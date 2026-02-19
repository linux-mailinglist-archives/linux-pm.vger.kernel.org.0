Return-Path: <linux-pm+bounces-42890-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMdyCfpWl2lPxAIAu9opvQ
	(envelope-from <linux-pm+bounces-42890-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 19:31:22 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B56161B20
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 19:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D0B73022F46
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 18:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E9F1F4CB3;
	Thu, 19 Feb 2026 18:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SFWg1clY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1561BC2A;
	Thu, 19 Feb 2026 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771525878; cv=none; b=P2d3rUkhoE77g0p2/5a4FcV2yPQpbkh2VpLf6KMJ7BlI6/3/g/W4wGc3l2g6x6RZXAoW8dJqjWwhkB9R2krBmj7BnOZWKXA6BnMd5BqBiFNB3AfMc+49UTEP0m3hVbCzoYtr9eSMz0jNQ2P42ywvEkcDjm0imRprZxiD6nh9aEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771525878; c=relaxed/simple;
	bh=M5AeCZqxWr3qIRd4WLtY4dp+wlycaOsl+tjpNhb3EPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gBBgJc5Jm3ivzPj9aLesnerdERxhQobEgxzGGx8nLHaX9QctfAxAX09EphjsMDTFcdtB0qukUZMfTOIyzXtsiJMnlMEv9dBpXchVz2qzzznCjHgt5GSo2Xknw35gWKiKI+Fvb3Zy3BqYB/Pfkebsf9ki9fw05EpcPvDxXyBm2CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SFWg1clY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J9ACWk1261180;
	Thu, 19 Feb 2026 18:30:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UyqtE5
	dFClD4qUnTIg5kBZRFtx9J4UpArQv5TR4phSc=; b=SFWg1clY7vnfwxc2JH30jJ
	GJyI4qt6fn1359Gi0VIHaY13aqwYWLOj6niHzBfsHP5AavkHlDE/vcNM2azVxa07
	0Zel6Es13bpMv4TGzSTxPKyEjvfE5AhzRlvYMEuPDIAjrJ27RKQJChBMjT8ZMFyI
	E3lShnVceGQMb/zRm3DsYqC0D0i6SEwdDkv74HM220HMvNTpB/+6OriXCGBjEbhP
	mJhjlRD7I+qgk8g3wBrUGqLGBcVEVm2RApSFTCYTPi+Wez+l9FuCSEuNL0bF3XNq
	cZx7xJ40MSy+Ykw0yUWGf+8teGiGPXVQnxjyG+r4bMFA0nWqqWOFb9Cb+bNiV8jA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6s7h9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 18:30:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61JI5k01015697;
	Thu, 19 Feb 2026 18:30:21 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb45dbya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 18:30:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61JIUHLX29229328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 18:30:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C524720043;
	Thu, 19 Feb 2026 18:30:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66FC720040;
	Thu, 19 Feb 2026 18:30:07 +0000 (GMT)
Received: from [9.111.92.82] (unknown [9.111.92.82])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Feb 2026 18:30:07 +0000 (GMT)
Message-ID: <9413517d-963b-4e6d-b11b-b440acd7cb5a@linux.ibm.com>
Date: Fri, 20 Feb 2026 00:00:06 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] powerpc/time: Prepare to stop elapsing in
 dynticks-idle
To: Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
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
        Kieran Bingham <kbingham@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
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
 <20260206142245.58987-5-frederic@kernel.org>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260206142245.58987-5-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=dvvWylg4 c=1 sm=1 tr=0 ts=699756bf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=YJB6otqPPJUw7w8ZA6oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: wBr2Fja_KVXT4_1MKa1HvqQ-fZlDiO8G
X-Proofpoint-ORIG-GUID: 0riturGGUpWqAjVXmFdvyORGCGQiEQj9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDE2NCBTYWx0ZWRfXydBM+OSLWTzC
 ZXK3WUprw2QRv0CstNwfm1HYMX09fQc9mgkhfmkAeYae0qdpXwTYM2fTlEGcxaxiS3ph0VWCZIY
 dXPnepPQ8PSxKduvuvQtq8HT/njmynffdUIClnWG5BvjEju0vZwrHWcJVMq85gYQf3KapPljO+O
 uWju3HnVtoEcV6YCBUrho8+uZm5qjE8oggcTXLzzgrzb4OzOIrwf3RfnxxnPYoym7PTbgGDDqCv
 Ev+o3/YrxQTD9A6ydZur6C18ZLRUz9SokEpx0p+KrHT6k7nLP4JGu9qDEWjtpiJO18Lmkdtv4wx
 KDyBtbLse6zROCdEJ6eTsp2PUdhxK3lgANAw+965RN6cCwIPWZ0QoGtdxvMbFlKiCAOGwmHnD/0
 LMTlzF8iSkZ8CITcxADOqNh9xfH5zpcK2sEV6TZTSW1eMjIZKcmvqCSH5vy5VObjdsIMstZVPv0
 iK7e9YgDm58GOlOhDBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_04,2026-02-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602190164
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[35];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42890-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,linutronix.de,google.com,gmail.com,arm.com,redhat.com,siemens.com,nvidia.com,suse.de,ellerman.id.au,infradead.org,goodmis.org,linaro.org,163.com,vger.kernel.org,lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 90B56161B20
X-Rspamd-Action: no action



