Return-Path: <linux-pm+bounces-42422-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBHZJjL9imlyPAAAu9opvQ
	(envelope-from <linux-pm+bounces-42422-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 10:41:06 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD0F119001
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 10:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51165303E3BB
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 09:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A09341674;
	Tue, 10 Feb 2026 09:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SabpRx8f";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SVb1rvDE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CA8341056
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 09:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770716454; cv=none; b=rBV4iZXcM5nN81MCOxA4MMsdF/JuBcwkdeqWIuUH1NOV/1A2YuWd9Bj9Czw82AYy1clne4+ETKHwRiTn2hUOvqEOjv0D4eeBrAt15dignob3CeB1zIO2sAh3OgegAeVYcCWIStIyH4auFVtcatyTDLITphdb9nY+fZPn0l+dr7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770716454; c=relaxed/simple;
	bh=IaFf8Z7TstwEdQwSe5OreMHuEwOc6UsGIJfofeXFebw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zl52qhA03z3J/FZ9cRw+T1Xzbd2fp4sd351Ysc9jYixuPbLv7O14obRTk51PjPpVsDWHhT0mfM5NL/G4ccST/UgpiZnjkquE3ufFsESWldt5Mixhy1UKVovP7YE/CRN5jHIC3kVzhg6XfevDdfH/pTMLcnVyyplQ7EddTFKoiaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SabpRx8f; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SVb1rvDE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A76sJ41151608
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 09:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7HX9D/rIEQoc/3ALF0SX5kf73GjJxX3M6evfAte1kZ8=; b=SabpRx8fkbC5VHGV
	8GnNuiXaflitNXdNWaVnuxJ7yBgFf4WRxvtf2/vwaWo0UugKQsHUj5HMiy4LxRXV
	GtTUdzDJo4NtKv22W9oTlVuW/wt8bKo65dDO8Dfw1JqZalmk4cz6GSE3r7PjYrqa
	TTr1qr21dfHeTEcTfNPJm6407/jk0Lb1f3VyXzwsUBRl45aoirgdDwc8k6Yk2XBn
	M3VymF7vQOESmBewf4E54G5XlJnWQdoyEq5K3xCyY8/NgenqCjzsLaURQkwuO+MF
	0FSAPEnruKnaeml7HEosYYgYMG08z43YxirmJz5cBS0JlTMMEa3ElMxHPnn/925O
	aGCmUg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c800j8jf4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 09:40:52 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82436a49592so2999462b3a.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Feb 2026 01:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770716451; x=1771321251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7HX9D/rIEQoc/3ALF0SX5kf73GjJxX3M6evfAte1kZ8=;
        b=SVb1rvDE7z2HR/mQRHujTScwN1CfBAcxC//HE3J6s2PxafO3lk7ScYwdCb39kQh0bo
         yGAVgiTJ+eq3p4kjPwAyEGJOSEF7WDsSaYECWAQ04D9/SCt+4qZouGgT63u2jJjn8sxN
         /ywcVkJKh6tBBWGVNXQF9wP8SajfD/KryqL3S95F+pY12HxCY7/UljIPu7Ft+339PKb0
         YLElC51vSQbV71AudtRIjRe8PjfS8aDwZOwUQNTjFvEjyixYgdcbpCPKRR9pRwfeNZRE
         7gsENL7PdiL4PKPmUzhVpWfO42YLJn2yZGRnn4dj9mq+Bn6Z763WdWT2xwi9h4TsMHwr
         SmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770716451; x=1771321251;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7HX9D/rIEQoc/3ALF0SX5kf73GjJxX3M6evfAte1kZ8=;
        b=jsv2JHY8Bh6xjDfWYUB/J6+aEGG6ZN0q2Y6VAWQw/uqCe1rcuV6mYhwqGi/egUl5f6
         zsWPLaMaqNxh5QYKmH8YeMeQpEUOQs8FTY70P2PxfyaX9Lw2Y9fFt2PbqzmfsEYWQ3py
         mZ7MzC/vbtsUttq3vTbD/IxbMtUzQfm56aKJAvD7ZT2wO3YNWe88/5caJFPRi94oBBd/
         Lnykhjpa+234Junx386YA2gURK4/cG/cXgOOEYq9FPndn/4oJ3VBUzkv31pyYvyzl+mh
         Xi5H6EBzg5sg05M8nliaX6awmlEpLf7ZgkLF9vo3n8ijjNjWoRwbH0tBOCzD+KkQuEBi
         QJRA==
X-Forwarded-Encrypted: i=1; AJvYcCWrwoW1xJGSp/7X6XSbicg00rCTvc4PUQA7B01fwgQzh8egznK/lqTbfP+1SGew2sRi26/k5II5og==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcLy0rR0oV1cOrdvirANzVp+1HYGndBIYhyA0kmpm3elvYNU8Q
	AKu06L1KemAPl86XEp46BDrRZWqWrcwb1mDITr/1ZAafLbAkQSld49aFLekHPIt9vaVD9armqYQ
	xJIip+LTkOUI35jbyylIZGFn+0BIFm6qI4qcWtFJmIXcS+FNzc/yQxiUfO11mZQ==
X-Gm-Gg: AZuq6aJ2VLidQxSXOpUHMn9R6CciXPFcoRlKunnftSoYyJdc5P4Nl0/bpKtRg9OXeIi
	JAFK9W++YuieccjgrJMmp7aAnPr031hxG0qoVsLGbq1To7zTxMQd9zP1u3gSxKBfyTFHpcBFFVi
	ayuROXbGmyzXOpcAQMjpN5ZYNoeMEwQfKhdlIJc+2/yKgLF7VKsK0muCTDS7sxE6Vg1oIF3M0GY
	jtM9A1K4ZWR5MohjUhUv/BUKsAUkO51oGUXfmdc2nnkerTdq1XdFrQbo5ON/hp8YY4X2UyZweNH
	nFaZyITXHvPOF0+V9TxHnG8of88pZmWwnbepchI8FYBfqAhuqv7sVxIGk7V/f82FL6MQxFUdPac
	8VXxwPSUzc4tW79sLzGs6t0CZN8kjjZCRzzlJ75HkncppTHB+XPXY6Q==
X-Received: by 2002:a05:6a00:2341:b0:7b9:8142:96f4 with SMTP id d2e1a72fcca58-824879b4c2amr1487373b3a.21.1770716451330;
        Tue, 10 Feb 2026 01:40:51 -0800 (PST)
X-Received: by 2002:a05:6a00:2341:b0:7b9:8142:96f4 with SMTP id d2e1a72fcca58-824879b4c2amr1487349b3a.21.1770716450825;
        Tue, 10 Feb 2026 01:40:50 -0800 (PST)
Received: from [10.217.216.195] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82441690235sm13508078b3a.18.2026.02.10.01.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 01:40:50 -0800 (PST)
Message-ID: <87985615-e8a7-4ded-b082-8d1cb91d49af@oss.qualcomm.com>
Date: Tue, 10 Feb 2026 15:10:45 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: qcom,qcs615-rpmh: add
 clocks property to enable QoS
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
References: <20260202070534.1281652-1-odelu.kukatla@oss.qualcomm.com>
 <20260202070534.1281652-2-odelu.kukatla@oss.qualcomm.com>
 <b37e6569-61e9-4998-8fc0-603b83edfa2a@oss.qualcomm.com>
 <95d42fb7-2365-46a0-a995-c9cc51b17424@oss.qualcomm.com>
 <ac26d960-5c05-4681-aefe-4827b74ef29e@oss.qualcomm.com>
 <a9c2f6e2-0185-4a1e-bed6-fd1f542b2367@oss.qualcomm.com>
 <luahjv66e2h6gvxygmy2syzvt4rmdzqlfig6um74ysfhidyztc@eu4whsehmm5q>
 <f694b267-ec02-4867-86a3-b63ff2d908ec@oss.qualcomm.com>
 <trcbrxphzbgldya5cau42irrsnu7wn5swffjyvm74z7emfcevg@muojwgpa6ln4>
Content-Language: en-US
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
In-Reply-To: <trcbrxphzbgldya5cau42irrsnu7wn5swffjyvm74z7emfcevg@muojwgpa6ln4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA4MCBTYWx0ZWRfX9ZvJWE+wYa/3
 HG9e+hRNSKchE/FOhFUsTJxeIDN5Fk63m6NPH0u38U8U29Xy2BXlgRqmZMqgI9TmAtXH+axYtNN
 IXZR/3RLMpxiRKLQvcZCinjLOpUltdo4UmPLc/aaoV2iFrQGt4t7D+VhMYjr72t5E1ZOwaBGDOd
 +bR1zFAZ3peY8SyQnEMBzv6aWpz4xXCruGAHMGeuGofec5afkJFGvbqWIRyNR7dS7ubnXVGp6ZU
 Rd0/Mt4VbUKMars24VPWesg1wNlNOYGHxnqAflR9xMcFZBd737W735ipeOKJS1LIf6SzET2AWZn
 QbCKjpGDO8qW+yNrhca4smB926aNK6dlhPGxBJHJYBpTDZbKKr1f6zfJNqiGXRS4BYp5pUr3wBl
 5vaZ/mZiCbKCJjfNoAc+lCJwZxkO2prmJOn9JJhl+JwDLw2dzEjdjkjs9QgqcODzrrCnHagQlxv
 mp8yirCmcAB7HQrngmA==
X-Proofpoint-GUID: 2MAHDbsvcinmTBNmMOrScubHX8YO7GdB
X-Proofpoint-ORIG-GUID: 2MAHDbsvcinmTBNmMOrScubHX8YO7GdB
X-Authority-Analysis: v=2.4 cv=b9u/I9Gx c=1 sm=1 tr=0 ts=698afd24 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=C88Ajdsh_gp41bVUDNUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100080
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42422-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[odelu.kukatla@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4DD0F119001
X-Rspamd-Action: no action



On 2/6/2026 12:21 PM, Dmitry Baryshkov wrote:
> On Fri, Feb 06, 2026 at 10:28:15AM +0530, Odelu Kukatla wrote:
>>
>>
>> On 2/5/2026 3:59 PM, Dmitry Baryshkov wrote:
>>> On Thu, Feb 05, 2026 at 03:10:31PM +0530, Odelu Kukatla wrote:
>>>>
>>>>
>>>> On 2/5/2026 2:31 PM, Konrad Dybcio wrote:
>>>>> On 2/5/26 7:06 AM, Odelu Kukatla wrote:
>>>>>>
>>>>>>
>>>>>> On 2/2/2026 4:33 PM, Konrad Dybcio wrote:
>>>>>>> On 2/2/26 8:05 AM, Odelu Kukatla wrote:
>>>>>>>> Aggre1-noc interconnect node on QCS615 has QoS registers located
>>>>>>>> inside a block whose interface is clock-gated. For that node,
>>>>>>>> driver must enable the corresponding clock(s) before accessing
>>>>>>>> the registers. Add the 'clocks' property so the driver can obtain
>>>>>>>> and enable the required clock(s).
>>>>>>>>
>>>>>>>> Only interconnects that have clock‑gated QoS register interface
>>>>>>>> use this property; it is not applicable to all interconnect nodes.
>>>>>>>>
>>>>>>>> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
>>>>>>>> ---
>>>>>
>>>>> [...]
>>>>>
>>>>>>>> +  - if:
>>>>>>>> +      properties:
>>>>>>>> +        compatible:
>>>>>>>> +          contains:
>>>>>>>> +            enum:
>>>>>>>> +              - qcom,qcs615-aggre1-noc
>>>>>>>> +    then:
>>>>>>>> +      properties:
>>>>>>>> +        clocks:
>>>>>>>> +          items:
>>>>>>>> +            - description: aggre UFS PHY AXI clock
>>>>>>>> +            - description: aggre USB2 SEC AXI clock
>>>>>>>> +            - description: aggre USB3 PRIM AXI clock
>>>>>>>
>>>>>>> Should we also include the IPA clock here?
>>>>>>>
>>>>>>
>>>>>> Thanks for the review!
>>>>>>
>>>>>> For QCS615, the IPA clock is already enabled by the bootloader (xBL) and
>>>>>> kept on during the boot‑up stage. Because of this, we do not need to
>>>>>> explicitly enable the IPA clock in the interconnect driver when
>>>>>> accessing the QoS registers.
>>>>>
>>>>> Would we need to re-enable it to re-program the hardware if say the
>>>>> icc module is loaded after unused clk cleanup or after a cx collapse?
>>>>>
>>>>
>>>> IPA clock is not managed by GCC clock controller driver, so
>>>> clk_disable_unused does not disable it.
>>>
>>> The clk_disable_unused is not limited to the GCC. The clock is managed
>>> by the clk-rpmh, so clk_disable_unused applies to it too. 
>>>
>>
>> clk_disable_unused()/clk_disable_unused_subtree() does not disable RPMh
>> managed clocks, so it does not apply to IPA clock.
> 
> You are describing the current behaviour of one OS. The DTS should be
> describing the hardware. Other platforms describe IPA clock used by the
> aggre NoC nodes.
> 

I will update the bindings and the device tree to include the IPA clock
for the Aggre1 NoC node to ensure the driver handles it correctly,
aligning with other platforms. I will send out V2 with these changes.

Thanks,
Odelu
>>
>>>> As a result, the icc provider
>>>> does not need to re enable an IPA clock for QoS access after unused clk
>>>> cleanup. And QCS615 does *not* support Cx collapse.
>>>
>>> Does lack of CX collapse apply to SM6150?
>>>
>>
>> SM6150, QCS615, and Talos are all names referring to the same underlying
>> SoC family.
> 
> Ack, I was making sure that lack of CX collapse isn't related to IoT vs
> mobile case.
> 


