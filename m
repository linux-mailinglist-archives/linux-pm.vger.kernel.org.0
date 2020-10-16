Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29CA2903EA
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 13:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394897AbgJPLRk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 07:17:40 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13038 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405579AbgJPLRk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 07:17:40 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f8981270000>; Fri, 16 Oct 2020 04:16:55 -0700
Received: from [10.41.23.128] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Oct
 2020 11:17:37 +0000
Subject: Re: [PATCH] cpufreq: Improve code around unlisted freq check
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>
CC:     <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>, Sumit Gupta <sumitg@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>
References: <37c3f1f76c055b305d1bba2c2001ac5b1d7a9b5f.1602565964.git.viresh.kumar@linaro.org>
From:   Sumit Gupta <sumitg@nvidia.com>
Message-ID: <75176efa-a837-004f-c9ec-c9e2370834ae@nvidia.com>
Date:   Fri, 16 Oct 2020 16:47:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <37c3f1f76c055b305d1bba2c2001ac5b1d7a9b5f.1602565964.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602847015; bh=bmbZpnsVueT5P6vdVy7J6oHE188K2FYe5c+5IO6rybg=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=EZ6gTy1CF8YbzwdJ2bJAorKva+sDFfhxaZ3Kl2ePopgn7QKSgt5yz89nC2XP9VBjg
         3DoBiPmIiBdwT2IBQ9jtIty6NL01+MgUYwmVcfaU4O67w7iv9Sle2jw4p3EhHdNEow
         PA0G7cnQKiCQt5LiwYbb2xRFIXy37HRVBY8VcxrPI1VboIWPNhR7pU/yPdJK7CpRHK
         p0TQzB9LZBf9Fz/iVb2haDj0P3BnyaOR4QC1YLly7T0pakWhXNE7x1NZYs9cbpgkvP
         akyEKNlnkjcpLGBf2qFa2IFs4pF17ihW1wmYZdqkKC6Jg7ZLiGigSKRPxUHgIz6J80
         Yrldz5NsudeeA==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 13/10/20 10:42 AM, Viresh Kumar wrote:
> External email: Use caution opening links or attachments
> 
> 
> The cpufreq core checks if the frequency programmed by the bootloaders
> is not listed in the freq table and programs one from the table in such
> a case. This is done only if the driver has set the
> CPUFREQ_NEED_INITIAL_FREQ_CHECK flag.
> 
> Currently we print two separate messages, with almost the same content,
> and do this with a pr_warn() which may be a bit too much as the driver
> only asked us to check this as it expected this to be the case. Lower
> down the severity of the print message by switching to pr_info() instead
> and print a single message only.
> 

Reviewed-by: Sumit Gupta <sumitg@nvidia.com>
Tested-by: Sumit Gupta <sumitg@nvidia.com>

> Reported-by: Sumit Gupta <sumitg@nvidia.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/cpufreq.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 2ea245a6c0c0..99864afac272 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1461,14 +1461,13 @@ static int cpufreq_online(unsigned int cpu)
>           */
>          if ((cpufreq_driver->flags & CPUFREQ_NEED_INITIAL_FREQ_CHECK)
>              && has_target()) {
> +               unsigned int old_freq = policy->cur;
> +
>                  /* Are we running at unknown frequency ? */
> -               ret = cpufreq_frequency_table_get_index(policy, policy->cur);
> +               ret = cpufreq_frequency_table_get_index(policy, old_freq);
>                  if (ret == -EINVAL) {
> -                       /* Warn user and fix it */
> -                       pr_warn("%s: CPU%d: Running at unlisted freq: %u KHz\n",
> -                               __func__, policy->cpu, policy->cur);
> -                       ret = __cpufreq_driver_target(policy, policy->cur - 1,
> -                               CPUFREQ_RELATION_L);
> +                       ret = __cpufreq_driver_target(policy, old_freq - 1,
> +                                                     CPUFREQ_RELATION_L);
> 
>                          /*
>                           * Reaching here after boot in a few seconds may not
> @@ -1476,8 +1475,8 @@ static int cpufreq_online(unsigned int cpu)
>                           * frequency for longer duration. Hence, a BUG_ON().
>                           */
>                          BUG_ON(ret);
> -                       pr_warn("%s: CPU%d: Unlisted initial frequency changed to: %u KHz\n",
> -                               __func__, policy->cpu, policy->cur);
> +                       pr_info("%s: CPU%d: Running at unlisted initial frequency: %u KHz, changing to: %u KHz\n",
> +                               __func__, policy->cpu, old_freq, policy->cur);
>                  }
>          }
> 
> --
> 2.25.0.rc1.19.g042ed3e048af
> 
