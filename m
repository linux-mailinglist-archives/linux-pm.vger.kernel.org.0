Return-Path: <linux-pm+bounces-41597-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIh+HtDaeWkg0QEAu9opvQ
	(envelope-from <linux-pm+bounces-41597-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 10:45:52 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DC49EFB8
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 10:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2A33300E251
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 09:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34C534CFBB;
	Wed, 28 Jan 2026 09:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OVFaonOH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dYllvsff"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E4034A3C5
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 09:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769593549; cv=none; b=BxMWNY8263astTdmbBg6suO/3hAV1yA/9lnAVdHek5wEzcTf1kcwSyWVNWGK4xDDMZMg7GGN4tzBN1acq9qjVTEuDJp+F6nBzvyixURc15hOI0vajjyMaDfRLvmcb34XNsT+R9PdSr/RGykFVHxz9Dm4U84YsWaxRA+n/VanY1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769593549; c=relaxed/simple;
	bh=QnGDz/E5viip/7CHf2oehKFgbjBcJvjeICm9qPBUzJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=baPwvBcRu3fIBkdUlGPSQ+nScKjo8Jy5ooqC+z9b7FdyPTO8ZVyL0LR55Dm8XKD6bvKhcdWkByCQu9IiZl/wRcZs+AyUzY/OVDUlaqnC/ofucCUQo8EGjzH01IPyXlOpGFR5AsHmB2PxoyED1/IKoqhQ+nT/O9J0mKwcllJCITY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OVFaonOH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dYllvsff; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S927U3811587
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 09:45:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Aqf0hprgBFDDa2Buyyt0F0yoiDV5iMmIOZoHRFYFO+g=; b=OVFaonOHbkxaBkVh
	El9NZNkKsGsttzRJYJ5rktcQqx1O0IIfB9f3Nnv2CETfbe0wllqJJQfX8kNrNe2I
	YJp2Xda3c/mZzRSEGu4xA/wVaySRX/J8Zpe5nMxWtz9VPP6zbripvjqaS8A3/iqm
	+HUhhkHJud5m0/LfCuIhWRnF7KPR5wkh16L/B/rFnxBhzprvmXO+aYmHzLITH/Kb
	W1kD+LUrSeW4sjq44FWc1cKlGAK0w26QOYC6Aoqipbmqldah7M/2XBrT42W2hfwj
	MdGT7H3Iqkmk97lV5M1u5kmI4kGbi6U+FEOD8FsK4HeM622p6wGjTcl5J6CYCXmT
	75Px8w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by6qbhw6b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 09:45:46 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c70c91c8b0so51686385a.2
        for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 01:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769593546; x=1770198346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Aqf0hprgBFDDa2Buyyt0F0yoiDV5iMmIOZoHRFYFO+g=;
        b=dYllvsffuJ+agELLcCgr6sExLqafJa9/J+1gWh0znXmBFpQp5HA+fwvdA8xS8sr2a4
         p13jMzInhesoE3nNlSuodeFZN9Uv+bfqYVsRHabEzaKIspELmTiarmQCjx/1JJGzEQai
         Xb9a9KIN3/vdsdCPw62C//QxSgUppLxK3BRS65+QQhjysgY45TieF9AmTK73akGRWzXM
         o4AmCXo1ywQ4kCJVvepEGL01U6FhMZzTLoKpmxghghHd6cpRAbevw2bXxCEB+ZXnYv1u
         9McKsfkOI8ZSAFmb1MT2y5/OPlOhsFsUsszCwcIxNlIbOfO/G9MYzyVCjOPT6+gzz/BI
         qUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769593546; x=1770198346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aqf0hprgBFDDa2Buyyt0F0yoiDV5iMmIOZoHRFYFO+g=;
        b=DiGOm1j0Bmu3aHyAMhwBBmLOrQlTh6synXaYF0rgP0hQBg6Cljf+LJVvBklxJRLuZ0
         hWQuUaS1iR0QKgJfGiMdvM/bN71SLbuRAizQeSXLGnpLoztpvnkGZwwbpXIAlNXSG1sG
         LYvwee2HjNsSvVyiTAFoTHgfM6mrHsE3t5d2BN0rHU5KgMZZzQyHpplbT53CxTc757jq
         vmHsiUzuEx6NGpVST74CwSGZ6TfTS3UGt+uJYyOFBYPgOmP5Vv94xDTtCHEwsREt7r/x
         FqdOPlQ/Rgu2ICDUnF+TW7c7gE/7C8+WZ5N2ityy8MYWznaRoXL53oWvGEbFDRKKLMxw
         zU5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVn7aeqSeb/d+L9bb6k6HwekMVC150Ga+L3POa9GEq97UhTkf+SgaxonUN425f2RM4oTVWekyzLLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqsyPl0NETjV0NMOmrKTvt1STfCRgZTagCIcgu4JSLMDVhDgJ+
	/6tC0bxWg1xrCoeBUS7wbK+J+MTnN2Ls4Y5sU7xbzh4rUNqd/zF9qHa/Jhnu+3pWXbRiInTU9Yf
	owSrgzFMMStEavfrKcmxnqHOHvDj3oSGUWU5DQ8ZMhsEBFC1qF6J//spvgDkGcA==
X-Gm-Gg: AZuq6aKOvnExwQ8pdDNGLHV/jTdU3OBxCWAUfYJj5wuwwwnAIAIs/5TuzTF68kMx3hJ
	j6OEk7woVYb5olTUNxFqXAb9CUCE2xQcmnObd1fRz5AP3L2fmSsebzdhj5UnqW67jUspp4SBDth
	Zh0Nd7i22ClazWEtj47e1f4o9nREWHmM3bXuzQEzReaBiAw3cNvOU6stPrcpjCmlpO3JQampcbN
	3D3etWoow8/hT5jIlZ6YCPSegt7+yh2UJlKYqqf2RjiA1QNLZP0ZCaQU/kSVnrviqIYMuqjFxDu
	VzIfH2qW00imfzQcsUuvzmEnbGIROI1ASVFquWjpTwD3IFqitJtUh20KQpT0xmVERX8AIwp8isR
	x0Scp+bW787Z5EX3LDcJHy+oSyy8F3pRwq1BgbOKl3wcn49onza0BgahAzY3BG2dgaVo=
X-Received: by 2002:a05:620a:4109:b0:8c7:111e:9db6 with SMTP id af79cd13be357-8c714c00500mr104164785a.9.1769593546317;
        Wed, 28 Jan 2026 01:45:46 -0800 (PST)
X-Received: by 2002:a05:620a:4109:b0:8c7:111e:9db6 with SMTP id af79cd13be357-8c714c00500mr104163285a.9.1769593545847;
        Wed, 28 Jan 2026 01:45:45 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbef86957sm110464166b.5.2026.01.28.01.45.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 01:45:45 -0800 (PST)
Message-ID: <98397a59-8ef2-4202-ae41-015c895d6bce@oss.qualcomm.com>
Date: Wed, 28 Jan 2026 10:45:42 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/8] remoteproc: qcom: probe all child devices
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
 <ef1911f5-2d96-428c-93f1-3d1815710894@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ef1911f5-2d96-428c-93f1-3d1815710894@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: R_0JDAwqD9v4wDSet65yaTKpzMbIc6Ez
