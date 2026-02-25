Return-Path: <linux-pm+bounces-43220-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNsxMek4n2m5ZQQAu9opvQ
	(envelope-from <linux-pm+bounces-43220-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 19:01:13 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2BD19BF0B
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 19:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61512300CE74
	for <lists+linux-pm@lfdr.de>; Wed, 25 Feb 2026 17:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179493ECBEA;
	Wed, 25 Feb 2026 17:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTtQ4To1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C8F3E8C7A;
	Wed, 25 Feb 2026 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772042363; cv=none; b=Mza69mZIXtnEcZV0Jhd5hYQAHg37Ipw+l48yxzbbTt+M1L5gaYMb691aaML5q5F5KtskDy2IXoch5iauwmak6XhuNmBVxRqJfEKLhcEemc6gjvxl0u0vCgZyB5QUrdftiu2WKNg2HOTD8KR3ayDHqHFGj6mEnjCW+BpNwITJkRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772042363; c=relaxed/simple;
	bh=gcndrDOD28MklPQt/Lh2XJCyQBbbmbxuz7jAD2TN7rY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukod8fP/qjb/sqvg5Vhe/Pz+700sCnUL6CKT0yLueT2R5n+QrBGD/31TMa/XXwTiAJPkRv0SCNEgZ5eni/ZEQAY+4tNbt3qCiKNxSx6S4JYp5o3QnAc9ITcxwUCEEqh/phDjOod30P3m+VRZg6yDgRCWs5PDHRnkkilwkTSI3Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTtQ4To1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07DCC116D0;
	Wed, 25 Feb 2026 17:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772042362;
	bh=gcndrDOD28MklPQt/Lh2XJCyQBbbmbxuz7jAD2TN7rY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JTtQ4To1CYUcPEg1qBHhdgllrxEgtibOC+WjvHacKlGLhV2HkSVlqwr9QiVz0aPkz
	 SVmlcLkdgoW5MoWjEmU8wSCqeRUFYMMrIehEiv41hU6TbclJwspiG6AR9oJknqpA8I
	 G/9sAfx6DhHQF4lgHtiXZhV1E2+9AVXLGbZDw6HOkkIKyo4fNi8f7SJNGtZf7MTwW0
	 gTYo7UCmQxvz1w3GcuHAnC2rid/Cs5G6yDK9WQOXXm0aQMPV0qmstXuSuFV7W6xvTS
	 XuX8hwDqAbABYkBvOE0pcsXUp59Q5gT+0vrg4qc7Er1X6GNGRpRi+Ipv/4nNAl2hgs
	 FIEQQUglHNysg==
Message-ID: <cd10be19-e0bc-4e0c-8dac-4f1c05d0de8f@kernel.org>
Date: Wed, 25 Feb 2026 18:59:11 +0100
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
 <55720b5b-f643-4e67-8841-d81a9e712faf@kernel.org>
 <a20beb34-0e4b-4063-b6b0-6c5886bbb971@linux.ibm.com>
 <a0c6e65c-3331-402a-94eb-14ba7f4b7ba7@kernel.org>
 <729a7e7f-a50e-480c-87ce-c45221fbb326@linux.ibm.com>
 <6c007cf1-46d5-4853-ae2e-90ee5257c6c9@kernel.org>
 <62f50aad-05ce-42ac-bdf6-dcb4af69c1c2@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <62f50aad-05ce-42ac-bdf6-dcb4af69c1c2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43220-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,linutronix.de,google.com,gmail.com,arm.com,redhat.com,siemens.com,nvidia.com,suse.de,ellerman.id.au,infradead.org,goodmis.org,linaro.org,163.com,vger.kernel.org,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C2BD19BF0B
X-Rspamd-Action: no action



Le 25/02/2026 à 18:47, Shrikanth Hegde a écrit :
> Hi Christophe.
> 
>> I think I'm starting to understand now.
>>
>> I think the problem is that acct->starttime has an invalid value the 
>> very first time it is used.
>>
>> We are probably lacking an initial value in paca->accounting.starttime.
>> This should likely be initialised from mftb in head_64.S in 
>> start_here_common for main CPU and __secondary_start for other CPUs or 
>> maybe at higher level in C in setup_arch() and start_secondary()
>>
>> Christophe
> 
> How about below? this works too.

Fine it is works, it means we found the real problem.

What about using the newly added vtime_reset() ? See below (untested)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 9b3167274653..f4aef85106ac 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -377,7 +377,6 @@ void vtime_task_switch(struct task_struct *prev)
  	}
  }

-#ifdef CONFIG_NO_HZ_COMMON
  /**
   * vtime_reset - Fast forward vtime entry clocks
   *
@@ -394,6 +393,7 @@ void vtime_reset(void)
  #endif
  }

+#ifdef CONFIG_NO_HZ_COMMON
  /**
   * vtime_dyntick_start - Inform vtime about entry to idle-dynticks
   *
@@ -931,6 +931,7 @@ static void __init set_decrementer_max(void)
  static void __init init_decrementer_clockevent(void)
  {
  	register_decrementer_clockevent(smp_processor_id());
+	vtime_reset();
  }

  void secondary_cpu_time_init(void)
@@ -946,6 +947,7 @@ void secondary_cpu_time_init(void)
  	/* FIME: Should make unrelated change to move snapshot_timebase
  	 * call here ! */
  	register_decrementer_clockevent(smp_processor_id());
+	vtime_reset();
  }

  /*


> 
> ---
> 
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 18506740f4a4..af129645b7f7 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -928,9 +928,24 @@ static void __init set_decrementer_max(void)
>                  bits, decrementer_max);
>   }
> 
> +#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
> +/*
> + * This is done to initialize the starttime correctly. with this
> + * /proc/stat show correct values similar to 
> CONFIG_VIRT_CPU_ACCOUNTING_GEN
> + */
> +static void init_cpu_accounting_startime(void)
> +{
> +       struct cpu_accounting_data *acct = get_accounting(current);
> +       acct->starttime = mftb();
> +}
> +#else
> +static void init_cpu_accounting_startime(void) { };
> +#endif
> +
>   static void __init init_decrementer_clockevent(void)
>   {
>          register_decrementer_clockevent(smp_processor_id());
> +       init_cpu_accounting_startime();
>   }
> 
>   void secondary_cpu_time_init(void)
> @@ -946,6 +961,8 @@ void secondary_cpu_time_init(void)
>          /* FIME: Should make unrelated change to move snapshot_timebase
>           * call here ! */
>          register_decrementer_clockevent(smp_processor_id());
> +
> +       init_cpu_accounting_startime();
>   }
> 
>   /*
> 


