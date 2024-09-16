Return-Path: <linux-pm+bounces-14346-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C650697A558
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 17:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38694B21BC4
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 15:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CD026AD3;
	Mon, 16 Sep 2024 15:31:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86581BC41;
	Mon, 16 Sep 2024 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726500712; cv=none; b=i9mflxKZbH0t1URo1xIFXqA9rtpOqC0eThbc+Dbp9+BZ3ieCskHxnPzHs2BCZRuD7cUEyx8Ad5ZM3hlZLipGIrEDTw52DR/nhYesUK/g6f7oPjeI3L2Ku21VRLZjoVWX6yNXY9qdHq7T+DE3Mj6iIPaASPkLrTjycyXfP9ZYQHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726500712; c=relaxed/simple;
	bh=eQoKx6HaczesQoiG51SdDPhmevQBrpf+QqGZExeD2pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VF29DNB1O+8PAD+Vag5P8QdMGp7pevN1wfnlbhGMOPOETejY0mJ7B4C2TuMy+wa2i+WlSpPdmHpmOmaMyWW2mWoBTLvvcZKj7dM7ibWpIVWf6guvbrD08dPzhZrb3lbm0DlRY7ZiNJG8DjOnoMCD9CXwgP6cAgxa/GmjFHUxoT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46FB211FB;
	Mon, 16 Sep 2024 08:32:19 -0700 (PDT)
Received: from [10.1.28.49] (e127648.arm.com [10.1.28.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99E6B3F66E;
	Mon, 16 Sep 2024 08:31:47 -0700 (PDT)
Message-ID: <2015a36a-0d45-429d-b223-063993c27e6f@arm.com>
Date: Mon, 16 Sep 2024 16:31:45 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/16] sched/pelt: Add a new function to approximate
 runtime to reach given util
To: "Sultan Alsawaf (unemployed)" <sultan@kerneltoast.com>,
 Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, John Stultz
 <jstultz@google.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240820163512.1096301-1-qyousef@layalina.io>
 <20240820163512.1096301-4-qyousef@layalina.io>
 <ZsbOdOf7jHTvVXPj@sultan-box.localdomain>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <ZsbOdOf7jHTvVXPj@sultan-box.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/24 06:36, Sultan Alsawaf (unemployed) wrote:
> On Tue, Aug 20, 2024 at 05:34:59PM +0100, Qais Yousef wrote:
>> It is basically the ramp-up time from 0 to a given value. Will be used
>> later to implement new tunable to control response time  for schedutil.
>>
>> Signed-off-by: Qais Yousef <qyousef@layalina.io>
>> ---
>>  kernel/sched/pelt.c  | 21 +++++++++++++++++++++
>>  kernel/sched/sched.h |  1 +
>>  2 files changed, 22 insertions(+)
>>
>> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
>> index 2ce83e880bd5..06cb881ba582 100644
>> --- a/kernel/sched/pelt.c
>> +++ b/kernel/sched/pelt.c
>> @@ -487,3 +487,24 @@ unsigned long approximate_util_avg(unsigned long util, u64 delta)
>>  
>>  	return sa.util_avg;
>>  }
>> +
>> +/*
>> + * Approximate the required amount of runtime in ms required to reach @util.
>> + */
>> +u64 approximate_runtime(unsigned long util)
>> +{
>> +	struct sched_avg sa = {};
>> +	u64 delta = 1024; // period = 1024 = ~1ms
>> +	u64 runtime = 0;
>> +
>> +	if (unlikely(!util))
>> +		return runtime;
> 
> Seems like this check can be removed since it's covered by the loop condition.
> 
>> +
>> +	while (sa.util_avg < util) {
>> +		accumulate_sum(delta, &sa, 1, 0, 1);
>> +		___update_load_avg(&sa, 0);
>> +		runtime++;
>> +	}
> 
> I think this could be a lookup table (probably 1024 * u8), for constant-time
> runtime approximation.

Somewhat agreed, given that we don't seem to care about the 2.4% error margin,
we could allow some more errors here even. Something like 50 values should be
more than enough (which might fit nicely in a simple formula, too?).

FWIW
util: approximate_runtime(util)
160: 8
192: 10
224: 12
256: 14
288: 16
320: 18
352: 20
384: 22
416: 25
448: 27
480: 30
512: 32
544: 35
576: 39
608: 42
640: 46
672: 50
704: 54
736: 59
768: 64
800: 71
832: 78
864: 86
896: 96
928: 109
960: 128
992: 159
1024: 323

Fine for a RFC though.

