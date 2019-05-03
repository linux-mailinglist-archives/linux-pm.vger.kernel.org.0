Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 773321332B
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2019 19:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfECRdx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 May 2019 13:33:53 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:52491 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfECRdx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2019 13:33:53 -0400
Received: by mail-it1-f193.google.com with SMTP id q65so8947192itg.2;
        Fri, 03 May 2019 10:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+2gg4z+rZQjGBdEHbAJ4Di8CT1K8c80KfYEwGpo3ExQ=;
        b=QFtJtD6cDlJAuC8vKYj7CL4OcRplxArKSJHumAz+4p4B+rMiZu53xdwSDnVzwZgJtp
         mY/AWhQm1EGoBjjxcoPX/D0+kFC1zHVp/hfcPoLbAMI90faNss56WEab1M7q27E3MaMc
         6NUzAkbGgqZNRr8wGnIO+2gztWjDkvNxDpqP0eldjbNcLz3ouCYNh1Qr3Fx23dQDFBF2
         nh7jI7vAYLH4vkph8fnbwyKh7jlP2Nd8HBuO4D0QYWOGB0R/BIUSfIXDSa91fsWEnbec
         qSd8PES6VbgBp8SNtvRxLRcy7k4/IJxJW3fmrirxYmcAvZF8X5RMQgQZxgCY/2W4S4jm
         MrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+2gg4z+rZQjGBdEHbAJ4Di8CT1K8c80KfYEwGpo3ExQ=;
        b=RsGifRn2IJgvjbZsakC70t7fCS0oR2TDko/xGl4uECMKeePK7Fwf6cTdeksuYU+I6B
         8zSJR3nQkGjvHdVM0orORo3r3k3+Hix9K2OgSlT9tZPJbQrF1J9qiy1Sn8bJNutUeLN8
         i0z4zcj9URBmA865ndXvMvmyxL6MtFTCuDsJHtyxuztc3eXc56keX2eyyP/nNArUbTJ4
         xnbtJbpr0uCft9ekioEPnlyqbsg06wVtl18Dc1AARHg4RpU8sumhz/EPLPZdEpZsszOG
         wpeUMVi3143OUJliiETaNS5JpJxKf6XpHFQb41FMDd0Qi4QEDr2HWG245UcxeJeZky/M
         Pk/Q==
X-Gm-Message-State: APjAAAVT5RTFhhzRCxareJqyQTcohM6nxwrbvuTbpn1R3muvlMVTdvQb
        /JdLatvdgrHkIRveg/uBPbWM+6P7q8rkFx7/n7TOBA==
X-Google-Smtp-Source: APXvYqw1EkOFpizqKtYRCCB80ruydNztpPx2ZCg1Kc6JEcxISL2U/hQCMGKmlgump6DkNieuo1FkD45dzVBdRQ0KQd0=
X-Received: by 2002:a05:660c:2c5:: with SMTP id j5mr1731491itd.154.1556904832500;
 Fri, 03 May 2019 10:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190503170042.19334-1-andrew.smirnov@gmail.com>
 <20190503170042.19334-4-andrew.smirnov@gmail.com> <20190503170326.GB32529@roeck-us.net>
In-Reply-To: <20190503170326.GB32529@roeck-us.net>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Fri, 3 May 2019 12:33:40 -0500
Message-ID: <CAHQ1cqGkcOHnW1S8QGGcgY3qV6ErCq5gbYgGwspVeoEt_ce6tg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] dt-bindings: power: supply: Add bindings for
 Microchip UCS1002
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo Serra <enric.balletbo@collabora.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 3, 2019 at 12:03 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Fri, May 03, 2019 at 10:00:42AM -0700, Andrey Smirnov wrote:
> > Add bindings for Microchip UCS1002 Programmable USB Port Power
> > Controller with Charger Emulation.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Reviewed-by: Rob Herring <robh+dt@kernel.org>
> > Cc: Enric Balletbo Serra <enric.balletbo@collabora.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Sebastian Reichel <sre@kernel.org>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > ---
> >  .../power/supply/microchip,ucs1002.txt        | 27 +++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
> >
> > diff --git a/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt b/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
> > new file mode 100644
> > index 000000000000..1d284ad816bf
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
> > @@ -0,0 +1,27 @@
> > +Microchip UCS1002 USB Port Power Controller
> > +
> > +Required properties:
> > +- compatible         : Should be "microchip,ucs1002";
> > +- reg                        : I2C slave address
> > +
> > +Optional properties:
> > +- interrupts         : A list of interrupts lines present (could be either
> > +                       corresponding to A_DET# pin, ALERT# pin, or both)
> > +- interrupt-names    : A list of interrupt names. Should contain (if
> > +                       present):
> > +                       - "a_det" for line connected to A_DET# pin
> > +                       - "alert" for line connected to ALERT# pin
> > +                       Both are expected to be IRQ_TYPE_EDGE_BOTH
> > +Example:
> > +
> > +&i2c3 {
> > +     charger@32 {
> > +             compatible = "microchip,ucs1002";
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&pinctrl_ucs1002_pins>;
> > +             reg = <0x32>;
> > +             interrupts-extended = <&gpio5 2 IRQ_TYPE_EDGE_BOTH>,
> > +                                   <&gpio3 21 IRQ_TYPE_EDGE_BOTH>;
>
> interrupts ?

Can't really use it here since it assumes single "interrupt-parent"
(we have gpio5 and gpio3 as parents above)

Thanks,
Andrey Smirnov
