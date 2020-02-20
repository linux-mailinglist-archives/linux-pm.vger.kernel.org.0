Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96997165C0B
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 11:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgBTKmN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 05:42:13 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41589 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgBTKmN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 05:42:13 -0500
Received: by mail-ot1-f66.google.com with SMTP id r27so3179667otc.8;
        Thu, 20 Feb 2020 02:42:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u3XojZcftnIKJKyJV35y5TFgVfWUEqTDB1cGXtSJ7ss=;
        b=WcqwXPMQjXS5thdEamJrLKhMcNvz52hxP2yHBOx6ofn1Y30uvZIHa2ioXHi6FCMBE8
         rIND5U/E6PjZ42v1aFvjhWhdFtZgi8hwe65QBoUOzQ4U44gP/c/lKGBPohrpcsePHA0Q
         9GtIWBMmf29NeKkgMS679JWgjY4phQ0CusBCDmj2jbuhWMZiAahY/txLmk3M9iViSsFv
         s6XHhg60GAXgcgZjyhohJQ2c3fa9I4vC8WjELITtsCl09PwL8qcVv1ezravRSRXG92Ty
         0Z3rFNol0TiTuLd21Vrea0hDi6sv8VwR09goPjcVdmTblmxkr/hOhhzlUjHkbOKjf+N6
         sJeA==
X-Gm-Message-State: APjAAAV7f7yAHu3UTz76/w6dJeTxCiLCzWkZhAFsQm2agDT07njNntYl
        wyhy0Y8tY0EsWZzY4K9ImPBNpiCxFFe2XUd+0RQ=
X-Google-Smtp-Source: APXvYqx7P9JcEQ3avtUpJ649mm+kpxTjDlbOod8QiB1WbzUtRl9JeH4PIotO/V2tMaE+9diGtnuPOXTmGDW2tCjJxSs=
X-Received: by 2002:a05:6830:1651:: with SMTP id h17mr21787986otr.167.1582195332516;
 Thu, 20 Feb 2020 02:42:12 -0800 (PST)
MIME-Version: 1.0
References: <20200220050440.45878-1-john.stultz@linaro.org> <20200220050440.45878-6-john.stultz@linaro.org>
In-Reply-To: <20200220050440.45878-6-john.stultz@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Feb 2020 11:42:01 +0100
Message-ID: <CAJZ5v0gTtz-Curdo-AY2UR6kXr9YSrnd8y=7JNVE9pxDu=pMtg@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] driver core: Rename deferred_probe_timeout and
 make it global
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
> Since other subsystems (like regulator) have similar arbitrary
> timeouts for how long they try to resolve driver dependencies,
> rename deferred_probe_timeout to driver_deferred_probe_timeout
> and set it as global, so it can be shared.

Fair enough.

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

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

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
>         int timeout;
>
>         if (!kstrtoint(str, 10, &timeout))
> -               deferred_probe_timeout = timeout;
> +               driver_deferred_probe_timeout = timeout;
>         return 1;
>  }
>  __setup("deferred_probe_timeout=", deferred_probe_timeout_setup);
> @@ -259,10 +261,10 @@ __setup("deferred_probe_timeout=", deferred_probe_timeout_setup);
>   */
>  int driver_deferred_probe_check_state(struct device *dev)
>  {
> -       if (!initcalls_done || deferred_probe_timeout > 0)
> +       if (!initcalls_done || driver_deferred_probe_timeout > 0)
>                 return -EPROBE_DEFER;
>
> -       if (!deferred_probe_timeout) {
> +       if (!driver_deferred_probe_timeout) {
>                 dev_WARN(dev, "deferred probe timeout, ignoring dependency");
>                 return -ETIMEDOUT;
>         }
> @@ -276,7 +278,7 @@ static void deferred_probe_timeout_work_func(struct work_struct *work)
>  {
>         struct device_private *private, *p;
>
> -       deferred_probe_timeout = 0;
> +       driver_deferred_probe_timeout = 0;
>         driver_deferred_probe_trigger();
>         flush_work(&deferred_probe_work);
>
> @@ -310,9 +312,9 @@ static int deferred_probe_initcall(void)
>         driver_deferred_probe_trigger();
>         flush_work(&deferred_probe_work);
>
> -       if (deferred_probe_timeout > 0) {
> +       if (driver_deferred_probe_timeout > 0) {
>                 schedule_delayed_work(&deferred_probe_timeout_work,
> -                       deferred_probe_timeout * HZ);
> +                       driver_deferred_probe_timeout * HZ);
>         }
>         return 0;
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
