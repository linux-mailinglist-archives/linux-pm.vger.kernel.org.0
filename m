Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C656F231A57
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 09:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgG2Hc3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 03:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgG2Hc2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2020 03:32:28 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4E5C061794;
        Wed, 29 Jul 2020 00:32:28 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id r11so4600146pfl.11;
        Wed, 29 Jul 2020 00:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9G4OYs0UCab/dvnPJIUS127vbTkpEm/c/Rhx2fW/Fzo=;
        b=EWEFZG0SKlG43Swojx3oG/j/sKtp+q79x/C6d8oMFHjTQwYWvd2OkOhEAIMBsDjuaB
         gWgzTm9UM1CDDoO9sZynLFD79eeavgTZgaWCCchH287Syn7ThY2YeT1ao3vKiLsQindc
         WX281Mmy8+ku/V/m7DCp1Y9N39kNrOmEXLPvULb1m4r5Fbt5i7X0MfibVcPvX6aQJ1BC
         xh31vwpYAhpPc3TeBv1BDlavFx7kRPatgL0PfbitSYUK0dJ86RAB6tBEILfFc598OE3M
         6XmJNP7gajwfc+s7cKPLL1loI4UCeAWEN0m8kdKcWCEgcgiv8AZt29a/+91JOwTC+cIb
         adGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9G4OYs0UCab/dvnPJIUS127vbTkpEm/c/Rhx2fW/Fzo=;
        b=cLDGnK1VXNUYad3sdOM6iv30IfAdL17yJKvAp66ToYQfUPrV6XrMnECPl03ohB9OAB
         558530CWi7GCG5nGnJrvzKXNhWLOhyFG7BrOkr0DKjwbRaGP/3QMEYlpiTzg8eIk633z
         n/MCDfvHbVuaXJ81B03HDGv+cvUmJHP+RmDTgbXuhTwkakwccEN70WZ1DAvFcckL2j5g
         J+TYrxPvjTUJHUiRHeCzJfhu3FLbl4AE73ML0rRPsBi4nUKHEijZ14SMkkInzXC0MdM+
         RWYG5E1hRPbG/deICnGhPxbrrIs2GCGhpv50bi2SjVXFfo02AM6HZbXIygNAbLWy9kcV
         4MgQ==
X-Gm-Message-State: AOAM531dgalLvyYJJG6H63vmlQfQq9ereeNra8/vF8xMJWCoeiAVMlVx
        mgfw2DyxE1nqHPINfuMmBbfDGueN3p5/NmKEe7w=
X-Google-Smtp-Source: ABdhPJwvHo2cLI9NiL24X4VzQ67G6fdokmJ+2H4uEy1nwgtFtBKA8RNW3aW0Yr3AqYYaqWXcgNFOn92b84KGkFtoXWQ=
X-Received: by 2002:a62:8ccb:: with SMTP id m194mr28731082pfd.36.1596007948031;
 Wed, 29 Jul 2020 00:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200729065424.12851-1-Perry_Yuan@Dell.com>
In-Reply-To: <20200729065424.12851-1-Perry_Yuan@Dell.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 29 Jul 2020 10:32:11 +0300
Message-ID: <CAHp75VekAQA1EpjEdXWm5W3bFfLExxxHRupaowtawDvbKm+-KA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86:dell-laptop:Add battery charging thresholds
 and charging mode switch.
To:     Perry Yuan <Perry.Yuan@dell.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 29, 2020 at 9:54 AM Perry Yuan <Perry.Yuan@dell.com> wrote:
>
> From: perry_yuan <perry_yuan@dell.com>

Fix your name, please. Or do you have it spelled in the official
documents like above?

