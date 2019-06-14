Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E13DD45825
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 11:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfFNJD4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 05:03:56 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44200 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfFNJD4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 05:03:56 -0400
Received: by mail-oi1-f193.google.com with SMTP id e189so1403473oib.11;
        Fri, 14 Jun 2019 02:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1N1H6TNo6f4nIbLuxfEqKMZkV+MXoVbdf9WCWp/BvUg=;
        b=Uzg6+tVPtACjh5cGR11KXy3XRCJbHGlq0f43/RsjKlJtcamdOUewYkuzqhXGQiQsIV
         DSzQhSp2bYQe+Osv45gAzD1iGNpD35actzqUiTSFkLPcRAlKk06+c18gUCriY+E5+2iO
         xk33TbitkUlT7EXcciqLvKUKuEAo1/GDCHg/ICLuSKbhVf9hp/mi/hjbG8FPobVJWxr/
         7zLGw7KZinc0AhL5OWVM1FYXgUgUFDuORq6l5n5odPvNMhorqUjwSxUFlswvSiPS8XRK
         hg4Qs+1ZcgVaeDUo0Sv3yoQdlPuvxHpMqMtMcsK1oC2pRm3ZcQnE+IJOHAv8icqZJ/qq
         D/hQ==
X-Gm-Message-State: APjAAAWFm50HcNEdWuFmSoDHxqhXg7LO3PAqFrWxo1qqVfMlY32xaDfp
        aiXG/wvlLwvkilq/g4FHZoN7QfxilZlGdfYpK1Y=
X-Google-Smtp-Source: APXvYqyoTJUj0cSkq+6B084xlRGG7AVi28WOCDVgrRM9EaNZhPuZ2l/XUFPt/5sXPOlhl/DQQNCQLle5U60X9Cm7iQs=
X-Received: by 2002:aca:4e89:: with SMTP id c131mr1212614oib.57.1560503035384;
 Fri, 14 Jun 2019 02:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190613170011.9647-1-thierry.reding@gmail.com>
