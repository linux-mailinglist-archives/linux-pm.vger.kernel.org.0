Return-Path: <linux-pm+bounces-43233-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCbYFCf3n2nkfAQAu9opvQ
	(envelope-from <linux-pm+bounces-43233-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 08:32:55 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CBB1A1DF5
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 08:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C79B302368C
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 07:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092C236EAAD;
	Thu, 26 Feb 2026 07:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhvNjpNI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D985833290F;
	Thu, 26 Feb 2026 07:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772091170; cv=none; b=bi82XS0pnPkQDYxyVUhlmus/RCUdTpcQfbHyiYoueFWIv/lO9H1nPxIxZne1EXsdS4dawHZsRAhXi9x/2u9SVLJjMFN+lIRPFvgs/x7Qg4kiDVCtjTidzCspoDEDT+3B74t2/wgGmOIvR52fGM2zmWbH5rGWElfdiFdNm/G9rPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772091170; c=relaxed/simple;
	bh=ifqswWyiVHltZ9jFj6fgw2nxsxq2WC8ta0ADE6u9hWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wg+evic6EuYDvHK3VurChkm3ElcpbyH0bjDG3UVrHojoqyNSc214N7h7laW8MWC66XX88qBLc7gwDu5XJbysArSl8Nq4csrB5JdtC6hXsrAZGGODhE2pywMsdOJvIHgHh8VDUiLUUgfvEPMvXwrfsqPle/jiV5pZUpTiqWSVMSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhvNjpNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799CBC19422;
	Thu, 26 Feb 2026 07:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772091170;
	bh=ifqswWyiVHltZ9jFj6fgw2nxsxq2WC8ta0ADE6u9hWI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WhvNjpNILxETP/ReAQHkJifgws79BarPd0lr/3gqQBeIzqk0pha6jraykIWKGQtVy
	 ZrHsOMJZnMrAm3YHBSPO4y3G750XUvfj7XhfDbyA2TSKY8m4v+v4/javixoBNFY2G2
	 nYzQr5QIgxxfFqY9lgcQSi+bVPGFXSt6IWRTbIMUcctibqsDZR3h6yrEy/KcHTAq2G
	 fO014sbo8trvofLQau9qwAz3BpgITpklacs/vDlBbdl4KXTiUXVisDUJ1UbLDppdhb
	 3B2KYdLlu4vI3vxE/jLVZGsmjAeaHUtqgeSHWi1Vq8hN3ve+qwwK0L7Esrnc2sjwYJ
	 x8ZwgdYb7lFOw==
Message-ID: <1c1e5cf6-5b38-476c-ba49-35510312b064@kernel.org>
Date: Thu, 26 Feb 2026 08:32:36 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] powerpc/time: Prepare to stop elapsing in
 dynticks-idle
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 Juri Lelli <juri.lelli@redhat.com>, Kieran Bingham <kbingham@kernel.org>,
 Mel Gorman <mgorman@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, "Paul E . McKenney"
 <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>, Sven Schnelle <svens@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>,
 Valentin Schneider <vschneid@redhat.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Xin Zhao <jackzxcui1989@163.com>,
 linux-pm@vger.kernel.org, linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20260206142245.58987-1-frederic@kernel.org>
 <20260206142245.58987-5-frederic@kernel.org>
 <9413517d-963b-4e6d-b11b-b440acd7cb5a@linux.ibm.com>
 <9ab1e7d7-57ee-49f9-963c-3a1b96dda684@kernel.org>
 <120884b0-0b09-43a9-b0f6-7dc2affe1ac0@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <120884b0-0b09-43a9-b0f6-7dc2affe1ac0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43233-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,linutronix.de,google.com,gmail.com,arm.com,redhat.com,siemens.com,nvidia.com,suse.de,ellerman.id.au,infradead.org,goodmis.org,linaro.org,163.com,vger.kernel.org,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vgoip:email]
X-Rspamd-Queue-Id: E6CBB1A1DF5
X-Rspamd-Action: no action

Hi Hegde,

