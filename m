Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94ADC1C1B1A
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 19:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgEARHF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 13:07:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728972AbgEARHF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 May 2020 13:07:05 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8867920836;
        Fri,  1 May 2020 17:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588352824;
        bh=5qpeiH/fIZx6UC1kR7bhjR0C7h+7C+1d7gOLo/CuMeo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TOfOVINGDu9vjdORFKv18QMxsZE425V3mgVpVH8wHxSmnLk14qPJgROgCktsu83+T
         gDSRwfrDlR9cSg1bHZYp7ZVXDpzBQf4XfW3REnsxacFn/2p1jWQVp9NyYIp9ytOqCB
         NXeDevyNj7ZGR60CP2qZ42UCPN1SfbV/NZXyMZ3w=
Subject: Re: [PATCH -next] cpupower: Remove unneeded semicolon
To:     Zou Wei <zou_wei@huawei.com>, trenn@suse.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <1588066995-71840-1-git-send-email-zou_wei@huawei.com>
From:   shuah <shuah@kernel.org>
Message-ID: <a51e2f2b-3381-bd5d-9599-0f291520b272@kernel.org>
Date:   Fri, 1 May 2020 11:07:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588066995-71840-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Zou Wei,

On 4/28/20 3:43 AM, Zou Wei wrote:
> Fixes coccicheck warnings:

I am not finding these in my coccicheck run. Can you send me the options
you are using?

> 
> tools/power/cpupower/utils/cpupower-info.c:65:2-3: Unneeded semicolon
> tools/power/cpupower/utils/cpupower-set.c:75:2-3: Unneeded semicolon
> tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c:120:2-3: Unneeded semicolon
> tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c:175:2-3: Unneeded semicolon
> tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c:56:2-3: Unneeded semicolon
> tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c:75:2-3: Unneeded semicolon
> tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c:82:2-3: Unneeded semicolon
> tools/power/cpupower/utils/idle_monitor/nhm_idle.c:94:2-3: Unneeded semicolon
> tools/power/cpupower/utils/idle_monitor/snb_idle.c:80:2-3: Unneeded semicolon
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>   tools/power/cpupower/utils/cpupower-info.c                | 2 +-
>   tools/power/cpupower/utils/cpupower-set.c                 | 2 +-
>   tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c | 2 +-
>   tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c   | 6 +++---
>   tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c    | 2 +-
>   tools/power/cpupower/utils/idle_monitor/nhm_idle.c        | 2 +-
>   tools/power/cpupower/utils/idle_monitor/snb_idle.c        | 2 +-
>   7 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/cpupower-info.c b/tools/power/cpupower/utils/cpupower-info.c
> index d3755ea..0ba61a2 100644
> --- a/tools/power/cpupower/utils/cpupower-info.c
> +++ b/tools/power/cpupower/utils/cpupower-info.c
> @@ -62,7 +62,7 @@ int cmd_info(int argc, char **argv)
>   		default:
>   			print_wrong_arg_exit();
>   		}
> -	};
> +	}
>   

The patch itself is fine.

thanks,
-- Shuah
