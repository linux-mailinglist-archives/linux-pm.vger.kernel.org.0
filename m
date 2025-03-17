Return-Path: <linux-pm+bounces-24158-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCCEA64F6B
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 13:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36F187A5BF7
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 12:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BE423C380;
	Mon, 17 Mar 2025 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="RCSb2mHy"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEC723BF9B;
	Mon, 17 Mar 2025 12:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215241; cv=none; b=Rbbrv4sRpMcKOlvEv2wD6IXs3gFLL1doUXja3hXAfzCPl828MWiO6fX5sAyEM20LUVyZaf/KT2V9gWvcGC4dKJ8+tDqbnJEgurMURjgk76vk3/i4kF5jDgn7/WBmSExHq54S1ppLqY64j5OPmOvET+Cn/P6tiPHym59SYImwXag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215241; c=relaxed/simple;
	bh=/ifvT0YHmAWaf7XWBlS5HTeD5nCccJPLy98iwqOOtig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MvebkXbWmLHs5Pq7nA0g1pOCIQ6qyTLlffVPLGZAnvbIRGwF2rm3U4nuWQTRPEh6FrYxWOmgytf3hsU1OAVs6lx9TVWwGSYyx+KbQMBIOY1O6mwJ80N/0JLai9B9sK5WOUtLtaTeQcYUNr9zuEq/q7aIXTn4LOokgH/LBjJszA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=RCSb2mHy; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 242C12E08D3A;
	Mon, 17 Mar 2025 14:40:35 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1742215237;
	bh=GvjbsrqhYXCl+fJq6B8Vfrvfs0PX7hF3K3MuqJf3WhI=;
	h=Received:From:Subject:To;
	b=RCSb2mHy7F/kd+ax1qAjHNv5sgjlK7KJ9m+jP3CorsRjKk6Dd7RPQ+pNag8E5rjLk
	 N5/7ItqOWDY+hvRQNCQ/Z+YhDt0L7dqw1ijgqCz9sJhOMl8Wt/hRamQWWOMfMeM+8a
	 68AdSNSq04dQM/qO5O8xwlCInIPo51bDtYf1B63U=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.182) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f182.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-30bee1cb370so48255231fa.1;
        Mon, 17 Mar 2025 05:40:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUUCs/mIzhxCejXUNwCTbo+rEPH8fN9DLp1AANPdAO6yWIQU8b2WBETJGixVHFBqlofmHhuxtbFQ7NG+s4=@vger.kernel.org,
 AJvYcCVwZKV+1xIIzPmyDKJbY4ZkC0n9X8CoFphV0G4VQBDoRV/dtixIF5Wc7JubYC8y7JIIY7VnuAVXpZU=@vger.kernel.org,
 AJvYcCXexYAWXPKtcTcbNPtd2YSagoETDLCyspa3l8cxCd2+OXl9lKtY90tq0f3imq6ZqtgVCrotIAqWtMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg6av/aOhIn6VFxDlvb9KZBBsmAXcd2RlT3tBQS6cpt1pdTxul
	3cPG56oEw9tuSPpsQpgWEHJ+7Op33xX8NVL1MuT7ycck6LCf/YHYZm3iYVIF/vqC7Jt+Vl9BPUj
	wxEsw5UgKoouejiotZ4j+FIVha1I=
X-Google-Smtp-Source: 
 AGHT+IGMR2djrUaFm4OR/AaOYmGUiiSOp6nN5pKnWDKGhArBTloCJmKfaznMHhz3ADypwLk2MJxkeGR/MMxiHPwOf10=
X-Received: by 2002:a05:651c:503:b0:30b:ee44:b692 with SMTP id
 38308e7fff4ca-30c4a8f4dd4mr58176431fa.33.1742215234440; Mon, 17 Mar 2025
 05:40:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311165406.331046-1-lkml@antheas.dev>
 <20250311165406.331046-7-lkml@antheas.dev>
 <c7a198b5-bebb-498b-9e77-17b467f4dc48@redhat.com>
