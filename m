Return-Path: <linux-pm+bounces-14428-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5812897C3E8
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 07:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE6B1F21D55
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 05:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C26655885;
	Thu, 19 Sep 2024 05:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oEhP7tbL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE6B50288;
	Thu, 19 Sep 2024 05:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726724907; cv=none; b=cE1mOt6187ixrMxdtoyGrqnD0AHMaCJKC9javANzyZNuhHH9yk4eDMicpRKfmKPD/umlQv+LdsdxBGfAHSNRSz87GR419QXJviQ05J77Il5FOeMvl47OpbDYedTkNAwDEeveSgrGCodUe7tRoD+FLyM8E0knYEKT3UiJT2suOsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726724907; c=relaxed/simple;
	bh=G3HxZ6BFJgGUngUEdEqRvTO8h+Y5um2rH+ytTzIxaSk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gQkfo0aBc1PoqIsCVBlqVpt3YAYFlFJgaipMbmC5OveEez3zmx6+i9hNfiC15nPNvqpHeP/T2ssYwShSxlsHpQTkowZ+p6EAGzdR2cT086BO39PtjRzJlKFdmbhLTO9AkSSrT3KbQSvQwI4ASwrZFRzrP/OuqNmqcOU3xEDf1mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oEhP7tbL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48IITF23009895;
	Thu, 19 Sep 2024 05:02:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	q5KuE0T+uQVKI2p30mdo6ySoLSIgxgeCS36MCTvmvCY=; b=oEhP7tbLz9/RhxJq
	I3F+vXRDRp6pR4mHlGluOsxZWDFptR36jH0uSRN12/aq70D9zisDu+iGgf14ijwo
	D2y0SF0sYzTsfk+UZFGZE/zVSEXRucnwrW7K3OzfULK5NYD1nsIXfrcXP/2mp530
	7nVC+90CIXcW6TbHzxUcKKVHl8wqBrgp1JKG0NDofinujndyH9vfwk7+p7qPeNUc
	uaEMYaFcYR63fVE8sEjFxb45turmj+z0SuECxC9aaU8bq1htG4trvMjw474tCKyo
	CBW6lg2VFRawYMu/7v+QXNmRkJcYWT6aIZ64EnGLIU2THFjqq6YEvO+JErDLZx9K
	JIh38Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3ujht8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 05:02:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48J4Iklo030649;
	Thu, 19 Sep 2024 05:02:24 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41npanf6t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 05:02:24 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48J52Nvv32571674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Sep 2024 05:02:23 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67AF35803F;
	Thu, 19 Sep 2024 05:02:23 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C288158054;
	Thu, 19 Sep 2024 05:02:19 +0000 (GMT)
Received: from li-34d1fccc-27cd-11b2-a85c-c167793e56f7.ibm.com (unknown [9.171.57.39])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Sep 2024 05:02:19 +0000 (GMT)
Message-ID: <6371848e9c260743f381be6e0114743ffab5e5bb.camel@linux.ibm.com>
Subject: Re: [PATCH 0/1] cpuidle/menu: Address performance drop from
 favoring physical over polling cpuidle state
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Christian Loehle <christian.loehle@arm.com>, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: gautam@linux.ibm.com, aboorvad@linux.ibm.com
Date: Thu, 19 Sep 2024 10:32:17 +0530
In-Reply-To: <4c897ab4-d592-427b-9a97-79c2b14d5c46@arm.com>
References: <20240809073120.250974-1-aboorvad@linux.ibm.com>
	 <93d9ffb2-482d-49e0-8c67-b795256d961a@arm.com>
	 <9e5ef8ab0f0f3e7cb128291cd60591e3d07b33e4.camel@linux.ibm.com>
	 <4c897ab4-d592-427b-9a97-79c2b14d5c46@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-26.el8_10) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wWktMu2_8I5AWkJTvgQEtICgsOHo0SMY
X-Proofpoint-GUID: wWktMu2_8I5AWkJTvgQEtICgsOHo0SMY
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-19_03,2024-09-18_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1011 bulkscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409190027

On Wed, 2024-08-21 at 11:55 +0100, Christian Loehle wrote:

