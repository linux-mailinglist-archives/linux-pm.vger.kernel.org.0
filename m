Return-Path: <linux-pm+bounces-42904-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNHgHWwNmGlF/gIAu9opvQ
	(envelope-from <linux-pm+bounces-42904-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 08:29:48 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B96C916547C
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 08:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 886B73033F91
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 07:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC4F331A59;
	Fri, 20 Feb 2026 07:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WMr6nv7b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AkNvneXG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357D9315793
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 07:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771572554; cv=none; b=rLeVNLI0bhiXrvO0waMwcu60fGmgaIsAoG4YOlgo023RknK42J90UAxzZxzQFBvIk+9q0UP1QGajXOtVVKYrEg/OUJeMEDDCm6grAyRqNZX24y3Cqybes1gK5IEOKgdH1VCiVQsELjqWRwNzuOvRjjpfpj/+NmmrMie4khktb1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771572554; c=relaxed/simple;
	bh=pPjKdwM9pmwO4ao95fJig6405dk2rzL3k/DXFhE4Olg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cij2b8N+ugCHNbnnPLBIejkYzPHQroFYn9KLP3VhfWZHuDxMVG5+/w2fNGnhoPHXWvZjL+rtf1JsmfxPhaD82XY8sOxHRf4Imu3prR1vIpFNdLmeA8geEj31hXLJRJ10f7hrssNsqTwGOccz0PcX++RLfLTZPLoCCuLAg9TNkVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WMr6nv7b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AkNvneXG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61K5Rm5e1851264
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 07:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nmdzgEkoO24WLtSkwTLlj9tbQJ0T6NhXURDMGInhV6w=; b=WMr6nv7be7sSjsGo
	T9gpWrneL0U2f4F8/jIZ2/V3GK4SamK+KYpwciacuBWJ1jDrE9Qdt3a+scb+bQVq
	3W7hj9xRFDLFlZWu5pMGCEXtq0gszJNXO3w/2VCzxmTaHhdR7/XlL7xOCzkeIvHP
	r5gmLPqdnDMfr29LlgZsmeDroWHTpCmeo0/vw1anFOf+szsYlsjlDQTYVl6vD/xB
	LTHkujNDjCxso9DCzl5ftSlKp96OlL2kTJJo4r7gS7x3Ck1MEZc45JjhS/cedR7i
	Wdq2cfuflccKJgm9T85E+vDVPQMu3+T1h5cAJOCXRE8t9ye6zlVN6XRFbeMk12PY
	2LKTCg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ce9ng9dq8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 20 Feb 2026 07:29:10 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8249ba7f6e8so915778b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 23:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771572550; x=1772177350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nmdzgEkoO24WLtSkwTLlj9tbQJ0T6NhXURDMGInhV6w=;
        b=AkNvneXGbI8HU8/nR47M0qTlZhnwUmh4uZiGSjBsVA5Ug5NX1cBuHpWqOXaP+LLrIj
         hfSFXpn/OFazFlGQbVmRElryXmnLjUWiZ5nbpTynO0ZVf7bmobM1ILYZMYqdcMLFQTt9
         PmlF8aYrsqdBMIqm8jvry/Zx6IKaaZepIrT5HPOQEPODRaTuKKPYNSCd9VbvVcPH1eja
         /9ssNwiJz6jwNQS2VcC/hjUcxnI7W2jpUsmr5sU4JAQG7kYoMAiM8wKxT8W7brBXX8bg
         ne3kHxwHa64c0Bi2bWm+Bw/V3NTDp5HqjouSl1BJyHuXmzlEXkXyk6TUm9eQnHFwuTYT
         TWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771572550; x=1772177350;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nmdzgEkoO24WLtSkwTLlj9tbQJ0T6NhXURDMGInhV6w=;
        b=ZZkQYd9IIJuCgCrzON/iGAeL6W73Y9vYyeWltUpYJT9PpIyxJfI88qrjXM0EUi4rZ/
         BkPLI9LdpoGD6Hi8bDni2gh2Hl+S8vbKEpclw1G8tK4+bLUnFRDdSYNGDgD1Bp1Oil17
         qVGl+VGkR/orJK6AOR4X0Nb36dRFjuEbl6B/OMWs2Chc5FTXBaQIQMjCFDTVptfoq3iL
         Ctv+h7ZA+Am2CazC/jC2AYObkKAsWuQK2E5kw7YOzc2aVobjWZ7p8AqVYM57AzLuKExE
         Ixcdc9wFrEmjrupJQ135lOcWv9j8Y4/iC8ZazB6nASWaVWyJlrpFV6Ppeh+0pwqFgnIN
         ReXg==
X-Forwarded-Encrypted: i=1; AJvYcCX48Tz+hdAq/T2IJin+EogEid5C0557XXxqFUgg+lUgsONSCq6SIumMiey7HnXoFjbrZPM543at+w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4bkpo8IKNDOTOa6xXaDEVcoDu/EZ8NYLBVKeLfuyQ4wYboYaC
	zoxYHT2BECwF8ClbIk379dWx08lb4HOZl/WY4eaI3zZPF6iPiUepq6rdmfToC54IUjU5UYKgDFR
	/4Y2OOxYzIAfmHU8V1/OgMoydKoJhDIyF26dlzV1wfTjyvdRCQGr3zgEQd/Xq5g==
X-Gm-Gg: AZuq6aJuIqO3X2c7vDGslAdsFxWmHA5vG/bPuiBgmHe5FL/3QPDxGQYLpWp1b1+agpo
	KYRbvubdy52TbxMwc0ZmSmFZ/LUHbd8owbhxLgvZ1ueba8LPFky3vSEdJlMcn0UITElvfVOKeDw
	+bt+o0xF3t68O71vVe4CWu5eUvZXf4xIY1WGq7spVn6D25FisZ3dnp6UHlXIecJAloHVfxTKZdP
	Jlao8aLZDFYIbL9nNTf4R/zzfaKDHfQnTQZA5MkS0Y8zqZopEejD3JFUgm17E5UVvpiT3MkY2M+
	uu40gRanqbOOdPCYmgYf52Um6k32yMkbv9DBSg/7clpZClrLwSNOr3Z7LFlmnkZBLehM0+oxvW8
	QJzzPEX1TZSmsI6cJqRW8E356mxouQRs10204sRVaQJqYz+lTNyY=
X-Received: by 2002:a05:6a00:3d0c:b0:81c:c98c:aeb7 with SMTP id d2e1a72fcca58-824d94d00abmr19343484b3a.7.1771572549764;
        Thu, 19 Feb 2026 23:29:09 -0800 (PST)
X-Received: by 2002:a05:6a00:3d0c:b0:81c:c98c:aeb7 with SMTP id d2e1a72fcca58-824d94d00abmr19343453b3a.7.1771572549211;
        Thu, 19 Feb 2026 23:29:09 -0800 (PST)
Received: from [10.218.12.237] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b69b13sm20291596b3a.30.2026.02.19.23.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 23:29:08 -0800 (PST)
Message-ID: <c6136314-5bdf-466b-b19e-43062fb11150@oss.qualcomm.com>
Date: Fri, 20 Feb 2026 12:59:02 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] dt-bindings: thermal: Add qcom,qmi-cooling yaml
 bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, konradybcio@kernel.org, mani@kernel.org,
        casey.connolly@linaro.org, amit.kucheria@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com
