Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391DB45A24E
	for <lists+linux-pm@lfdr.de>; Tue, 23 Nov 2021 13:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbhKWMRx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Nov 2021 07:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbhKWMRw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Nov 2021 07:17:52 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184D5C061574;
        Tue, 23 Nov 2021 04:14:45 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id j21so15902009ila.5;
        Tue, 23 Nov 2021 04:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f9GFnRwWoXBmF4GPMU/rzKtvEAldcHlqSbusbFwUFqY=;
        b=kAiQZnjFCNDdgBwpOztH/CvVmZYXCBl/D7sHJ3yPz8+rgdyavhtsFH/Ib0Q0094Nde
         Vglw4BrfnMDiiCxXJi0vO/TBeab/PBQeQBq29NMgLU7ndJHIoXEeFPDaJzVTfMHhFh6Y
         YilASjAv1TzlWksfAaU5hskYljxzA7JJ/DaUoZtzeaPXdr8T1mQ6yvNdFmke12bJ8LCZ
         aqkB5gp5Ji2JRoE6E94t3IgRhikhtaJ3SKvNOARKDErc9AJqv0dNFGSfOttoCg4MqVql
         y2rbCCabtBg7EHPQ+ODZmN35SlyR2jW2Q9XVMGgElxcLKKEIXqAVjvKZmcIuKMbSUGui
         k+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f9GFnRwWoXBmF4GPMU/rzKtvEAldcHlqSbusbFwUFqY=;
        b=jR+lAWBOh2z6QDytReuH0iUy/17BhgvpM79UelqLuKiDsKIntO+5agD0UFT0MaboDJ
         0SysBisvxQ15vrWc6hgcfAf1FDDdhvN2SfSaKFzBmN8QaXeknf26ZaJpyIuFmPSgmmYt
         EZh0FIVKFI/2MkuCcn3X3jKgI+yo9pr2RFKcsQg5skMmUhm0URHdL/qHiT2Cyzr98wiW
         aiSOh0yz9N7sM7gtjbkbzuXfOhcWUmPVaaUBDRuuKMxx4O7ybxnkaTIgk7Y/pGjrYgkf
         LZCYl99XkvPcO3Vn2od6DE8w591Qdiu+25YzLVrBuBYzdiIM9rdvr/IDwtmbsspHpAe2
         RDBA==
X-Gm-Message-State: AOAM533dv2Ta+quZcp1mUKxnSuULcBf5llK24sOylq4F/lXxe40lQGkE
        67nf7/xntwgsZPcP6yxLzFw4Tk585P5vNesVT+c=
X-Google-Smtp-Source: ABdhPJx9TQeKsP1u1QKlJCOgX7KT/SYyb/hAXIeZLaKSrVvgSCVbY0urc8cCUPV27gN0Gkdbmsq6LFMM5G9/hfkuAH8=
X-Received: by 2002:a05:6e02:1b08:: with SMTP id i8mr4125997ilv.74.1637669684337;
 Tue, 23 Nov 2021 04:14:44 -0800 (PST)
MIME-Version: 1.0
References: <20211110122948.188683-1-alistair@alistair23.me>
 <20211110122948.188683-4-alistair@alistair23.me> <20211116000634.767dcdc0@aktux>
In-Reply-To: <20211116000634.767dcdc0@aktux>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Tue, 23 Nov 2021 22:14:18 +1000
Message-ID: <CAKmqyKPFOqWD7t6tC1Act97CVcY+yazrhwMLLr3j_wOyH50GTA@mail.gmail.com>
Subject: Re: [PATCH v15 3/8] mfd: simple-mfd-i2c: Enable support for the silergy,sy7636a
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>, lgirdwood@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rui.zhang@intel.com, devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-hwmon@vger.kernel.org, amitk@kernel.org,
        linux-pm@vger.kernel.org, dl-linux-imx <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 16, 2021 at 9:10 AM Andreas Kemnade <andreas@kemnade.info> wrote:
>
> Hi,
>
> this all creates a lot of question marks...
> One of my main question is whether sy7636a = sy7636 (at least the
> driver in the kobo vendor kernels does not have the "A" at the end,
> whic does not necessarily mean a difference).
>
> https://www.silergy.com/products/panel_pmic
> lists only a SY7636ARMC, so chances are good that the letters were just
> stripped away by the driver developers. Printing on chip package is
> cryptic so it is not that helpful. It is just "BWNBDA"

I don't have a definite answer for you. But I think it's sy7636a

The page you linked to above lists SY7636ARMC as well as SY7627RMC,
SY7570RMC. That makes me think that the RMC is a generic suffix and
this actual IC is the SY7636A.

>
>  On Wed, 10 Nov 2021 22:29:43 +1000
> Alistair Francis <alistair@alistair23.me> wrote:
>
> [...]
> > diff --git a/include/linux/mfd/sy7636a.h b/include/linux/mfd/sy7636a.h
> > new file mode 100644
> > index 000000000000..2797c22dabc2
> > --- /dev/null
> > +++ b/include/linux/mfd/sy7636a.h
> > @@ -0,0 +1,36 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Functions to access SY3686A power management chip.
>
> Typo? or is it really a SY3686A? So what we are talking about?