> On 8/20/24 09:51, Aboorva Devarajan wrote:
> > On Tue, 2024-08-13 at 13:56 +0100, Christian Loehle wrote:
> > 
...
> The wakeup source(s), since they don't seem to be timer events would be
> interesting, although a bit of a hassle to get right. 
> What's the workload anyway?
> 

Hi Christian,

Apologies for the delayed response.

I identified the part of the internal workload responsible for performance
improvement with the patch and it appears to be the OLTP queries, and yes
the wakeup sources are not timer events.

---------------------------------------------------------------------

Additionally to reproduce the issue using a more open and accessible
benchmark, conducted similar experiments using pgbench and I observed
similar improvements with the patch, particularly when running the
read intensive select query benchmarks.

---------------------------------------------------------------------
System Details
---------------------------------------------------------------------
$ lscpu
Architecture:             ppc64le
  Byte Order:             Little Endian
CPU(s):                   224
  On-line CPU(s) list:    0-223
Model name:               POWER10 (architected), altivec supported
  Model:                  2.0 (pvr 0080 0200)
  Thread(s) per core:     8
  Core(s) per socket:     3
  Socket(s):              8
Virtualization features:  
  Hypervisor vendor:      pHyp
  Virtualization type:    para
---------------------------------------------------------------------

$ cpupower idle-info
CPUidle driver: pseries_idle
CPUidle governor: menu
analyzing CPU 0:

Number of idle states: 2
Available idle states: snooze CEDE
snooze:
Flags/Description: snooze

Latency: 0
Residency: 0
Usage: 6229
Duration: 402142
CEDE:
Flags/Description: CEDE
Latency: 12
Residency: 120
Usage: 191411
Duration: 36329999037

---------------------------------------------------------------------
PostgreSQL Benchmark:
---------------------------------------------------------------------

I ran pgbench with 224 clients and 20 threads for 600 seconds,
performing only SELECT queries against the pgbench database to 
evaluate performance under read-intensive workloads:

$ pgbench -c 224 -j 20 -T 600 -S pgbench

Latency:

|---|-------------|------------|------------|
| # | Before (ms) | After (ms) | Change (%) |
|Run| Patch       | Patch      |            |
|---|-------------|------------|------------|
| 1 | 0.343       | 0.287      | -16.31%    |
| 2 | 0.334       | 0.286      | -14.37%    |
| 3 | 0.333       | 0.286      | -14.11%    |
| 4 | 0.341       | 0.288      | -15.55%    |
| 5 | 0.342       | 0.288      | -15.79%    |
|---|-------------|------------|------------|

Latency Reduction: After applying the patch, the latency decreased
by 14% to 16% across multiple runs.

Throughput per second:

|---|-------------|------------|------------|
| # | Before      | After      | Change (%) |
|Run| Patch       | Patch      |            |
|---|-------------|------------|------------|
| 1 | 652,544.23  | 780,613.42 | +19.63%    |
| 2 | 670,243.45  | 784,348.44 | +17.04%    |
| 3 | 673,495.39  | 784,458.12 | +16.48%    |
| 4 | 656,609.16  | 778,531.20 | +18.57%    |
| 5 | 654,644.52  | 778,322.88 | +18.88%    |
|---|-------------|------------|------------|

Transactions per second Improvement: The patch led to an increase in
TPS, ranging from 16% to 19%.

This indicates that the patch significantly reduces latency while
improving throughput (TPS).  pgbench is an OLTP benchmark and doesn't
do timer based wakeups, this is in-line with the improvements
I saw in the originally reported OLTP workload as well. 

---------------------------------------------------------------------
Additional CPU Idle test with custom benchmark:
---------------------------------------------------------------------
I also wrote a simple benchmark [1] to analyze the impact of cpuidle
state selection, comparing timer-based wakeups and non-timer
(pipe-based) wakeups.

This test involves a single waker thread periodically waking up a
single wakee thread, simulating a repeating sleep-wake pattern. The
test was run with both timer-based and pipe-based wakeups, and cpuidle
statistics (usage, time, above, below) were collected.

Timer based wakeup:

