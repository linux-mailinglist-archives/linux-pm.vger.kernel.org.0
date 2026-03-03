Return-Path: <linux-pm+bounces-43501-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKG7FT/2pmmgawAAu9opvQ
	(envelope-from <linux-pm+bounces-43501-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 15:54:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C42951F1D90
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 15:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42B0830F9CDD
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 14:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF1E47DD54;
	Tue,  3 Mar 2026 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lEEOcZuV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XGsR4dcw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DDC3C1974
	for <linux-pm@vger.kernel.org>; Tue,  3 Mar 2026 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549441; cv=none; b=pAG60G7J1J0lM9fgAj34Zl44BsmmVcQkTZlUuMsx8Wey8Z5PBTiMe/2qdca5ODVc4LhpvJod8YkZ3/TSy3JbO7NVXPEfPo9tclghXi/5OahuyAZJAkYou42KlSvsXMczRT6TrYoGfFUL+N09h+flPSzh5Exzm4MrNpnPQL85aWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549441; c=relaxed/simple;
	bh=+m1oPPpqfWeAOO56f1hf4+JV6zoMk3IpH9UEKIQQVdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rgXrsWr8kx3noF9La2zUNKg2o2AS+kW+Jp/Tk/NM/LiowejnxproH6gmym2HJGOXpJ/tzVlE0vi4ze+m91wdVRVOf1qUCXEGpDagcY20C3ODQ5Goo6P/kSUgTiP/fQZub+qsbqMP0J6gRFxcD+crvglPR94SKi56Bpyf0WNqIjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lEEOcZuV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XGsR4dcw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6239n9oM2630110
	for <linux-pm@vger.kernel.org>; Tue, 3 Mar 2026 14:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NE8pe8ib8kQOsIUrUjRQdb4uB8crsnoEVqb4KHhRpHw=; b=lEEOcZuVmN8xb/uJ
	I+DvIulht3sRtrS3pGsyaeHRJi827gjdR2vD2PkHANwMxX7PXjRzOD/YkWxYAGkv
	UZ1ptaV5RuJ17xo8I3HCBk8Kg3XMqSU9bzg8fOnhnj9WwaaoVwmseip012zHZ3uL
	1urQ/QUsUvn7hRRtnwLoAAYObcH9ii2+/zxqCb5q0xeNfqDjSaKmMnS4OK1QsHeX
	wdVdwhOj3DH7p0PPPRezPDGIihJi8GjLt1x82lf0DDtFJAen5sHepvu4AuSLqqRO
	jM8tTnR1Ysrzw5oWTuYHouVfOvpySx+Wuv4541WClDtWnGNBotBJdROg5kM7y5KT
	j1BYBA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnhx5b71p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 14:50:39 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ae66ee7354so1041735ad.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2026 06:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772549438; x=1773154238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NE8pe8ib8kQOsIUrUjRQdb4uB8crsnoEVqb4KHhRpHw=;
        b=XGsR4dcwa2YemqJ+kA6bC6Ua+M0kxFZRDJLYs0VXMUvTCkesOw3GrguWqDYskA5gRC
         MaMmCaprkQywPUjSUtcdldHfuNBwjwzSAxGtwjg0ETrUjeW/CNYe/iQ3qWbI1yFI2IxO
         NRDnial+3tRaomZJNLmMFRTB/mCd0PA7INrg4m3/3Wtu8ZtXF5lu8ULkO0SmMsQsV4Ss
         F3TtwwIjUGE+X1kKh/LoI0Aaz/Ek586y9hV7rHzDzH9caFJqh6k1o5/tGmhWDdORpoue
         +Ikh5SH9sb0obIIZ7ZjMgAw9uHmaDVk1geHqeerpHH01jBpimI6csu0F0+4FKcZ3rDHq
         MGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772549438; x=1773154238;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NE8pe8ib8kQOsIUrUjRQdb4uB8crsnoEVqb4KHhRpHw=;
        b=eWZC7uXPH+waVquuqk3L9jTtHNaIN74YjHAALCUxySAD/eJMaj36a8w6amV1FwAYNX
         qFQUig9zG6zr9lEVc9ZixXMYEz1wJg8eya+BT9LNOxUHFHbC7yXmroQLDlxiShmZw8ko
         jPUEC6uX0k/HYDHjIb9bf86mrP2uBnjAVXaie/VLEf5LdnHveyvEwHm3VxVpV1HQxs7e
         tScXZ1HNpKptIm7jqnIowpot/vBh/RR1FvV0bjRYXfU+hzQMuMvJa27aqpd49hPbrunP
         N8FPqDJkEFj3KDamf9Av/g5QS4dI8KFMkiFBnq6426YNFNIfuD3PpuD+xfe3SEP8q30m
         MUDA==
X-Forwarded-Encrypted: i=1; AJvYcCXIKdckdO4G0xXz51TuhV0JxBXRHy5rQuWxoIFkS/LOVnKJahGrkDPfXvftwWJ7qG4AJrdo5ExzeA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh9mmT9FpbB37pyldVjMBQl9rpu6LaatvTvl1Ws6xjhquQhXbi
	pD2VqUrnRpppWOD1FNLRzuUV44GKl1D6n8zv+RtZZ/fTvPIMj0E99gOlbuxo1AY5mC+O8P6JVow
	IXgB2gPIPas0wFFttF5BUSE2SIZeu8YYPy3blFBpvWHbl2pIaYfJ3uE72anvaDQ==
X-Gm-Gg: ATEYQzyvo10CzVC1gxLm73+f0elw919NKEFYD6VAgucD0fJEOQ/LFFkLH9jgH7cb8tL
	8JtqmqCelzghCGkisozZs+Q5BIXEI6X+5SzrLMs4kyw6BTWVNJOUYXbTK9igUnmfmFdhLt6Nfek
	Lc7Ac+yJYn1CoXElrLuCjSDArHaC8vpk9NQK0yVcWG2bD/gj8/2IUOSSJe4csysotj8WXnd/3Lq
	2veEA8pYEnJy/CNpxXMQj+YbcDfMGhC6m98Yy4fbmNZNH7NDG7/fXNeIKqvKBtJhgQMAWWiVwbI
	pU6htDMNhgKjq0uM1V8rzIkgeSD59jnuJP7o3n+Rpc5Tuzm1EJDfCW1kFri7Ejax+agY3VsKcD4
	m6Td9QVdMsHEatOjccDnKO/yQX8BO9oVllDfzXI1cHkEizc2WUyI=
X-Received: by 2002:a17:902:ce8d:b0:2ae:55bd:1473 with SMTP id d9443c01a7336-2ae55bd1983mr61678465ad.31.1772549438150;
        Tue, 03 Mar 2026 06:50:38 -0800 (PST)
X-Received: by 2002:a17:902:ce8d:b0:2ae:55bd:1473 with SMTP id d9443c01a7336-2ae55bd1983mr61678135ad.31.1772549437633;
        Tue, 03 Mar 2026 06:50:37 -0800 (PST)
Received: from [192.168.1.5] ([122.179.39.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69f283sm170655295ad.49.2026.03.03.06.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 06:50:37 -0800 (PST)
Message-ID: <99b76cfa-389b-409f-bdc4-74a077108a07@oss.qualcomm.com>
Date: Tue, 3 Mar 2026 20:20:29 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: interconnect: qcom,qcs615-rpmh: add
 clocks property to enable QoS
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
References: <20260211091112.3285626-1-odelu.kukatla@oss.qualcomm.com>
 <20260211091112.3285626-2-odelu.kukatla@oss.qualcomm.com>
 <20260212-armored-kingfisher-of-admiration-bdef7c@quoll>
Content-Language: en-US
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
In-Reply-To: <20260212-armored-kingfisher-of-admiration-bdef7c@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDExOCBTYWx0ZWRfX3HQa4Gy4FXvD
 OzyI459TM3qvthrvhhnVOm+VcFZeHvMIXN7hwitI8Wklf6HH15UQsoXXftIaSjnw0DB4HJvBXGw
 iptYaW/dh7ZG6BoVLYw6kzqsSytCY0pLprXxUxBUS+xFMkrP7Yu3nILIrGvqr1db17xKJhENk4t
 FGweVB9egiwzgXHGvzzoPdONJ8TeVhbVDnGv7UJ+//qbHvKIgsP7XnMMWMGmNzqi4BBGC/tTW4Z
 xR7NYId0SKR5CpRjQDZSotFeAm8Vf8AyCGhE6s/wzZNZx44V+YPSptMdKhK6Ns3ezVK7gRgZ/zL
 x/Sun83XjVEfhgzhyzuyro8HXoem+5ZvRz9KmHXdOd0GzbZtjhnGXHUIipkqsOkX1vRMwSl/6m8
 x6sswYEVnqe1l9kV1YTgu1xRwUnHV+jEpftRLGDkK9rWSFCgfc+SsYm8RB+OdeNWcLi0RXrXAM3
 qdzKmvrl4NDBHBcxg1A==
X-Authority-Analysis: v=2.4 cv=T9CBjvKQ c=1 sm=1 tr=0 ts=69a6f53f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=U82GXnHrZkNfQIH0kmVtCQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=hh-M-2xEcZ6B0zPyQVMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: Tbmh4eYs1LulEfb2LxVQulY0zgM6_DIb
X-Proofpoint-ORIG-GUID: Tbmh4eYs1LulEfb2LxVQulY0zgM6_DIb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603030118
X-Rspamd-Queue-Id: C42951F1D90
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-43501-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[odelu.kukatla@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 2/12/2026 4:32 PM, Krzysztof Kozlowski wrote:
> On Wed, Feb 11, 2026 at 02:41:10PM +0530, Odelu Kukatla wrote:
>> Aggre1-noc interconnect node on QCS615 has QoS registers located
>> inside a block whose interface is clock-gated. For that node,
>> driver must enable the corresponding clock(s) before accessing
>> the registers. Add the 'clocks' property so the driver can obtain
>> and enable the required clock(s).
>>
>> Only interconnects that have clock‑gated QoS register interface
>> use this property; it is not applicable to all interconnect nodes.
>>
>> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
>> ---
>>  .../interconnect/qcom,qcs615-rpmh.yaml        | 46 +++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml
>> index e06404828824..42679deb4607 100644
>> --- a/Documentation/devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml
>> @@ -34,6 +34,10 @@ properties:
>>    reg:
>>      maxItems: 1
>>  
>> +  clocks:
>> +    minItems: 4
>> +    maxItems: 4
> 
> Define the clocks here please.
> 
>> +
>>  required:
>>    - compatible
>>  
>> @@ -53,6 +57,37 @@ allOf:
>>        required:
>>          - reg
>>  
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,qcs615-aggre1-noc
>> +    then:
>> +      properties:
>> +        clocks:
>> +          items:
>> +            - description: aggre UFS PHY AXI clock
>> +            - description: aggre USB2 SEC AXI clock
>> +            - description: aggre USB3 PRIM AXI clock
>> +            - description: RPMH CC IPA clock
> 
> And this entire "if" goes away... unless you already plan to correct other
> devices. If so, please correc them now.
> 

Hi Krzysztof,
Thanks for the review.

I will move the clocks definition to the top-level properties and remove
the specific if block for aggre1-noc as suggested.
Regarding the exclusion “if” block: I will keep it to align with your
recent fix for SA8775P (dt-bindings: interconnect: sa8775p: Fix
incorrectly added reg and clocks) where you enforced strict constraints.

My plan for v3 is to:
1.Define clocks at the top level.
2.Remove "if" block for aggre1-noc
3.Keep "if" block to explicitly disallow clocks for the nodes that do
not support them.

I will send v3 with these changes shortly.

Regards,
Odelu

> Best regards,
> Krzysztof
> 


