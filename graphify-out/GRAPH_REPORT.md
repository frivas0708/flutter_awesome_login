# Graph Report - awesome_login  (2026-10-15)

## Corpus Check
- cluster-only mode — file stats not available

## Summary
- 201 nodes · 234 edges · 11 communities (10 shown, 1 thin omitted)
- Extraction: 100% EXTRACTED · 0% INFERRED · 0% AMBIGUOUS
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `28eb0f38`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- awesome_login_card.dart
- main.dart
- awesome_login_config.dart
- login_form.dart
- forgot_password_form.dart
- register_form.dart
- change_password_form.dart
- two_factor_form.dart
- social_buttons.dart
- login_result.dart
- awesome_login.dart

## God Nodes (most connected - your core abstractions)
1. `_AwesomeLoginCardState` - 4 edges
2. `AwesomeLoginConfig` - 3 edges
3. `AwesomeLoginCard` - 3 edges
4. `ForgotPasswordForm` - 3 edges
5. `_ForgotPasswordFormState` - 3 edges
6. `LoginForm` - 3 edges
7. `_LoginFormState` - 3 edges
8. `RegisterForm` - 3 edges
9. `_RegisterFormState` - 3 edges
10. `ChangePasswordForm` - 3 edges

## Surprising Connections (you probably didn't know these)
- `_ChangePasswordFormState` --inherits--> `State`  [EXTRACTED]
  lib/src/widgets/change_password_form.dart → None  _Bridges community 4 → community 6_
- `_RegisterFormState` --inherits--> `State`  [EXTRACTED]
  lib/src/widgets/register_form.dart → None  _Bridges community 4 → community 5_
- `_TwoFactorFormState` --inherits--> `State`  [EXTRACTED]
  lib/src/widgets/two_factor_form.dart → None  _Bridges community 4 → community 7_

## Import Cycles
- None detected.

## Communities (11 total, 1 thin omitted)

### Community 0 - "awesome_login_card.dart"
Cohesion: 0.07
Nodes (17): AwesomeLoginConfig, build, _buildLoginContent, config, _anim, build, _buildAnimatedCard, _buildSide (+9 more)

### Community 1 - "main.dart"
Cohesion: 0.08
Nodes (23): appleSignIn, biometricHandler, build, DemoApp, DemoPage, googleSignIn, main, onChangePassword (+15 more)

### Community 2 - "awesome_login_config.dart"
Cohesion: 0.07
Nodes (26): accentColor, apiUrl, backgroundColor, biometricButtonText, cardColor, cardElevation, cardShadowColor, changePasswordButtonText (+18 more)

### Community 3 - "login_form.dart"
Cohesion: 0.07
Nodes (25): build, createState, dispose, _doBiometric, _email, enableApple, enableBiometrics, enableGoogle (+17 more)

### Community 4 - "forgot_password_form.dart"
Cohesion: 0.12
Nodes (14): AwesomeLoginCard, _AwesomeLoginCardState, build, createState, dispose, _email, ForgotPasswordForm, _ForgotPasswordFormState (+6 more)

### Community 5 - "register_form.dart"
Cohesion: 0.15
Nodes (12): build, createState, dispose, _email, _formKey, _loading, _name, onSwitchLogin (+4 more)

### Community 6 - "change_password_form.dart"
Cohesion: 0.15
Nodes (13): build, buttonText, ChangePasswordForm, _ChangePasswordFormState, createState, dispose, _formKey, _loading (+5 more)

### Community 7 - "two_factor_form.dart"
Cohesion: 0.17
Nodes (12): build, buttonText, _codeController, createState, dispose, _formKey, _loading, onCancel (+4 more)

### Community 8 - "social_buttons.dart"
Cohesion: 0.20
Nodes (5): build, onSocialResult, showApple, showGoogle, SocialResult

### Community 9 - "login_result.dart"
Cohesion: 0.29
Nodes (5): errorMessage, LoginResult, requires2FA, requiresPasswordChange, success

## Knowledge Gaps
- **133 isolated node(s):** `build`, `_buildLoginContent`, `config`, `_anim`, `build` (+128 more)
  These have ≤1 connection - possible missing edges. (Counts symbols only; 158 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **1 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `AwesomeLoginConfig` connect `awesome_login_card.dart` to `awesome_login_config.dart`?**
  _High betweenness centrality (0.028) - this node is a cross-community bridge._
- **What connects `build`, `_buildLoginContent`, `config` to the rest of the system?**
  _133 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `awesome_login_card.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.06896551724137931 - nodes in this community are weakly interconnected._
- **Why does `_AwesomeLoginCardState` connect `forgot_password_form.dart` to `awesome_login_card.dart`?**
  _High betweenness centrality (0.014) - this node is a cross-community bridge._
- **Should `main.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.07586206896551724 - nodes in this community are weakly interconnected._
- **Why does `_LoginFormState` connect `forgot_password_form.dart` to `login_form.dart`?**
  _High betweenness centrality (0.005) - this node is a cross-community bridge._
- **Should `awesome_login_config.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.06896551724137931 - nodes in this community are weakly interconnected._