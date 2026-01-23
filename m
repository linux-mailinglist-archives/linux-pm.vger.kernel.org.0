Return-Path: <linux-pm+bounces-41376-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ZSFMHN9c2mQwwAAu9opvQ
	(envelope-from <linux-pm+bounces-41376-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 14:53:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F802767FF
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 14:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA25E301BCF0
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 13:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB212D838C;
	Fri, 23 Jan 2026 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AuRKHtxF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eNqTXmGf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABC12BF006
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769176432; cv=none; b=KUBfpdNFlY21TUnJyyd8FUUusCHZi+uAPs0u2qX4o7bFpfZSwktIjncn1aLH171HKV9LZAGDpkQma4JUEdh+G2hs3ZRb+iiK2ineRohMjNz/jU8n1twfuuocbyX2sT4896FbJ/rKCqfonsbrP2eyfopI1ZfoqBiGWdabjmGlvrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769176432; c=relaxed/simple;
	bh=ARsh7yVkaTjhfNXlQQNdqW8KzcgE7DBrjE6Oh4aiDDc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YZjL9pLUsgjsEP2HtiEE3gEoyvp80k4Yv8phtH+Ki/yEcO+CT7hnAf6eZkMrmQzUy1xLc7QB3ZZh6Dd9Gp6N6lrDAiQ/bkh5M2IWz5dEDM59ZnKkB90HigQ2NpZsjKcj3YTC8DU0iaDtAf+y6gjSgvy4JkQAIADm91gfxru3YFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AuRKHtxF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eNqTXmGf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60NDEH09324234
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 13:53:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xyk4VyTJvjXyVeGrau23wiL81EvwFDD9XQegtrqTgvc=; b=AuRKHtxFyw1rA19I
	a9dqHS41Gy6UonEBf5+cW03Z5w7f4/MstRkmP2YPrg3/cNFqCMY5W1QGsCg2HHGJ
	HwiYqeN/IExF2aO0y6eM8Hbo26EzXpAYavhv+xIUE5PHMEIMEt1Uc/sAV7aX9F8e
	qra1j/+qP0RYd1WBreCaiRrlH1vZRI+7YFqrFpxedrNE06PgmVbvVupjaboiSoTF
	zn4gjBQPnjNW15MY2B9+mvNCPUDmisCPFksd2TS0cHSxkMfEY4XZ6J0MV5KzZGyc
	wQ+SR2k8f4CdcFTZ8zQYtRMN2q5wtVTzqw8GgVUGSoGcgpF/Duy658rZ+DrNDQuH
	HLVtqg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bv3mq9j2x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 13:53:49 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-352e6fcd72dso3353153a91.3
        for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 05:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769176428; x=1769781228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xyk4VyTJvjXyVeGrau23wiL81EvwFDD9XQegtrqTgvc=;
        b=eNqTXmGfSKMK4ITO4A8Hk5r52Me4+aQn/Sj2C23LhhgVTV+Kd87oCI8sct6rP9EDuF
         88yeQ2DwP6JxjaeeOhvKWr3uBAC0x/Se1td8gb2C7hLNaVyP+7GvaAcebpAxcF5J8uDx
         gUTIvpYYST09zhlOYOJeLGTNXrFH/CsTGuUJQ/3dqVzxaLCJ5SXL6j2oEvK8McabC1N5
         W0COL1WdjqHChVkXeJMo3X7Bb3YZ3ZIpRh70i9wi8OBF8XerMhu/l+W9dCPI9LkPr0x4
         CmzVPMgK+VHLuE+003XcJ79icWiK8jL/40N/DYls+ATrUKIN4X8ynXaYh7jGqqSE6Dak
         gNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769176428; x=1769781228;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xyk4VyTJvjXyVeGrau23wiL81EvwFDD9XQegtrqTgvc=;
        b=igSOI2zDD4B8EnuaEZDQIiJfZtdddZVAx68rJns9afwSnX6izZrADdISZYIo8Cgysg
         thTHa8iZdXVNzz0UJrBLwWGvDIz6ICnBkh691aqhBxfpsbAbFV836IL7KzPkXpQnqmN/
         fYiEMxQ+HBKoVaeNO+qVfbKuxB/EgJxfwB3hKa32EuPoagLkipxDDxPpua9zmLPrNRsE
         +JcER86ZEdZ/9Onrqqq3N5dLbtfuJVOemrts6vlEejNq9Dul5oyDVEx97Sd5UL1M/oIu
         nsdh61j1TJd1M86eZhJBSeWtPrfqGwpPgCqBpp/h2ynJ6GYbK/dMYnF6oTmRrwsXFZXO
         Pbug==
X-Forwarded-Encrypted: i=1; AJvYcCU5AVR5hFCo1dorryjE7Hel2zntwTVObrXbrb+EqeLRJcM2HwVhuUMaFQGU9Xuy9SQJbKrJx2UM7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YykoVHMll7dO1lFw9qQbc2LofN40Mx2q7aA224AFYABMlRIiKHP
	sJRpNTMSNHdiWUXKXh/xLOTZADu55Zikob96VIeUMjp2Cd7aD4eWL3/yCE0SEM4WGk9OCqRG1p5
	sCG5ziOxKCZzozYLOugogTvZVz/xXFg9Kakh5Bjb+EtrdWxW2OtxaGF9pv6IJoQ==
X-Gm-Gg: AZuq6aKe0uPXH2jGUg3jbICpJk42gOAx2icYpu49tuv7VfGlsY/bQcA8QnoRilneRG2
	7X5cnutjUy9MN5oENHfMuPnWWbBCeon7eL1W93kyE1wnA74+Z+YwN52p6etXb08JmkIml8INbdm
	WxZ3xR7tBdSCeOAZSY2V8Pk10nlxSeQ2B3svfCORa0eQm6IczOYFEQE84sEUCiqvK82JdpZ3bmJ
	RDMmOMUuCw39Bj8gn3Q3GLxgH6doWafbZyF23pfz/9SqXW8jTdapZugOk0P5c7InbyE1i0rwE5j
	vDjMwdDMQudkFxCohVv9B2zRVApaon8iatW3ZmMSjZ3ETB/06IJ1ML7l9CC4r8s8HQGGRzFLlx6
	qqA8m4XicEHjdkJeTFZs2EX0sPhmpRXCFm7Ht4hT/
X-Received: by 2002:a17:90b:4d8b:b0:340:ca7d:936a with SMTP id 98e67ed59e1d1-353688574d3mr2599001a91.18.1769176428032;
        Fri, 23 Jan 2026 05:53:48 -0800 (PST)
X-Received: by 2002:a17:90b:4d8b:b0:340:ca7d:936a with SMTP id 98e67ed59e1d1-353688574d3mr2598963a91.18.1769176427551;
        Fri, 23 Jan 2026 05:53:47 -0800 (PST)
Received: from [192.168.1.22] ([106.222.229.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353352160a2sm5222874a91.7.2026.01.23.05.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 05:53:46 -0800 (PST)
Message-ID: <57493aef-fb35-4377-8cf3-1df7f53470c9@oss.qualcomm.com>
Date: Fri, 23 Jan 2026 19:23:39 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/8] remoteproc: qcom: probe all child devices
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: mathieu.poirier@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, lukasz.luba@arm.com, konradybcio@kernel.org,
        amitk@kernel.org, mani@kernel.org, casey.connolly@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20251223123227.1317244-1-gaurav.kohli@oss.qualcomm.com>
 <20251223123227.1317244-3-gaurav.kohli@oss.qualcomm.com>
 <evb5tn2cht7wk76fuc2wpsyxepknigfw37633n6ypuapstbceh@tn5glmi65bdv>
 <cb5430c8-12d6-4439-b1ae-c2f36f29a9f8@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <cb5430c8-12d6-4439-b1ae-c2f36f29a9f8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OfHdTvFjeoIVAAyP52yPoRgSSwMsh3VP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDExMyBTYWx0ZWRfX7C2kw9g7zLSj
 JaFZ7rTOMpkLBT916StzCChL11bT2/MJ1m/DCvVPkWDMZYwSzas1cpTReAn2r9EWUI8DdUaFz50
 duzp7Pq0DdbwSa5KE3Gj2B6MR2VD8zdJzwAwESPAmnuqw2mDoYOME7dA4hivb6fhDgOCy7i45EE
 3xdB76BOjAKr2TdYdV2gpc+ICemgsUk3+ye+0YFzbGLbh7uEecAGqY5ofRtz0akLLMsiOejD9sz
 hV1/YPsWfz+7Np2BFJSwbqavb89/hVJi8VCDfD9EBMYaNq0WuN+8vwe9fXImsUMsgcZYv0Et7zj
 msKYkn3U50QV5fzddW9jLBocus2J8vUDjxnuzJVeIWl0o74QsgN1jcKy27sr9awDTSFLiULBLPS
 Gbb65TlNf7z8JWJ+bqzoS37Ew49AkkUGhrY2ChBfRndOpOdpxFOYCnSJYQQT6+JTxHDcDIfIQ81
 WnUHNr1DmTmIN+Rq0DA==
X-Authority-Analysis: v=2.4 cv=SMpPlevH c=1 sm=1 tr=0 ts=69737d6d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=EBd7WcfsMYPMwvoCMWz0vA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=32UuRXtoL6AckyYbW_AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: OfHdTvFjeoIVAAyP52yPoRgSSwMsh3VP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601230113
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41376-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,linaro.org:email,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gaurav.kohli@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3F802767FF
X-Rspamd-Action: no action


On 1/8/2026 12:37 PM, Gaurav Kohli wrote:
>
> On 1/3/2026 8:26 PM, Bjorn Andersson wrote:
>> On Tue, Dec 23, 2025 at 06:02:21PM +0530, Gaurav Kohli wrote:
>>> From: Casey Connolly <casey.connolly@linaro.org>
>>>
>>> Generalise the qcom,bam-dmux child node support by probing all
>>> remoteproc children with of_platform_populate(). This will be used to
>>> enable support for devices which are best represented as subnodes of 
>>> the
>>> remoteproc, such as those representing QMI clients.
>> Please flip this around, start with the description of the problem
>> you're trying to solve.
>>
>>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>> This must have your signed-off-by, where you certifies the origin of
>> this patch.
>>
>>> ---
>>>   drivers/remoteproc/qcom_q6v5.c     | 4 ++++
>>>   drivers/remoteproc/qcom_q6v5_mss.c | 8 --------
>>>   2 files changed, 4 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/remoteproc/qcom_q6v5.c 
>>> b/drivers/remoteproc/qcom_q6v5.c
>>> index 58d5b85e58cd..a02839c7ed8c 100644
>>> --- a/drivers/remoteproc/qcom_q6v5.c
>>> +++ b/drivers/remoteproc/qcom_q6v5.c
>>> @@ -6,6 +6,7 @@
>>>    * Copyright (C) 2014 Sony Mobile Communications AB
>>>    * Copyright (c) 2012-2013, The Linux Foundation. All rights 
>>> reserved.
>>>    */
>>> +#include <linux/of_platform.h>
>>>   #include <linux/kernel.h>
>>>   #include <linux/platform_device.h>
>>>   #include <linux/interconnect.h>
>>> @@ -351,6 +352,8 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, 
>>> struct platform_device *pdev,
>>>           return dev_err_probe(&pdev->dev, PTR_ERR(q6v5->path),
>>>                        "failed to acquire interconnect path\n");
>>>   +    of_platform_populate(q6v5->dev->of_node, NULL, NULL, q6v5->dev);
>> There are other child nodes here, in particular the GLINK and SMD edges.
>> Do we really want platform_devices registered for them?
>>
>> Regards,
>> Bjorn
>
>
> thanks for pointing this, can you please suggest the right approach.
>
> This should not impact glink, as that is registering as rproc sub 
> node, And we need rproc cooling as child node
>
> of remote proc subsytem to create probe dependency only.
>
>
> Can we do platform populate for specific child, would that be right 
> approach. or we should create rproc cooling as independent of parent ?
>

HI Bjorn,

I’d like to highlight the impact and details of placement of remoteproc 
cooling dt node:


->As a child of the remote proc subsystem node:
     In this configuration, the cooling device will only be probed once 
the corresponding remote proc subsystem itself is probed.

->Outside the remote proc subsystem, may be part of soc node:
     In this setup, the cooling device will be probed independently. It 
will wait until the remoteproc subsystem is brought up
     before completing cooling registration.
     The drawback here is that if the parent remoteproc subsystem is 
disabled, the cooling device will still undergo an
     unnecessary probe, even though it cannot be registered.

>
>>> +
>>>       return 0;
>>>   }
>>>   EXPORT_SYMBOL_GPL(qcom_q6v5_init);
>>> @@ -361,6 +364,7 @@ EXPORT_SYMBOL_GPL(qcom_q6v5_init);
>>>    */
>>>   void qcom_q6v5_deinit(struct qcom_q6v5 *q6v5)
>>>   {
>>> +    of_platform_depopulate(q6v5->dev);
>>>       qmp_put(q6v5->qmp);
>>>   }
>>>   EXPORT_SYMBOL_GPL(qcom_q6v5_deinit);
>>> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c 
>>> b/drivers/remoteproc/qcom_q6v5_mss.c
>>> index 91940977ca89..d40565c1cc62 100644
>>> --- a/drivers/remoteproc/qcom_q6v5_mss.c
>>> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
>>> @@ -238,7 +238,6 @@ struct q6v5 {
>>>       struct qcom_rproc_pdm pdm_subdev;
>>>       struct qcom_rproc_ssr ssr_subdev;
>>>       struct qcom_sysmon *sysmon;
>>> -    struct platform_device *bam_dmux;
>>>       bool need_mem_protection;
>>>       bool has_alt_reset;
>>>       bool has_mba_logs;
>>> @@ -2029,7 +2028,6 @@ static int q6v5_alloc_memory_region(struct 
>>> q6v5 *qproc)
>>>   static int q6v5_probe(struct platform_device *pdev)
>>>   {
>>>       const struct rproc_hexagon_res *desc;
>>> -    struct device_node *node;
>>>       struct q6v5 *qproc;
>>>       struct rproc *rproc;
>>>       const char *mba_image;
>>> @@ -2163,10 +2161,6 @@ static int q6v5_probe(struct platform_device 
>>> *pdev)
>>>       if (ret)
>>>           goto remove_sysmon_subdev;
>>>   -    node = of_get_compatible_child(pdev->dev.of_node, 
>>> "qcom,bam-dmux");
>>> -    qproc->bam_dmux = of_platform_device_create(node, NULL, 
>>> &pdev->dev);
>>> -    of_node_put(node);
>>> -
>>>       return 0;
>>>     remove_sysmon_subdev:
>>> @@ -2186,8 +2180,6 @@ static void q6v5_remove(struct platform_device 
>>> *pdev)
>>>       struct q6v5 *qproc = platform_get_drvdata(pdev);
>>>       struct rproc *rproc = qproc->rproc;
>>>   -    if (qproc->bam_dmux)
>>> - of_platform_device_destroy(&qproc->bam_dmux->dev, NULL);
>>>       rproc_del(rproc);
>>>         qcom_q6v5_deinit(&qproc->q6v5);
>>> -- 
>>> 2.34.1
>>>