References: <20260127155722.2797783-1-gaurav.kohli@oss.qualcomm.com>
 <20260127155722.2797783-3-gaurav.kohli@oss.qualcomm.com>
 <20260128-whispering-caracal-of-respect-a26638@quoll>
 <36706481-2549-4716-8e6d-0e4db42591a2@oss.qualcomm.com>
 <546faeda-d896-403c-a449-5c9b0cd7159e@kernel.org>
 <17474333-bb82-49d7-bc04-45ab21095c38@oss.qualcomm.com>
 <ae4c1f7e-8f4c-4ce0-a6b8-bab29984e693@kernel.org>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <ae4c1f7e-8f4c-4ce0-a6b8-bab29984e693@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDA2NCBTYWx0ZWRfXxNgi1yofXcBG
 ykvWVs1wo7hs2/Q3cYfp5jeJiF9vKLTtTDWSRWIthcHHHlf4CFFo/BSMPFtWP6yGNPt5w2V6U5v
 +3N4jh0cv6XPNacht76cTrUPvvVIHUu+b7gFKQXLco3ebbeLJCkZsvYSmBkf/Ft+PZ/RswOeNkt
 x38KvS+bu03QstWreDOS4M1vFahY5pNtahZW7kplgSvRZJbMjWM3/X2g77zAuj789r/CYnv/5o8
 e8unxM/+ihsRSyT3UUI92Kpm36ujbthHi8k0mbtc07bP5FsLrM9ddVp0xQhndAYZyWjkFQkrC1k
 alsuKz/3xfnyBxcCOJAXf8dsMOiDzQcTISBIwTnowtU18AagoZD6qb+FxaA7ya/I+yMkWvIN7Yj
 i9YjHxNSMglY9YJZ9yko28V506ei9O+I9luGXFgy25eaL1wn2R2bHRCwfX2WN2vFm43gxtP3bNV
 GsWH9VapvMVGZGSwzng==
