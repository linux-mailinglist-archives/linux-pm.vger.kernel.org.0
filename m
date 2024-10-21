Return-Path: <linux-pm+bounces-16059-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EA79A5D4A
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 09:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027401C22955
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 07:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93DE1E04AA;
	Mon, 21 Oct 2024 07:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IjKD/Qjs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6A81E0495;
	Mon, 21 Oct 2024 07:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729496432; cv=none; b=BjD+xfYRBh5OFUqXpWb6zwpTUYx5yrA9VL7MbJQEBq1swT+avK/fmsY8Hmkbjh1yzOMNUrZMPED2dMjIkkxLfnWTGZmudEQaN5BNQ8rBy/SqJ51fyIp9S3oOewpfTnB49Pz584oY0dS7PHAXM8CwPRX9QKgIZ18K5NqufOsfsPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729496432; c=relaxed/simple;
	bh=QiIPymE3ZW6IOXyQoxjWyZYV/W6QsQuSXjp7drmGROM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=TuC7g6Z0JFhl3+sNujXxiVJqrYyG0NGHiKsQqImYvm7tQ/SeibK+D2uTapHY8KMscgQKo8TQH8nKCySN8AOqhhFCa19EPDMQjZWob7qWeqYxiPKIhcNj83wUYqPi4cyd97zR/XNM7FEs1oGioIv0SdgjFpfRJlMpZ6fSL1eGTaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IjKD/Qjs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L2KIuf027007;
	Mon, 21 Oct 2024 07:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iRjicH
	T5sNiJ7stSdEwnUbhIly6y7KXNNE8Iny8eH/M=; b=IjKD/QjspIskdv8L9VzZcG
	z8twOZQAS56/i53E18pEKwxIQayT12CnRMpDT2oK2qi/+Ce2pYu1OZoUGT1CF1S9
	2haYZMGkqpB9nSXN+sn7SxeiMlc2nz/BC5u0LtqciUEelLt3E99VSUg27+0bgGQp
	j88GrM0J0/o00YSBa64KxXY7/E1dFCyhkN6S+GVruW7vdFMxRvVornOB8DZnnncN
	RBfxPapPt5d0JtyAARdsqW+TCUC5hHn9FlfTvqM014lLK6nHbwp2+MPiNMmOy+Bt
	ubqryUVdeaWMvPhI3q0ODv50QlOtMJXP9Yj2lU3yCp6tCL3VmFdOg7jfWCwdf1kg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5fcf9t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 07:40:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49L5nL3i018554;
	Mon, 21 Oct 2024 07:40:22 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42csaj4tfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 07:40:22 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49L7eLNd50397522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 07:40:21 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E43E558060;
	Mon, 21 Oct 2024 07:40:20 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE8A95805A;
	Mon, 21 Oct 2024 07:40:18 +0000 (GMT)
Received: from li-34d1fccc-27cd-11b2-a85c-c167793e56f7.ibm.com (unknown [9.204.200.131])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Oct 2024 07:40:18 +0000 (GMT)
Message-ID: <46f92f23aaff45a67a95aa8c83e3cf00bb96d3cf.camel@linux.ibm.com>
Subject: Re: [PATCH 0/1] cpuidle/menu: Address performance drop from
 favoring physical over polling cpuidle state
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Christian Loehle <christian.loehle@arm.com>, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: gautam@linux.ibm.com
Date: Mon, 21 Oct 2024 13:10:17 +0530
In-Reply-To: <592a0c06-a23c-464a-9f67-2ce8ce91a306@arm.com>
References: <20240809073120.250974-1-aboorvad@linux.ibm.com>
	 <93d9ffb2-482d-49e0-8c67-b795256d961a@arm.com>
	 <9e5ef8ab0f0f3e7cb128291cd60591e3d07b33e4.camel@linux.ibm.com>
	 <4c897ab4-d592-427b-9a97-79c2b14d5c46@arm.com>
	 <6371848e9c260743f381be6e0114743ffab5e5bb.camel@linux.ibm.com>
	 <6ae997ca-9712-4497-b666-11b976b1816d@arm.com>
	 <592a0c06-a23c-464a-9f67-2ce8ce91a306@arm.com>
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
X-Proofpoint-ORIG-GUID: 1ePUaoRWZR4IN5vn9lbiZc4s5Ec4Ylb7
X-Proofpoint-GUID: 1ePUaoRWZR4IN5vn9lbiZc4s5Ec4Ylb7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210052

