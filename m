Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1CF32F9ADD
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 08:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733253AbhARH7h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 02:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733246AbhARH7g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2021 02:59:36 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57A4C061573;
        Sun, 17 Jan 2021 23:58:55 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 36so3904470otp.2;
        Sun, 17 Jan 2021 23:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+pua5Gz7X03MCfazw2FMpdYgyIB67LM2COVuZ3gUxWQ=;
        b=lSnC3hR4eOjaRFlWfYoewkPPii7bue9M83B4abPBVFrXjO3lZvABE2N/QB11a7uV34
         kfHMcPKtUrNClOKYTPrPqN0e5h2GCUIrAPhIEKtFyTtYXlGTv4eregazSL9i7PbDU/g2
         TqYgt4jUGav/RCzJr7+oSzCuQZfJoRAEh0cw2L9nCijYsUXwOb2nYkU1dcxzXOGSGc0Z
         YAKno1alTvHsbZjbiOLnBzQ83e03uYIxKxsJmAA+v+T7aRwfKMjpTxYCbsdLMrGiJ+o1
         VP1cG9M3QixvKplVx6yvPP84z+3Eb+XEMP8G4EfX6fPXjs0aLkrWwJASMRo7R89O0Q11
         YcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+pua5Gz7X03MCfazw2FMpdYgyIB67LM2COVuZ3gUxWQ=;
        b=pyjjRvrrF/I1HyfPL8Q5HVUVEqxTGQIqk3AwA3Fj0GpMS7sn+xaW4kC8N+eeEYLxPf
         KW2pL0akA99KnGB2Jd8YpkU/RTUF07KGwy+wD3T82DSHZsqfmywKlwQ+Kz5EQFPysLZz
         oTj19axcHTh1LnDCwz0aZao5v3p2skgOH3k38NbROnHqy1J6QyWb73xjHk1A0UJdQmSQ
         fW+qYMDss+BDWbB2FIQ5sCzbvmN2QI5EVQMNIHaPgU14sTFt/D3H6sosRaOdQ8xzgCs6
         w7V9r3A4PkJY8lMzn/CGJI5MHM83L3H6KuC6fzEGPlmUrB+E8nHyuJUl4W+P5X3qBWrd
         2kUw==
X-Gm-Message-State: AOAM533NMIyBgNepC6g7YeYltFMtGyrSSYFr3trwoAikm0mhfTwsTlyo
        iMwvxvfDOBByQsqi1lwEoVVxue1yhX1eB9+ArFw=
X-Google-Smtp-Source: ABdhPJw374BOPOpd/HDhDTOJyhxewF5r8SqojbvvQxmCnOBYrtv7NQiYnhP1+TOW/VKrUdbqNGmJbKL+eJLlUanW/Wk=
X-Received: by 2002:a05:6830:160f:: with SMTP id g15mr16889598otr.129.1610956735299;
 Sun, 17 Jan 2021 23:58:55 -0800 (PST)
MIME-Version: 1.0
References: <1608796084-29418-1-git-send-email-gene.chen.richtek@gmail.com>
 <1608796084-29418-3-git-send-email-gene.chen.richtek@gmail.com>
 <20210106201654.lkmqorlgcecgqqkf@earth.universe> <CAE+NS37t-Gf7fjK0crZ+9qxWxfxm3k8hoEvwystdNP4CjM=KXQ@mail.gmail.com>
 <20210116101237.vktppv2ec7kvtz3v@earth.universe>
In-Reply-To: <20210116101237.vktppv2ec7kvtz3v@earth.universe>
From:   Gene Chen <gene.chen.richtek@gmail.com>
Date:   Mon, 18 Jan 2021 15:58:44 +0800
Message-ID: <CAE+NS34dKX+Zrzp3zzL2-NFvh7FrCUEminVT8jMBDOvS1ZQH9w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] power: supply: mt6360_charger: add MT6360 charger support
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gene Chen <gene_chen@richtek.com>, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, ChiYuan Huang <cy_huang@richtek.com>,
        benjamin.chao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sebastian Reichel <sebastian.reichel@collabora.com> =E6=96=BC 2021=E5=B9=B4=
