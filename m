Return-Path: <linux-pm+bounces-43890-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPO5FYaNq2nOeAEAu9opvQ
	(envelope-from <linux-pm+bounces-43890-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 07 Mar 2026 03:29:26 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D25AC2299E5
	for <lists+linux-pm@lfdr.de>; Sat, 07 Mar 2026 03:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83E173023680
	for <lists+linux-pm@lfdr.de>; Sat,  7 Mar 2026 02:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F7B2690EC;
	Sat,  7 Mar 2026 02:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nr/Ui62I"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C011B227565;
	Sat,  7 Mar 2026 02:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772850562; cv=none; b=uwCknird3yS8sxEzhCJr2MawbQ84B/szo7KPxXtFTHnMunuF3P+ZzEUKp9Jh+OqvBS2WVbaKz2lVxWOvDYe9lFbhCBXRRrVRyk+Q5fN0us/xs/90irp6uRGY6vi4Yl4YgAMlODiy9UjBfaBgBrXP70mJHtH/7FWeXxMOyhjQM0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772850562; c=relaxed/simple;
	bh=MWp0mghb6S8ZmAxV9y/CZoNAGWmR0S8/f7MbtfvOhyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WaPvSrRuI5k3+lybH0ZeASOzRarZ+EuUvobOBbkTMBmUnqpikjoZHf1BuUt+0GePs21cS45MmNwv3Aq/mZdDpUHxm/bws/75osNFZD/mRvrIEpIeOdeQr8Dy7yCIqiLZTAlf2ME9PYBX7GuzNesg0a9WOBhRWGZyRiaSoZrN6wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nr/Ui62I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8378C4CEF7;
	Sat,  7 Mar 2026 02:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772850562;
	bh=MWp0mghb6S8ZmAxV9y/CZoNAGWmR0S8/f7MbtfvOhyo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nr/Ui62IF/42ul199Gn9Ug8flGIdnhw8WCdCsB6wzQD+3WKSlHE+YG1A/j0Ieq8lP
	 Y/kYUjkasKaaScIROOMoFFvRyL1ExrFLCl8BSWyv6vvLWuKlcmFB5E0+XNQGS6pTf0
	 ti/zLMA+u3+hkiXFBpjWR5ownErbF+/yZ0wr4BD/IgDoOSswTFfMhY5KFuTjIoxESQ
	 +FYp7DSn+PODRaxi3t0Nmx/m/2y9OG53AV1iZbVJ4Wi1+xc7SPAc/WKiHkJRalouy+
	 UunXvdFQ05Bc/lO9XCFk174GQitiFpKj1H438obiPhjrZHWjoapJ3i9PifEOt54uWm
	 87HQAYIWCA7hA==
Message-ID: <30bff99d-f74a-47a4-aed5-2616a32fe423@kernel.org>
Date: Fri, 6 Mar 2026 20:29:20 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] amd-pstate: Fix memory leak in
 amd_pstate_epp_cpu_init()
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260306095753.17155-1-gautham.shenoy@amd.com>
 <20260306095753.17155-2-gautham.shenoy@amd.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20260306095753.17155-2-gautham.shenoy@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D25AC2299E5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43890-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[superm1@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.942];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 3/6/2026 3:57 AM, Gautham R. Shenoy wrote:
> On failure to set the epp, the function amd_pstate_epp_cpu_init()
> returns with an error code without freeing the cpudata object that was
> allocated at the beginning of the function.
> 
> Ensure that the cpudata object is freed before returning from the
> function.
> 
> This memory leak was discovered by Claude Opus 4.6 with the aid of
> Chris Mason's AI review-prompts
> (https://github.com/masoncl/review-prompts/tree/main/kernel).
> 
> Assisted-by: Claude:claude-opus-4.6 review-prompts/linux
> Fixes: f9a378ff6443 ("cpufreq/amd-pstate: Set different default EPP policy for Epyc and Ryzen")
> Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/cpufreq/amd-pstate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 5aa9fcd80cf51..d57969c72c9dc 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1533,7 +1533,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   
>   	ret = amd_pstate_set_epp(policy, cpudata->epp_default);
>   	if (ret)
> -		return ret;
> +		goto free_cpudata1;
>   
>   	current_pstate_driver->adjust_perf = NULL;
>   