On Thu, 2024-09-19 at 10:43 +0100, Christian Loehle wrote:

> On 9/19/24 09:49, Christian Loehle wrote:
> > On 9/19/24 06:02, Aboorva Devarajan wrote:
> > > On Wed, 2024-08-21 at 11:55 +0100, Christian Loehle wrote:
> > > Timer based wakeup:
> > > 
> > > +------------------------+---------------------+---------------------+
> > > > Metric                 | Without Patch       | With Patch          |
> > > +------------------------+---------------------+---------------------+
> > > > Wakee thread - CPU     | 110                 | 110                 |
> > > > Waker thread - CPU     | 20                  | 20                  |
> > > > Sleep Interval         | 50 us               | 50 us               |
> > > > Total Wakeups          | -                   | -                   |
> > > > Avg Wakeup Latency     | -                   | -                   |
> > > > Actual Sleep time      | 52.639 us           | 52.627 us           |
> > > +------------------------+---------------------+---------------------+
> > > > Idle State 0 Usage Diff| 94,879              | 94,879              |
> > > > Idle State 0 Time Diff | 4,700,323 ns        | 4,697,576 ns        |
> > > > Idle State 1 Usage Diff| 0                   | 0                   |
> > > > Idle State 1 Time Diff | 0 ns                | 0 ns                |
> > > +------------------------+---------------------+---------------------+
> > > > Total Above Usage      | 0 (0.00%)           | (0.00%)             |
> > > +------------------------+---------------------+---------------------+
> > > > Total Below Usage      | 0 (0.00%)           | 0 (0.00%)           |
> > > +------------------------+---------------------+---------------------+
> > > 
> > > In timer-based wakeups, the menu governor effectively predicts the idle
> > > duration both with and without the patch. This ensures that there are
> > > few or no instances of "Above" usage, allowing the CPU to remain in the
> > > correct idle state.
> > > 
> > > The condition (s->target_residency_ns <= data->next_timer_ns) in the menu
> > > governor ensures that a physical idle state is not prioritized when a
> > > timer event is expected before the target residency of the first physical
> > > idle state.
> > > 
> > > As a result, the patch has no impact in this case, and performance
> > > remains stable with timer based wakeups.
> > > 
> > > Pipe based wakeup (non-timer wakeup):
> > > 
> > > +------------------------+---------------------+---------------------+
> > > > Metric                 | Without Patch       | With Patch          |
> > > +------------------------+---------------------+---------------------+
> > > > Wakee thread - CPU     | 110                 | 110                 |
> > > > Waker thread - CPU     | 20                  | 20                  |
> > > > Sleep Interval         | 50 us               | 50 us               |
> > > > Total Wakeups          | 97031               | 96583               |
> > > > Avg Wakeup Latency     | 7.070 us            | 4.879 us            |
> > > > Actual Sleep time      | 51.366 us           | 51.605 us           |
> > > +------------------------+---------------------+---------------------+
> > > > Idle State 0 Usage Diff| 1209                | 96,586              |
> > > > Idle State 0 Time Diff | 55,579 ns           | 4,510,003 ns        |
> > > > Idle State 1 Usage Diff| 95,826              | 5                   |
> > > > Idle State 1 Time Diff | 4,522,639 ns        | 198 ns              |
> > > +------------------------+---------------------+---------------------+
> > > +------------------------+---------------------+---------------------+
> > > > **Total Above Usage**  | 95,824 (98.75%)     | 5 (0.01%)           |
> > > +------------------------+---------------------+---------------------+     
> > > +------------------------+---------------------+---------------------+
> > > > Total Below Usage      | 0 (0.00%)           | 0 (0.00%)           |
> > > +------------------------+---------------------+---------------------+
> > > 
> > > In the pipe-based wakeup scenario, before the patch was applied, the 
> > > "Above" metric was notably high around 98.75%. This suggests that the
> > > menu governor frequently selected a deeper idle state like CEDE, even
> > > when the idle period was relatively short.
> > > 
> > > This happened because the menu governor is inclined to prioritize the
> > > physical idle state (CEDE) even when the target residency time of the
> > > physical idle state (s->target_residency_ns) was longer than the
> > > predicted idle time (predicted_ns), so data->next_timer_ns won't be
> > > relevant here in non-timer wakeups.
> > > 
> > > In this test, despite the actual idle period being around 50 microseconds,
> > > the menu governor still chose CEDE state, which has a target residency of
> > > 120 microseconds.
> > 
> > And the idle_miss statistics confirms that this was mostly wrong decisions
> > in hindsight.
> > I'll go through the menu code again, this indeed shouldn't be happening.
> > I'd be very surprised if upstream teo performed as badly (or actually badly
> > at all) on this, although it doesn't seem to help your actual workload,
> > would you mind giving that a try too?
> > 
> > Regards,
> > Christian
> 
> So with a workload as static as this, the recent interval detection of menu
> should take affect. It records the last 8 idle interval lengths and does some
> statistics do see if they are somewhat stable and uses those instead of the
> next timer event.
> While I wouldn't vouch for the statistics just yet, the results don't seem
> to be completely unreasonable.
> Do you mind trying

