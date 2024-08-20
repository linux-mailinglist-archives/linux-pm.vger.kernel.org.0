Return-Path: <linux-pm+bounces-12544-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A880958162
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 10:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7655282427
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 08:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE03B18A952;
	Tue, 20 Aug 2024 08:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qPyDdws7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484C277F01;
	Tue, 20 Aug 2024 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724143914; cv=none; b=Fiy20TyGrHoYIDM94Nc20j79Jp9vCGbpGLXYMtmRN0KoCu5fJah01+mAiOFOR+zRDXZL79uWM9qK5x7iKROp5UejTDJc8kSh8XHqgRa8LqFvIJ7DRUbBeoj4w2B0tD4A/Fv4hgzNLdFkv1mlaKUQZHER9KgvKIjoBmTuY+g09fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724143914; c=relaxed/simple;
	bh=mNILr8Pdls+TeURy3XmDnjOuSLT2Jf1WUkkMCewepMs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q2s2NVeswd/QQVLzozcjGRnENhXXJrr20VTOzry7M65B1p5zs05GDZwAsk4MM2UXujMLxIXUFehAF6+JTS5eBVJgB1ZspEelW0UM8AVe+Tlbn1D6d0QWyvkC5rxZfQvjLzlR8Yf3ESdfUdPyCbhewTQ/xnVtZZl2oJkA4T00GUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qPyDdws7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JI0QWZ027831;
	Tue, 20 Aug 2024 08:51:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	FxaRGyeY0qiUYRkyliaFWbt0eNy3WsJw6YkRsvCb6GI=; b=qPyDdws7hU6JVKRI
	Nf/femsaqIhhdLNlD5VOoSGFDb0+pxE+1qB7alBk39+6oJ60jNTfpeikAOOcrlRM
	c9HIFOyideVpeqd0V+nVBLprvlhqqIq+Y/a8cKCW9zMtQ7QITzegjZKvZdPS/fqo
	IJVwvF6gVVcjPCjA7VMhWlH4zlywI4fP1XCdJH/NUq3v4e7kqtDBbFJedRfRrpfz
	CQH4MD5WqIYWQGmM1xc4NFb6456LthBSM3L+lRHKuflxwNhg3AlRulchAqSOEhWx
	2j2Njg1tlRZ1MY/FJoKfwMYSPog9AUOLJZ9yWuwCwyEawFxeaXO34pZhltmpoYiL
	KVpXIw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mbfv9j0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 08:51:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47K5aRa9013103;
	Tue, 20 Aug 2024 08:51:44 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41366u2aka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 08:51:44 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47K8peQQ24117880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 08:51:43 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B36965805D;
	Tue, 20 Aug 2024 08:51:40 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3559B58055;
	Tue, 20 Aug 2024 08:51:38 +0000 (GMT)
Received: from li-34d1fccc-27cd-11b2-a85c-c167793e56f7.ibm.com (unknown [9.43.62.216])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Aug 2024 08:51:37 +0000 (GMT)
Message-ID: <9e5ef8ab0f0f3e7cb128291cd60591e3d07b33e4.camel@linux.ibm.com>
Subject: Re: [PATCH 0/1] cpuidle/menu: Address performance drop from
 favoring physical over polling cpuidle state
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Christian Loehle <christian.loehle@arm.com>, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: gautam@linux.ibm.com, aboorvad@linux.ibm.com
Date: Tue, 20 Aug 2024 14:21:36 +0530
In-Reply-To: <93d9ffb2-482d-49e0-8c67-b795256d961a@arm.com>
References: <20240809073120.250974-1-aboorvad@linux.ibm.com>
	 <93d9ffb2-482d-49e0-8c67-b795256d961a@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-26.el8_10) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: a9Jp-FI6R0vi1mlmCPUR9glTI9v4p4xe
X-Proofpoint-ORIG-GUID: a9Jp-FI6R0vi1mlmCPUR9glTI9v4p4xe
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408200058

