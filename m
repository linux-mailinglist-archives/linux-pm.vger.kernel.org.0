Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF42FF3D67
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 02:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfKHBZB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Nov 2019 20:25:01 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:60962 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfKHBZA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Nov 2019 20:25:00 -0500
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 9a94e20a5dd8eaf8; Fri, 8 Nov 2019 02:24:58 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     mathieu.poirier@linaro.org, mingo@redhat.com, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org
Subject: Re: [PATCH V6 3/3] powercap/drivers/idle_inject: Specify the idle state to inject
Date:   Fri, 08 Nov 2019 02:24:58 +0100
Message-ID: <9716500.oJdd2kxadQ@kreacher>
In-Reply-To: <20191030075141.1039-3-daniel.lezcano@linaro.org>
References: <20191030075141.1039-1-daniel.lezcano@linaro.org> <20191030075141.1039-3-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, October 30, 2019 8:51:41 AM CET Daniel Lezcano wrote:
> Currently the idle injection framework only allows to inject the
> deepest idle state available on the system.
> 
> Give the opportunity to specify which idle state we want to inject by
> adding a new function helper to set the state and use it when calling
> play_idle().
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   V6:
>    - Rename variable name 'state' -> 'state_idx':
>      https://lkml.org/lkml/2019/10/28/874
> ---
>  drivers/powercap/idle_inject.c | 14 +++++++++++++-
>  include/linux/idle_inject.h    |  3 +++
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
> index 233c878cbf46..2607d3e9afc5 100644
> --- a/drivers/powercap/idle_inject.c
> +++ b/drivers/powercap/idle_inject.c
> @@ -66,6 +66,7 @@ struct idle_inject_thread {
>   */
>  struct idle_inject_device {
>  	struct hrtimer timer;
> +	int state_idx;
>  	unsigned int idle_duration_us;
>  	unsigned int run_duration_us;
>  	unsigned long int cpumask[0];
> @@ -140,7 +141,7 @@ static void idle_inject_fn(unsigned int cpu)
>  	iit->should_run = 0;
>  
>  	play_idle(READ_ONCE(ii_dev->idle_duration_us),
> -		  cpuidle_find_deepest_state());
> +		  READ_ONCE(ii_dev->state_idx));
>  }
>  
>  /**
> @@ -171,6 +172,16 @@ void idle_inject_get_duration(struct idle_inject_device *ii_dev,
>  	*idle_duration_us = READ_ONCE(ii_dev->idle_duration_us);
>  }
>  
> +/**
> + * idle_inject_set_state - set the idle state to inject
> + * @state: an integer for the idle state to inject
> + */
> +void idle_inject_set_state(struct idle_inject_device *ii_dev, int index)
> +{
> +	if (index >= CPUIDLE_STATE_NOUSE && index < CPUIDLE_STATE_MAX)
> +		WRITE_ONCE(ii_dev->state_idx, index);
> +}

So whoever uses this interface, needs to know the idle states list as
provided by the cpuidle driver for the given CPU, but what really needs
to be specified here is the exit latency limit (which can be provided as
a number in us or ns without knowing the state index).



