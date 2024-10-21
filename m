Return-Path: <linux-pm+bounces-16061-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EA29A5DE4
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 10:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20DD1F21B3B
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 08:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE541E1333;
	Mon, 21 Oct 2024 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i32q+Wgi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD48196DA4;
	Mon, 21 Oct 2024 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729497752; cv=none; b=Bi0PHoDR43v9UIpcbNFubcJ07OHnEgJSb0xD7+T5ipYLfuXkLfZ/p+u/w1ojv4flddseIsjhbld2PMAyqLDlzjs2roonIoeBP2Nnb+CZOt0DwZMmT/isjGasEJVm1S0a/AAuVZXboBAlV6vO4wEJ5tqwYxY1E2480z8r6LO9zyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729497752; c=relaxed/simple;
	bh=0kYuio+QVYSBlJ8mioFtvDmpKsomlYegPaCTxkBDM38=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=NsX3RFAUp5CvCGYC8pxuqh3Zxwtt97sqqn/Sd6OYXGgI+fiLnvJze/fHCTkeDkFsJNEPMdXbayIS8eyI8SYapetu1sjMLUw9KcCBlSXqmgds37tWU+AhcrEAeJJWUZLwChthz6+fcHeE1XKTMsE/s8+KzRwlmV3ktbGuHRsHiYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i32q+Wgi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L2KKTs032591;
	Mon, 21 Oct 2024 08:02:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gSTkTm
	rLhposA8ULxDR6s6PKhbG0aSU5kiVfb52v1Jg=; b=i32q+Wgi07hQEJxSldFfIz
	U1rKMuTRe4afXfpOo7+ALUxpBevSUzc2x7u5L5JCNvAcC84wfNoTzQnX7cz4XIe+
	KHrVOL47W282BoL/jYxBbqmWhsWTQlhTF5maP5Pd7IqtosiOq1hqLQBxLRDYqAr+
	s/2siPa7C1ByPejkTBZch6I9WIUwcp605IpbeU+uJlP1BOKEiuUn9h7oMO6OOJNa
	bbN8t/d/jA0eOjKcDSp4QVIKPYE9yru0LHwSJGF/4OuocqO+kiX8d82uiLM06X2+
	7+gDCkqQJkh19i24WUF4S/RgkggPUOm/8+PMhQQlNE0buN4JEGNajVWqmaQgv3/A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5hm7udr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 08:02:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49L80YI1028870;
	Mon, 21 Oct 2024 08:02:21 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42cqfxd8c7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 08:02:21 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49L82JOZ52625694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 08:02:20 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAECB58053;
	Mon, 21 Oct 2024 08:02:19 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B1C058059;
	Mon, 21 Oct 2024 08:02:17 +0000 (GMT)
Received: from li-34d1fccc-27cd-11b2-a85c-c167793e56f7.ibm.com (unknown [9.204.200.131])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Oct 2024 08:02:16 +0000 (GMT)
Message-ID: <96960c17eb8325973dcb907fa19533ee1130e2a2.camel@linux.ibm.com>
Subject: Re: [PATCH 0/1] cpuidle/menu: Address performance drop from
 favoring physical over polling cpuidle state
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Christian Loehle <christian.loehle@arm.com>, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: gautam@linux.ibm.com, aboorvad@linux.ibm.com
Date: Mon, 21 Oct 2024 13:32:15 +0530
In-Reply-To: <f951ac01-d074-41b6-b7a6-689f6146faf4@arm.com>
References: <20240809073120.250974-1-aboorvad@linux.ibm.com>
	 <93d9ffb2-482d-49e0-8c67-b795256d961a@arm.com>
	 <9e5ef8ab0f0f3e7cb128291cd60591e3d07b33e4.camel@linux.ibm.com>
	 <4c897ab4-d592-427b-9a97-79c2b14d5c46@arm.com>
	 <6371848e9c260743f381be6e0114743ffab5e5bb.camel@linux.ibm.com>
	 <6ae997ca-9712-4497-b666-11b976b1816d@arm.com>
	 <592a0c06-a23c-464a-9f67-2ce8ce91a306@arm.com>
	 <964275d1-5f31-4eef-8dcd-fa8f11dbb830@arm.com>
	 <f951ac01-d074-41b6-b7a6-689f6146faf4@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-26.el8_10) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UBVBYcs3_i7N_xZ_aPl6oQ8ejexWz3lc
X-Proofpoint-GUID: UBVBYcs3_i7N_xZ_aPl6oQ8ejexWz3lc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210056

