Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 804A03034B
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2019 22:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfE3UcF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 May 2019 16:32:05 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32994 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfE3UcF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 May 2019 16:32:05 -0400
Received: by mail-pl1-f196.google.com with SMTP id g21so3033722plq.0;
        Thu, 30 May 2019 13:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kguosYeFwg0UQb+y10YIE7iIZLNffVxVTFmnvc3bap8=;
        b=fGvVeOZSE0ET9SO/bO/OPxJ5yvsV1UHHYcsckRtI1SVNBgTAGyjAWyvXAx66N4W2jl
         GrNqwi7ZhmDlL5FiBdznmWlMBD/kV1ceCIfMqVh3JMvA8pCunpPDxWUPiRufwF4Lyp5X
         rKcsx3AkQ6Ml4GWgfhH6laJzBAo8FmYSWYLBjRbCAyf5KXiwfNr5PyuraW4/6NK8Gu5v
         TvPRGQq7AAt2Hy/ih8bsKf1iLqaj8rpGhsPHcd/QX8kutMeTuP7whyUXKsLy6CrZTZNh
         IGHf5ZCTkj3yzBNzkYO/Xz39hk4WNw/aulmxJehwmKsBIEVYejsm8oi6PpZ9+EUVgs1J
         Fy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kguosYeFwg0UQb+y10YIE7iIZLNffVxVTFmnvc3bap8=;
        b=lYCNUL4vqwgLqMr4lXi+rV/38BVwWpfwsHalhakCIc4JRIssCYphfRIpp80X0mcLsE
         dhEHg1RAmVncc4fWchahrGoX2qb1Qov/t/JnWE78UPDl19uGvLDFX+DSQoxFz4RStN0f
         vE+c7Zb3oMKdRML5uFnOQG0NFNjQKb/f17YNXS7r22t7zgmOmrl8uJhD/fmH0X56MiFm
         +ozLtWZtdwpivmF3GbQG531WTPeG6VVRdskF2WpDBqNWgA0XME7tAQLZMofSBqb+cxpT
         LUfQhCLlbjiRFwzj62A8pOIWcH16MyZxdocEFVxZPC+L+Qq65xC41Xnzd8fUZEvNU91U
         Iszg==
X-Gm-Message-State: APjAAAW8nojjnwuhcT2CZ4sjqdxhcDFLWOcYfxU9VXr7lF2fKntzgl06
        Tjj8QKYUX8wpj5d0p9L7Csc=
X-Google-Smtp-Source: APXvYqz3Cxdgk8TW1rHHu3MlWR0sJbYNWQWDNc8q7gYGplLRcrTWWHS3rocG1QiSmnMTBKOErj1JOg==
X-Received: by 2002:a17:902:4e:: with SMTP id 72mr5561546pla.80.1559248324265;
        Thu, 30 May 2019 13:32:04 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t4sm3256666pjq.19.2019.05.30.13.32.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 13:32:03 -0700 (PDT)
Date:   Thu, 30 May 2019 13:32:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] power: supply: Add HWMON compatibility layer
Message-ID: <20190530203202.GD12310@roeck-us.net>
References: <20190529071112.16849-1-andrew.smirnov@gmail.com>
 <20190529071112.16849-2-andrew.smirnov@gmail.com>
 <22dcfea4-00a2-3de8-8313-35d8d1350493@roeck-us.net>
 <CAHQ1cqGpcRbqzDk3z0nu0OUGsPbXXmc-fzZRzZjd-_dnqCwodQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQ1cqGpcRbqzDk3z0nu0OUGsPbXXmc-fzZRzZjd-_dnqCwodQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 30, 2019 at 01:08:35PM -0700, Andrey Smirnov wrote:
