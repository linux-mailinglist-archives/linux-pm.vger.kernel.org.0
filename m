Return-Path: <linux-pm+bounces-33036-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C7BB3466F
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 17:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45F4D7A48AB
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 15:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D952FE579;
	Mon, 25 Aug 2025 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eSVbWHny"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9CD2FC028
	for <linux-pm@vger.kernel.org>; Mon, 25 Aug 2025 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756137421; cv=none; b=hkNRH/IGYKryJWX5NHPvB7qS8URamu0M6pBO2fh/iebWwtDWIOamXwh5B1eNflj8xTEZ6onm/JSH+upN9G+BZO6mKRqKBywcXXWJYdyZplKnVXTYYL9tactsaIhKzqSGFWlwfwDDTz+bfVM2ZWWkA443xo67aLUHuXo0MXrkRZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756137421; c=relaxed/simple;
	bh=JC64w3tuSkbajzgasYe6Zh8VlInyWVH1Pll+dy7VGfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rT5c94r24dlVSS6Lam03LfsK+Kg2CMhbr7ADJiJ/EgWR2TUUHyZCoZR2FCrBu5yuZjc/2SELz4hCGyfB0DWIvhD50snM0qryOTgDoRyKnmlJo3SQc25orTHNcnkuKvB3Ed2UrHjBfzL0BmGDvRSW5IXGEE4aD7GLzgXpZKUMy1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eSVbWHny; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8bT8a028657
	for <linux-pm@vger.kernel.org>; Mon, 25 Aug 2025 15:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QutffaOQ13Xwk3xH5hQhBka1Be9Thp0ZBqEZpEIMmX4=; b=eSVbWHny/cJccXmn
	S9JOMBfpnGg6yJJDMgRqDrLtLomR8hUkVFrW2C8iMAVHVja7mHsIdGOQil2rV8es
	rMo59RJAgl2fR/CYAuMGUWM0y3zoSseb5q5fk6oa8yFzyT4oapyaPlsd0Wt3UXOy
	fCoRGsYnFxUBrh/JqM1Ybb3+0vdK8CoZ8y8ZziSQ9Q9J1LZu2zd1HNUwuBbXiaTM
	LOALguo8PDIkmhykfwFvNnaTWYZ8tX61om9T3kxOLK7dL9d9TsK+BL+1wOv5a/Rt
	ozOnuIXRZfJVwXE6CsCW7OhWR/u0zykML1S57q7CzA1GRJK02UM9IOxiANKgZ0UJ
	sbfbKQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6thwp23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 25 Aug 2025 15:56:58 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b49c4e7ba85so1424745a12.3
        for <linux-pm@vger.kernel.org>; Mon, 25 Aug 2025 08:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756137418; x=1756742218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QutffaOQ13Xwk3xH5hQhBka1Be9Thp0ZBqEZpEIMmX4=;
        b=iQc2/OBLHT0Hq/L/nacbaORhEUJMwcqTc+n4/hCVNo/Neu1KtuxfXWmqGAvk7sZK53
         +amOYL7uRH/3hXqS5Qzamfh/EekTcoo1RqvJ+8jExmNozGJCMhcIqvYpJXKT3gNuAY1j
         ZwQ6Z8w9IN6OFQeN/ETMscNjK4lTWonUhOJdqbQjFdBFbTw2mJrWBBjiXVVCSt968ncG
         swWffIAa0Y6I0ZpU4UZdBw4Nrn8eb9MH+4wMpAajzV6bTgS6vIC3EEhDtPMNZ29LYxB0
         TYtvBdthcnlFaBxHMTtTmj8u4qTninJ1h3i19uqQfCNCpSfk1YnYf22y96egS7aW4w2f
         VxDQ==
X-Gm-Message-State: AOJu0YytnIxdl/fZBt4DWvD2UVr0fU057c58fSq8rWiKZBT/HmzhZz2M
	ZIHoaVAxwPRwjLp/skzlS8B15mWs3Y4y9pXC6FLC4r1NC+savbRW0pq4qimJbbEenj70qJ9/owp
	dTP0Vj3n0I8DkYCe3neI2Fqb39hHPRWPu1DIGW81puRQH+D8bGhbjypXp7Jdo5g==
