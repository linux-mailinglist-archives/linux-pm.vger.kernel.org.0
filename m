Return-Path: <linux-pm+bounces-43481-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJa8JA/Cpmn3TQAAu9opvQ
	(envelope-from <linux-pm+bounces-43481-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 12:12:15 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 905891ED84C
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 12:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 991373007B2A
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2026 11:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01ABA3D3D02;
	Tue,  3 Mar 2026 11:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kn9C6wwl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE58F282F17;
	Tue,  3 Mar 2026 11:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772536328; cv=none; b=lAgH7iRpfU+DxZu3d7NaZYkLLdbQmx5URUHVuAupHLxAfm2dy123MfBXjPx7baJcBC0xqxN0N3quPTJ48zWuMHJibJi4SOVBNbpVXAHfOON9YAcNWP7ieQ/cwj/FmxDqiNwjZhHuLku+arur++oGDGQJHA2/9guYuKgxu/79mIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772536328; c=relaxed/simple;
	bh=jLZOY6WAwrY9fo3pShlsIhNH58r2Ro+Orz3HeUJxOb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NYAah2AosChI96E2pqMrgeGkhmoG8w8g90WWhtV6noRSWCjSsI5pe3Sj3iw4x/Zy6cLJuEh+19TRTlteCNU9xHLZRRqxA+93HDyLJWEq8T4eNs1r8mMsEQwNl8WqAc53GVp9+58qng8RjRTQGQZBPl6SUgW3sP8tqI3GWkUG3ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kn9C6wwl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6237FTXp2104794;
	Tue, 3 Mar 2026 11:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5R7/8c
	d7xW9zkt0oSt0vLll879jI88nP5jlzNhGC1Go=; b=kn9C6wwljog+hJvduGFq12
	v5wuELVOt/KFg6LCcm2DcHkP/eCRu9BJVKlQgBiIWyQr7u4kMkOhl8rIxOyKVC5Q
	nRvnCjjayux6BzxkwdnXWlSdqxGrPxr7vjx1cLhajMKOiLgGw9LVaNrolj6rzwe5
	Z4mUYUbxj5NTZlcpFKdGvaeWj3/XKiGFNXSIc7/YTeYS11QLPWzZooAwwJwtdPRb
	OcfAdpUCBArmB4eK/9GPfUJBcqLzt7Y9JKlASFuDvxEWv0ueygmdBeCt6XHcZ3/S
	+pP44VC0GCZn2TAPHXLHXoLQgfuUBKu4Cb7hSsQBqmEG3DsBddB2JLxBYQHxpk8A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksjdanec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 11:11:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6235rGEt008791;
	Tue, 3 Mar 2026 11:11:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmdd19mrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 11:11:29 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 623BBQDV30998832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Mar 2026 11:11:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B22320043;
	Tue,  3 Mar 2026 11:11:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BA9B2004B;
	Tue,  3 Mar 2026 11:11:19 +0000 (GMT)
Received: from [9.124.210.250] (unknown [9.124.210.250])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Mar 2026 11:11:19 +0000 (GMT)
Message-ID: <415e925a-e9f0-40ad-9f53-263dd34dd2a9@linux.ibm.com>
Date: Tue, 3 Mar 2026 16:41:18 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] sched/cputime: Handle idle irqtime gracefully
To: Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Joel Fernandes <joelagnelf@nvidia.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mel Gorman <mgorman@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
        Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E . McKenney"
 <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Xin Zhao <jackzxcui1989@163.com>, linux-pm@vger.kernel.org,
        linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20260206142245.58987-1-frederic@kernel.org>
 <20260206142245.58987-15-frederic@kernel.org>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260206142245.58987-15-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=M9BA6iws c=1 sm=1 tr=0 ts=69a6c1e3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=WffY0ah0q7W8p7317v4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: iOvsbUvpvsRb0o9WyNLZDxuI7eo5f5b8
X-Proofpoint-GUID: t3Mj4QLPgnhluBsZ6V0TeElOuOBh_39W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA4NiBTYWx0ZWRfX+mA/8CnyaB72
 J71qrO5vFg7C1rSBMjcWXUpLpNxl0rhLe4+zS7kgyOPQ77xdvSeubvjU8C4WzKR/uEHRYPG0/O0
 RP/I9EY6x8si7M8fx7LWbzulq6gvqVt1IDBgKy9TgHZaIuG9qRXvU1NcTkVD52NzjAnR4srojvF
 0FnRJqZbNrPBSqForkgm16KTgfsnwcpKkr510yohyRmHQ1DzUle80iAIa1yzdXcxfSYcXJPHiH/
 QHE8CQrHNN26xBG2pXtrhOoO9DHWyOkbAZSr58XjhSHxSn6Oq/LUFlIx7x52l9IZZnbpS9TsmhJ
 Oe+e21fl7621RgwrAJsPwSmgOp+SkwMQVHyEpsLfwfNgNXYqb4jUuZ+K7MmRwCIfktbjAL8VyHL
 5AIwUIYGaOWi0uj5C1FGMiiE6/fcGfJQNBN4mxO/GQ0j60/2+IdHtx7OJWPvGMsoTnl9Cz/e7x+
 dVZkNLCWzSNvk+wXHJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030086
