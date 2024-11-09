Return-Path: <linux-pm+bounces-17251-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE0E9C2C47
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 12:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C541F21E12
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2024 11:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AED0175D35;
	Sat,  9 Nov 2024 11:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ljK6H66X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B428D154BF5
	for <linux-pm@vger.kernel.org>; Sat,  9 Nov 2024 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731153192; cv=none; b=RcIkFxQGNQ68jcJOnQ0c77c87Fe8zX7SHj1DuPiRW9bANxKy1p9zdrIWoZVH/MRyhs6kqcKezZyazC1ygvXGTpgNMq+0v/R6jNUYsl6uIkb3VxVhHMp9iSiMXViIxh3vnCB4nprGfdMvwp7c42cCA2gaI8cB3AHwYglP1On9Gsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731153192; c=relaxed/simple;
	bh=WbO3bwNTbo9CJaITdFuh3lFQvk9b5CAZsrlvd0nPISU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTC+l2NPX/vUWqs2VQTOq5j+yoGq8Hgaii7ZavonHvfIeNS3g/ORgAF79+g1gLS9DNJhkbFTUE5QRd4u+nRTGe15Yhspyrlu1BvfK7dW7Ys2Wg3avcIFFnGWtdPuVdUn0hUDnX76Ww/GoloQwRPGxg8NzsDcrHFGbHvihUGLhC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ljK6H66X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A9AGEgm023724
	for <linux-pm@vger.kernel.org>; Sat, 9 Nov 2024 11:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WbO3bwNTbo9CJaITdFuh3lFQvk9b5CAZsrlvd0nPISU=; b=ljK6H66Xjg6/l9L5
	msKLXhOB/aHsEyWw+SyAtPdiDrmdJAhQ28YGhSTKoJQtf4p0C8rDC1BA6Y9whRj+
	hEad6Zwc+rPEziO5SypeoWR/kb2EE95u+c1pFEvXmmSg6ihutXg9iaMtPrZzNIy0
	jPu2boRS2nh9zbeSZ1hOcnOLo7h2kxQP7rKOdfhdhOMW8ZWIvXVGpdF8adUYRdUu
	l0gfU8OrIfPtgFLpwoI/tjbFcE7uezjmYBqGh+nXPskqaoR8RrTAd/X385AlN3r9
	t6bjk1NlqgFOk+RH2w6qxzS4UEHh7RI6YBd9jFLZtAyxscsdXnL3WEORzSAjTmcs
	45jZhQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42t1180f6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 09 Nov 2024 11:53:09 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6cbe5e8658fso910766d6.0
        for <linux-pm@vger.kernel.org>; Sat, 09 Nov 2024 03:53:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731153188; x=1731757988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WbO3bwNTbo9CJaITdFuh3lFQvk9b5CAZsrlvd0nPISU=;
        b=mhQhKPm+Q3P2L0t6qNvUBaYD8z8/WgJ4BfAadM1/+opa2BW6N7NEIZ76H1LYUJC6/E
         SqdZweMJ3LWZzncw2a8eHbwBAtntTaJ/alnIeG4mDuhYuHuq3dMvFblf9EDShkzd+eO2
         deBHY9P/DVvmqM3mHTJmQTegVnUA9KH3bvisDJg4kZVnfOsbJC5q/Ed+adKYLROh3h/+
         JjMCJL/cmJaZY4Btek2OgMR+nc/jpM7wzq9zu8Q+uvbwj0XpRQwccra+TMdyljiQiToi
         C5+W7xI11zZm2VdijL7q3jKdWX8IIQR4k3U60cahfvmCke+pzU/iAlvh5xrYhc5Kc7Pd
         NcEw==
X-Forwarded-Encrypted: i=1; AJvYcCXzVL4NP+SL3U32bN2SDlza91m9grQN5jUQKGDsQFUaaMOFA3/8yv9Og5zHMfziWwl3qexF3qQBHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwepUk6//soFlU7vn9Dcd+vCFO3TrsxxW7eUwg20A6VJXgpGC+T
	kFIi0RPQfIvhsfs8/0PcfWIOYH2L0x0ZQa1q3kD7VKSfGPd47tNBSDq1vIsJi98os3IKC3uhFoK
	jLY86+ylbCimH8xih2alhA5Y3yFShfW8Biih5kqjmjxB3SIoKFUdDVCIzLQ==
X-Received: by 2002:a05:620a:24d6:b0:7b1:8e09:5122 with SMTP id af79cd13be357-7b331dc1d1amr357303385a.1.1731153188356;
        Sat, 09 Nov 2024 03:53:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHl7UYZzV/NRfxqM1jrH9cTW8r3ctv9OuDpOq1GOlGbjBAVwnStnlfGHEtxjiNYaEuj2o1SYw==
X-Received: by 2002:a05:620a:24d6:b0:7b1:8e09:5122 with SMTP id af79cd13be357-7b331dc1d1amr357300985a.1.1731153188005;
        Sat, 09 Nov 2024 03:53:08 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a48561sm351434366b.48.2024.11.09.03.53.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2024 03:53:07 -0800 (PST)
Message-ID: <f4a2598f-28be-47f5-9f6c-5cbbf911c3ef@oss.qualcomm.com>
Date: Sat, 9 Nov 2024 12:53:02 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/14] arm64: dts: qcom: Add initial support for
 MSM8917
To: barnabas.czeman@mainlining.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Lee Jones <lee@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, iommu@lists.linux.dev,
        =?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
References: <20241107-msm8917-v3-0-6ddc5acd978b@mainlining.org>
 <20241107-msm8917-v3-12-6ddc5acd978b@mainlining.org>
 <0293b1c5-d405-4021-b9c1-205271107350@oss.qualcomm.com>
 <2c5f429d01fc04b2b40251e841bd4f64@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <2c5f429d01fc04b2b40251e841bd4f64@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cXG1yScDqWuvLEdkiICYpt7pUtpnPVep
X-Proofpoint-GUID: cXG1yScDqWuvLEdkiICYpt7pUtpnPVep
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=949 lowpriorityscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411090101

On 9.11.2024 12:36 PM, barnabas.czeman@mainlining.org wrote:
> On 2024-11-08 18:03, Konrad Dybcio wrote:
>> On 7.11.2024 6:02 PM, Barnabás Czémán wrote:
>>> From: Otto Pflüger <otto.pflueger@abscue.de>
>>>
>>> Add initial support for MSM8917 SoC.
>>>
>>> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
>>> [reword commit, rebase, fix schema errors]
>>> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>>> ---

[...]

>>> +                opp-19200000 {
>>> +                    opp-hz = /bits/ 64 <19200000>;
>>> +                };
>>
>> Does the GPU actually function at 19.2 MHz? You can check this by removing
>> all other entries and starting some gpu workload
> Yes

Thanks for confirming, feel free to keep this entry then

Konrad