X-Gm-Gg: ASbGncuYSR+6vwDun5anGfsMu3/ESubjZVOXSuY9bcNDqI2vG+eP86jjfIHVqXw/zY2
	0dZ8PYmAAuHv1DlFNtQLV67/SFqW0fWkMBeb3wsSbmFbekI67QkVRP7OLxeWRWLIr6XSEg91xwH
	RqEGYe/ADT/2AQ0HMFDf6ru4XxeU51vZYELTUcnliLwMNnDBy/KNyoTRtmAB7GoCHxfIoi8bTVw
	4OfyR5KpYPPwioEm/Tis4bhzbpJDuF7MoKgiwjuMXs1o0vVxHpBthjQO4+KgKSUwgTFup9igIs9
	jOtgUgUHaCeDQUHiVsibRHHLan1+nbON2QFnI2kESIU1qTQDRS/hvmPeEt7uUhGzBerSZYpO9b3
	W
X-Received: by 2002:a17:902:ce87:b0:246:e7ca:3598 with SMTP id d9443c01a7336-246e7ca3766mr35835125ad.38.1756137417899;
        Mon, 25 Aug 2025 08:56:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgrzCJcPV9SeMDkGSRfPk/j1dIRe81ecf4/C6a6KOY63K2M2JwS5OVVxjAsuQl2S0Ot4bAiw==
X-Received: by 2002:a17:902:ce87:b0:246:e7ca:3598 with SMTP id d9443c01a7336-246e7ca3766mr35834875ad.38.1756137417383;
        Mon, 25 Aug 2025 08:56:57 -0700 (PDT)
