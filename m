Return-Path: <linux-pm+bounces-16056-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF8B9A59B4
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 07:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5AF282545
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 05:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759EE193428;
	Mon, 21 Oct 2024 05:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B+UJAAsb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317EAA41;
	Mon, 21 Oct 2024 05:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729488462; cv=none; b=eyhRPSxI8Z6vvOzflxP46Wa5UKT0KhsH4xrmuBBJ+O1v9N8hFMO2CAY6w+kQJVRZ9FWm+EZDB5yaA1ryj8qrIpodWeXceWNr/DS9PWFd8TFpTRjQ0UA8jiwYBNbteRfbUOjRatIlycSVH+/42X0VlQGWzDn4IuTF6fA2QSIZkXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729488462; c=relaxed/simple;
	bh=InRyiTb6nxPAWDnRP0xzYkrqk7J91zSaCIZ7cWHYTe0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kONvQsGsN9nCnEBxKGvYidWfhnHHEDkx+pp6ZmunmBXnCQVS8jxpktW8oBhK7KqU0jeJwgLu9CKgO57mICR+mxzw7H2m6u/rY1roxNGm+jVyjAoUiWym3xhCPIyai3Lsrpl3RBAA25/ATdUesievG1ihqG2XNWtDDhv1UIZaByg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B+UJAAsb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L2KKJA032591;
	Mon, 21 Oct 2024 05:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0DtSUH
	2xpDnSTxYmcBKHaWr0ThCq7vlTDn3zKKpv0K8=; b=B+UJAAsbzx7CjHaBhrL2Su
	kr7ugdPN/o5MmdEaXGTw42wtG5InY3w/MfyoHWN4Fas7t4q4aRMBkt3nvrgD0Rnp
	aIf3Q/l6op7Qm/9lNGD7UVYAyygfGQgkdS0z9OJnLmjnXmDPzJRC6whHFiTHciaA
	hHOCh5glE8JCX+w6rR1YkKc1JOrzf4nCsZr95NB32QErPviUf9hVavjmGG2wQlQx
	izNZd4DqqrCQ4xlqa7+Y4+7fsdMRXS7fT8b5mCS9TO+mij2xK1sEpNVeqzK1VxSa
	IOmbd8G4TK6sasjtlmLTxgd+CsOEY8T7k4eo4hJK2KN8+wSIgHnM18nDAQ8KouCw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5hm767f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 05:27:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49L0aB1Z018613;
	Mon, 21 Oct 2024 05:27:25 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42csaj4a9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 05:27:25 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49L5ROKq24248962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 05:27:24 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B7B858055;
	Mon, 21 Oct 2024 05:27:24 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D14A55805B;
	Mon, 21 Oct 2024 05:27:20 +0000 (GMT)
Received: from li-34d1fccc-27cd-11b2-a85c-c167793e56f7.ibm.com (unknown [9.171.58.205])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Oct 2024 05:27:20 +0000 (GMT)
Message-ID: <20f31d99374ef1ffa7dc7fc1a609074009742e00.camel@linux.ibm.com>
Subject: Re: [PATCH 0/1] cpuidle/menu: Address performance drop from
 favoring physical over polling cpuidle state
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Christian Loehle <christian.loehle@arm.com>, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: gautam@linux.ibm.com
Date: Mon, 21 Oct 2024 10:57:18 +0530
In-Reply-To: <6ae997ca-9712-4497-b666-11b976b1816d@arm.com>
References: <20240809073120.250974-1-aboorvad@linux.ibm.com>
	 <93d9ffb2-482d-49e0-8c67-b795256d961a@arm.com>
	 <9e5ef8ab0f0f3e7cb128291cd60591e3d07b33e4.camel@linux.ibm.com>
	 <4c897ab4-d592-427b-9a97-79c2b14d5c46@arm.com>
	 <6371848e9c260743f381be6e0114743ffab5e5bb.camel@linux.ibm.com>
	 <6ae997ca-9712-4497-b666-11b976b1816d@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-26.el8_10) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oSsYabgKE4Yaf22lNd7QzAiyBvsTPHJx
