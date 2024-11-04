Return-Path: <linux-pm+bounces-16963-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 846269BB75F
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 15:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7A691C235BB
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 14:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0A71494B1;
	Mon,  4 Nov 2024 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZFl3mqvP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8171442F2
	for <linux-pm@vger.kernel.org>; Mon,  4 Nov 2024 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729893; cv=none; b=Q9dYiZAZaSVH8VULbTrr6RutWBQESxFV+SlYwW6rm3Qv4VTk+VAg9IKwbbWXKm/0HqEVw6nSLFcGMQkbbvwCggBerMx7ySRagQDEplimy4tDAAvm0nwogpFcyroZL2f32qutFK6l7zB0q6yO+ID+drlNgW13ESGsfXh2c55F2T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729893; c=relaxed/simple;
	bh=Teyavt3wsHUxjvyFAZiKpPT387B+tlsdvE9LyLGy+W0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kqzmCUJuHDUZrmPmGfF0RvMkdPfunrHyoSg8Bg/LYpQYDb9I4SAfIWsnI4nqWQctEtGHXY+yeZIaCqVcp0YiZEVqvw/FOc1w8g1o70tIZlM/IcqJGLrHIHiYhGNZajBh3mTsA/08eEqRHeigzNn9FkZTfh8xw3jQGGy4qfaZQX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZFl3mqvP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4Bu4F1031836
	for <linux-pm@vger.kernel.org>; Mon, 4 Nov 2024 14:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u1v/WVvHGAo0bVyM2Taoht+/F9lPQwBWyf6U4K1s2Xk=; b=ZFl3mqvPbcrqu5Fm
	/tdQBLyc1RjQhobSxIgv3AoflRkDcnVMqMoINj4uQJrMxqktvTB6rn27n9CmqOur
	Czq75fWmigZZLMbsJ3t53Gt3ZlRiL4Oif9NVq9/u6JkNSNGmiNGPPnnGG0k9LB3L
	aGAlhLDddL7oTD+Wd3bunyRsHIPHHWHYvqvo4O143vt5SH/0Zt1aaDCu3Rp+Xvgn
	/vCyTIy46BxEQR+9JKGPTpu7VgLGNVhjhD4A++Ad3Qv8iQ4d55wwJvkZeaRBNg/j
	85kvTB7L9V3m5tKT7c0vJWwULTmzd5GWtwwZnvcq1U17sJpeNR3iBxRltqp/3bLo
	nn1YmA==
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd5cmf0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 04 Nov 2024 14:18:10 +0000 (GMT)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a6baffc7f9so1847905ab.1
        for <linux-pm@vger.kernel.org>; Mon, 04 Nov 2024 06:18:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730729889; x=1731334689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u1v/WVvHGAo0bVyM2Taoht+/F9lPQwBWyf6U4K1s2Xk=;
        b=gdezlO/Dk36e0suQoJx+9zZlTxElymg1+7L8PXpZp5ez6dnMoVDh27dOJRdnix9MB1
         hdqN0XNi7+JrhavyJC2B5uG0/oVF26Pj/tHxMp2zcrHaPAt1g/wz2J+6rRR/xWdwRatU
         DgAE4AX5/7HbNjicILGUM1kKP3EFMVPL6ZfpU3GHYaI6rfYxhWUCjYLOWNCGrHGVameo
         yCRT8+xeGDX0MRlzFECMbDZervus0ze8T9uecSglhNSV3f2pi9sjyIxLkqs8Ym7Y2J/t
         uup01XvGooet7uipXyU5IZffhOOQzYyJM785SMKiI2Ak+/lRRoQUc6xyFTif6bk6/5UX
         QoIA==
