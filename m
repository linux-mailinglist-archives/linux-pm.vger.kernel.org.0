Return-Path: <linux-pm+bounces-41753-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JKDGOxXfGn6LwIAu9opvQ
	(envelope-from <linux-pm+bounces-41753-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 08:04:12 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C20B7C30
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 08:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED9BB3012E96
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 07:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6B52FBE1D;
	Fri, 30 Jan 2026 07:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="If8ezSzl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RgjlAb8v"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A743F2F6935
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 07:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769756640; cv=none; b=eRpXoCg5bPiYrGjDVCHvizoyes7wlZkuQIZSDQzrw3rje45saaFS8ZlkQBkmF0LIj0wjgCFrKDiDIJVorjuxdDLahh7OHixvYMCFMIXg9ypzd5/IJZChJySBFWTUOw6W8faKnVzoTq6MVbzTfelP+OEEN7bOVdB+whlZ+P53vcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769756640; c=relaxed/simple;
	bh=85qwfsFCAztNi0YFiuPSb3IVyem+uphlWZ8XLNYAsuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b6sht04DIlbC1rMQjLVKx17wixpPeGzMvB4KU369+auwk/yciSoNud1XNsHTFwcUQ0MVPc2hOhrvqj3KNP1bF1hVS3g5FpA5fOb7XITc+d19LxGyDC2YK7oJvpQv4gcLey6T2kyM8PXRLqGjEefX2n78haW23Omv6BgBqeTfF3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=If8ezSzl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RgjlAb8v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60U52ZUX555316
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 07:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3F4T+IeKKJ2+B9uNR/SwtxkVQIyvpzTD34HVI9Mg+8s=; b=If8ezSzlfZA4SBBy
	rZU0Zyf63SlCcXV/tZky5ZbhwgQVPU+OypGPs/hLXnIUSJy42viYPwJvF9kwP7ua
	cay5Q+UMr1kfK/0Mwo0pa3cqSLd9VQw28GskSjQ/EcZ7UDdmiT/obsxO2cp5w3TQ
	3TdRpvBABOC267++jwyiMhj42hnYWI67RNAn8kge6vQ6MhtZ+wUbFrxHIjBoErpx
	dBl88e/BrOEO/Rhk5LDqW2KMeG6+FwSN0FL9yDTuSdBVGMZhuLp8sjAxxG8L2DE0
	Y0x5BVLfwEKCbNUo8FLHLS4fOJEQu53BoA8+RzGR9vCfTtp7/yMx3gcEX12rSWGX
	mKgFOg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0p59gatv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 07:03:57 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a79164b686so19849235ad.0
        for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 23:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769756636; x=1770361436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3F4T+IeKKJ2+B9uNR/SwtxkVQIyvpzTD34HVI9Mg+8s=;
        b=RgjlAb8v4Z/ztYu06HkIWULAMajfFhyV6taU9n26Wgv9kUMob5EaDCD6suQdQFqT/d
         +BlwVHJeLjcQXvYCoLd3MpXWJcLNHcQMTS+UWvw/qLFcVMtUGWV0fJy26yKSI1L/Pq32
         giPFMspCXXMYii5F6rKBwlbw2bRUVxrqsO1sZ+XTH7NtLG5mhCgvfEmku705AP/yk3Wn
         Nq89D2ifue/hmI+Le+rz1W+9Tj7WImQKm88Tjp+RYoy2V2H4O6jkTlrsnaBU9sTm49Nz
         rdkZsrtOeV9DHKP512cHm8nkjyR5tlh0vbDYRmcMNK6tXs4JS8rZl6pp7dGr1wPMhwdR
         mHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769756636; x=1770361436;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3F4T+IeKKJ2+B9uNR/SwtxkVQIyvpzTD34HVI9Mg+8s=;
        b=WfW5GRVCfruW1m8wRFtKVVPwV7sAZWC2lsryYyLw9KA8RldE0CXeqaYXO/QoX9EvvP
         dUBEiUe2y4VLYY5vey8Qnvw3VnwC4f0lMSvYo4mYX7ZYdV/FKR8TERmMLXM/XTtnV21X
         Bmj5+5XvxMtM9lNGjgwh/ToAoWJtqSnivndrSJYavW3/owZQDk7LWrAj68sQ9fb+syyx
         9+SiciouuoXJGEoCzNM9dso+7PllrTE2qH+8+aed+3/MLzJ1UY4xkPA3eYBb+O1aZJrm
         prfDfL+e5x35rLzUuA1fOkVE4D+OuZ8IqpEqrtQq3BLxAkWl4BESbPCxLnZMw79uN8GH
         6rIw==
X-Forwarded-Encrypted: i=1; AJvYcCW4OPUtEuYVC9xLfTlObmRnWD8btEuGXKSPD5Ak7yygAAasRXFdnJ08uIrE0TCCAep5sxLBcp3B5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwB/GQxYPB6qBRQ1YyLfJMEO7sers9E6bp56LBHLmwq4jkW7drV
	szxjrlm9r7Kdpn6+ZoYmPrUbCQuz9GUKRbXTZH88sFV68ZMXSrYzj4kXM2FrGVWHvybwZNC1ctL
	fT45fPc0ILFeMsXhErV2WOMe7rkNg9pVa/zPAzPqocGmHc9H8ZiPOliNZBZAbpg==
X-Gm-Gg: AZuq6aJITDHZKNQoXO+YIOSO71G7PqBMWCMFWQLC8qgkB5WB9SOtQaPnTY97ouxD48s
	U4S7QE+uVYMRgLJovzQMzCJou3DbvJWZ1lTuILHDIQWuTVMg6VKSzC05gwjRzBy0VWJ6Fr8c8sd
	fvDUfe9G3q9GUk30q2p/lI9+TT+PCbc20+R24gSa3uMlifRxpxC5ToLEhrDNJr+QrPrDdz2Iq6V
	hhP0dcRb0w48obsfjTFv+DsN6w+ESz7cIXp1WhYm2eH5+qfujNpUhOCNg2EUsT7ldIjxVQfVD1+
	sLWXrauMqclikAb1KojTHmoQf0602FVP+ZEPKcDnhgY2EKbNS6spEZvbRbtEu4ubfZ10TFsph4J
	wq88+vwgNwDlNzo8IcMdUldqkZX9rgSCcr/ur5s5P
X-Received: by 2002:a17:903:41cb:b0:2a3:1d78:7505 with SMTP id d9443c01a7336-2a8d9953170mr18327085ad.56.1769756635936;
        Thu, 29 Jan 2026 23:03:55 -0800 (PST)
X-Received: by 2002:a17:903:41cb:b0:2a3:1d78:7505 with SMTP id d9443c01a7336-2a8d9953170mr18326515ad.56.1769756635144;
        Thu, 29 Jan 2026 23:03:55 -0800 (PST)
Received: from [10.217.199.117] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eec76sm70715005ad.19.2026.01.29.23.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 23:03:54 -0800 (PST)
Message-ID: <c5ace95c-6ba1-4ce9-b461-82225a9fc576@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 12:33:48 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/8] remoteproc: qcom: probe all child devices
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
 <98397a59-8ef2-4202-ae41-015c895d6bce@oss.qualcomm.com>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <98397a59-8ef2-4202-ae41-015c895d6bce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: i-ztxywuhl820bf1ZIJN_Q2PwvkCaVnZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDA1MyBTYWx0ZWRfX9nB2/fkqJfIa
 Ix+Cn4ACcj7gEVX+ZLfN49SBFkWda1PaZ4HIzvmsJbBx3cG+1DhEWY2uRd2FRC7ey6WIQg8vO2w
 UzJRz4Hvw0a2m8J20z575tH9kwEzV6/VdZCwoWVZPkX1gowuV2eJbabCna20T3/LgDYcz8nBwQX
 lyziLQZz000C3F/SdIvJlQACu8gI9ztOHf5ZhohGrs1IG5oIO1X21m/alpxt1V6NHm1jYU/3DiL
 3MVjh4lfI5uQIrJyMonIUileXPkn1Te6oBlILnMYXMeBCU48XO3GuhbFK1gWYWzZCVWcLLDIhEW
 7CDwXVAlzZom8j5nPc2xwiDZ6j/DN4VolpClOz2WPFVE+DFciGgWIKGn/W/kDGzw0x8KuLAZn3I
 dqyYhCUOxUlFDsS1/hQ1Dj54do5z8ERnx9uQUXzUBQb79oCVI5k2xVqD2zIgqmeeEoqIPgC4JXc
 XPWYdXavanp9MVXi8nA==
