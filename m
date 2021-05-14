Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3F53805A4
	for <lists+linux-pm@lfdr.de>; Fri, 14 May 2021 10:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhENI5x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 May 2021 04:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhENI5x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 May 2021 04:57:53 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FCAC06174A
        for <linux-pm@vger.kernel.org>; Fri, 14 May 2021 01:56:41 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n3so3741880plf.7
        for <linux-pm@vger.kernel.org>; Fri, 14 May 2021 01:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/4IU+cIjO072ANjiPhOXacPYOuvXpydGpm2dpjUQcws=;
        b=PujwjuYSsw1K7oz/Baa46fTUrvXyBOk+g6hieRKjmG+f7YeqW0uHprPn9d3rMotYkZ
         5gvgz5FP/KAyphMmLXWAOzG42xbdoeCUWs9a/ghrpYKQP/7Uf1DcYZG8ojeE2HKzZamE
         gfQPom7u6TpEJS/mTlzFmrwD5g6DeAObdKJfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/4IU+cIjO072ANjiPhOXacPYOuvXpydGpm2dpjUQcws=;
        b=HhGxxE1diNVf4s17U6AIkg2qotDRqIUEPVCRUpxqffFpLIKIJmSZSrVsLJ8HD9nuXf
         PFKuJaCQyTRcq5ERnrqihdyYC/fKOpVIOW62iC8Ga12olGo40TKZKw9dIz6Btot9OCTS
         /EkeU9kDuHl+Oa9Rt8YwRzDKNIy2hFxsehjY6Onbz7V4mGSqDYgPhw4K3jS6kNDhWCQk
         pkNskQyoGS2RzrxZsyKslh7StKlSYLffbXWWOi8oPubBd9FkaVXBdWt+qBc+HuP03dP9
         Xc6sjwCptpBw3vpYA7c8bWBajzsqOXF8aHr9PrQMy+8G+sL4hKsfnghj8qAmivFW3FqP
         TjhA==
X-Gm-Message-State: AOAM532hZ4D0PI3uJzG56Y2acZJgQqegk9rs7imt+BB+RTmD/ZKM+0nG
        bn049nVxLJtngnVJtFBj/J5vfEJ/G6OVNXG2xkcAtQ==
X-Google-Smtp-Source: ABdhPJwVJ9ZJjOxv1erPjtCTW6Kynzb4CnV+W80WAiAEKwNLnLMPn0ZApCQ/CcDyflbYiMi78pFiOflohG/cYOuWuSY=
X-Received: by 2002:a17:90a:be10:: with SMTP id a16mr9578779pjs.112.1620982600675;
 Fri, 14 May 2021 01:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210513020308.4011440-1-ikjn@chromium.org> <20210513110045.5yrootk4bv6u6lya@earth.universe>
In-Reply-To: <20210513110045.5yrootk4bv6u6lya@earth.universe>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Fri, 14 May 2021 16:56:29 +0800
Message-ID: <CAATdQgAPW4hq1R7WA3wSFS7L3jas5-CPSaEgRWL+gzx7Lokdeg@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] power: supply: sbs-battery: cache constant
 string properties
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-pm@vger.kernel.org, Hsinyi Wang <hsinyi@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,
Thanks for the review!