+------------------------+---------------------+---------------------+
| Metric                 | Without Patch       | With Patch          |
+------------------------+---------------------+---------------------+
| Wakee thread - CPU     | 110                 | 110                 |
| Waker thread - CPU     | 20                  | 20                  |
| Sleep Interval         | 50 us               | 50 us               |
| Total Wakeups          | -                   | -                   |
| Avg Wakeup Latency     | -                   | -                   |
| Actual Sleep time      | 52.639 us           | 52.627 us           |
+------------------------+---------------------+---------------------+
| Idle State 0 Usage Diff| 94,879              | 94,879              |
| Idle State 0 Time Diff | 4,700,323 ns        | 4,697,576 ns        |
| Idle State 1 Usage Diff| 0                   | 0                   |
| Idle State 1 Time Diff | 0 ns                | 0 ns                |
+------------------------+---------------------+---------------------+
| Total Above Usage      | 0 (0.00%)           | (0.00%)             |
+------------------------+---------------------+---------------------+
| Total Below Usage      | 0 (0.00%)           | 0 (0.00%)           |
+------------------------+---------------------+---------------------+

In timer-based wakeups, the menu governor effectively predicts the idle
duration both with and without the patch. This ensures that there are
few or no instances of "Above" usage, allowing the CPU to remain in the
correct idle state.

The condition (s->target_residency_ns <= data->next_timer_ns) in the menu
governor ensures that a physical idle state is not prioritized when a
timer event is expected before the target residency of the first physical
idle state.

As a result, the patch has no impact in this case, and performance
remains stable with timer based wakeups.

Pipe based wakeup (non-timer wakeup):

+------------------------+---------------------+---------------------+
| Metric                 | Without Patch       | With Patch          |
+------------------------+---------------------+---------------------+
| Wakee thread - CPU     | 110                 | 110                 |
| Waker thread - CPU     | 20                  | 20                  |
| Sleep Interval         | 50 us               | 50 us               |
| Total Wakeups          | 97031               | 96583               |
| Avg Wakeup Latency     | 7.070 us            | 4.879 us            |
| Actual Sleep time      | 51.366 us           | 51.605 us           |
+------------------------+---------------------+---------------------+
| Idle State 0 Usage Diff| 1209                | 96,586              |
| Idle State 0 Time Diff | 55,579 ns           | 4,510,003 ns        |
| Idle State 1 Usage Diff| 95,826              | 5                   |
| Idle State 1 Time Diff | 4,522,639 ns        | 198 ns              |
+------------------------+---------------------+---------------------+
+------------------------+---------------------+---------------------+
| **Total Above Usage**  | 95,824 (98.75%)     | 5 (0.01%)           |
+------------------------+---------------------+---------------------+     
+------------------------+---------------------+---------------------+
| Total Below Usage      | 0 (0.00%)           | 0 (0.00%)           |
+------------------------+---------------------+---------------------+

In the pipe-based wakeup scenario, before the patch was applied, the 
"Above" metric was notably high around 98.75%. This suggests that the
menu governor frequently selected a deeper idle state like CEDE, even
when the idle period was relatively short.

This happened because the menu governor is inclined to prioritize the
physical idle state (CEDE) even when the target residency time of the
physical idle state (s->target_residency_ns) was longer than the
predicted idle time (predicted_ns), so data->next_timer_ns won't be
relevant here in non-timer wakeups.

In this test, despite the actual idle period being around 50 microseconds,
the menu governor still chose CEDE state, which has a target residency of
120 microseconds.

---------------------------------------------------------------------

While timer-based wakeups performed well even without the patch, workloads
that don't have timers as wakeup source but have predictable idle durations
shorter than the first idle state's target residency benefit significantly
from the patch.

It will be helpful to understand why prioritizing deep physical idle
states over shallow ones even for short idle periods that don’t meet
the target residency like mentioned above is considered more beneficial.

Is there something I could be missing here?

Any comments or suggestions will be really helpful.

[1] https://github.com/AboorvaDevarajan/linux-utils/tree/main/cpuidle/cpuidle_wakeup

Thanks,
Aboorva