X-Forwarded-Encrypted: i=1; AJvYcCU3xIPGflv7qBStRDuTUprWyWXYhLozH+KLYL3qaUwA8YaZMPcrSUvzKPlXTsfGRZl5WHF8qHTklA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx874olx3//nC9ydPUDegSgiXMkZAW/7jYj05w5q/9Aj0t76eWN
	K7jlL8R9LYW1GdzmKeGGCurwOWPNGwstoviKOaKkyUPeQvEzztdNAa6fyNSFGePCDfbKQ8a3duR
	V/e3C8FaGfC85kqJfioSM0KYeiX8WBVJsXfRbIrYH9H8wtk86n+xxjcfjIA==
X-Received: by 2002:a92:c561:0:b0:3a3:af94:4610 with SMTP id e9e14a558f8ab-3a4ed314920mr76085945ab.7.1730729889308;
        Mon, 04 Nov 2024 06:18:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCE3MSfa+IhWcVZ63OZ1NsqKoHNMmvePwJ57m9ObdgTyluZNlPMfMOzkM+3rGnAfblsK0Ltg==
X-Received: by 2002:a92:c561:0:b0:3a3:af94:4610 with SMTP id e9e14a558f8ab-3a4ed314920mr76085745ab.7.1730729888716;
        Mon, 04 Nov 2024 06:18:08 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e566442easm555348766b.166.2024.11.04.06.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 06:18:07 -0800 (PST)
Message-ID: <e1871824-78c8-436f-a41c-16ac1614004a@oss.qualcomm.com>
Date: Mon, 4 Nov 2024 15:18:03 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] drm/msm/adreno: Add support for ACD
To: Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20241012-gpu-acd-v1-0-1e5e91aa95b6@quicinc.com>
 <20241012-gpu-acd-v1-1-1e5e91aa95b6@quicinc.com>
 <1543ae2a-76ff-4b36-adae-37076e48b7f8@oss.qualcomm.com>
 <20241021220914.vrxiyeoxjyxweovu@hu-akhilpo-hyd.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241021220914.vrxiyeoxjyxweovu@hu-akhilpo-hyd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: gEqnsce4E56qx8OM3BN5dbZggKExU79G
X-Proofpoint-GUID: gEqnsce4E56qx8OM3BN5dbZggKExU79G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040124

On 22.10.2024 12:09 AM, Akhil P Oommen wrote:
> On Mon, Oct 21, 2024 at 11:38:41AM +0200, Konrad Dybcio wrote:
>> On 11.10.2024 10:29 PM, Akhil P Oommen wrote:
>>> ACD a.k.a Adaptive Clock Distribution is a feature which helps to reduce
>>> the power consumption. In some chipsets, it is also a requirement to
>>> support higher GPU frequencies. This patch adds support for GPU ACD by
>>> sending necessary data to GMU and AOSS. The feature support for the
>>> chipset is detected based on devicetree data.
>>>
>>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>>> ---
>>
>> [...]
>>
>>> +
>>> +	/* Initialize qmp node to talk to AOSS */
>>> +	gmu->qmp = qmp_get(gmu->dev);
>>> +	if (IS_ERR(gmu->qmp)) {
>>> +		cmd->enable_by_level = 0;
>>> +		return dev_err_probe(gmu->dev, PTR_ERR(gmu->qmp), "Failed to initialize qmp\n");
>>> +	}
>>
>> I'm still in favor of keeping qmp_get where it currently is, so that
>> probe can fail/defer faster
> 
> Sorry, I somehow missed this email from you until now.
> 
> If it fails, then it probably doesn't matter if it is a bit late. But for defer, isn't there
> some optimizations to track the dependency from devicetree data? I am
> not entirely sure!

There's devlink for clocks/supplies etc, it doesn't apply universally
for all phandle references IIUC.

> 
> Since qmp node is related to ACD, I felt it is better to:
>   1. Keep all acd probe related code in a single place.
>   2. Be more opportunistic in skipping qmp_get() wherever possible.
> 
> But if you still have strong opinion on this, I can move it back in the
> next revision (v3).

I suppose the answer is yes, I have a strong opinion :D

Konrad