On Tue, 2024-08-13 at 13:56 +0100, Christian Loehle wrote:

Hi Christian,

Thanks a lot for your comments.
...
> On 8/9/24 08:31, Aboorva Devarajan wrote:
> > This patch aims to discuss a potential performance degradation that can occur
> > in certain workloads when the menu governor prioritizes selecting a physical
> > idle state over a polling state for short idle durations. 
> > 
> > Note: This patch is intended to showcase a performance degradation, applying
> > this patch could lead to increased power consumption due to the trade-off between
> > performance and power efficiency, potentially causing a higher preference for
> > performance at the expense of power usage.
> > 
> 
> Not really a menu expert, but at this point I don't know who dares call
> themselves one.
> The elephant in the room would be: Does teo work better for you?
> 

I ran some tests with the teo governor enabled, but it didn’t make a
lot of difference. The results are presented below.

> > ==================================================
> > System details in which the degradation is observed:
> > 
> > $ uname -r
> > 6.10.0+
> > 
> > $ lscpu
> > Architecture:             ppc64le
> >   Byte Order:             Little Endian
> > CPU(s):                   160
> >   On-line CPU(s) list:    0-159
> > Model name:               POWER10 (architected), altivec supported
> >   Model:                  2.0 (pvr 0080 0200)
> >   Thread(s) per core:     8
> >   Core(s) per socket:     3
> >   Socket(s):              6
> >   Physical sockets:       4
> >   Physical chips:         2
> >   Physical cores/chip:    6
> > Virtualization features:
> >   Hypervisor vendor:      pHyp
> >   Virtualization type:    para
> > Caches (sum of all):
> >   L1d:                    1.3 MiB (40 instances)
> >   L1i:                    1.9 MiB (40 instances)
> >   L2:                     40 MiB (40 instances)
> >   L3:                     160 MiB (40 instances)
> > NUMA:
> >   NUMA node(s):           6
> >   NUMA node0 CPU(s):      0-31
> >   NUMA node1 CPU(s):      32-71
> >   NUMA node2 CPU(s):      72-79
> >   NUMA node3 CPU(s):      80-87
> >   NUMA node4 CPU(s):      88-119
> >   NUMA node5 CPU(s):      120-159
> > 
> > 
> > $ cpupower idle-info
> > CPUidle driver: pseries_idle
> > CPUidle governor: menu
> > analyzing CPU 0:
> > 
> > Number of idle states: 2
> > Available idle states: snooze CEDE
> > snooze:
> > Flags/Description: snooze
> > Latency: 0
> > Residency: 0
> > Usage: 6229
> > Duration: 402142
> > CEDE:
> > Flags/Description: CEDE
> > Latency: 12
> > Residency: 120
> > Usage: 191411
> > Duration: 36329999037
> > 
> > ==================================================
> > 
> > The menu governor contains a condition that selects physical idle states over,
> > such as the CEDE state over polling state, by checking if their exit latency meets
> > the latency requirements. This can lead to performance drops in workloads with
> > frequent short idle periods.
> > 
> > The specific condition which causes degradation is as below (menu governor):
> > 
> > ```
> > if (s->target_residency_ns > predicted_ns) {
> >     ...
> >     if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
> >         s->exit_latency_ns <= latency_req &&
> >         s->target_residency_ns <= data->next_timer_ns) {
> >         predicted_ns = s->target_residency_ns;
> >         idx = i;
> >         break;
> >     }
> >     ...
> > }
> > ```
> > 
> > This condition can cause the menu governor to choose the CEDE state on Power
> > Systems (residency: 120 us, exit latency: 12 us) over a polling state, even
> > when the predicted idle duration is much shorter than the target residency
> > of the physical state. This misprediction leads to performance degradation
> > in certain workloads.
> > 
> 
> So clearly the condition
> s->target_residency_ns <= data->next_timer_ns)
> is supposed to prevent this, but data->next_timer_ns isn't accurate,
> have you got any idea what it's set to in your workload usually?
> Seems like your workload is timer-based, so the idle duration should be
> predicted accurately.
> 

