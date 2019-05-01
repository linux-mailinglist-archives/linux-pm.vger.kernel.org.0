Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 963A6106EE
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2019 12:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfEAKXw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 06:23:52 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61309 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfEAKXw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 06:23:52 -0400
Received: from 79.184.254.69.ipv4.supernova.orange.pl (79.184.254.69) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 71690d2d1aeaf7d2; Wed, 1 May 2019 12:23:51 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     viresh.kumar@linaro.org, rafael.j.wysocki@intel.com,
        linux-pm@vger.kernel.org, huyue2@yulong.com
Subject: Re: [PATCH] cpufreq: Remove needless bios_limit check in show_bios_limit()
Date:   Wed, 01 May 2019 12:23:50 +0200
Message-ID: <21353710.QnO7stapYA@kreacher>
In-Reply-To: <20190416024027.6516-1-zbestahu@gmail.com>
References: <20190416024027.6516-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, April 16, 2019 4:40:27 AM CEST Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Initially, bios_limit attribute will be created if driver->bios_limit
> is set in cpufreq_add_dev_interface(). So remove the redundant check
> for latter show operation.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  drivers/cpufreq/cpufreq.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index d9123de..047662b 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -857,11 +857,9 @@ static ssize_t show_bios_limit(struct cpufreq_policy *policy, char *buf)
>  {
>  	unsigned int limit;
>  	int ret;
> -	if (cpufreq_driver->bios_limit) {
> -		ret = cpufreq_driver->bios_limit(policy->cpu, &limit);
> -		if (!ret)
> -			return sprintf(buf, "%u\n", limit);
> -	}
> +	ret = cpufreq_driver->bios_limit(policy->cpu, &limit);
> +	if (!ret)
> +		return sprintf(buf, "%u\n", limit);
>  	return sprintf(buf, "%u\n", policy->cpuinfo.max_freq);
>  }
>  
> 

Applied, thanks!




