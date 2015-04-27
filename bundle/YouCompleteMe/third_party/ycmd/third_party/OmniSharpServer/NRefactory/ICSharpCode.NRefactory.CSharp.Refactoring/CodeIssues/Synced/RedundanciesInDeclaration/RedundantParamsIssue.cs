//
// RedundantParamsIssue.cs
//
// Author:
//       Mike Krüger <mkrueger@xamarin.com>
//
// Copyright (c) 2013 Xamarin Inc. (http://xamarin.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
using ICSharpCode.NRefactory.Semantics;
using ICSharpCode.NRefactory.TypeSystem;
using ICSharpCode.NRefactory.Refactoring;
using System.Linq;

namespace ICSharpCode.NRefactory.CSharp.Refactoring
{
	[IssueDescription("'params' is ignored on overrides",
	                  Description = "'params' is ignored on overrides",
	                  Category = IssueCategories.RedundanciesInDeclarations,
	                  Severity = Severity.Warning,
	                  AnalysisDisableKeyword = "RedundantParams")]
	public class RedundantParamsIssue : GatherVisitorCodeIssueProvider
	{
		protected override IGatherVisitor CreateVisitor(BaseRefactoringContext context)
		{
			return new GatherVisitor(context);
		}

		class GatherVisitor : GatherVisitorBase<RedundantParamsIssue>
		{
			public GatherVisitor(BaseRefactoringContext context) : base (context)
			{
			}

			public override void VisitMethodDeclaration(MethodDeclaration methodDeclaration)
			{
				if (!methodDeclaration.HasModifier(Modifiers.Override))
					return;
				var lastParam = methodDeclaration.Parameters.LastOrDefault();
				if (lastParam == null || lastParam.ParameterModifier != ParameterModifier.Params)
					return;
				var type = lastParam.Type as ComposedType;
				if (type == null || !type.ArraySpecifiers.Any())
					return;
				var rr = ctx.Resolve(methodDeclaration) as MemberResolveResult;
				if (rr == null)
					return;
				var baseMember = InheritanceHelper.GetBaseMember(rr.Member) as IMethod;
				if (baseMember == null || baseMember.Parameters.Count == 0 || baseMember.Parameters.Last().IsParams)
					return;
				AddIssue(new CodeIssue(
					lastParam.GetChildByRole(ParameterDeclaration.ParamsModifierRole),
					ctx.TranslateString("'params' is always ignored in overrides"),
					ctx.TranslateString("Remove 'params' modifier"),
					script => {
						var p = (ParameterDeclaration)lastParam.Clone();
						p.ParameterModifier = ParameterModifier.None;
						script.Replace(lastParam, p);
					}
				) { IssueMarker = IssueMarker.GrayOut });
			}

			public override void VisitBlockStatement(BlockStatement blockStatement)
			{
				// SKIP
			}
		}
	}
}

