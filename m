Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5349A1C4857
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 22:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgEDUcQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 16:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgEDUcJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 16:32:09 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F418C061A0E
        for <linux-pm@vger.kernel.org>; Mon,  4 May 2020 13:32:08 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s8so5294pgq.1
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2020 13:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0OEdpK+P+poWRAHxUtISvWf2SnXdSDR2qMxnPur8Y9E=;
        b=TyKsKz94C646o7hELX2YLY9mlV3/BovMZAQ3JxgGcT3PeO69S3Fi+wS+DozT2mzmmX
         eWU+NbSzwHoFjM8HXT8ZuYXlO93JNjE9kRR0L21xsnMaFy04tJ4XxmxSQkaLi9lbmjLF
         7n41CnGnQwIN9la6uZgno3XEQ5M1g3VcVp1s0e2RzWdplLlP0q8+xtb8ijuHd9yCSvPQ
         fMHtOiqjTPjSTSFraKF9NGgq2Q/jRrX6wbrBVwqoxSIxUTgevgxzWgLVG1Kh3t96KM0N
         oOYaXnEhWsmZpXQpU59YzzMwPUI0FtNYSVpkuA6NvBv29IBXiS4lf0JKelh6T0RIH4/H
         xg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0OEdpK+P+poWRAHxUtISvWf2SnXdSDR2qMxnPur8Y9E=;
        b=HI4a5xOwGJLXmdDgRZF9ESTU+kvZ6wNA2uaQeR6xFDu2IJDbZqEZZGjT/x4mBAd46r
         6E0B79FiYtbnPHuZC8HwkOE3n3HM+KIBhRLXXEu3NPDQvv0CbLdHMinpmceLM/9u61RC
         HiwbGwdkGtZmRC5+gESH1e964gXc7mZB5ZSyk+Xonf7rsTCGHOtv98h/DfF5tySf+lNK
         DCYEh3yQrc4g9tkTruv57U1EjGWAp2Mtm9DTVdEUGR+bcF59Wseu9AxZLXHayLg+H66F
         kOejtJn7AfSwimwfc20c5r+gnlSh9z5EuN0u3rHh+25cqNsZ8Hha4k+r6evL/HBWubrV
         RBIw==
X-Gm-Message-State: AGi0PuYHHzIUMLngZ6CI5mx362mGQOT842vpsz1M4ydzrw3vEGRUhiz4
        PjXs7LRKDFuJMFuhuFGFYYPGzVL12PJzWZLoy1LsQg==
X-Google-Smtp-Source: APiQypL09vobg5tyv3EIvgERqBsjzsbLAOGe7VniTbcmvU87tw0YrCFe3ocgD8aDUQf9UsNrIEQPxi2i6TzSu89CZsg=
X-Received: by 2002:a63:745b:: with SMTP id e27mr17221pgn.195.1588624327563;
 Mon, 04 May 2020 13:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200424173533.48572-1-mathewk@chromium.org> <20200424173533.48572-2-mathewk@chromium.org>
 <20200502003212.qnv6xnprk6ehkg4i@earth.universe>
In-Reply-To: <20200502003212.qnv6xnprk6ehkg4i@earth.universe>
From:   Mat King <mathewk@google.com>
Date:   Mon, 4 May 2020 14:31:56 -0600
Message-ID: <CAL_quvSyaHZroAiLh8Nmr_KAhqg2VqmB8p-t4yEdRXBykddwTA@mail.gmail.com>
Subject: Re: [PATCH 1/4] power_supply: Cleanup power supply sysfs attribute list
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Mathew King <mathewk@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 1, 2020 at 6:32 PM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On Fri, Apr 24, 2020 at 11:35:30AM -0600, Mathew King wrote:
> > Make the device attribute list used to create sysfs attributes more
> > robust by decoupling the list order from order of the enum defined in
> > power_supply.h. This is done by using a designated initializer in the
> > POWER_SUPPLY_ATTR macro.
>
> Thanks for doing this :)
>
> > Also properties not added to the list will still be created with
> > name in the format "prop_*".
>
> This is bad. We don't want to expose PROP_%d to userspace and risk
> this becoming ABI. Instead it should not be registered and a warning
> should be printed. This means we can drop the prop_name field and directly
> use upper, which will always be in TEXT segment then.
>
> For the lower case name, I think it's better to provide it as second
> argument to POWER_SUPPLY_ATTR. Not very elegant solution, but it
> means, that the string is in the TEXT segment and that we can
> have the complete dev_attr initialized from the macro.

