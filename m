Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFF02E9297
	for <lists+linux-pm@lfdr.de>; Mon,  4 Jan 2021 10:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbhADJ2m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jan 2021 04:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbhADJ2m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jan 2021 04:28:42 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F040C061794
        for <linux-pm@vger.kernel.org>; Mon,  4 Jan 2021 01:28:01 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id e15so14183987vsa.0
        for <linux-pm@vger.kernel.org>; Mon, 04 Jan 2021 01:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ExeHQWgqTKzH+DZSpsOqxVJU7/CNUO5Q/p82stk7PJg=;
        b=X/Gi1auS3Z+zUYZURdGr75NeBrHpMm88ga/jDKcAnCz36LUKhNeJ0M3y88x8ecm4aW
         jb4mF6EA6DYbILrCj8jk9pSE8WoyyMlSKbaZ7dPLlDioDHoVbnXORu5975RR0wGdbP/f
         UiRWu0Iw93RxoFRjm8IrYO2fT7jyTbN6hNPks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ExeHQWgqTKzH+DZSpsOqxVJU7/CNUO5Q/p82stk7PJg=;
        b=TXYF8iuV/HvEfAteEOxhrDNapqxx3bJy/L0nvmGK2Y/yWMN0IAdxZdzXaIrjGpdiNF
         M2QvKUgJXW/0OaJ2UDwj9Thpwhx7bqUtTronmqFZ1IS0MnQ3jPjF/OU68QVBNfsd8ZwD
         y7qbljMK6oGKx69RDCNBSWvoJkEsCb24A5C5/nmEcfa5/gKmeWWFU/iQ21NMkVedZyC4
         bIaafvmzsL3MRyA6l3nMCz9IgdWKatj1QBi9rEqXZdiHyULTTPXbbLaibu5hrW8bvNC+
         gvhysCjIoySVLhclZryT4UeMmzmyssrZw/lA/Wqxu4MW76swPyAO/Fe5kzd+Eb4y6Eia
         OxrA==
X-Gm-Message-State: AOAM5319NqzSxzj16h2TyADuv7S0YZk+tFWsigfraDp20ajyxIsZmS7T
        ZsA2sOSbanYkmiG/lCLFcQ9dsaKNK+GM/oYi0FWEpg==
X-Google-Smtp-Source: ABdhPJyF2xBh5X4KryFT0WGdabrZwrmbRW9n5pz8Ld0ZfllL2ZL5QKd1r3/IEp7q8KkK01cJ6iv5O7LHMnae2yoQXKE=
X-Received: by 2002:a67:5c03:: with SMTP id q3mr43046284vsb.47.1609752480656;
 Mon, 04 Jan 2021 01:28:00 -0800 (PST)
MIME-Version: 1.0
References: <20201227105449.11452-1-roger.lu@mediatek.com> <20201227105449.11452-4-roger.lu@mediatek.com>
 <CANMq1KBNKy708Vz67WOc+n7V7ne4L1EZVkUVGj6abd5voxKjxA@mail.gmail.com> <1609750266.20758.40.camel@mtksdaap41>
