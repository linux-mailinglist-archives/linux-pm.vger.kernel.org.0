Return-Path: <linux-pm+bounces-36346-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82608BE804A
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 12:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 359BB3A17B9
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 10:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300BF2D77FE;
	Fri, 17 Oct 2025 10:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mESr5QPA"
X-Original-To: linux-pm@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8672D6E5B;
	Fri, 17 Oct 2025 10:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760696127; cv=none; b=swRg2XvIPMAjFSs95iIkkzfe9VziMwgDnjsx6bcSDByGeTQxTLlmsrspS/DXFEyvKWBaMgPlu78jDGBR5jborKdJsJz1GoocczNQB+ijeQDV6m3maPCyOUR67nRRYJsceJMktzqcNvWNZfS+LbcFwkMTcEa7hLkfX2SkqUwJX1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760696127; c=relaxed/simple;
	bh=0ZRBA+nKWLHvVQU5bLDfqU164MIzoUT/GKn7+SZOtgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFDp/wt5mx8hBrGJ60jox0OAKrYkdTXWycOYX6PWRNbYDPMurUeVDx6Ykcs955oivFRlETjHvl6bdm30f6Tj6H2Je6T+rciIsQjnwU8Bk689wx1kcIbjewhzXFLDkCY/WtXmbLFuxrbVHc/xxV/PdT/6puDHg8ljh7VR+qXtCEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mESr5QPA; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=foxZlAn+rwPCGv1EUUcZaOp0f3TbSZApKlY3+roEXio=; b=mESr5QPA5RKifin8wuK4L0aypL
	WM4yr6k0hjnZvn+AKVC0ztwCCVXJEHDcW4vP+XJxd0ziJ5RRG9aSItE4P1CO/53kl2/UQ+6jzH14f
	8mmORddVkj4qz6RD0smXvwmPaPDaudD1SZ3nnyTjvemzMvYhPFhsVHV7PxgCCj7eFLRdqBcCKcXk9
	xW/RAqPKFLoW1FMMCwr3bes8t55GEE1BAdt9v41Z7jfbl0xKpcw6fBcFh0LbCKBzFlaVHC53noGeq
	jDzotC36/rsRJQTISlIz28EMRFXSK++Um8LUT7j6exlKCFRGIbUGrRkUPjTMo7D3HLaTsiKQXFbTW
	SioC9xKQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9hUS-00000007Sf6-0q00;
	Fri, 17 Oct 2025 10:15:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C04ED30023C; Fri, 17 Oct 2025 12:15:15 +0200 (CEST)
Date: Fri, 17 Oct 2025 12:15:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Saravana Kannan <saravanak@google.com>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>, Dhruva Gole <d-gole@ti.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] sched: idle: Respect the CPU system-wakeup QoS
 limit for s2idle
Message-ID: <20251017101515.GX4067720@noisy.programming.kicks-ass.net>
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
 <20251016151929.75863-4-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016151929.75863-4-ulf.hansson@linaro.org>

On Thu, Oct 16, 2025 at 05:19:23PM +0200, Ulf Hansson wrote:

No objections to this.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index c39b089d4f09..c1c3d0166610 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -131,12 +131,13 @@ void __cpuidle default_idle_call(void)
>  }
>  
>  static int call_cpuidle_s2idle(struct cpuidle_driver *drv,
> -			       struct cpuidle_device *dev)
> +			       struct cpuidle_device *dev,
> +			       u64 max_latency_ns)
>  {
>  	if (current_clr_polling_and_test())
>  		return -EBUSY;
>  
> -	return cpuidle_enter_s2idle(drv, dev);
> +	return cpuidle_enter_s2idle(drv, dev, max_latency_ns);
>  }
>  
>  static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> @@ -205,12 +206,13 @@ static void cpuidle_idle_call(void)
>  		u64 max_latency_ns;
>  
>  		if (idle_should_enter_s2idle()) {
> +			max_latency_ns = cpu_wakeup_latency_qos_limit() *
> +					 NSEC_PER_USEC;
>  
> -			entered_state = call_cpuidle_s2idle(drv, dev);
> +			entered_state = call_cpuidle_s2idle(drv, dev,
> +							    max_latency_ns);
>  			if (entered_state > 0)
>  				goto exit_idle;
> -
> -			max_latency_ns = U64_MAX;
>  		} else {
>  			max_latency_ns = dev->forced_idle_latency_limit_ns;
>  		}
> -- 
> 2.43.0
> 