> The patch control battery charging thresholds when system is under custom
> charging mode through smbios API and driver`s sys attributes.It also set the
> percentage bounds for custom charge.
> Start value must lie in the range [50, 95],End value must lie in the range
> [55, 100],END must be at least (START + 5).
>
> The patch also add the battery charging modes switch support.User can switch
> the battery charging mode through the new sysfs entry.

The commit message needs rewording. I would recommend reading [1] and [2].

[1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html
(section 2)
[2]: https://chris.beams.io/posts/git-commit/

> Primary battery charging modes valid choices are:
> ['primarily_ac', 'adaptive', 'custom', 'standard', 'express']

This and documentation are different (at least in terms of case).

Looks like this is something that should be agreed upon on the format
and gets supported by Power Supply framework in the first place,

>  Documentation/ABI/testing/sysfs-class-power |  23 ++

In any case it should be a separate patch. It has nothing to do with
Dell, on contrary it's a certain device which relies on generic
attributes.

...

>  #include <linux/debugfs.h>
>  #include <linux/seq_file.h>

>  #include <acpi/video.h>
> +#include <acpi/battery.h>

Keep it ordered.

> +#include <linux/string.h>

And this is a generic one, should be in generic headers block.

>  #include "dell-rbtn.h"
>  #include "dell-smbios.h"

...

> +static int dell_battery_get(int *start, int *end)
> +{
> +       struct calling_interface_buffer buffer;
> +       struct calling_interface_token *token;
> +       int ret;
> +

> +       if (start) {
> +               token = dell_smbios_find_token(BATTERY_CUSTOM_CHARGE_START);
> +               if (!token)
> +                       return -ENODEV;
> +               dell_fill_request(&buffer, token->location, 0, 0, 0);
> +               ret = dell_send_request(&buffer,
> +                                       CLASS_TOKEN_READ, SELECT_TOKEN_STD);
> +               *start = buffer.output[1];
> +       }

(1)

> +       if (end) {
> +               token = dell_smbios_find_token(BATTERY_CUSTOM_CHARGE_END);
> +               if (!token)
> +                       return -ENODEV;
> +               dell_fill_request(&buffer, token->location, 0, 0, 0);
> +               ret = dell_send_request(&buffer,
> +                                       CLASS_TOKEN_READ, SELECT_TOKEN_STD);
> +               if (ret)
> +                       return -EIO;
> +               *end = buffer.output[1];
> +       }

(2)

(1) and (2) look like twins. Care to provide a helper to simplify?

> +       return 0;
> +}

...

> +       ret = dell_send_request(&buffer,
> +                               CLASS_TOKEN_WRITE, SELECT_TOKEN_STD);
> +       if (ret)

> +               return -EIO;

Why shadowing error code?

...

> +       ret = dell_send_request(&buffer,
> +                               CLASS_TOKEN_WRITE, SELECT_TOKEN_STD);
> +       if (ret)
> +               return -EIO;

Ditto.

> +       return ret;

And here perhaps simple 'return dell_send_request();'?

...

> +       switch (mode) {
> +       case BAT_STANDARD_MODE:
> +               token = dell_smbios_find_token(BAT_STANDARD_MODE_TOKEN);

> +               if (!token)
> +                       return -ENODEV;

> +               break;
> +       case BAT_EXPRESS_MODE:
> +               token = dell_smbios_find_token(BAT_EXPRESS_MODE_TOKEN);

> +               if (!token)
> +                       return -ENODEV;

> +               break;
> +       case BAT_PRIMARILY_AC_MODE:
> +               token = dell_smbios_find_token(BAT_PRIMARILY_AC_MODE_TOKEN);

> +               if (!token)
> +                       return -ENODEV;

> +               break;
> +       case BAT_CUSTOM_MODE:
> +               token = dell_smbios_find_token(BAT_CUSTOM_MODE_TOKEN);

> +               if (!token)
> +                       return -ENODEV;

> +               break;
> +       case BAT_ADAPTIVE_MODE:
> +               token = dell_smbios_find_token(BAT_ADAPTIVE_MODE_TOKEN);

> +               if (!token)
> +                       return -ENODEV;

Five times the same lines. Please deduplicate them. One is enough.

> +               break;
> +       default:

> +               pr_warn("unspported charging mode!\n");

When you have a device use dev_*() to print messages.

> +               return -EINVAL;
> +       }

...

> +       ret = dell_send_request(&buffer, CLASS_TOKEN_WRITE, SELECT_TOKEN_STD);
> +       if (ret)
> +               return -EIO;
> +
> +       return ret;

return dell_send_request(...);

...

> +       ret = dell_send_request(&buffer, CLASS_TOKEN_READ, SELECT_TOKEN_STD);
> +       if (ret)
> +               return -EIO;

Do not shadow error codes.

> +       if (ret == 0)

What is the point?

> +               *mode = buffer.output[1];

> +       return ret;

Any difference to return 0; ?

...

> +static ssize_t charge_control_charging_mode_show(struct device *dev,
> +               struct device_attribute *attr,
> +               char *buf)
> +{
> +       enum battery_charging_mode mode;
> +       char *s = buf;
> +
> +       for (mode = BAT_STANDARD_MODE; mode < BAT_MAX_MODE; mode++) {
> +               if (battery_state[mode]) {
> +                       if (mode == bat_chg_current)
> +                               s += sprintf(s, "[%s] ", battery_state[mode]);
> +                       else
> +                               s += sprintf(s, "%s ", battery_state[mode]);

You have to control buffer boundaries.

> +               }
> +       }

> +       if (s != buf)

if (s == buf)
  return 0;

> +               /* convert the last space to a newline */
> +               *(s-1) = '\n';
> +       return (s - buf);
> +}

...

> +static ssize_t charge_control_charging_mode_store(struct device *dev,
> +               struct device_attribute *attr,
> +               const char *buf, size_t size)
> +{
> +       int err;
> +       enum battery_charging_mode mode;
> +       char *p;
> +       int len;
> +       const char *label;

> +       p = memchr(buf, '\n', size);
> +       len = p ? p - buf : size;
> +
> +       for (mode = BAT_STANDARD_MODE; mode < BAT_MAX_MODE; mode++) {
> +               label = battery_state[mode];
> +               if (label && len == strlen(label) &&
> +                       !strncmp(buf, label, len)) {
> +                       bat_chg_current = mode;
> +                       break;
> +               }
> +       }

sysfs_match_string()

> +       if (mode > BAT_NONE_MODE && mode < BAT_MAX_MODE)
> +               err = battery_charging_mode_set(mode);
> +       else
> +               err = -EINVAL;
> +
> +       return err ? err : size;
> +}

...

> +static ssize_t charge_control_thresholds_store(struct device *dev,
> +               struct device_attribute *attr,
> +               const char *buf, size_t size)
> +{
> +       int err, start, end;

> +       if (sscanf(buf, "%d %d", &start, &end) != 2)
> +               return -EINVAL;

It's bad. The rule of thumb is one node per one property.
On top of that sscanf() is not good, it doesn't check for overflow,
use one of kstrto*().

> +       err = dell_battery_set(start, end);
> +       if (err)
> +               return err;
> +
> +       return size;
> +}

...

> +static int dell_battery_add(struct power_supply *battery)
> +{
> +       device_create_file(&battery->dev,
> +               &dev_attr_charge_control_start_threshold);
> +       device_create_file(&battery->dev,
> +               &dev_attr_charge_control_end_threshold);
> +       device_create_file(&battery->dev,
> +               &dev_attr_charge_control_charging_mode);

Can it be an attribute group?

> +}

...

> +static struct acpi_battery_hook dell_battery_hook = {
> +       .add_battery = dell_battery_add,
> +       .remove_battery = dell_battery_remove,
> +       .name = "Dell Battery Extension"

Missed comma.

> +};

...

> +static void dell_battery_setup(struct device *dev)
> +{
> +       enum battery_charging_mode current_mode = BAT_NONE_MODE;
> +
> +       battery_charging_mode_get(&current_mode);
> +       if (current_mode) {
> +               bat_chg_current = current_mode;

> +               pr_debug("battery is present\n");
> +       } else {
> +               pr_debug("battery is not present\n");
> +       }

Why not dev_dbg()? Why do we have these messages at all?

> +       battery_hook_register(&dell_battery_hook);

> +       device_create_file(dev, &dev_attr_charge_control_thresholds);

Hmm...

> +}
> +
> +static void dell_battery_exit(struct device *dev)
> +{
> +       if (bat_chg_current != BAT_NONE_MODE) {
> +               battery_hook_unregister(&dell_battery_hook);
> +               device_remove_file(dev, &dev_attr_charge_control_thresholds);
> +       }
> +}

...

> +/*Battery Charging Modes */

Indentation issues.
Same for many other comments in this change.


--
With Best Regards,
Andy Shevchenko
