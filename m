Return-Path: <linux-pm+bounces-42755-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMb1CQN9lGkfFAIAu9opvQ
	(envelope-from <linux-pm+bounces-42755-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 15:36:51 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 532A514D394
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 15:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4EDF0300463B
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 14:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B991136BCEE;
	Tue, 17 Feb 2026 14:36:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9519936923F;
	Tue, 17 Feb 2026 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771339004; cv=none; b=bDcOY0s11AWJHIvv0yAfXRscFZp6WAxqvf7xePXvn7wbGxFm4X5K6WLP+j1B/m6h4R9rEHPk6RbPGn7eV1SQSC7sdXBirD9PMf92QMI+5qvQjWRSp8H7PWkYWC2g52GZvab9iZROjZSsIb62Xm9EHiyjEpb/0T3wk8M4kCx2FUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771339004; c=relaxed/simple;
	bh=TexRp5/U3aqpzRJvmQzXI7egomw2lMUAl6c9CRjuMkw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dnsJp5OsW46sf34XBVoG2zRPZgS1ymz3te0qWCt8AM+zMO5cdcDOf9qVd5kos4jlRmHVJnOfV6tzidE+CCGFYPGajaSdLPJ0b6Kr3Wd2mQgm8Ju/NdZaoq7G6HxgmWUqeKhCX78WJYohrqOVORGgQFxsPv+x/NVPHOOogvUzUB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77C551477;
	Tue, 17 Feb 2026 06:36:35 -0800 (PST)
Received: from [10.57.12.137] (unknown [10.57.12.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 985EB3F62B;
	Tue, 17 Feb 2026 06:36:40 -0800 (PST)
Message-ID: <042f57b8-b027-4dee-ac8c-6c6efc34d427@arm.com>
Date: Tue, 17 Feb 2026 14:36:33 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH v2 1/4] cpuidle: Skip governor when only one idle state is
 available
To: Aboorva Devarajan <aboorvad@linux.ibm.com>, rafael@kernel.org,
 daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260216185005.1131593-1-aboorvad@linux.ibm.com>
 <20260216185005.1131593-2-aboorvad@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260216185005.1131593-2-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	R_DKIM_NA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.loehle@arm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42755-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 532A514D394
X-Rspamd-Action: no action

On 2/16/26 18:50, Aboorva Devarajan wrote:
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
> Fix this by adding a bail-out in cpuidle_select() that returns state 0
> directly when state_count <= 1, bypassing the governor and keeping the
> tick running.
> 
> Fixes: dc2251bf98c6 ("cpuidle: Eliminate the CPUIDLE_DRIVER_STATE_START symbol")
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

> ---
>  drivers/cpuidle/cpuidle.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index c7876e9e024f..65fbb8e807b9 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -359,6 +359,16 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
>  int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  		   bool *stop_tick)
>  {
> +	/*
> +	 * If there is only a single idle state (or none), there is nothing
> +	 * meaningful for the governor to choose. Skip the governor and
> +	 * always use state 0 with the tick running.
> +	 */
> +	if (drv->state_count <= 1) {
> +		*stop_tick = false;
> +		return 0;
> +	}
> +
>  	return cpuidle_curr_governor->select(drv, dev, stop_tick);
>  }
>  


