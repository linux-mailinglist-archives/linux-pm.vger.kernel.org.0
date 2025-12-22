Return-Path: <linux-pm+bounces-39783-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB43DCD6BA5
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 17:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBAC6304B703
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 16:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBD9350298;
	Mon, 22 Dec 2025 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lye7C4yi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BUvrZjuf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFCF34FF7E
	for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766422633; cv=none; b=nENnfGApPSV2XaL25nM69VFIkAEIUXLHtJkD0Hk9LIbvUwktcyfLwAOmHTdkbWeU40k85pH8cvh1w9oyBnKEmk2jEJv55r4kRksyh+jIiUW/Y/jyRBjH5Gt9eZ70YC2hwsCl1waspFoFxCM2JXZPWX4QRcdfWVFxMzH1X0woLRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766422633; c=relaxed/simple;
	bh=xV6tWgjxZaXKfkrPw5l/uzOAaZsuSpJiThtogYYnDTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=momKsHIy8kzNJN8FxRGdXptGuni7EWOIvXNJmEr+hEZI8JztgmuKUBdQYZ7U7c5iKmTxVWvt7kLvFr7aWUd49z9GMIgNfg/EN2+Sw8w1dKrHAnPVfmr8HTj9NNaroz8qHYpm89VxZ8MI1NDHcNmIqGjRJ1U1CaMWC3rCTSAi7kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lye7C4yi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BUvrZjuf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BMEC3ul1889233
	for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 16:57:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4itgOftOBi39v3+Y6wa7zx7cM8P0meLsOdf8/g/via4=; b=lye7C4yiuqPLel88
	HPjm+8uaBtuxa3yyOHwh+GY3XIatjzgnZCsGY2fsw1lPxqqMMamgVc0ktvkg/0nU
	05DH+C2j7hcGr4pOk30N4qYefy/mBWQnnKLwTWqOBKGZ+imEAVCe1Ozjp6jeiqkn
	i39hcH2pVNn0JxF+ITsmzv+FRazzD4vydZEfLWRzTdEgfTV+tSB9y8JPK8BdM1FE
	d+yG5AVxDufijhKCnBvKHHt8jIkUcB+3ICYyGQtwc0khA3zHQvPZ5+6mjy/HsHi2
	5+ZUuvM9Dxu0ys9sZ3OIOeAgngMdiEVYvcgiXLwOWSmBhMr1oi++5T5Vm/KyTQ1a
	JwEnkA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b770aghc4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 16:57:09 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0bb1192cbso82601465ad.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 08:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766422629; x=1767027429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4itgOftOBi39v3+Y6wa7zx7cM8P0meLsOdf8/g/via4=;
        b=BUvrZjufjNZiV46lq+7neHqdgxSSJiH7IMrC7M3zQGKRoT3/ZQBFuP6GAVG8RN/RDc
         shgGHcNdcb/Jsmj0oPuoK84lja9v/vivhWzkcJDg/+d/WObcdOVncvj45aGuLyqEvRJQ
         NH17xh0CsHFSrMZJpPKNqzFISLFRgHH8z17yljCsqs5kZ8Aj/v9RhMcGGkTetBj8J3Vy
         KhMLX49tCHLFTbKBxg1YdL0oNma1m6wxoBrtQS7WrPhU7DM+fBIhWlB4rldVwkt067pb
         ef98vDQb5yJuXdOe/gKYRFZSYn67aBvbzTIXYzEsxcsXTRu+Ko7NJxZcdlTyXkF3ucRc
         merw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766422629; x=1767027429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4itgOftOBi39v3+Y6wa7zx7cM8P0meLsOdf8/g/via4=;
        b=kqISh62j960zzvZHhky/lRCMi2iNWSE55y8PllOh9/fYScOBCZ/p6PGPmHpJHo+B6k
         LRAVLxsoj45LM4Yu41c1jBDnzSUf+lVSNzdHUhHoK0UznR1qBbum90i/qaRykEW25Nyc
         tSvQ0+fCVxgb6O4VN0cvTzO/MOROB9ByqVFgATlBsW5c2n52cUSlUDpcak6D4mQ5Kul0
         hiunGg03C/FVj9gnM7tfkqePDpdZRYpbg+ghot6Mid26fHUnNdDwma6L2u4TjkQtj+Ji
         fghKESn9YEv8rksDfZpvOEqjfiEcF2VNLDaJRg3HnqrEnK3mrQJRQTkbjPehZBd+UH/f
         YOHA==
X-Forwarded-Encrypted: i=1; AJvYcCUyGy03jc2bcZXGTnugaSvqATKJXcLsV/Jtuyv/EukNjdkFX0XH05uFMQQGMeSA918YHTp1RIkSvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMA9pfpdrY3PHdD7noS/bKbIS9LcHWryLnMBO/xsin+0fh2tS3
	i2zttUr1BCVnRAm1svfvqSYLpR5am1RxhnNe3kWrbLUUSqO7qRI8WxEXSAtGoJi0iCK8Xk9GhCp
	U1TL89E26+VBiWMQgK5EjvTCshCMJqCr7zaSkGPbDNHUljCWQ0XXbLYPLHyfVMA==
