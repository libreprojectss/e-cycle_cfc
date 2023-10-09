from .serializers import SignupSerializer,LoginSerializer
from rest_framework.views import APIView
from account.renderers import UserRenderer
#View for signup
class UserCreateView(APIView):
    # renderer_classes=[UserRenderer] #Renderer class to render the response format
    def post(self,request):
        serializeddata=SignupSerializer(data=request.data)
        if serializeddata.is_valid(raise_exception=True):
            data=serializeddata.save()
            return Response({"success":"Account created sucessfully.Email has been sent to your mail box for validation."},status=status.HTTP_200_OK)


#View for login
class LoginView(APIView):
    renderer_classes=[UserRenderer]
    def post(self, request):
        serializer = LoginSerializer(data=request.data)
        if serializer.is_valid(raise_exception=True):
            token = serializer.validated_data['token']
            if serializer.validated_data["is_verified"]:
                user=AccountSerializer(serializer.validated_data["user"]).data
                

                return Response({'token': token,
                                 'success': "Login successful",
                                  'user':user},
                                  status=status.HTTP_200_OK)
            else:
                send_email_verification_token(request.data["email"])
                return Response({'error':'User is not verified'},status=status.HTTP_403_FORBIDDEN)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)