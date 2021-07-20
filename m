Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1857A3CFF4F
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jul 2021 18:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbhGTPpg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 20 Jul 2021 11:45:36 -0400
Received: from mail-yb1-f177.google.com ([209.85.219.177]:43838 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbhGTPi1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jul 2021 11:38:27 -0400
Received: by mail-yb1-f177.google.com with SMTP id g5so33465840ybu.10;
        Tue, 20 Jul 2021 09:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/tuAsxTxs6Rvi+p/wTgyJYt239TXDSVXz4z8meprIB8=;
        b=Flc1hNQ2hJTokwYt0luyhAsrM54qONlLKvkuN6Ey9xndOzZDv78xx1lVhYu15HXDQJ
         3cJElfYiC2eldE0Zw8x9l/PGqim5eflgwUXiFsJ1wSI1mlLdVjoOFOGUhQm3YEyxnbld
         EPoJORRM+WKaLVXk9+Qj+poC0r719+Xocce2y7qDBvRnP7L1rmBMgXgf1IeCJxGDz+d7
         +VhB1ivnFXNqXimv+2huhZM7dSBzbejEOvgc4esyNzZm/E4sKej1ykgJiZ36gH9G8a6G
         pWdOuug+my2MHE+vDx3xHDbvsBwATnMrKzf0xAEvt1QnjwWuH0Ao0/v5k4eWRUzZSiBV
         wP/g==
X-Gm-Message-State: AOAM532cxjRCjxJR4JL1iLie1XDzBovGu3IXwny2WvYw8tw0Rx6zYvYk
        pPzBpMqVMY1P/c8VsNK9BL3NXxacEsMRVsfbkbeDSpVz+CY=
X-Google-Smtp-Source: ABdhPJxA0p1LFiovnlzCLhOM3BMb+zZCYel0Rs/78DAXbTtc6CexG5mqz2t4YEFShmlfIzJScEtvGDaqocUjB2HR8ms=
X-Received: by 2002:a25:4102:: with SMTP id o2mr38143044yba.23.1626797931250;
 Tue, 20 Jul 2021 09:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210625224744.1020108-1-kernel@esmil.dk> <20210625224744.1020108-3-kernel@esmil.dk>
 <YPbmmqfOuE5w6EgW@google.com> <CANBLGcy_28q23vRJk9=UZR_Feeqod-ETET=v4Ub=35edySH7SA@mail.gmail.com>
 <YPbsodxMk+VvU/3D@google.com> <CANBLGcx08XajR8khJmKARBjy7bQ5ebbgO+RRqRu=bvyMx7LuKA@mail.gmail.com>
 <YPb0spKPvEvuuMWc@google.com>
In-Reply-To: <YPb0spKPvEvuuMWc@google.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Tue, 20 Jul 2021 18:18:40 +0200
Message-ID: <CANBLGcx2R4xuyoLHJUNbqiJeRrqTD1oL7X1K0RKzOPD_9xnMdw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] mfd: tps65086: Make interrupt line optional
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 20 Jul 2021 at 18:07, Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 20 Jul 2021, Emil Renner Berthing wrote:
> > On Tue, 20 Jul 2021 at 17:32, Lee Jones <lee.jones@linaro.org> wrote:
> > > On Tue, 20 Jul 2021, Emil Renner Berthing wrote:
> > > > On Tue, 20 Jul 2021 at 17:07, Lee Jones <lee.jones@linaro.org> wrote:
> > > > > On Sat, 26 Jun 2021, Emil Renner Berthing wrote:
> > > > > > The BeagleV Starlight v0.9 board[1] doesn't have the IRQB line routed to
> > > > > > the SoC, but it is still useful to be able to reach the PMIC over I2C
> > > > > > for the other functionality it provides.
> > > > > >
> > > > > > [1] https://github.com/beagleboard/beaglev-starlight
> > > > > >
> > > > > > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > > > > > ---
> > > > > >  .../devicetree/bindings/mfd/ti,tps65086.yaml  |  3 ---
> > > > >
> > > > > This is not present in my current tree.
> > > > >
> > > > > Looks like it's still *.txt.
> > > > >
> > > > > Am I missing a patch?
> > > >
> > > > Yes, the first patch in the series converts that to yaml. I'm quite
> > > > sure I had the same list of recipients on all 4 mails in the series,
> > > > so don't know why that should be missing.
> > >
> > > Oh, it's not marked as 'important' because it has open review comments
> > > on it.
> > >
> > > Just have this for now then:
> > >
> > > For my own reference (apply this as-is to your sign-off block):
> > >
> > >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> >
> > Thanks! Do you want to have a look at 3/3 or should I just send a v2
> > to fix the yaml conversion now?
>
> Patch 3 should be split.

Oh, how split? Split off the series or split into adding the "driver"
and then add the cell to the parent?

> I think it should also s/restart/reset/.

Oh right yes. You mean the cell name needs to be .name =
"tps65086-reset", right?
I'll fix that anyway.

> --
> Lee Jones [李琼斯]
> Senior Technical Lead - Developer Services
> Linaro.org │ Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