Received: from [192.168.29.113] ([49.43.227.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246e1b6fae5sm27049645ad.140.2025.08.25.08.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 08:56:57 -0700 (PDT)
Message-ID: <919ea7ce-a36a-4eaa-a13a-c693eb9c6c2f@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 21:26:49 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] OPP: Move refcount and key update for readability
 in _opp_table_find_key()
To: Marek Szyprowski <m.szyprowski@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
References: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
 <20250820-opp_pcie-v4-2-273b8944eed0@oss.qualcomm.com>
 <CGME20250825135939eucas1p206b6e2b5ba115f51618c773a1f37939c@eucas1p2.samsung.com>
 <4066c0b4-807f-401e-baaa-25f4891f10ac@samsung.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <4066c0b4-807f-401e-baaa-25f4891f10ac@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0MyBTYWx0ZWRfX/FnULMqSjL9T
 I6+YYziOgwhf4MI360gAj9zWLShwDAZRxOl/8JHHS6nLac/7jLKHCNfjfIYZv4gyPTN1YHL1LPt
 QTOlW87UxhejXVqaXWxEVDyC3eZvsiluDG5n538+mEOBAcKDAPmA6a2L3lfokr5h3Cmh9Ld3pWO
 ftrwXs7oaXX+dT+54Z+wDNjyJaNAIDRuJwFdjCbesV5K5VUix/Kche+el8NeL5pezaD6N7N0E4q
 zQ9YcWrpRWqdejukz6OVCLTMPDtRHn+e43E13GB99wHkd7OsBMRWEBA3ywjdi2UM1gnkiiqxBe0
 zZHqt7bSgN4Wb5pOnK0cpO+54c7fzEfeS86St2koQmuGlHo26uxg7ffy/Pqpjfw/mCjySreU7AV
 MUzttBAB
X-Proofpoint-ORIG-GUID: n69C55b8O1hzMO-u6DHiIF3TREunliyr
X-Proofpoint-GUID: n69C55b8O1hzMO-u6DHiIF3TREunliyr
X-Authority-Analysis: v=2.4 cv=W544VQWk c=1 sm=1 tr=0 ts=68ac87cb cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=TWSI64EsO1MY+X2Q/zVH0g==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=Wpt1jf_klKcEcVUAeWIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_07,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230043



On 8/25/2025 7:29 PM, Marek Szyprowski wrote:
> On 20.08.2025 10:28, Krishna Chaitanya Chundru wrote:
>> Refactor _opp_table_find_key() to improve readability by moving the
>> reference count increment and key update inside the match condition block.
>>
>> Also make the 'assert' check mandatory instead of treating it as optional.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> 
> This patch landed in today's linux-next (20250825) as commit
> b5323835f050 ("OPP: Reorganize _opp_table_find_key()"). In my tests I
> found that it causes regressions on my test boards. Reverting this
> change on top of linux-next fixes booting of all the affected boards.
> 
> Here are kernel logs with lockdep enabled:
> 
> 1. Exynos4412-based Odroid-U3 board (ARM 32bit):
> 
> ============================================
> WARNING: possible recursive locking detected
> 6.17.0-rc3-next-20250825 #10901 Not tainted
> --------------------------------------------
> kworker/u16:0/12 is trying to acquire lock:
> cf896040 (&devfreq->lock){+.+.}-{3:3}, at: devfreq_notifier_call+0x30/0x124
> 
> but task is already holding lock:
> cf896040 (&devfreq->lock){+.+.}-{3:3}, at: devfreq_monitor+0x1c/0x1a4
> 
> other info that might help us debug this:
>    Possible unsafe locking scenario:
> 
>          CPU0
>          ----
>     lock(&devfreq->lock);
>     lock(&devfreq->lock);
> 
>    *** DEADLOCK ***
> 
>    May be due to missing lock nesting notation
> 
> 4 locks held by kworker/u16:0/12:
>    #0: c289d0b4 ((wq_completion)devfreq_wq){+.+.}-{0:0}, at:
> process_one_work+0x1b0/0x70c
>    #1: f0899f18
> ((work_completion)(&(&devfreq->work)->work)#2){+.+.}-{0:0}, at:
> process_one_work+0x1dc/0x70c
>    #2: cf896040 (&devfreq->lock){+.+.}-{3:3}, at: devfreq_monitor+0x1c/0x1a4
>    #3: c2e78c4c (&(&opp_table->head)->rwsem){++++}-{3:3}, at:
> blocking_notifier_call_chain+0x28/0x60
> 
> stack backtrace:
> CPU: 2 UID: 0 PID: 12 Comm: kworker/u16:0 Not tainted
> 6.17.0-rc3-next-20250825 #10901 PREEMPT
> Hardware name: Samsung Exynos (Flattened Device Tree)
> Workqueue: devfreq_wq devfreq_monitor
> Call trace:
>    unwind_backtrace from show_stack+0x10/0x14
>    show_stack from dump_stack_lvl+0x68/0x88
>    dump_stack_lvl from print_deadlock_bug+0x370/0x380
>    print_deadlock_bug from __lock_acquire+0x1428/0x29ec
>    __lock_acquire from lock_acquire+0x134/0x388
>    lock_acquire from __mutex_lock+0xac/0x10c0
>    __mutex_lock from mutex_lock_nested+0x1c/0x24
>    mutex_lock_nested from devfreq_notifier_call+0x30/0x124
>    devfreq_notifier_call from notifier_call_chain+0x84/0x1d4
>    notifier_call_chain from blocking_notifier_call_chain+0x44/0x60
>    blocking_notifier_call_chain from _opp_kref_release+0x3c/0x5c
>    _opp_kref_release from exynos_bus_target+0x24/0x70
>    exynos_bus_target from devfreq_set_target+0x8c/0x2e8
>    devfreq_set_target from devfreq_update_target+0x9c/0xf8
>    devfreq_update_target from devfreq_monitor+0x28/0x1a4
>    devfreq_monitor from process_one_work+0x24c/0x70c
>    process_one_work from worker_thread+0x1b8/0x3bc
>    worker_thread from kthread+0x13c/0x264
>    kthread from ret_from_fork+0x14/0x28
> Exception stack(0xf0899fb0 to 0xf0899ff8)
> 
> ...
> 
> 
> 2. Exynos5422-based Odroid-XU3 board (ARM 32bit):
> 
> 8<--- cut here ---
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000000 when read
> [00000000] *pgd=00000000
> Internal error: Oops: 5 [#1] SMP ARM
> Modules linked in:
> CPU: 7 UID: 0 PID: 68 Comm: kworker/u34:1 Not tainted
> 6.17.0-rc3-next-20250825 #10901 PREEMPT
> Hardware name: Samsung Exynos (Flattened Device Tree)
> Workqueue: devfreq_wq devfreq_monitor
> PC is at _opp_compare_key+0x30/0xb4
> LR is at 0xfffffffc
> pc : [<c09831c4>]    lr : [<fffffffc>]    psr: 20000013
> sp : f0a89de0  ip : cfb0e94c  fp : c1574880
> r10: c14095a4  r9 : f0a89e44  r8 : c2a9c010
> r7 : cfb0ea80  r6 : 00000001  r5 : cfb0e900  r4 : 00000001
> r3 : 00000000  r2 : cfb0e900  r1 : cfb0ea80  r0 : cfaf5800
> Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 4000406a  DAC: 00000051
> Register r0 information: slab kmalloc-1k start cfaf5800 pointer offset 0
> size 1024
> Register r1 information: slab kmalloc-128 start cfb0ea80 pointer offset
> 0 size 128
> Register r2 information: slab kmalloc-128 start cfb0e900 pointer offset
> 0 size 128
> Register r3 information: NULL pointer
> Register r4 information: non-paged memory
> Register r5 information: slab kmalloc-128 start cfb0e900 pointer offset
> 0 size 128
> Register r6 information: non-paged memory
> Register r7 information: slab kmalloc-128 start cfb0ea80 pointer offset
> 0 size 128
> Register r8 information: slab kmalloc-1k start c2a9c000 pointer offset
> 16 size 1024
> Register r9 information: 2-page vmalloc region starting at 0xf0a88000
> allocated at kernel_clone+0x58/0x3c4
> Register r10 information: non-slab/vmalloc memory
> Register r11 information: non-slab/vmalloc memory
> Register r12 information: slab kmalloc-128 start cfb0e900 pointer offset
> 76 size 128
> Process kworker/u34:1 (pid: 68, stack limit = 0x050eb3d7)
> Stack: (0xf0a89de0 to 0xf0a8a000)
> ..
> Call trace:
>    _opp_compare_key from _set_opp+0x78/0x50c
>    _set_opp from dev_pm_opp_set_rate+0x15c/0x21c
>    dev_pm_opp_set_rate from panfrost_devfreq_target+0x2c/0x3c
>    panfrost_devfreq_target from devfreq_set_target+0x8c/0x2e8
>    devfreq_set_target from devfreq_update_target+0x9c/0xf8
>    devfreq_update_target from devfreq_monitor+0x28/0x1a4
>    devfreq_monitor from process_one_work+0x24c/0x70c
>    process_one_work from worker_thread+0x1b8/0x3bc
>    worker_thread from kthread+0x13c/0x264
>    kthread from ret_from_fork+0x14/0x28
> Exception stack(0xf0a89fb0 to 0xf0a89ff8)
> ...
> ---[ end trace 0000000000000000 ]---
> 
> 
> 3. Qualcomm Technologies, Inc. Robotics RB5(ARM 64bit):
> 
> ufshcd-qcom 1d84000.ufshc: freq-table-hz property not specified
> ufshcd-qcom 1d84000.ufshc: ufshcd_populate_vreg: Unable to find
> vdd-hba-supply regulator, assuming enabled
> ufshcd-qcom 1d84000.ufshc: Failed to find OPP for MIN frequency
> ufshcd-qcom 1d84000.ufshc: ufshcd_pltfrm_init: OPP parse failed -34
> ufshcd-qcom 1d84000.ufshc: error -ERANGE: ufshcd_pltfrm_init() failed
> ufshcd-qcom 1d84000.ufshc: probe with driver ufshcd-qcom failed with
> error -34
> 
> 
> 
>> ---
>>    drivers/opp/core.c | 14 ++++++--------
>>    1 file changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>> index a36c3daac39cd0bdd2a1f7e9bad5b92f0c756153..bf49709b8c39271431772924daf0c003b45eec7f 100644
>> --- a/drivers/opp/core.c
>> +++ b/drivers/opp/core.c
>> @@ -544,24 +544,22 @@ static struct dev_pm_opp *_opp_table_find_key(struct opp_table *opp_table,
>>    	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
>>    
>>    	/* Assert that the requirement is met */
>> -	if (assert && !assert(opp_table, index))
>> +	if (!assert(opp_table, index))
>>    		return ERR_PTR(-EINVAL);
>>    
>>    	guard(mutex)(&opp_table->lock);
>>    
>>    	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
>>    		if (temp_opp->available == available) {
>> -			if (compare(&opp, temp_opp, read(temp_opp, index), *key))
>> +			if (compare(&opp, temp_opp, read(temp_opp, index), *key)) {
>> +				/* Increment the reference count of OPP */
>> +				*key = read(opp, index);
>> +				dev_pm_opp_get(opp);
>>    				break;
>> +			}
>>    		}
>>    	}
>>    
>> -	/* Increment the reference count of OPP */
>> -	if (!IS_ERR(opp)) {
>> -		*key = read(opp, index);
>> -		dev_pm_opp_get(opp);
>> -	}
>> -
>>    	return opp;
>>    }
>>    
>>
> Best regards
Thanks Marek for reporting.

Viresh,

looks like for compare_floor we need to iterate to the OPP table till
the OPP key is greater than the target key and return previous OPP.

In that case the updation of the key and dev_pm_opp_get() should be
outside as before. We need to remove this part of the patch.

Thanks & Regards,
Krishna Chaitanya.

