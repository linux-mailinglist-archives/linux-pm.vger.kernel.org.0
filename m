Return-Path: <linux-pm+bounces-32432-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F35B2802D
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 14:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BCD1189FD1D
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 12:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714CC2874E4;
	Fri, 15 Aug 2025 12:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="POsBI022"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D225DDAB;
	Fri, 15 Aug 2025 12:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755262148; cv=none; b=WrZid8L1L7+A3m+iR0wwXG5UVf2gMf6b17iwAuNfGf1jrjqLY1tEU9nzbjH3XOIJDy8z1amscPQ4FLo9b/ClNkSb5/env6AFoIwT9AMRYgUoSzIMA2Xvt2JtlwLFzHBSJUU37wmlfTOsTWmhB/0lnkN5Wzaspt+rW0Pu9rE5ewg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755262148; c=relaxed/simple;
	bh=TszXMU49qG3PiI/lUkV4zsxC6WnAW1JSHFD5eAnJhug=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T/gucpOWUFIJNsMq1Lt7O9m+e+63KnTq7fxXwnORrcjpZL6zOP63Jrx2Oy2F3DoGbfNZZ+cV8L1z3arj5WiVlNCCcQg5sLDLV1bR6R3/zcXYdMeGdXSthhPNXLuapuhoTWGHDn0U1sQh2y06ECVYvDhEH2KCjDiZIV83bprM72I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=POsBI022; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57F9linH010468;
	Fri, 15 Aug 2025 12:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pComdYhf8ID09m/5ijvvK+F08ZofY1uU3bdlKG2IwjU=; b=POsBI022AopIlVon
	eMMgUF7de/7Gd45LUFc6G5TUERdm1Hxm7/5iqq3vXm2RQFwQuL9g7+p/i4lBuHuR
	Xoz3RGQaTZDQ7lRgfLw5NPgbcA+b1wAJ9C9rub4a24X7GD8iUlxxDRM309PUGBJx
	TbG5gSf34VjHNtA0S+66gw3+M6xYSa/3rfwCOQLVg1DIKr5dtYDrx3KLJ1dYroho
	f2OgzWtVGh5IKHFt/41V3fhx+qkoF+2bUJBGBk+ryZOtenaUt4WngfH5UGdKnorm
	le+ILyY6bnIlqpv5ocSgjqnkVFwxORDouh8F0HU89E6iyUxtE68hIL7AQ2N6cWqJ
	xjcYmA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dw9t3962-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 12:48:58 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57FCmvDE001355
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Aug 2025 12:48:57 GMT
Received: from [10.133.33.33] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 15 Aug
 2025 05:48:53 -0700
Message-ID: <c4d4c458-bc64-4ca9-9c65-3e942825eac5@quicinc.com>
Date: Fri, 15 Aug 2025 20:48:43 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] PM QoS: Add CPU affinity latency QoS support and
 resctrl integration
To: <rafael@kernel.org>, <lenb@kernel.org>, <pavel@kernel.org>,
        <tony.luck@intel.com>, <reinette.chatre@intel.com>,
        <Dave.Martin@arm.com>, <james.morse@arm.com>, <ulf.hansson@linaro.org>,
        <amit.kucheria@linaro.org>, <christian.loehle@arm.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhongqiu.han@oss.qualcomm.com>
References: <20250721124104.806120-1-quic_zhonhan@quicinc.com>
Content-Language: en-US
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
In-Reply-To: <20250721124104.806120-1-quic_zhonhan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=J+Wq7BnS c=1 sm=1 tr=0 ts=689f2cba cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=ONSPaYZiz2aHDf4gUJcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: XCQ0Kj62ox8c6Gn-sLZ8OAO0HuccMX30
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxNSBTYWx0ZWRfX0xcnuYn7h9Vw
 ak48ubIL3Kh/c8wST6AZyZlKALqU5c03On4iAPEn9/LK91W1L3Zx2m4/BFELqa3vQjr7iXJO15b
 PZoc5rOt+sFGgqoVn0kG2zA4ung/il8BOQsyZ/Z7U2ofIcwGq6uoXMF/mCMbm/I5ry4URhHbbx/
 to7QyJ7umFTfVFZwzWIwG/efpcGFLg5R0fNiQ8rrXnvS4MY9+10ZPoG4r+2PAGjlodYxxx5MnJD
 /ikHkFVpZRFS92kEsGozegT0yt22EMeXtx+BRwHJTZSQEhalgD9v9ft08pNYTdX6JlkUEGDJVPp
 ztoE2CPdU2ANMGGXzqAmO2hc0It6AEZkQdhfYWF2sEd527nHs8SlQvoYiYQ73AhNXO6SWc3HC6W
 GUIrj0WH