Thanks for the feedback. I just sent a new patch series with these
issues addressed.

>
> -- Sebastian
>
> > Signed-off-by: Mathew King <mathewk@chromium.org>
> > ---
> >  drivers/power/supply/power_supply.h       |   7 +-
> >  drivers/power/supply/power_supply_core.c  |   9 +-
> >  drivers/power/supply/power_supply_sysfs.c | 290 +++++++++++++---------
> >  3 files changed, 179 insertions(+), 127 deletions(-)
> >
> > diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/power_supply.h
> > index c310d4f36c10..e3475d35ec2a 100644
> > --- a/drivers/power/supply/power_supply.h
> > +++ b/drivers/power/supply/power_supply.h
> > @@ -15,12 +15,15 @@ struct power_supply;
> >
> >  #ifdef CONFIG_SYSFS
> >
> > -extern void power_supply_init_attrs(struct device_type *dev_type);
> > +extern int power_supply_init_attrs(struct device_type *dev_type);
> > +extern void power_supply_destroy_attrs(void);
> >  extern int power_supply_uevent(struct device *dev, struct kobj_uevent_env *env);
> >
> >  #else
> >
> > -static inline void power_supply_init_attrs(struct device_type *dev_type) {}
> > +static inline int power_supply_init_attrs(struct device_type *dev_type)
> > +{ return 0; }
> > +static void power_supply_destroy_attrs(void) {}
> >  #define power_supply_uevent NULL
> >
> >  #endif /* CONFIG_SYSFS */
> > diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> > index 1a9a9fae73d3..7fb99302b532 100644
> > --- a/drivers/power/supply/power_supply_core.c
> > +++ b/drivers/power/supply/power_supply_core.c
> > @@ -1329,19 +1329,26 @@ EXPORT_SYMBOL_GPL(power_supply_get_drvdata);
> >
> >  static int __init power_supply_class_init(void)
> >  {
> > +     int ret;
> >       power_supply_class = class_create(THIS_MODULE, "power_supply");
> >
> >       if (IS_ERR(power_supply_class))
> >               return PTR_ERR(power_supply_class);
> >
> >       power_supply_class->dev_uevent = power_supply_uevent;
> > -     power_supply_init_attrs(&power_supply_dev_type);
> > +
> > +     ret = power_supply_init_attrs(&power_supply_dev_type);
> > +     if (ret) {
> > +             class_destroy(power_supply_class);
> > +             return ret;
> > +     }
> >
> >       return 0;
> >  }
> >
> >  static void __exit power_supply_class_exit(void)
> >  {
> > +     power_supply_destroy_attrs();
> >       class_destroy(power_supply_class);
> >  }
> >
> > diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> > index f37ad4eae60b..b579081599d7 100644
> > --- a/drivers/power/supply/power_supply_sysfs.c
> > +++ b/drivers/power/supply/power_supply_sysfs.c
> > @@ -18,27 +18,22 @@
> >
> >  #include "power_supply.h"
> >
> > -/*
> > - * This is because the name "current" breaks the device attr macro.
> > - * The "current" word resolves to "(get_current())" so instead of
> > - * "current" "(get_current())" appears in the sysfs.
> > - *
> > - * The source of this definition is the device.h which calls __ATTR
> > - * macro in sysfs.h which calls the __stringify macro.
> > - *
> > - * Only modification that the name is not tried to be resolved
> > - * (as a macro let's say).
> > - */
> > +#define UNDEF_PROP_NAME_FMT "PROP_%d"
> > +#define UNDEF_PROP_NAME_LEN (strlen(UNDEF_PROP_NAME_FMT) + 2)
> > +
> > +struct power_supply_attr {
> > +     const char *prop_name;
> > +     const char *upper_name;
> > +     const char *lower_name;
> > +     struct device_attribute dev_attr;
> > +};
> >
> > -#define POWER_SUPPLY_ATTR(_name)                                     \
> > -{                                                                    \
> > -     .attr = { .name = #_name },                                     \
> > -     .show = power_supply_show_property,                             \
> > -     .store = power_supply_store_property,                           \
> > +#define POWER_SUPPLY_ATTR(_name)     \
> > +[POWER_SUPPLY_PROP_ ## _name] =              \
> > +{                                    \
> > +     .prop_name = #_name             \
> >  }
> >
> > -static struct device_attribute power_supply_attrs[];
> > -
> >  static const char * const power_supply_type_text[] = {
> >       "Unknown", "Battery", "UPS", "Mains", "USB",
> >       "USB_DCP", "USB_CDP", "USB_ACA", "USB_C",
> > @@ -77,6 +72,91 @@ static const char * const power_supply_scope_text[] = {
> >       "Unknown", "System", "Device"
> >  };
> >
> > +static struct power_supply_attr power_supply_attrs[] = {
> > +     /* Properties of type `int' */
> > +     POWER_SUPPLY_ATTR(STATUS),
> > +     POWER_SUPPLY_ATTR(CHARGE_TYPE),
> > +     POWER_SUPPLY_ATTR(HEALTH),
> > +     POWER_SUPPLY_ATTR(PRESENT),
> > +     POWER_SUPPLY_ATTR(ONLINE),
> > +     POWER_SUPPLY_ATTR(AUTHENTIC),
> > +     POWER_SUPPLY_ATTR(TECHNOLOGY),
> > +     POWER_SUPPLY_ATTR(CYCLE_COUNT),
> > +     POWER_SUPPLY_ATTR(VOLTAGE_MAX),
> > +     POWER_SUPPLY_ATTR(VOLTAGE_MIN),
> > +     POWER_SUPPLY_ATTR(VOLTAGE_MAX_DESIGN),
> > +     POWER_SUPPLY_ATTR(VOLTAGE_MIN_DESIGN),
> > +     POWER_SUPPLY_ATTR(VOLTAGE_NOW),
> > +     POWER_SUPPLY_ATTR(VOLTAGE_AVG),
> > +     POWER_SUPPLY_ATTR(VOLTAGE_OCV),
> > +     POWER_SUPPLY_ATTR(VOLTAGE_BOOT),
> > +     POWER_SUPPLY_ATTR(CURRENT_MAX),
> > +     POWER_SUPPLY_ATTR(CURRENT_NOW),
> > +     POWER_SUPPLY_ATTR(CURRENT_AVG),
> > +     POWER_SUPPLY_ATTR(CURRENT_BOOT),
> > +     POWER_SUPPLY_ATTR(POWER_NOW),
> > +     POWER_SUPPLY_ATTR(POWER_AVG),
> > +     POWER_SUPPLY_ATTR(CHARGE_FULL_DESIGN),
> > +     POWER_SUPPLY_ATTR(CHARGE_EMPTY_DESIGN),
> > +     POWER_SUPPLY_ATTR(CHARGE_FULL),
> > +     POWER_SUPPLY_ATTR(CHARGE_EMPTY),
> > +     POWER_SUPPLY_ATTR(CHARGE_NOW),
> > +     POWER_SUPPLY_ATTR(CHARGE_AVG),
> > +     POWER_SUPPLY_ATTR(CHARGE_COUNTER),
> > +     POWER_SUPPLY_ATTR(CONSTANT_CHARGE_CURRENT),
> > +     POWER_SUPPLY_ATTR(CONSTANT_CHARGE_CURRENT_MAX),
> > +     POWER_SUPPLY_ATTR(CONSTANT_CHARGE_VOLTAGE),
> > +     POWER_SUPPLY_ATTR(CONSTANT_CHARGE_VOLTAGE_MAX),
> > +     POWER_SUPPLY_ATTR(CHARGE_CONTROL_LIMIT),
> > +     POWER_SUPPLY_ATTR(CHARGE_CONTROL_LIMIT_MAX),
> > +     POWER_SUPPLY_ATTR(CHARGE_CONTROL_START_THRESHOLD),
> > +     POWER_SUPPLY_ATTR(CHARGE_CONTROL_END_THRESHOLD),
> > +     POWER_SUPPLY_ATTR(INPUT_CURRENT_LIMIT),
> > +     POWER_SUPPLY_ATTR(INPUT_VOLTAGE_LIMIT),
> > +     POWER_SUPPLY_ATTR(INPUT_POWER_LIMIT),
> > +     POWER_SUPPLY_ATTR(ENERGY_FULL_DESIGN),
> > +     POWER_SUPPLY_ATTR(ENERGY_EMPTY_DESIGN),
> > +     POWER_SUPPLY_ATTR(ENERGY_FULL),
> > +     POWER_SUPPLY_ATTR(ENERGY_EMPTY),
> > +     POWER_SUPPLY_ATTR(ENERGY_NOW),
> > +     POWER_SUPPLY_ATTR(ENERGY_AVG),
> > +     POWER_SUPPLY_ATTR(CAPACITY),
> > +     POWER_SUPPLY_ATTR(CAPACITY_ALERT_MIN),
> > +     POWER_SUPPLY_ATTR(CAPACITY_ALERT_MAX),
> > +     POWER_SUPPLY_ATTR(CAPACITY_LEVEL),
> > +     POWER_SUPPLY_ATTR(TEMP),
> > +     POWER_SUPPLY_ATTR(TEMP_MAX),
> > +     POWER_SUPPLY_ATTR(TEMP_MIN),
> > +     POWER_SUPPLY_ATTR(TEMP_ALERT_MIN),
> > +     POWER_SUPPLY_ATTR(TEMP_ALERT_MAX),
> > +     POWER_SUPPLY_ATTR(TEMP_AMBIENT),
> > +     POWER_SUPPLY_ATTR(TEMP_AMBIENT_ALERT_MIN),
> > +     POWER_SUPPLY_ATTR(TEMP_AMBIENT_ALERT_MAX),
> > +     POWER_SUPPLY_ATTR(TIME_TO_EMPTY_NOW),
> > +     POWER_SUPPLY_ATTR(TIME_TO_EMPTY_AVG),
> > +     POWER_SUPPLY_ATTR(TIME_TO_FULL_NOW),
> > +     POWER_SUPPLY_ATTR(TIME_TO_FULL_AVG),
> > +     POWER_SUPPLY_ATTR(TYPE),
> > +     POWER_SUPPLY_ATTR(USB_TYPE),
> > +     POWER_SUPPLY_ATTR(SCOPE),
> > +     POWER_SUPPLY_ATTR(PRECHARGE_CURRENT),
> > +     POWER_SUPPLY_ATTR(CHARGE_TERM_CURRENT),
> > +     POWER_SUPPLY_ATTR(CALIBRATE),
> > +     /* Properties of type `const char *' */
> > +     POWER_SUPPLY_ATTR(MODEL_NAME),
> > +     POWER_SUPPLY_ATTR(MANUFACTURER),
> > +     POWER_SUPPLY_ATTR(SERIAL_NUMBER),
> > +};
> > +
> > +static struct attribute *
> > +__power_supply_attrs[ARRAY_SIZE(power_supply_attrs) + 1];
> > +
> > +static enum power_supply_property dev_attr_psp(struct device_attribute *attr)
> > +{
> > +     return container_of(attr, struct power_supply_attr, dev_attr) -
> > +             power_supply_attrs;
> > +}
> > +
> >  static ssize_t power_supply_show_usb_type(struct device *dev,
> >                                         enum power_supply_usb_type *usb_types,
> >                                         ssize_t num_usb_types,
> > @@ -117,7 +197,7 @@ static ssize_t power_supply_show_property(struct device *dev,
> >                                         char *buf) {
> >       ssize_t ret;
> >       struct power_supply *psy = dev_get_drvdata(dev);
> > -     enum power_supply_property psp = attr - power_supply_attrs;
> > +     enum power_supply_property psp = dev_attr_psp(attr);
> >       union power_supply_propval value;
> >
> >       if (psp == POWER_SUPPLY_PROP_TYPE) {
> > @@ -186,7 +266,7 @@ static ssize_t power_supply_store_property(struct device *dev,
> >                                          const char *buf, size_t count) {
> >       ssize_t ret;
> >       struct power_supply *psy = dev_get_drvdata(dev);
> > -     enum power_supply_property psp = attr - power_supply_attrs;
> > +     enum power_supply_property psp = dev_attr_psp(attr);
> >       union power_supply_propval value;
> >
> >       switch (psp) {
> > @@ -235,86 +315,6 @@ static ssize_t power_supply_store_property(struct device *dev,
> >       return count;
> >  }
> >
> > -/* Must be in the same order as POWER_SUPPLY_PROP_* */
> > -static struct device_attribute power_supply_attrs[] = {
> > -     /* Properties of type `int' */
> > -     POWER_SUPPLY_ATTR(status),
> > -     POWER_SUPPLY_ATTR(charge_type),
> > -     POWER_SUPPLY_ATTR(health),
> > -     POWER_SUPPLY_ATTR(present),
> > -     POWER_SUPPLY_ATTR(online),
> > -     POWER_SUPPLY_ATTR(authentic),
> > -     POWER_SUPPLY_ATTR(technology),
> > -     POWER_SUPPLY_ATTR(cycle_count),
> > -     POWER_SUPPLY_ATTR(voltage_max),
> > -     POWER_SUPPLY_ATTR(voltage_min),
> > -     POWER_SUPPLY_ATTR(voltage_max_design),
> > -     POWER_SUPPLY_ATTR(voltage_min_design),
> > -     POWER_SUPPLY_ATTR(voltage_now),
> > -     POWER_SUPPLY_ATTR(voltage_avg),
> > -     POWER_SUPPLY_ATTR(voltage_ocv),
> > -     POWER_SUPPLY_ATTR(voltage_boot),
> > -     POWER_SUPPLY_ATTR(current_max),
> > -     POWER_SUPPLY_ATTR(current_now),
> > -     POWER_SUPPLY_ATTR(current_avg),
> > -     POWER_SUPPLY_ATTR(current_boot),
> > -     POWER_SUPPLY_ATTR(power_now),
> > -     POWER_SUPPLY_ATTR(power_avg),
> > -     POWER_SUPPLY_ATTR(charge_full_design),
> > -     POWER_SUPPLY_ATTR(charge_empty_design),
> > -     POWER_SUPPLY_ATTR(charge_full),
> > -     POWER_SUPPLY_ATTR(charge_empty),
> > -     POWER_SUPPLY_ATTR(charge_now),
> > -     POWER_SUPPLY_ATTR(charge_avg),
> > -     POWER_SUPPLY_ATTR(charge_counter),
> > -     POWER_SUPPLY_ATTR(constant_charge_current),
> > -     POWER_SUPPLY_ATTR(constant_charge_current_max),
> > -     POWER_SUPPLY_ATTR(constant_charge_voltage),
> > -     POWER_SUPPLY_ATTR(constant_charge_voltage_max),
> > -     POWER_SUPPLY_ATTR(charge_control_limit),
> > -     POWER_SUPPLY_ATTR(charge_control_limit_max),
> > -     POWER_SUPPLY_ATTR(charge_control_start_threshold),
> > -     POWER_SUPPLY_ATTR(charge_control_end_threshold),
> > -     POWER_SUPPLY_ATTR(input_current_limit),
> > -     POWER_SUPPLY_ATTR(input_voltage_limit),
> > -     POWER_SUPPLY_ATTR(input_power_limit),
> > -     POWER_SUPPLY_ATTR(energy_full_design),
> > -     POWER_SUPPLY_ATTR(energy_empty_design),
> > -     POWER_SUPPLY_ATTR(energy_full),
> > -     POWER_SUPPLY_ATTR(energy_empty),
> > -     POWER_SUPPLY_ATTR(energy_now),
> > -     POWER_SUPPLY_ATTR(energy_avg),
> > -     POWER_SUPPLY_ATTR(capacity),
> > -     POWER_SUPPLY_ATTR(capacity_alert_min),
> > -     POWER_SUPPLY_ATTR(capacity_alert_max),
> > -     POWER_SUPPLY_ATTR(capacity_level),
> > -     POWER_SUPPLY_ATTR(temp),
> > -     POWER_SUPPLY_ATTR(temp_max),
> > -     POWER_SUPPLY_ATTR(temp_min),
> > -     POWER_SUPPLY_ATTR(temp_alert_min),
> > -     POWER_SUPPLY_ATTR(temp_alert_max),
> > -     POWER_SUPPLY_ATTR(temp_ambient),
> > -     POWER_SUPPLY_ATTR(temp_ambient_alert_min),
> > -     POWER_SUPPLY_ATTR(temp_ambient_alert_max),
> > -     POWER_SUPPLY_ATTR(time_to_empty_now),
> > -     POWER_SUPPLY_ATTR(time_to_empty_avg),
> > -     POWER_SUPPLY_ATTR(time_to_full_now),
> > -     POWER_SUPPLY_ATTR(time_to_full_avg),
> > -     POWER_SUPPLY_ATTR(type),
> > -     POWER_SUPPLY_ATTR(usb_type),
> > -     POWER_SUPPLY_ATTR(scope),
> > -     POWER_SUPPLY_ATTR(precharge_current),
> > -     POWER_SUPPLY_ATTR(charge_term_current),
> > -     POWER_SUPPLY_ATTR(calibrate),
> > -     /* Properties of type `const char *' */
> > -     POWER_SUPPLY_ATTR(model_name),
> > -     POWER_SUPPLY_ATTR(manufacturer),
> > -     POWER_SUPPLY_ATTR(serial_number),
> > -};
> > -
> > -static struct attribute *
> > -__power_supply_attrs[ARRAY_SIZE(power_supply_attrs) + 1];
> > -
> >  static umode_t power_supply_attr_is_visible(struct kobject *kobj,
> >                                          struct attribute *attr,
> >                                          int attrno)
> > @@ -352,17 +352,7 @@ static const struct attribute_group *power_supply_attr_groups[] = {
> >       NULL,
> >  };
> >
> > -void power_supply_init_attrs(struct device_type *dev_type)
> > -{
> > -     int i;
> > -
> > -     dev_type->groups = power_supply_attr_groups;
> > -
> > -     for (i = 0; i < ARRAY_SIZE(power_supply_attrs); i++)
> > -             __power_supply_attrs[i] = &power_supply_attrs[i].attr;
> > -}
> > -
> > -static char *kstruprdup(const char *str, gfp_t gfp)
> > +static char *kstrlwrdup(const char *str, gfp_t gfp)
> >  {
> >       char *ret, *ustr;
> >
> > @@ -372,19 +362,75 @@ static char *kstruprdup(const char *str, gfp_t gfp)
> >               return NULL;
> >
> >       while (*str)
> > -             *ustr++ = toupper(*str++);
> > +             *ustr++ = tolower(*str++);
> >
> >       *ustr = 0;
> >
> >       return ret;
> >  }
> >
> > +int power_supply_init_attrs(struct device_type *dev_type)
> > +{
> > +     int i;
> > +
> > +     dev_type->groups = power_supply_attr_groups;
> > +
> > +     for (i = 0; i < ARRAY_SIZE(power_supply_attrs); i++) {
> > +             const char *upper, *lower;
> > +             struct device_attribute *attr;
> > +
> > +             upper = power_supply_attrs[i].prop_name;
> > +
> > +             if (!upper) {
> > +                     char *name = kmalloc(UNDEF_PROP_NAME_LEN, GFP_KERNEL);
> > +
> > +                     if (!name)
> > +                             goto err_no_mem;
> > +
> > +                     sprintf(name, UNDEF_PROP_NAME_FMT, i);
> > +                     upper = name;
> > +             }
> > +
> > +             lower = kstrlwrdup(upper, GFP_KERNEL);
> > +
> > +             if (!lower)
> > +                     goto err_no_mem;
> > +
> > +             power_supply_attrs[i].upper_name = upper;
> > +             power_supply_attrs[i].lower_name = lower;
> > +
> > +             attr = &power_supply_attrs[i].dev_attr;
> > +
> > +             attr->attr.name = lower;
> > +             attr->show = power_supply_show_property;
> > +             attr->store = power_supply_store_property;
> > +             __power_supply_attrs[i] = &attr->attr;
> > +     }
> > +
> > +     return 0;
> > +
> > +err_no_mem:
> > +     power_supply_destroy_attrs();
> > +     return -ENOMEM;
> > +}
> > +
> > +void power_supply_destroy_attrs(void)
> > +{
> > +     int i;
> > +
> > +     for (i = 0; i < ARRAY_SIZE(power_supply_attrs); i++) {
> > +             kfree(power_supply_attrs[i].lower_name);
> > +
> > +             if (!power_supply_attrs[i].prop_name)
> > +                     kfree(power_supply_attrs[i].upper_name);
> > +     }
> > +}
> > +
> >  int power_supply_uevent(struct device *dev, struct kobj_uevent_env *env)
> >  {
> >       struct power_supply *psy = dev_get_drvdata(dev);
> >       int ret = 0, j;
> >       char *prop_buf;
> > -     char *attrname;
> >
> >       if (!psy || !psy->desc) {
> >               dev_dbg(dev, "No power supply yet\n");
> > @@ -400,12 +446,14 @@ int power_supply_uevent(struct device *dev, struct kobj_uevent_env *env)
> >               return -ENOMEM;
> >
> >       for (j = 0; j < psy->desc->num_properties; j++) {
> > -             struct device_attribute *attr;
> > +             struct power_supply_attr *pwr_attr;
> > +             struct device_attribute *dev_attr;
> >               char *line;
> >
> > -             attr = &power_supply_attrs[psy->desc->properties[j]];
> > +             pwr_attr = &power_supply_attrs[psy->desc->properties[j]];
> > +             dev_attr = &pwr_attr->dev_attr;
> >
> > -             ret = power_supply_show_property(dev, attr, prop_buf);
> > +             ret = power_supply_show_property(dev, dev_attr, prop_buf);
> >               if (ret == -ENODEV || ret == -ENODATA) {
> >                       /* When a battery is absent, we expect -ENODEV. Don't abort;
> >                          send the uevent with at least the the PRESENT=0 property */
> > @@ -420,14 +468,8 @@ int power_supply_uevent(struct device *dev, struct kobj_uevent_env *env)
> >               if (line)
> >                       *line = 0;
> >
> > -             attrname = kstruprdup(attr->attr.name, GFP_KERNEL);
> > -             if (!attrname) {
> > -                     ret = -ENOMEM;
> > -                     goto out;
> > -             }
> > -
> > -             ret = add_uevent_var(env, "POWER_SUPPLY_%s=%s", attrname, prop_buf);
> > -             kfree(attrname);
> > +             ret = add_uevent_var(env, "POWER_SUPPLY_%s=%s",
> > +                                  pwr_attr->upper_name, prop_buf);
> >               if (ret)
> >                       goto out;
> >       }
> > --
> > 2.26.2.303.gf8c07b1a785-goog
> >
