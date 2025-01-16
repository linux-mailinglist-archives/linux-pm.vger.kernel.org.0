Return-Path: <linux-pm+bounces-20545-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B081BA13AE2
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 14:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BDAD188C068
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 13:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630E622A7EC;
	Thu, 16 Jan 2025 13:27:50 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE9F22A7E4;
	Thu, 16 Jan 2025 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737034070; cv=none; b=XRcy2+gVEfxbfU8rOeV9zOInUNasu16tofseRmfSj+YXAwzY3Pol77GtSTo+EzM1l3iAWeph9L6U3wai4s7kNgO5HZlnnBGS7W76XPGlvfpLebO5TquecUo67oZnmLbA7PeD5C+TrUstED+t5gvFNb3qCab6EHDV/rxwfFFmgO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737034070; c=relaxed/simple;
	bh=FtfcWd01mSXm76DD2MYj54nNhXTffDs79k+HGqbaueo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ntKoW4s71spJaaeT83U2jm1ETJR2Uc0mkbmcqHyeSQRgMqu9JdAofDRnBPHVEqD7gljFwKH3wCeEY89bRbq+mcc0puDhGGJ9G0XXawGJ9sexvRG50+2VtSP35mf6nnhoq5DsuTqvBGU/fy8Fy1q4eBCVQbRSAgkHzXFq+yir88M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB3C0106F;
	Thu, 16 Jan 2025 05:28:15 -0800 (PST)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 524D73F673;
	Thu, 16 Jan 2025 05:27:45 -0800 (PST)
Message-ID: <a61647e9-dedd-4053-8f65-126564748950@arm.com>
Date: Thu, 16 Jan 2025 13:27:39 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/9] cpuidle: teo: Reorder candidate state index checks
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
References: <6116275.lOV4Wx5bFT@rjwysocki.net>
 <1907276.tdWV9SEqCh@rjwysocki.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <1907276.tdWV9SEqCh@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/25 18:36, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since constraint_idx may be 0, the candidate state index may change to 0
> after assigning constraint_idx to it, so first check if it is greater
> than constraint_idx (and update it if so) and then check it against 0.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Fine with me now, since the posted patch addresses my concern.
Reviewed-by: Christian Loehle <christian.loehle@arm.com>

> ---
> 
> This is a rebased variant of
> 
> https://lore.kernel.org/linux-pm/8476650.T7Z3S40VBb@rjwysocki.net/
> 
> ---
>  drivers/cpuidle/governors/teo.c |   15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -428,6 +428,14 @@
>  				break;
>  		}
>  	}
> +
> +	/*
> +	 * If there is a latency constraint, it may be necessary to select an
> +	 * idle state shallower than the current candidate one.
> +	 */
> +	if (idx > constraint_idx)
> +		idx = constraint_idx;
> +
>  	if (!idx && prev_intercept_idx) {
>  		/*
>  		 * We have to query the sleep length here otherwise we don't
> @@ -439,13 +447,6 @@
>  	}
>  
>  	/*
> -	 * If there is a latency constraint, it may be necessary to select an
> -	 * idle state shallower than the current candidate one.
> -	 */
> -	if (idx > constraint_idx)
> -		idx = constraint_idx;
> -
> -	/*
>  	 * Skip the timers check if state 0 is the current candidate one,
>  	 * because an immediate non-timer wakeup is expected in that case.
>  	 */
> 
> 
> 