On Thu, May 13, 2021 at 7:00 PM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On Thu, May 13, 2021 at 10:03:08AM +0800, Ikjoon Jang wrote:
> > Currently sbs-battery supports three string properties -
> > manufacturer, model_name, and chemistry. Buffers for those
> > properties are currently defined as global variables.
> >
> > This patch moves those global variables into struct sbs_info
> > and cache/reuse them as they are all constant values.
>
> Thanks, that's a nice cleanup. I have a two comments, though.
> Please find them inline.
>
> > Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> > Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
> >
> > ---
> > Resend v2: Adds Tested-by, escape from v1 mail thread.
> >
> > Changes in v2:
> > - change function name of sbs_get_battery_string_property()
> >   to sbs_get_constant_string()
> > - use cached string properties
> > - use cached technology value in sbs_get_chemistry()
> >
> >  drivers/power/supply/sbs-battery.c | 140 +++++++++++++++++------------
> >  1 file changed, 82 insertions(+), 58 deletions(-)
> >
> > diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
> > index 4bf92831cb06..414de9bc47bf 100644
> > --- a/drivers/power/supply/sbs-battery.c
> > +++ b/drivers/power/supply/sbs-battery.c
> > @@ -188,6 +188,14 @@ static const enum power_supply_property sbs_properties[] = {
> >  /* Supports special manufacturer commands from TI BQ20Z65 and BQ20Z75 IC. */
> >  #define SBS_FLAGS_TI_BQ20ZX5         BIT(0)
> >
> > +static const enum power_supply_property string_properties[] = {
> > +     POWER_SUPPLY_PROP_TECHNOLOGY,
> > +     POWER_SUPPLY_PROP_MANUFACTURER,
> > +     POWER_SUPPLY_PROP_MODEL_NAME,
> > +};
> > +
> > +#define NR_STRING_BUFFERS    ARRAY_SIZE(string_properties)
> > +
> >  struct sbs_info {
> >       struct i2c_client               *client;
> >       struct power_supply             *power_supply;
> > @@ -201,11 +209,22 @@ struct sbs_info {
> >       struct delayed_work             work;
> >       struct mutex                    mode_lock;
> >       u32                             flags;
> > +     int                             technology;
> > +     char                            strings[NR_STRING_BUFFERS][I2C_SMBUS_BLOCK_MAX + 1];
> >  };
> >
> > -static char model_name[I2C_SMBUS_BLOCK_MAX + 1];
> > -static char manufacturer[I2C_SMBUS_BLOCK_MAX + 1];
> > -static char chemistry[I2C_SMBUS_BLOCK_MAX + 1];
> > +static char *sbs_get_string_buf(struct sbs_info *chip,
> > +                             enum power_supply_property psp)
> > +{
> > +     int i = 0;
> > +
> > +     for (i = 0; i < NR_STRING_BUFFERS; i++)
> > +             if (string_properties[i] == psp)
> > +                     return chip->strings[i];
> > +
> > +     return ERR_PTR(-EINVAL);
> > +}
> > +
> >  static bool force_load;
> >
> >  static int sbs_read_word_data(struct i2c_client *client, u8 address);
> > @@ -639,17 +658,45 @@ static int sbs_get_battery_property(struct i2c_client *client,
> >       return 0;
> >  }
> >
> > -static int sbs_get_battery_string_property(struct i2c_client *client,
> > -     int reg_offset, enum power_supply_property psp, char *val)
> > +static int sbs_get_property_index(struct i2c_client *client,
> > +     enum power_supply_property psp)
> >  {
> > -     s32 ret;
> > +     int count;
> > +
> > +     for (count = 0; count < ARRAY_SIZE(sbs_data); count++)
> > +             if (psp == sbs_data[count].psp)
> > +                     return count;
> >
> > -     ret = sbs_read_string_data(client, sbs_data[reg_offset].addr, val);
> > +     dev_warn(&client->dev,
> > +             "%s: Invalid Property - %d\n", __func__, psp);
> >
> > -     if (ret < 0)
> > -             return ret;
> > +     return -EINVAL;
> > +}
> >
> > -     return 0;
> > +static const char *sbs_get_constant_string(struct sbs_info *chip,
> > +                     enum power_supply_property psp)
> > +{
> > +     int ret;
> > +     char *buf;
> > +     u8 addr;
> > +
> > +     buf = sbs_get_string_buf(chip, psp);
> > +     if (IS_ERR(buf))
> > +             return buf;
> > +
> > +     if (!buf[0]) {
> > +             ret = sbs_get_property_index(chip->client, psp);
> > +             if (ret < 0)
> > +                     return ERR_PTR(ret);
> > +
> > +             addr = sbs_data[ret].addr;
> > +
> > +             ret = sbs_read_string_data(chip->client, addr, buf);
> > +             if (ret < 0)
> > +                     return ERR_PTR(ret);
> > +     }
> > +
> > +     return buf;
> >  }
> >
> >  static void  sbs_unit_adjustment(struct i2c_client *client,
> > @@ -772,48 +819,34 @@ static int sbs_get_battery_serial_number(struct i2c_client *client,
> >       return 0;
> >  }
> >
> > -static int sbs_get_property_index(struct i2c_client *client,
> > -     enum power_supply_property psp)
> > -{
> > -     int count;
> > -     for (count = 0; count < ARRAY_SIZE(sbs_data); count++)
> > -             if (psp == sbs_data[count].psp)
> > -                     return count;
> > -
> > -     dev_warn(&client->dev,
> > -             "%s: Invalid Property - %d\n", __func__, psp);
> > -
> > -     return -EINVAL;
> > -}
> > -
> > -static int sbs_get_chemistry(struct i2c_client *client,
> > +static int sbs_get_chemistry(struct sbs_info *chip,
> >               union power_supply_propval *val)
> >  {
> > -     enum power_supply_property psp = POWER_SUPPLY_PROP_TECHNOLOGY;
> > -     int ret;
> > +     const char *chemistry;
> >
> > -     ret = sbs_get_property_index(client, psp);
> > -     if (ret < 0)
> > -             return ret;
> > +     if (chip->technology >= POWER_SUPPLY_TECHNOLOGY_UNKNOWN)
> > +             return chip->technology;
>
> This obviously must look like this:
>
> val->intval = chip->technology;
> return 0;
>
> With your code you should only see correct technology for the
> first read of the technology property. How did you test your
> changes?

yeah, you're right. That's really a problem
and easily noticeable before sending ;-(
Let me test battery properties manually this time.

>
> > -     ret = sbs_get_battery_string_property(client, ret, psp,
> > -                                           chemistry);
> > -     if (ret < 0)
> > -             return ret;
> > +     chemistry = sbs_get_constant_string(chip, POWER_SUPPLY_PROP_TECHNOLOGY);
> > +
> > +     if (IS_ERR(chemistry))
> > +             return PTR_ERR(chemistry);
> >
> >       if (!strncasecmp(chemistry, "LION", 4))
> > -             val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
> > +             chip->technology = POWER_SUPPLY_TECHNOLOGY_LION;
> >       else if (!strncasecmp(chemistry, "LiP", 3))
> > -             val->intval = POWER_SUPPLY_TECHNOLOGY_LIPO;
> > +             chip->technology = POWER_SUPPLY_TECHNOLOGY_LIPO;
> >       else if (!strncasecmp(chemistry, "NiCd", 4))
> > -             val->intval = POWER_SUPPLY_TECHNOLOGY_NiCd;
> > +             chip->technology = POWER_SUPPLY_TECHNOLOGY_NiCd;
> >       else if (!strncasecmp(chemistry, "NiMH", 4))
> > -             val->intval = POWER_SUPPLY_TECHNOLOGY_NiMH;
> > +             chip->technology = POWER_SUPPLY_TECHNOLOGY_NiMH;
> >       else
> > -             val->intval = POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
> > +             chip->technology = POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
> >
> > -     if (val->intval == POWER_SUPPLY_TECHNOLOGY_UNKNOWN)
> > -             dev_warn(&client->dev, "Unknown chemistry: %s\n", chemistry);
> > +     if (chip->technology == POWER_SUPPLY_TECHNOLOGY_UNKNOWN)
> > +             dev_warn(&chip->client->dev, "Unknown chemistry: %s\n", chemistry);
> > +
> > +     val->intval = chip->technology;
> >
> >       return 0;
> >  }
> > @@ -857,6 +890,7 @@ static int sbs_get_property(struct power_supply *psy,
> >       int ret = 0;
> >       struct sbs_info *chip = power_supply_get_drvdata(psy);
> >       struct i2c_client *client = chip->client;
> > +     const char *str;
> >
> >       if (chip->gpio_detect) {
> >               ret = gpiod_get_value_cansleep(chip->gpio_detect);
> > @@ -882,7 +916,7 @@ static int sbs_get_property(struct power_supply *psy,
> >               break;
> >
> >       case POWER_SUPPLY_PROP_TECHNOLOGY:
> > -             ret = sbs_get_chemistry(client, val);
> > +             ret = sbs_get_chemistry(chip, val);
> >               if (ret < 0)
> >                       break;
> >
> > @@ -934,23 +968,12 @@ static int sbs_get_property(struct power_supply *psy,
> >               break;
> >
> >       case POWER_SUPPLY_PROP_MODEL_NAME:
> > -             ret = sbs_get_property_index(client, psp);
> > -             if (ret < 0)
> > -                     break;
> > -
> > -             ret = sbs_get_battery_string_property(client, ret, psp,
> > -                                                   model_name);
> > -             val->strval = model_name;
> > -             break;
> > -
> >       case POWER_SUPPLY_PROP_MANUFACTURER:
> > -             ret = sbs_get_property_index(client, psp);
> > -             if (ret < 0)
> > -                     break;
> > -
> > -             ret = sbs_get_battery_string_property(client, ret, psp,
> > -                                                   manufacturer);
> > -             val->strval = manufacturer;
> > +             str = sbs_get_constant_string(chip, psp);
> > +             if (IS_ERR(str))
> > +                     ret = PTR_ERR(str);
> > +             else
> > +                     val->strval = str;
> >               break;
> >
> >       case POWER_SUPPLY_PROP_MANUFACTURE_YEAR:
> > @@ -1097,6 +1120,7 @@ static int sbs_probe(struct i2c_client *client)
> >       psy_cfg.of_node = client->dev.of_node;
> >       psy_cfg.drv_data = chip;
> >       chip->last_state = POWER_SUPPLY_STATUS_UNKNOWN;
> > +     chip->technology = -1;
> >       mutex_init(&chip->mode_lock);
> >
> >       /* use pdata if available, fall back to DT properties,
>
> You need to invalidate the cached values when battery is unplugged,
> since a different battery may be attached afterwards.

Yes, correct,
I'll add the codes in sbs_update_presence() when !(is_present)
in v3, thanks again.

>
> -- Sebastian
