Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0228B4D24
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2019 13:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfIQLqO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Sep 2019 07:46:14 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34736 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfIQLqO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Sep 2019 07:46:14 -0400
Received: by mail-oi1-f195.google.com with SMTP id 83so1059391oii.1;
        Tue, 17 Sep 2019 04:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iQmgkBy929J7xJM6lySEJ2RGnrP3SzRTLUGUYlBX0sU=;
        b=HwgNTJDKTl31C35oyunoRdG/Gop/nQwSz5Ly4r4I2HZcql8RRQmube18UeMIy0f3y7
         v6muIEvnXXb9Z6ClKUcR9uLIvP/GDoWnCOWOi+TPCBXdg8WBRWbiE7SucOFsvc1x8snc
         W1/HXF/p5Cx9ABpti0Ic2mS+zD+swaNAeNfmEWsTXlClkQOZPAhTMjc5VzeX3k8vsKWA
         z8lExUfPdBqAmPfWldLYkZYXLseicBJrRtfyN4X9MY+5aSUfuXC49+2RhDRMpci4IM+H
         HhTITBJXNmG5XBmP2moRfbk7sJyNQOAwVREn2y0UyItRLBPibb6wz/2HGVf7E27915Nh
         aAQA==
X-Gm-Message-State: APjAAAUgaWnM5a0tYAA926/f65r9RSGLAviSRiGRsk9yJs9b7OZ/gwj6
        I+qOq0zUxs+UP4xwpchvI6VFxb+5qINYyzeVw4w=
X-Google-Smtp-Source: APXvYqzTXjZEVBuKrH039W2b4srrBsE9xr3er4HJXAkLCSJ4cWnd1aTpjOyolHKADv0pTZdfq9cR13pL3FHNTPMA5LY=
X-Received: by 2002:aca:dad4:: with SMTP id r203mr3338531oig.102.1568720773071;
 Tue, 17 Sep 2019 04:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190916100717.31472-1-horms+renesas@verge.net.au>
 <20190917113250.6q4mmyiaa7pdkbeb@verge.net.au> <CAMuHMdUDRdWoe8L49kDAwsv_46UzwKPiNz9WfEQyrX-o7XZhwQ@mail.gmail.com>
 <20190917114112.wh564oqhdmfhkm4u@verge.net.au>
In-Reply-To: <20190917114112.wh564oqhdmfhkm4u@verge.net.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 17 Sep 2019 13:46:02 +0200
Message-ID: <CAMuHMdWn42tJVVDws+0Hmxajpm9uHH-LrfB1oy4Ct=M-GMJRag@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: thermal: rcar-thermal: convert bindings to json-schema
To:     Simon Horman <horms@verge.net.au>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Simon,

On Tue, Sep 17, 2019 at 1:41 PM Simon Horman <horms@verge.net.au> wrote:
> On Tue, Sep 17, 2019 at 01:37:39PM +0200, Geert Uytterhoeven wrote:
> > On Tue, Sep 17, 2019 at 1:32 PM Simon Horman <horms@verge.net.au> wrote:
> > > I missread the original bindings document and somehow missed
> > > warnings emitted by dtbs_check. I now think the compat property should be
> > > described as:
> > >
> > >   compatible:
> > >     oneOf:
> > >       - items:
> > >           - enum:
> > >               - renesas,thermal-r8a73a4       # R-Mobile APE6
> > >               - renesas,thermal-r8a7779       # R-Car H1
> > >           - const: renesas,rcar-thermal       # Without thermal-zone
> > >
> > >       - items:
> > >           - enum:
> > >               - renesas,thermal-r8a7790       # R-Car H2
> > >               - renesas,thermal-r8a7791       # R-Car M2-W
> > >               - renesas,thermal-r8a7792       # R-Car V2H
> > >               - renesas,thermal-r8a7793       # R-Car M2-N
> > >           - const: renesas,rcar-gen2-thermal  # With thermal-zone
> > >           - const: renesas,rcar-thermal       # Without thermal-zone
> > >
> > >       - items:
> > >           - enum:
> > >               - renesas,thermal-r8a7743       # RZ/G1M
> > >               - renesas,thermal-r8a7744       # RZ/G1N
> > >           - const: renesas,rcar-gen2-thermal  # With thermal-zone
> > >
> > >       - items:
> > >           - enum:
> > >               - renesas,thermal-r8a774c0      # RZ/G2E
> > >               - renesas,thermal-r8a77970      # R-Car V3M
> > >               - renesas,thermal-r8a77990      # R-Car E3
> > >               - renesas,thermal-r8a77995      # R-Car D3
> >
> > Perhaps we should (try to) get rid of the "Without thermal-zone" legacy?
> > All R-Car Gen2 DTSes received thermal zones a while ago.
> > R-Mobile APE6 and R-Car H1 still don't have them described, though.
>
> Do you mean deprecate renesas,rcar-thermal ?

Exactly.

> If so that sounds reasonable if APE6 and R-Car H1 supports thermal-zones.
> But I don't feel it belongs in this patch, which aims
> to translate the documentation from one format to another

OK.

> (perhaps highlighting problems along the way :).

That part has been activated, definitely ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
