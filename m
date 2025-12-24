Return-Path: <linux-pm+bounces-39911-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57177CDBF1B
	for <lists+linux-pm@lfdr.de>; Wed, 24 Dec 2025 11:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D60E03007C78
	for <lists+linux-pm@lfdr.de>; Wed, 24 Dec 2025 10:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD53D33372D;
	Wed, 24 Dec 2025 10:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SjZSYxdt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O3vcEA2v"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBDD301037
	for <linux-pm@vger.kernel.org>; Wed, 24 Dec 2025 10:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766571107; cv=none; b=Usbzyf0mzk8oxdufqGdkryZ+mCpVKCdN6LYIuKK99eGz7j29SfBVw/H2w/0g96zjdOR5nRaLXEcIhn5xQsyM85d3i5lyKlVH725IRcSwVQhug53MM++16hVqqc8Jw6T2jyFefQEePHn27qRPW5Pr0gPI40O+NmlbwTjRsGTvGo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766571107; c=relaxed/simple;
	bh=0+LzigftUlRjypYE7eKHbXMl8C6YbFGHAlET3r9jYMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uMzrka9gatFZoWXZT4MCfcyeewOQuI4Kw9VFH8is60SQHST64+kDTlJVRI0CPsgW/91+Lpp9pPn+Ioh7/0jcV3tRuizNm9PwZGickfsNmitkzmfhaAsb8F3uSV5hZLB0d3coc2KFf9KwgRZoh2DBWiwehyzFTseVUdJWvbvUrug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SjZSYxdt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O3vcEA2v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BO43QEm4134150
	for <linux-pm@vger.kernel.org>; Wed, 24 Dec 2025 10:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Svub1lU8ZSgyZ0FEnwysVHAmS9UtLZzdyHUW+Tohk6E=; b=SjZSYxdt2qoOIAnh
	sPT/EtoFzR/AwExHlaMqaGu92FAjXvr4mI/r4uIFkGszTaRob3AZ65FxNpZmSx+B
	3zraQBeYRFFTb5xW2K4U8xyfKGiAp6NxTxyKmBv0jmmQJ09FEVR64SJxBdhhy9sl
	WCiJ5FiweTQixePBqHVC+J1POROYTAWLRCTUa6/99utOu7pdlfCOThZzLn3BdLn6
	6BQK18B6FA7PT/LjV6H7Ch5smKCsJk9D3N5z/hYMHLNaLOizMdS7n5HFn9+1x6q8
	xMu0W+z/wm3q+vhcUwb8SDsC1H06QMqda5bEkzaPeHGZ0jClBtj0LNMvJZ7QbLc3
	GljtdQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b7x46tqxr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 24 Dec 2025 10:11:45 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29f8e6a5de4so80321975ad.2
        for <linux-pm@vger.kernel.org>; Wed, 24 Dec 2025 02:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766571105; x=1767175905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Svub1lU8ZSgyZ0FEnwysVHAmS9UtLZzdyHUW+Tohk6E=;
        b=O3vcEA2viZ3YgUK9+c0aWZ/HMJMkoqpIY97uhD0jaFrbC1AX7AEFlrgJYdsNDBAJ3x
         iJHyK4Hw/CTSwucY6NX9pgen0TtpkyKUwSLKs/4vDaCcEf/Uu4Odb3aYQy84G0OoG5fc
         yxAp3cU35xViShPa6QP8nWTOOBsMWRw/pFPwJjVwHhBKNCESdBO6xbUslzXzsUKYYxUg
         vvEO3I5LLNPnzNaAWuP6E/neyqRSQlE+D73kZ5mAcjE0bTSE4BWbWEBwUR/lZhwJA8hD
         nUP85/DCThNJlxJJcYFQum1KvY5ZvazX657dRqdRkuph7ATOonMmEH0aPEHQAtNOa8Hr
         7e5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766571105; x=1767175905;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Svub1lU8ZSgyZ0FEnwysVHAmS9UtLZzdyHUW+Tohk6E=;
        b=ni2E9oRCWf/Fl6al2trvh8KshwcDJ0yk1xj6PWc6v1JT6U232LtsvVR9XWHgj90csL
         A04/N52Z0xhYW1lyQrVgedzV9qMRvMXxq3RstdsoQXQXB/yp/T5YcCN+/dV3X2f0Bv/f
         SebtfDiKEcMzNF01K6hS/Gg3gyYFmARedAgTZz/qTRNdNEb5qfxGiYbAIOm17A0ueDl6
         KPD88cuNsEinFspC4lkxspBfoJTiirCdXqCok7R0TvSZ55fUeHr3s0vLdeOBwVOXWP2I
         Efs+q4PSuCrx+u9LFdcsc73zsBTPUi009jp0CahNqMOccBSCXUIuFawvdOIqPXdIEjoK
         WKvA==
X-Forwarded-Encrypted: i=1; AJvYcCXtRH0ucNpTWFpOfbzIfWroYM6UqQrS+AL5UFfozv1mZclDqMdnjIvCea3+8VgK99x14R5A0Nx4jQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBZ0cuQ+c5SfsbJvzNkuU/ihjkBWButcMqDAiaICVwzJEcLovG
	AUPuzf8txHUbIvtlQWqavV4x9yISaqD30GGRjYS3/hPJKvhp3em/nFdbvHBvBeNSEwYz9lvLERQ
	eAKCApfXF3+U9zWKiJThg6R2kMTFlmximNPv/QHqoebTshdq+Rw+ZpBwzewU1QQ==
