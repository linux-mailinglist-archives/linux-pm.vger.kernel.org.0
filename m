Return-Path: <linux-pm+bounces-41596-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNtcJ0nZeWlI0AEAu9opvQ
	(envelope-from <linux-pm+bounces-41596-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 10:39:21 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1579EE89
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 10:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99B9A3006203
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 09:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6B9347BA5;
	Wed, 28 Jan 2026 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SAqH+zfX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ENMpB49o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DD532BF43
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 09:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769593155; cv=none; b=jjgqEjg2B2gEFA6J4FqKg4JDk2njwso8fGHltA3mPIpUwqNNW1S54ftk2sJZxW4T8Yf75aizDnCYrCmgQIZgkYQGkkvPOxj6NNjotrPCWAGbm4o3h/BeKuzB3crnBcSd/xyXSLFWvecPohXWrhjoeU1fi3umFKtEPKg4hBluu7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769593155; c=relaxed/simple;
	bh=K5ZEN/duoiXPG9bzPnaDmslMimyxgixMi1nt9Q3UDOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UDrmF7PJ9xXTBSGoFr9Gy74x08HK/BsRs/8N98DFXlmuyKd1CVgySBoq9TzM0Pl9kGBs095hvojUz46cQTFL5mWmknf64HUrFEg1Eh+CQfA2l2mLqg7NxxbWQHYlBdJqU2QufibOtTVJr0NfLlFMow0u3ED/NErtauCLwd9faqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SAqH+zfX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ENMpB49o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S92Dt03387376
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 09:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Nm5vNdqRfLEBF55FPQ1/gDCsJCzH9FYWFBL/2AtZOhg=; b=SAqH+zfXwKuoA27Q
	u//MjSCjUME9pePPqosMKO2u/QcUUQfXvimi7Tf8PYIwdRfVGaRK6WGlW7SWShFY
	xIi1XDmGJ9NUz6pjL0SMbyqcHivCMFB00WbFm1Set/cK1LqpTNlRxAa6TgNA8vLh
	Fmewby0sf5vorVd+9OfYLWs522rvh/a8aX1Cza0srJBQOECqzwC4UEbufjaEDXG3
	5kT/4shwmv9BzrauhekkpdWz/qKAxGaP0kWspuONws2QiLzbtZRwbPmoW3NbplJz
	j3BEMpDRuhOnMHgobeudlFerCirZG6zPXEePnq5nuoi0i1gqwQjPdEb7v7LNFvE5
	vydPag==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by1dftwd3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 09:39:12 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-352c79abf36so5631811a91.2
        for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 01:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769593151; x=1770197951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nm5vNdqRfLEBF55FPQ1/gDCsJCzH9FYWFBL/2AtZOhg=;
        b=ENMpB49oEzzWXQToLrqVYkon3wEs5qCUtkkR4gqldVy61w2atTmaXzNmxPB1axaqjL
         3Aivv23raJ7GiQsSUESHNxthem7DmYk4cXB43MkswYKboC3eSLqBazHNd8KrFkpnY2hN
         GtpXqUnoICorWu30IaV2UrZb07xeMcLV4Guw+lwN0vLW7lefMsmDniqn9NPwMXQvBDJ5
         RTW6fA1lj+h2YN3xotWKYz6C/XALmGJNr9q7V3jML81VhoHLgzR1YjHXrvzkOOGL2W4a
         T308z34t5I8k1QeVnoWODeyyuHhRY4TGJc0Ucjps2KkiBBguiowXk8hejJzPls1uccCw
         0JqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769593151; x=1770197951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nm5vNdqRfLEBF55FPQ1/gDCsJCzH9FYWFBL/2AtZOhg=;
        b=aJXFvrlRWueXLWTfs3YNtPquOaEhGTfpss3+2TIjlqbwMkB2ljacabqjYNEPWy1EX1
         exf6NYhymSHdVIsBYsGOP2E2jVvJWXJt0sHw9mDpvdHVpZ8GgQyTTXJzInMMf38yIq1Y
         /SoJZebI4m8uRHUqN5kAhLDCXmjjA9h6RVX22Ud6F5r9B7I4Z7yvTZ8jOp4IdSZDx8Q2
         M+uHYRZMC0UFAssQ5XOxPEh4WkAXiRPJuOVeGgnHQ0yi79xj7q2Eeq+7eTLDg1Hg0gD2
         0y7rede4/Pc8VZ0vRg3eaV6S45pRPsmY4W8wXPoj9r/eXz19IXiu6ZgcXnJfJB6CBdHT
         aALw==
X-Forwarded-Encrypted: i=1; AJvYcCXCbVPbKwMevAbRatOrrALt0ctsxdAzx3SkD5XOteyBMPPxe83SwfYPF7XWZUwVdBGutxcqFl7bKw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0iaI+VlIobcTkD6Tpr0i5xwkauzYW1iIOEU6WFLidv8mvRGkH
	4NNi2QHmU1UOfgpggOKRdAstlzqxFHvAp6zNlad3xMq5/3h1KR3TRRFpjLGZXp1q2yVlWR0j0M2
	US851CdJOFJjH6eh8EUK4tHB5XHqiSShgQo2xmxhZefcY2w9KhPTj56AT5iNVRA==
X-Gm-Gg: AZuq6aLBWC193b+i11XlIPG864bPR4MVdHdhRCI80nqrEcvGdxEXdh8uT/qRhTxAkI0
	AM+02m4dcDrU4Ge9pfNWZIIUXrdeJR8uu4e8+gaOMbdSYdDqGzny4Wj/zQElDO+fZxW/H995wjH
	vACyYYK8NStr8QuFjcj800vlZKs505Zzik2dWnuiY1opKxwdk/4rfrjfBrYEVD3PnXpb9Y1OiFy
	d0Oht0EOgtwSZmhEaBEP7/3nmWpSahEujL9wrTOGqFIHwc/EmarxtQjlCpAqIUa+BGYWpQRy7P0
	8ZteYFSSv8G+BwJd8p+m8hdY5QNH3JcyPGbyXE2d3oLzlilRA+gwZNJjM+FvlObMfnC9r2iE+G4
	MVo38+FIv2nY73LU0xfk8XHESMvU6W6zF/4a7UbE=
X-Received: by 2002:a17:90a:dfc4:b0:341:88d5:a74e with SMTP id 98e67ed59e1d1-353fed87bf8mr4407357a91.29.1769593151260;
        Wed, 28 Jan 2026 01:39:11 -0800 (PST)
X-Received: by 2002:a17:90a:dfc4:b0:341:88d5:a74e with SMTP id 98e67ed59e1d1-353fed87bf8mr4407331a91.29.1769593150691;
        Wed, 28 Jan 2026 01:39:10 -0800 (PST)
Received: from [10.218.12.237] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f61e0007sm5012246a91.12.2026.01.28.01.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 01:39:10 -0800 (PST)
Message-ID: <ef1911f5-2d96-428c-93f1-3d1815710894@oss.qualcomm.com>
Date: Wed, 28 Jan 2026 15:09:02 +0530
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
 <5db5dafd-3c1f-4844-b822-bbfe86b3eb4d@oss.qualcomm.com>
 <ctrpymbvjlchp3djnsqq4bghkq2zvqnf5bebszi74f3d36l5dv@icvnkdwgdxmi>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <ctrpymbvjlchp3djnsqq4bghkq2zvqnf5bebszi74f3d36l5dv@icvnkdwgdxmi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA3NyBTYWx0ZWRfXzNfDCF4B5COp
 aJW+sJKwXY7ClpPJRx2KOPd+DflM60PJeEEjDF7AgXw9TpAYqv1iHEpYoUwZFc2bC/4Nfzqt2x1
 7UjxrxxNLF+4L1vruiSOK2SF3XOGX30imNYeq68DhbG14PJEPxLjILxorivwC7oHqH+7mZQ8TIt
 F5QHMArwbJF4Ivq46lBDyOu7EZBT2RI/6240c+juTvbfYQ4tHbcC2vMpL+MCvfO9wdFtMAbdluA
 7Ww+Fsy92uCVw9Tc3J9iqAmJO3cGAMHzbO+3a+Ti6P1jHolHzwNGMKLPH3J+jDQdMRWBR98XDFM
 I/Z80mo8UfUoalp+AjlqF034ZelljWY6t9Q8LtCbLU5deCOy4sLOs7jOrwyRK8zB47QQnu2NtV8
 or7ilOVE1IoG9oOfwoBfYd+x58lvLs9Tfc2tD6pTzG5GEgCpDqSTit0HCCrdxI3322mLgdEAPLB
 FMmx12NJqJwfjXipJzg==
X-Proofpoint-GUID: -FyVOGKooFyVoV9N60ntVvPp9HzMsgO7
X-Proofpoint-ORIG-GUID: -FyVOGKooFyVoV9N60ntVvPp9HzMsgO7
X-Authority-Analysis: v=2.4 cv=YeuwJgRf c=1 sm=1 tr=0 ts=6979d940 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=PKciL30m5ai67S71p9gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_02,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601280077
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-41596-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gaurav.kohli@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DA1579EE89
X-Rspamd-Action: no action


On 1/27/2026 10:11 PM, Dmitry Baryshkov wrote:
> On Tue, Jan 27, 2026 at 09:42:10PM +0530, Gaurav Kohli wrote:
>> On 1/24/2026 12:33 AM, Dmitry Baryshkov wrote:
>>> On Fri, Jan 23, 2026 at 07:23:39PM +0530, Gaurav Kohli wrote:
>>>> On 1/8/2026 12:37 PM, Gaurav Kohli wrote:
>>>>> On 1/3/2026 8:26 PM, Bjorn Andersson wrote:
>>>>>> On Tue, Dec 23, 2025 at 06:02:21PM +0530, Gaurav Kohli wrote:
>>>>>>> From: Casey Connolly <casey.connolly@linaro.org>
>>>>>>>
>>>>>>> Generalise the qcom,bam-dmux child node support by probing all
>>>>>>> remoteproc children with of_platform_populate(). This will be used to
>>>>>>> enable support for devices which are best represented as
>>>>>>> subnodes of the
>>>>>>> remoteproc, such as those representing QMI clients.
>>>>>> Please flip this around, start with the description of the problem
>>>>>> you're trying to solve.
>>>>>>
>>>>>>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>>>>>> This must have your signed-off-by, where you certifies the origin of
>>>>>> this patch.
>>>>>>
>>>>>>> ---
>>>>>>>     drivers/remoteproc/qcom_q6v5.c     | 4 ++++
>>>>>>>     drivers/remoteproc/qcom_q6v5_mss.c | 8 --------
>>>>>>>     2 files changed, 4 insertions(+), 8 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/remoteproc/qcom_q6v5.c
>>>>>>> b/drivers/remoteproc/qcom_q6v5.c
>>>>>>> index 58d5b85e58cd..a02839c7ed8c 100644
>>>>>>> --- a/drivers/remoteproc/qcom_q6v5.c
>>>>>>> +++ b/drivers/remoteproc/qcom_q6v5.c
>>>>>>> @@ -6,6 +6,7 @@
>>>>>>>      * Copyright (C) 2014 Sony Mobile Communications AB
>>>>>>>      * Copyright (c) 2012-2013, The Linux Foundation. All rights
>>>>>>> reserved.
>>>>>>>      */
>>>>>>> +#include <linux/of_platform.h>
>>>>>>>     #include <linux/kernel.h>
>>>>>>>     #include <linux/platform_device.h>
>>>>>>>     #include <linux/interconnect.h>
>>>>>>> @@ -351,6 +352,8 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5,
>>>>>>> struct platform_device *pdev,
>>>>>>>             return dev_err_probe(&pdev->dev, PTR_ERR(q6v5->path),
>>>>>>>                          "failed to acquire interconnect path\n");
>>>>>>>     +    of_platform_populate(q6v5->dev->of_node, NULL, NULL, q6v5->dev);
>>>>>> There are other child nodes here, in particular the GLINK and SMD edges.
>>>>>> Do we really want platform_devices registered for them?
>>>>>>
>>>>>> Regards,
>>>>>> Bjorn
>>>>> thanks for pointing this, can you please suggest the right approach.
>>>>>
>>>>> This should not impact glink, as that is registering as rproc sub node,
>>>>> And we need rproc cooling as child node
>>>>>
>>>>> of remote proc subsytem to create probe dependency only.
>>>>>
>>>>>
>>>>> Can we do platform populate for specific child, would that be right
>>>>> approach. or we should create rproc cooling as independent of parent ?
>>>>>
>>>> HI Bjorn,
>>>>
>>>> I’d like to highlight the impact and details of placement of remoteproc
>>>> cooling dt node:
>>>>
>>>>
>>>> ->As a child of the remote proc subsystem node:
>>>>       In this configuration, the cooling device will only be probed once the
>>>> corresponding remote proc subsystem itself is probed.
>>>>
>>>> ->Outside the remote proc subsystem, may be part of soc node:
>>>>       In this setup, the cooling device will be probed independently. It will
>>>> wait until the remoteproc subsystem is brought up
>>>>       before completing cooling registration.
>>>>       The drawback here is that if the parent remoteproc subsystem is
>>>> disabled, the cooling device will still undergo an
>>>>       unnecessary probe, even though it cannot be registered.
>>> Bjorns question was different. It wasn't about pushing cooling device
>>> outside of the remoteproc node. It is about not registering the devices.
>>>
>>> Can we follow the approach outlined by qcom_add_smd_subdev() /
>>> qcom_add_glink_subdev()?
>>
>> Hi Dmitry,
>>
>> Thanks for the review. Since the remoteproc cooling is a QMI-based driver,
>> it will receive the
>> subsystem up notification directly. Therefore, there’s no need to make it a
>> subdev node or
>> tie it into the init/reset sequence of remoteproc subsytem.
> But you've added a subnode for it (and we are discussing exactly
> of_platform_populate()) call. So, you are tying it to the remoteproc
> device lifecycle instead of the remoteproc subsys, which seems strange
> to me. There is no cooling device if the DSP is not running.


For the cooling feature, we don’t need to define it as a subnode. The 
cooling subsystem becomes relevant only
after the remote subsystem is up, at which point it will receive 
add/delete notifications from the QMI server.


If child nodes must be modeled as subnodes for rproc, we can move the 
CDSP TMD out of the remoteproc and add in soc.
Is there currently a way for the remoteproc core layer to call 
of_platform_populate() without requiring a subnode?