X-Proofpoint-GUID: oSsYabgKE4Yaf22lNd7QzAiyBvsTPHJx
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 phishscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210035

On Thu, 2024-09-19 at 09:49 +0100, Christian Loehle wrote:


Hi Christian, 

> On 9/19/24 06:02, Aboorva Devarajan wrote:
> > On Wed, 2024-08-21 at 11:55 +0100, Christian Loehle wrote:
> > 
> > > On 8/20/24 09:51, Aboorva Devarajan wrote:
> > > > On Tue, 2024-08-13 at 13:56 +0100, Christian Loehle wrote:
> > > > 
> > ...
> > > The wakeup source(s), since they don't seem to be timer events would be
> > > interesting, although a bit of a hassle to get right. 
> > > What's the workload anyway?
> > > 
> > 
> > I identified the part of the internal workload responsible for performance
> > improvement with the patch and it appears to be the OLTP queries, and yes
> > the wakeup sources are not timer events.
> > 
> > ---------------------------------------------------------------------
> > 
> > Additionally to reproduce the issue using a more open and accessible
> > benchmark, conducted similar experiments using pgbench and I observed
> > similar improvements with the patch, particularly when running the
> > read intensive select query benchmarks.
> > 
> > ---------------------------------------------------------------------
> > System Details
> > ---------------------------------------------------------------------
> > $ lscpu
> > Architecture:             ppc64le
> >   Byte Order:             Little Endian
> > CPU(s):                   224
> >   On-line CPU(s) list:    0-223
> > Model name:               POWER10 (architected), altivec supported
> >   Model:                  2.0 (pvr 0080 0200)
> >   Thread(s) per core:     8
> >   Core(s) per socket:     3
> >   Socket(s):              8
> > Virtualization features:  
> >   Hypervisor vendor:      pHyp
> >   Virtualization type:    para
> > ---------------------------------------------------------------------
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
> > 
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
> > ---------------------------------------------------------------------
> > PostgreSQL Benchmark:
> > ---------------------------------------------------------------------
> > 
> > I ran pgbench with 224 clients and 20 threads for 600 seconds,
> > performing only SELECT queries against the pgbench database to 
> > evaluate performance under read-intensive workloads:
> > 
> > $ pgbench -c 224 -j 20 -T 600 -S pgbench
> > 
> > Latency:
> > 
> > > ---|-------------|------------|------------|
> > >  # | Before (ms) | After (ms) | Change (%) |
> > > Run| Patch       | Patch      |            |
> > > ---|-------------|------------|------------|
> > >  1 | 0.343       | 0.287      | -16.31%    |
> > >  2 | 0.334       | 0.286      | -14.37%    |
> > >  3 | 0.333       | 0.286      | -14.11%    |
> > >  4 | 0.341       | 0.288      | -15.55%    |
> > >  5 | 0.342       | 0.288      | -15.79%    |
> > > ---|-------------|------------|------------|
> > 
> > Latency Reduction: After applying the patch, the latency decreased
> > by 14% to 16% across multiple runs.
> > 
> > Throughput per second:
> > 
> > > ---|-------------|------------|------------|
> > >  # | Before      | After      | Change (%) |
> > > Run| Patch       | Patch      |            |
> > > ---|-------------|------------|------------|
> > >  1 | 652,544.23  | 780,613.42 | +19.63%    | 
> > >  2 | 670,243.45  | 784,348.44 | +17.04%    |
> > >  3 | 673,495.39  | 784,458.12 | +16.48%    |
> > >  4 | 656,609.16  | 778,531.20 | +18.57%    |
> > >  5 | 654,644.52  | 778,322.88 | +18.88%    |
> > > ---|-------------|------------|------------|
> 
> Do you happen to have the idle stats here, too?
> Especially above/below see comment below.

I ran the benchmark again and collected the idle statistics on a different
system since I no longer have access to the previous one.

Here are the stats I gathered, including data for the menu, teo, and ladder governors:

