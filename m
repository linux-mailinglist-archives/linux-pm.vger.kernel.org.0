Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417881B07BA
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 13:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgDTLmd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 07:42:33 -0400
Received: from foss.arm.com ([217.140.110.172]:46866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgDTLmc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Apr 2020 07:42:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 545301FB;
        Mon, 20 Apr 2020 04:42:31 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2846D3F237;
        Mon, 20 Apr 2020 04:42:30 -0700 (PDT)
Date:   Mon, 20 Apr 2020 12:42:25 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     zhang.lyra@gmail.com
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [RFC PATCH v1 1/2] cpuidle: allow idle state to be found as
 deepest state for s2idle only
Message-ID: <20200420114222.GA14343@lakrids.cambridge.arm.com>
References: <20200413070014.12960-1-zhang.lyra@gmail.com>
 <20200413070014.12960-2-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413070014.12960-2-zhang.lyra@gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 13, 2020 at 03:00:13PM +0800, zhang.lyra@gmail.com wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> Add a new flag CPUIDLE_FLAG_S2IDLE to allow c-state to be found as
> deepest state for s2idle only, so that users can add a new c-state
> for using s2idle and don't worry disturbing other use cases such as
> play_idle() which probably don't want to enter into so much deep
> idle state since devices are not suspended for that kind of cases.

Can you please elaborate on this?

Why exactly are these states not suited for regular cpu idle? What
problems do they cause? e.g. long wakeup latency?

The flag and the for-s2-idle-only DT property are encoding a policy
rarher than a property, and as such I don't think this is the right way
to describe this in the DT. However, if there might be porperties of the
idle state that we could describe so that the OS can come to the same
conclusion.

Thanks,
Mark.

> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  drivers/cpuidle/cpuidle.c        | 3 ++-
>  drivers/cpuidle/dt_idle_states.c | 3 +++
>  include/linux/cpuidle.h          | 1 +
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index de81298051b3..bb61f0c271d2 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -89,7 +89,8 @@ static int find_deepest_state(struct cpuidle_driver *drv,
>  		    s->exit_latency_ns <= latency_req ||
>  		    s->exit_latency_ns > max_latency_ns ||
>  		    (s->flags & forbidden_flags) ||
> -		    (s2idle && !s->enter_s2idle))
> +		    (s2idle && !s->enter_s2idle) ||
> +		    (!s2idle && (s->flags & CPUIDLE_FLAG_S2ILDE)))
>  			continue;
>  
>  		latency_req = s->exit_latency_ns;
> diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
> index 252f2a9686a6..530db2726c05 100644
> --- a/drivers/cpuidle/dt_idle_states.c
> +++ b/drivers/cpuidle/dt_idle_states.c
> @@ -80,6 +80,9 @@ static int init_state_node(struct cpuidle_state *idle_state,
>  	idle_state->flags = 0;
>  	if (of_property_read_bool(state_node, "local-timer-stop"))
>  		idle_state->flags |= CPUIDLE_FLAG_TIMER_STOP;
> +
> +	if (of_property_read_bool(state_node, "for-s2idle-only"))
> +		idle_state->flags |= CPUIDLE_FLAG_S2ILDE;
>  	/*
>  	 * TODO:
>  	 *	replace with kstrdup and pointer assignment when name
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index ec2ef63771f0..08da701f74cd 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -78,6 +78,7 @@ struct cpuidle_state {
>  #define CPUIDLE_FLAG_TIMER_STOP BIT(2) /* timer is stopped on this state */
>  #define CPUIDLE_FLAG_UNUSABLE	BIT(3) /* avoid using this state */
>  #define CPUIDLE_FLAG_OFF	BIT(4) /* disable this state by default */
> +#define CPUIDLE_FLAG_S2ILDE	BIT(5) /* state is used for s2idle only */
>  
>  struct cpuidle_device_kobj;
>  struct cpuidle_state_kobj;
> -- 
> 2.20.1
> 
