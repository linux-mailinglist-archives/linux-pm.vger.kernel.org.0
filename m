Return-Path: <linux-pm+bounces-41563-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBOYHpvkeGlftwEAu9opvQ
	(envelope-from <linux-pm+bounces-41563-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 17:15:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD60978D4
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 17:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78A203017C88
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 16:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C1D36072D;
	Tue, 27 Jan 2026 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GJAIbMUH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NhhxR+Ok"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B22835EDC8
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769530342; cv=none; b=WYU4oQn/tfuMObNwt5yiB9kUe8jnympbNGsy/q3y67Y1JYQ+IYNEiNYgYYDGFyg6r2lQiKVH5ma7MQ2wUCiV1t54zrnBxIDPILdmquVXorXimBiowslyxLfzVLTXoy2JEhjNbmCjObcqwN0vd9cthLFXY46f/28v7AMb1yMbp0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769530342; c=relaxed/simple;
	bh=oqoBow5D3lG837WMPctNSJeeKyxHDiuyOmPTM74O8P4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvk4n5pQ7kgnJLlNjiV7ZQyoxYHBA65TGy+JyxZth5+/KSpisv8414wyXz7bI05MqvQ5O6FS+tWApJ4kHjy5bUnqMEmiiQAKBgnXH3gCsTr1ftWFpfyWHbL/k9T/pzvpmg2P8TbKBmM9Vk62v2tARMmBIXQxTRj9Dk//cl3GWSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GJAIbMUH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NhhxR+Ok; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RA0Zw53857536
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 16:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+SEkQgEJt3XSj0HPB4DBICRq/bSP9m3nTqv1wEUO5dM=; b=GJAIbMUHFANji3ap
	dyADZWwk/CEa7ZGm9UCid41ymVZz4hGg4hfqBNB42fBmRdDjCIh5VNBUIb4ve0qs
	p3dTlTyDsZuys78RnhGekkxdY+8c6f6hoshS1MnaLtEUIZADDXbhvwluz6+8KCvO
	NmbA+mCHSWFpL6OThICAew5btI2UHhJxDTHWMre9fSdy6G2enoZGK7Q1/8OzIIV3
	HniesAz+JYlBTXi+Cvb5aFkzatkrlbOtNNPR9V9NDJU2tivTdy6XaeIgUYgZcvjo
	AZFUJXTvGVtX62C9uhnwqvbeFavPe+p9jA+f2gnH5ulAYXOaAwY2mXXPC+KqPhm+
	V/1vVw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxffs3cu4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 16:12:19 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a77040ede0so55623455ad.2
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 08:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769530338; x=1770135138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+SEkQgEJt3XSj0HPB4DBICRq/bSP9m3nTqv1wEUO5dM=;
        b=NhhxR+OkOrgzWu7z3y87J/LuwSmpA8A3Xkd3Pl+rSQhS/q1CTLpBATRqH1PX9Azpu3
         wF+TvmkxONkzbxjL4Vqq43q3+/yFOlFlrUWhBhjaD3gYWrwAJstMz+wPgY/40NPhW1PD
         lfzrlMhROQWU7o4DC9kZtBiQP4EzTSQDlIhP4UY+iQ+h0XDOkeP6C5AC/n/SjmkW2pQU
         FzqjbLN/cFWjO+WRqi1ZVlrggSx5AOlTL4vb5zDWtSX8DVe9V8oWr0izEF/DnwVSUUSg
         TbEjIUsBudoBUo8zm44c75eKiGFIQ4s+cfkhsKgPFrjUkshYZiFx7XznAU5jiiiWyF6r
         Eijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769530338; x=1770135138;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+SEkQgEJt3XSj0HPB4DBICRq/bSP9m3nTqv1wEUO5dM=;
        b=SCzG1Ww/b3Wv9pLTS/oM9Bu/6rIeCdSwmD7XEty8b6biGitJwIP7ht4RhiRAQYrtXm
         BVKRmFmOtnD4O6OsOEAa4gZsFhWI0/4S8kq7FDO+XtsllR652vpWYdgjsGhP5w1IBo31
         MQFwrS6X/CzZwhiXg36xFthzKf9M4HBHwjgKE1P4zSlBcOFQmbfLB77R7TiHfjO1ftdC
         JpDyehkfS/iQSyaj06FNCD6rXDIUtUXRaL2JKr+M/44omnSDvwranxUEv0u+08t/piD9
         X7ZLXcGT+ogVzL6XPMEmTXTlL4hGIh1d/790ryZCk8fGS8VUYCCUiAQPXqUYGIR9lL7V
         hi2w==
X-Forwarded-Encrypted: i=1; AJvYcCXej62cFPiiIi6+PcZspOmsbWmHuFmaRE2VBj6N/aNM27MXd57hP97yKB2wxJDeeOB3b/1Pwp1Ovw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgkqgtgZ4yPtnky7Qkt1ozDXOubxmX6a3Ptm+iVSZ8Sare9U+f
	HsAoNKOo4eHXrknjyq2bZqEo1N8NTab2xDCkElKbK+gBYf5x8bNg1OwsGrsw0RBXp56ESssO6d6
	J4KrTHLumOMzsbtUErhRulnrcqvPiyZMf9+2yfBmqst6fhlVEFo3i49gmtEERHw==
X-Gm-Gg: AZuq6aK7xM7xcwUlvImfVw9d2INYaAVkMnDczmpcj96VJ8Rfh9QMNNIqUYZeeomAI8A
	N70Dcp65srilg3v9QRpkOQ395lzrpkxSM06sFcedpmGxlEHYbvY7MSDlALOEHchRg5tuy4uQx9j
	laWO2oeB5vyzln5i4ouVljmNL6NAs8w8EVjLr9bRG4NrI+0pNYjGv9991HIBP7/khlbZQxFfA9u
	KhVV70DcSEeEATiT8WfcFTiydfSLfnv1yLh1wHVhpK0UQMtnlKFDAnRaYieHAwid6cqHzK92edF
	9AW6+JAnwa+aXXys3CVHmzF3lQdapzVLQVRk1XpCUvFuFNZbMSeaQ85Ppnnu7OHhPTRuioq0S/z
	B+tQFeY9FpfN4dvjbCcKJZmp6/dRneiE4cfZGKkU=
X-Received: by 2002:a17:902:dac4:b0:2a0:c5b8:24b0 with SMTP id d9443c01a7336-2a870dd56edmr28281685ad.46.1769530338397;
        Tue, 27 Jan 2026 08:12:18 -0800 (PST)
X-Received: by 2002:a17:902:dac4:b0:2a0:c5b8:24b0 with SMTP id d9443c01a7336-2a870dd56edmr28281295ad.46.1769530337793;
        Tue, 27 Jan 2026 08:12:17 -0800 (PST)
Received: from [192.168.1.6] ([106.222.229.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802f97f3asm123086095ad.59.2026.01.27.08.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 08:12:17 -0800 (PST)
Message-ID: <5db5dafd-3c1f-4844-b822-bbfe86b3eb4d@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 21:42:10 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/8] remoteproc: qcom: probe all child devices
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, mathieu.poirier@linaro.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, konradybcio@kernel.org, amitk@kernel.org,
        mani@kernel.org, casey.connolly@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
 <20251223123227.1317244-3-gaurav.kohli@oss.qualcomm.com>
 <evb5tn2cht7wk76fuc2wpsyxepknigfw37633n6ypuapstbceh@tn5glmi65bdv>
 <cb5430c8-12d6-4439-b1ae-c2f36f29a9f8@oss.qualcomm.com>
 <57493aef-fb35-4377-8cf3-1df7f53470c9@oss.qualcomm.com>
 <74h7r3vsig3csejax3eu3uk53mdiimg2hjx7ntmmfrwdai6s3j@eiztghclfcvt>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <74h7r3vsig3csejax3eu3uk53mdiimg2hjx7ntmmfrwdai6s3j@eiztghclfcvt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ulQrYhgvV586o9c3xKFQrvGI29A-sJ-G
X-Authority-Analysis: v=2.4 cv=YpcChoYX c=1 sm=1 tr=0 ts=6978e3e3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=EBd7WcfsMYPMwvoCMWz0vA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=2-K1YE3ZJe1EJHp8LXMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ulQrYhgvV586o9c3xKFQrvGI29A-sJ-G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEzMiBTYWx0ZWRfXzRoki+GLYyTl
 olcArgVyxM91LLVxEoyYxvHyAFfkVbh8EG5EpH4czuHnsh9Z2P53B7teaB/d3gBNuN98gRtDIN0
 1M1DAmCF6Zl8nFjLiB1XMM/c7CABs/4OLkGYf/KahUZYOMIdXz0392QN2iBbGv5GWMpXJxn/W2q
 9r8Phm4RThjHBtyLot+RT6jeAIgrDgj9BIxxlas3wXmYJDUTdeGF/GV79x7/tGvj0iY5wheCdH1
 GiliKJQ0YniMyXZ/Wol3sUSNHSDVS9k0Zq88CQTBIHvQtqCATNwqsuh7778CwTjLEAn2Mu2rJrG
 bRXtImaKOt1KKH2veSnW9zqf+mzHODBjaOn/OqMU7xyLPY1mw+ionOqpuOOBHipGDMM3D5GJLKf
 JMgxunb3O7Gsk+8q8LqH9MVIMpftfo/JSuHQSuRTsKM6n97SXKFeHBStB3XDfCeB+FdRmUZ2T3q
 mmeYv7yJWRpNNsYJ+Sw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270132
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41563-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gaurav.kohli@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5BD60978D4
X-Rspamd-Action: no action


On 1/24/2026 12:33 AM, Dmitry Baryshkov wrote:
> On Fri, Jan 23, 2026 at 07:23:39PM +0530, Gaurav Kohli wrote:
>> On 1/8/2026 12:37 PM, Gaurav Kohli wrote:
>>> On 1/3/2026 8:26 PM, Bjorn Andersson wrote:
>>>> On Tue, Dec 23, 2025 at 06:02:21PM +0530, Gaurav Kohli wrote:
>>>>> From: Casey Connolly <casey.connolly@linaro.org>
>>>>>
>>>>> Generalise the qcom,bam-dmux child node support by probing all
>>>>> remoteproc children with of_platform_populate(). This will be used to
>>>>> enable support for devices which are best represented as
>>>>> subnodes of the
>>>>> remoteproc, such as those representing QMI clients.
>>>> Please flip this around, start with the description of the problem
>>>> you're trying to solve.
>>>>
>>>>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>>>> This must have your signed-off-by, where you certifies the origin of
>>>> this patch.
>>>>
>>>>> ---
>>>>>    drivers/remoteproc/qcom_q6v5.c     | 4 ++++
>>>>>    drivers/remoteproc/qcom_q6v5_mss.c | 8 --------
>>>>>    2 files changed, 4 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/drivers/remoteproc/qcom_q6v5.c
>>>>> b/drivers/remoteproc/qcom_q6v5.c
>>>>> index 58d5b85e58cd..a02839c7ed8c 100644
>>>>> --- a/drivers/remoteproc/qcom_q6v5.c
>>>>> +++ b/drivers/remoteproc/qcom_q6v5.c
>>>>> @@ -6,6 +6,7 @@
>>>>>     * Copyright (C) 2014 Sony Mobile Communications AB
>>>>>     * Copyright (c) 2012-2013, The Linux Foundation. All rights
>>>>> reserved.
>>>>>     */
>>>>> +#include <linux/of_platform.h>
>>>>>    #include <linux/kernel.h>
>>>>>    #include <linux/platform_device.h>
>>>>>    #include <linux/interconnect.h>
>>>>> @@ -351,6 +352,8 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5,
>>>>> struct platform_device *pdev,
>>>>>            return dev_err_probe(&pdev->dev, PTR_ERR(q6v5->path),
>>>>>                         "failed to acquire interconnect path\n");
>>>>>    +    of_platform_populate(q6v5->dev->of_node, NULL, NULL, q6v5->dev);
>>>> There are other child nodes here, in particular the GLINK and SMD edges.
>>>> Do we really want platform_devices registered for them?
>>>>
>>>> Regards,
>>>> Bjorn
>>>
>>> thanks for pointing this, can you please suggest the right approach.
>>>
>>> This should not impact glink, as that is registering as rproc sub node,
>>> And we need rproc cooling as child node
>>>
>>> of remote proc subsytem to create probe dependency only.
>>>
>>>
>>> Can we do platform populate for specific child, would that be right
>>> approach. or we should create rproc cooling as independent of parent ?
>>>
>> HI Bjorn,
>>
>> I’d like to highlight the impact and details of placement of remoteproc
>> cooling dt node:
>>
>>
>> ->As a child of the remote proc subsystem node:
>>      In this configuration, the cooling device will only be probed once the
>> corresponding remote proc subsystem itself is probed.
>>
>> ->Outside the remote proc subsystem, may be part of soc node:
>>      In this setup, the cooling device will be probed independently. It will
>> wait until the remoteproc subsystem is brought up
>>      before completing cooling registration.
>>      The drawback here is that if the parent remoteproc subsystem is
>> disabled, the cooling device will still undergo an
>>      unnecessary probe, even though it cannot be registered.
> Bjorns question was different. It wasn't about pushing cooling device
> outside of the remoteproc node. It is about not registering the devices.
>
> Can we follow the approach outlined by qcom_add_smd_subdev() /
> qcom_add_glink_subdev()?


Hi Dmitry,

Thanks for the review. Since the remoteproc cooling is a QMI-based 
driver, it will receive the

subsystem up notification directly. Therefore, there’s no need to make 
it a subdev node or

tie it into the init/reset sequence of remoteproc subsytem.


>

