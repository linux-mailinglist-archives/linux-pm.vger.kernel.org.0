Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4E5130C06
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 03:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgAFCWO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Jan 2020 21:22:14 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35296 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbgAFCWO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Jan 2020 21:22:14 -0500
Received: by mail-ed1-f65.google.com with SMTP id f8so2706500edv.2;
        Sun, 05 Jan 2020 18:22:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=guWV4kowMxOih1kRoF7JAZaHs8K4xRnf2iN9iTMDP9w=;
        b=qnxdRGO+fv/xCS3EZTVV3Y2GAV7PdSya2EJgT3sBqJZLlNh+EBeunm8GJbDTSaRBsy
         3AHnF15r4Hsmihz8FDYHZ6yY1I14D+lywYmEFmgScX2gyCSldFRKqmK8PLdapDX/VXAV
         GtWONecXCtUJodgC82cVNa+nn66u2AelEuduPgka+xLOPYz8rkt6oKnTepyQfrB3pNcP
         NH719A7adNpDIjyxmsmCHLOpzXLUDmXOdZDj0uOoJNiTCMRvNXcmqYJF2Yod8Sc8XE6Z
         +t17tOlpXKVaZP8gfWwIZWgE31AHchkZUTAnDgZQIIQxD0q2nF3DUcJaRdZ9wqZ7uZAl
         ZmJQ==
X-Gm-Message-State: APjAAAWSS81WCWjxgf5MvYXIP+MoMZC83a7y4PnPBgM3ntoB7WxohmPX
        NtsSG8T9bFr5ymFeLxJszh0ALLkadVA=
X-Google-Smtp-Source: APXvYqx/MAagoSOZDQpMIp9OvTD26492+zSgOMCGmQnSSTFj79X+Fgy4PuxbXg455HYxXtkZ2+wLtA==
X-Received: by 2002:a17:906:934c:: with SMTP id p12mr103897536ejw.68.1578277331679;
        Sun, 05 Jan 2020 18:22:11 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id r19sm7851309ejr.33.2020.01.05.18.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jan 2020 18:22:11 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id w15so35485138wru.4;
        Sun, 05 Jan 2020 18:22:11 -0800 (PST)
X-Received: by 2002:a5d:6b88:: with SMTP id n8mr82174248wrx.288.1578277331005;
 Sun, 05 Jan 2020 18:22:11 -0800 (PST)
MIME-Version: 1.0
References: <20200105012416.23296-1-samuel@sholland.org> <20200105012416.23296-8-samuel@sholland.org>
 <CAGb2v67esqWZnKa8QNQAp8w-fhN+hM=zO9kUdzO9vFgr0FbfEQ@mail.gmail.com> <f0c5e260-dcc3-2744-21cd-305e4534f2be@sholland.org>
In-Reply-To: <f0c5e260-dcc3-2744-21cd-305e4534f2be@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 6 Jan 2020 10:22:01 +0800
X-Gmail-Original-Message-ID: <CAGb2v66-G5PxvMHdOmLiGGiv4KQJM9nTAEeMKH6D5DCnO7jr3g@mail.gmail.com>
Message-ID: <CAGb2v66-G5PxvMHdOmLiGGiv4KQJM9nTAEeMKH6D5DCnO7jr3g@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2 7/9] power: supply: axp20x_usb_power:
 Allow offlining
To:     Samuel Holland <samuel@sholland.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 6, 2020 at 1:47 AM Samuel Holland <samuel@sholland.org> wrote:
>
> On 1/5/20 4:40 AM, Chen-Yu Tsai wrote:
> > On Sun, Jan 5, 2020 at 9:24 AM Samuel Holland <samuel@sholland.org> wrote:
> >>
> >> AXP803/AXP813 have a flag that enables/disables the USB power supply
> >> input. Allow control of this flag via the ONLINE property on those
> >> variants.
> >>
> >> It may be necessary to offline the USB power supply input when using
> >> the USB port in OTG mode, or to allow userspace to disable charging.
> >
> > Any idea how the former would be implemented? AFAIK this isn't allowed
> > right now.
>
> Pinephone currently has AXP N_VBUSEN/DRIVEVBUS floating, so the hardware doesn't
> automatically disable the VBUS path when enabling the boost regulator driving
> it. This doubles the current draw from the battery.
>
> The USB PHY driver would need to call:
>
>     union power_supply_propval val = { .intval = false };
>     power_supply_set_property(data->vbus_power_supply,
>                               POWER_SUPPLY_PROP_ONLINE, &val);
>
> or similar to set VBUS offline in sun4i_usb_phy_power_on(), and set it back
> online in sun4i_usb_phy_power_off().

