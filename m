Return-Path: <linux-pm+bounces-42487-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DmpGtcxjGkAjAAAu9opvQ
	(envelope-from <linux-pm+bounces-42487-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 08:37:59 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D12121E75
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 08:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C5FE301DE07
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 07:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFEC2E62C6;
	Wed, 11 Feb 2026 07:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PTsZG0WY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OJBN9O4k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44562278165
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 07:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770795476; cv=none; b=btHB+mO9lxukOOfO44mgRcPKKwatNRk5N5EihpxrIgk76rH48BVgOfCRoHbxuPKdp63hN+FpJQAo9JfUmISk11XNAFlVxx7mzVi8+nrfDXMPTuVfrnHHGGeo+Wv0KLtmHyLc2fvkHshMOCiB5Pm8hxOn7TNN6QyGsCSyrdGsto0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770795476; c=relaxed/simple;
	bh=zEjVw7VFZCsg3T6HT+/mixoxnJc0GQzrS/OaTdqRKAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NiFnkshb6WQFCEk2GYqbMywVh3RR46ZKHDcLD3ZhQOM7TamZcrL2ppKM9LQSZ6f2rrP+fR+zEgdnP5+NADnPxHL/Ex72SgKlNQH6VS6CtNgXC1J9BA8HrltuO6MCsPUwHGeORJ8XyKtm48Xd1hki6jplV2Wmw73d4osd+WEsnpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PTsZG0WY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OJBN9O4k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61B0RVQL170311
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 07:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nNh0LW4+QgF1Ws6tgvgVchZguW207LBV5kiUxDW0Ny8=; b=PTsZG0WYtWQEgy47
	XI1IXjEkqOeCXHFJ+9tdsDblvSH1AqymvIwVoSn8sOhPj1pKECoAYIEF0UhUJ4Mi
	JYdAan2EPt93+vZgWPdJchI+8YIZeRbaYYUWbAFDzMx3Wazp47oWH4FUg2X0ExAN
	DyjiA9sQFpaLxiXNsIed9stS6JL2Uz3vYft8fTdAS/KDzRt4eh6CaJFucf+FuE4m
	Qer7dD1PcJgLpa/B/3hrwwnzh/l5a8yjBMY1xJereA0KA3w69cgqyTfXlBiQ8vSm
	pcxqMygty6v11W44nb5e5x0XOJfRYFn25aVWm7W1KjF5cMMXxwE4z9e2Dcd4x4Q4
	r0kxmQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8f8792rm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2026 07:37:54 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-81d9b88caf2so1736891b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 23:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770795474; x=1771400274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nNh0LW4+QgF1Ws6tgvgVchZguW207LBV5kiUxDW0Ny8=;
        b=OJBN9O4kF719Kd+x1Ij9oNi6O4OZ4RWe5tjmx8iPCv5F/llOZmnMN9b8A3l/MVW9CY
         4Tx5K8zxQE24d0BfA0vL2ajMgkppwNUYQZ8OW8VdnZKSRsRHDmCvlfmjjydo8iTsMu03
         WKf+qCtL0zHl7EP3KEMb742kA4YcnSX3pnSCiSNDPbvLZ0XY5vc9TrtoWJ591D1Js4WA
         ISAvOHWw/k6n+JV7C2RsEVxSO/rCxAaN/2xVSWbVnLtpk52hYziMDnzkY5wT8Tf7JhaF
         Z9xlYAO1ol+zZfr4nvsbTcOPJSIMQPvaJdNis5bIeadCnyae/R5aHBbubbPKJHcYNmo+
         XMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770795474; x=1771400274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nNh0LW4+QgF1Ws6tgvgVchZguW207LBV5kiUxDW0Ny8=;
        b=DvpjtwtF4/3wFHhVZquJF/tv6OGSIYnE0n37CKAHu6y7h0Yo53cI+55G9IfGR6qL/j
         elUw5Uw8rhDdR1A0k5paGz87q7HR1iuAG1KnOOduvps7ZJgtkd/cumS/K+8GW85UBXrg
         OqIhillB03NnPoFfe962L8ALtKBf4o44xz2fcMAgX7NyXl9WaGpPoS++Kez00ubgtqos
         N58TCyh18bW/qj0YIk010zU04CHSDBbl5TtG24oV7YRclI0r51XXOyw9lTy4ZcqlzfRG
         A1JurNySTbFDXdeMNmEsBJxo3xw48tfGSEA1iBbrntnKGXWxvQkfSxxreaXNFJqXjeBo
         NzpA==
X-Forwarded-Encrypted: i=1; AJvYcCWGH8G5Dv5d+9fkNZQK16gSohVTMEdM7a8TI+LrGm5jhNwRmOl5QubKlruv2G+4STB3kkHHNMTHPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkB1DqG5+C1253mO5nizk/ircGCG0zwULcFPLmkORcF/z6xsk8
	excdJfuSWmZprvPzDQi+5B3tzzBghsvBt/wTQExyB8TKz+imtJfbKbJQ7eHrFFGHyPHFllEfqwV
	Dif030ODuOQ4vrmCPrIdDjYWh6dXK7d0mLu5C01yOW49kd+mnjLfte6q1TjNQ8g==
X-Gm-Gg: AZuq6aKltQBf7WwI+0U03jzcQwjC8kAn1j9NzTX8Gqyt6g5m2lO5UZ56pE3048vEXaM
	WS1re+YQ+y2XmoeqYVJ0+rZYBjLpKue+GaWQkwS59HN6XE2AXpG+Y2eWSPmfD4b2dtBFClN83+B
	URpV/MOxrQle8yNKRS2sj42Tq6qibDtek0jtRU9f26suAMcSs6ZYUceUcKkzLNrQd+chb7MV0cj
	GDZxYgK3fYtsUI9ObSnaTYTvjTp9Yu7y2D5I/kPijYRE4nzYdJ9z4reNoaixSKqxyx9ZQRqvzmO
	lUZeKIRIGF3TfDZP945wG79GR3gRJqnY4rcYbujyUcuIrRmRkCdnGJgAseDTRS2EcCzyvV7m4Et
	VZf0XNIkjSJK+lDEjf//GZAj0ivIdajEBF5VSx7awiFvkbsqY7NqI
X-Received: by 2002:a05:6a00:a802:b0:81f:17b:c70f with SMTP id d2e1a72fcca58-8244166b774mr14884336b3a.29.1770795473427;
        Tue, 10 Feb 2026 23:37:53 -0800 (PST)
X-Received: by 2002:a05:6a00:a802:b0:81f:17b:c70f with SMTP id d2e1a72fcca58-8244166b774mr14884304b3a.29.1770795472845;
        Tue, 10 Feb 2026 23:37:52 -0800 (PST)
Received: from [10.217.199.117] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197d9ef2sm1080931a12.21.2026.02.10.23.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 23:37:52 -0800 (PST)
Message-ID: <17474333-bb82-49d7-bc04-45ab21095c38@oss.qualcomm.com>
Date: Wed, 11 Feb 2026 13:07:46 +0530
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
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <546faeda-d896-403c-a449-5c9b0cd7159e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KpNAGGWN c=1 sm=1 tr=0 ts=698c31d2 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=oZ-I6jP96QeCqEGTFp0A:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA2MSBTYWx0ZWRfX9u2NTT+2c1M4
 /1FNN2pmaL/ULzVKxwRm6qfMYgcHmYuLroWz5AEZwdjmOsxITyHAmnrI9LBDCbnc+HtbAqcBFVq
 TjjABezcjdb8TWDtXUtsaqZcw5DilECoPPk2vAaJX0Zca1YgJ0wCM4G/AhiUf3PpP6CH4kFazvj
 lUjYK13YusyvVEAUOTKrD5GSbC1uWi+A2jqZ0Wn6Pr/xPM98wx3ErPVvaCcVtSXPFKrliyhRuQk
 xYyDwPFwJ1WD1LWszLFko0ILOQM+qwfH/hR25zlDFCqRjLyps579GCa0g5r+G0eronrMlx0L8WG
 VuMPOsFRY84pewlcJcKn3iHOQn5IGmNHAVPVSWyOP7W2Pg4VMDoR8JFf8PeVasyT3E4fqPtq/DW
 5aZ9wocRT/O207iRG9tcWudfzXfqAOTE6iOEqoOfnm6Ph7qW4GmzxUQvrHi5DQVViKV6Kbc/zGK
 BnqgWa4icbG1alAc9Xg==
X-Proofpoint-GUID: DXOjPVbSkd-k6Vj1_Z_ybHlgITwICfih
X-Proofpoint-ORIG-GUID: DXOjPVbSkd-k6Vj1_Z_ybHlgITwICfih
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110061
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
	TAGGED_FROM(0.00)[bounces-42487-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,devicetree.org:url,2a300000:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gaurav.kohli@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_PROHIBIT(0.00)[1.145.78.96:email];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B7D12121E75
X-Rspamd-Action: no action



On 2/8/2026 3:36 PM, Krzysztof Kozlowski wrote:
> On 29/01/2026 13:06, Gaurav Kohli wrote:
>>
>> On 1/28/2026 4:57 PM, Krzysztof Kozlowski wrote:
>>> On Tue, Jan 27, 2026 at 09:27:16PM +0530, Gaurav Kohli wrote:
>>>> The cooling subnode of a remoteproc represents a client of the Thermal
>>>> Mitigation Device QMI service running on it. Each subnode of the cooling
>>>> node represents a single control exposed by the service.
>>>>
>>>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>>> ---
>>>>    .../bindings/remoteproc/qcom,pas-common.yaml  |  6 ++
>>>>    .../bindings/thermal/qcom,qmi-cooling.yaml    | 72 +++++++++++++++++++
>>>>    2 files changed, 78 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>>>> index 68c17bf18987..6a736161d5ae 100644
>>>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>>>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
>>>> @@ -80,6 +80,12 @@ properties:
>>>>          and devices related to the ADSP.
>>>>        unevaluatedProperties: false
>>>>    
>>>> +  cooling:
>>>> +    $ref: /schemas/thermal/qcom,qmi-cooling.yaml#
>>>> +    description:
>>>> +      Cooling subnode which represents the cooling devices exposed by the Modem.
>>> I do not see the reason why you need 3 (!!!) children here. Everything
>>> should be folded here.
>>
>>
>> Thanks Krzysztof for review.
>>
>> Each subsystem may support multiple thermal mitigation devices through
>> remote TMD service.
>>
>> Because of this multiplicity, introduced separate binding file.
> 
> This explains nothing. Subsystem does not matter for the binding. My
> comment stays.
> 

thanks for this suggestion, we will use qcom,pas-common.yaml to define 
bindings and avoid creating new file.

>>
>>>> +    unevaluatedProperties: false
>>>> +
>>>>    required:
>>>>      - clocks
>>>>      - clock-names
>>>> diff --git a/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml b/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
>>>> new file mode 100644
>>>> index 000000000000..0dd3bd84c176
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/thermal/qcom,qmi-cooling.yaml
>>>> @@ -0,0 +1,72 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/thermal/qcom,qmi-cooling.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Qualcomm QMI based thermal mitigation (TMD) cooling devices
>>>> +
>>>> +maintainers:
>>>> +  - Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>>> +
>>>> +description:
>>>> +  Qualcomm QMI-based TMD cooling devices are used to mitigate thermal conditions
>>>> +  across multiple remote subsystems. These devices operate based on junction
>>>> +  temperature sensors (TSENS) associated with thermal zones for each subsystem.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - qcom,qmi-cooling-cdsp
>>>> +      - qcom,qmi-cooling-cdsp1
>>> What are the differences between them?
>>
>>
>> Some SOcs support multiple CDSP/NSP instances. Each instance requires
>> it's own
>>
>> compatible string to distinguish.
> 
> Why? What are the differences?
> 
> I will not ask third time, but just respond with NAK.
> 

For Leman's, we have multiple NSP subsystem to support compute and each 
instance has it's own firmware and separate hardware like below for cdsp

Below data is from lemans.dtsi for cdsp subsystem:
-> remoteproc@26300000 {
->  remoteproc@2a300000 {

That's why, we have introduced different compatible to distinguish 
multiple instance, but we can also solve this with single compatible
with new dt property for each subsystem instance id. Please let us know 
if you are fine, we can use that.

>>
>>
>>> Why these are not SoC specific?
>>
>>
>> They are not soc specific because the qmi thermal mitigation interface
>> exposed by CDSP is architecturally
>>
>> identical across multiple SOCS.
> 
> I have doubts on that but anyway if you want exception from standard
> compatible rules you must come with arguments in terms of hardware and
> firmware. Above is not enough. Everyone claims that.
> 
>>
>>
>>>> +
>>>> +patternProperties:
>>>> +  "cdsp-tmd[0-9]*$":
>>>> +    type: object
>>> No, you do not need childnode. See writing bindings (covers exactly this
>>> case).
>>
>>
>> Each subsystem may support multiple thermal mitigation devices through
>> remote TMD service. So
>>
>> need childnode to distinguish for different mitigations.
> 
> NAK
> 

As each subsystem supports multiple cooling devices, So introduced
multiple child nodes for cooling binding in thermal zone.

> 
> 
> Best regards,
> Krzysztof