> a) printing some snapshots of these intervals and the
> resulting return value of get_typical_interval()?

Christian,

Here are the stats I get when printing the intervals and corresponding predicted_ns
for an idle duration of 50 us set from user space. In this case, a pipe wakeup with
a 50 us sleep time in user space translates to approximately 34 us of CPU idle time
in the kernel, with very little deviation.

-------------------------------------------------------------------------------------
process        cpu           timestamp   trace
<idle>-0       [200] d....   123.969564: menu_select: CPU[200]: Interval[2] = 34
<idle>-0       [200] d....   123.969564: menu_select: CPU[200]: Interval[3] = 34
<idle>-0       [200] d....   123.969564: menu_select: CPU[200]: Interval[4] = 34
<idle>-0       [200] d....   123.969564: menu_select: CPU[200]: Interval[5] = 34
<idle>-0       [200] d....   123.969565: menu_select: CPU[200]: Interval[6] = 34
<idle>-0       [200] d....   123.969565: menu_select: CPU[200]: Interval[7] = 34
<idle>-0       [200] d....   123.969565: menu_select: CPU[200]: Predicted ns = 34000
<idle>-0       [200] d....   123.969615: menu_select: CPU[200]: Interval[0] = 34
<idle>-0       [200] d....   123.969616: menu_select: CPU[200]: Interval[1] = 34
<idle>-0       [200] d....   123.969616: menu_select: CPU[200]: Interval[2] = 34
<idle>-0       [200] d....   123.969616: menu_select: CPU[200]: Interval[3] = 34
<idle>-0       [200] d....   123.969616: menu_select: CPU[200]: Interval[4] = 34
<idle>-0       [200] d....   123.969616: menu_select: CPU[200]: Interval[5] = 34
<idle>-0       [200] d....   123.969616: menu_select: CPU[200]: Interval[6] = 34
<idle>-0       [200] d....   123.969616: menu_select: CPU[200]: Interval[7] = 34
<idle>-0       [200] d....   123.969617: menu_select: CPU[200]: Predicted ns = 34000
...
...
...
...
<idle>-0       [200] d....   123.969667: menu_select: CPU[200]: Interval[0] = 34
<idle>-0       [200] d....   123.969667: menu_select: CPU[200]: Interval[1] = 34
<idle>-0       [200] d....   123.969667: menu_select: CPU[200]: Interval[2] = 34
<idle>-0       [200] d....   123.969667: menu_select: CPU[200]: Interval[3] = 34
<idle>-0       [200] d....   123.969667: menu_select: CPU[200]: Interval[4] = 34
<idle>-0       [200] d....   123.969668: menu_select: CPU[200]: Interval[5] = 34
<idle>-0       [200] d....   123.969668: menu_select: CPU[200]: Interval[6] = 34
<idle>-0       [200] d....   123.969668: menu_select: CPU[200]: Interval[7] = 33
<idle>-0       [200] d....   123.969668: menu_select: CPU[200]: Predicted ns = 33000

