Return-Path: <linux-pm+bounces-42504-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AQwM6KZjGkhrgAAu9opvQ
	(envelope-from <linux-pm+bounces-42504-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 16:00:50 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB831255DE
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 16:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7A2053020EBE
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 15:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56354284671;
	Wed, 11 Feb 2026 15:00:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4DE280318;
	Wed, 11 Feb 2026 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770822019; cv=none; b=ICTI5cVWlJUAe0nWAkOp4HAfIWX58KGHYwQOKAsjhiBZPg00QGdYUcbC6Qmo6u2g2H5gEotocyZCsR1sgOs25wAGTD+IL1ToG94Hxlwf22TGMhfrYe2Citmquh0EKnkyU24wqqSUFoICu9gtnJ8M2Puc9t9cj4oxyzisNh5ZvzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770822019; c=relaxed/simple;
	bh=Gi90zCxNvXM2M+qVL9FKfvEkfnqdO6DquYJ+qhVUB40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=plQYr4Qx0r6JTJ/lDrKmLCcjNzk0vV2MVZdUTSu1mDt9V5WiYt4+xFyihpszCg1UHjeg2YVY+NLYKqAGM7Aw2HsBiUcWJ7R2s+6lgAsd3jj+Dv8DXzg3QNiWBUl80OPCCj3x6LilCjtgQts+suBraX09w0FGuBFfT6ImznqNjIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D407A339;
	Wed, 11 Feb 2026 07:00:09 -0800 (PST)
Received: from [10.1.36.100] (e127648.arm.com [10.1.36.100])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4ED083F63F;
	Wed, 11 Feb 2026 07:00:15 -0800 (PST)
Message-ID: <c3d670cd-fc54-49a8-b640-fb16f9bd0487@arm.com>
Date: Wed, 11 Feb 2026 15:00:13 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuidle: ladder: Fix state index when only one idle state
 is registered
To: Aboorva Devarajan <aboorvad@linux.ibm.com>, rafael@kernel.org,
 daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260211053552.739337-1-aboorvad@linux.ibm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260211053552.739337-1-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42504-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[aboorvad.linux.ibm.com:query timed out];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.loehle@arm.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arm.com:mid]
X-Rspamd-Queue-Id: BCB831255DE
X-Rspamd-Action: no action

On 2/11/26 05:35, Aboorva Devarajan wrote:
> On certain platforms (PowerNV systems without a power-mgt DT node),
> cpuidle may register only a single idle state. In cases where that
> single state is a polling state (state 0), the ladder governor may
> incorrectly treat state 1 as the first usable state and pass an
> out-of-bounds index. This can lead to a NULL enter callback being
> invoked, ultimately resulting in a system crash.
> 
> [   13.342636] cpuidle-powernv : Only Snooze is available
> [   13.351854] Faulting instruction address: 0x00000000
> [   13.376489] NIP [0000000000000000] 0x0
> [   13.378351] LR  [c000000001e01974] cpuidle_enter_state+0x2c4/0x668
> 
> Fix this by determining the first non-polling state index based on
> the number of registered states, and by returning state 0 when only
> one state is registered.
> 
> Fixes: dc2251bf98c6 ("cpuidle: Eliminate the CPUIDLE_DRIVER_STATE_START symbol")
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>

Agreed that the current behavior is a bug, but is there really much value
in using a cpuidle governor with just a polling state?
It's dead code and trivial to bail out of in cpuidle, right?

> ---
>  drivers/cpuidle/governors/ladder.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
> index 6617eb494a11..294a688ed0bb 100644
> --- a/drivers/cpuidle/governors/ladder.c
> +++ b/drivers/cpuidle/governors/ladder.c
> @@ -42,6 +42,21 @@ struct ladder_device {
>  
>  static DEFINE_PER_CPU(struct ladder_device, ladder_devices);
>  
> +/**
> + * ladder_get_first_idx - get the first non-polling state index
> + * @drv: cpuidle driver
> + *
> + * Returns the index of the first non-polling state, or 0 if state 0 is not
> + * polling or if there's only one state available.
> + */
> +static inline int ladder_get_first_idx(struct cpuidle_driver *drv)
> +{
> +	if (drv->state_count > 1 &&
> +	    drv->states[0].flags & CPUIDLE_FLAG_POLLING)
> +		return 1;
> +	return 0;
> +}
> +
>  /**
>   * ladder_do_selection - prepares private data for a state change
>   * @dev: the CPU
> @@ -70,16 +85,17 @@ static int ladder_select_state(struct cpuidle_driver *drv,
>  	struct ladder_device *ldev = this_cpu_ptr(&ladder_devices);
>  	struct ladder_device_state *last_state;
>  	int last_idx = dev->last_state_idx;
> -	int first_idx = drv->states[0].flags & CPUIDLE_FLAG_POLLING ? 1 : 0;
> +	int first_idx;
>  	s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
>  	s64 last_residency;
>  
> -	/* Special case when user has set very strict latency requirement */
> -	if (unlikely(latency_req == 0)) {
> +	/* Special case when there's only one state or strict latency requirement */
> +	if (unlikely(drv->state_count <= 1 || latency_req == 0)) {
>  		ladder_do_selection(dev, ldev, last_idx, 0);
>  		return 0;
>  	}
>  
> +	first_idx = ladder_get_first_idx(drv);
>  	last_state = &ldev->states[last_idx];
>  
>  	last_residency = dev->last_residency_ns - drv->states[last_idx].exit_latency_ns;
> @@ -134,7 +150,7 @@ static int ladder_enable_device(struct cpuidle_driver *drv,
>  				struct cpuidle_device *dev)
>  {
>  	int i;
> -	int first_idx = drv->states[0].flags & CPUIDLE_FLAG_POLLING ? 1 : 0;
> +	int first_idx = ladder_get_first_idx(drv);
>  	struct ladder_device *ldev = &per_cpu(ladder_devices, dev->cpu);
>  	struct ladder_device_state *lstate;
>  	struct cpuidle_state *state;


