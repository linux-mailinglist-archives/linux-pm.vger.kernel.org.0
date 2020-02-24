Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7759F16B3E5
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 23:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgBXW1K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 17:27:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:32900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727249AbgBXW1J (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Feb 2020 17:27:09 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3577921744;
        Mon, 24 Feb 2020 22:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582583228;
        bh=WWPak2AFUuceePOBYdtUKhE65dyVm6ZA09X+7CE9Gco=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MyLQXz+2GJVE3rDR/k0By0c8Lxd9qk7AJR8k44Rqg3BZZPvqp66xwsfPVghhKU8sA
         GQfizaZmBW4c0NVsh4yZOPzfSRwp3HvChNEHItc1OgeYXBivILQ10yVUfbfzG3QZse
         wBfelyKdOu+JofypCeHOacu1x6wpkp/2POB5Q90M=
Subject: Re: [PATCH v2] cpupower: avoid multiple definition with gcc
 -fno-common
To:     Mike Gilbert <floppym@gentoo.org>, linux-pm@vger.kernel.org
Cc:     trenn@suse.com, shuah <shuah@kernel.org>
References: <20200201175046.3948500-1-floppym@gentoo.org>
 <20200224202029.877025-1-floppym@gentoo.org>
From:   shuah <shuah@kernel.org>
Message-ID: <a4c5af79-d9f0-2ea8-4013-30fe8f2a96d3@kernel.org>
Date:   Mon, 24 Feb 2020 15:26:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224202029.877025-1-floppym@gentoo.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Mike,

On 2/24/20 1:20 PM, Mike Gilbert wrote:
> The -fno-common option will be enabled by default in GCC 10.

Great. It landed in my inbox now.
Please include the message you are seeing in the change log.

> 
> Bug: https://bugs.gentoo.org/707462
> Signed-off-by: Mike Gilbert <floppym@gentoo.org>
> --- >> v2: Made start_time static instead of extern.
> 
>   tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c  | 2 +-
>   tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c    | 2 +-
>   tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c | 2 ++
>   tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h | 2 +-
>   4 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c b/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
> index 33dc34db4f3c..20f46348271b 100644
> --- a/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
> +++ b/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
> @@ -82,7 +82,7 @@ static struct pci_access *pci_acc;
>   static struct pci_dev *amd_fam14h_pci_dev;
>   static int nbp1_entered;
>   
> -struct timespec start_time;
> +static struct timespec start_time;
>   static unsigned long long timediff;

Does it make sense to move start_time and timediff defines to
cpupower-monitor.c and adding externs for them in
cpupower-monitor.h?

>   
>   #ifdef DEBUG
> diff --git a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
> index 3c4cee160b0e..a65f7d011513 100644
> --- a/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
> +++ b/tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c
> @@ -19,7 +19,7 @@ struct cpuidle_monitor cpuidle_sysfs_monitor;
>   
>   static unsigned long long **previous_count;
>   static unsigned long long **current_count;
> -struct timespec start_time;
> +static struct timespec start_time;
>   static unsigned long long timediff;
>   
>   static int cpuidle_get_count_percent(unsigned int id, double *percent,
> diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> index 6d44fec55ad5..7c77045fef52 100644
> --- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> +++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> @@ -27,6 +27,8 @@ struct cpuidle_monitor *all_monitors[] = {
>   0
>   };
>   
> +int cpu_count;
> +
>   static struct cpuidle_monitor *monitors[MONITORS_MAX];
>   static unsigned int avail_monitors;
>   
> diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
> index 5b5eb1da0cce..c559d3115330 100644
> --- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
> +++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
> @@ -25,7 +25,7 @@
>   #endif
>   #define CSTATE_DESC_LEN 60
>   
> -int cpu_count;
> +extern int cpu_count;
>   
>   /* Hard to define the right names ...: */
>   enum power_range_e {
> 

thanks,
-- Shuah
