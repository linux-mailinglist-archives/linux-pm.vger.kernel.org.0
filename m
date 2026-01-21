Return-Path: <linux-pm+bounces-41230-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEnHBznTcGkOaAAAu9opvQ
	(envelope-from <linux-pm+bounces-41230-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 14:23:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C61B7577A6
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 14:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D246B500A9F
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 13:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE54348AE21;
	Wed, 21 Jan 2026 13:10:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FF52BEC5A;
	Wed, 21 Jan 2026 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769001001; cv=none; b=eHxlfx8qsfY6ziMW3UE0W1jn2tJ1c80ibLxYU4cgfdtSyNyiEJcATRQ+l/ODNUQ3R1wEk/1v64Cw1My5JsPUWxrIUrASPzmp39U6PgghTdqCdd1aoeZLiiBbfGMjseu6z6UgiXDviSJIPozTzlZ2T4ZVeu3GeDE2+UNN/bi6Tp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769001001; c=relaxed/simple;
	bh=CPsY6RTa1hEfVZejl1bNBxhaGWL4/6L3cEK/vvH1i3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PdicfJNpI5XQRyvjmGD/R6j1hw4VKpyXSPIEKaBSE16j0fDT02DnJXjsXjBwER7p9jTsPUnWBP0w0v5/QNF90hmvvhLhcxpgV0Gi9H3+8ZO2fcaiRXymyScGrBcbvWbKeTV5dbiwniJgK5vdy0pEiFR6Nkgon06iC2BzRNl+u/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E58E1476;
	Wed, 21 Jan 2026 05:09:52 -0800 (PST)
Received: from [10.1.35.68] (e127648.arm.com [10.1.35.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EA163F632;
	Wed, 21 Jan 2026 05:09:58 -0800 (PST)
Message-ID: <0d066ce0-b0bf-43f2-a1c4-56e5ac47cce1@arm.com>
Date: Wed, 21 Jan 2026 13:09:56 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] cpuidle: governors: teo: Avoid selecting states
 with zero-size bins
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
References: <2257365.irdbgypaU6@rafael.j.wysocki>
 <3033265.e9J7NaK4W3@rafael.j.wysocki>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <3033265.e9J7NaK4W3@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : No valid SPF, No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-pm];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.loehle@arm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-41230-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,arm.com:email,arm.com:mid]
X-Rspamd-Queue-Id: C61B7577A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/14/26 19:44, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If the last two enabled idle states have the same target residency which
> is at least equal to TICK_NSET, teo may select the next-to-last one even

s/TICK_NSET/TICK_NSEC

> though the size of that state's bin is 0, which is confusing.
> 
> Prevent that from happening by adding a target residency check to the
> relevant code path.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/governors/teo.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -388,6 +388,15 @@ static int teo_select(struct cpuidle_dri
>  			while (min_idx < idx &&
>  			       drv->states[min_idx].target_residency_ns < TICK_NSEC)
>  				min_idx++;
> +
> +			/*
> +			 * Avoid selecting a state with a lower index, but with
> +			 * the same target residency as the current candidate
> +			 * one.
> +			 */
> +			if (drv->states[min_idx].target_residency_ns ==
> +					drv->states[idx].target_residency_ns)

We need to check that min_idx isn't disabled though, otherwise we now skip a
potential (enabled) idx==1 if min_idx==2 and min_idx is disabled. 
Other than that LGTM and with that check and the nit above:

Reviewed-by: Christian Loehle <christian.loehle@arm.com>

> +				goto constraint;
>  		}
>  
>  		/*
> @@ -410,6 +419,7 @@ static int teo_select(struct cpuidle_dri
>  		}
>  	}
>  
> +constraint:
>  	/*
>  	 * If there is a latency constraint, it may be necessary to select an
>  	 * idle state shallower than the current candidate one.
> 
> 
> 


