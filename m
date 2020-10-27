Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570B029A2EB
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 04:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436870AbgJ0DGT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 23:06:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41927 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436825AbgJ0DGS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2020 23:06:18 -0400
Received: by mail-pl1-f195.google.com with SMTP id w11so9941pll.8
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2020 20:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bZ+poZHp6tJl3tkG9P7E99WJ8ANGR1+a+nENYn33bgI=;
        b=NhoiMmlVAe54UlUm+JfQ/Ch6ew2TOAVX65QWMTqB8RoWfd/T2uPciyd3smue0kS4za
         tif2V5WAeghAiEyt3CmJyQQzhuSLYHmWN01ThQVvZxmlYdrpKawhzqTnQsz+GCq5WWGX
         DTYlX9HCAsOwzzQpJOrGmfZLOa9UpNIRzga4DoD7zxMQhh9L1K+yVTV6bpQ3+GUT9lhM
         7zi4F6a335BDLpXNksaVtcLy884ba6883kUAyj/aJfxIbOVXPbDsBh1N3JwsvZzwsLV1
         eTtLbKbjtRSUnAWK1BkAIDqo9kmkxmLkXCAGAUzyTqjYvhOqfiGGSVeCyrdr8FrSV/NT
         7rkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bZ+poZHp6tJl3tkG9P7E99WJ8ANGR1+a+nENYn33bgI=;
        b=IycENZCHyi3uT3z69L+lcvLdnkrlHRRGefVPN5adPEIzARERtHrcFt0EC8bNqQtuwt
         cbFsVH9Vhd8zVp+hHJ9EkqrAE1sXkt9tSdhVTHprjg53sGB8qUyfiQ5lVk1x1nb3tfN6
         h6fK91CNhhvAFpfpcHqWSy02MT5IjN0rt1whpUGHSnWiRcp3+zDBbBhf1CTJJNKZNn4W
         F9ArzDVNMszMtBhw+GajXCp0dmeoU49XV9/QG0U2nZ1+D9NI4KfK4mIBEWgSPek6sW2B
         HMMRlwaEUBmjPJ7QMO9QE56S3+Fsd8WK6J+EUIVMNeVAGytyuT1vt0JF8x1t5Cd8Je+J
         KyIg==
X-Gm-Message-State: AOAM530DrTN1tvB8aGsGa2NA2kX52mZYKGTACEwFscWF0SyfxuPvQnGz
        56ah3QWSh0EtyNABSlZQ0usl6w==
X-Google-Smtp-Source: ABdhPJxHD0CMz7aeVmarlZKwxd0aVgM8BFWLORz79ZP9Qjb7ulIDCckETspbqwaQiT+Xo7+lv1ztiQ==
X-Received: by 2002:a17:90a:8906:: with SMTP id u6mr60867pjn.35.1603767978154;
        Mon, 26 Oct 2020 20:06:18 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id i21sm20124pgh.2.2020.10.26.20.06.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 20:06:17 -0700 (PDT)
Date:   Tue, 27 Oct 2020 08:36:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v2 1/4] cpufreq: Introduce CPUFREQ_NEED_UPDATE_LIMITS
 driver flag
Message-ID: <20201027030615.oasrkjpa6ejwrmdp@vireshk-i7>
References: <2183878.gTFULuzKx9@kreacher>
 <1673796.UrKzctInAk@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1673796.UrKzctInAk@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-10-20, 17:35, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Generally, a cpufreq driver may need to update some internal upper
> and lower frequency boundaries on policy max and min changes,
> respectively, but currently this does not work if the target
> frequency does not change along with the policy limit.
> 
> Namely, if the target frequency does not change along with the
> policy min or max, the "target_freq == policy->cur" check in
> __cpufreq_driver_target() prevents driver callbacks from being
> invoked and they do not even have a chance to update the
> corresponding internal boundary.
> 
> This particularly affects the "powersave" and "performance"
> governors that always set the target frequency to one of the
> policy limits and it never changes when the other limit is updated.
> 
> To allow cpufreq the drivers needing to update internal frequency
> boundaries on policy limits changes to avoid this issue, introduce
> a new driver flag, CPUFREQ_NEED_UPDATE_LIMITS, that (when set) will
> neutralize the check mentioned above.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> New patch in v2.
> 
> ---
>  drivers/cpufreq/cpufreq.c |    3 ++-
>  include/linux/cpufreq.h   |   10 +++++++++-
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/include/linux/cpufreq.h
> ===================================================================
> --- linux-pm.orig/include/linux/cpufreq.h
> +++ linux-pm/include/linux/cpufreq.h
> @@ -297,7 +297,7 @@ __ATTR(_name, 0644, show_##_name, store_
>  
>  struct cpufreq_driver {
>  	char		name[CPUFREQ_NAME_LEN];
> -	u8		flags;
> +	u16		flags;
>  	void		*driver_data;
>  
>  	/* needed by all drivers */
> @@ -417,6 +417,14 @@ struct cpufreq_driver {
>   */
>  #define CPUFREQ_IS_COOLING_DEV			BIT(7)
>  
> +/*
> + * Set by drivers that need to update internale upper and lower boundaries along
> + * with the target frequency and so the core and governors should also invoke
> + * the diver if the target frequency does not change, but the policy min or max
> + * may have changed.
> + */
> +#define CPUFREQ_NEED_UPDATE_LIMITS		BIT(8)
> +
>  int cpufreq_register_driver(struct cpufreq_driver *driver_data);
>  int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
>  
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -2191,7 +2191,8 @@ int __cpufreq_driver_target(struct cpufr
>  	 * exactly same freq is called again and so we can save on few function
>  	 * calls.
>  	 */
> -	if (target_freq == policy->cur)
> +	if (target_freq == policy->cur &&
> +	    !(cpufreq_driver->flags & CPUFREQ_NEED_UPDATE_LIMITS))

I was wondering if the same change should be made in the target_index part as we
do this kind of check again ? But then I thought that since we know there are no
users of that right now, why bother :)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