X-Proofpoint-GUID: XCQ0Kj62ox8c6Gn-sLZ8OAO0HuccMX30
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090015

On 7/21/2025 8:40 PM, Zhongqiu Han wrote:
> Hi all,
> 
> This patch series introduces support for CPU affinity-based latency
> constraints in the PM QoS framework. The motivation is to allow
> finer-grained power management by enabling latency QoS requests to target
> specific CPUs, rather than applying system-wide constraints.
> 
> The current PM QoS framework supports global and per-device CPU latency
> constraints. However, in many real-world scenarios, such as IRQ affinity
> or CPU-bound kernel threads, only a subset of CPUs are
> performance-critical. Applying global constraints in such cases
> unnecessarily prevents other CPUs from entering deeper C-states, leading
> to increased power consumption.
> 
> This series addresses that limitation by introducing a new interface that
> allows latency constraints to be applied to a CPU mask. This is
> particularly useful on heterogeneous platforms (e.g., big.LITTLE) and
> embedded systems where power efficiency is critical for example:
> 
>                          driver A       rt kthread B      module C
>    CPU IDs (mask):         0-3              2-5              6-7
>    target latency(us):     20               30               100
>                            |                |                |
>                            v                v                v
>                            +---------------------------------+
>                            |        PM  QoS  Framework       |
>                            +---------------------------------+
>                            |                |                |
>                            v                v                v
>    CPU IDs (mask):        0-3            2-3,4-5            6-7
>    runtime latency(us):   20             20, 30             100
> 
> The current implementation includes only cpu_affinity_latency_qos_add()
> and cpu_affinity_latency_qos_remove() interfaces. An update interface is
> planned for future submission, along with PM QoS optimizations in the UFS
> subsystem.
> 
> Patch1 introduces the core support for CPU affinity latency QoS in the PM
> QoS framework.
> 
> Patch2 removes redundant KERN_ERR prefixes in WARN() calls in the global
> CPU PM QoS interface. This change addresses issues in existing code and is
> not related to the new interface introduced in this patch series.
> 
> Patch3 adds documentation for the new interface.
> 
> Patch4 fixes a minor documentation issue related to the return type of
> cpu_latency_qos_request_active(). This change addresses issues in existing
> doc and is not related to the new interface introduced in this patch
> series.
> 
> Patch5 updates the resctrl pseudo-locking logic to use the new CPU
> affinity latency QoS helpers, improving clarity and consistency. The only
> functional and beneficial change is that the new interface actively wakes
> up CPUs whose latency QoS values have changed, ensuring the latency limit
> takes effect immediately.

Hi Rafael,
I hope you're doing well. I just wanted to kindly check in regarding
current patch I submitted a while ago.

I understand things can get busy, and there's absolutely no rush — just
wanted to make sure it hasn't been missed.

Thank you~


> 
> Changes since v1:
> - Rebased on top of current next.
> - Resolve the compilation warning due to a missing static function
>    declaration.
> - Remove the conditional compilation based on CONFIG_CPU_IDLE and make it
>    depend solely on CONFIG_PM.
> - Add support for cpu_affinity_latency_qos_active.
> - Remove cpu_affinity_latency_qos_update; will reintroduce it when needed
>    in the future.
> - Optimize the code, for example by using cpu_affinity_latency_qos_active
>    inside the add/remove functions to enhance robustness.
> - Refine the commit message and fix a few minor issues unrelated to this
>    series.
> - Refactor the CPU latency PM QoS logic of resctrl pseudo_lock using the
>    interfaces provided by this series.
> - Link to v1: https://lore.kernel.org/all/20250424095228.1112558-1-quic_zhonhan@quicinc.com/
> 
> Zhongqiu Han (5):
>    PM: QoS: Add support for CPU affinity latency PM QoS
>    PM: QOS: Remove unnecessary KERN_ERR on WARN() calls
>    Documentation: PM: QoS: Add CPU affinity latency PM QoS Interface
>      documentation
>    Documentation: PM: QoS: Fix return type and return value description
>    resctrl: Replace PM QoS logic with cpu_affinity_latency_qos_* helpers
> 
>   Documentation/power/pm_qos_interface.rst |  63 ++++++++-
>   fs/resctrl/pseudo_lock.c                 |  51 +------
>   include/linux/pm_qos.h                   |  40 ++++++
>   include/linux/resctrl.h                  |   3 +-
>   kernel/power/qos.c                       | 166 ++++++++++++++++++++++-
>   5 files changed, 268 insertions(+), 55 deletions(-)
> 
> 
> base-commit: 024e09e444bd2b06aee9d1f3fe7b313c7a2df1bb


-- 
Thx and BRs,
Zhongqiu Han