Le 25/02/2026 à 08:46, Shrikanth Hegde a écrit :
> Hi Christophe,
> 
> On 2/24/26 9:11 PM, Christophe Leroy (CS GROUP) wrote:
>> Hi Hegde,
>>
>> Le 19/02/2026 à 19:30, Shrikanth Hegde a écrit :
>>>
>>>
>>> On 2/6/26 7:52 PM, Frederic Weisbecker wrote:
>>>> Currently the tick subsystem stores the idle cputime accounting in
>>>> private fields, allowing cohabitation with architecture idle vtime
>>>> accounting. The former is fetched on online CPUs, the latter on offline
>>>> CPUs.
>>>>
>>>> For consolidation purpose, architecture vtime accounting will continue
>>>> to account the cputime but will make a break when the idle tick is
>>>> stopped. The dyntick cputime accounting will then be relayed by the 
>>>> tick
>>>> subsystem so that the idle cputime is still seen advancing coherently
>>>> even when the tick isn't there to flush the idle vtime.
>>>>
>>>> Prepare for that and introduce three new APIs which will be used in
>>>> subsequent patches:
>>>>
>>>> _ vtime_dynticks_start() is deemed to be called when idle enters in
>>>>    dyntick mode. The idle cputime that elapsed so far is accumulated.
>>>>
>>>> - vtime_dynticks_stop() is deemed to be called when idle exits from
>>>>    dyntick mode. The vtime entry clocks are fast-forward to current 
>>>> time
>>>>    so that idle accounting restarts elapsing from now.
>>>>
>>>> - vtime_reset() is deemed to be called from dynticks idle IRQ entry to
>>>>    fast-forward the clock to current time so that the IRQ time is still
>>>>    accounted by vtime while nohz cputime is paused.
>>>>
>>>> Also accumulated vtime won't be flushed from dyntick-idle ticks to 
>>>> avoid
>>>> accounting twice the idle cputime, along with nohz accounting.
>>>>
>>>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>>>
>>> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>>>
>>>> ---
>>>>   arch/powerpc/kernel/time.c | 41 ++++++++++++++++++++++++++++++++++ 
>>>> ++++
>>>>   include/linux/vtime.h      |  6 ++++++
>>>>   2 files changed, 47 insertions(+)
>>>>
>>>> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
>>>> index 4bbeb8644d3d..18506740f4a4 100644
>>>> --- a/arch/powerpc/kernel/time.c
>>>> +++ b/arch/powerpc/kernel/time.c
>>>> @@ -376,6 +376,47 @@ void vtime_task_switch(struct task_struct *prev)
>>>>           acct->starttime = acct0->starttime;
>>>>       }
>>>>   }
>>>> +
>>>> +#ifdef CONFIG_NO_HZ_COMMON
>>>> +/**
>>>> + * vtime_reset - Fast forward vtime entry clocks
>>>> + *
>>>> + * Called from dynticks idle IRQ entry to fast-forward the clocks 
>>>> to current time
>>>> + * so that the IRQ time is still accounted by vtime while nohz 
>>>> cputime is paused.
>>>> + */
>>>> +void vtime_reset(void)
>>>> +{
>>>> +    struct cpu_accounting_data *acct = get_accounting(current);
>>>> +
>>>> +    acct->starttime = mftb();
>>>
>>> I figured out why those huge values happen.
>>>
>>> This happens because mftb is from when the system is booted.
>>> I was doing kexec to start the new kernel and mftb wasn't getting
>>> reset.
>>>
>>> I thought about this. This is concern for pseries too, where LPAR's
>>> restart but system won't restart and mftb will continue to run 
>>> instead of
>>> reset.
>>>
>>> I think we should be using sched_clock instead of mftb here.
>>> Though we need it a few more places and some cosmetic changes around it.
>>>
>>> Note: Some values being huge exists without series for few CPUs, with 
>>> series it
>>> shows up in most of the CPUs.
>>>
>>> So I am planning send out fix below fix separately keeping your
>>> series as dependency.
>>>
>>> ---
>>>   arch/powerpc/include/asm/accounting.h |  4 ++--
>>>   arch/powerpc/include/asm/cputime.h    | 14 +++++++-------
>>>   arch/powerpc/kernel/time.c            | 22 +++++++++++-----------
>>>   3 files changed, 20 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/accounting.h b/arch/powerpc/ 
>>> include/asm/accounting.h
>>> index 6d79c31700e2..50f120646e6d 100644
>>> --- a/arch/powerpc/include/asm/accounting.h
>>> +++ b/arch/powerpc/include/asm/accounting.h
>>> @@ -21,8 +21,8 @@ struct cpu_accounting_data {
>>>       unsigned long steal_time;
>>>       unsigned long idle_time;
>>>       /* Internal counters */
>>> -    unsigned long starttime;    /* TB value snapshot */
>>> -    unsigned long starttime_user;    /* TB value on exit to usermode */
>>> +    unsigned long starttime;    /* Time value snapshot */
>>> +    unsigned long starttime_user;    /* Time value on exit to 
>>> usermode */
>>>   #ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
>>>       unsigned long startspurr;    /* SPURR value snapshot */
>>>       unsigned long utime_sspurr;    /* ->user_time when ->startspurr 
>>> set */
>>> diff --git a/arch/powerpc/include/asm/cputime.h b/arch/powerpc/ 
>>> include/ asm/cputime.h
>>> index aff858ca99c0..eb6b629b113f 100644
>>> --- a/arch/powerpc/include/asm/cputime.h
>>> +++ b/arch/powerpc/include/asm/cputime.h
>>> @@ -20,9 +20,9 @@
>>>   #include <asm/time.h>
>>>   #include <asm/param.h>
>>>   #include <asm/firmware.h>
>>> +#include <linux/sched/clock.h>
>>>
>>>   #ifdef __KERNEL__
>>> -#define cputime_to_nsecs(cputime) tb_to_ns(cputime)
>>>
>>>   /*
>>>    * PPC64 uses PACA which is task independent for storing accounting 
>>> data while
>>> @@ -44,20 +44,20 @@
>>>    */
>>>   static notrace inline void account_cpu_user_entry(void)
>>>   {
>>> -    unsigned long tb = mftb();
>>> +    unsigned long now = sched_clock();
>>
>> Now way !
>>
>> By doing that you'll kill performance for no reason. All we need when 
>> accounting time spent in kernel or in user is the difference between 
>> time at entry and time at exit, no mater what the time was at boot time.
>>
> 
> No. With this patch there will not be any performance difference.
> All it does is, instead of using mftb uses sched_clock at those places.
> 

For the record, I did some benchmark test with 
tools/testing/selftests/powerpc/benchmarks/null_syscall on powerpc 885 
microcontroller:

Without your proposed patch:

root@vgoip:~# ./null_syscall
    2729.98 ns     360.36 cycles

With your proposed patch below:

root@vgoip:~# ./null_syscall
    3370.80 ns     444.95 cycles

So as expected it is a huge regression, almost 25% more time to run the 
syscall.

Christophe


> 
> In arch/powerpc/kernel/time.c we have sched_clock().
> notrace unsigned long long sched_clock(void)
> {
>          return mulhdu(get_tb() - boot_tb, tb_to_ns_scale) << 
> tb_to_ns_shift;
> }
> 
> It does the same mftb call, and accounts only the time after boot, which is
> what /proc/stat should do as well.
> 
> "
> the amount of time, measured in units of USER_HZ
> (1/100ths of a second on most architectures
> 
> user   (1) Time spent in user mode.
> 
> idle   (4) Time spent in the idle task.  This value
>         should be USER_HZ times the second entry in
>         the /proc/uptime pseudo-file.
> "
> /proc/uptime is based on sched_clock, so i infer /proc/stat also should 
> show
> values w.r.t to boot of the OS.
> 
> 
>> Also sched_clock() returns nanoseconds which implies calculation from 
>> timebase. This is pointless CPU consumption. The current 
>> implementation calculates nanoseconds at task switch when calling 
>> vtime_flush().Your change will now do it at every kernel entry and 
>> kernel exit by calling sched_clock().
> 
> This change doesn't add any additional paths. Even without patches, mftb 
> would have
> been called in every kernel entry/exit.  See mftb usage 
> account_cpu_user_exit/enter
> 
> Now instead of mftb sched_clock is used, that's all. No additional 
> entry/exit points.
> And previously when accounting we would have done cputime_to_nsecs, now 
> that conversion
> is done automatically in sched_clock. So overall computation-wise it 
> should be same.
> 
> What i am missing to see it here?
> 
>>
>> Another point is that sched_clock() returns a long long not a long.
> 
> Thanks for pointing that out.
> 
> Ok. Let me change some of those variables into unsigned long long.
> Compiler didn't warn me, so i didn't see it.
> 
>>
>> And also sched_clock() uses get_tb() which does mftb and mftbu. Which 
>> is pointless for calculating time deltas unless your application 
>> spends hours without being re-scheduled.
>>
> 
> I didn't get this. At current also, we use mftb, that functionality 
> should be the same.
> Could you please explain how?
> 
>>
>>>       struct cpu_accounting_data *acct = raw_get_accounting(current);
>>>
>>> -    acct->utime += (tb - acct->starttime_user);
>>> -    acct->starttime = tb;
>>> +    acct->utime += (now - acct->starttime_user);
>>> +    acct->starttime = now;
>>>   }
>>>
>>>   static notrace inline void account_cpu_user_exit(void)
>>>   {
>>> -    unsigned long tb = mftb();
>>> +    unsigned long now = sched_clock();
>>>       struct cpu_accounting_data *acct = raw_get_accounting(current);
>>>
>>> -    acct->stime += (tb - acct->starttime);
>>> -    acct->starttime_user = tb;
>>> +    acct->stime += (now - acct->starttime);
>>> +    acct->starttime_user = now;
>>>   }
>>>
>>>   static notrace inline void account_stolen_time(void)
>>> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
>>> index 18506740f4a4..fb67cdae3bcb 100644
>>> --- a/arch/powerpc/kernel/time.c
>>> +++ b/arch/powerpc/kernel/time.c
>>> @@ -215,7 +215,7 @@ static unsigned long vtime_delta(struct 
>>> cpu_accounting_data *acct,
>>>
>>>       WARN_ON_ONCE(!irqs_disabled());
>>>
>>> -    now = mftb();
>>> +    now = sched_clock();
>>>       stime = now - acct->starttime;
>>>       acct->starttime = now;
>>>
>>> @@ -299,9 +299,9 @@ static void vtime_flush_scaled(struct task_struct 
>>> *tsk,
>>>   {
>>>   #ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
>>>       if (acct->utime_scaled)
>>> -        tsk->utimescaled += cputime_to_nsecs(acct->utime_scaled);
>>> +        tsk->utimescaled += acct->utime_scaled;
>>>       if (acct->stime_scaled)
>>> -        tsk->stimescaled += cputime_to_nsecs(acct->stime_scaled);
>>> +        tsk->stimescaled += acct->stime_scaled;
>>>
>>>       acct->utime_scaled = 0;
>>>       acct->utime_sspurr = 0;
>>> @@ -321,28 +321,28 @@ void vtime_flush(struct task_struct *tsk)
>>>       struct cpu_accounting_data *acct = get_accounting(tsk);
>>>
>>>       if (acct->utime)
>>> -        account_user_time(tsk, cputime_to_nsecs(acct->utime));
>>> +        account_user_time(tsk, acct->utime);
>>>
>>>       if (acct->gtime)
>>> -        account_guest_time(tsk, cputime_to_nsecs(acct->gtime));
>>> +        account_guest_time(tsk, acct->gtime);
>>>
>>>       if (IS_ENABLED(CONFIG_PPC_SPLPAR) && acct->steal_time) {
>>> -        account_steal_time(cputime_to_nsecs(acct->steal_time));
>>> +        account_steal_time(acct->steal_time);
>>>           acct->steal_time = 0;
>>>       }
>>>
>>>       if (acct->idle_time)
>>> -        account_idle_time(cputime_to_nsecs(acct->idle_time));
>>> +        account_idle_time(acct->idle_time);
>>>
>>>       if (acct->stime)
>>> -        account_system_index_time(tsk, cputime_to_nsecs(acct->stime),
>>> +        account_system_index_time(tsk, acct->stime,
>>>                         CPUTIME_SYSTEM);
>>>
>>>       if (acct->hardirq_time)
>>> -        account_system_index_time(tsk, cputime_to_nsecs(acct- 
>>>  >hardirq_time),
>>> +        account_system_index_time(tsk, acct->hardirq_time,
>>>                         CPUTIME_IRQ);
>>>       if (acct->softirq_time)
>>> -        account_system_index_time(tsk, cputime_to_nsecs(acct- 
>>>  >softirq_time),
>>> +        account_system_index_time(tsk, acct->softirq_time,
>>>                         CPUTIME_SOFTIRQ);
>>>
>>>       vtime_flush_scaled(tsk, acct);
>>> @@ -388,7 +388,7 @@ void vtime_reset(void)
>>>   {
>>>       struct cpu_accounting_data *acct = get_accounting(current);
>>>
>>> -    acct->starttime = mftb();
>>> +    acct->starttime = sched_clock();
>>>   #ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
>>>       acct->startspurr = read_spurr(acct->starttime);
>>>   #endif
>>
> 
> PS: I measured the performance with hackbench. I don't see any degradation.
> 