> On Wed, May 29, 2019 at 5:40 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On 5/29/19 12:11 AM, Andrey Smirnov wrote:
> > > Add code implementing HWMON adapter/compatibility layer to allow
> > > expositing various sensors present on power supply devices via HWMON
> > > subsystem. This is done in order to allow userspace to use single
> > > ABI/library(libsensors) to access/manipulate all of the sensors of the
> > > system.
> > >
> > > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > > Cc: Chris Healy <cphealy@gmail.com>
> > > Cc: Lucas Stach <l.stach@pengutronix.de>
> > > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > > Cc: Guenter Roeck <linux@roeck-us.net>
> > > Cc: Sebastian Reichel <sre@kernel.org>
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: linux-pm@vger.kernel.org
> > > ---
> > >   drivers/power/supply/Kconfig              |  14 +
> > >   drivers/power/supply/Makefile             |   1 +
> > >   drivers/power/supply/power_supply_hwmon.c | 329 ++++++++++++++++++++++
> > >   include/linux/power_supply.h              |  11 +
> > >   4 files changed, 355 insertions(+)
> > >   create mode 100644 drivers/power/supply/power_supply_hwmon.c
> > >
> > > diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> > > index 26dacdab03cc..1f2252cb95fd 100644
> > > --- a/drivers/power/supply/Kconfig
> > > +++ b/drivers/power/supply/Kconfig
> > > @@ -14,6 +14,20 @@ config POWER_SUPPLY_DEBUG
> > >         Say Y here to enable debugging messages for power supply class
> > >         and drivers.
> > >
> > > +config POWER_SUPPLY_HWMON
> > > +     bool
> > > +     prompt "Expose power supply sensors as hwmon device"
> > > +     depends on HWMON=y || HWMON=POWER_SUPPLY
> > > +     default y
> >
> > Not sure if you want to enable that by default.
> >
> 
> That's what THERMAL_HWMON does which seems pretty analogous to this code.
> 
maintainer call to make.

