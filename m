Return-Path: <linux-pm+bounces-37500-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3786C39C5B
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 10:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B12118C6447
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 09:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A539D30C36D;
	Thu,  6 Nov 2025 09:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cDNgVcAp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WNyppZ41"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03A9304BA2
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762420530; cv=none; b=LgmqzaXKnZrhePplVfNtwsEA2UG08l3o3cIIEgx7zkeALfjrkHNobNianE6srbUHekIDrGY+3cTmKS+50GDjE5NsBXNSFPu8ncid/8tTlKDMQaRdXq0rBKxdH1G9J54QaRuh653i2E8/2+73rslXfMOPsnDUuvort1YJvepEUP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762420530; c=relaxed/simple;
	bh=IqDU06J8KRhHUMTkW8BrYVFpwrOQjixDrvjAH5rTJAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSnKA3+z/A0kKh8cDQL4iZvvE9L/LwNNFMycDvikPP2HktwHW26AzxY44AyiANy8EqUnmlOaVaN/3FdsmW7ayxl1kOLDgzEHNEvLvWfnNjp7376PXBd9+d3i9Xt/jR7PWmsm5ieNWPqZ/ZQ99Gq4/tI3mXH3d/XrJCLX4XwSUHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cDNgVcAp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WNyppZ41; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A66t1bR3155522
	for <linux-pm@vger.kernel.org>; Thu, 6 Nov 2025 09:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fSBcZQ0RQcmst4/RrknYi9gdsm4mdIdNyFnHTvoBzKs=; b=cDNgVcApKbRwtG7v
	L5rHIcBYbNNuzNB8KDmIvCcdBIvVgdJM9C19bJ4ettuFGcrKpRk4XFZ8Biy6xQ/J
	h0Qlfn87zo/YE3YTQyJpp1VRw/SuQKs2tCerqQhQSMha/BOn5RsomcgOe1I1YG8M
	s/LaKbPVyi3eig/hC5TPmyYXnqcIk6FMtGp5czn7EYUHBNsVSwrPU2jE+VPJsYvW
	d9q43herYiIKYu/IoMaHdzWUOmA5UnToWOgp9qJ8gul3ZAjsfz2bmHUZIgJ2y9zK
	5XqYbkFUx7Tz5ac5CiD6DCtUtKVVFP5ljPBECo7kULDBQO8gAPuO5ZdBGktzpwfO
	uDXRkg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8pu0gd1b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 06 Nov 2025 09:15:27 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3418ad76023so690774a91.0
        for <linux-pm@vger.kernel.org>; Thu, 06 Nov 2025 01:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762420527; x=1763025327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fSBcZQ0RQcmst4/RrknYi9gdsm4mdIdNyFnHTvoBzKs=;
        b=WNyppZ41ePsCf26j0StWs/LI5b+bzeO+VIJ6njMdszO/66mchsnyGTcq09zxHL0SNM
         hyCkTgIN7vK6jiv13cfzAmsQAFt9w2d0lVm+egqUueikUElQJK/nINmwwYtbgyLGzzJm
         IjQCm0//b6iFEYQvfcCaBqL4uZ1F9gilGCQnxDfCd9/iuKhMF7zZsfZtRSn4IbnbZUuq
         OANPsu0HKfR+xacY68McIH0eFJpvv575NFg9AZBw6aIQ0KrPPp9abpyhVtKRCiJiqhQP
         eKlUCkUedeUTnCeIQYO50tIzZt/h+aOvbgGOLlLHMwW2XtoNH/EYlWvKQLaS3TsgUZ2s
         06Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762420527; x=1763025327;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fSBcZQ0RQcmst4/RrknYi9gdsm4mdIdNyFnHTvoBzKs=;
        b=wFNU06nZ2gR7EJZ/raokZ7Iz9lV/B6+/pNphwTsOWdAybSgul724qwewq5iOEZ/p4o
         +gd3LP/cydBCGoE+pkx3SI2hWvhP59u3dn4Pbf0GsqkgUBm+c1evXu+2TKetxu2G0RQJ
         slLnW30lyOLDK9A0Oxzfk+m0+DcSIxrIgeWoELFcEwS25sjDXTZfTkXWH+1nySbGt379
         4GtGs2JqtEWhYMMpqjNcuFw7EkZYsiFwPoTJ3xPqcmY8R+QN2u0u85+7VKo3vF1CdIYp
         J2Q6UGJmYojiq9EOXp/LXFPZ4LtwO5BKBU1f/MyTF+Jz8XzJXXpD5mURt8EenyBH1Uih
         RkYw==
X-Forwarded-Encrypted: i=1; AJvYcCWF6uHyEX0/NmxJZsrg80ob28IabenRbapmmd600HhPM+uCEX/u08yKm/YFF7Z98F42ABmsiEuHRA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwyeyJumToi5M12VTyBTvdWZLJtKxoUbD2dspFYOXmAU55up4k
	kLHzZfsaIccocl5Dbcv5bBtHysIc86tfV8TPToUOzBTowWIXJk6w8UA1yHWMo5840pmDv3KiUO6
	abqTPTlUkv+QBYxMuDC0Ff2vrVKgvoFzHWpYR3pYqwL6DdqovnDVCPIpCeVMIAw==