X-Gm-Gg: AY/fxX6hYX4w2AHDNii07D1cf2L0m+6dgCEHJuYTNgCFqAVoY/uWJ9JX6Wo1Hf7KJwD
	0d++NRcYZGEubupRBIkQVMN+GocqsFTfQqYZ0kt6LNScpoJ2yfmbtWdFD2VulujjlZd+eknN0Cw
	Cc/kd3ZPPvYAMrfyD1eb4PQzJDOW8IMS/WDU5zuYgQrxsVyAVBXy0Fq8MeeBjTWMwiCjW3VEH8I
	/97qu440abvhS0oz3Jkeg3Xb49ym3cBtRzJd+3jIGfqsootOh8EEuw3m+mBePfqGXWUTCNoe8YL
	funKl9Zi+FirDi48zgMuC0L2yg535eM9uP8dSuVqrsuMZWOC1iIo04IwHkhaVqsSAcEOK56LaYI
	XMqUSooIJaw4lo1obZ1sE1ZMEeFCUC3rTaPpymFidzw==
X-Received: by 2002:a17:903:2cd:b0:2a0:e532:242e with SMTP id d9443c01a7336-2a2f220dd7bmr160503125ad.11.1766571104923;
        Wed, 24 Dec 2025 02:11:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPP9Ip+0lDlRJOgiICxJKR2lJuGko3g+A/N9Bn0a9iSgphrPC7hgQ2nkVu84feaV3gcN9RWg==
X-Received: by 2002:a17:903:2cd:b0:2a0:e532:242e with SMTP id d9443c01a7336-2a2f220dd7bmr160502985ad.11.1766571104446;
        Wed, 24 Dec 2025 02:11:44 -0800 (PST)
Received: from [192.168.1.11] ([106.222.232.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c66bd3sm151171405ad.1.2025.12.24.02.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Dec 2025 02:11:44 -0800 (PST)
Message-ID: <a0df9078-f05e-40bc-a708-cd03eb86839f@oss.qualcomm.com>
Date: Wed, 24 Dec 2025 15:41:37 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 8/8] arm64: dts: qcom: Enable cdsp qmi tmd devices for
 monaco
To: Krzysztof Kozlowski <krzk@kernel.org>, andersson@kernel.org,
        mathieu.poirier@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, lukasz.luba@arm.com, konradybcio@kernel.org,
        amitk@kernel.org, mani@kernel.org, casey.connolly@linaro.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
 <20251223123227.1317244-9-gaurav.kohli@oss.qualcomm.com>
 <2ce05668-e4b1-4943-aebd-9ba57f4c8363@kernel.org>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <2ce05668-e4b1-4943-aebd-9ba57f4c8363@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ttNMGIZ-NKV1MugKOieRhRz8h5I_Ndea
X-Proofpoint-GUID: ttNMGIZ-NKV1MugKOieRhRz8h5I_Ndea
X-Authority-Analysis: v=2.4 cv=aOf9aL9m c=1 sm=1 tr=0 ts=694bbc61 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=pk+8NuH2X28N4C0eta/h1Q==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=JG_C0qjW1QYSyXvylJMA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDA4NyBTYWx0ZWRfX8dfQOjOOyPuQ
 f2H+BtG/PfSfac5iqVxpApe/413R5jzFJiX5vJRqMJvRLhrMvGQGdciCj+shzwFIi/c8k+wIYz+
 /dJRYDy2S4hrjmmiFaNRnHns2m3mltcZCyq2HpvPPqa0T7UgSeBH4aTQxKJjLnkuTywmbcEgUFT
 BFoqVVR6OiJkb0V0Mc4SzgfXGRnO2YJeFnmQnUOuRY5fKZnIYSRAWDxXkeGkhQQ216VVbMBjVUi
 L7Dd1YXbPOFPJ8KYa9FdRx8a7W3tPrpgNdmwO9UXOgo3a8PXjKucPXPLVNjOaikVr+iI1eyT8/C
 dOUbCGn3ieb6qAAig21SQz/buPqjbY72vWZOkJbx2F7fuFT27fm2JCEzu65Q99fHvnFSzoW7nO7
 l+d74Tz95Al6D+w1AqoHVNH3v4Ltr09k+EZSDGHULipWaPXsNXC63gfXpGnmXfToJsWxKC2Oolx
 pPp2TzfJJb/UpMfrG5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512240087


On 12/24/2025 2:28 PM, Krzysztof Kozlowski wrote:
> On 23/12/2025 13:32, Gaurav Kohli wrote:
>> Enable cdsp cooling devices and thermal zone cooling map bindings
>> for cdsp.
>>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/monaco.dtsi | 92 ++++++++++++++++++++++++++++
>>   1 file changed, 92 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
>> index 985e37bf4876..1fe148ec5cf7 100644
>> --- a/arch/arm64/boot/dts/qcom/monaco.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
>> @@ -6217,6 +6217,14 @@ compute-cb@4 {
>>   					};
>>   				};
>>   			};
>> +
>> +			cooling {
>> +				compatible = "qcom,qmi-cooling-cdsp";
>> +					cdsp_sw: cdsp_sw {
> Another LLM generated snippet or just mistake?


All this is manual code, will fix this.


>
> Best regards,
> Krzysztof