On 2/6/26 7:52 PM, Frederic Weisbecker wrote:
> Currently the tick subsystem stores the idle cputime accounting in
> private fields, allowing cohabitation with architecture idle vtime
> accounting. The former is fetched on online CPUs, the latter on offline
> CPUs.
> 
> For consolidation purpose, architecture vtime accounting will continue
> to account the cputime but will make a break when the idle tick is
> stopped. The dyntick cputime accounting will then be relayed by the tick
> subsystem so that the idle cputime is still seen advancing coherently
> even when the tick isn't there to flush the idle vtime.
> 
> Prepare for that and introduce three new APIs which will be used in
> subsequent patches:
> 
> _ vtime_dynticks_start() is deemed to be called when idle enters in
>    dyntick mode. The idle cputime that elapsed so far is accumulated.
> 
> - vtime_dynticks_stop() is deemed to be called when idle exits from
>    dyntick mode. The vtime entry clocks are fast-forward to current time
>    so that idle accounting restarts elapsing from now.
> 
> - vtime_reset() is deemed to be called from dynticks idle IRQ entry to
>    fast-forward the clock to current time so that the IRQ time is still
>    accounted by vtime while nohz cputime is paused.
> 
> Also accumulated vtime won't be flushed from dyntick-idle ticks to avoid
> accounting twice the idle cputime, along with nohz accounting.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

