Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC15758D67
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 23:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfF0Vws (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 17:52:48 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43346 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0Vwr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 17:52:47 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 7cadff100b9ad2cd; Thu, 27 Jun 2019 23:52:45 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 3/5] cpufreq: Use has_target() instead of !setpolicy
Date:   Thu, 27 Jun 2019 23:52:45 +0200
Message-ID: <1887700.825Na11sEE@kreacher>
In-Reply-To: <56d8e01d8febb81917aded319249145fdc73daec.1560999838.git.viresh.kumar@linaro.org>
References: <cover.1560999838.git.viresh.kumar@linaro.org> <56d8e01d8febb81917aded319249145fdc73daec.1560999838.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, June 20, 2019 5:05:48 AM CEST Viresh Kumar wrote:
> For code consistency, use has_target() instead of !setpolicy everywhere,
> as it is already done at several places. Maybe we should also use
> "!has_target()" instead of "cpufreq_driver->setpolicy" where we need to
> check if the driver supports setpolicy, so to use only one expression
> for this kind of differentiation.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 41ac701e324f..5f5c7a516c74 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -632,7 +632,7 @@ static int cpufreq_parse_policy(char *str_governor,
>  }
>  
>  /**
> - * cpufreq_parse_governor - parse a governor string only for !setpolicy
> + * cpufreq_parse_governor - parse a governor string only for has_target()
>   */
>  static int cpufreq_parse_governor(char *str_governor,
>  				  struct cpufreq_policy *policy)
> @@ -1301,7 +1301,7 @@ static int cpufreq_online(unsigned int cpu)
>  		policy->max = policy->user_policy.max;
>  	}
>  
> -	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
> +	if (cpufreq_driver->get && has_target()) {
>  		policy->cur = cpufreq_driver->get(policy->cpu);
>  		if (!policy->cur) {
>  			pr_err("%s: ->get() failed\n", __func__);
> @@ -2401,7 +2401,7 @@ void cpufreq_update_policy(unsigned int cpu)
>  	 * BIOS might change freq behind our back
>  	 * -> ask driver for current freq and notify governors about a change
>  	 */
> -	if (cpufreq_driver->get && !cpufreq_driver->setpolicy &&
> +	if (cpufreq_driver->get && has_target() &&
>  	    (cpufreq_suspended || WARN_ON(!cpufreq_update_current_freq(policy))))
>  		goto unlock;
>  
> 

Applied, thanks!