X-Authority-Analysis: v=2.4 cv=Z4Dh3XRA c=1 sm=1 tr=0 ts=6979daca cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=c06_8Dn6AeKgcUQ8PTcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: R_0JDAwqD9v4wDSet65yaTKpzMbIc6Ez
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA3OSBTYWx0ZWRfX5lvTsYHzpwm+
 q8pFBy3DK951n1A1yswqIq746K+DoSM7UQIqJ7a3054xoM2LXBAYtY9dRmeAQFCRpzC/HOzef5e
 9hxVwv+G0KnnoB4V5RrCuQjZ5rcilDStlz5fjSCx+YjeGCVXmUpuUaHAkD1ptsRCu92EOAPrDs9
 TqeZ/6vpeJoy7FmcfaMxTr0mDPNFzj3uO7mtRqIKGkxPHXfFOFRcQYXmqyQm6KnaxJBdgI8VkkT
 Qu4cBRqlbwjU4oCtj1OsYkFV134YO26HeFqJR/UU5N1wZVqVJvgXxpBuUzibK8PDfZaq7K+/iNz
 sTD2W3tLzzewjVLzAso7C3GM2vx9AhKvOX1sE6invwhlQ7hAI44Ln2U9X7B52u+6uml0ZN3vLdl
 jpdWcZnljr9tcYIFuD+LztG82bzA/4lXMHJ1YYBGv8GKcXiIevh8J6i/6wA7kWvqTPXFy+BpzB4
 WYYGuvgXMVKDHqFbTbg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_02,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601280079
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41597-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D9DC49EFB8
X-Rspamd-Action: no action