This pattern repeats until I stop the workload.
----------------------------------------------------------------------
---------------

> b) Trying this out? Setting these values to some around 50us, that returns
> 50us for me as expected and therefore should not select an idle state above
> that.
> 
> -->8--
> 
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -112,6 +112,8 @@ struct menu_device {
>         int             interval_ptr;
>  };
>  
> +static int intervals_dummy[] = {50, 52, 48, 50, 51, 49, 51, 51};
> +
>  static inline int which_bucket(u64 duration_ns, unsigned int nr_iowaiters)
>  {
>         int bucket = 0;
> @@ -177,7 +179,7 @@ static unsigned int get_typical_interval(struct menu_device *data)
>         sum = 0;
>         divisor = 0;
>         for (i = 0; i < INTERVALS; i++) {
> -               unsigned int value = data->intervals[i];
> +               unsigned int value = intervals_dummy[i];
>                 if (value <= thresh) {
>                         sum += value;
>                         divisor++;
> @@ -200,7 +202,7 @@ static unsigned int get_typical_interval(struct menu_device *data)
>         /* Then try to determine variance */
>         variance = 0;
>         for (i = 0; i < INTERVALS; i++) {
> -               unsigned int value = data->intervals[i];
> +               unsigned int value = intervals_dummy[i];
>                 if (value <= thresh) {
>                         int64_t diff = (int64_t)value - avg;
>                         variance += diff * diff;
> 

Yes, I tried the above patch and I still see the issue:

+-----------------------------+------------------+------------------+------------------+
|           Metric            |     ladder       |      menu        |      teo         |
+=============================+==================+==================+==================+
|           Wakeups           |     579817       |     579298       |     578359       |
+-----------------------------+------------------+------------------+------------------+
| Average wakeup latency (us) |      7.32        |     7.099        |     4.538        |
+-----------------------------+------------------+------------------+------------------+
|     Sleep interval (us)     |      51.722      |    51.768        |     51.852       |
+-----------------------------+------------------+------------------+------------------+
|     State 0 Usage diff      |      0           |     7056         |     578402       |
+-----------------------------+------------------+------------------+------------------+
|   State 0 Time diff (ns)    |      0           |    350579        |    2.75562e+07   |
+-----------------------------+------------------+------------------+------------------+
|     State 0 Above diff      |      0           |      0           |      0           |
+-----------------------------+------------------+------------------+------------------+
|     State 0 Below diff      |      0           |      1           |      0           |
+-----------------------------+------------------+------------------+------------------+
|     State 1 Usage diff      |    580239        |    572168        |      0           |
+-----------------------------+------------------+------------------+------------------+
|   State 1 Time diff (ns)    |   2.74763e+07    |   2.73917e+07    |      0           |
+-----------------------------+------------------+------------------+------------------+
|     State 1 Above diff      |    580140        |    572070        |      0           |
+-----------------------------+------------------+------------------+------------------+
|     State 1 Below diff      |      0           |      0           |      0           |
+-----------------------------+------------------+------------------+------------------+
|         Total Above         |    580140        |    572070        |      0           |
+-----------------------------+------------------+------------------+------------------+
|         Total Below         |      0           |      1           |      0           |
+=============================+==================+==================+==================+
|     Total Above Percent     |     99.98        |     98.76        |      0           |
+-----------------------------+------------------+------------------+------------------+
|     Total Below Percent     |      0           |      0           |      0           |
+======================================================================================+

--------------------------------------------------------------------------------------------
Note:

% Total Above Percent (w.r.t. Total Usage) = (Total Above / Total Usage) * 100
% Total Below Percent (w.r.t. Total Usage) = (Total Below / Total Usage) * 100
--------------------------------------------------------------------------------------------

This confirms that the issue is not occuring due to the way in which predicted_ns is
computed in get_typicial_interval, but rather related to the menu governor's CPU idle
state selection logic.

Thanks,
Aboorva


