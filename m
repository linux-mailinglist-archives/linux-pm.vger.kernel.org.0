Return-Path: <linux-pm+bounces-37294-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8047AC2B950
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 13:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8C73B5939
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 12:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7E2309DCC;
	Mon,  3 Nov 2025 12:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OUzK5wEF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UNAx7P27"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493B63093CF
	for <linux-pm@vger.kernel.org>; Mon,  3 Nov 2025 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762172067; cv=none; b=XmTyR+AfLXaU+66AFldbR9eJllwhE25VrwoANfIdqoSx6/b7QRtW4JrcPHAjtZK2bBIgHkpoRXxjrsphzhcr9h+DCv+xCsX3CNNFtz1Z3TkLJpPTn9+5TX+dGtEzB9oka4TPbRYsqseDimO10o7uboqz2UNw/oR+SNaVMREudVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762172067; c=relaxed/simple;
	bh=JTYZcKugNZOA0vYR2o3dVvUjZjHQpyWvNa4nAUsB1/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o950sRT7ioffhGUwyRiSh0u5mjQx/Rflo3F6im+y3TnSSykXcLI/dJ1mTi6hkNEQkBg7HE1ecFubaB56AtoNwiJmrElGfuob5NMXjOJ1oKEz1OCpO1Lp81WLwrgWgFgWHti134KQVIaA7TkpCZzh6jEq4FO36Uh6q03ksX9F+Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OUzK5wEF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UNAx7P27; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A386Hbn694026
	for <linux-pm@vger.kernel.org>; Mon, 3 Nov 2025 12:14:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6PPtwZvy+gqvwwYYjdp01cD8qHwlSUjev3sm8V5A7n8=; b=OUzK5wEFC9V0CHDj
	GQ43SzIWe1qeGLVQY1cULEJLKVNG0kDOlmmNJ18aN7Jh1VKQFeWE0iBawNDgzRUx
	5OH8EQEKRP+LE3BFKvwnlUHHXB2ySN/OQblyq4oUHHCOrU7PNDJunlAWBN+YGOoY
	jJM/nEhg3WZEhd0dQkaEYj+rZVD9oy1tWqIsnTJI/x3K3UYTo47za0JAPamLkPeW
	+vcz12BHIqe+vyrzAxRPtvBk6XJaxKJM9ESxX/G/QMfT3EPrJ7YPCAvEwGYSg590
	KnC8hHSzVjq4OhpvUHLsC9tB8X9pXAIffG+/kXv7oWZPQXyseiwP6bWfYRWerTg/
	kdkz2w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5ak8mjnk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2025 12:14:25 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-883618130f5so176149685a.1
        for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2025 04:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762172064; x=1762776864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6PPtwZvy+gqvwwYYjdp01cD8qHwlSUjev3sm8V5A7n8=;
        b=UNAx7P27BAiYPYoUMw1t1o//wNODLItHFD3I3YJ1N+I16WRTusSztY8NG6+WgTT01a
         5VXDffrNTz9IDmZiUipzBRBTMapqZXnCkGXq1aQW7KrqyfkhKQIoCwPf5Zkx5m2Qs8BH
         G5sN4+W9ok9UyDoPX4wktKIMJMjHpH3FPe0UdvDNqNTY12fCKzzbuFEzlY0hdwc5DgwX
         aOl9VYPaFkXvTGmWMvSM8T+ZSHIL9kfInFwiDWashP+KljOBAp7qBZ2K2LQMNNSSI708
         bhpDJS+8JqitBgf2EvlKbL5L2dvX7Zcfoh3+BCI5RmWI1EPfpGfb46kmdxJYuOncqOxe
         FnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762172064; x=1762776864;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6PPtwZvy+gqvwwYYjdp01cD8qHwlSUjev3sm8V5A7n8=;
        b=ADqurYbTft1jhxfzwQXjNKheL66CKw7NIPWK4fyp/eCQsDk4LvQWVWbsq7NlD3sAjA
         kWMrbTuFMmkilwe3TACcrD0gaVbZ9hYWZT1C0OzBXJMlOddsbJgN01Y1DBrWterPX2aA
         Zb+uQbbEV1sOW2W8L2kW5GSc2isf9m79vZn6ilx/eAVjFgAnw2KfzOCYZOMh9h6sP/Oj
         A9HfKALCfqqie7IWmEMmplVMiT/P31swa6JHOJF7n2V6Pa/Yw1WrAsbbh+1pNWXayjN1
         Ad5JyonhiennNozz9I3Iu8Z4ZIGkz9CSIma4toolRATCZYe36d41qqMWOkpEeKz4YsmV
         hCSg==
