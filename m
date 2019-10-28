Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8843EE74FC
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 16:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbfJ1PXb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 11:23:31 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57551 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbfJ1PXb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2019 11:23:31 -0400
Received: from cust-east-parth2-46-193-72-114.wb.wifirst.net (46.193.72.114) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id c030794400d0e802; Mon, 28 Oct 2019 16:23:29 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Clarify the comment in cpufreq_set_policy()
Date:   Mon, 28 Oct 2019 16:23:28 +0100
Message-ID: <3398893.vxru0tI2Zt@kreacher>
In-Reply-To: <ec3e8e001b35c9244f6406932335d7156b611373.1571739473.git.viresh.kumar@linaro.org>
References: <ec3e8e001b35c9244f6406932335d7156b611373.1571739473.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, October 22, 2019 12:17:57 PM CET Viresh Kumar wrote:
> One of the responsibility of the ->verify() callback is to make sure
> that the policy's min frequency is <= max frequency as this isn't
> guaranteed by the QoS framework which gave us those values.
> 
> Update the comment in cpufreq_set_policy() to clarify that.
> 
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 2e698b5f0f80..b4b5f11c2f1e 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2384,7 +2384,10 @@ int cpufreq_set_policy(struct cpufreq_policy *policy,
>  	new_policy->min = freq_qos_read_value(&policy->constraints, FREQ_QOS_MIN);
>  	new_policy->max = freq_qos_read_value(&policy->constraints, FREQ_QOS_MAX);
>  
> -	/* verify the cpu speed can be set within this limit */
> +	/*
> +	 * Verify that the cpu speed can be set within this limit and make sure
> +	 * min <= max.
> +	 */
>  	ret = cpufreq_driver->verify(new_policy);
>  	if (ret)
>  		return ret;
> 

Applying for 5.5, thanks!




