Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 763041661B5
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 17:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgBTQBk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 11:01:40 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40137 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbgBTQBk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 11:01:40 -0500
Received: by mail-pg1-f193.google.com with SMTP id z7so2143097pgk.7
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2020 08:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7YYhTHyPcet2bXJxoSBw3K8Nr56X3eocGMytdf5zvZI=;
        b=lfWVAO9I+3ZPdqPQdR6d+YtLLaP1HvUMxmm9lbf13Q6U+p19v1eOepI/GH/7BzzkHh
         vMfLHDVNT1pipnCqSsEC1ulxbhYvyVkZCeQ1+GnNLxmHnAb1cRhDIJiUfNC5/j0XCIAL
         pphx2xlzjuYFVRjTvlPBArhEb9+cBi4Bjqf8tZL14TgMlCGzD+e09KnQQaaCwlXLOUFM
         KhyTTtUM4R7AZ1gChki1o5wbh6+hDMRpMIhVDlLhWWcuDphBDTspj+rvwJB2qM3IHu1g
         sLGkHcNlLhxD1bKSl/ZT59rzHyhm74A228XgFK79bk8AAEeprvXy3q9zlvxmB9QKMpAx
         FCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7YYhTHyPcet2bXJxoSBw3K8Nr56X3eocGMytdf5zvZI=;
        b=MH1v6VcsokIgY9fg8cqJI3CKloPjnoMwp8PhglONRNbCyckWpkuED3SX5F6miFFQjE
         HExUNcsWBvky0iCpAaIc88gW4E0eSNLaE9A9WVZtyzbuxdks5XPLrZS2sBpmSAJ6gRyK
         E9yrVbDSSkwuCgi2RyFzUidzUNC03j9T+XFJaYfoW3OUYdv/ei0UMv34/fdsxaOG6UqV
         koVPCIqb1Iu0akddrMWacyiMQCPkNzOcicdXl7IqGTGblEIVa3+FVgb1+sIw3gTjHGHw
         VRjMKLX7uYioBp+1N7qkGvvZQyGbxj1MJq9oqs+4V/zSn3+pFIGI7WWdsm5v+83d6a+s
         y1ew==
X-Gm-Message-State: APjAAAVw63AtanU9RnrVS0ylXuCcJgsYjkKcbZCamjhsMukoLeLygWRY
        Nmtrgxt9bEf/Vy1A8ce0ggjUrg==
X-Google-Smtp-Source: APXvYqxsbs+MxhGVm4m2x6lk3oob0XT1vb2VDrlT4K7aCvPbjPepCVTI7dZD3V2GTfqiLQ/KuwzJQw==
X-Received: by 2002:a63:fe4f:: with SMTP id x15mr34695489pgj.30.1582214499616;
        Thu, 20 Feb 2020 08:01:39 -0800 (PST)
Received: from ripper (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y24sm4368808pge.72.2020.02.20.08.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:01:38 -0800 (PST)
Date:   Thu, 20 Feb 2020 08:00:43 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 5/6] driver core: Rename deferred_probe_timeout and
 make it global
Message-ID: <20200220160043.GG955802@ripper>
References: <20200220050440.45878-1-john.stultz@linaro.org>
 <20200220050440.45878-6-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220050440.45878-6-john.stultz@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed 19 Feb 21:04 PST 2020, John Stultz wrote:

> Since other subsystems (like regulator) have similar arbitrary
> timeouts for how long they try to resolve driver dependencies,
> rename deferred_probe_timeout to driver_deferred_probe_timeout
> and set it as global, so it can be shared.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> Change-Id: I92ee3b392004ecc9217c5337b54eda48c2d7f3ee

Change-Id...

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> v4:
> * Split out into its own patch as suggested by Mark
> * Renamed deferred_probe_timeout as suggested by Greg
> ---
>  drivers/base/dd.c             | 18 ++++++++++--------
>  include/linux/device/driver.h |  1 +
>  2 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 408e4da081da..39f1ce6d4f1c 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -229,17 +229,19 @@ DEFINE_SHOW_ATTRIBUTE(deferred_devs);
>   * In the case of modules, set the default probe timeout to
>   * 30 seconds to give userland some time to load needed modules
>   */
> -static int deferred_probe_timeout = 30;
> +int driver_deferred_probe_timeout = 30;
>  #else
>  /* In the case of !modules, no probe timeout needed */
> -static int deferred_probe_timeout = -1;
> +int driver_deferred_probe_timeout = -1;
>  #endif
> +EXPORT_SYMBOL_GPL(driver_deferred_probe_timeout);
> +
>  static int __init deferred_probe_timeout_setup(char *str)
>  {
>  	int timeout;
>  
>  	if (!kstrtoint(str, 10, &timeout))
> -		deferred_probe_timeout = timeout;
> +		driver_deferred_probe_timeout = timeout;
>  	return 1;
>  }
>  __setup("deferred_probe_timeout=", deferred_probe_timeout_setup);
> @@ -259,10 +261,10 @@ __setup("deferred_probe_timeout=", deferred_probe_timeout_setup);
>   */
>  int driver_deferred_probe_check_state(struct device *dev)
>  {
> -	if (!initcalls_done || deferred_probe_timeout > 0)
> +	if (!initcalls_done || driver_deferred_probe_timeout > 0)
>  		return -EPROBE_DEFER;
>  
> -	if (!deferred_probe_timeout) {
> +	if (!driver_deferred_probe_timeout) {
>  		dev_WARN(dev, "deferred probe timeout, ignoring dependency");
>  		return -ETIMEDOUT;
>  	}
> @@ -276,7 +278,7 @@ static void deferred_probe_timeout_work_func(struct work_struct *work)
>  {
>  	struct device_private *private, *p;
>  
> -	deferred_probe_timeout = 0;
> +	driver_deferred_probe_timeout = 0;
>  	driver_deferred_probe_trigger();
>  	flush_work(&deferred_probe_work);
>  
> @@ -310,9 +312,9 @@ static int deferred_probe_initcall(void)
>  	driver_deferred_probe_trigger();
>  	flush_work(&deferred_probe_work);
>  
> -	if (deferred_probe_timeout > 0) {
> +	if (driver_deferred_probe_timeout > 0) {
>  		schedule_delayed_work(&deferred_probe_timeout_work,
> -			deferred_probe_timeout * HZ);
> +			driver_deferred_probe_timeout * HZ);
>  	}
>  	return 0;
>  }
> diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
> index 5242afabfaba..ee7ba5b5417e 100644
> --- a/include/linux/device/driver.h
> +++ b/include/linux/device/driver.h
> @@ -236,6 +236,7 @@ driver_find_device_by_acpi_dev(struct device_driver *drv, const void *adev)
>  }
>  #endif
>  
> +extern int driver_deferred_probe_timeout;
>  void driver_deferred_probe_add(struct device *dev);
>  int driver_deferred_probe_check_state(struct device *dev);
>  void driver_init(void);
> -- 
> 2.17.1
> 
