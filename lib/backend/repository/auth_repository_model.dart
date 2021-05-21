abstract class AuthRepoModel {
  dynamic login(var model);
  dynamic register(var model);
  dynamic logOut();
  dynamic checkCurrentUser();
  dynamic updatePassword(var model);
}