I think it's SY7636A

>
> > + *
> > + * Copyright (C) 2021 reMarkable AS - http://www.remarkable.com/
> > + */
> > +
> > +#ifndef __MFD_SY7636A_H
> > +#define __MFD_SY7636A_H
> > +
> > +#define SY7636A_REG_OPERATION_MODE_CRL               0x00
> > +#define SY7636A_OPERATION_MODE_CRL_VCOMCTL   BIT(6)
>
> hmm, this thing is called VCOM_MANUAL in the 4.1.15-based driver for the
> Kobos and in the 3.0.35 kernel for the Tolinos it is:
>
> // 1:controll the vcom by external VCOM_EN pin
> #define SY7636_REG_OPM_VCOM_EXT_mask    0x1 //
> #define SY7636_REG_OPM_VCOM_EXT_lsb             6 //
>
> In both kernels, it is set if a gpio is used to control the regulator.
> That does not necessarily conflict with your usage. The gpio might just
> be hardwired to something in your device. Maybe just a comment about
> that issue.

Ok, I'll add a comment.

>
> > +#define SY7636A_OPERATION_MODE_CRL_ONOFF     BIT(7)
> > +#define SY7636A_REG_VCOM_ADJUST_CTRL_L               0x01
> > +#define SY7636A_REG_VCOM_ADJUST_CTRL_H               0x02
> > +#define SY7636A_REG_VCOM_ADJUST_CTRL_MASK    0x01ff
> > +#define SY7636A_REG_VLDO_VOLTAGE_ADJULST_CTRL        0x03
> > +#define SY7636A_REG_POWER_ON_DELAY_TIME              0x06
> > +#define SY7636A_REG_FAULT_FLAG                       0x07
> > +#define SY7636A_FAULT_FLAG_PG                        BIT(0)
> > +#define SY7636A_REG_TERMISTOR_READOUT                0x08
> > +
> > +#define SY7636A_REG_MAX                              0x08
> > +
> > +#define VCOM_MIN             0
> > +#define VCOM_MAX             5000
>
> hmm, what does that maximum mean? What you can set without something
> freaking out just by setting it? Or the limit where the driver works
> reliably?

Good question. This is unused so I have just removed it.

> > +
> > +#define VCOM_ADJUST_CTRL_MASK        0x1ff
> > +// Used to shift the high byte
> > +#define VCOM_ADJUST_CTRL_SHIFT       8
> > +// Used to scale from VCOM_ADJUST_CTRL to mv
> > +#define VCOM_ADJUST_CTRL_SCAL        10000
> > +
> > +#define FAULT_FLAG_SHIFT     1
> > +
> > +#endif /* __LINUX_MFD_SY7636A_H */
>
> Hmm, are that all defines you know about? I am fine with not including
> unused things now, but I am curious.

Yep, this is all that I currently have information on.

> For comparison, here is my "scratchpad" of all the information I could
> squeeze out of the sy7636 driver until now:
>
> OPMODE 0
>   RAILS_ON 7
>   VCOM_MANUAL 6
>   LIGHTNESS 5
>
>   VDDH_DISABLE 4
>   VEE_DISABLE 3
>   VPOS_DISABLE 2
>   VNEG_DISABLE 1
>   VCOM_DISABLE 0
>
>   -> combined as RAILS_DISABLE in code
>
>   VCOM: 10000 uV per step, accepts up to 2.75V (that is a bit contradictory)
> VCOM_ADJ1 1
>
> VCOM_ADJ2 2
>   VCOM2_B8 7
>   VDDH_EXT 0..4
>
> VLDO_ADJ 3
>   VLDO_ADJ = 5..7
>   VPDD_ADJ = 0..4
>
> VPDD_LEN 4
>   VPPD_LEN 0..4
>
> VEE_VP_EXT 5
>   VP_EXT 5..6
>   VEE_EXT 0..4
>
> PWRON_DLY = 6
>   TDLY4 = 6..7
>   TDLY3 = 4..5
>   TDLY2 = 2..3
>   TDLY1 = 0..1
>
> FAULTFLAGS 7
>   FAULS 1..4: to be read out after interrupt and cleared
>       0  no faults
>       1  UVP at VB rail
>       2  UVP at VN rail
>       3  UVP at VPOS rail
>       4  UVP at VNEG rail
>       5  UVP at VDDH rail
>       6  UVP at VEE rail
>       7  SCP at VB rail
>       8  SCP at VN rail
>       9  SCP at VPOS rail
>       A  SCP at VNEG rail
>       B  SCP at VDDH rail
>       C  SCP at VEE rail
>       D  SCP at VCOM rail
>       E  UVLO
>       F  Thermal shutdown
>
>   PG 0
>
> THERM 8

Cool!

Alistair

>
> Regards,
> Andreas