X-Gm-Gg: AY/fxX7uVmuMEqwEk15ltZrwvs5R1RDKgFE7vV+t8hs5Q/URz+rcXsKD9L71+ymxBU4
	H2I11zbkgI/HEwET2dwpGCsaHCDqXwzjM+0KnfT1VVO8MzhRFCCYg0V5PLMEp9tN6PmmtJsJlP4
	d+3F5m3SMjbgChVFp4/41TjkJQyIMYePbGw9AZFxQzHUepmPbGRuklqR3v+ltUfXcKZMKykyr6f
	wTVqjlsw2928dRifw9GAEgQWr52K9RNDpUsUpI3sS8bBc5jC7SrAwlwFdSXY2aEmQnyrO7oLl3R
	oIVkEi+Fr80/RKRDzpIs0tSqG1FOGnmroo6W5MczeTAnnQ7TcOUlxFvJB++AFWomNlaq8KXMDbq
	VSAxhrQRJlXl550DWmAFAZpgSgCokgNzzXwbt
X-Received: by 2002:a17:903:2448:b0:2a0:b7d3:1bf4 with SMTP id d9443c01a7336-2a2f2212833mr125103615ad.5.1766422628892;
        Mon, 22 Dec 2025 08:57:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDKazaiIoCtCLvy9WCpAv5NHiSa0bEoYQsJ/tn3nK095kVKTp+ibCk6SgPCiILA+nQ1SiDjw==
X-Received: by 2002:a17:903:2448:b0:2a0:b7d3:1bf4 with SMTP id d9443c01a7336-2a2f2212833mr125103405ad.5.1766422628416;
        Mon, 22 Dec 2025 08:57:08 -0800 (PST)
Received: from [192.168.1.5] ([27.57.93.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c9b51esm101496025ad.43.2025.12.22.08.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 08:57:08 -0800 (PST)
Message-ID: <698bb8b4-d6ae-4a97-8cc3-9e48ea8afd2e@oss.qualcomm.com>
Date: Mon, 22 Dec 2025 22:27:01 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: qcs8300: Add clocks for QoS
 configuration
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
References: <20251128150106.13849-1-odelu.kukatla@oss.qualcomm.com>
 <20251128150106.13849-4-odelu.kukatla@oss.qualcomm.com>
 <8b8d35d4-ee88-4d91-aef5-0e77f03f59b0@kernel.org>
Content-Language: en-US
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
In-Reply-To: <8b8d35d4-ee88-4d91-aef5-0e77f03f59b0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDE1NSBTYWx0ZWRfXzcSDXI0maMBr
 ajlt1rmqkrytDH+JAFmh5dxxS2PfZPEq8qrBcnjcAXUrEPzXTrHIzAgtjPJN1CFHkX9VvBlSlPt
 n6Py9yTuZ94g6+fGQV+zbz87E6AK3xJ9ByfE2GywikNs70vh1eXNfgcOoGzcuLmXdqs/icOSYvR
 pmINnmuQ6FUrcG1+I4n03RN8Cr79rx6K105EHuULkGMbQ48YkVfyPvIMqYEunrpaa5gAkE8FoaH
 5UNH5vsKC/UnlAfElj3d5Fgyic2L1oVdOm+Axg5b3/COLJcn+7A38sqFYRsYyY9DAd82zb1LTST
 20sc4bDkmS3TXG8gA9Rxyc0SKIRQFdYJGVx9AlqScZoEg7SOS4VIWZN6HYdQhCwl7IwNByMH+YF
 WBXMlj+YxStzt1CnmloAPYXCDVa1GfLVfD+nUwRMbVbbqXbCpPZ89W8jndMNmM6+ASQhljJ6xCE
 RmyGJJLpLEyaaZ0l0aQ==
X-Authority-Analysis: v=2.4 cv=VqAuwu2n c=1 sm=1 tr=0 ts=69497865 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=luqpl2TCSyK2LuNNAmtdDg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=P0VVE0QUFgw9kxqKfqoA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: gg9XHGCYfIO1vLYLN201GPumQru0Ro37
X-Proofpoint-ORIG-GUID: gg9XHGCYfIO1vLYLN201GPumQru0Ro37
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-22_02,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512220155



On 11/29/2025 3:04 PM, Krzysztof Kozlowski wrote:
> On 28/11/2025 16:01, Odelu Kukatla wrote:
>> Add clocks which need to be enabled for configuring QoS on
>> qcs8300 SoC.
>>
>> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/monaco.dtsi | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
>> index 816fa2af8a9a..6139511ea525 100644
>> --- a/arch/arm64/boot/dts/qcom/monaco.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
>> @@ -2226,6 +2226,10 @@
>>  			reg = <0x0 0x016c0000 0x0 0x17080>;
>>  			#interconnect-cells = <2>;
>>  			qcom,bcm-voters = <&apps_bcm_voter>;
>> +			clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
>> +				 <&gcc GCC_AGGRE_NOC_QUPV3_AXI_CLK>,
>> +				 <&gcc GCC_AGGRE_USB2_PRIM_AXI_CLK>,
>> +				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>;
> 
> Your binding said all interconnects have clocks, so please update all of
> them. Not only three out of 10-or-whatever-in-total-you-have.
> 

Thanks Krzysztof!
Not all interconnects have clocks/MMIO, I will update the bindings as
you suggested in the fix:
https://lore.kernel.org/all/20251129094612.16838-2-krzysztof.kozlowski@oss.qualcomm.com/


Thanks,
Odelu

> 
> Best regards,
> Krzysztof