In-Reply-To: <1609750266.20758.40.camel@mtksdaap41>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 4 Jan 2021 17:27:49 +0800
Message-ID: <CANMq1KDxVLo=JAAq-gjybke1WiX03COwNX7sHsZDMF9USzSECw@mail.gmail.com>
Subject: Re: [PATCH v10 3/7] [v10, 3/7]: soc: mediatek: SVS: introduce MTK SVS engine
To:     Roger Lu <roger.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, Angus Lin <Angus.Lin@mediatek.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>, Fan Chen <fan.chen@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 4, 2021 at 4:51 PM Roger Lu <roger.lu@mediatek.com> wrote:
>
>
> Hi Nicolas,
>
> Thanks for all the advices.
>
> On Thu, 2020-12-31 at 10:10 +0800, Nicolas Boichat wrote:
> > On Sun, Dec 27, 2020 at 6:55 PM Roger Lu <roger.lu@mediatek.com> wrote:
[snip]
> > > +static int svs_adjust_pm_opp_volts(struct svs_bank *svsb, bool force_update)
> > > +{
> > > +       int tzone_temp, ret = -EPERM;
> >
> > No need to initialize ret.
>
> Oh, excuse me, some coding check tool warn that this `ret` might return
> without being uninitialized. Therefore, I'll keep the initialization.

Oh, you're right, there is a possible path where ret is not set. sgtm then.

>
> >
> > > +       u32 i, svsb_volt, opp_volt, temp_offset = 0;
> > > +
> > > +       mutex_lock(&svsb->lock);
> > > +
> > > +       /*
> > > +        * If svs bank is suspended, it means signed-off voltages are applied.
> > > +        * Don't need to update opp voltage anymore.
> > > +        */
> > > +       if (svsb->suspended && !force_update) {
> > > +               dev_notice(svsb->dev, "bank is suspended\n");
> > > +               ret = -EPERM;
> > > +               goto unlock_mutex;
> > > +       }
> > > +
> > > +       /* Get thermal effect */
> > > +       if (svsb->phase == SVSB_PHASE_MON) {
> > > +               if (svsb->temp > svsb->temp_upper_bound &&
> > > +                   svsb->temp < svsb->temp_lower_bound) {
> > > +                       dev_warn(svsb->dev, "svsb temp = 0x%x?\n", svsb->temp);
> > > +                       ret = -EINVAL;
> > > +                       goto unlock_mutex;
> > > +               }
> > > +
> > > +               ret = svs_get_bank_zone_temperature(svsb->tzone_name,
> > > +                                                   &tzone_temp);
> > > +               if (ret) {
> > > +                       dev_err(svsb->dev, "no \"%s\"?(%d)?\n",
> > > +                               svsb->tzone_name, ret);
> > > +                       dev_err(svsb->dev, "set signed-off voltage\n");
> >
> > Please merge the error message in one line (I'm not sure what "set
> > signed-off voltage" means here).
>
> 1. Ok, I'll merge them. Thanks.
> 2. signed-off voltages means CPU DVFS default voltages

So just write "default voltages" then? ,-)

>
> >
[snip]
> > > +static irqreturn_t svs_isr(int irq, void *data)
> > > +{
> > > +       struct svs_platform *svsp = (struct svs_platform *)data;
> >
> > cast not needed.
>
> Ok, I'll remove it. Thanks.
>
> >
> > > +       struct svs_bank *svsb = NULL;
> > > +       unsigned long flags;
> > > +       u32 idx, int_sts, svs_en;
> > > +
> > > +       for (idx = 0; idx < svsp->bank_num; idx++) {
> > > +               svsb = &svsp->banks[idx];
> > > +
> > > +               spin_lock_irqsave(&mtk_svs_lock, flags);
> > > +               svsp->pbank = svsb;
> > > +
> > > +               /* Find out which svs bank fires interrupt */
> > > +               if (svsb->int_st & svs_readl(svsp, INTST)) {
> > > +                       spin_unlock_irqrestore(&mtk_svs_lock, flags);
> > > +                       continue;
> > > +               }
> > > +
> > > +               if (!svsb->suspended) {
> > > +                       svs_switch_bank(svsp);
> > > +                       int_sts = svs_readl(svsp, INTSTS);
> > > +                       svs_en = svs_readl(svsp, SVSEN);
> > > +
> > > +                       if (int_sts == SVSB_INTSTS_COMPLETE &&
> > > +                           ((svs_en & SVSB_EN_MASK) == SVSB_EN_INIT01))
> > > +                               svs_init01_isr_handler(svsp);
> > > +                       else if ((int_sts == SVSB_INTSTS_COMPLETE) &&
> > > +                                ((svs_en & SVSB_EN_MASK) == SVSB_EN_INIT02))
> > > +                               svs_init02_isr_handler(svsp);
> > > +                       else if (!!(int_sts & SVSB_INTSTS_MONVOP))
> >
> > !! is not required.
>
> Ok, I'll remove it. Thanks.
>
> >
> > > +                               svs_mon_mode_isr_handler(svsp);
> > > +                       else
> > > +                               svs_error_isr_handler(svsp);
> > > +               }
> > > +
> > > +               spin_unlock_irqrestore(&mtk_svs_lock, flags);
> > > +               break;
> > > +       }
> >
> > This will panic if svsb is NULL, is that ok or do you want to catch that?
>
> Oh, it is fine. Thanks for the heads-up.

I should have been stronger in my statement, I think you want to add a
BUG_ON(!svsb) to crash in a slightly more predictable manner.

[snip]
> > > +
> > > +       svsp->tefuse = (u32 *)nvmem_cell_read(cell, &svsp->tefuse_num);
> >
> > Cast not needed.
>
> Ok, I'll remove it if build/test ok. Because nvmem_cell_read returns
> (void *).
>
> >
> > Also, this need to be freed somewhere in remove code (kfree(svsp->tefuse)).
> >
> > And it seems like svsp->tefuse is only used in this function, can you
> > just allocate it here?
>
> Oh, svsp->tefuse will be used in SVS debug patch for debug purpose. So,
> I need to save it as struct member.

Oh I missed that, sgtm then. Thanks.

>
[snip]
