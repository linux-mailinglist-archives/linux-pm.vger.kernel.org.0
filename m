Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FC34507C5
	for <lists+linux-pm@lfdr.de>; Mon, 15 Nov 2021 16:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhKOPFS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Nov 2021 10:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhKOPFS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Nov 2021 10:05:18 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62642C061570;
        Mon, 15 Nov 2021 07:02:19 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id np3so13074323pjb.4;
        Mon, 15 Nov 2021 07:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d8PXUffPazSmYKKzNF/TGrdTUsuiK6Ny9wBNo2wwLbI=;
        b=ZLjifqPVgG2iMUclzUkQFWnuYLDCosIK2s/DssPdmERUSiTTyhAQ2r9NczmX/DfRsJ
         9uR/8NQOuM/qTdRd3gWcldBpnB1BtEkmf1PLyijjoRkYcvWVV7nV0VQHG2CoNXHp7/dA
         e7+F0echaqpDANjSaIY8bpLY/q0wDIrsl86hDhhpnqPHPZnsP+XPEGfwSY05RZyXncKs
         gK0g/QXWpzAD5PqJq65HQ+LfFhyGS8Cq+0hZKEoIRB9UFzyT2TEghyZBnYzN2CwL2m6G
         TMRMaygYLovpTe3J+CoTHQt5mRAMgZ93E3/LJt917HDy3+cCf/vmSbCNFO6tXDu96i5W
         4Xgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d8PXUffPazSmYKKzNF/TGrdTUsuiK6Ny9wBNo2wwLbI=;
        b=Q/yRsVk+749oTPkHMkf3nwKRNz6PcOML/BgEGng86fLLwFSlcsclYpkSi+MyAv2epL
         gOhDr4F8ScVg9f4TwECeKcTnlaXdFvBnukaT2GG3sHQ2Zsz52oT2C22STNy9/OmjngFz
         lpQ7PKAvFSyk8p4pvVKBDrCOWvOLh1afTWkli/2xbPm0ua1D8Vph00efzkGaVpIn56gm
         BLd1xaXs1ImPdtShp+t2WAtcU3kuHNUHFU8ibJQ9Zv9aCYtz/LNzsy75evotVRBohBA5
         ulD3/KBEAM06JJwU9Pqy3mbvo6ozJfuMrjkFpWph6edi6G+YAG3eww+Iq72uoCaJsjiA
         m6FQ==
X-Gm-Message-State: AOAM531LIWoZNEFKCyr0W2X9kpXSLkqW3uFZAGIX5Ra1/T5Z7YqCQAHF
        TQ5bIKVF97lRhNoITAfd9EH1sx9WV2UfWUzhnqQ=
X-Google-Smtp-Source: ABdhPJwkHtTTW3ES4uV67rzJ33QwTWk2CJ0+UlwIlbg7igYYS/+l83BQ0mb2AQZ2n9xhwKLRKCLDbQScz2TG7PWmHOs=
X-Received: by 2002:a17:90a:7481:: with SMTP id p1mr26437282pjk.169.1636988538858;
 Mon, 15 Nov 2021 07:02:18 -0800 (PST)
MIME-Version: 1.0
References: <20211019130809.21281-1-o.rempel@pengutronix.de>
 <20211020050459.GE16320@pengutronix.de> <CAPwXO5b=z1nhQCo55A_XuK-Es2o7TrL2Vj6AkRSXa3Wxh0s8sA@mail.gmail.com>
 <20211021172048.GE2298@pengutronix.de> <CAPwXO5bWoAvZgQLQHa6CsFmZ2bcUQ9pJQBBL3F+goppMeAKkFQ@mail.gmail.com>
 <8692108c-1b46-3d3d-6911-300ac27c2980@ysoft.com> <20211111091627.GG12195@pengutronix.de>
In-Reply-To: <20211111091627.GG12195@pengutronix.de>
From:   Petr Benes <petrben@gmail.com>
Date:   Mon, 15 Nov 2021 16:02:07 +0100
Message-ID: <CAPwXO5anM809k+wuSYU9LR9vLAyutaMNo6kceCHOZHPmZUbnUw@mail.gmail.com>
Subject: Re: [PATCH v2] thermal: imx: implement runtime PM support
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Amit Kucheria <amitk@kernel.org>, linux-kernel@vger.kernel.org,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Oleksij,