X-Forwarded-Encrypted: i=1; AJvYcCXekryHsLRLDMM3AWymuJ7myDhGDzC4mX4Pi9lfjNjcRwQ0Iy9FPuh0W4HSCFsPMIWRBkKcWJvzQg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9BshiftLd+XAX4kow0Dk4Q3cYZZasMSfolUdxW4641bOqslB5
	IHYIli2hZN0lKsSwjE3GErVCKsBVj6ozvOHKl4gIxhfcAztrQj4zgsK7NsN7zDnvuIdNhv1u9YS
	6EtbJAKX7uNAFphAT9wLzPniS1JLrTFvPUhbYC1SXOLzjgJeJpmnTqb0UT5AqSQ==
X-Gm-Gg: ASbGncunOGwlhzl6H8xsCz+3yOdSONiIqwthElbWVHMNekQeXCNght8eN5PnOQoD1H/
	T2RWql/hWw7Hu4Vw8mR9wCyQpLjp58qMgK1+Kmx8deIJsHWOCzd8biOe0YvRWhDynkmYXgz6//3
	8Fk2+Vi38YRkE9QGE36tTha5bIIMGPVTp6SfNm7ak3MzO02cc0PF2NR/Am0tZ77EsBysjyyR6VC
	UimKS9mfPvxdRlragev+kELOlHQjqxnpPyv73c7eRXGhinfq+sSgebLKUEfcaSlhIho2AtekX97
	+1dPKfQ/ILZVm8xOMjefVsXyAxvVlhDOM1kaX8bXzC4XojIW+Ix1dhkFh9aQPLpltF/+zeZF4QO
	61SbzmuV89alCGyKgJkWZD2VNvSHKzE5vSSGGZ6zQE6q37e0R+9ihA7+D
X-Received: by 2002:a05:622a:14c:b0:4ec:f7e4:8a0e with SMTP id d75a77b69052e-4ed30f84d8bmr115447961cf.9.1762172064482;
        Mon, 03 Nov 2025 04:14:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFojfDNx4zUtTBFnI84zhhJWl5ScbUrZr2SjZmrkUFo9wwBQljbRwY0JohB1/KDEp4gMP6DxQ==
X-Received: by 2002:a05:622a:14c:b0:4ec:f7e4:8a0e with SMTP id d75a77b69052e-4ed30f84d8bmr115447551cf.9.1762172063877;
        Mon, 03 Nov 2025 04:14:23 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f5bc248sm2843451e87.91.2025.11.03.04.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 04:14:23 -0800 (PST)
Message-ID: <c93afd94-9d94-42fb-a312-df6e26bb2bc8@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 13:14:18 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] Various dt-bindings for Milos and The Fairphone
 (Gen. 6) addition
To: Luca Weiss <luca.weiss@fairphone.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org
References: <20250905-sm7635-fp6-initial-v3-0-0117c2eff1b7@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250905-sm7635-fp6-initial-v3-0-0117c2eff1b7@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: pklwf9DPDkK99tlv95eiqY4w3RHiky5v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDExMSBTYWx0ZWRfX/dHC/kERgjxL
 DGyseFMteDQJVteAvEo1Ibp88lMcAvNy01t2iVnNjJLvYCpoxFEX6TTNmMIaUcqIYtN6Rlmll/7
 m8roNRpSXw7mQIAxykSrvKfVBb2OTQfSrwfIePlWhwSUMPAmEon/OdQGjzASPtJqGQVpMgsakR7
 gCmWMDJruyrGr43pTY6OArin2ZT74rw8HIE6uY5xqeB+ASZbPmY41iJcZIYJpMk2UNi5F3hAbnQ
 EekgrGCJOAvW+TXz4yTeEZ3dTKW94CdRip5qaqB+iCXhWEFqxJk36kRI8zN5fXgQQhtxC83glkX
 CgRSTpR4xI/hGmVCo7+e74zrG1RPgV1qwDHzJHPrgaRVfVmdXU+c6jjFsSLCcOvmeHKxE+L3vvy
 ATsnCQxsruw6BWO1RvfXkb+PhqvifQ==
X-Authority-Analysis: v=2.4 cv=ZZEQ98VA c=1 sm=1 tr=0 ts=69089ca1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=6H0WHjuAAAAA:8 a=PtzdWR5wS_Xl21Jse7IA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: pklwf9DPDkK99tlv95eiqY4w3RHiky5v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-11-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 bulkscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030111

On 9/5/25 12:40 PM, Luca Weiss wrote:
> Document various bits of the Milos SoC in the dt-bindings, which don't
> really need any other changes.
> 
> Then we can add the dtsi for the Milos SoC and finally add a dts for
> the newly announced The Fairphone (Gen. 6) smartphone.
> 
> Dependencies:
> * The dt-bindings should not have any dependencies on any other patches.
> * The qcom dts bits depend on most other Milos patchsets I have sent in
>   conjuction with this one. The exact ones are specified in the b4 deps.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

FWIW this looks good.. where are we with regards to the dependencies?

Are we waiting for anything else than the PMIV0104 (as part of glymur/
kaanapali)?

Konrad