In-Reply-To: <c7a198b5-bebb-498b-9e77-17b467f4dc48@redhat.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 17 Mar 2025 13:40:23 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwH3Hev7oZP-q6z8Q8iv3XpnrMvN1AzDx7Nsq0bmei+bng@mail.gmail.com>
X-Gm-Features: AQ5f1Jr92O07Ma23OFxBek5VHTKvouZczp3nhbmXFN7sYLxzh5rKvE2OPnyvb4Q
Message-ID: 
 <CAGwozwH3Hev7oZP-q6z8Q8iv3XpnrMvN1AzDx7Nsq0bmei+bng@mail.gmail.com>
Subject: Re: [PATCH v4 06/13] platform/x86: oxpec: Add charge threshold and
 behaviour to OneXPlayer
To: Hans de Goede <hdegoede@redhat.com>
Cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>,
	Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Derek J Clark <derekjohn.clark@gmail.com>,
	Kevin Greenberg <kdgreenberg234@protonmail.com>,
 Joshua Tam <csinaction@pm.me>,
	Parth Menon <parthasarathymenon@gmail.com>, Eileen <eileen@one-netbook.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174221523563.32285.13355826910338874268@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Mon, 17 Mar 2025 at 13:33, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 11-Mar-25 17:53, Antheas Kapenekakis wrote:
> > With the X1 (AMD), OneXPlayer added a charge limit and charge bypass to
> > their devices. Charge limit allows for choosing an arbitrary battery
> > charge setpoint in percentages. Charge bypass allows to instruct the
> > device to stop charging either when it is in s0 or always.
>
> Again please don't use the word bypass, use inhibit instead.
>
> > This feature was then extended for the F1Pro as well. OneXPlayer also
> > released BIOS updates for the X1 Mini, X1 (Intel), and F1 devices that
> > add support for this feature. Therefore, enable it for all F1 and
> > X1 devices.
> >
> > Add both of these under the standard sysfs battery endpoints for them,
> > by looking for the battery. OneXPlayer devices have a single battery.
> >
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >  drivers/platform/x86/Kconfig |   1 +
> >  drivers/platform/x86/oxpec.c | 217 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 218 insertions(+)
> >
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> > index 82cfc76bc5c9..f4d993658c01 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -1189,6 +1189,7 @@ config SEL3350_PLATFORM
> >  config OXP_EC
> >       tristate "OneXPlayer EC platform control"
> >       depends on ACPI_EC
> > +     depends on ACPI_BATTERY
> >       depends on HWMON
> >       depends on X86
> >       help
> > diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
> > index dc3a0871809c..d73a10598d8f 100644
> > --- a/drivers/platform/x86/oxpec.c
> > +++ b/drivers/platform/x86/oxpec.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/module.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/processor.h>
> > +#include <acpi/battery.h>
> >
> >  /* Handle ACPI lock mechanism */
> >  static u32 oxp_mutex;
> > @@ -87,6 +88,24 @@ static enum oxp_board board;
> >
> >  #define OXP_TURBO_RETURN_VAL           0x00 /* Common return val */
> >
> > +/* Battery bypass settings */
> > +#define EC_CHARGE_CONTROL_BEHAVIOURS_X1      (BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)             | \
> > +                                      BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE)    | \
> > +                                      BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0))
> > +
> > +#define OXP_X1_CHARGE_LIMIT_REG      0xA3 /* X1 charge limit (%) */
> > +#define OXP_X1_CHARGE_BYPASS_REG     0xA4 /* X1 bypass charging */
> > +
> > +#define OXP_X1_CHARGE_BYPASS_MASK_S0 0x01
>
> Again avoid the word BYPASS please, if OneXPlayer are calling this bypass in their
> own documentation maybe add a note here when defining the registers that OneXPlayer
> calls this bypass and then use inhibit from there on.