Yes, that's right ideally this condition should have prevented this,
but `data->next_timer_ns` is almost always greater than the actual
idle duration which seems inaccurate.

> 
> > ==================================================
> > Test Results
> > ==================================================
> > 
> > This issue can be clearly observed with the below test.
> > 
> > A test with multiple wakee threads and a single waker thread was run to
> > demonstrate this issue. The waker thread periodically wakes up the wakee
> > threads after a specific sleep duration, creating a repeating of sleep -> wake
> > pattern. The test was run for a stipulated period, and cpuidle statistics are
> > collected.
> > 
> > ./cpuidle-test -a 0 -b 10 -b 20 -b 30 -b 40 -b 50 -b 60 -b 70 -r 20 -t 60
> > 
> > ==================================================
> > Results (Baseline Kernel):
> > ==================================================
> > Wakee 0[PID 8295] affined to CPUs: 10,
> > Wakee 2[PID 8297] affined to CPUs: 30,
> > Wakee 3[PID 8298] affined to CPUs: 40,
> > Wakee 1[PID 8296] affined to CPUs: 20,
> > Wakee 4[PID 8299] affined to CPUs: 50,
> > Wakee 5[PID 8300] affined to CPUs: 60,
> > Wakee 6[PID 8301] affined to CPUs: 70,
> > Waker[PID 8302] affined to CPUs: 0,
> > 
> > > -----------------------------------|-------------------------|-----------------------------|
> > > Metric                            | snooze                  | CEDE                        |
> > > -----------------------------------|-------------------------|-----------------------------|
> > > Usage                             | 47815                   | 2030160                     |
> > > Above                             | 0                       | 2030043                     |
> > > Below                             | 0                       | 0                           |
> > > Time Spent (us)                   | 976317 (1.63%)          | 51046474 (85.08%)           |
> > > Overall average sleep duration    | 28.721 us               |                             |
> > > Overall average wakeup latency    | 6.858 us                |                             |
> > > -----------------------------------|-------------------------|-----------------------------|
> > 
> > In this test, without the patch, the CPU often enters the CEDE state for
> > sleep durations of around 20-30 microseconds, even though the CEDE state's
> > residency time is 120 microseconds. This happens because the menu governor
> > prioritizes the physical idle state (CEDE) if its exit latency is within
> > the latency limits. It also uses next_timer_ns for comparison, which can
> > be farther off than the actual idle duration as it is more predictable,
> > instead of using predicted idle duration as a comparision point with the
> > target residency.
> 
> Ideally that shouldn't be the case though (next_timer_ns be farther off thactual idle duration)

I ran some experiments based on your suggestions. Below are the
relative average runtimes and percentage differences compared to
the base version:

Picked a single representative workload for simplicity:

Note: Lower (% Difference) the better.
|---------------------------|-----------------|--------------|
| Configuration             | Average Runtime | % Difference |
|---------------------------|-----------------|--------------|
| Base (menu)               | 1.00            | 0.00%        |
| Base + Patch 1 (menu)     | 0.92            | -8.00%       |
| Base + Patch 2 (menu)     | 0.98            | -2.00%       |
| Base (teo)                | 1.01            | +1.00%       |
|---------------------------|-----------------|--------------|
Patch 1: https://lore.kernel.org/all/20240809073120.250974-2-aboorvad@linux.ibm.com/  
Patch 2: https://lore.kernel.org/all/c20a07e4-b9e6-4a66-80f5-63d679b17c3b@arm.com/

It seems that Patch 2 does provide a slight improvement in runtime, but
not significantly like Patch 1. Additionally, teo does not seem
to help in this case.

Regarding the condition `s->target_residency_ns <= data->next_timer_ns`,
it appears that `data->next_timer_ns` is consistently greater than
both actual idle duration and `s->target_residency_ns` so this condition
nearly always holds true, indicating some inaccuracy. I'll investigate
this further and follow up with more details.

Regards,
Aboorva


