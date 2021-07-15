Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D53D3C9DB9
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jul 2021 13:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240714AbhGOLae (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Jul 2021 07:30:34 -0400
Received: from mail-yb1-f178.google.com ([209.85.219.178]:40821 "EHLO
        mail-yb1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239113AbhGOLae (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Jul 2021 07:30:34 -0400
Received: by mail-yb1-f178.google.com with SMTP id p22so8474382yba.7;
        Thu, 15 Jul 2021 04:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+W8ELn/zFAvft5g8sYWYS9+LY4YGOgrltlgjHqPH+4E=;
        b=KketO8vJATWz08ULV54iv8bMIFNpQXZbesm1LMiB02xGyUwhwtv0tMBtXFXw+FjWCo
         WKlBaFNLUVeuhnuHY6iWvjhAaHAyBNJuN4eZr3//l24UlO8D+F8oDMl6/ErIyaMcgdMj
         B2UBLczltmfFbYbOhU1BSM4gm/7IZSL7ZxPs5UCwFoxp7xPuMeWuGmpFF6UTLqJxk5SN
         MgUwjif3muLlpLG0RdCsu0OQeOQaEAMWfMTZnJuv5SjJb2nM57/M90NtHFOAM5mJaf9m
         +xkg2zou0hs64I9oy+vOo669FtzQXrVxt8iGV7GJuPPSMtr8gg3sVlbGp1FUVsQTqQLD
         7Fuw==
X-Gm-Message-State: AOAM531ZGB05rHT+L4h1ErznMKmEkFPi5nf2Y+W/G/4Gdpfg05i/yB/M
        yLXFh3TDhGJu6ItuVFPAY6X3v5ISTBsSZT1LY8M=
X-Google-Smtp-Source: ABdhPJy1l/jsObrnrl7Gdd93dH1lUdyiAvfTZq1DLYzxiUayWNTGyY4wIFrB4zh3JBjH5i7ZKt+/9SmlVh2gwDmVki4=
X-Received: by 2002:a25:4102:: with SMTP id o2mr4697605yba.23.1626348460634;
 Thu, 15 Jul 2021 04:27:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210625224744.1020108-1-kernel@esmil.dk> <20210625224744.1020108-3-kernel@esmil.dk>
 <YO1aSSSankv+cAru@google.com> <20210714203843.GA3476672@robh.at.kernel.org> <YPAYQvhHwPOrnyik@google.com>
In-Reply-To: <YPAYQvhHwPOrnyik@google.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Thu, 15 Jul 2021 13:27:29 +0200
Message-ID: <CANBLGcwTtHZgJ3XakANOvB6-kiuf7W3igLKzBKW2ZfQ5zN_Y0w@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] mfd: tps65086: Make interrupt line optional
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 15 Jul 2021 at 13:13, Lee Jones <lee.jones@linaro.org> wrote:
> On Wed, 14 Jul 2021, Rob Herring wrote:
> > On Tue, Jul 13, 2021 at 10:18:01AM +0100, Lee Jones wrote:
> > > On Sat, 26 Jun 2021, Emil Renner Berthing wrote:
> > >
> > > > The BeagleV Starlight v0.9 board[1] doesn't have the IRQB line routed to
> > > > the SoC, but it is still useful to be able to reach the PMIC over I2C
> > >
> > > What is still useful?
> > >
> > > The GPIO and Regulator drivers?
> > >
> > > > for the other functionality it provides.
> > > >
> > > > [1] https://github.com/beagleboard/beaglev-starlight
> > > >
> > > > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > > > ---
> > > >  .../devicetree/bindings/mfd/ti,tps65086.yaml  |  3 ---
> > > >  drivers/mfd/tps65086.c                        | 21 ++++++++++---------
> > > >  2 files changed, 11 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml b/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
> > > > index ba638bd10a58..4b629fcc0df9 100644
> > > > --- a/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
> > > > +++ b/Documentation/devicetree/bindings/mfd/ti,tps65086.yaml
> > > > @@ -87,9 +87,6 @@ additionalProperties: false
> > > >  required:
> > > >    - compatible
> > > >    - reg
> > > > -  - interrupts
> > > > -  - interrupt-controller
> > > > -  - '#interrupt-cells'
> > >
> > > I can't say that I've been keeping up with the latest DT binding
> > > changes, but shouldn't these lines be relocated into some kind of
> > > optional listing?
> > >
> > > Or are optional properties omitted from documentation?
> >
> > Optional properties are the ones not listed in the 'required' list.
>
> Ah, so they are already documented somewhere else in the file?

Yes, just a few lines above.
