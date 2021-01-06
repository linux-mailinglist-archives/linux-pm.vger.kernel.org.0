Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059742EBB3B
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jan 2021 09:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbhAFIpM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jan 2021 03:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbhAFIpM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jan 2021 03:45:12 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B901BC061357
        for <linux-pm@vger.kernel.org>; Wed,  6 Jan 2021 00:44:31 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id h6so1413786vsr.6
        for <linux-pm@vger.kernel.org>; Wed, 06 Jan 2021 00:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8BtqrpAZ+ssFRAoqkcqoX+i0pgFKIbpTJROkFhKnB54=;
        b=X6NOAGdSiz/IW64htDr3odCGFCPzWLdw7XHUJBvbZ00IdN6jDKzb1siXxIaPi6D5A4
         5SY3alIe8rbRH0qev5KIOe0isaJ7wHkYHKpmsWbmKEocFdYPWRLY5uyQIMJum8Q1qUOk
         bfZgrO8BjvLdMl6IN7roLOGRKB7/n15FTRqJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8BtqrpAZ+ssFRAoqkcqoX+i0pgFKIbpTJROkFhKnB54=;
        b=fdr8FSJmQXmc/6aqwOG9MQGUWv+c9ZmFNkh38N1GSCfDgHbD1KjV+ep1zEaECwUdG7
         jCLa0+vH/fUTLud3eWU8w7i3l9XFthxno+2a9MjVtlSVN88nBFFCaRysefydpmxuyzLb
         vxzCVUkfsmFAR+qVsunPbbdVj39BB5Kw9eD3DUWX7AYoX/VdEPu/pf42qcP6gCdoN4yI
         lDenxc1EGWgrIrvEA8Hffa4DGTG5ZMprBIAGZcv1bMi+3zq/OhWIlMicJ8i4sN97+p1f
         VxaLxPbtJbl6XwXvxwCAYz2q4ugOLD3DXZAPFyRTcmpq4aTBeiNhKtoqgC684OMOczGl
         G0Dg==
X-Gm-Message-State: AOAM532th7zb6556pf3LKnxRToKgQxKfk4XQGU5Z6r5YUJm9E64uPdpo
        BwqOjQ+aTuoZGyxof8mV8fMQOJSKqp1VUEsKSb/DAw==
X-Google-Smtp-Source: ABdhPJyvWwQuY4TJxmlVoIBqvuScGueMmhttXzbYyJihh6nXvK0B7iBhP8fCeeXeXIPqoFUXoWoASZIehmQdnjNOooo=
X-Received: by 2002:a67:5c03:: with SMTP id q3mr2298164vsb.47.1609922670668;
 Wed, 06 Jan 2021 00:44:30 -0800 (PST)
MIME-Version: 1.0
References: <20201227105449.11452-1-roger.lu@mediatek.com> <20201227105449.11452-4-roger.lu@mediatek.com>
 <CANMq1KBNKy708Vz67WOc+n7V7ne4L1EZVkUVGj6abd5voxKjxA@mail.gmail.com>
 <1609750266.20758.40.camel@mtksdaap41> <1609922515.18506.17.camel@mtksdaap41>
In-Reply-To: <1609922515.18506.17.camel@mtksdaap41>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 6 Jan 2021 16:44:19 +0800
Message-ID: <CANMq1KCDPn6vRXMC5piH=Ym+ZGTiF=B4KAJ-5iKSWwVQLWgYNA@mail.gmail.com>
Subject: Re: [PATCH v10 3/7] [v10, 3/7]: soc: mediatek: SVS: introduce MTK SVS engine
To:     Roger Lu <roger.lu@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        YT Lee <yt.lee@mediatek.com>, Fan Chen <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 6, 2021 at 4:41 PM Roger Lu <roger.lu@mediatek.com> wrote:
>
> Hi Nicolas,
>
> [snip]
> > >
> > > > +
> > > > +       /* Svs efuse parsing */
> > > > +       ft_pgm = (svsp->efuse[0] >> 4) & GENMASK(3, 0);
> > > > +
> > > > +       for (idx = 0; idx < svsp->bank_num; idx++) {
> > > > +               svsb = &svsp->banks[idx];
> > > > +
> > > > +               if (ft_pgm <= 1)
> > > > +                       svsb->init01_volt_flag = SVSB_INIT01_VOLT_IGNORE;
> > > > +
> > > > +               switch (svsb->sw_id) {
> > > > +               case SVSB_CPU_LITTLE:
> > > > +                       svsb->bdes = svsp->efuse[16] & GENMASK(7, 0);
> > > > +                       svsb->mdes = (svsp->efuse[16] >> 8) & GENMASK(7, 0);
> > > > +                       svsb->dcbdet = (svsp->efuse[16] >> 16) & GENMASK(7, 0);
> > > > +                       svsb->dcmdet = (svsp->efuse[16] >> 24) & GENMASK(7, 0);
> > > > +                       svsb->mtdes  = (svsp->efuse[17] >> 16) & GENMASK(7, 0);
> > >
> > > Again, if all of those values were u8, there'd be no need for these GENMASK
> >
> > Ok, I'll use u8 instead of GENMASK. Thanks.
>
> After refining the codes, I think it's much explicit to assign the bits
> I want by GENMASK() and will remove other GENMASK() that are repetitive
> like in svs_set_bank_phase() or svs_set_freqs_pct_v2().

I'm not sure what you mean, but, sure, you can go ahead with v11 and
we'll see how it looks.

Thanks,

> [snip]
>