On 1/28/26 10:39 AM, Gaurav Kohli wrote:
> 
> On 1/27/2026 10:11 PM, Dmitry Baryshkov wrote:
>> On Tue, Jan 27, 2026 at 09:42:10PM +0530, Gaurav Kohli wrote:
>>> On 1/24/2026 12:33 AM, Dmitry Baryshkov wrote:
>>>> On Fri, Jan 23, 2026 at 07:23:39PM +0530, Gaurav Kohli wrote:
>>>>> On 1/8/2026 12:37 PM, Gaurav Kohli wrote:
>>>>>> On 1/3/2026 8:26 PM, Bjorn Andersson wrote:
>>>>>>> On Tue, Dec 23, 2025 at 06:02:21PM +0530, Gaurav Kohli wrote:
>>>>>>>> From: Casey Connolly <casey.connolly@linaro.org>
>>>>>>>>
>>>>>>>> Generalise the qcom,bam-dmux child node support by probing all
>>>>>>>> remoteproc children with of_platform_populate(). This will be used to
>>>>>>>> enable support for devices which are best represented as
>>>>>>>> subnodes of the
>>>>>>>> remoteproc, such as those representing QMI clients.
>>>>>>> Please flip this around, start with the description of the problem
>>>>>>> you're trying to solve.
>>>>>>>
>>>>>>>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>>>>>>> This must have your signed-off-by, where you certifies the origin of
>>>>>>> this patch.
>>>>>>>
>>>>>>>> ---
>>>>>>>>     drivers/remoteproc/qcom_q6v5.c     | 4 ++++
>>>>>>>>     drivers/remoteproc/qcom_q6v5_mss.c | 8 --------
>>>>>>>>     2 files changed, 4 insertions(+), 8 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/remoteproc/qcom_q6v5.c
>>>>>>>> b/drivers/remoteproc/qcom_q6v5.c
>>>>>>>> index 58d5b85e58cd..a02839c7ed8c 100644
>>>>>>>> --- a/drivers/remoteproc/qcom_q6v5.c
>>>>>>>> +++ b/drivers/remoteproc/qcom_q6v5.c
>>>>>>>> @@ -6,6 +6,7 @@
>>>>>>>>      * Copyright (C) 2014 Sony Mobile Communications AB
>>>>>>>>      * Copyright (c) 2012-2013, The Linux Foundation. All rights
>>>>>>>> reserved.
>>>>>>>>      */
>>>>>>>> +#include <linux/of_platform.h>
>>>>>>>>     #include <linux/kernel.h>
>>>>>>>>     #include <linux/platform_device.h>
>>>>>>>>     #include <linux/interconnect.h>
>>>>>>>> @@ -351,6 +352,8 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5,
>>>>>>>> struct platform_device *pdev,
>>>>>>>>             return dev_err_probe(&pdev->dev, PTR_ERR(q6v5->path),
>>>>>>>>                          "failed to acquire interconnect path\n");
>>>>>>>>     +    of_platform_populate(q6v5->dev->of_node, NULL, NULL, q6v5->dev);
>>>>>>> There are other child nodes here, in particular the GLINK and SMD edges.
>>>>>>> Do we really want platform_devices registered for them?
>>>>>>>
>>>>>>> Regards,
>>>>>>> Bjorn
>>>>>> thanks for pointing this, can you please suggest the right approach.
>>>>>>
>>>>>> This should not impact glink, as that is registering as rproc sub node,
>>>>>> And we need rproc cooling as child node
>>>>>>
>>>>>> of remote proc subsytem to create probe dependency only.
>>>>>>
>>>>>>
>>>>>> Can we do platform populate for specific child, would that be right
>>>>>> approach. or we should create rproc cooling as independent of parent ?
>>>>>>
>>>>> HI Bjorn,
>>>>>
>>>>> I’d like to highlight the impact and details of placement of remoteproc
>>>>> cooling dt node:
>>>>>
>>>>>
>>>>> ->As a child of the remote proc subsystem node:
>>>>>       In this configuration, the cooling device will only be probed once the
>>>>> corresponding remote proc subsystem itself is probed.
>>>>>
>>>>> ->Outside the remote proc subsystem, may be part of soc node:
>>>>>       In this setup, the cooling device will be probed independently. It will
>>>>> wait until the remoteproc subsystem is brought up
>>>>>       before completing cooling registration.
>>>>>       The drawback here is that if the parent remoteproc subsystem is
>>>>> disabled, the cooling device will still undergo an
>>>>>       unnecessary probe, even though it cannot be registered.
>>>> Bjorns question was different. It wasn't about pushing cooling device
>>>> outside of the remoteproc node. It is about not registering the devices.
>>>>
>>>> Can we follow the approach outlined by qcom_add_smd_subdev() /
>>>> qcom_add_glink_subdev()?
>>>
>>> Hi Dmitry,
>>>
>>> Thanks for the review. Since the remoteproc cooling is a QMI-based driver,
>>> it will receive the
>>> subsystem up notification directly. Therefore, there’s no need to make it a
>>> subdev node or
>>> tie it into the init/reset sequence of remoteproc subsytem.
>> But you've added a subnode for it (and we are discussing exactly
>> of_platform_populate()) call. So, you are tying it to the remoteproc
>> device lifecycle instead of the remoteproc subsys, which seems strange
>> to me. There is no cooling device if the DSP is not running.
> 
> 
> For the cooling feature, we don’t need to define it as a subnode. The cooling subsystem becomes relevant only
> after the remote subsystem is up, at which point it will receive add/delete notifications from the QMI server.
> 
> 
> If child nodes must be modeled as subnodes for rproc, we can move the CDSP TMD out of the remoteproc and add in soc.
> Is there currently a way for the remoteproc core layer to call of_platform_populate() without requiring a subnode?

I think the question is "why can't you register the remoteproc device
as a cooling_device, with perhaps #cooling-cells = <1>; instead of
any form of children?"

Konrad

