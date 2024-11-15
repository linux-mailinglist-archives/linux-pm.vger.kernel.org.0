Return-Path: <linux-pm+bounces-17607-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E178D9CDC45
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 11:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE14283A20
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 10:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFA31B3933;
	Fri, 15 Nov 2024 10:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XLGlYOrC"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AB11B392C;
	Fri, 15 Nov 2024 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731665680; cv=none; b=H23t1OUbMF91AJ22XlFwPnusKMjlSa1NLwNLvaRF7YrMLxGFbBxQgiBsXyWNPlcd1UwZPbhyVvLFvIzgmaMa6sY00Q5ILebviVCZeILEB3T++PiC4p0eNxjnZQ+8bb0/5lomKKC5DzVykuEpe4zS8Zs5FHsTovgyvIa8W7j7Nw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731665680; c=relaxed/simple;
	bh=ClXDFqigNOWdwf9KNYarVPC6+6yyGvHil5GPQzCaJLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Axd3oo9HWz12wmX7ZsNdXVVsaOhQlwf8nXamK5w0PaQ5FfQbj7BcluJPXe8fipiWIQCjT8ZW+lf0+NyCRSTbsioq7xHl0oZIb/eiVBuszQftVJvp60E4W0GUn0O5C8o3vJ16d2pBMLcNHaQUOdTAL8+yzIfXAooDlMPCiEQAZUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XLGlYOrC; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bozUcDWdqBEL+95Swpb+9YqTsyPImTAFCDkHvk//y58=; b=XLGlYOrCvgyrAR20cuAYOT7hPv
	evzIHqUvbWWoGCJaZPg0IZBkLBCALUUqKhKLgFucJfx/6xYpKTd01kGXXaJ3vK0ASidnUKiiTafuq
	6YnxB/foNQaQrxPjyG4s1z8t3MtfAxy7zZMOGp4vVJFq1ugswiRB7XBDaTfCeB6RRtZrWIIzV4rcX
	sVLV4wim60uUEjfoYC87KLUkbfpUaiVgu+Veo4CzT/uxHAnmDn4XIjCSNzLf/9/RNikbaP6/p3rzF
	Zw9eze2I9LlirBz4iDc2yC9Y5HKb0xyMT44YXAmw9nHzuikhJw1NFX0m2B4YzqjN7e+EETLPeuOvA
	S5+kX0Xw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tBtLP-00000000DWO-2BDl;
	Fri, 15 Nov 2024 10:14:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2495230066A; Fri, 15 Nov 2024 11:14:27 +0100 (CET)
Date: Fri, 15 Nov 2024 11:14:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	x86 Maintainers <x86@kernel.org>,
	Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v1] cpuidle: Do not return from cpuidle_play_dead() on
 callback failures
Message-ID: <20241115101427.GA22801@noisy.programming.kicks-ass.net>
References: <4992010.31r3eYUQgx@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4992010.31r3eYUQgx@rjwysocki.net>

On Thu, Nov 14, 2024 at 06:46:20PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If the :enter_dead() idle state callback fails for a certain state,
> there may be still a shallower state for which it will work.
> 
> Because the only caller of cpuidle_play_dead(), native_play_dead(),
> falls back to hlt_play_dead() if it returns an error, it should
> better try all of the idle states for which :enter_dead() is present
> before failing, so change it accordingly.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpuidle/cpuidle.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> Index: linux-pm/drivers/cpuidle/cpuidle.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/cpuidle.c
> +++ linux-pm/drivers/cpuidle/cpuidle.c
> @@ -70,9 +70,10 @@ int cpuidle_play_dead(void)
>  		return -ENODEV;
>  
>  	/* Find lowest-power state that supports long-term idle */
> -	for (i = drv->state_count - 1; i >= 0; i--)
> -		if (drv->states[i].enter_dead)
> -			return drv->states[i].enter_dead(dev, i);
> +	for (i = drv->state_count - 1; i >= 0; i--) {
> +		if (drv->states[i].enter_dead && !drv->states[i].enter_dead(dev, i))
> +			return 0;
> +	}

Hmm, strictly speaking there is no 'success' return from play_dead(). On
success, the CPU is dead :-)

