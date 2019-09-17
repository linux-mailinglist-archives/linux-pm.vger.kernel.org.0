Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75708B4D19
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2019 13:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfIQLlR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Sep 2019 07:41:17 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:39202 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfIQLlR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Sep 2019 07:41:17 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 0863325B777;
        Tue, 17 Sep 2019 21:41:15 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 14E389407F6; Tue, 17 Sep 2019 13:41:13 +0200 (CEST)
Date:   Tue, 17 Sep 2019 13:41:13 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
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
Subject: Re: [PATCH] dt-bindings: thermal: rcar-thermal: convert bindings to
 json-schema
Message-ID: <20190917114112.wh564oqhdmfhkm4u@verge.net.au>
References: <20190916100717.31472-1-horms+renesas@verge.net.au>
 <20190917113250.6q4mmyiaa7pdkbeb@verge.net.au>
 <CAMuHMdUDRdWoe8L49kDAwsv_46UzwKPiNz9WfEQyrX-o7XZhwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUDRdWoe8L49kDAwsv_46UzwKPiNz9WfEQyrX-o7XZhwQ@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 17, 2019 at 01:37:39PM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Tue, Sep 17, 2019 at 1:32 PM Simon Horman <horms@verge.net.au> wrote:
> > I missread the original bindings document and somehow missed
> > warnings emitted by dtbs_check. I now think the compat property should be
> > described as:
> >
> >   compatible:
> >     oneOf:
> >       - items:
> >           - enum:
> >               - renesas,thermal-r8a73a4       # R-Mobile APE6
> >               - renesas,thermal-r8a7779       # R-Car H1
> >           - const: renesas,rcar-thermal       # Without thermal-zone
> >
> >       - items:
> >           - enum:
> >               - renesas,thermal-r8a7790       # R-Car H2
> >               - renesas,thermal-r8a7791       # R-Car M2-W
> >               - renesas,thermal-r8a7792       # R-Car V2H
> >               - renesas,thermal-r8a7793       # R-Car M2-N
> >           - const: renesas,rcar-gen2-thermal  # With thermal-zone
> >           - const: renesas,rcar-thermal       # Without thermal-zone
> >
> >       - items:
> >           - enum:
> >               - renesas,thermal-r8a7743       # RZ/G1M
> >               - renesas,thermal-r8a7744       # RZ/G1N
> >           - const: renesas,rcar-gen2-thermal  # With thermal-zone
> >
> >       - items:
> >           - enum:
> >               - renesas,thermal-r8a774c0      # RZ/G2E
> >               - renesas,thermal-r8a77970      # R-Car V3M
> >               - renesas,thermal-r8a77990      # R-Car E3
> >               - renesas,thermal-r8a77995      # R-Car D3
> 
> Perhaps we should (try to) get rid of the "Without thermal-zone" legacy?
> All R-Car Gen2 DTSes received thermal zones a while ago.
> R-Mobile APE6 and R-Car H1 still don't have them described, though.

Do you mean deprecate renesas,rcar-thermal ?

If so that sounds reasonable if APE6 and R-Car H1 supports thermal-zones.
But I don't feel it belongs in this patch, which aims
to translate the documentation from one format to another
(perhaps highlighting problems along the way :).
