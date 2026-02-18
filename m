Return-Path: <linux-pm+bounces-42829-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDkhFZ4DlmlFYQIAu9opvQ
	(envelope-from <linux-pm+bounces-42829-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 19:23:26 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B40B0158ACD
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 19:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29F3D30097D9
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 18:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FBF1E0B86;
	Wed, 18 Feb 2026 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dZSttBme"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C354A281370;
	Wed, 18 Feb 2026 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771438994; cv=none; b=IPuzU+i9Fi6zxtT9+9X7iV2X37XzokRoT/rQBHavrfOmH0iy+FkAixYxgNOZTNDxv+nF5qaXwo3SqxlPU/I02yvuHQiMcA+PXTRh9ftgb6LKLtD8Ya7B5Wbh0Wso5uUQaTLq/3v8RJ9wR6D0F7DbxgL6xNAJtmt4Nr2fsq0OcDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771438994; c=relaxed/simple;
	bh=lUdoYy9oVQmGXZSjnsQoKs4qR+8cVf+Enm6KJLhARBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m19cU5lMFwy95a1L4dXe9/qUEN/5bE+5v1hx2F7LYyo663errCwvi8M6rhAfJ3PeNOvUeMGLWwqfIZJ/vBSGBNNAZceUMO5gM6TWQfwQNB1r2joLjhwngBGnhJze3omo781JCmokqU/PwS9Qn2UuKSm1ze0lnPHzSg4YgstvQsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dZSttBme; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61I69h8C3354314;
	Wed, 18 Feb 2026 18:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0NPWXc
	FnDOyF2XkV+Rxo1cDo2IfbAk+Luw7jV18Rj/U=; b=dZSttBmeyn0rgoRLmT9MW5
	RfxeQ20a7Z1JlJpekhxW/KrES0KvhHUozMNOLpaY+b1YE81cIq/elsLZQKqaB7RL
	5B5lM40oC5OBu/IlXsDHmZIqT1euMdrEdWeaDv4b4jqKFFOErauw0o9O+vZbfySA
	WSOiefu3ETCipTeyuP48ZSUW269UimsV0B6W1Nxv2YPhx/PITemnt59g3sho95WV
	GGzzbBSoL/Eq5T2xHwGGtxmEt09gKc4pDY18VdrW/Hu/DA9EoY0CNzOYPApH3Rpo
	ywv9h7owfgC3zbLC5DuMosIt7tot+uGGteXO1vGOe07uRfQpcxRdksGpLgB0Fxrg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj4khh2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 18:22:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61IHSK5w023899;
	Wed, 18 Feb 2026 18:22:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb45916w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 18:22:41 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61IIMbOx24707830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 18:22:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA9832004B;
	Wed, 18 Feb 2026 18:22:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1B9420043;
	Wed, 18 Feb 2026 18:22:27 +0000 (GMT)
Received: from [9.111.93.209] (unknown [9.111.93.209])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Feb 2026 18:22:27 +0000 (GMT)
Message-ID: <8fee8933-1b27-41f2-b198-45a2d1390e70@linux.ibm.com>
Date: Wed, 18 Feb 2026 23:52:26 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] sched/idle: Handle offlining first in idle loop
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
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
 <20260206142245.58987-2-frederic@kernel.org>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260206142245.58987-2-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDE1NSBTYWx0ZWRfX4BHUtWXNKtVg
 3KkYKoHQGksJGb5a85dTZyKSuB1eQjs2W65mF88ZJ/Lga6//SaoNXf00GorPbK5iYBjIBVAO8Uc
 Nl7ohDKnr0l4koacb0Yaqfz94dm3JPRCJ7st9LyQ/IiPpfI/gf9hmdAC13VRJSoEgg0FsIpd/qg
 /6tWZa1uQbzyQZb3UiXy5ei1dXy0MX1eAhdf39ufbGcoYyIE7IXuoRemV9vcpaFY/i9WiWNVVhK
 jVoOnBpQU80AKME8VbYT1e1nn+bpBT8bguJ6wThSzkrQvnWLi+j1cnI9YqBOQ/UMkiNHuR71abf
 gicMz5PSh0mI19k7Gd785eYJoBFpn7AP6LYPYPfsszV5dY+cBI+DQz+OkZMz1t+9JTfcWbUSEO+
 4cNDo1UpiXuA5njoL84nNBYbWTMA6SO29O/RQo2MGUo5w8WLQ6lFT7FCjBFguPcO5zEMyc6PPt9
 Vc1AQLFwyBGdrzDTXrw==
X-Proofpoint-ORIG-GUID: B1NrpVy1KPkVC7VW6YlK3OnaFYL4hO7q
X-Proofpoint-GUID: IhRE2r75_C8EqT2m1I81Y2_I-sw0Vcda
X-Authority-Analysis: v=2.4 cv=M7hA6iws c=1 sm=1 tr=0 ts=69960373 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=M70JiF8069jlCNdMrNkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602180155
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[35];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42829-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linux.ibm.com,linutronix.de,google.com,gmail.com,arm.com,redhat.com,siemens.com,nvidia.com,suse.de,ellerman.id.au,infradead.org,goodmis.org,linaro.org,163.com,lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: B40B0158ACD
X-Rspamd-Action: no action



On 2/6/26 7:52 PM, Frederic Weisbecker wrote:
> Offline handling happens from within the inner idle loop,
> after the beginning of dyntick cputime accounting, nohz idle
> load balancing and TIF_NEED_RESCHED polling.
> 
> This is not necessary and even buggy because:
> 
> * There is no dyntick handling to do. And calling tick_nohz_idle_enter()
>    messes up with the struct tick_sched reset that was performed on
>    tick_sched_timer_dying().
> 
> * There is no nohz idle balancing to do.
> 
> * Polling on TIF_RESCHED is irrelevant at this stage, there are no more
>    tasks allowed to run.
> 
> * No need to check if need_resched() before offline handling since
>    stop_machine is done and all per-cpu kthread should be done with
>    their job.
> 
> Therefore move the offline handling at the beginning of the idle loop.
> This will also ease the idle cputime unification later by not elapsing
> idle time while offline through the call to:
> 
> 	tick_nohz_idle_enter() -> tick_nohz_start_idle()
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>


Makes sense to call it outside the loop.
Once you report idle is dead, there is nothing to do that CPU.

Reviewed-by: Shrikanth Hegde<sshegde@linux.ibm.com>


> ---
>   kernel/sched/idle.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index c174afe1dd17..51764cbec6f3 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -260,6 +260,14 @@ static void do_idle(void)
>   {
>   	int cpu = smp_processor_id();
>   
> +	if (cpu_is_offline(cpu)) {
> +		local_irq_disable();
> +		/* All per-CPU kernel threads should be done by now. */
> +		WARN_ON_ONCE(need_resched());
> +		cpuhp_report_idle_dead();
> +		arch_cpu_idle_dead();
> +	}
> +
>   	/*
>   	 * Check if we need to update blocked load
>   	 */
> @@ -311,11 +319,6 @@ static void do_idle(void)
>   		 */
>   		local_irq_disable();
>   
> -		if (cpu_is_offline(cpu)) {
> -			cpuhp_report_idle_dead();
> -			arch_cpu_idle_dead();
> -		}
> -
>   		arch_cpu_idle_enter();
>   		rcu_nocb_flush_deferred_wakeup();
>   