Metric                        | Ladder        | Teo           | Menu          | Menu Patched
--------------------------------------------------------------------------------------------
Transactions Processed        | 42,902,188    | 48,499,709    | 42,653,477    | 48,648,867   
Latency (ms)                  | 0.313         | 0.277         | 0.315         | 0.276        
TPS                           | 715,340.96    | 808,672.59    | 711,123.13    | 811,137.40  
--------------------------------------------------------------------------------------------
Total Usage Difference        | 46,680,184    | 66,348,992    | 47,892,509    | 62,366,337
Usage Diff (CEDE)             | 46,680,184    | 7,612,960     | 45,421,436    | 19,237,430
Usage Diff (Snooze)           | 0             | 58,736,032    | 2,471,073     | 43,128,907
--------------------------------------------------------------------------------------------
Total Time Difference (s)     | 5,552.20      | 5,242.75      | 5,534.62      | 5,238.46     
Time Diff (CEDE)              | 5,552.20      | 2,497.89      | 5,431.91      | 3,324.99
Time Diff (Snooze)            | 0.00          | 2,744.86      | 102.71        | 1,913.47
--------------------------------------------------------------------------------------------
Total Above Diff              | 40,381,398    | 4,520,998     | 38,942,725    | 15,072,345
Above Diff (CEDE)             | 40,381,398    | 4,520,998     | 38,942,725    | 15,072,345
Above Diff (Snooze)           | 0             | 0             | 0             | 0
--------------------------------------------------------------------------------------------
Total Below Diff              | 0             | 12,362,392    | 405,357       | 8,172,845
Below Diff (CEDE)             | 0             | 0             | 0             | 0
Below Diff (Snooze)           | 0             | 12,362,392    | 405,357       | 8,172,845
--------------------------------------------------------------------------------------------
% Above w.r.t. Usage          | 86.51%        | 6.82%         | 81.30%        | 24.17%
--------------------------------------------------------------------------------------------
% Below w.r.t. Usage          | 0%            | 18.64%        | 0.85%         | 13.10%
--------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------

Note:

% Above w.r.t Usage = (Total Above Difference / Total Usage Difference) * 100
% Below w.r.t Usage = (Total Below Difference / Total Usage Difference) * 100


Menu, Teo, Ladder: This is with menu, teo and ladder governor enabled respectively on v6.12-rc1.

Menu Patched: This is with menu governor enabled on v6.12-rc + 
              https://lore.kernel.org/all/20240809073120.250974-2-aboorvad@linux.ibm.com/
--------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------
Inference:
--------------------------------------------------------------------------------------------

Transactions Processed: The number of transactions processed in Menu Patched is
14.06% higher compared to Menu.

Latency: There is a 12.38% reduction in latency in Menu Patched compared to Menu.

TPS (Transactions Per Second): The TPS in Menu Patched is 14.06% higher than in
Menu.
--------------------------------------------------------------------------------------------

While this patch hasn't completely eliminated the cpuidle miss ratio, but it
has improved see Above w.r.t Usage, Below w.r.t Usage.

I'll keep investigating why there's still a 24% miss rate in the "above" and
13% in the "below" stats after the patch. This could be a different issue.
Additionally, I've seen good performance improvements using the teo governor
with the pgbench benchmark, although it didn't provide the same benefit in the
original test.

> 
> > Transactions per second Improvement: The patch led to an increase in
> > TPS, ranging from 16% to 19%.
> > 
> > This indicates that the patch significantly reduces latency while
> > improving throughput (TPS).  pgbench is an OLTP benchmark and doesn't
> > do timer based wakeups, this is in-line with the improvements
> > I saw in the originally reported OLTP workload as well. 
> > 
> > ---------------------------------------------------------------------
> > Additional CPU Idle test with custom benchmark:
> > ---------------------------------------------------------------------
> > I also wrote a simple benchmark [1] to analyze the impact of cpuidle
> > state selection, comparing timer-based wakeups and non-timer
> > (pipe-based) wakeups.
> > 
> > This test involves a single waker thread periodically waking up a
> > single wakee thread, simulating a repeating sleep-wake pattern. The
> > test was run with both timer-based and pipe-based wakeups, and cpuidle
> > statistics (usage, time, above, below) were collected.
> 
> Thanks, pretty cool and just quickly checking it seems to be all there:
> hrtimer, different cpusets for wakee and waker, the pipe wakeup.
> That could be useful, only thing missing is the license header ;)

