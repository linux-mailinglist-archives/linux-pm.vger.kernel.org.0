Return-Path: <linux-pm+bounces-29640-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77CEAEB0A6
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 09:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0866117123A
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 07:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF772264A8;
	Fri, 27 Jun 2025 07:55:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A696194098;
	Fri, 27 Jun 2025 07:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751010907; cv=none; b=ggFRpY0oGK7xdWv0uiCSmVZrLndebwFAoaBLImoHP5ADN9Az/5EXXU9w44MImUvJDKhi3XfEbjjuZNlSO5KJIhstr8P34Wmk//Irw4RL7gO8nUeOfSBjE3+0fluUuUuvO1NwXjrFcBvhU57N0xv+ZLAfnQMuJw/ocoExd9ajO+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751010907; c=relaxed/simple;
	bh=qB5pTwqOYhyBOIIyXPWfElUSO60HEYgRWxjbYysjfg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AjlpkNjkGo4knNp+++MMdKXAaobqNcLjPJiiUy9utMn4uXSnbyAPYXnZEkngEjo0QojBZkn4LXsoemcexLVOzd8ccNwnT/hhI5m41eSiNg41aapR6mZ/ykQFw8OdzLJ3tDT5u6omZDyCg5A+VN9+3N+H2iZ+/47kp5aWAbQ+//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bT75X4gyWzCsBl;
	Fri, 27 Jun 2025 15:50:40 +0800 (CST)
Received: from kwepemo100006.china.huawei.com (unknown [7.202.195.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 05F41140159;
	Fri, 27 Jun 2025 15:55:01 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemo100006.china.huawei.com
 (7.202.195.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 27 Jun
 2025 15:55:00 +0800
Message-ID: <ef3f933a-742c-9e8e-9da4-762b33f2de94@hisilicon.com>
Date: Fri, 27 Jun 2025 15:54:59 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
To: Prashant Malani <pmalani@google.com>
CC: Ben Segall <bsegall@google.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
	<juri.lelli@redhat.com>, open list <linux-kernel@vger.kernel.org>, "open
 list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, Mel Gorman
	<mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Valentin Schneider
	<vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh
 Kumar <viresh.kumar@linaro.org>, Ionela Voinescu <ionela.voinescu@arm.com>,
	Beata Michalska <beata.michalska@arm.com>, z00813676
	<zhenglifeng1@huawei.com>
References: <20250619000925.415528-1-pmalani@google.com>
 <20250619000925.415528-3-pmalani@google.com>
 <ff65b997-eb14-798f-1d2f-c375bf763e71@hisilicon.com>
 <CAFivqm+hjfDwPJCiHavnZSg2D+OaP5xbQnidmwxQ3HD32ic6EA@mail.gmail.com>
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <CAFivqm+hjfDwPJCiHavnZSg2D+OaP5xbQnidmwxQ3HD32ic6EA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo100006.china.huawei.com (7.202.195.47)


Hi Prashant,

Sorry for a late reply as I'm busy on other stuff and this doesn't seem to
be an easy issue to solve.

I may provide some thoughts but probably need more time to go through the
history and come up with a good solution.
 
Actually, the inaccuracy of cppc_cpufreq_get_rate() has been reported and
discussed many times.  I believe your issue is just one of the cases.

For the latest kernel, [1] provides a new 'cpuinfo_avg_freq' sysfs file to
reflect the frequency base on AMUs, which is supposed to be more stable.
Though it usually shows 'Resource temporarily unavailable' on my platform
at the moment and looks a bit buggy.

Most of the related discussions can be found in the reference links in [1].
[1] https://lore.kernel.org/linux-pm/20250131162439.3843071-1-beata.michalska@arm.com/

As reported, the current frequency sampling method may show an large error
on 1) 100% load, 2) high memory access pressure, 3) idle cpus in your case.

AFAICS, they may all come from the unstable latency accessing remote AMUs
for 4 times but delaying a fixed 2us sampling window.

Increase the sampling windows seems to help but also increase the time
overhead, so that's not favoured by people.

On 20/06/2025 13:07, Prashant Malani wrote:
> Hi Jie,
> 
> Thanks for taking a look at the patch.
> 
> On Thu, 19 Jun 2025 at 20:53, Jie Zhan <zhanjie9@hisilicon.com> wrote:
>> On 19/06/2025 08:09, Prashant Malani wrote:
>>> AMU performance counters tend to be inaccurate when measured on idle CPUs.
>>> On an idle CPU which is programmed to 3.4 GHz (verified through firmware),
>>> here is a measurement and calculation of operating frequency:
>>>
>>> t0: ref=899127636, del=3012458473
>>> t1: ref=899129626, del=3012466509
>>> perf=40
>>
>> In this case, the target cpu is mostly idle but not fully idle during the
>> sampling window since the counter grows a little bit.
>> Perhaps some interrupts happen to run on the cpu shortly.

Check back here again, I don't think it 'mostly idle'.
Diff of ref counters is around 2000, and I guess the ref counter freq is
1GHz on your platform?  That's exactly 2us, so the target cpu is mostly
busy.

So that might be some other issue.  Let's forget the minimum threshold
stuff below for now.

>>
>> Thus, the actual issue is the accuracy of frequency sampling becomes poor
>> when the delta of counters are too small to obtain a reliable accuracy.
>>
>> Would it be more sensible to put a minimum threshold of the delta of
>> counters when sampling the frequency?
> 
> I'm happy to throw together a patch if there is some safe
> threshold the experts here can agree on for the minimum delta for
> the ref counter. I would caution that with this sort of approach we
> start running into the familiar issue:
> - What value is appropriate? Too large and you get false
> positives (falling back to the idle invalid path when we shouldn't), and
> too less and you get false negatives (we still report inaccurate
> counter values).
> - Is the threshold the same across platforms?
> - Will it remain the same 5/10 years from now?
> 
>>  BTW, that ABI
>> doesn't seem to be synchronous at all, i.e. the cpu might be busy when we
>> check and then become idle when sampling.
>>
> 
> I don't think this is necessarily an issue. The ABI doesn't need to be
> synchronous; it is merely a snapshot of the scheduler view of that CPU
> at a point in time. Even the current method of perf counters sampling
> is purely hueristic. The CPU might be idle for the 2 usec the
> sampling is done, and servicing traffic before and after that.
> This is inherent whenever you are sampling any system state.

Then the issue is not totally solved, just less often?

> 
> I would imagine it is more reliable to trust the kernel scheduler's view
> of whether a CPU is idle, than relying on counters and a calculation
> method which are sensitive and unreliable for idle systems
> (i.e stray interrupts can throw off the calculations).
> 
> That said, I'm happy to go with the approach folks on this list recommend.
> 
> Cheers,
> 

