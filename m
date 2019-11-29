Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6452210D485
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2019 12:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfK2LDA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Nov 2019 06:03:00 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:35767 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfK2LDA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Nov 2019 06:03:00 -0500
Received: from localhost (lfbn-1-1480-129.w90-65.abo.wanadoo.fr [90.65.102.129])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 4286224000D;
        Fri, 29 Nov 2019 11:02:57 +0000 (UTC)
Date:   Fri, 29 Nov 2019 12:02:53 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu.Beznea@microchip.com
Cc:     kamel.bouhara@bootlin.com, sre@kernel.org,
        Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH] power: reset: at91-reset: add sysfs interface to the
 power on reason
Message-ID: <20191129110253.GX299836@piout.net>
References: <20191017124058.19300-1-kamel.bouhara@bootlin.com>
 <034c9d01-633a-eeaa-f61f-d185be7227f2@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <034c9d01-633a-eeaa-f61f-d185be7227f2@microchip.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29/11/2019 10:57:45+0000, Claudiu.Beznea@microchip.com wrote:
> Hi Kamel,
> 
> On 17.10.2019 15:40, Kamel Bouhara wrote:
> > This patch export the power on reason through the sysfs interface and
> > introduce some generic reset sources.
> > Update the ABI documentation to list current power on sources.
> > 
> > Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > ---
> >  .../sysfs-devices-platform-power-on-reason    | 14 ++++++
> >  drivers/power/reset/at91-reset.c              | 44 +++++++++++++------
> >  include/linux/power/power_on_reason.h         | 19 ++++++++
> >  3 files changed, 64 insertions(+), 13 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-power-on-reason
> >  create mode 100644 include/linux/power/power_on_reason.h
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-devices-platform-power-on-reason b/Documentation/ABI/testing/sysfs-devices-platform-power-on-reason
> > new file mode 100644
> > index 000000000000..83daeb9b1aa2
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-devices-platform-power-on-reason
> > @@ -0,0 +1,14 @@
> > +What:		/sys/devices/platform/.../power_on_reason
> > +
> > +Date:		October 2019
> > +KernelVersion:	5.4
> > +Contact:	Kamel Bouhara <kamel.bouhara@bootlin.com>
> > +Description:	This file shows system power on reason.
> > +		The possible sources are:
> > +		General System Power-ON, RTC wakeup, Watchdog timeout,
> > +		Software Reset, User pressed reset button,
> > +		CPU Clock failure, 32.768kHz Oscillator Failure,
> > +		Low power mode exit, Unknown.
> > +
> > +		The file is read only.
> > +
> > diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
> > index 44ca983a49a1..3cb2df40af37 100644
> > --- a/drivers/power/reset/at91-reset.c
> > +++ b/drivers/power/reset/at91-reset.c
> > @@ -17,7 +17,7 @@
> >  #include <linux/of_address.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/reboot.h>
> > -
> > +#include <linux/power/power_on_reason.h>
> >  #include <soc/at91/at91sam9_ddrsdr.h>
> >  #include <soc/at91/at91sam9_sdramc.h>
> > 
> > @@ -146,42 +146,42 @@ static int samx7_restart(struct notifier_block *this, unsigned long mode,
> >  	return NOTIFY_DONE;
> >  }
> > 
> > -static void __init at91_reset_status(struct platform_device *pdev)
> > +static const char *at91_reset_reason(struct platform_device *pdev)
> >  {
> >  	const char *reason;
> >  	u32 reg = readl(at91_rstc_base + AT91_RSTC_SR);
> > 
> >  	switch ((reg & AT91_RSTC_RSTTYP) >> 8) {
> >  	case RESET_TYPE_GENERAL:
> > -		reason = "general reset";
> > +		reason = POWER_ON_REASON_GENERAL;
> >  		break;
> >  	case RESET_TYPE_WAKEUP:
> > -		reason = "wakeup";
> > +		reason = POWER_ON_REASON_RTC;
> >  		break;
> >  	case RESET_TYPE_WATCHDOG:
> > -		reason = "watchdog reset";
> > +		reason = POWER_ON_REASON_WATCHDOG;
> >  		break;
> >  	case RESET_TYPE_SOFTWARE:
> > -		reason = "software reset";
> > +		reason = POWER_ON_REASON_SOFTWARE;
> >  		break;
> >  	case RESET_TYPE_USER:
> > -		reason = "user reset";
> > +		reason = POWER_ON_REASON_USER;
> >  		break;
> >  	case RESET_TYPE_CPU_FAIL:
> > -		reason = "CPU clock failure detection";
> > +		reason = POWER_ON_REASON_CPU_FAIL;
> >  		break;
> >  	case RESET_TYPE_XTAL_FAIL:
> > -		reason = "32.768 kHz crystal failure detection";
> > +		reason = POWER_ON_REASON_XTAL_FAIL;
> >  		break;
> >  	case RESET_TYPE_ULP2:
> > -		reason = "ULP2 reset";
> > +		reason = POWER_ON_REASON_LOW_POWER;
> >  		break;
> >  	default:
> > -		reason = "unknown reset";
> > +		reason = POWER_ON_REASON_UNKNOWN;
> >  		break;
> >  	}
> > 
> > -	dev_info(&pdev->dev, "Starting after %s\n", reason);
> > +	return reason;
> >  }
> > 
> >  static const struct of_device_id at91_ramc_of_match[] = {
> > @@ -204,6 +204,17 @@ static struct notifier_block at91_restart_nb = {
> >  	.priority = 192,
> >  };
> > 
> > +static ssize_t power_on_reason_show(struct device *dev,
> > +				    struct device_attribute *attr,
> > +				    char *buf)
> > +{
> > +	struct platform_device *pdev = to_platform_device(dev);
> > +
> > +	return sprintf(buf, "%s\n", at91_reset_reason(pdev));
> > +}
> > +
> > +static DEVICE_ATTR_RO(power_on_reason);
> > +
> >  static int __init at91_reset_probe(struct platform_device *pdev)
> >  {
> >  	const struct of_device_id *match;
> > @@ -248,7 +259,14 @@ static int __init at91_reset_probe(struct platform_device *pdev)
> >  		return ret;
> >  	}
> > 
> > -	at91_reset_status(pdev);
> > +	ret = device_create_file(&pdev->dev, &dev_attr_power_on_reason);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Could not create sysfs entry\n");
> > +		return ret;
> > +	}
> > +
> > +	dev_info(&pdev->dev, "Starting after %s reset\n",
> > +		 at91_reset_reason(pdev));
> > 
> >  	return 0;
> >  }
> > diff --git a/include/linux/power/power_on_reason.h b/include/linux/power/power_on_reason.h
> > new file mode 100644
> > index 000000000000..9978cc757427
> > --- /dev/null
> > +++ b/include/linux/power/power_on_reason.h
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Author: Kamel Bouhra <kamel.bouhara@bootlin.com>
> > + */
> > +
> > +#ifndef POWER_ON_REASON_H
> > +#define POWER_ON_REASON_H
> > +
> > +#define POWER_ON_REASON_GENERAL "General"
> > +#define POWER_ON_REASON_RTC "RTC wakeup"
> > +#define POWER_ON_REASON_WATCHDOG "Watchdog timeout"
> > +#define POWER_ON_REASON_SOFTWARE "Software"
> > +#define POWER_ON_REASON_USER "User"
> > +#define POWER_ON_REASON_CPU_FAIL "CPU Clock Failure"
> > +#define POWER_ON_REASON_XTAL_FAIL "32.768k Crystal oscillator Failure"
> > +#define POWER_ON_REASON_LOW_POWER "Low power exit"
> > +#define POWER_ON_REASON_UNKNOWN "Unknown"
> > +
> > +#endif /* POWER_ON_REASON_H */
> 
> Is this new header necessary?
> 

Yes because we want other drivers to be able to reuse them as-is so the
ABI is stable.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