X-Proofpoint-GUID: i-ztxywuhl820bf1ZIJN_Q2PwvkCaVnZ
X-Authority-Analysis: v=2.4 cv=Re+dyltv c=1 sm=1 tr=0 ts=697c57dd cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=j1b_eO6ZJhPIRq7GVskA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601300053
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
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41753-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,linaro.org:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gaurav.kohli@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B1C20B7C30
X-Rspamd-Action: no action


On 1/28/2026 3:15 PM, Konrad Dybcio wrote:
> On 1/28/26 10:39 AM, Gaurav Kohli wrote:
>> On 1/27/2026 10:11 PM, Dmitry Baryshkov wrote:
>>> On Tue, Jan 27, 2026 at 09:42:10PM +0530, Gaurav Kohli wrote:
>>>> On 1/24/2026 12:33 AM, Dmitry Baryshkov wrote:
>>>>> On Fri, Jan 23, 2026 at 07:23:39PM +0530, Gaurav Kohli wrote:
>>>>>> On 1/8/2026 12:37 PM, Gaurav Kohli wrote:
>>>>>>> On 1/3/2026 8:26 PM, Bjorn Andersson wrote:
>>>>>>>> On Tue, Dec 23, 2025 at 06:02:21PM +0530, Gaurav Kohli wrote:
>>>>>>>>> From: Casey Connolly <casey.connolly@linaro.org>
>>>>>>>>>
>>>>>>>>> Generalise the qcom,bam-dmux child node support by probing all
>>>>>>>>> remoteproc children with of_platform_populate(). This will be used to
>>>>>>>>> enable support for devices which are best represented as
>>>>>>>>> subnodes of the
>>>>>>>>> remoteproc, such as those representing QMI clients.
>>>>>>>> Please flip this around, start with the description of the problem
>>>>>>>> you're trying to solve.
>>>>>>>>
>>>>>>>>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>>>>>>>> This must have your signed-off-by, where you certifies the origin of
>>>>>>>> this patch.
>>>>>>>>
>>>>>>>>> ---
>>>>>>>>>      drivers/remoteproc/qcom_q6v5.c     | 4 ++++
>>>>>>>>>      drivers/remoteproc/qcom_q6v5_mss.c | 8 --------
>>>>>>>>>      2 files changed, 4 insertions(+), 8 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/remoteproc/qcom_q6v5.c
>>>>>>>>> b/drivers/remoteproc/qcom_q6v5.c
>>>>>>>>> index 58d5b85e58cd..a02839c7ed8c 100644
>>>>>>>>> --- a/drivers/remoteproc/qcom_q6v5.c
>>>>>>>>> +++ b/drivers/remoteproc/qcom_q6v5.c
>>>>>>>>> @@ -6,6 +6,7 @@
>>>>>>>>>       * Copyright (C) 2014 Sony Mobile Communications AB
>>>>>>>>>       * Copyright (c) 2012-2013, The Linux Foundation. All rights
>>>>>>>>> reserved.
>>>>>>>>>       */
>>>>>>>>> +#include <linux/of_platform.h>
>>>>>>>>>      #include <linux/kernel.h>
>>>>>>>>>      #include <linux/platform_device.h>
>>>>>>>>>      #include <linux/interconnect.h>
>>>>>>>>> @@ -351,6 +352,8 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5,
>>>>>>>>> struct platform_device *pdev,
>>>>>>>>>              return dev_err_probe(&pdev->dev, PTR_ERR(q6v5->path),
>>>>>>>>>                           "failed to acquire interconnect path\n");
>>>>>>>>>      +    of_platform_populate(q6v5->dev->of_node, NULL, NULL, q6v5->dev);
>>>>>>>> There are other child nodes here, in particular the GLINK and SMD edges.
>>>>>>>> Do we really want platform_devices registered for them?
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Bjorn
>>>>>>> thanks for pointing this, can you please suggest the right approach.
>>>>>>>
>>>>>>> This should not impact glink, as that is registering as rproc sub node,
>>>>>>> And we need rproc cooling as child node
>>>>>>>
>>>>>>> of remote proc subsytem to create probe dependency only.
>>>>>>>
>>>>>>>
>>>>>>> Can we do platform populate for specific child, would that be right
>>>>>>> approach. or we should create rproc cooling as independent of parent ?
>>>>>>>
>>>>>> HI Bjorn,
>>>>>>
>>>>>> I’d like to highlight the impact and details of placement of remoteproc
>>>>>> cooling dt node:
>>>>>>
>>>>>>
>>>>>> ->As a child of the remote proc subsystem node:
>>>>>>        In this configuration, the cooling device will only be probed once the
>>>>>> corresponding remote proc subsystem itself is probed.
>>>>>>
>>>>>> ->Outside the remote proc subsystem, may be part of soc node:
>>>>>>        In this setup, the cooling device will be probed independently. It will
>>>>>> wait until the remoteproc subsystem is brought up
>>>>>>        before completing cooling registration.
>>>>>>        The drawback here is that if the parent remoteproc subsystem is
>>>>>> disabled, the cooling device will still undergo an
>>>>>>        unnecessary probe, even though it cannot be registered.
>>>>> Bjorns question was different. It wasn't about pushing cooling device
>>>>> outside of the remoteproc node. It is about not registering the devices.
>>>>>
>>>>> Can we follow the approach outlined by qcom_add_smd_subdev() /
>>>>> qcom_add_glink_subdev()?
>>>> Hi Dmitry,
>>>>
>>>> Thanks for the review. Since the remoteproc cooling is a QMI-based driver,
>>>> it will receive the
>>>> subsystem up notification directly. Therefore, there’s no need to make it a
>>>> subdev node or
>>>> tie it into the init/reset sequence of remoteproc subsytem.
>>> But you've added a subnode for it (and we are discussing exactly
>>> of_platform_populate()) call. So, you are tying it to the remoteproc
>>> device lifecycle instead of the remoteproc subsys, which seems strange
>>> to me. There is no cooling device if the DSP is not running.
>>
>> For the cooling feature, we don’t need to define it as a subnode. The cooling subsystem becomes relevant only
>> after the remote subsystem is up, at which point it will receive add/delete notifications from the QMI server.
>>
>>
>> If child nodes must be modeled as subnodes for rproc, we can move the CDSP TMD out of the remoteproc and add in soc.
>> Is there currently a way for the remoteproc core layer to call of_platform_populate() without requiring a subnode?
> I think the question is "why can't you register the remoteproc device
> as a cooling_device, with perhaps #cooling-cells = <1>; instead of
> any form of children?"
>
> Konrad


thanks Konrad, for the review.

As each subsystem can expose multiple thermal mitigation devices via the 
remoteproc TMD service, so need to define child node.



