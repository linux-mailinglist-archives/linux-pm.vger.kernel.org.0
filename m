Return-Path: <linux-pm+bounces-42124-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJFyJMhghGng2gMAu9opvQ
	(envelope-from <linux-pm+bounces-42124-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 10:20:08 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 212BEF087E
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 10:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD68530FC75B
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 09:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9703136EABE;
	Thu,  5 Feb 2026 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ro54lUHF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eXRrle9I"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614D636EA97
	for <linux-pm@vger.kernel.org>; Thu,  5 Feb 2026 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770282077; cv=none; b=Z6lEXaLdX9sBsndmf/ikHxEKM6AMliLmNs/ZZSKd3Ik7EAsEu+ARJj17swCzbnkSzAamFFr1ZTpol7l/z9d7kscRgBfi1cHG08j2gOlXErkpDiIqBFxXaRML6ShoTM+LNZwV8lBVp2UKhdKJol6bUBmrQojSJveoLElht1oiyZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770282077; c=relaxed/simple;
	bh=Gkb8FKXpoDfkn/jUQYSvOOu7QYbZgcPt/PoChDyyk2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qlsiz29o4FiL/V3pKW39df9zaER2ay7wTgG4VZwWAcuBLP0vqUy+gPljdPk3VLroC6Up19njEbTLhsvq2xNpifJcEfC11FJbT9TYD70MNeKwFFtRDub1aSxJFDCTdlVdcO9YcFldQe+TuGXE+Jqb2CKaJSFAmenMdeBM7zVHGQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ro54lUHF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eXRrle9I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6153dmMl2759581
	for <linux-pm@vger.kernel.org>; Thu, 5 Feb 2026 09:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PJMVZFUE4KOxEnuiMJZ5bx2oMxAoaysvSaCQJCkpBCk=; b=Ro54lUHFe9GsPDIk
	hB70/hyU3CTrQtxbd5S9gt8Et0bA8STlbRVLW5wg1V4GtowAbzse10D7z809GZz5
	lkUZFRWjNoIDarrX7YoXQU8a/bIfIwORP3/8AqWxMxf3038LjuNen4fQYNH9/GJe
	M9gaqPdCB9P1noge9IrxKILatExFwicQfDFh6y2vCEJxDH1cBh66Y7/DKuSSqc2M
	PmNeC1R/oTKwl+CD4unc+95/TKCkjUQpUGFq5jAQ1zDdqmE+4/D0tdGa1v4aEpfT
	AfOZIGKZFtaG1sFMsK0G2fqoWJM7i3BEKWVQ8hxe8X3umB0wM2jHHjOmx76DZrpb
	xK4Tpw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c4jpd11pr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Feb 2026 09:01:16 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c533f07450so25065385a.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Feb 2026 01:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770282075; x=1770886875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PJMVZFUE4KOxEnuiMJZ5bx2oMxAoaysvSaCQJCkpBCk=;
        b=eXRrle9Ifsp7rKzldF4MzcMGtFxlFIQkUQ/cQIaaBRC+np5pfGof62MTJ17Zpytc2M
         Igq0wmGCiz7lrrNI19d3vJ/R4oJOnviEO1Zt2Fcf/p+zijt1MTOFcPlhS9WVnkYpENsq
         blRlO3bb2qcCKBdVITyQDpNPteeAPWHTb5QUrYBoE6KDFQFf2f73Y1IGvOc3PNTP305n
         V9H2w0quhr7Zoz/oaaJAtrwpXCKbrtvbnPbX51YoUjCaPi5gGUiKNvgxJcTfHXI6hFZm
         4VL1m/FB74B7ES6am4WOL6A8XU8pI5Nte5lt/kkfzaL1QJ2ZEIWyrsPokUh1SvMXa4C6
         ttpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770282075; x=1770886875;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PJMVZFUE4KOxEnuiMJZ5bx2oMxAoaysvSaCQJCkpBCk=;
        b=cWWlGEohbceJJoPcAi0w3H+OgUu33F/QBstlexK4RLtk55xF04f4QSLOVv9mzObOOk
         QK/BG3MBhy/KRsq2fd4pvq/l1qf9byYM/40Pw8flppn1LLs9mgrOSvURdJX95lLtaweM
         fnUHzEHlQvkzQwhawHh9VhOgjLOPfgCqPTHXz7ODve/4Gg7ab62hlOHNVC1zre+/hk5m
         61rckGfHVIcYvWLUmBgWBwChjD27z7/oeLagLm18KZ2cWFfWs8zIu+Y58uFxJkOpqGUi
         bTYoNnMOvFewMoeansct4fLseGUMCR49yz/E7npM5+GrCLVOCBxwQhMm9ONfEYfQsrJn
         k4WA==
X-Forwarded-Encrypted: i=1; AJvYcCUCNzoxUlJZj6qY/xPQNbrByesJ6jBQe3mMcsXZgLWha25x1w/JkskrtyeViFaa6hCnRL0ucYju2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt/gayFCAWLmqvC3099KSbWLO43w7jnKr1VAchiSUYRUrsUdoM
	/VL/BLZF/gxJlstAvmWSLiVngkpcFtX4s0OqUqAi85BiuI313ToFzN0OlJ6pWsozquwmbTBfX6c
	LwqwpHLy2G2yYQTglTdV1pjGwBH51w3/p5cP06sv+t8zMrXt1riNaGUOc7KM2Sg==
X-Gm-Gg: AZuq6aJxdAQGGPT8S0W+Mo4uIgTvSCcgEDlcwruZz+74xi+/gsk1o5wkfA0IAVm+Abw
	WSYekalAYo/HPTZ4p0P/G2FzAd+ycRgf8XpKVIW07z3Iy6HtVgKu7wUtMFm6YRWtHL+8Mfvq+cK
	OFA7mKIkKI72km2VY4B09Pp76OXh4LaNTKQEl8f526nKauOzimH/+jN5bNcdf+mU3hfTlAnohrK
	esKQR7pFOkswve9PfaT7xQuwYj0NPA+yXXn/5ogvX0AKmJblc1R2djNrfbzF69hlp+MDqXFb4Sk
	z6FnEJC48DqFNPxle2HFTt2bmb4kvm2Urd09MrnmEm43Mlcezisgs/t6zgwqmPDmC8Txs2rFt32
	8UeCx6ghQOj9RJW2huPJcehyvWif45DB213mR0tcHlqIb+dfUIczsQyoXKKtKmMAd3f4=
X-Received: by 2002:a05:620a:17a7:b0:8c6:ca3d:4e0a with SMTP id af79cd13be357-8ca2f83c150mr570394485a.3.1770282075520;
        Thu, 05 Feb 2026 01:01:15 -0800 (PST)
X-Received: by 2002:a05:620a:17a7:b0:8c6:ca3d:4e0a with SMTP id af79cd13be357-8ca2f83c150mr570389785a.3.1770282075007;
        Thu, 05 Feb 2026 01:01:15 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8ea004ff20sm206037366b.62.2026.02.05.01.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 01:01:14 -0800 (PST)
Message-ID: <ac26d960-5c05-4681-aefe-4827b74ef29e@oss.qualcomm.com>
Date: Thu, 5 Feb 2026 10:01:11 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: qcom,qcs615-rpmh: add
 clocks property to enable QoS
To: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
References: <20260202070534.1281652-1-odelu.kukatla@oss.qualcomm.com>
 <20260202070534.1281652-2-odelu.kukatla@oss.qualcomm.com>
 <b37e6569-61e9-4998-8fc0-603b83edfa2a@oss.qualcomm.com>
 <95d42fb7-2365-46a0-a995-c9cc51b17424@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <95d42fb7-2365-46a0-a995-c9cc51b17424@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA2NSBTYWx0ZWRfX21l76Q4TCjP6
 6Iqfh7OR2vcRGiZ/ddwL7VdH+QD0jpwGbCssVQJxhI1V1aMDlUZIhMPYsVz3eQfYtKdWM2B9QHl
 maLBN+dV/Rb/lovjaA6aHtdvINv5w6IJ3XtohGfLvGLcr46Rx48OxPMo232vB6ck1KqDMaJRUu6
 3LuFxMithAkH62DiXKEeQE6QcpaKKXy+8zfoNpM23QT2Zk4/Ri06FbvOYDiIGnu+Bqhwt4j3ZqW
 rqlGapHk41kUBkkmeBpXEDPuPRB5oE+ygtgDkC3eJetsf1P8WJV+BmWvzRKTrOZ/e097zzRn9rI
 Sz5jqotiJkfMrf9G8097AjrczIZkyb0mFM4IAKh4Qis2IaKD6ZtXinFgvcF3bSU0hmI7UKrDR8Y
 FKm0LUtbQ0hMVmBqYOwAM16mgHt3WC9YA5M6gOQLooHfxYkabRrE13SkRq5DnOu3+od5/vW01lQ
 DqA+KDMnPMCzsuc04nA==
X-Proofpoint-GUID: bM_AvR5mOBM1gMGwsFDX13dI0y1mkVFd
X-Authority-Analysis: v=2.4 cv=d7j4CBjE c=1 sm=1 tr=0 ts=69845c5c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=3aRxcYRQ6Dp4JYTzBNUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: bM_AvR5mOBM1gMGwsFDX13dI0y1mkVFd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_01,2026-02-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050065
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42124-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 212BEF087E
X-Rspamd-Action: no action

On 2/5/26 7:06 AM, Odelu Kukatla wrote:
> 
> 
> On 2/2/2026 4:33 PM, Konrad Dybcio wrote:
>> On 2/2/26 8:05 AM, Odelu Kukatla wrote:
>>> Aggre1-noc interconnect node on QCS615 has QoS registers located
>>> inside a block whose interface is clock-gated. For that node,
>>> driver must enable the corresponding clock(s) before accessing
>>> the registers. Add the 'clocks' property so the driver can obtain
>>> and enable the required clock(s).
>>>
>>> Only interconnects that have clock‑gated QoS register interface
>>> use this property; it is not applicable to all interconnect nodes.
>>>
>>> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
>>> ---

[...]

>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - qcom,qcs615-aggre1-noc
>>> +    then:
>>> +      properties:
>>> +        clocks:
>>> +          items:
>>> +            - description: aggre UFS PHY AXI clock
>>> +            - description: aggre USB2 SEC AXI clock
>>> +            - description: aggre USB3 PRIM AXI clock
>>
>> Should we also include the IPA clock here?
>>
> 
> Thanks for the review!
> 
> For QCS615, the IPA clock is already enabled by the bootloader (xBL) and
> kept on during the boot‑up stage. Because of this, we do not need to
> explicitly enable the IPA clock in the interconnect driver when
> accessing the QoS registers.

Would we need to re-enable it to re-program the hardware if say the
icc module is loaded after unused clk cleanup or after a cx collapse?

Konrad