X-Gm-Gg: ASbGnculHJ1aLBIsQ4RAolbP8Q+FzKohQGbyXFkfB5syO7zR6azKgVx0Ad1gkjlnV0k
	3FY+xmgJjV95/Ty5HZyf7mb7arashq2OjrMeYHmuOqMRQmnURzfWwi5M6A4deXNNk67QLwfaM+/
	/2wyPQjzRZ7Lk+uyYY+e+Gxvxx9u2n9+JBMQ476/3iQ7ZaCiVqfPwC90l0ds12HdFOU8RPIPPk3
	bhonwkTjxzmDaz32MsIYMoUw7CR/QpArq6udZD9YrkOIWqlsTkDlKL0kj6PRugUK21FG85/h/2E
	Cahd7evcAKDQ6g7+2pmxzNnTZQOHakKVY3Rp3ZsblgH9u1+G7/cOak0wKpFFcmqTiKcjwOzVO2B
	G9GMRtPXW+FDjeRZ89PzyMMLSKg==
X-Received: by 2002:a17:90b:2888:b0:33e:30b2:d20 with SMTP id 98e67ed59e1d1-341a70082demr8272616a91.33.1762420526755;
        Thu, 06 Nov 2025 01:15:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHun9YYghwsNEVAON0drNEeOBr3tdiHVJCshN/1Daostzc8S6e6a1xDbSuel5MNU+po1yNqkw==
X-Received: by 2002:a17:90b:2888:b0:33e:30b2:d20 with SMTP id 98e67ed59e1d1-341a70082demr8272554a91.33.1762420526210;
        Thu, 06 Nov 2025 01:15:26 -0800 (PST)
Received: from [10.218.33.29] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d08afb02sm1083005a91.0.2025.11.06.01.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 01:15:25 -0800 (PST)
Message-ID: <25e8453b-91fb-49f2-a61b-fd7b3267e558@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 14:44:58 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sc8280xp: Add missing VDD_MXC links
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Ulf Hansson
 <ulf.hansson@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>
References: <20251104-topic-8280_mxc-v1-0-df545af0ef94@oss.qualcomm.com>
 <20251104-topic-8280_mxc-v1-5-df545af0ef94@oss.qualcomm.com>
 <1e464f5d-f4ed-4ee5-b966-fc7de586340a@oss.qualcomm.com>
 <7f7179b7-73a0-40f3-b921-888b3e21537c@oss.qualcomm.com>
Content-Language: en-US
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
In-Reply-To: <7f7179b7-73a0-40f3-b921-888b3e21537c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA3NCBTYWx0ZWRfX9ZEsyp9Cvraz
 SDcBXb4CncGR/GrBVZeKDE/vMGOTYqd/7eYcoWrnfaYAB4uG1Eok9NH8OQaNLrYwRrd4sf7tBJI
 kfApl10++VxaplWNISe0gZmz0FAo5abDf28ZMxN5AMjAHaLNObaoDaixq1abfeztD0x3weeJTy4
 PosxDH7m2cvqaYkpfRMj+BEy/67SXus4zJPVUrj6vZBJtRF0EXBlcWAQ7jVzYGh1ebk4Rsm/VFY
 ircF3XSUB4ppPtGzRtSJGMNAuDvYe+mFsJFfiKXHdK0zzVGFKsXuZoaL4+DMogrriSaHWg+j3RF
 PUhapDS2GhHXXyZf3QMVWzDM1cYvpvSVdk2/fhKvhWY32q6lBWcXZbsZMmranq8g32Gq1w5ELmS
 J2yd7Sd4B1sz+htKHZyut5mie78sGg==
X-Authority-Analysis: v=2.4 cv=bIYb4f+Z c=1 sm=1 tr=0 ts=690c672f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=IzPYbt_51FXaukp9Qk0A:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: aq3NjOL1zO22KEe9l7W2ZwxAV9S9gVp8
X-Proofpoint-GUID: aq3NjOL1zO22KEe9l7W2ZwxAV9S9gVp8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060074



On 11/5/2025 4:32 PM, Konrad Dybcio wrote:
> On 11/5/25 10:21 AM, Imran Shaik wrote:
>>
>>
>> On 11/5/2025 1:01 AM, Konrad Dybcio wrote:
>>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>
>>> To make sure that power rail is voted for, wire it up to its consumers.
>>>
>>> Fixes: 9bd07f2c558f ("arm64: dts: qcom: sc8280xp: Add in CAMCC for sc8280xp")
>>> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 22 ++++++++++++++++------
>>>  1 file changed, 16 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>> index 5334adebf278..643a61cc91b4 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>> @@ -4586,8 +4586,10 @@ camcc: clock-controller@ad00000 {
>>>  				 <&rpmhcc RPMH_CXO_CLK>,
>>>  				 <&rpmhcc RPMH_CXO_CLK_A>,
>>>  				 <&sleep_clk>;
>>> -			power-domains = <&rpmhpd SC8280XP_MMCX>;
>>> -			required-opps = <&rpmhpd_opp_low_svs>;
>>> +			power-domains = <&rpmhpd SC8280XP_MMCX>,
>>> +					<&rpmhpd SC8280XP_MXC>;
>>
>> I see that none of the CAMCC PLLs/clocks are on MXC rail on SC8280XP target.
>> So, MXC support is not required for CAMCC.
> 
> Hm, to the extent that camss is supported upstream, I could indeed
> boot without pd_ignore_unused and the camera actually kept working..
> 
> I see in docs that there are links between MXC and various IPs within
> camera so I'm a little confused. Would you know more?
> 

Not sure on the rail requirements from the camera core side, but from the
camera clock controller side, we don't need the MXC support.

Thanks,
Imran

> 
> I wasn't able to test venus because it locks up either way..
> 
> Konrad


