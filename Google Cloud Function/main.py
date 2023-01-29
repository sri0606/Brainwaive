import openai
from flask import jsonify
from flask import Flask, request


def gptinput(request):
 # Get the "question" field from the request body
    question = request.json.get('question')

    # Get the "howManyQuestions" field from the request body
    num = int(request.json.get('howManyQuestions'))

    # Get the "isQuestion" field from the request body
    is_question = bool(request.json.get('isQuestion'))


    openai.api_key = "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"
    if is_question:
      quest= "create '"+str(num)+ "' questions related to '"+question+"' with 4 options and print answer as ('ANSWER') and seperate each question with '/////'"
    else:
      quest = "create"+ str(num)+" numerical and conceptual questions related to "+ question+ " with solutions and seperate each question with '/////'"
    # Generate text using GPT-3
    output_lis = []
    ans = []
    while(len(ans)< num):
      response = openai.Completion.create(
          engine="text-davinci-002",
          prompt= quest,
          max_tokens=2048,
          n=1,
          stop=None,
          temperature=0.5
          )
          # Extract the generated text
      
      generated_text = response["choices"][0]["text"]
      ans += generated_text.split("/////")

    if not is_question:
      return jsonify(ans)
    else:
      ans_key = "ANSWER"
      for i in ans:
        q = i.split('?')
        options= q[1][0:q[1].find(ans_key)]
        answer = q[1][q[1].find(ans_key)+8:]
        answer = answer.strip()
        
        option_lis = options.split('\n')
        option_lis.append(answer)
        
        ques = q[0].strip()
        option_lis = [s for s in option_lis if (s!='' or s!="")]
        option_lis1 = [s for s in option_lis if (s!="\n" )]

        output_lis.append({ques:option_lis1})
        data = output_lis[0:num]
      return jsonify(data)
      