sure, I will add this. Thanks for pointing it out.

> 
> > Timer based wakeup:
> > 
> > +------------------------+---------------------+---------------------+
> > > Metric                 | Without Patch       | With Patch          |
> > +------------------------+---------------------+---------------------+
> > > Wakee thread - CPU     | 110                 | 110                 |
> > > Waker thread - CPU     | 20                  | 20                  |
> > > Sleep Interval         | 50 us               | 50 us               |
> > > Total Wakeups          | -                   | -                   |
> > > Avg Wakeup Latency     | -                   | -                   |
> > > Actual Sleep time      | 52.639 us           | 52.627 us           |
> > +------------------------+---------------------+---------------------+
> > > Idle State 0 Usage Diff| 94,879              | 94,879              |
> > > Idle State 0 Time Diff | 4,700,323 ns        | 4,697,576 ns        |
> > > Idle State 1 Usage Diff| 0                   | 0                   |
> > > Idle State 1 Time Diff | 0 ns                | 0 ns                |
> > +------------------------+---------------------+---------------------+
> > > Total Above Usage      | 0 (0.00%)           | (0.00%)             |
> > +------------------------+---------------------+---------------------+
> > > Total Below Usage      | 0 (0.00%)           | 0 (0.00%)           |
> > +------------------------+---------------------+---------------------+
> > 
> > In timer-based wakeups, the menu governor effectively predicts the idle
> > duration both with and without the patch. This ensures that there are
> > few or no instances of "Above" usage, allowing the CPU to remain in the
> > correct idle state.
> > 
> > The condition (s->target_residency_ns <= data->next_timer_ns) in the menu
> > governor ensures that a physical idle state is not prioritized when a
> > timer event is expected before the target residency of the first physical
> > idle state.
> > 
> > As a result, the patch has no impact in this case, and performance
> > remains stable with timer based wakeups.
> > 
> > Pipe based wakeup (non-timer wakeup):
> > 
> > +------------------------+---------------------+---------------------+
> > > Metric                 | Without Patch       | With Patch          |
> > +------------------------+---------------------+---------------------+
> > > Wakee thread - CPU     | 110                 | 110                 |
> > > Waker thread - CPU     | 20                  | 20                  |
> > > Sleep Interval         | 50 us               | 50 us               |
> > > Total Wakeups          | 97031               | 96583               |
> > > Avg Wakeup Latency     | 7.070 us            | 4.879 us            |
> > > Actual Sleep time      | 51.366 us           | 51.605 us           |
> > +------------------------+---------------------+---------------------+
> > > Idle State 0 Usage Diff| 1209                | 96,586              |
> > > Idle State 0 Time Diff | 55,579 ns           | 4,510,003 ns        |
> > > Idle State 1 Usage Diff| 95,826              | 5                   |
> > > Idle State 1 Time Diff | 4,522,639 ns        | 198 ns              |
> > +------------------------+---------------------+---------------------+
> > +------------------------+---------------------+---------------------+
> > > **Total Above Usage**  | 95,824 (98.75%)     | 5 (0.01%)           |
> > +------------------------+---------------------+---------------------+     
> > +------------------------+---------------------+---------------------+
> > > Total Below Usage      | 0 (0.00%)           | 0 (0.00%)           |
> > +------------------------+---------------------+---------------------+
> > 
> > In the pipe-based wakeup scenario, before the patch was applied, the 
> > "Above" metric was notably high around 98.75%. This suggests that the
> > menu governor frequently selected a deeper idle state like CEDE, even
> > when the idle period was relatively short.
> > 
> > This happened because the menu governor is inclined to prioritize the
> > physical idle state (CEDE) even when the target residency time of the
> > physical idle state (s->target_residency_ns) was longer than the
> > predicted idle time (predicted_ns), so data->next_timer_ns won't be
> > relevant here in non-timer wakeups.
> > 
> > In this test, despite the actual idle period being around 50 microseconds,
> > the menu governor still chose CEDE state, which has a target residency of
> > 120 microseconds.
> 
> And the idle_miss statistics confirms that this was mostly wrong decisions
> in hindsight.
> I'll go through the menu code again, this indeed shouldn't be happening.
> I'd be very surprised if upstream teo performed as badly (or actually badly
> at all) on this, although it doesn't seem to help your actual workload,
> would you mind giving that a try too?