In-Reply-To: <20190613170011.9647-1-thierry.reding@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Jun 2019 11:03:43 +0200
Message-ID: <CAJZ5v0i5t_KjSwKdq+iXiJpNQHkNgn6OtwEkJOm0cG5yaHRaDQ@mail.gmail.com>
Subject: Re: [PATCH v2] driver: core: Allow subsystems to continue deferring probe
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 13, 2019 at 7:00 PM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> From: Thierry Reding <treding@nvidia.com>
>
> Some subsystems, such as pinctrl, allow continuing to defer probe
> indefinitely. This is useful for devices that depend on resources
> provided by devices that are only probed after the init stage.
>
> One example of this can be seen on Tegra, where the DPAUX hardware
> contains pinmuxing controls for pins that it shares with an I2C
> controller. The I2C controller is typically used for communication
> with a monitor over HDMI (DDC). However, other instances of the I2C
> controller are used to access system critical components, such as a
> PMIC. The I2C controller driver will therefore usually be a builtin
> driver, whereas the DPAUX driver is part of the display driver that
> is loaded from a module to avoid bloating the kernel image with all
> of the DRM/KMS subsystem.
>
> In this particular case the pins used by this I2C/DDC controller
> become accessible very late in the boot process. However, since the
> controller is only used in conjunction with display, that's not an
> issue.
>
> Unfortunately the driver core currently outputs a warning message
> when a device fails to get the pinctrl before the end of the init
> stage. That can be confusing for the user because it may sound like
> an unwanted error occurred, whereas it's really an expected and
> harmless situation.
>
> In order to eliminate this warning, this patch allows callers of the
> driver_deferred_probe_check_state() helper to specify that they want
> to continue deferring probe, regardless of whether we're past the
> init stage or not. All of the callers of that function are updated
> for the new signature, but only the pinctrl subsystem passes a true
> value in the new persist parameter if appropriate.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - pass persist flag via flags parameter to make the function call easier
>   to understand
>
>  drivers/base/dd.c            | 19 ++++++++++++++-----
>  drivers/base/power/domain.c  |  2 +-
>  drivers/iommu/of_iommu.c     |  2 +-
>  drivers/pinctrl/devicetree.c |  9 +++++----
>  include/linux/device.h       | 18 +++++++++++++++++-
>  5 files changed, 38 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 0df9b4461766..0399a6f6c479 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -238,23 +238,32 @@ __setup("deferred_probe_timeout=", deferred_probe_timeout_setup);
>  /**
>   * driver_deferred_probe_check_state() - Check deferred probe state
>   * @dev: device to check
> + * @flags: Flags used to control the behavior of this function. Drivers can
> + *   set the DRIVER_DEFER_PROBE_PERSIST flag to indicate that they want to

What about calling this flag DRIVER_DEFER_PROBE_CONTINUE ?

Also, I would just say

@flags: Flags used to control the behavior of this function.

here and added the description of the flag below.

> + *   keep trying to probe after built-in drivers have had a chance to probe.
> + *   This is useful for built-in drivers that rely on resources provided by
> + *   modular drivers.
>   *
>   * Returns -ENODEV if init is done and all built-in drivers have had a chance
> - * to probe (i.e. initcalls are done), -ETIMEDOUT if deferred probe debug
> - * timeout has expired, or -EPROBE_DEFER if none of those conditions are met.
> + * to probe (i.e. initcalls are done) and unless the DRIVER_DEFER_PROBE_PERSIST

"unless DRIVER_DEFER_PROBE_CONTINUE is set in @flags"

> + * flag is set, -ETIMEDOUT if deferred probe debug timeout has expired, or
> + * -EPROBE_DEFER if none of those conditions are met.
>   *
>   * Drivers or subsystems can opt-in to calling this function instead of directly
>   * returning -EPROBE_DEFER.

And here:

"In that case, passing DRIVER_DEFER_PROBE_CONTINUE in @flags indicates
that the caller wants to keep trying to probe after built-in drivers
have had a chance to probe, which is useful for built-in drivers that
rely on resources provided by modular drivers."

>   */
> -int driver_deferred_probe_check_state(struct device *dev)
> +int driver_deferred_probe_check_state(struct device *dev, unsigned long flags)
>  {
>         if (initcalls_done) {
>                 if (!deferred_probe_timeout) {
>                         dev_WARN(dev, "deferred probe timeout, ignoring dependency");
>                         return -ETIMEDOUT;
>                 }
> -               dev_warn(dev, "ignoring dependency for device, assuming no driver");
> -               return -ENODEV;
> +
> +               if ((flags & DRIVER_DEFER_PROBE_PERSIST) == 0) {

What about

if (!(flags & DRIVER_DEFER_PROBE_PERSIST)) {

> +                       dev_warn(dev, "ignoring dependency for device, assuming no driver");
> +                       return -ENODEV;
> +               }
>         }
>         return -EPROBE_DEFER;
>  }
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 33c30c1e6a30..6198c6a30fe2 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2423,7 +2423,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>                 mutex_unlock(&gpd_list_lock);
>                 dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
>                         __func__, PTR_ERR(pd));
> -               return driver_deferred_probe_check_state(base_dev);
> +               return driver_deferred_probe_check_state(base_dev, 0);
>         }
>
>         dev_dbg(dev, "adding to PM domain %s\n", pd->name);
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 614a93aa5305..b95d4342e414 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -105,7 +105,7 @@ static int of_iommu_xlate(struct device *dev,
>          * a proper probe-ordering dependency mechanism in future.
>          */
>         if (!ops)
> -               return driver_deferred_probe_check_state(dev);
> +               return driver_deferred_probe_check_state(dev, 0);
>
>         return ops->of_xlate(dev, iommu_spec);
>  }
> diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
> index f7e354f85518..43c0183fa23f 100644
> --- a/drivers/pinctrl/devicetree.c
> +++ b/drivers/pinctrl/devicetree.c
> @@ -111,13 +111,14 @@ static int dt_to_map_one_config(struct pinctrl *p,
>
>                 np_pctldev = of_get_next_parent(np_pctldev);
>                 if (!np_pctldev || of_node_is_root(np_pctldev)) {
> +                       unsigned long flags = 0;
> +
>                         of_node_put(np_pctldev);
> -                       ret = driver_deferred_probe_check_state(p->dev);
>                         /* keep deferring if modules are enabled unless we've timed out */
> -                       if (IS_ENABLED(CONFIG_MODULES) && !allow_default && ret == -ENODEV)
> -                               ret = -EPROBE_DEFER;
> +                       if (IS_ENABLED(CONFIG_MODULES) && !allow_default)
> +                               flags |= DRIVER_DEFER_PROBE_PERSIST;
>
> -                       return ret;
> +                       return driver_deferred_probe_check_state(p->dev, flags);
>                 }
>                 /* If we're creating a hog we can use the passed pctldev */
>                 if (hog_pctldev && (np_pctldev == p->dev->of_node)) {
> diff --git a/include/linux/device.h b/include/linux/device.h
> index e0649f6adf2e..d364656a920c 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -340,7 +340,23 @@ struct device *driver_find_device(struct device_driver *drv,
>                                   int (*match)(struct device *dev, void *data));
>
>  void driver_deferred_probe_add(struct device *dev);
> -int driver_deferred_probe_check_state(struct device *dev);
> +
> +/*
> + * This can be use to continue to defer probe after the init stage and after
> + * all the built-in drivers have had a chance to probe. This is useful if a
> + * built-in driver requires resources provided by a modular driver.
> + *
> + * One such example is the pinctrl subsystem, where for example the DPAUX
> + * hardware on Tegra provides pinmuxing controls for pins shared between DPAUX
> + * and I2C controllers. Only a subset of I2C controllers need the DPAUX
> + * pinmuxing, and some I2C controllers are used during early boot for critical
> + * tasks (such as communicating with the system PMIC). The I2C controllers
> + * that don't share pins with a DPAUX block will want to be driven by a built-
> + * in driver to make sure they are available early on.
> + */
> +#define DRIVER_DEFER_PROBE_PERSIST (1 << 0)

Use BIT(1) ?

> +
> +int driver_deferred_probe_check_state(struct device *dev, unsigned long flags);
>
>  /**
>   * struct subsys_interface - interfaces to device functions
> --
