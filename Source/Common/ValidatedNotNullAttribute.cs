using System.Diagnostics;

namespace FToolkit.Analyzers;

/// <summary>
/// メソッドパラメーターがnullではないことを検証済みとマークします。
/// </summary>
[Conditional("VALIDATED_NOT_NULL_KEEP_ATTRIBUTES")]
[AttributeUsage(AttributeTargets.Parameter, AllowMultiple = false, Inherited = false)]
sealed class ValidatedNotNullAttribute : Attribute;