1=E6=9C=8816=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=886:12=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> Hi,
>
> On Mon, Jan 11, 2021 at 08:15:33PM +0800, Gene Chen wrote:
> > Sebastian Reichel <sebastian.reichel@collabora.com> =E6=96=BC 2021=E5=
=B9=B41=E6=9C=887=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=884:16=E5=AF=
=AB=E9=81=93=EF=BC=9A
> > > > +     last_usb_type =3D mci->psy_usb_type;
> > > > +     /* Plug in */
> > > > +     ret =3D regmap_read(mci->regmap, MT6360_PMU_USB_STATUS1, &usb=
_status);
> > > > +     if (ret < 0)
> > > > +             goto out;
> > > > +     usb_status &=3D MT6360_USB_STATUS_MASK;
> > > > +     usb_status >>=3D MT6360_USB_STATUS_SHFT;
> > > > +     switch (usb_status) {
> > > > +     case MT6360_CHG_TYPE_UNDER_GOING:
> > > > +             dev_info(mci->dev, "%s: under going...\n", __func__);
> > > > +             goto out;
> > >
> > > IDK what this is supposed to tell me. Do you mean "detection in
> > > progress"? Also why is this info level? I would expect either
> > > debug (assuming it happens regularly and is normal) or warning
> > > (assuming it should not happen).
> > >
> >
> > When handling attach interrupt and cable plug out at the same
> > time, HW change register status. So we don' need to handle this
> > attach interrupt at this case.
>
> So this is basically for debouncing? I suggest adding a comment:
>
> /* Received attach IRQ followed by detach event, so nothing to do */
> dev_dbg(mci->dev, "under going...\n");
> goto out;
>

Sorry I have a little misunderstand.
under going is "detect in progress".
Attachi irq will trigger when power ready(vbus=3D5V) and bc12
chargedetection done.
Another irq, Detachi, is indicated power not ready(vbus=3D0V) and which
is be masked.
So, if the usb status is not SDP/NONSTD/CDP/DCP, the result can be
ignored. (e.q. NO VBUS/Under going/BC12 disabled/Reserved address)

> [...]
>
> > > > +     config.dev =3D &pdev->dev;
> > > > +     config.regmap =3D mci->regmap;
> > > > +     mci->otg_rdev =3D devm_regulator_register(&pdev->dev, &mt6360=
_otg_rdesc,
> > > > +                                             &config);
> > > > +     if (IS_ERR(mci->otg_rdev))
> > > > +             return PTR_ERR(mci->otg_rdev);
> > > > +
> > > > +     ret =3D mt6360_sysfs_create_group(mci);
> > > > +     if (ret) {
> > > > +             dev_err(&pdev->dev,
> > > > +                     "%s: Failed to create sysfs attrs\n", __func_=
_);
> > > > +             return ret;
> > > > +     }
> > >
> > > Use charger_cfg.attr_grp to register custom sysfs group for
> > > power-supply devices. Otherwise your code is racy (udev may not pick
> > > up the sysfs attributes). Also custom sysfs attributes need to be
> > > documented in Documentation/ABI/testing/sysfs-class-power-<driver>.
> > >
> > > Looking at the attributes you are planning to expose, I don't think t=
hey
> > > are suitable for sysfs anyways. Looks more like a debug interface, wh=
ich
> > > should go into debugfs instead. But it's hard to tell without any doc=
umentation
> > > being provided :)
> >
> > ACK, I will change to charger_cfg.attr_grp.
> > I assumed the charger algorithm thread is in user space, and take
> > control by sysfs node from charger device, like bq24190.c.
> > Should I change to debugfs?
>
> It's hard to tell without knowing more about the attributes
> your are trying to expose. In debugfs we have relaxed ABI rules,
> so it's easier to adopt naming e.t.c. later.
>

I briefly classify the whole attributes. There are either unused, or
can be replaced by POWER_SUPPLY PROPERTY,
so I will remove unuse part.

HIZ =3D VBUS_IN high impedance mode.
VMIVR =3D Maximum input voltage regulation. Let input power can provide
at the predetermined voltage level.
(like POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT)
SYSREG =3D Config system minimum regulation voltage.
OTG_OC =3D maximum current of battery boost OTG 5V.
ICHG =3D maximum Charging current. (like
POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT)
IEOC =3D Like POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT
VOREG =3D Input voltage regulation. (like
POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE)
LBP =3D Low battery protection for battery boost OTG 5V.
VPREC =3D Pre-charge volatge level. (maybe can add new prop
POWER_SUPPLY_PROP_PRECHARGE_VOLTAGE)
TE =3D Charge termination enable/disable.
CHG_WDT_EN =3D Charger Watch dog timer enable/disable.
CHG_WDT =3D Charger Watch dog timer, 8/40/80/160s.
WT_FC =3D Fast charge Timer, 4~20hr.
BAT_COMP =3D Battery IR compensation resistor setting.
VCLAMP =3D Battery IR compensation maximum voltage clamp.
USBCHGEN =3D USB charger detection flow enable/disable.
CHG_EN =3D Battery charging enable/disable.
CHRDET_EXT =3D VBUS_IN is between VBUS_UV_TH(3.7V) and VBUS_OV_TH(10.5V)

> -- Sebastian
