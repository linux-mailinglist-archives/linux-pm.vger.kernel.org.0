Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41F6A58D65
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 23:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfF0Vwd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 17:52:33 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50247 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0Vwd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 17:52:33 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 85ea1641cc35ec6f; Thu, 27 Jun 2019 23:52:31 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/5] cpufreq: Remove the redundant !setpolicy check
Date:   Thu, 27 Jun 2019 23:52:31 +0200
Message-ID: <2485108.CxIRPt9KNH@kreacher>
In-Reply-To: <b9bac95bcc36f5f70e910e4801be5d4f8fd32d0c.1560999838.git.viresh.kumar@linaro.org>
References: <cover.1560999838.git.viresh.kumar@linaro.org> <b9bac95bcc36f5f70e910e4801be5d4f8fd32d0c.1560999838.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, June 20, 2019 5:05:46 AM CEST Viresh Kumar wrote:
> cpufreq_start_governor() is only called for !setpolicy case, checking it
> again is not required.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 85ff958e01f1..54befd775bd6 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2153,7 +2153,7 @@ static int cpufreq_start_governor(struct cpufreq_policy *policy)
>  
>  	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
>  
> -	if (cpufreq_driver->get && !cpufreq_driver->setpolicy)
> +	if (cpufreq_driver->get)
>  		cpufreq_update_current_freq(policy);
>  
>  	if (policy->governor->start) {
> 

Applied, thanks!



