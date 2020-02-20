Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8DA1661AE
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 17:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgBTQAn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 11:00:43 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39863 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbgBTQAn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 11:00:43 -0500
Received: by mail-pg1-f194.google.com with SMTP id j15so2145289pgm.6
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2020 08:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wbab2MAyBGVFVIVKjVgIjH6RybCXv9GVcrcCbqRwpPY=;
        b=O4dI7IVoeleTa/KTNc+v5co+jsDKZweNB2IF6C3xqrIzT0bxEB0NBuTB+MCDauj3Tz
         EWQGjCZe10yjw2XC/dNUcCIzTxrtqZyn2plgoLERrMscLyewavaOoOb6hRVx/5n3a2cT
         ehtRlLd0yRn5/udp5PrDlr1wWmYHfDa+kwFCU7LsqCZIBrW6UYvnVOdBDXL6spfk5SZm
         fw03faaIcHXM6DmDRecW4lOuwAB+NlnE1wXF5KuqVTFSvDi5VfS766kzxhfb9XLPq3bW
         3U7sFKREGC29PT99UYrxu/0SSp3YzvL4A2zqvKYcOOkg9sJ5de0Mp9/l+mBkZqxqk0AF
         zdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wbab2MAyBGVFVIVKjVgIjH6RybCXv9GVcrcCbqRwpPY=;
        b=DLCRsk5BwijiBSPpsnL/hZj7VYNrs0pbB2F66CLqwAk75NPRo0oT15g6dHKqtnFb1I
         gPDPCOsq1p+7N0Nyv6O39sB4myhE6tnaH8zarQ+56DeenBkh7uMwsxZ6EnBPOfv08MIJ
         6O73Kg7tygpt0WhI5iNw/jLmEZaMX0EY1A6BEooca9dnD1aVeZJLpHx8J505ZePTLEHj
         jOtfTqInAv5e/cNHx4147mNW2c8tiwN8sCteckCDuWMFtFT7dQuZIeIYX1VnwNWYe468
         VRsKtg+VP56bxGqvc7WiAy2GydbFr2nPzFsWd7letInAfgdcnj4mKgKPxu5kFxp3z11x
         l60w==
X-Gm-Message-State: APjAAAUwT1I3tuuynco6cD/P+PhQpEgFLcSZWjsopS/t18qwAkSN9sfh
        mwWX0+uMUBlJ3pKFpimeXTqYKQ==
X-Google-Smtp-Source: APXvYqyniQeB0JwM3bF6YAJywLFqtTnmJzv22eYSwTjFbne1ZebTYK1xGgrm2MzYxjPWpf3OBOZIBQ==
X-Received: by 2002:a62:1456:: with SMTP id 83mr33251094pfu.186.1582214442159;
        Thu, 20 Feb 2020 08:00:42 -0800 (PST)
Received: from ripper (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 199sm41506pfu.71.2020.02.20.08.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 08:00:41 -0800 (PST)
Date:   Thu, 20 Feb 2020 07:59:46 -0800
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
Subject: Re: [PATCH v4 4/6] driver core: Remove
 driver_deferred_probe_check_state_continue()
Message-ID: <20200220155946.GF955802@ripper>
References: <20200220050440.45878-1-john.stultz@linaro.org>
 <20200220050440.45878-5-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220050440.45878-5-john.stultz@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed 19 Feb 21:04 PST 2020, John Stultz wrote:

> Now that driver_deferred_probe_check_state() works better, and
> we've converted the only user of
> driver_deferred_probe_check_state_continue() we can simply
> remove it and simplify some of the logic.
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
> Change-Id: Id5cd5e9264cfb0fbd70a702715174cc4b10006f4

Change-Id...

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/base/dd.c             | 49 +++++------------------------------
>  include/linux/device/driver.h |  1 -
>  2 files changed, 6 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index fa138f24e2d3..408e4da081da 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -244,19 +244,6 @@ static int __init deferred_probe_timeout_setup(char *str)
>  }
>  __setup("deferred_probe_timeout=", deferred_probe_timeout_setup);
>  
> -static int __driver_deferred_probe_check_state(struct device *dev)
> -{
> -	if (!initcalls_done || deferred_probe_timeout > 0)
> -		return -EPROBE_DEFER;
> -
> -	if (!deferred_probe_timeout) {
> -		dev_WARN(dev, "deferred probe timeout, ignoring dependency");
> -		return -ETIMEDOUT;
> -	}
> -
> -	return 0;
> -}
> -
>  /**
>   * driver_deferred_probe_check_state() - Check deferred probe state
>   * @dev: device to check
> @@ -272,43 +259,19 @@ static int __driver_deferred_probe_check_state(struct device *dev)
>   */
>  int driver_deferred_probe_check_state(struct device *dev)
>  {
> -	int ret;
> +	if (!initcalls_done || deferred_probe_timeout > 0)
> +		return -EPROBE_DEFER;
>  
> -	ret = __driver_deferred_probe_check_state(dev);
> -	if (ret < 0)
> -		return ret;
> +	if (!deferred_probe_timeout) {
> +		dev_WARN(dev, "deferred probe timeout, ignoring dependency");
> +		return -ETIMEDOUT;
> +	}
>  
>  	dev_warn(dev, "ignoring dependency for device, assuming no driver");
>  
>  	return -ENODEV;
>  }
>  
> -/**
> - * driver_deferred_probe_check_state_continue() - check deferred probe state
> - * @dev: device to check
> - *
> - * Returns -ETIMEDOUT if deferred probe debug timeout has expired, or
> - * -EPROBE_DEFER otherwise.
> - *
> - * Drivers or subsystems can opt-in to calling this function instead of
> - * directly returning -EPROBE_DEFER.
> - *
> - * This is similar to driver_deferred_probe_check_state(), but it allows the
> - * subsystem to keep deferring probe after built-in drivers have had a chance
> - * to probe. One scenario where that is useful is if built-in drivers rely on
> - * resources that are provided by modular drivers.
> - */
> -int driver_deferred_probe_check_state_continue(struct device *dev)
> -{
> -	int ret;
> -
> -	ret = __driver_deferred_probe_check_state(dev);
> -	if (ret < 0)
> -		return ret;
> -
> -	return -EPROBE_DEFER;
> -}
> -
>  static void deferred_probe_timeout_work_func(struct work_struct *work)
>  {
>  	struct device_private *private, *p;
> diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
> index 1188260f9a02..5242afabfaba 100644
> --- a/include/linux/device/driver.h
> +++ b/include/linux/device/driver.h
> @@ -238,7 +238,6 @@ driver_find_device_by_acpi_dev(struct device_driver *drv, const void *adev)
>  
>  void driver_deferred_probe_add(struct device *dev);
>  int driver_deferred_probe_check_state(struct device *dev);
> -int driver_deferred_probe_check_state_continue(struct device *dev);
>  void driver_init(void);
>  
>  /**
> -- 
> 2.17.1
> 
