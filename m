Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A23DE165BB3
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 11:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgBTKim (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 05:38:42 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37253 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgBTKim (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 05:38:42 -0500
Received: by mail-ot1-f65.google.com with SMTP id b3so1994291otp.4;
        Thu, 20 Feb 2020 02:38:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wjs+bqcPT9MeOZqbAU1vmO7aFhPK7e0+qLDFpmywzq4=;
        b=m3GZoBhDtyB7gY7DzYlaemYZnZRVUVj0XYQx/6+cnAIB5qgKggQubd1XNqXLTiDUh9
         15ClbmHo+gh4q+trF+GaWbGOvzMSZMBsIHJFVMjlDO4uYGOVLymXs2nrusEF3O4abr+y
         rLdij/pSdqde6yOZShCSWLlmu/fyRI5VERGFB4B94zDub4ZobTnoXw0+Is+12Tz5uxDw
         3Zt58XeAnNhr2ATZzcegX4F3IX2/p+iS1YxE8N9pw9+Vn1yu1Lkhjf//CwNscEzMQ9PJ
         LZNG3NOzR4kPEeFU1i6xHtDPoNgunIMnv0ghHzFHEA8CBEitQylJauEKtf0pAocRa+7x
         aaEA==
X-Gm-Message-State: APjAAAVCYR+X8X6gNV7g9cXebS068lqPXdDqlTGFBuwZr9enKGnsFxq5
        D+cxeYs1HBhJbgplMqUnoI4Cr2b8cNVnkoHzLwQ=
X-Google-Smtp-Source: APXvYqzFBZk9/DZvDaNVAs2YXI+6x9S5FHh4UEDtVxtEFLg6U8vLB5gaWR5bRdb2UxhDyTJbbFbm3WvaqaLD9En2BgY=
X-Received: by 2002:a9d:67d7:: with SMTP id c23mr23055702otn.262.1582195121545;
 Thu, 20 Feb 2020 02:38:41 -0800 (PST)
MIME-Version: 1.0
References: <20200220050440.45878-1-john.stultz@linaro.org> <20200220050440.45878-5-john.stultz@linaro.org>
In-Reply-To: <20200220050440.45878-5-john.stultz@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Feb 2020 11:38:30 +0100
Message-ID: <CAJZ5v0i8KGMwWCuJJPNyXXP0LvM_S61=m0UoYS97tEi_PNAUCw@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] driver core: Remove driver_deferred_probe_check_state_continue()
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 20, 2020 at 6:05 AM John Stultz <john.stultz@linaro.org> wrote:
>
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

Nice!

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

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
> -       if (!initcalls_done || deferred_probe_timeout > 0)
> -               return -EPROBE_DEFER;
> -
> -       if (!deferred_probe_timeout) {
> -               dev_WARN(dev, "deferred probe timeout, ignoring dependency");
> -               return -ETIMEDOUT;
> -       }
> -
> -       return 0;
> -}
> -
>  /**
>   * driver_deferred_probe_check_state() - Check deferred probe state
>   * @dev: device to check
> @@ -272,43 +259,19 @@ static int __driver_deferred_probe_check_state(struct device *dev)
>   */
>  int driver_deferred_probe_check_state(struct device *dev)
>  {
> -       int ret;
> +       if (!initcalls_done || deferred_probe_timeout > 0)
> +               return -EPROBE_DEFER;
>
> -       ret = __driver_deferred_probe_check_state(dev);
> -       if (ret < 0)
> -               return ret;
> +       if (!deferred_probe_timeout) {
> +               dev_WARN(dev, "deferred probe timeout, ignoring dependency");
> +               return -ETIMEDOUT;
> +       }
>
>         dev_warn(dev, "ignoring dependency for device, assuming no driver");
>
>         return -ENODEV;
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
> -       int ret;
> -
> -       ret = __driver_deferred_probe_check_state(dev);
> -       if (ret < 0)
> -               return ret;
> -
> -       return -EPROBE_DEFER;
> -}
> -
>  static void deferred_probe_timeout_work_func(struct work_struct *work)
>  {
>         struct device_private *private, *p;
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