On Thu, 2024-09-19 at 15:38 +0100, Christian Loehle wrote:
> On 9/19/24 15:07, Christian Loehle wrote:
> > On 9/19/24 10:43, Christian Loehle wrote:
> > > On 9/19/24 09:49, Christian Loehle wrote:
> > > > On 9/19/24 06:02, Aboorva Devarajan wrote:
> > > > > On Wed, 2024-08-21 at 11:55 +0100, Christian Loehle wrote:
> > > > > Timer based wakeup:
> > > > > 
> > > > > +------------------------+---------------------+---------------------+
> > > > > > Metric                 | Without Patch       | With Patch          |
> > > > > +------------------------+---------------------+---------------------+
> > > > > > Wakee thread - CPU     | 110                 | 110                 |
> > > > > > Waker thread - CPU     | 20                  | 20                  |
> > > > > > Sleep Interval         | 50 us               | 50 us               |
> > > > > > Total Wakeups          | -                   | -                   |
> > > > > > Avg Wakeup Latency     | -                   | -                   |
> > > > > > Actual Sleep time      | 52.639 us           | 52.627 us           |
> > > > > +------------------------+---------------------+---------------------+
> > > > > > Idle State 0 Usage Diff| 94,879              | 94,879              |
> > > > > > Idle State 0 Time Diff | 4,700,323 ns        | 4,697,576 ns        |
> > > > > > Idle State 1 Usage Diff| 0                   | 0                   |
> > > > > > Idle State 1 Time Diff | 0 ns                | 0 ns                |
> > > > > +------------------------+---------------------+---------------------+
> > > > > > Total Above Usage      | 0 (0.00%)           | (0.00%)             |
> > > > > +------------------------+---------------------+---------------------+
> > > > > > Total Below Usage      | 0 (0.00%)           | 0 (0.00%)           |
> > > > > +------------------------+---------------------+---------------------+
> > > > > 
> > > > > In timer-based wakeups, the menu governor effectively predicts the idle
> > > > > duration both with and without the patch. This ensures that there are
> > > > > few or no instances of "Above" usage, allowing the CPU to remain in the
> > > > > correct idle state.
> > > > > 
> > > > > The condition (s->target_residency_ns <= data->next_timer_ns) in the menu
> > > > > governor ensures that a physical idle state is not prioritized when a
> > > > > timer event is expected before the target residency of the first physical
> > > > > idle state.
> > > > > 
> > > > > As a result, the patch has no impact in this case, and performance
> > > > > remains stable with timer based wakeups.
> > > > > 
> > > > > Pipe based wakeup (non-timer wakeup):
> > > > > 
> > > > > +------------------------+---------------------+---------------------+
> > > > > > Metric                 | Without Patch       | With Patch          |
> > > > > +------------------------+---------------------+---------------------+
> > > > > > Wakee thread - CPU     | 110                 | 110                 |
> > > > > > Waker thread - CPU     | 20                  | 20                  |
> > > > > > Sleep Interval         | 50 us               | 50 us               |
> > > > > > Total Wakeups          | 97031               | 96583               |
> > > > > > Avg Wakeup Latency     | 7.070 us            | 4.879 us            |
> > > > > > Actual Sleep time      | 51.366 us           | 51.605 us           |
> > > > > +------------------------+---------------------+---------------------+
> > > > > > Idle State 0 Usage Diff| 1209                | 96,586              |
> > > > > > Idle State 0 Time Diff | 55,579 ns           | 4,510,003 ns        |
> > > > > > Idle State 1 Usage Diff| 95,826              | 5                   |
> > > > > > Idle State 1 Time Diff | 4,522,639 ns        | 198 ns              |
> > > > > +------------------------+---------------------+---------------------+
> > > > > +------------------------+---------------------+---------------------+
> > > > > > **Total Above Usage**  | 95,824 (98.75%)     | 5 (0.01%)           |
> > > > > +------------------------+---------------------+---------------------+     
> > > > > +------------------------+---------------------+---------------------+
> > > > > > Total Below Usage      | 0 (0.00%)           | 0 (0.00%)           |
> > > > > +------------------------+---------------------+---------------------+
> > > > > 
> > > > > In the pipe-based wakeup scenario, before the patch was applied, the 
> > > > > "Above" metric was notably high around 98.75%. This suggests that the
> > > > > menu governor frequently selected a deeper idle state like CEDE, even
> > > > > when the idle period was relatively short.
> > > > > 
> > > > > This happened because the menu governor is inclined to prioritize the
> > > > > physical idle state (CEDE) even when the target residency time of the
> > > > > physical idle state (s->target_residency_ns) was longer than the
> > > > > predicted idle time (predicted_ns), so data->next_timer_ns won't be
> > > > > relevant here in non-timer wakeups.
> > > > > 
> > > > > In this test, despite the actual idle period being around 50 microseconds,
> > > > > the menu governor still chose CEDE state, which has a target residency of
> > > > > 120 microseconds.
> > > > 
> > > > And the idle_miss statistics confirms that this was mostly wrong decisions
> > > > in hindsight.
> > > > I'll go through the menu code again, this indeed shouldn't be happening.
> > > > I'd be very surprised if upstream teo performed as badly (or actually badly
> > > > at all) on this, although it doesn't seem to help your actual workload,
> > > > would you mind giving that a try too?
> > > > 
> > > > Regards,
> > > > Christian
> > > 
> > > So with a workload as static as this, the recent interval detection of menu
> > > should take affect. It records the last 8 idle interval lengths and does some
> > > statistics do see if they are somewhat stable and uses those instead of the
> > > next timer event.
> > > While I wouldn't vouch for the statistics just yet, the results don't seem
> > > to be completely unreasonable.
> > > Do you mind trying a) printing some snapshots of these intervals and the
> > > resulting return value of get_typical_interval()?
> > > b) Trying this out? Setting these values to some around 50us, that returns
> > > 50us for me as expected and therefore should not select an idle state above
> > > that.
> > > 
> > > -->8--
> > > 
> > > --- a/drivers/cpuidle/governors/menu.c
> > > +++ b/drivers/cpuidle/governors/menu.c
> > > @@ -112,6 +112,8 @@ struct menu_device {
> > >         int             interval_ptr;
> > >  };
> > >  
> > > +static int intervals_dummy[] = {50, 52, 48, 50, 51, 49, 51, 51};
> > 
> > So just to illustrate this a bit more:
> > {51, 80, 90, 54, 72, 60, 80, 117} is insignificant, but decrementing the last:
> > {51, 80, 90, 54, 72, 60, 80, 116} is significant (75us returned)
> > That sounds about reasonable but I think something like that would
> > also be observable for you. It's an unfortunate edge case.
> > I wouldn't want to mess with the ancient statistics (and silently break
> > an unknown amount of setups). I much prefer the teo intercept approach that
> > makes this idle state dependent and doesn't try to get one formula right
> > for all setups.
> > 
> > That is all assuming that a) get_typical_interval() doesn't return a
> > significant interval length for you and b) replacing that with dummy
> > significant values then fixes it (and not the error being some menu
> > logic that I overlooked).
> > 
> > Thinking out loud regarding the menu logic:
> > If we have ~50us predicted interval and your state setup the code then
> > goes as follows:
> > 
> > predicted_ns = 50000
> > ...
> > data->next_timer_ns = KTIME_MAX; 
> > delta_tick = TICK_NSEC / 2;  
> > data->bucket = which_bucket(KTIME_MAX, nr_iowaiters); // bucket highest state probably
> > 
> > And then we have the big for loop for state 0 POLLING and state 1 CEDE target_residency_ns==100000:
> > trivially we have for i = 0:
> > 	if (idx == -1)                                                  
> > 		idx = i; /* first enabled state */
> > and for i = 1:
> > 	if (s->target_residency_ns > predicted_ns) { // True
> > ...
> > 		if (predicted_ns < TICK_NSEC) // True                      
> > 			break;
> > and should end up with idx == 0 and *stop_tick = false, all good.
> > If my above assumptions in a) and b) do not hold then I must've made a
> > mistake reading the code just now.
> > 
> 
> And of course I realise right after sending I did indeed make a mistake.
> RESIDENCY_THRESHOLD_NS is 15us so timer is actually polled and the fields
> populated accurately, but also in the for loop it checks polling for idx == 0.
> predicted_ns should still be the value from get_typical_interval(), but
> that is unable to ever enforce a polling state, making your proposed code
> change the only obvious fix.

> Essentially with only one non-polling state the get_typical_interval()
> logic might as well be skipped, it never affects anything.
> 
> If I'm correct this time then I'm not really sure how to proceed.
> On the one hand, if we trust predicted_ns we should indeed select a state
> with predicted_ns < s->target_residency_ns, no matter if polling or not,
> but that would be quite a behaviour change for x86 users too.

That's right, so far this is the only solution I can think of that
improves performance, But, I'm open to trying alternative suggestions
if any.
> 
> I'm still curious on why teo wouldn't solve your problem, it's intercept
> logic doesn't care if it selects a polling state or not because of it.
> 
I confirmed that "teo" doesn't have the reported issue, and when compared
to the  vanilla menu governor switching to "teo" does improve the performance
of some workloads, though not the original workload I tested. I'll look into
why that's the case.

However, we would still want to resolve the issue with the menu governor,
as it's the default governor currently enabled and have been tested so
far. While switching to "teo" could be an option in the future.

Thanks,
Aboorva