> ---
>   arch/powerpc/kernel/time.c | 41 ++++++++++++++++++++++++++++++++++++++
>   include/linux/vtime.h      |  6 ++++++
>   2 files changed, 47 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 4bbeb8644d3d..18506740f4a4 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -376,6 +376,47 @@ void vtime_task_switch(struct task_struct *prev)
>   		acct->starttime = acct0->starttime;
>   	}
>   }
> +
> +#ifdef CONFIG_NO_HZ_COMMON
> +/**
> + * vtime_reset - Fast forward vtime entry clocks
> + *
> + * Called from dynticks idle IRQ entry to fast-forward the clocks to current time
> + * so that the IRQ time is still accounted by vtime while nohz cputime is paused.
> + */
> +void vtime_reset(void)
> +{
> +	struct cpu_accounting_data *acct = get_accounting(current);
> +
> +	acct->starttime = mftb();

I figured out why those huge values happen.

This happens because mftb is from when the system is booted.
I was doing kexec to start the new kernel and mftb wasn't getting
reset.

I thought about this. This is concern for pseries too, where LPAR's
restart but system won't restart and mftb will continue to run instead of
reset.

I think we should be using sched_clock instead of mftb here.
Though we need it a few more places and some cosmetic changes around it.

Note: Some values being huge exists without series for few CPUs, with series it
shows up in most of the CPUs.

So I am planning send out fix below fix separately keeping your
series as dependency.

---
  arch/powerpc/include/asm/accounting.h |  4 ++--
  arch/powerpc/include/asm/cputime.h    | 14 +++++++-------
  arch/powerpc/kernel/time.c            | 22 +++++++++++-----------
  3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/accounting.h b/arch/powerpc/include/asm/accounting.h
index 6d79c31700e2..50f120646e6d 100644
--- a/arch/powerpc/include/asm/accounting.h
+++ b/arch/powerpc/include/asm/accounting.h
@@ -21,8 +21,8 @@ struct cpu_accounting_data {
  	unsigned long steal_time;
  	unsigned long idle_time;
  	/* Internal counters */
-	unsigned long starttime;	/* TB value snapshot */
-	unsigned long starttime_user;	/* TB value on exit to usermode */
+	unsigned long starttime;	/* Time value snapshot */
+	unsigned long starttime_user;	/* Time value on exit to usermode */
  #ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
  	unsigned long startspurr;	/* SPURR value snapshot */
  	unsigned long utime_sspurr;	/* ->user_time when ->startspurr set */
diff --git a/arch/powerpc/include/asm/cputime.h b/arch/powerpc/include/asm/cputime.h
index aff858ca99c0..eb6b629b113f 100644
--- a/arch/powerpc/include/asm/cputime.h
+++ b/arch/powerpc/include/asm/cputime.h
@@ -20,9 +20,9 @@
  #include <asm/time.h>
  #include <asm/param.h>
  #include <asm/firmware.h>
+#include <linux/sched/clock.h>
  
  #ifdef __KERNEL__
-#define cputime_to_nsecs(cputime) tb_to_ns(cputime)
  
  /*
   * PPC64 uses PACA which is task independent for storing accounting data while
@@ -44,20 +44,20 @@
   */
  static notrace inline void account_cpu_user_entry(void)
  {
-	unsigned long tb = mftb();
+	unsigned long now = sched_clock();
  	struct cpu_accounting_data *acct = raw_get_accounting(current);
  
-	acct->utime += (tb - acct->starttime_user);
-	acct->starttime = tb;
+	acct->utime += (now - acct->starttime_user);
+	acct->starttime = now;
  }
  
  static notrace inline void account_cpu_user_exit(void)
  {
-	unsigned long tb = mftb();
+	unsigned long now = sched_clock();
  	struct cpu_accounting_data *acct = raw_get_accounting(current);
  
-	acct->stime += (tb - acct->starttime);
-	acct->starttime_user = tb;
+	acct->stime += (now - acct->starttime);
+	acct->starttime_user = now;
  }
  
  static notrace inline void account_stolen_time(void)
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 18506740f4a4..fb67cdae3bcb 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -215,7 +215,7 @@ static unsigned long vtime_delta(struct cpu_accounting_data *acct,
  
  	WARN_ON_ONCE(!irqs_disabled());
  
-	now = mftb();
+	now = sched_clock();
  	stime = now - acct->starttime;
  	acct->starttime = now;
  
@@ -299,9 +299,9 @@ static void vtime_flush_scaled(struct task_struct *tsk,
  {
  #ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
  	if (acct->utime_scaled)
-		tsk->utimescaled += cputime_to_nsecs(acct->utime_scaled);
+		tsk->utimescaled += acct->utime_scaled;
  	if (acct->stime_scaled)
-		tsk->stimescaled += cputime_to_nsecs(acct->stime_scaled);
+		tsk->stimescaled += acct->stime_scaled;
  
  	acct->utime_scaled = 0;
  	acct->utime_sspurr = 0;
@@ -321,28 +321,28 @@ void vtime_flush(struct task_struct *tsk)
  	struct cpu_accounting_data *acct = get_accounting(tsk);
  
  	if (acct->utime)
-		account_user_time(tsk, cputime_to_nsecs(acct->utime));
+		account_user_time(tsk, acct->utime);
  
  	if (acct->gtime)
-		account_guest_time(tsk, cputime_to_nsecs(acct->gtime));
+		account_guest_time(tsk, acct->gtime);
  
  	if (IS_ENABLED(CONFIG_PPC_SPLPAR) && acct->steal_time) {
-		account_steal_time(cputime_to_nsecs(acct->steal_time));
+		account_steal_time(acct->steal_time);
  		acct->steal_time = 0;
  	}
  
  	if (acct->idle_time)
-		account_idle_time(cputime_to_nsecs(acct->idle_time));
+		account_idle_time(acct->idle_time);
  
  	if (acct->stime)
-		account_system_index_time(tsk, cputime_to_nsecs(acct->stime),
+		account_system_index_time(tsk, acct->stime,
  					  CPUTIME_SYSTEM);
  
  	if (acct->hardirq_time)
-		account_system_index_time(tsk, cputime_to_nsecs(acct->hardirq_time),
+		account_system_index_time(tsk, acct->hardirq_time,
  					  CPUTIME_IRQ);
  	if (acct->softirq_time)
-		account_system_index_time(tsk, cputime_to_nsecs(acct->softirq_time),
+		account_system_index_time(tsk, acct->softirq_time,
  					  CPUTIME_SOFTIRQ);
  
  	vtime_flush_scaled(tsk, acct);
@@ -388,7 +388,7 @@ void vtime_reset(void)
  {
  	struct cpu_accounting_data *acct = get_accounting(current);
  
-	acct->starttime = mftb();
+	acct->starttime = sched_clock();
  #ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
  	acct->startspurr = read_spurr(acct->starttime);
  #endif
-- 
2.43.0


