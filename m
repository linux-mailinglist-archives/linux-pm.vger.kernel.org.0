Return-Path: <linux-pm+bounces-43933-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNm5GA+QrmnVGAIAu9opvQ
	(envelope-from <linux-pm+bounces-43933-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 10:17:03 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8359235FE6
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 10:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35E47303526D
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 09:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A666C376BF2;
	Mon,  9 Mar 2026 09:13:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A055526B755;
	Mon,  9 Mar 2026 09:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773047638; cv=none; b=ThAvak04qO7K4B+AZGh9dQFH61y8YaLWFwZjFbFwNLLwlkClTWdB1RCXzZMayhN+Jbv+a2YthNfJbvX33TgKuruMfuaFRdWXcd35E81Lei5zpQ4n70a6xRKaPssSiOEC8RXEPsZY2cGB8P5d/KQemrxss2foSPUGmMv67W+c6PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773047638; c=relaxed/simple;
	bh=mA/1kkvPSdKHdp2QV4yLOnxFW5xvMK+WX3Kw3SkhUW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=klc+qcDKse09SMi9fRSR6VJSKedeWqwCNiKiCAxR6rjIsstgAWJMwxsKx5TLSgkdOXHRiC8ZaEBsqYsFWaLuHm0ushTK+5TMl7Te3pppKeL/By/vGrMUm4NnwTa/KiqULCvptt1Tu9SQP8Gl9LT2tdxIt1NaTs/n3e0zlb0UxNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD0031570;
	Mon,  9 Mar 2026 02:13:49 -0700 (PDT)
Received: from [10.1.25.22] (e127648.arm.com [10.1.25.22])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1CA93F5CA;
	Mon,  9 Mar 2026 02:13:53 -0700 (PDT)
Message-ID: <eaccec02-2f4d-4746-81a0-deda2125bed3@arm.com>
Date: Mon, 9 Mar 2026 09:13:52 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] sched: idle: Make skipping governor callbacks more
 consistent
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Qais Yousef <qyousef@layalina.io>, Thomas Gleixner <tglx@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
References: <20260301191959.406218221@kernel.org>
 <CAJZ5v0h-bGU34d9OnhYqdzz+5UiKV1rBEB9NS-TL4=sK2jf-LQ@mail.gmail.com>
 <20260304030306.uk5c63xw4oqvjffb@airbuntu>
 <12857700.O9o76ZdvQC@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <12857700.O9o76ZdvQC@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B8359235FE6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.186];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43933-lists,linux-pm=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.loehle@arm.com,linux-pm@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/7/26 16:12, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If the cpuidle governor .select() callback is skipped because there
> is only one idle state in the cpuidle driver, the .reflect() callback
> should be skipped as well, at least for consistency (if not for
> correctness), so do it.
> 
> Fixes: e5c9ffc6ae1b ("cpuidle: Skip governor when only one idle state is available")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/cpuidle.c |   10 ----------
>  kernel/sched/idle.c       |   11 ++++++++++-
>  2 files changed, 10 insertions(+), 11 deletions(-)
> 
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -359,16 +359,6 @@ noinstr int cpuidle_enter_state(struct c
>  int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  		   bool *stop_tick)
>  {
> -	/*
> -	 * If there is only a single idle state (or none), there is nothing
> -	 * meaningful for the governor to choose. Skip the governor and
> -	 * always use state 0 with the tick running.
> -	 */
> -	if (drv->state_count <= 1) {
> -		*stop_tick = false;
> -		return 0;
> -	}
> -
>  	return cpuidle_curr_governor->select(drv, dev, stop_tick);
>  }
>  
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -221,7 +221,7 @@ static void cpuidle_idle_call(void)
>  
>  		next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
>  		call_cpuidle(drv, dev, next_state);
> -	} else {
> +	} else if (drv->state_count > 1) {
>  		bool stop_tick = true;
>  
>  		/*
> @@ -239,6 +239,15 @@ static void cpuidle_idle_call(void)
>  		 * Give the governor an opportunity to reflect on the outcome
>  		 */
>  		cpuidle_reflect(dev, entered_state);
> +	} else {
> +		tick_nohz_idle_retain_tick();
> +
> +		/*
> +		 * If there is only a single idle state (or none), there is
> +		 * nothing meaningful for the governor to choose.  Skip the
> +		 * governor and always use state 0.
> +		 */
> +		call_cpuidle(drv, dev, 0);
>  	}
>  
>  exit_idle:
> 
> 
> 

Duh, good catch.
Reviewed-by: Christian Loehle <christian.loehle@arm.com>