X-Rspamd-Queue-Id: 905891ED84C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[35];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43481-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,linutronix.de,google.com,gmail.com,arm.com,redhat.com,siemens.com,nvidia.com,suse.de,ellerman.id.au,infradead.org,goodmis.org,linaro.org,163.com,vger.kernel.org,lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.ibm.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sshegde@linux.ibm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

Hi Frederic,

On 2/6/26 7:52 PM, Frederic Weisbecker wrote:
> The dyntick-idle cputime accounting always assumes that IRQ time
> accounting is enabled and consequently stops elapsing the idle time
> during dyntick-idle IRQs.
> 
> This doesn't mix up well with disabled IRQ time accounting because then
> idle IRQs become a cputime blind-spot. Also this feature is disabled
> on most configurations and the overhead of pausing dyntick-idle
> accounting while in idle IRQs could then be avoided.
> 
> Fix the situation with conditionally pausing dyntick-idle accounting
> during idle IRQs only if neither native vtime (which does IRQ time
> accounting) nor generic IRQ time accounting are enabled.
> 
> Also make sure that the accumulated IRQ time is not accidentally
> substracted from later accounting.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   kernel/sched/cputime.c | 24 +++++++++++++++++++++---
>   kernel/sched/sched.h   |  1 +
>   2 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index d588a4a50e57..92fa2f037b6e 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -46,7 +46,8 @@ static void irqtime_account_delta(struct irqtime *irqtime, u64 delta,
>   	u64_stats_update_begin(&irqtime->sync);
>   	cpustat[idx] += delta;
>   	irqtime->total += delta;
> -	irqtime->tick_delta += delta;
> +	if (!irqtime->idle_dyntick)
> +		irqtime->tick_delta += delta;

Wouldn't kcpustat_idle_dyntick achieve the same thing?

>   	u64_stats_update_end(&irqtime->sync);
>   }
>   
> @@ -81,6 +82,16 @@ void irqtime_account_irq(struct task_struct *curr, unsigned int offset)
>   		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
>   }
>   
> +static inline void irqtime_dyntick_start(void)
> +{
> +	__this_cpu_write(cpu_irqtime.idle_dyntick, true);
> +}
> +
> +static inline void irqtime_dyntick_stop(void)
> +{
> +	__this_cpu_write(cpu_irqtime.idle_dyntick, false);
> +}
> +
>   static u64 irqtime_tick_accounted(u64 maxtime)
>   {
>   	struct irqtime *irqtime = this_cpu_ptr(&cpu_irqtime);
> @@ -94,6 +105,9 @@ static u64 irqtime_tick_accounted(u64 maxtime)
>   
>   #else /* !CONFIG_IRQ_TIME_ACCOUNTING: */
>   
> +static inline void irqtime_dyntick_start(void) { }
> +static inline void irqtime_dyntick_stop(void) { }
> +
>   static u64 irqtime_tick_accounted(u64 dummy)
>   {
>   	return 0;
> @@ -444,6 +458,7 @@ void kcpustat_dyntick_stop(u64 now)
>   		WARN_ON_ONCE(!kc->idle_dyntick);
>   		kcpustat_idle_stop(kc, now);
>   		kc->idle_dyntick = false;
> +		irqtime_dyntick_stop();
>   		vtime_dyntick_stop();
>   		steal_account_process_time(ULONG_MAX);
>   	}
> @@ -455,6 +470,7 @@ void kcpustat_dyntick_start(u64 now)
>   
>   	if (!vtime_generic_enabled_this_cpu()) {
>   		vtime_dyntick_start();
> +		irqtime_dyntick_start();
>   		kc->idle_dyntick = true;
>   		kcpustat_idle_start(kc, now);
>   	}
> @@ -464,7 +480,8 @@ void kcpustat_irq_enter(u64 now)
>   {
>   	struct kernel_cpustat *kc = kcpustat_this_cpu;
>   
> -	if (!vtime_generic_enabled_this_cpu())
> +	if (!vtime_generic_enabled_this_cpu() &&
> +	    (irqtime_enabled() || vtime_accounting_enabled_this_cpu()))
>   		kcpustat_idle_stop(kc, now);
>   }
Scenario: context_tracking is not enabled(since nohz_full or isolcpus not specified) and
irqtime/native is not enabled. ( config is CONFIG_VIRT_CPU_ACCOUNTING_GEN + IRQ_TIME=n)


cpu goes into tickless mode. Gets irqs, but kcpustat_irq_enter/exit is nop.
Then the time it spent in irq is still accounted for idle time, during kcpustat_dyntick_stop?

Who is going to account the irq time in this case?

>   
> @@ -472,7 +489,8 @@ void kcpustat_irq_exit(u64 now)
>   {
>   	struct kernel_cpustat *kc = kcpustat_this_cpu;
>   
> -	if (!vtime_generic_enabled_this_cpu())
> +	if (!vtime_generic_enabled_this_cpu() &&
> +	    (irqtime_enabled() || vtime_accounting_enabled_this_cpu()))
>   		kcpustat_idle_start(kc, now);
>   }
>   
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index d30cca6870f5..cf677ff12b10 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3307,6 +3307,7 @@ static inline void sched_core_tick(struct rq *rq) { }
>   #ifdef CONFIG_IRQ_TIME_ACCOUNTING
>   
>   struct irqtime {
> +	bool			idle_dyntick;
>   	u64			total;
>   	u64			tick_delta;
>   	u64			irq_start_time;