On Thu, 11 Nov 2021 at 10:16, Oleksij Rempel <o.rempel@pengutronix.de> wrot=
e:
>
> On Wed, Nov 10, 2021 at 11:07:31AM +0100, Michal Vok=C3=A1=C4=8D wrote:
> > On 25. 10. 21 13:06, Petr Benes wrote:
> > > Hi Oleksij,
> > >
> > > On Thu, 21 Oct 2021 at 19:21, Oleksij Rempel <o.rempel@pengutronix.de=
> wrote:
> > > >
> > > > Hi Petr,
> > > >
> > > > On Wed, Oct 20, 2021 at 05:53:03PM +0200, Petr Benes wrote:
> > > > > On Wed, 20 Oct 2021 at 07:05, Oleksij Rempel <o.rempel@pengutroni=
x.de> wrote:
> > > > > >
> > > > > > Hi Petr and Michal,
> > > > > >
> > > > > > I forgot to add you for v2 in CC. Please test/review this versi=
on.
> > > > >
> > > > > Hi Oleksij,
> > > > >
> > > > > It works good. with PM as well as without PM. The only minor issu=
e I found is,
> > > > > that the first temperature reading (when the driver probes) fails=
. That is
> > > > > (val & soc_data->temp_valid_mask) =3D=3D 0) holds true. How does
> > > > > pm_runtime_resume_and_get() behave in imx_thermal_probe()?
> > > > > Does it go through imx_thermal_runtime_resume() with usleep_range=
()?
> > > >
> > > > How exactly did you reproduce it? Even more or less understanding h=
ow
> > >
> > > I just placed my debug print into get_temp()
> > >
> > >      if ((val & soc_data->temp_valid_mask) =3D=3D 0) {
> > >          dev_dbg(&tz->device, "temp measurement never finished\n");
> > >          printk("Wrong temperature reading!!!!!!\n");
> > >          return -EAGAIN;
> > >      }
> > >
> > > > this can potentially happen, i never had this issue on my HW. Is it=
 something
> > > > HW specific?
> > >
> > > IMHO it is just product of the following sequence:
> > >
> > > pm_runtime_set_active(&pdev->dev);
> > > pm_runtime_enable(data->dev);
> > > pm_runtime_resume_and_get(data->dev);
> > > thermal_zone_device_enable(data->tz);
> > >
> > > With assumption imx_thermal_runtime_resume() didn't run,
> > > hence the sensor didn't get enough time to come up.
> > >
> > > I didn't have time to spend it on and you have better knowledge of th=
e
> > > area. If it is not that straightforward I can try to diagnose it bett=
er.
> > >
> > Hi Oleksij,
> > Did you manage to further debug and reproduce this problem?
> > Do you plan to send the v3?
> >
> > Regarding your question about the HW - this problem occured once we
> > upgraded the SoC on our SBC from i.MX6DL to i.MX6Q/QP. With the DualLit=
e
> > we never had this problem but the Quad is getting hot quite fast.
> > We have pretty limited cooling options so the core is operated at its
> > upper temperature limits when fully loaded.
>
> Hi Michal,
>
> Sorry, I was busy and lost this topic from my radar. I was not able to
> reproduce it on my i.MX6Q and i.MX6QP died after other thermal voltage
> experiments. Please, if you able to reproduce it, try to investigate
> what is wrong, for example increasing wakeup time and/or and tracing
> sleap/wake/get sequences.

Seems it is just as easy as calling usleep_range(20, 50) when you switch on
the sensor and enable temperature measurement in imx_thermal_probe().
So, we are sure the sensor is configured and _ready_.

You call pm_runtime_set_active(), pm_runtime_enable(), and
pm_runtime_resume_and_get(). The last one doesn't call the resume
callback (which correctly handles waiting for the sensor) as the device
is already active.

On some SoCs the timing leads to a failure of the temperature readout
in thermal_zone_device_enable() which follows. I've seen it on i.MX6DL,
but cannot reproduce it on i.MX6QP for example.

Regards,
Petr

>
> Regards,
> Oleksij
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  =
|
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|