> > > +     help
> > > +       This options enables API that allows sensors found on a
> > > +       power supply device (current, voltage, temperature) to be
> > > +       exposed as a hwmon device.
> > > +
> > > +       Say 'Y' here if you want power supplies to
> > > +       have hwmon sysfs interface too.
> > > +
> > > +
> > >   config PDA_POWER
> > >       tristate "Generic PDA/phone power driver"
> > >       depends on !S390
> > > diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> > > index f208273f9686..c47e88ba16b9 100644
> > > --- a/drivers/power/supply/Makefile
> > > +++ b/drivers/power/supply/Makefile
> > > @@ -6,6 +6,7 @@ power_supply-$(CONFIG_SYSFS)          += power_supply_sysfs.o
> > >   power_supply-$(CONFIG_LEDS_TRIGGERS)        += power_supply_leds.o
> > >
> > >   obj-$(CONFIG_POWER_SUPPLY)  += power_supply.o
> > > +obj-$(CONFIG_POWER_SUPPLY_HWMON) += power_supply_hwmon.o
> > >   obj-$(CONFIG_GENERIC_ADC_BATTERY)   += generic-adc-battery.o
> > >
> > >   obj-$(CONFIG_PDA_POWER)             += pda_power.o
> > > diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
> > > new file mode 100644
> > > index 000000000000..dca7f79fae6e
> > > --- /dev/null
> > > +++ b/drivers/power/supply/power_supply_hwmon.c
> > > @@ -0,0 +1,329 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + *  power_supply_hwmon.c - power supply hwmon support.
> > > + */
> > > +
> > > +#include <linux/hwmon.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/err.h>
> > > +#include <linux/power_supply.h>
> > > +
> > Alphabetic order ?
> >
> 
> Sure, will do in v2.
> 
> > > +struct power_supply_hwmon {
> > > +     struct power_supply *psy;
> > > +     unsigned long *props;
> > > +};
> > > +
> > > +static int power_supply_hwmon_in_to_property(u32 attr)
> > > +{
> > > +     switch (attr) {
> > > +     case hwmon_in_average:
> > > +             return POWER_SUPPLY_PROP_VOLTAGE_AVG;
> > > +     case hwmon_in_min:
> > > +             return POWER_SUPPLY_PROP_VOLTAGE_MIN;
> > > +     case hwmon_in_max:
> > > +             return POWER_SUPPLY_PROP_VOLTAGE_MAX;
> > > +     case hwmon_in_input:
> > > +             return POWER_SUPPLY_PROP_VOLTAGE_NOW;
> > > +     default:
> > > +             break;
> > > +     }
> > > +
> > > +     return -EINVAL;
> > > +}
> > > +
> > > +static int power_supply_hwmon_curr_to_property(u32 attr)
> > > +{
> > > +     switch (attr) {
> > > +     case hwmon_curr_average:
> > > +             return POWER_SUPPLY_PROP_CURRENT_AVG;
> > > +     case hwmon_curr_max:
> > > +             return POWER_SUPPLY_PROP_CURRENT_MAX;
> > > +     case hwmon_curr_input:
> > > +             return POWER_SUPPLY_PROP_CURRENT_NOW;
> > > +     default:
> > > +             break;
> > > +     }
> > > +
> > > +     return -EINVAL;
> > > +}
> > > +
> > > +static int power_supply_hwmon_temp_to_property(u32 attr, int channel)
> > > +{
> > > +     if (channel) {
> > > +             switch (attr) {
> > > +             case hwmon_temp_input:
> > > +                     return POWER_SUPPLY_PROP_TEMP_AMBIENT;
> > > +             case hwmon_temp_min_alarm:
> > > +                     return POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN;
> > > +             case hwmon_temp_max_alarm:
> > > +                     return POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX;
> > > +             default:
> > > +                     break;
> > > +             }
> > > +     } else {
> > > +             switch (attr) {
> > > +             case hwmon_temp_input:
> > > +                     return POWER_SUPPLY_PROP_TEMP;
> > > +             case hwmon_temp_max:
> > > +                     return POWER_SUPPLY_PROP_TEMP_MAX;
> > > +             case hwmon_temp_min:
> > > +                     return POWER_SUPPLY_PROP_TEMP_MIN;
> > > +             case hwmon_temp_min_alarm:
> > > +                     return POWER_SUPPLY_PROP_TEMP_ALERT_MIN;
> > > +             case hwmon_temp_max_alarm:
> > > +                     return POWER_SUPPLY_PROP_TEMP_ALERT_MAX;
> > > +             default:
> > > +                     break;
> > > +             }
> > > +     }
> > > +
> > > +     return -EINVAL;
> > > +}
> > > +
> > > +static int
> > > +power_supply_hwmon_to_property(enum hwmon_sensor_types type,
> > > +                            u32 attr, int channel)
> > > +{
> > > +     switch (type) {
> > > +     case hwmon_in:
> > > +             return power_supply_hwmon_in_to_property(attr);
> > > +     case hwmon_curr:
> > > +             return power_supply_hwmon_curr_to_property(attr);
> > > +     case hwmon_temp:
> > > +             return power_supply_hwmon_temp_to_property(attr, channel);
> > > +     default:
> > > +             break;
> > > +     }
> > > +
> > > +     return -EINVAL;
> > > +}
> > > +
> > > +static bool power_supply_hwmon_is_a_label(enum hwmon_sensor_types type,
> > > +                                       u32 attr)
> > > +{
> > > +     return type == hwmon_temp && attr == hwmon_temp_label;
> > > +}
> > > +
> > > +static umode_t power_supply_hwmon_is_visible(const void *data,
> > > +                                          enum hwmon_sensor_types type,
> > > +                                          u32 attr, int channel)
> > > +{
> > > +     const struct power_supply_hwmon *psyhw = data;
> > > +     int prop, is_writable;
> > > +
> > > +     if (power_supply_hwmon_is_a_label(type, attr))
> > > +             return 0444;
> > > +
> > > +     prop = power_supply_hwmon_to_property(type, attr, channel);
> > > +     if (prop < 0 || !test_bit(prop, psyhw->props))
> > > +             return 0;
> > > +
> > > +     is_writable = power_supply_property_is_writeable(psyhw->psy, prop);
> > > +
> > > +     return (is_writable <= 0) ? 0444 : 0644;
> >
> > I a a bit concerned that this can result in writeable voltage/current/temp
> > values (not just for limits), which would be very undesirable. It might be
> > better to add another check to ensure that this does not happen.
> >
> 
> OK, will do.
> 
> > > +}
> > > +
> > > +static int power_supply_hwmon_read_string(struct device *dev,
> > > +                                       enum hwmon_sensor_types type,
> > > +                                       u32 attr, int channel,
> > > +                                       const char **str)
> > > +{
> > > +     *str = channel ? "temp" : "temp ambient";
> > > +     return 0;
> > > +}
> > > +
> > > +static int
> > > +power_supply_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> > > +                     u32 attr, int channel, long *val)
> > > +{
> > > +     struct power_supply_hwmon *psyhw = dev_get_drvdata(dev);
> > > +     struct power_supply *psy = psyhw->psy;
> > > +     union power_supply_propval pspval;
> > > +     int ret, prop;
> > > +
> > > +     prop = power_supply_hwmon_to_property(type, attr, channel);
> > > +     if (prop < 0)
> > > +             return prop;
> > > +
> > > +     ret  = power_supply_get_property(psy, prop, &pspval);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     switch (type) {
> > > +     /*
> > > +      * Both voltage and current is reported in units of
> > > +      * microvolts/microamps, so we need to adjust it to
> > > +      * milliamps(volts)
> > > +      */
> > > +     case hwmon_curr:
> > > +     case hwmon_in:
> > > +             pspval.intval /= 1000;
> >
> > DIV_ROUND_CLOSEST() ?
> >
> 
> Yeah, good idea, will do.
> 
> > > +             break;
> > > +     /*
> > > +      * Temp needs to be converted from 1/10 C to milli-C
> > > +      */
> > > +     case hwmon_temp:
> > > +             pspval.intval *= 100;
> >
> > intval is an int, so theoretically this could result in an overflow.
> >
> 
> Sure, will change the code to use check_mul_overflow()
> 
> >
> > > +             break;
> > > +     default:
> >
> > Wouldn't this be an error ?
> >
> 
> Shouldn't happen, but adding a error path here won't hurt.
> 
> > Personally I prefer direct value assignments. I don't see value in
> > updating pspval.intval first only to assign it to *val later.
> >
> 
> This won't work once I convert the code to use check_mul_overflow()
> since it expects its argument to have the same type and "*val" is
> long.
> 
> > > +             break;
> > > +     }
> > > +
> > > +     *val = pspval.intval;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int
> > > +power_supply_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
> > > +                      u32 attr, int channel, long val)
> > > +{
> > > +     struct power_supply_hwmon *psyhw = dev_get_drvdata(dev);
> > > +     struct power_supply *psy = psyhw->psy;
> > > +     union power_supply_propval pspval;
> > > +     int prop;
> > > +
> > > +     prop = power_supply_hwmon_to_property(type, attr, channel);
> > > +     if (prop < 0)
> > > +             return prop;
> > > +
> > > +     pspval.intval = val;
> > > +
> > > +     switch (type) {
> > > +     /*
> > > +      * Both voltage and current is reported in units of
> > > +      * microvolts/microamps, so we need to adjust it to
> > > +      * milliamps(volts)
> > > +      */
> > > +     case hwmon_curr:
> > > +     case hwmon_in:
> > > +             pspval.intval *= 1000;
> >
> > Range checks ? This can result in an overflow.
> >
> 
> Will add check_mul_overflow() here as well.
> 
> > > +             break;
> > > +     /*
> > > +      * Temp needs to be converted from 1/10 C to milli-C
> > > +      */
> > > +     case hwmon_temp:
> > > +             pspval.intval /= 100;
> > > +             break;
> > > +     default:
> > > +             break;
> >
> > Wouldn't this be an error ?
> >
> 
> Will add an error path in v2.
> 
> > > +     }
> > > +
> > > +     return power_supply_set_property(psy, prop, &pspval);
> > > +}
> > > +
> > > +static const struct hwmon_ops power_supply_hwmon_ops = {
> > > +     .is_visible     = power_supply_hwmon_is_visible,
> > > +     .read           = power_supply_hwmon_read,
> > > +     .write          = power_supply_hwmon_write,
> > > +     .read_string    = power_supply_hwmon_read_string,
> > > +};
> > > +
> > > +static const struct hwmon_channel_info *power_supply_hwmon_info[] = {
> > > +     HWMON_CHANNEL_INFO(temp,
> > > +                        HWMON_T_LABEL     |
> > > +                        HWMON_T_INPUT     |
> > > +                        HWMON_T_MAX       |
> > > +                        HWMON_T_MIN       |
> > > +                        HWMON_T_MIN_ALARM |
> > > +                        HWMON_T_MIN_ALARM,
> > > +
> > > +                        HWMON_T_LABEL     |
> > > +                        HWMON_T_INPUT     |
> > > +                        HWMON_T_MIN_ALARM |
> > > +                        HWMON_T_LABEL     |
> > > +                        HWMON_T_MAX_ALARM),
> > > +
> > > +     HWMON_CHANNEL_INFO(curr,
> > > +                        HWMON_C_AVERAGE |
> > > +                        HWMON_C_MAX     |
> > > +                        HWMON_C_INPUT),
> > > +
> > > +     HWMON_CHANNEL_INFO(in,
> > > +                        HWMON_I_AVERAGE |
> > > +                        HWMON_I_MIN     |
> > > +                        HWMON_I_MAX     |
> > > +                        HWMON_I_INPUT),
> > > +     NULL
> > > +};
> > > +
> > > +static const struct hwmon_chip_info power_supply_hwmon_chip_info = {
> > > +     .ops = &power_supply_hwmon_ops,
> > > +     .info = power_supply_hwmon_info,
> > > +};
> > > +
> > > +static void power_supply_hwmon_bitmap_free(void *data)
> > > +{
> > > +     bitmap_free(data);
> > > +}
> > > +
> > > +struct device *devm_power_supply_add_hwmon_sysfs(struct power_supply *psy)
> > > +{
> > > +     const struct power_supply_desc *desc = psy->desc;
> > > +     struct power_supply_hwmon *psyhw;
> > > +     struct device *dev = &psy->dev;
> > > +     struct device *hwmon;
> > > +     int ret, i;
> > > +
> > > +     if (!devres_open_group(dev, NULL, GFP_KERNEL))
> > > +             return ERR_PTR(-ENOMEM);
> > > +
> > > +     psyhw = devm_kzalloc(dev, sizeof(*psyhw), GFP_KERNEL);
> > > +     if (!psyhw) {
> > > +             ret = -ENOMEM;
> > > +             goto error;
> > > +     }
> > > +
> > > +     psyhw->psy = psy;
> > > +     psyhw->props = bitmap_zalloc(POWER_SUPPLY_PROP_TIME_TO_FULL_AVG + 1,
> > > +                                  GFP_KERNEL);
> > > +     if (!psyhw->props) {
> > > +             ret = -ENOMEM;
> > > +             goto error;
> > > +     }
> > > +
> > > +     ret = devm_add_action(dev, power_supply_hwmon_bitmap_free,
> > > +                           psyhw->props);
> > > +     if (ret)
> > > +             goto error;
> > > +
> > > +     for (i = 0; i < desc->num_properties; i++) {
> > > +             const enum power_supply_property prop = desc->properties[i];
> > > +
> > > +             switch (prop) {
> > > +             case POWER_SUPPLY_PROP_CURRENT_AVG:
> > > +             case POWER_SUPPLY_PROP_CURRENT_MAX:
> > > +             case POWER_SUPPLY_PROP_CURRENT_NOW:
> > > +             case POWER_SUPPLY_PROP_TEMP:
> > > +             case POWER_SUPPLY_PROP_TEMP_MAX:
> > > +             case POWER_SUPPLY_PROP_TEMP_MIN:
> > > +             case POWER_SUPPLY_PROP_TEMP_ALERT_MIN:
> > > +             case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
> > > +             case POWER_SUPPLY_PROP_TEMP_AMBIENT:
> > > +             case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MIN:
> > > +             case POWER_SUPPLY_PROP_TEMP_AMBIENT_ALERT_MAX:
> > > +             case POWER_SUPPLY_PROP_VOLTAGE_AVG:
> > > +             case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> > > +             case POWER_SUPPLY_PROP_VOLTAGE_MAX:
> > > +             case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> > > +                     set_bit(prop, psyhw->props);
> > > +                     break;
> > > +             default:
> > > +                     break;
> > > +             }
> > > +     }
> > > +
> > > +     hwmon = devm_hwmon_device_register_with_info(dev, psy->desc->name,
> > > +                                             psyhw,
> > > +                                             &power_supply_hwmon_chip_info,
> > > +                                             NULL);
> > > +     ret = PTR_ERR_OR_ZERO(hwmon);
> > > +     if (ret)
> > > +             goto error;
> > > +
> > > +     devres_remove_group(dev, NULL);
> >
> > Why devres_remove_group() and not devres_close_group() ?
> >
> 
> That's id-less group that'll never be used again, closing it and
> keeping it around isn't really particularly useful to me.
> 
Ok, fine with me if it works. I have no idea what the semantics of devres
groups is, much less what the difference between devres_remove_group() and
devres_close_group() is.

> > > +     return hwmon;
> >
> > Why return a pointer to the hwmon device and not just an error code ?
> >
> 
> Just to expose created hwmon device.
> 

Sure, but what for ?

> > > +error:
> > > +     devres_release_group(dev, NULL);
> > > +     return ERR_PTR(ret);
> > > +}
> > > diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> > > index d9c0c094f8a0..839abfa2c640 100644
> > > --- a/include/linux/power_supply.h
> > > +++ b/include/linux/power_supply.h
> > > @@ -481,4 +481,15 @@ static inline bool power_supply_is_watt_property(enum power_supply_property psp)
> > >       return 0;
> > >   }
> > >
> > > +#ifdef CONFIG_POWER_SUPPLY_HWMON
> > > +extern struct device *
> > > +devm_power_supply_add_hwmon_sysfs(struct power_supply *psy);
> > > +#else
> > > +static struct device *
> > > +devm_power_supply_add_hwmon_sysfs(struct power_supply *psy)
> > > +{
> > > +     return 0;
> >
> > You might consider making the return code an int. Otherwise this gets difficult
> > for the caller, who would have to check for IS_ERR() and NULL (if the device
> > pointer is supposed to be used for anything).
> >
> 
> Sure, if removing access to created hwmon device is OK, I am more than
> happy to convert this to return an int.
> 
Again, the question is the opposite: You should not return a pointer unless
you have a use case. "to expose created hwmon device" is not a use case.

Thanks,
Guenter