I ran a similar benchmark using teo cpuidle governor, presented the averaged out
values across 10 runs (has low standard deviation). Below are the results for a
pipe-based wakeup with an approximate 50 microsecond sleep interval:


Pipe based wakeup with approx 50 us as sleep interval:

Metric                    Ladder           Menu            Teo              Menu Patched
----------------------------------------------------------------------------------------
Wakeups                   579,690          579,951         578,328          578,363
Avg wakeup latency (us)   7.456            7.112           4.46067          4.48733
========================================================================================
Sleep interval (us)       51.7333          51.7097         51.8533          51.8477
========================================================================================
State 0 Usage diff        0                7,324           578,361          578,407
State 0 Time diff (ns)    0                340,115         2.75953e+07      2.75696e+07
State 0 Above diff        0                0               0                0
State 0 Below diff        0                0               0.333333         0.666667
========================================================================================
State 1 Usage diff        580,114          572,644         0.666667         9.33333
State 1 Time diff (ns)    2.74189e+07      2.73901e+07     20.6667          445.333
State 1 Above diff        579,993          572,535         0.666667         9.33333
State 1 Below diff        0                0               0                0
Total Above               579,993          572,535         0.666667         9.33333
Total Below               0                0               0.333333         0.666667
========================================================================================
Total Above Percent       99.98%           98.7167%        0%               0%             --> [1]
Total Below Percent       0%               0%              0%               0%
========================================================================================

Timer based wakeup with approx 50 us as sleep interval:

Metric                    Ladder           Menu            Teo              Menu Patched
----------------------------------------------------------------------------------------
Sleep interval (us)        53.775           52.3687         52.746           52.327
========================================================================================
State 0 Usage diff         0                572,575         568,419          573,109
State 0 Time diff (ns)     0                2.84142e+07     2.81956e+07      2.84548e+07
State 0 Above diff         0                0               0                0
State 0 Below diff         0                0.333333        1                0.333333
========================================================================================
State 1 Usage diff         558,285          0.333333        0                0
State 1 Time diff (ns)     2.80965e+07      17              0                0
State 1 Above diff         558,215          0.333333        0                0
State 1 Below diff         0                0               0                0
========================================================================================
Total Above                558,215          0.333333        0                0
Total Below                0                0.333333        1                0.333333
========================================================================================
Total Above Percent        99.99%           0%              0%               0%
Total Below Percent        0%               0%              0%               0%
========================================================================================


[1] The results does show that the teo governor doesn't have this issue.

> 
> Regards,
> Christian
> 
> > ---------------------------------------------------------------------
> > 
> > While timer-based wakeups performed well even without the patch, workloads
> > that don't have timers as wakeup source but have predictable idle durations
> > shorter than the first idle state's target residency benefit significantly
> > from the patch.
> > 
> > It will be helpful to understand why prioritizing deep physical idle
> > states over shallow ones even for short idle periods that don’t meet
> > the target residency like mentioned above is considered more beneficial.
> > 
> > Is there something I could be missing here?
> > 
> > Any comments or suggestions will be really helpful.
> > 
> > [1] https://github.com/AboorvaDevarajan/linux-utils/tree/main/cpuidle/cpuidle_wakeup
> > 
> > Thanks,
> > Aboorva
> > 


