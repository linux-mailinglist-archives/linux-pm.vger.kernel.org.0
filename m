Return-Path: <linux-pm+bounces-41688-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LBkIcFOe2n9DgIAu9opvQ
	(envelope-from <linux-pm+bounces-41688-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 13:12:49 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B27AFF1C
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 13:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B8DD303F067
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 12:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D0A3876B5;
	Thu, 29 Jan 2026 12:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L6Z21/3t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SRdeCM1I"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CDA385ED2
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 12:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769688666; cv=none; b=cxKyvu5I5cX/QCQ8ajC8tS76LBjy7bfpJvT992CGrkWzyCewuwiZi6fzQ6BdrbdGalB8dSTTHzd+34iPpvmTLTx9kv+I5XVO3cpk65eIMPKSrnYky8QTrpRCzbBH+VQA7pKdwQUk+T+QB5LRvtXZ812IcRBjvj8csP2OeXr2OUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769688666; c=relaxed/simple;
	bh=3azX8oVj1c15R3dhcDwWK3XeVSUWIUXitKc5ZBu7dDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y6IrRHrEk/aBjagq335tKBpBrFQxeLGIIRAnUgEyL2e0CrQ77THMdQVuGoQ088YJglBZYMYTMMGUHftLTdRBsQx719Vba7GVAnvPH5Til2TLpc+Sl8dIV+ffy7FfN8TlYnWAHCZ4HZysCgr2hCmAQhJUQFSlEjiIF3nafNnv4f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L6Z21/3t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SRdeCM1I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TAKZdM3674068
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 12:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3T6vtt4wbQUsGCz4EvbMTMZdQSqORbzLetNOyheoGkw=; b=L6Z21/3tAVTCqmB2
	K56KognUAtw65/Wqk5LFhvANpGKkkcNUTTlOugFND3yDYa7uWgoD12BHWTXYyVk6
	O2RtyLKgLF8vPQfnUZxZOqUrv6B24ZI3f/88gChKswxXJJQKSj4xbZZGyVdjnP9h
	m7QtfGjP57IsJnCBqjiwDSLKpTf5ouhpdwwfosoBYmrFUSceJbdN+nijAA5Osi7J
	Q+khLLg6i6EAvEIROIo4BHpQ0UZViVkOZDMsanASNzLm789FOhhLn5fcng85yemK
	UkXUrlUsXC0WQpWACLDYPE3Hr4qaTNOXBAoTreksoPgUvy/Xk1g0xMAPsVJSwawy
	hACpkg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c05q7g9tj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 12:11:04 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34e70e2e363so932290a91.1
        for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 04:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769688664; x=1770293464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3T6vtt4wbQUsGCz4EvbMTMZdQSqORbzLetNOyheoGkw=;
        b=SRdeCM1IlzVTuzwr2L4iyyw8W+lGWYJZUignAtCL4cjU6w8tsJJ6GHFRtaeXcD571P
         tvUvFBwwy03HpmB7zqTBPtb3u73I7Iv2pnGe8Uqec760ZPoqrD78MEwJXc+bxRPfS+i/
         Z+Xjm2Bhk4+VFUpF10PsivaxNLnAbE4zVjho/WMI4RIJGjQzkEJDdJntJ3INN28haqJc
         H+15+UcdbLTw0zMi5cs/iulYY6vlpq8tgEwKPHFnKx3Y565VA/xVw9EsUXkvfPLf27mw
         Ws9biq6nuVGS4upcGpBWN9v4Uvg7ba6C0a+BvKHMxK0N5NXrZ5Ix7kJVUoPyEkcSaEp+
         f8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769688664; x=1770293464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3T6vtt4wbQUsGCz4EvbMTMZdQSqORbzLetNOyheoGkw=;
        b=Y19FQ/i8DSAW1nHe6JB+WU4gF8uvitjWLE2HaPJx/JvNLnt/QVfe/PvCOAFFQOTrDG
         se7b7jaeREY3/z3pYsD02F5qtVfGyhIaePsU1GdFqK3dAP0Cm2eUNejufmElCKO8JBEY
         zbwWKYzX9pd2PXgU/hDVjIaGveDqPEwjdcVAHpeAPhj9KCsT0PfKHSyZbnbwiZADGS6h
         bryQ59oAEDsJkkX84YvCEPGNcC0u0WSt5oPIRGqZgqrVY1SYYibmCHEP06XodB9Sp3W1
         Iwe1TLitR16JxFYF3aOXgaH1eMxGBVPyuMYGTu1x7wIWTIl6F5ZjopL2Nbpwqo72Vi2l
         bt/A==
X-Forwarded-Encrypted: i=1; AJvYcCWKDC71R4ag4Ac/pUjPrlNyux0WsNhuy0N2zakhBzZTXtGdDkrgiDu2zsfh4UDjAOz3Xn81R8GcXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUaI1wRFMrtGWGag9awAZ85xL7/Dqd1fdH6AO1loCK6lGLqnHe
	9plqLl+sSGluNtJDgH1uQBbwr/0tx3kC3iXfyQVpl58tqrYyqv4oHR0yNobuyyxkSczYuQSJwFp
	DMiel9SVmv2O32ZKipfjS+roRLaDuNeg6KHrNinzE6hl6ECBo0xrSYmsSmlNxdA==
X-Gm-Gg: AZuq6aLj1YmsjDueX3yV7JTlxAx/AsNBlOUk+69vi/HjvsMV8cfLKILaghC8zW86Az9
	7p+kyLnKI8Ey9mNrk1n5b49DRmFLCFaNgP4WiD9vV8vmVPJYOvJ1J/KlwdDAdI3frd4k9+BvcrH
	rutO3Leva5BCoUnDj3iZiZYrAO8UEJe9OyKHPNkER6zY5HDJ/U1oTSoEnEsVr6n+Mrfp5BnG+ur
	6BiezMQGeV5j9L6bNhyL9wkGt8rTYYoSz1yYkxFwn/cANMP3fHFbcOxn86Ml1Mxx82ipot/OkFc
	befngVx/Db1RDkaADbaoK6dqtEkMiNl8xpdm6p4b8qyU+Lfjt62iMAd0kDG/jTDL2vCiy7+B4UR
	9MBFZ4MkKW4BvvZAMwXulEzv8iwyOlucK0/eX/Ic+
X-Received: by 2002:a17:90b:3e4f:b0:353:3b33:8263 with SMTP id 98e67ed59e1d1-353fece5768mr7723451a91.9.1769688663638;
        Thu, 29 Jan 2026 04:11:03 -0800 (PST)
X-Received: by 2002:a17:90b:3e4f:b0:353:3b33:8263 with SMTP id 98e67ed59e1d1-353fece5768mr7723430a91.9.1769688663151;
        Thu, 29 Jan 2026 04:11:03 -0800 (PST)
Received: from [10.217.199.117] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a3356b4sm4882283a12.17.2026.01.29.04.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 04:11:02 -0800 (PST)
Message-ID: <3a1b3a2b-d73a-4dae-b866-14abec2ff18d@oss.qualcomm.com>
Date: Thu, 29 Jan 2026 17:40:56 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] arm64: dts: qcom: lemans: Enable CDSP cooling
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, konradybcio@kernel.org, mani@kernel.org,
        casey.connolly@linaro.org, amit.kucheria@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com
