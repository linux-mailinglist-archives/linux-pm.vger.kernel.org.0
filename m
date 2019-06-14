Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99A8C45848
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 11:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfFNJLD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 05:11:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbfFNJLD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Jun 2019 05:11:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D39B520851;
        Fri, 14 Jun 2019 09:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560503461;
        bh=9DKZ646a4J6ATQ//CaFVDnj6Wq0/JkbKY3qgoAIFXmM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lO3D+aYTQvrsKpC3zOC9Lt5GXQnDhM5/Re9/ndXSd3LMTIT3CavcxmV/lv+1iYMmC
         ITVhafnbM31AcJrFSw8coTLe8F66wch64DQ58gM+B7s0cJ+Uu3q+bDUfrophmZhTb/
         HnrQDcSrRzh4Dl8plsWQqu8XRGKkEwFyjzDda4l4=
Date:   Fri, 14 Jun 2019 11:10:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org,
        linux-gpio@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] driver: core: Allow subsystems to continue deferring
 probe
Message-ID: <20190614091058.GA25912@kroah.com>
References: <20190613170011.9647-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613170011.9647-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 13, 2019 at 07:00:11PM +0200, Thierry Reding wrote:
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
> + *   keep trying to probe after built-in drivers have had a chance to probe.
> + *   This is useful for built-in drivers that rely on resources provided by
> + *   modular drivers.
>   *
>   * Returns -ENODEV if init is done and all built-in drivers have had a chance
> - * to probe (i.e. initcalls are done), -ETIMEDOUT if deferred probe debug
> - * timeout has expired, or -EPROBE_DEFER if none of those conditions are met.
> + * to probe (i.e. initcalls are done) and unless the DRIVER_DEFER_PROBE_PERSIST
> + * flag is set, -ETIMEDOUT if deferred probe debug timeout has expired, or
> + * -EPROBE_DEFER if none of those conditions are met.
>   *
>   * Drivers or subsystems can opt-in to calling this function instead of directly
>   * returning -EPROBE_DEFER.
>   */
> -int driver_deferred_probe_check_state(struct device *dev)
> +int driver_deferred_probe_check_state(struct device *dev, unsigned long flags)
>  {
>  	if (initcalls_done) {
>  		if (!deferred_probe_timeout) {
>  			dev_WARN(dev, "deferred probe timeout, ignoring dependency");
>  			return -ETIMEDOUT;
>  		}
> -		dev_warn(dev, "ignoring dependency for device, assuming no driver");
> -		return -ENODEV;
> +
> +		if ((flags & DRIVER_DEFER_PROBE_PERSIST) == 0) {
> +			dev_warn(dev, "ignoring dependency for device, assuming no driver");
> +			return -ENODEV;
> +		}
>  	}
>  	return -EPROBE_DEFER;
>  }
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 33c30c1e6a30..6198c6a30fe2 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2423,7 +2423,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>  		mutex_unlock(&gpd_list_lock);
>  		dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
>  			__func__, PTR_ERR(pd));
> -		return driver_deferred_probe_check_state(base_dev);
> +		return driver_deferred_probe_check_state(base_dev, 0);

Again, I said no odd flags for functions, how is anyone supposed to know
what "0" means here?

You just swapped a boolean for a bitmapped flag, right?  That did not
make the api any easier to understand at all.

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

In the future, please always use BIT() for stuff like this.

Anyway, this isn't ok, do it correctly please, like I asked for the
first time...

thanks,

greg k-h