X-Proofpoint-ORIG-GUID: SFolOZEDcim0D9I_K4n8U-_w3xZ_tpsA
X-Authority-Analysis: v=2.4 cv=Sbj6t/Ru c=1 sm=1 tr=0 ts=69980d46 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=Y8yh3MHrz31bv1ga194A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: SFolOZEDcim0D9I_K4n8U-_w3xZ_tpsA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_06,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200064
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42904-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[2a300000:email,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gaurav.kohli@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_PROHIBIT(0.00)[1.145.78.96:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B96C916547C
X-Rspamd-Action: no action



On 2/11/2026 1:43 PM, Krzysztof Kozlowski wrote:
> On 11/02/2026 08:37, Gaurav Kohli wrote:
>>
>>
>> On 2/8/2026 3:36 PM, Krzysztof Kozlowski wrote:
>>> On 29/01/2026 13:06, Gaurav Kohli wrote:
>>>>
>>>> On 1/28/2026 4:57 PM, Krzysztof Kozlowski wrote:
>>>>> On Tue, Jan 27, 2026 at 09:27:16PM +0530, Gaurav Kohli wrote:
>>>>>> The cooling subnode of a remoteproc represents a client of the Thermal
>>>>>> Mitigation Device QMI service running on it. Each subnode of the cooling
>>>>>> node represents a single control exposed by the service.
>>>>>>
>>>>>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>>>>> ---
>>>>>>     .../bindings/remoteproc/qcom,pas-common.yaml  |  6 ++
>>>>>>     .../bindings/thermal/qcom,qmi-cooling.yaml    | 72 +++++++++++++++++++
>>>>>>     2 files changed, 78 insertions(+)
>>>>>>     create mode 100644 Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>>>>>> index 68c17bf18987..6a736161d5ae 100644
>>>>>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>>>>>> @@ -80,6 +80,12 @@ properties:
>>>>>>           and devices related to the ADSP.
>>>>>>         unevaluatedProperties: false
>>>>>>     
>>>>>> +  cooling:
>>>>>> +    $ref: /schemas/thermal/qcom,qmi-cooling.yaml#
>>>>>> +    description:
>>>>>> +      Cooling subnode which represents the cooling devices exposed by the Modem.
>>>>> I do not see the reason why you need 3 (!!!) children here. Everything
>>>>> should be folded here.
>>>>
>>>>
>>>> Thanks Krzysztof for review.
>>>>
>>>> Each subsystem may support multiple thermal mitigation devices through
>>>> remote TMD service.
>>>>
>>>> Because of this multiplicity, introduced separate binding file.
>>>
>>> This explains nothing. Subsystem does not matter for the binding. My
>>> comment stays.
>>>
>>
>> thanks for this suggestion, we will use qcom,pas-common.yaml to define
>> bindings and avoid creating new file.
> 
> I asked not to create any children nodes.
> 

We have multiple cores within a subsystem(cdsp) and each core has its 
own independent DCVS. And also we have dedicated TSENS sensor placed on 
each core within the subsystem.
As a result, each core requires its own cooling device, which must be 
linked to its TSENS thermal zone. Because of this, we introduced 
multiple child nodes—one for each cooling device.

  ------            ----------------------------------------
|      | -------> |  cdsp                                  |
|      |          |                                        |
|      |          | HVX compute(tsens1)    HMX NPU(tsens2) |          |
|      |           ----------------------------------------
| SOC  |
|      |
|      |
|      |           -----------------------------------------
|      | -------> |  Modem                                  |
|      |          |                                         |
  ------           |  (modem Lte)    (modem nr)   (modem pa) | 
  

                    -----------------------------------------

Unfortunately, we don't have target in this series which supports 
multiple cores within the subsystem, but there are targets which 
supports multiple cores. We will post patches for those once upstream 
dependency aligns. If it make sense, we will add superset node examples 
in dt bindings for future targets also.

We can use another approach, we can take this cooling node out of 
remoteproc node and use soc node to define child node. This has it's own 
drawback, here qmi-tmd will probe and wait for remoteproc subsystem to 
be up. For cases where remoteproc won't be up, qmi-tmd will still do
probe and sits indefinitely.

So we need your guidance here.

>>
>>>>
>>>>>> +    unevaluatedProperties: false
>>>>>> +
>>>>>>     required:
>>>>>>       - clocks
>>>>>>       - clock-names
>>>>>> diff --git a/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml b/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
>>>>>> new file mode 100644
>>>>>> index 000000000000..0dd3bd84c176
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
>>>>>> @@ -0,0 +1,72 @@
>>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>>>> +
>>>>>> +%YAML 1.2
>>>>>> +---
>>>>>> +$id: http://devicetree.org/schemas/thermal/qcom,qmi-cooling.yaml#
>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>> +
>>>>>> +title: Qualcomm QMI based thermal mitigation (TMD) cooling devices
>>>>>> +
>>>>>> +maintainers:
>>>>>> +  - Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>>>>> +
>>>>>> +description:
>>>>>> +  Qualcomm QMI-based TMD cooling devices are used to mitigate thermal conditions
>>>>>> +  across multiple remote subsystems. These devices operate based on junction
>>>>>> +  temperature sensors (TSENS) associated with thermal zones for each subsystem.
>>>>>> +
>>>>>> +properties:
>>>>>> +  compatible:
>>>>>> +    enum:
>>>>>> +      - qcom,qmi-cooling-cdsp
>>>>>> +      - qcom,qmi-cooling-cdsp1
>>>>> What are the differences between them?
>>>>
>>>>
>>>> Some SOcs support multiple CDSP/NSP instances. Each instance requires
>>>> it's own
>>>>
>>>> compatible string to distinguish.
>>>
>>> Why? What are the differences?
>>>
>>> I will not ask third time, but just respond with NAK.
>>>
>>
>> For Leman's, we have multiple NSP subsystem to support compute and each
>> instance has it's own firmware and separate hardware like below for cdsp
>>
>> Below data is from lemans.dtsi for cdsp subsystem:
>> -> remoteproc@26300000 {
>> ->  remoteproc@2a300000 {
>>
>> That's why, we have introduced different compatible to distinguish
>> multiple instance, but we can also solve this with single compatible
> 
> You did not answer the question what are the differences, so I am not
> going to ask third time. NAK.

For exact hw diff, we are checking internally and will update for this. 
Right now we only know that we have two cdsp subsystem in Leman's and 
each has it's own firmware/cores.

  ------            ----------------------------------------
|      | -------> |  cdsp0                                 |
|      |          |                                        |
|      |          | HVX compute(tsens1)    HMX NPU(tsens2) |
|      |           ----------------------------------------
| SOC  |
|      |
|      |
|      |           -----------------------------------------
|      | -------> |  cdsp1                                  |
|      |          |                                         |
  ------           |  tsesn3               tsens4            | 
  

                    -----------------------------------------

> 
>> with new dt property for each subsystem instance id. Please let us know
> 
> Instance IDs are not allowed, either. Please read writing bindings doc
> or slides from talks.
> 
> Best regards,
> Krzysztof


