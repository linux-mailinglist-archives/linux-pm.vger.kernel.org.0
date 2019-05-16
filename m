Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13F4320E7C
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2019 20:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfEPSOL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 May 2019 14:14:11 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38344 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfEPSOL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 May 2019 14:14:11 -0400
Received: by mail-it1-f196.google.com with SMTP id i63so7830387ita.3;
        Thu, 16 May 2019 11:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oYizfKO0iUCkCx87QTv9y+9/yguDDJWHGpNmrjjyMQE=;
        b=T1a1UQAWEN1zwXTAxJ0W6YsgQvMdJVGrZGrDTxkDkBdftsG7bFuxqMMuyRYIbwpp3N
         zpUtrb0fyJY34h5ZAqJ5AKxT5uAswqiB8LO5sX7EJZTZgfYEuGvfO/pb8QwJVTKmVOqr
         MpYvM0qdYL46t4TGTV4SiIP/n20fxoie6h4lu9vHtVeHW6WMLT7uWNa4D7JCmGJdqinU
         Pff5NHk3/urnJe9KHzJ6+b6680Gwf/AWHqMdWWb+a/6DEl/LFjfmKJv/qzjGlsL+oluN
         QFRErVrPnqIzZrVDXUDAYofBl17/UhgtMEOjPMZ4uAeyPqGuIKtX1oJjyRayHP/2d5U4
         lc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oYizfKO0iUCkCx87QTv9y+9/yguDDJWHGpNmrjjyMQE=;
        b=aI3BJkR77k41yerUhldC952Lgy/oKTQNv9pFBpp6ZHJXfWHgNppFPPKR63/OgKNvji
         WOEectIMFLrFFPfkZPpWVc3p+bvNXB7fLNa6FV3/3ZNjO2yw7UW26KV6kxV36U+KWg5U
         bmlCZOBl7xzdvEVv0lkmUZuT3kxYRUh8ba+ICWZYza8TjF4oCYJbDNVs0w/48Zf6Ie6u
         xeGx5x3cFESJ2dKxx1GXmfQdsCCB/RMzYNultjszjl/Ux9VUYapFRZ/H6nvcJuLi3IJp
         J0HnF6EkFzgNjjLUGaEgscd7vcywjSnxUJNUFno03ZVo6wOqQvSShYDvTKkOccxRog08
         TLeg==
X-Gm-Message-State: APjAAAXXykYoKxaINn+ab7wg/iSsFv4vFk9F6yssAfPJjgiq8rV5gEe0
        Ue3/o0J0gJc52+tHt/XwASXbTEd3TW+lgHNXpyQ=
X-Google-Smtp-Source: APXvYqzg91EbMijFJyKzCeNsU32nhaqbI5CANe+33pKz919XCTOUPyqfIi2K6fq6NPt65fI6+i8jOiwXWRTfBrRl2y4=
X-Received: by 2002:a05:660c:105:: with SMTP id w5mr1049148itj.37.1558030450144;
 Thu, 16 May 2019 11:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190512082614.9045-1-tiny.windzz@gmail.com> <20190512082614.9045-4-tiny.windzz@gmail.com>
 <20190512134152.yrletgtiglxncyo4@flea>
In-Reply-To: <20190512134152.yrletgtiglxncyo4@flea>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Fri, 17 May 2019 02:13:58 +0800
Message-ID: <CAEExFWvkM86ajB4io8yopkKEOfRE3UObRpqoi=Sq0RtDnuaRWA@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: thermal: add binding document for h6
 thermal controller
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, robh+dt@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, catalin.marinas@arm.com,
        will.deacon@arm.com, David Miller <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan.Cameron@huawei.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        paulmck@linux.ibm.com, Andy Gross <andy.gross@linaro.org>,
        olof@lixom.net, bjorn.andersson@linaro.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        marc.w.gonzalez@free.fr, stefan.wahren@i2se.com,
        enric.balletbo@collabora.com, Linux PM <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, May 12, 2019 at 9:41 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> On Sun, May 12, 2019 at 04:26:14AM -0400, Yangtao Li wrote:
> > This patch adds binding document for allwinner h6 thermal controller.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  .../bindings/thermal/sun50i-thermal.txt       | 32 +++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/sun50i-thermal.txt
>
> We're starting to convert to YAML for binding descriptions that will
> allow to validate that all DT are properly using the binding. It would
> be great if you could use it as well.

What have been changed to this now?

>
> > diff --git a/Documentation/devicetree/bindings/thermal/sun50i-thermal.txt b/Documentation/devicetree/bindings/thermal/sun50i-thermal.txt
> > new file mode 100644
> > index 000000000000..67eda7794262
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/sun50i-thermal.txt
> > @@ -0,0 +1,32 @@
> > +Binding for Thermal Sensor of Allwinner SOC.
> > +
> > +This describes the device tree binding for the Allwinner thermal controller
> > +which measures the on-SoC temperatures.
> > +
> > +Required properties:
> > +- compatible:
> > +  - "allwinner,sun50i-h6-ths" : For H6
> > +- reg: Address range of the thermal controller
> > +- clocks, clock-names: Clocks needed for the thermal controller.
> > +                    The required clocks for h6 are: "bus".
>
> If there's a single clock, then we don't need clock-names

Yeah, but, IIRC, H3 have two clk.
So I'd like to keep it.

>
> > +- resets, reset-names: Reference to the reset controller controlling
> > +                    the thermal controller.
>
> Ditto.

Done.

Thx,
Yangtao
>
> > +- nvmem-cells: A phandle to the calibration data provided by a nvmem device. If
> > +            unspecified default values shall be used.
> > +- nvmem-cell-names: Should be "calib"
>
> I thought you said that nvmem support was optional in the
> driver. Maybe we could make it optional in the DT too?
>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
