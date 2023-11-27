Return-Path: <linux-pm+bounces-279-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 694F27FA466
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 16:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA99DB2115E
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 15:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED646321AC;
	Mon, 27 Nov 2023 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xjc/fUdZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E108CC
	for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 07:27:40 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a00b01955acso626664766b.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 07:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701098858; x=1701703658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B2V4E8aAgyIZKhmfsBfyBlErfRpqAl2TcTNM0rL2LSc=;
        b=xjc/fUdZozlciAnPWUf7xt7CxlnxqON/25RePPnm7tERwGc4Eo4WLDu+XJPzVSE37V
         rTOv/el9gSk1Wbiljuz9hqHl3fkiNUM4mniBfd6TaLJfzWTANUf4aFXz+M4wRa/N1B2Q
         VLLeVTbmAOz5HjKor52RhTFCXwiHQajjeSYGM8fhOnk+rkMHWh4d+a/1JCjrYFTLBQa6
         I+Sa5s1OdE+pxeFPkyj4djongCOibYsqVvdSsf3AV+/9YxvfS1yyo2MfHULai/qBXDXF
         k6nWkKhG/lB4Cvg68oilujNHvdjaDaMMhoTiBXE1G1+ZTFZKdBG9YCOm2LxrngJEIj2P
         KAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701098858; x=1701703658;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B2V4E8aAgyIZKhmfsBfyBlErfRpqAl2TcTNM0rL2LSc=;
        b=JVe/RC+kaxoYjcQQdbwSZHghPA4s6Ccf6oyeHjGU0Zare/SA3VlxUSxcNheBHxaMPD
         RO4xXhjb6Y7NaJ7yDQrirjB23nOCD8VtP7oPqGNp1kp46MpvLyhB971oiuX18AC7rFiZ
         4NtVE4x9eVqwniOKQFMSLa213HjeglPcZwEd/xcfDa9tmbjwPGvYHM2THtIuV56KgALl
         Og8eF7+xzQxnj/R5fvnpLdjy/gUwZTpjcUylLZIf8cYdxeUBmSiq7WVZSaTr4yb4MDg7
         be6tm6PoyPtNqmONLxqJF42bail90w9JLGf4CmNOCXRp8pGji446KWIv340M7+qqeRJJ
         IopQ==
X-Gm-Message-State: AOJu0YzPcqjajSm8B5HBuE8GuZjTKQPNF+pk/AZz+qKQyYTl7G9dmaOD
	bUIF9ne3b4o8/ZmfIAQW7sjadw==
X-Google-Smtp-Source: AGHT+IG92xB1cQKlhDFcO+etwXYhfIzWcPajJXuVu+G9ThrvaiYtFDJdXN/+rRvkfhYvar9YctrdMA==
X-Received: by 2002:a17:906:29d4:b0:9fa:caf3:fb17 with SMTP id y20-20020a17090629d400b009facaf3fb17mr9063129eje.51.1701098858496;
        Mon, 27 Nov 2023 07:27:38 -0800 (PST)
Received: from [192.168.201.100] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id cw18-20020a170906c79200b009bf7a4d591csm5923226ejb.11.2023.11.27.07.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 07:27:38 -0800 (PST)
Message-ID: <a430cbe6-beb2-43b0-a436-b9c266934b04@linaro.org>
Date: Mon, 27 Nov 2023 16:27:35 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: interconnect: Add Qualcomm SM6115 NoC
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Georgi Djakov <djakov@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 Konrad Dybcio <konradybcio@kernel.org>
References: <20231125-topic-6115icc-v2-0-69d05d90871b@linaro.org>
 <20231125-topic-6115icc-v2-1-69d05d90871b@linaro.org>
 <769bf4e4-0db7-4fc4-9640-3797a729e404@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <769bf4e4-0db7-4fc4-9640-3797a729e404@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27.11.2023 13:27, Krzysztof Kozlowski wrote:
> On 27/11/2023 12:10, Konrad Dybcio wrote:
>> Add bindings for Qualcomm SM6115 Network-On-Chip interconnect.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
> ...
> 
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,sm6115-bimc
>> +      - qcom,sm6115-cnoc
>> +      - qcom,sm6115-snoc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    minItems: 1
>> +    maxItems: 4
> 
> clock-names as well here. All of such arrays go together.
Gah, forgot about this one. Will fix.

Konrad