References: <20260127155722.2797783-1-gaurav.kohli@oss.qualcomm.com>
 <20260127155722.2797783-6-gaurav.kohli@oss.qualcomm.com>
 <o3gdovqbkmclpmrhjtg3lknhqcecwfrp73bpbv6nsspzvkjfm7@qqkrzte3cdy5>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <o3gdovqbkmclpmrhjtg3lknhqcecwfrp73bpbv6nsspzvkjfm7@qqkrzte3cdy5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Ok23crUaRj0rLZcY_En_vGhZo6bJEr3x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDA4MiBTYWx0ZWRfX98BK7QrKKvlR
 BSKLCcNDj/79yKpLxUohmUsKarA8ItLfvsoshkqTjiw1RH7jCDVJLvFwNKRS95mCGOEQO4ITQRW
 pDujrL+61168M/KuFCY1G5iucoVXoZkoASQuzBnwIh7E3YuXqSFKSkoWzfCNRE8MRsT1zGec0Q2
 Kl3GWWwLQK/1jz+tLs/eBdocGDADDpPY4YA5cFt/6LN1BnNaIc+v9wlK8klK4KiYNzfJCsT/4xY
 pGlxm2bvxg17k6yqufBoex64Tllxqc6VaOxvDz7GQ0jR7WqWZbbgFAgYIwrqVpcAmipiVv7P8jn
 U9qt5OmmHFqKFappA9g4br2l6TFGzaTOoqcwFxS80JJY0XtkvfN6OoXawmvhkeUvZp+2WP7Y+/r
 JG3rlu2RCJBlwMj4xu0zu5woPU3fsHncpHDMtwS5GEhVYf4gm32+TPhc3BHT5RFEI6ElUxsO6so
 V4yXBLw6AIJ5mNWjc3w==
X-Authority-Analysis: v=2.4 cv=donWylg4 c=1 sm=1 tr=0 ts=697b4e58 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=V2w4IgnLWKD3j5nXI8sA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: Ok23crUaRj0rLZcY_En_vGhZo6bJEr3x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290082
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41688-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,2a0c0000:email,0.0.0.11:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gaurav.kohli@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B5B27AFF1C
X-Rspamd-Action: no action


On 1/29/2026 6:13 AM, Dmitry Baryshkov wrote:
> On Tue, Jan 27, 2026 at 09:27:19PM +0530, Gaurav Kohli wrote:
>> Unlike the CPU, the CDSP does not throttle its speed automatically
>> when it reaches high temperatures in Lemans.
>>
>> Set up CDSP cooling by throttling the cdsp when it reaches 105°C.
>>
>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/lemans.dtsi | 138 ++++++++++++++++++++++++---
>>   1 file changed, 126 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
>> index 808827b83553..c747dd534caa 100644
>> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
>> @@ -7281,6 +7281,15 @@ compute-cb@11 {
>>   					};
>>   				};
>>   			};
>> +
>> +			cooling {
>> +				compatible = "qcom,qmi-cooling-cdsp";
>> +
>> +				cdsp_tmd0: cdsp-tmd0 {
> This question was already raised. Are there more than one cooling device
> for the DSP? If not, drop the subnodes.


Thanks Dmitry for review.

Yes, Each subsystem may support multiple thermal mitigation devices 
through remote TMD service.

So, need to define subnodes.


>> +					label = "cdsp_sw";
>> +					#cooling-cells = <2>;
>> +				};
>> +			};
>>   		};
>>   
>>   		nspb_noc: interconnect@2a0c0000 {

