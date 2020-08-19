Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4003024A6D2
	for <lists+linux-pm@lfdr.de>; Wed, 19 Aug 2020 21:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgHSTXc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Aug 2020 15:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgHSTX3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Aug 2020 15:23:29 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DD6C061757;
        Wed, 19 Aug 2020 12:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bGT9fwoymd6Ic9AGH3RntlECSDyDiGNWp2hinEX/z1I=; b=Nz4x6SLPB9YvHOHs9R+RjbXmsw
        jiuyRjtli+sw8kM98fLFS5EIeX+rBOTraKKByIt9LXeg9v/m0CkpMXl8fxql5/7dGIU5s6CaDDlen
        5ZDNxwMqLhM14odRkryCHduXiSpRZg47ztbMSWOLM8kuN1nard283L3+x0rwBxkmcUag=;
Received: from p200300ccff0e87001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0e:8700:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1k8Tfv-0007qx-2w; Wed, 19 Aug 2020 21:23:07 +0200
Date:   Wed, 19 Aug 2020 21:23:05 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-pm@vger.kernel.org, aford@beaconembedded.com,
        hns@goldelico.com, kernel test robot <lkp@intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] thermal: ti-soc-thermal: Enable addition power
 management
Message-ID: <20200819212305.6caa4b7d@aktux>
In-Reply-To: <20200819125925.2119434-1-aford173@gmail.com>
References: <20200819125925.2119434-1-aford173@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 19 Aug 2020 07:59:23 -0500
Adam Ford <aford173@gmail.com> wrote:

> The bandgap sensor can be idled when the processor is too, but it
> isn't currently being done, so the power consumption of OMAP3
> boards can elevated if the bangap sensor is enabled.
> 
> This patch attempts to use some additional power management
> to idle the clock to the bandgap when not needed.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
> V2: Fix issue where variable stating the suspend mode isn't being
>     properly set and cleared.
> 
I get
root@(none):/# cat /sys/class/thermal/thermal_zone0/type 
cpu_thermal
root@(none):/# cat /sys/class/thermal/thermal_zone0/temp 
50000
root@(none):/# cat /sys/class/thermal/thermal_zone1/     
available_policies  mode                subsystem/
integral_cutoff     offset              sustainable_power
k_d                 passive             temp
k_i                 policy              type
k_po                power/              uevent
k_pu                slope               
root@(none):/# cat /sys/class/thermal/thermal_zone1/type 
bq27000-battery
root@(none):/# cat /sys/kernel/debug/pm_debug/count 
usbhost_pwrdm (ON),OFF:3459,RET:635,INA:0,ON:4095,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
sgx_pwrdm (OFF),OFF:1,RET:0,INA:1,ON:2,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
core_pwrdm (ON),OFF:86,RET:7,INA:0,ON:94,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
per_pwrdm (ON),OFF:1518,RET:64,INA:0,ON:1583,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
dss_pwrdm (ON),OFF:3459,RET:635,INA:0,ON:4095,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
cam_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:2,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
neon_pwrdm (ON),OFF:2845,RET:1131,INA:119,ON:4096,RET-LOGIC-OFF:0
mpu_pwrdm (ON),OFF:2845,RET:1130,INA:119,ON:4095,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
iva2_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:2,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
usbhost_clkdm->usbhost_pwrdm (1)
sgx_clkdm->sgx_pwrdm (0)
per_clkdm->per_pwrdm (13)
cam_clkdm->cam_pwrdm (0)
dss_clkdm->dss_pwrdm (1)
d2d_clkdm->core_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
core_l4_clkdm->core_pwrdm (20)
core_l3_clkdm->core_pwrdm (1)
neon_clkdm->neon_pwrdm (0)
root@(none):/# 

So things still turn off.

Tested-by: Andreas Kemnade <andreas@kemnade.info> # GTA04

> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> index ab19ceff6e2a..9404631bea4d 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> @@ -25,10 +25,18 @@
>  #include <linux/of_platform.h>
>  #include <linux/of_irq.h>
>  #include <linux/io.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pm.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  
>  #include "ti-bandgap.h"
>  
>  static int ti_bandgap_force_single_read(struct ti_bandgap *bgp, int id);
> +static int bandgap_omap_cpu_notifier(struct notifier_block *nb,
> +				  unsigned long cmd, void *v);
>  
>  /***   Helper functions to access registers and their bitfields   ***/
>  
> @@ -1008,6 +1016,9 @@ int ti_bandgap_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	bgp->nb.notifier_call = bandgap_omap_cpu_notifier;
> +	cpu_pm_register_notifier(&bgp->nb);
> +
>  	return 0;
>  
>  remove_last_cooling:
> @@ -1041,7 +1052,9 @@ int ti_bandgap_remove(struct platform_device *pdev)
>  	struct ti_bandgap *bgp = platform_get_drvdata(pdev);
>  	int i;
>  
> -	/* First thing is to remove sensor interfaces */
> +	cpu_pm_unregister_notifier(&bgp->nb);
> +
> +	/* Remove sensor interfaces */
>  	for (i = 0; i < bgp->conf->sensor_count; i++) {
>  		if (bgp->conf->sensors[i].unregister_cooling)
>  			bgp->conf->sensors[i].unregister_cooling(bgp, i);
> @@ -1150,9 +1163,43 @@ static int ti_bandgap_suspend(struct device *dev)
>  	if (TI_BANDGAP_HAS(bgp, CLK_CTRL))
>  		clk_disable_unprepare(bgp->fclock);
>  
> +	bgp->is_suspended = true;
> +
>  	return err;
>  }
>  
> +static int bandgap_omap_cpu_notifier(struct notifier_block *nb,
> +				  unsigned long cmd, void *v)
> +{
> +	struct ti_bandgap *bgp;
> +
> +	bgp = container_of(nb, struct ti_bandgap, nb);
> +
> +	spin_lock(&bgp->lock);
> +	switch (cmd) {
> +	case CPU_CLUSTER_PM_ENTER:
> +		if (bgp->is_suspended)
> +			break;
> +		ti_bandgap_save_ctxt(bgp);
> +		ti_bandgap_power(bgp, false);
> +		if (TI_BANDGAP_HAS(bgp, CLK_CTRL))
> +			clk_disable(bgp->fclock);
> +		break;
> +	case CPU_CLUSTER_PM_ENTER_FAILED:
> +	case CPU_CLUSTER_PM_EXIT:
> +		if (bgp->is_suspended)
> +			break;
> +		if (TI_BANDGAP_HAS(bgp, CLK_CTRL))
> +			clk_enable(bgp->fclock);
> +		ti_bandgap_power(bgp, true);
> +		ti_bandgap_restore_ctxt(bgp);
> +		break;
> +	}
> +	spin_unlock(&bgp->lock);
> +
> +	return NOTIFY_OK;
> +}
> +
>  static int ti_bandgap_resume(struct device *dev)
>  {
>  	struct ti_bandgap *bgp = dev_get_drvdata(dev);
> @@ -1161,6 +1208,7 @@ static int ti_bandgap_resume(struct device *dev)
>  		clk_prepare_enable(bgp->fclock);
>  
>  	ti_bandgap_power(bgp, true);
> +	bgp->is_suspended = false;
>  
>  	return ti_bandgap_restore_ctxt(bgp);
>  }
> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.h b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
> index fce4657e9486..ed0ea4b17b25 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.h
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
> @@ -12,6 +12,10 @@
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
>  #include <linux/err.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pm.h>
>  
>  struct gpio_desc;
>  
> @@ -203,6 +207,8 @@ struct ti_bandgap {
>  	int				irq;
>  	struct gpio_desc		*tshut_gpiod;
>  	u32				clk_rate;
> +	struct notifier_block		nb;
> +	unsigned int is_suspended:1;
>  };
>  
>  /**