Ah, OK. That's a valid use case. I had something else in mind, the OTG host
mode with charger one.

> > As for disabling charging, wouldn't it make more sense to disable the
> > charger?
>
> Yes, I see now that there's a bit at 33H[7] for this. I don't see an obvious
> property to hook it up to, though. Maybe POWER_SUPPLY_PROP_CHARGE_TYPE ==
> POWER_SUPPLY_CHARGE_TYPE_NONE?

Maybe? I suppose the sysfs ABI docs would have some clues.

> > Either way, these are not directly related to the changes. I'm just curious.
> >
> >> When the USB VBUS input is disabled via the PATH_SEL bit, the VBUS_USED
> >> bit in PWR_INPUT_STATUS is cleared, so there is no change needed when
> >> getting the property.
> >>
> >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >> ---
> >>  drivers/power/supply/axp20x_usb_power.c | 27 +++++++++++++++++++++++++
> >>  1 file changed, 27 insertions(+)
> >>
> >> diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
> >> index 2d7272e19a87..68443f264dff 100644
> >> --- a/drivers/power/supply/axp20x_usb_power.c
> >> +++ b/drivers/power/supply/axp20x_usb_power.c
> >> @@ -29,6 +29,9 @@
> >>
> >>  #define AXP20X_USB_STATUS_VBUS_VALID   BIT(2)
> >>
> >> +#define AXP20X_VBUS_PATH_SEL           BIT(7)
> >> +#define AXP20X_VBUS_PATH_SEL_OFFSET    7
> >> +
> >>  #define AXP20X_VBUS_VHOLD_uV(b)                (4000000 + (((b) >> 3) & 7) * 100000)
> >>  #define AXP20X_VBUS_VHOLD_MASK         GENMASK(5, 3)
> >>  #define AXP20X_VBUS_VHOLD_OFFSET       3
> >> @@ -263,6 +266,16 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
> >>         return 0;
> >>  }
> >>
> >> +static int axp813_usb_power_set_online(struct axp20x_usb_power *power,
> >> +                                      int intval)
> >> +{
> >> +       int val = !intval << AXP20X_VBUS_PATH_SEL_OFFSET;
> >> +
> >> +       return regmap_update_bits(power->regmap,
> >> +                                 AXP20X_VBUS_IPSOUT_MGMT,
> >> +                                 AXP20X_VBUS_PATH_SEL, val);
> >> +}
> >> +
> >>  static int axp20x_usb_power_set_voltage_min(struct axp20x_usb_power *power,
> >>                                             int intval)
> >>  {
> >> @@ -344,6 +357,9 @@ static int axp20x_usb_power_set_property(struct power_supply *psy,
> >>         struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
> >>
> >>         switch (psp) {
> >> +       case POWER_SUPPLY_PROP_ONLINE:
> >> +               return axp813_usb_power_set_online(power, val->intval);
> >> +
> >
> > I would add a comment here pointing to the next change as to why there's
> > only an axp813-specific callback used here.
>
> I'll add this for v3.

Thanks
ChenYu

> >>         case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> >>                 return axp20x_usb_power_set_voltage_min(power, val->intval);
> >>
> >> @@ -363,6 +379,17 @@ static int axp20x_usb_power_set_property(struct power_supply *psy,
> >>  static int axp20x_usb_power_prop_writeable(struct power_supply *psy,
> >>                                            enum power_supply_property psp)
> >>  {
> >> +       struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
> >> +
> >> +       /*
> >> +        * Both AXP2xx and AXP8xx have a VBUS path select flag.
> >> +        * On AXP2xx, setting the flag enables VBUS (ignoring N_VBUSEN).
> >> +        * On AXP8xx, setting the flag disables VBUS (ignoring N_VBUSEN).
> >> +        * So we only expose the control on AXP8xx where it is meaningful.
> >> +        */
> >> +       if (psp == POWER_SUPPLY_PROP_ONLINE)
> >> +               return power->axp20x_id == AXP813_ID;
> >> +
> >>         return psp == POWER_SUPPLY_PROP_VOLTAGE_MIN ||
> >>                psp == POWER_SUPPLY_PROP_CURRENT_MAX;
> >>  }
> >> --
> >
> > Otherwise,
> >
> > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> >
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/f0c5e260-dcc3-2744-21cd-305e4534f2be%40sholland.org.
