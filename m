Return-Path: <linux-pm+bounces-42756-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Iw2F1h9lGkfFAIAu9opvQ
	(envelope-from <linux-pm+bounces-42756-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 15:38:16 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC60114D3C1
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 15:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9ADD303A3F1
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 14:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0850636B07A;
	Tue, 17 Feb 2026 14:37:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BD930F813;
	Tue, 17 Feb 2026 14:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771339065; cv=none; b=Zw9KuyfcQxQO/ye5Q+WgvmmSVWnQjAS8YtpQF7U1q+euEh54IFy2SwzlT8upUsGzCJIEUlKKoiHOAkcy2P/bYE3MV3ullzc/zR4VEhlsgUPX1+y5E6l7AN+436mk6+pCwTpLsZGVx6kbnDle6u3vLXGzEwnyjIxgFhrCgmeIYEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771339065; c=relaxed/simple;
	bh=Vq7cN9fW4M9dP0uPIjEFv0B7d0cyCp1D4XoNTkQeTHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=See1UXo0gA8c807M+bG55frxTqA59I9nCsxTT9WOvuyi/6f0FlDzENHf5ibgIvhAem7+v8NSdcDjuh58acMd5bZVQXysleOd4Zc6r0e5fPOi2fZE4WbXmvz/c5MuBtzfKAhstYnPOQObmZshaw7RusN8gh61X6y7DZMRVI9ElIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC05D1477;
	Tue, 17 Feb 2026 06:37:37 -0800 (PST)
Received: from [10.57.12.137] (unknown [10.57.12.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 113503F62B;
	Tue, 17 Feb 2026 06:37:42 -0800 (PST)
Message-ID: <2f15b061-611e-4d1d-a0de-2f7ed62ca2d3@arm.com>
Date: Tue, 17 Feb 2026 14:37:41 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] cpuidle: haltpoll: Remove single state handling
To: Aboorva Devarajan <aboorvad@linux.ibm.com>, rafael@kernel.org,
 daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260216185005.1131593-1-aboorvad@linux.ibm.com>
 <20260216185005.1131593-3-aboorvad@linux.ibm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260216185005.1131593-3-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	TAGGED_FROM(0.00)[bounces-42756-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:mid,arm.com:email]
X-Rspamd-Queue-Id: EC60114D3C1
X-Rspamd-Action: no action

On 2/16/26 18:50, Aboorva Devarajan wrote:
> cpuidle systems where the governor has no choice because there's only
> a single idle state are now handled by cpuidle core and bypass the
> governor, so remove the related handling.
> 
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>

Good catch, thanks!
Reviewed-by: Christian Loehle <christian.loehle@arm.com>

> ---
>  drivers/cpuidle/governors/haltpoll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/governors/haltpoll.c b/drivers/cpuidle/governors/haltpoll.c
> index 663b7f164d20..ed3952df8526 100644
> --- a/drivers/cpuidle/governors/haltpoll.c
> +++ b/drivers/cpuidle/governors/haltpoll.c
> @@ -52,7 +52,7 @@ static int haltpoll_select(struct cpuidle_driver *drv,
>  {
>  	s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
>  
> -	if (!drv->state_count || latency_req == 0) {
> +	if (latency_req == 0) {
>  		*stop_tick = false;
>  		return 0;
>  	}