Sure, I can do that.

> > +/*
> > + * Cannot control S3, S5 individually.
> > + * X1 Mask is 0x0A, OneXFly F1Pro is just 0x02
> > + * but the extra bit on the X1 does nothing.
> > + */
> > +#define OXP_X1_CHARGE_BYPASS_MASK_S3S5 0x02
>
> Ok, so suspend is treated as off, but that is for S3 suspend, what about
> s2idle, or does this hw not do s2idle ?

I will change it to OFF. Sorry, s3 is a typo it should be S4.

> > +#define OXP_X1_CHARGE_BYPASS_MASK_ALWAYS (OXP_X1_CHARGE_BYPASS_MASK_S0 | \
> > +     OXP_X1_CHARGE_BYPASS_MASK_S3S5)
> > +
> >  static const struct dmi_system_id dmi_table[] = {
> >       {
> >               .matches = {
> > @@ -434,6 +453,194 @@ static ssize_t tt_toggle_show(struct device *dev,
> >
> >  static DEVICE_ATTR_RW(tt_toggle);
> >
> > +/* Callbacks for charge behaviour attributes */
> > +static bool charge_behaviour_supported(void)
> > +{
> > +     switch (board) {
> > +     case oxp_x1:
> > +     case oxp_fly:
> > +             return 1;
> > +     default:
> > +             break;
> > +     }
> > +     return 0;
> > +}
> > +
> > +static ssize_t charge_behaviour_store(struct device *dev,
> > +                            struct device_attribute *attr, const char *buf,
> > +                            size_t count)
> > +{
> > +     unsigned int available;
> > +     long val, s0, always;
> > +     int ret;
> > +     u8 reg;
> > +
> > +     switch (board) {
> > +     case oxp_x1:
> > +     case oxp_fly:
> > +             s0 = OXP_X1_CHARGE_BYPASS_MASK_S0;
> > +             always = OXP_X1_CHARGE_BYPASS_MASK_ALWAYS;
> > +             reg = OXP_X1_CHARGE_BYPASS_REG;
> > +             available = EC_CHARGE_CONTROL_BEHAVIOURS_X1;
> > +             break;
>
> Since these are always the same this does not seem useful, please
> use the defines directly below.

Ack

> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret = power_supply_charge_behaviour_parse(available, buf);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     switch (ret) {
> > +     case POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO:
> > +             val = 0;
> > +             break;
> > +     case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0:
> > +             val = s0;
> > +             break;
> > +     case POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE:
> > +             val = always;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret = write_to_ec(reg, val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return count;
> > +}
> > +
> > +static ssize_t charge_behaviour_show(struct device *dev,
> > +                           struct device_attribute *attr, char *buf)
> > +{
> > +     long val, s0, always, sel;
> > +     unsigned int available;
> > +     int ret;
> > +     u8 reg;
> > +
> > +     switch (board) {
> > +     case oxp_x1:
> > +     case oxp_fly:
> > +             s0 = OXP_X1_CHARGE_BYPASS_MASK_S0;
> > +             always = OXP_X1_CHARGE_BYPASS_MASK_ALWAYS;
> > +             reg = OXP_X1_CHARGE_BYPASS_REG;
> > +             available = EC_CHARGE_CONTROL_BEHAVIOURS_X1;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret = read_from_ec(reg, 1, &val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if ((val & always) == always)
> > +             sel = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
> > +     else if ((val & s0) == s0)
> > +             sel = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_S0;
> > +     else
> > +             sel = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
> > +
> > +     return power_supply_charge_behaviour_show(dev, available, sel, buf);
> > +}
> > +
> > +static DEVICE_ATTR_RW(charge_behaviour);
> > +
> > +static ssize_t charge_control_end_threshold_store(struct device *dev,
> > +                            struct device_attribute *attr, const char *buf,
> > +                            size_t count)
> > +{
> > +     u64 val, reg;
> > +     int ret;
> > +
> > +     ret = kstrtou64(buf, 10, &val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (val > 100)
> > +             return -EINVAL;
> > +
> > +     switch (board) {
> > +     case oxp_x1:
> > +     case oxp_fly:
> > +             reg = OXP_X1_CHARGE_LIMIT_REG;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret = write_to_ec(reg, val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return count;
> > +}
> > +
> > +static ssize_t charge_control_end_threshold_show(struct device *dev,
> > +                           struct device_attribute *attr, char *buf)
> > +{
> > +     long val;
> > +     int ret;
> > +     u8 reg;
> > +
> > +     switch (board) {
> > +     case oxp_x1:
> > +     case oxp_fly:
> > +             reg = OXP_X1_CHARGE_LIMIT_REG;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret = read_from_ec(reg, 1, &val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return sysfs_emit(buf, "%ld\n", val);
> > +}
> > +
> > +static DEVICE_ATTR_RW(charge_control_end_threshold);
> > +
> > +static int oxp_battery_add(struct power_supply *battery, struct acpi_battery_hook *hook)
> > +{
> > +     /* OneXPlayer devices only have one battery. */
> > +     if (strcmp(battery->desc->name, "BAT0") != 0 &&
> > +         strcmp(battery->desc->name, "BAT1") != 0 &&
> > +         strcmp(battery->desc->name, "BATC") != 0 &&
> > +         strcmp(battery->desc->name, "BATT") != 0)
> > +             return -ENODEV;
> > +
> > +     if (device_create_file(&battery->dev,
> > +         &dev_attr_charge_control_end_threshold))
> > +             return -ENODEV;
> > +
> > +     if (device_create_file(&battery->dev,
> > +         &dev_attr_charge_behaviour)) {
> > +             device_remove_file(&battery->dev,
> > +                             &dev_attr_charge_control_end_threshold);
> > +             return -ENODEV;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int oxp_battery_remove(struct power_supply *battery, struct acpi_battery_hook *hook)
> > +{
> > +     device_remove_file(&battery->dev,
> > +                        &dev_attr_charge_control_end_threshold);
> > +     device_remove_file(&battery->dev,
> > +                        &dev_attr_charge_behaviour);
> > +     return 0;
> > +}
> > +
> > +static struct acpi_battery_hook battery_hook = {
> > +     .add_battery = oxp_battery_add,
> > +     .remove_battery = oxp_battery_remove,
> > +     .name = "OneXPlayer Battery",
> > +};
> > +
>
> Since this is new code it should use the new power-supply extension support instead
> of the old battery_hook mechanism:
>
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6037802bbae892f3ad0c7b4c4faee39b967e32b0
>

Ack

>
> >  /* PWM enable/disable functions */
> >  static int oxp_pwm_enable(void)
> >  {
> > @@ -716,15 +923,25 @@ static int oxp_platform_probe(struct platform_device *pdev)
> >       hwdev = devm_hwmon_device_register_with_info(dev, "oxpec", NULL,
> >                                                    &oxp_ec_chip_info, NULL);
> >
> > +     if (charge_behaviour_supported())
> > +             battery_hook_register(&battery_hook);
> > +
> >       return PTR_ERR_OR_ZERO(hwdev);
> >  }
> >
> > +static void oxp_platform_remove(struct platform_device *device)
> > +{
> > +     if (charge_behaviour_supported())
> > +             battery_hook_unregister(&battery_hook);
> > +}
> > +
> >  static struct platform_driver oxp_platform_driver = {
> >       .driver = {
> >               .name = "oxp-platform",
> >               .dev_groups = oxp_ec_groups,
> >       },
> >       .probe = oxp_platform_probe,
> > +     .remove = oxp_platform_remove,
> >  };
> >
> >  static struct platform_device *oxp_platform_device;
>
> Regards,
>
> Hans
>
>

