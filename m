Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC8315CFDA
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2020 03:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgBNCT1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 21:19:27 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46407 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgBNCT0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2020 21:19:26 -0500
Received: by mail-pf1-f196.google.com with SMTP id k29so4062444pfp.13
        for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2020 18:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4I810uUcCa94O8o1UlAKbQD3L4Wlk5QU1lNCuTSmZdI=;
        b=HNlgbyRHlY/ab/PWmEWgT4cNJuYfK/UrcM4xAUz5DHiHl3iEKComJXj9/oidVspEIA
         DCMF2HH+XEZSU19biMDPrjfDXICuX+k+4RGkdhw9sClXrrpIXtatlhQ4JuKp4STV4cBh
         P+nqcdDN4PnPTZ4rMxUk3lyf14hiUjEfOKCiOfiQrvk+8XTJ7+Yp+EP//dnTurvXygIp
         oOcmpzUF4ZcP+c/6a5evHAVrBXlbqLmmieiPrpx0IxaPuE71GnFVcXPvnJgrIoE2Yt52
         zrlMw4aHRj13k+9w9oK1ETtBGpJwPHQCiXsyOO2Gm1wb/DOVZWpRHdW2miis96BzxbaG
         KaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4I810uUcCa94O8o1UlAKbQD3L4Wlk5QU1lNCuTSmZdI=;
        b=WWLf6S8SZDH+WnQDPWzLnbOIKty+0A78WBkc4kt5nqF/IAbhc0t5fUxPNZJTD78ojZ
         dnvyXDZsl/5ZtubS2aZH3BodjlvG8JZVft8mjdf/1HuWCH448wiTIK6A8AWJpfO/ugM0
         bTq3Y29JOYohUMrxHI1/iE73XGdmdJFw4TFfC7xoB1b5AYKMQYFx+vPTnxd2rDjaELk/
         ZMG2zfaCEByb3y5uHR2ss3fYNKgofHtehySBKn4dOYtlzbMmnwhOayqGdbqEwKIOSErE
         W8NB6Ek8El4z/LvRbQm7WUyGsEhmd4rmAf7UVmHZsj3J19vVuD9eCAkNf+phVMCVFy1p
         V6BQ==
X-Gm-Message-State: APjAAAUeSW2OjsESjDQz4NmPXmpfyjBqi1dAwzTAQnZ/Vq+0t4EDXDIE
        hu+gcdGw1FblVTUpGFXv5E4zdg==
X-Google-Smtp-Source: APXvYqxl5UE4iFmjPVhmfPoYKTGz0wrRqKh1H2y/RNSHDp/d25/zZFyvCC8AfTu43QLdADGSD1EBzw==
X-Received: by 2002:aa7:84cd:: with SMTP id x13mr1014993pfn.130.1581646766063;
        Thu, 13 Feb 2020 18:19:26 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b18sm4698863pfb.116.2020.02.13.18.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 18:19:25 -0800 (PST)
Date:   Thu, 13 Feb 2020 18:19:22 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: Re: [RFC][PATCH] driver core: Extend returning EPROBE_DEFER for two
 minutes after late_initcall
Message-ID: <20200214021922.GO1443@yoga>
References: <20200214004413.12450-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214004413.12450-1-john.stultz@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 13 Feb 16:44 PST 2020, John Stultz wrote:

> Due to commit e01afc3250255 ("PM / Domains: Stop deferring probe
> at the end of initcall"), along with commit 25b4e70dcce9
> ("driver core: allow stopping deferred probe after init") after
> late_initcall, drivers will stop getting EPROBE_DEFER, and
> instead see an error causing the driver to fail to load.
> 
> That change causes trouble when trying to use many clk drivers
> as modules, as the clk modules may not load until much later
> after init has started. If a dependent driver loads and gets an
> error instead of EPROBE_DEFER, it won't try to reload later when
> the dependency is met, and will thus fail to load.
> 
> Instead of reverting that patch, this patch tries to extend the
> time that EPROBE_DEFER is retruned by two minutes, to (hopefully)
> ensure that everything has had a chance to load.
> 
> Specifically, on db845c, this change allows us to set
> SDM_GPUCC_845, QCOM_CLK_RPMH and COMMON_CLK_QCOM as modules and
> get a working system, where as without it the display will fail
> to load.

The purpose of 25b4e70dcce9 ("driver core: allow stopping deferred probe
after init") is to ensure that when the kernel boots with a DeviceTree
blob that references a resource (power-domain in this case) that either
hasn't been compiled in, or simply doesn't exist yet, it should continue
to boot - under the assumption that these resources probably aren't
needed to provide a functional system.

I don't think your patch maintains this behavior, because when userspace
kicks in and load kernel modules during the first two minutes they will
all end up in the probe deferral list. Past two minutes any event that
registers a new driver (i.e. manual intervention) will kick of a new
wave of probing, which will now continue as expected, ignoring any
power-domains that is yet to be probed (either because they don't exist
or they are further down the probe deferral list).

You can improve the situation somewhat by calling
driver_deferred_probe_trigger() in your
deferred_initcall_done_work_func(), to remove the need for human
intervention. But the outcome will still depend on the order in
deferred_probe_active_list.



That said, your patch does resolve an important problem for me!

We have a number of drivers providing power-domains that are registered
subject to timing in interaction with co-processors. So with a
sufficiently small kernel (e.g. heavy use of kernel modules) it's likely
that these are registered past late_initcall.

Your extension of this to two minutes past late_initcall will for sure
be sufficient to avoid this issue.

Regards,
Bjorn

> 
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-pm@vger.kernel.org
> Fixes: e01afc3250255 ("PM / Domains: Stop deferring probe at the end of initcall")
> Fixes: 25b4e70dcce9 ("driver core: allow stopping deferred probe after init")
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/base/dd.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index b25bcab2a26b..35ebae8b65be 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -311,6 +311,12 @@ static void deferred_probe_timeout_work_func(struct work_struct *work)
>  }
>  static DECLARE_DELAYED_WORK(deferred_probe_timeout_work, deferred_probe_timeout_work_func);
>  
> +static void deferred_initcall_done_work_func(struct work_struct *work)
> +{
> +	initcalls_done = true;
> +}
> +static DECLARE_DELAYED_WORK(deferred_initcall_done_work, deferred_initcall_done_work_func);
> +
>  /**
>   * deferred_probe_initcall() - Enable probing of deferred devices
>   *
> @@ -327,7 +333,7 @@ static int deferred_probe_initcall(void)
>  	driver_deferred_probe_trigger();
>  	/* Sort as many dependencies as possible before exiting initcalls */
>  	flush_work(&deferred_probe_work);
> -	initcalls_done = true;
> +	schedule_delayed_work(&deferred_initcall_done_work, 120 * HZ);
>  
>  	/*
>  	 * Trigger deferred probe again, this time we won't defer anything
> -- 
> 2.17.1
> 
