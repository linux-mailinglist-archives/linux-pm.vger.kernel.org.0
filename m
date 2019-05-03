Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDFFF1338D
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2019 20:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfECSRH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 May 2019 14:17:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42362 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbfECSRH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2019 14:17:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id p6so3081534pgh.9;
        Fri, 03 May 2019 11:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ebeybqPyoYxIU9IJ9ueOCrDBH6yBD5+m4rUusA3XFTo=;
        b=aUSJRB3WCAHVAVdM0oGRtjvAIyZDtDgH5Do3XuKHITJnXeDfJEdr9EqKCORhmMZJNO
         9hS2Rq6UJkRLei94Lz2iuSJoLGbseX4xO65gRro1fqS1/JCHG2Go/XcVcxavuI0hsHKj
         1ZeoyrUsS4Ul55o0G88ro5D4wXbQ+OI58EoIG/iIYmK1//Rd0pPaR24CCPqXwQPJ3zjs
         HUBlkCNw/fqSiMKk3yb5WwDJzK+klXCFbZ623H8FzDinpMGj16QJQulCAUoPdgrl0aKU
         4pUXWMfBkED8LBiUtH1cjd4yBiyyqfxmNY+DEiNVuNCZYdumac7xIU3mdkHJJ6k8eEoT
         SSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ebeybqPyoYxIU9IJ9ueOCrDBH6yBD5+m4rUusA3XFTo=;
        b=ZwSySVmVkrsfuzKhFAuitZET91nVPHBng3VSFBiMe3V+1AJ10EYfug9poYVf7QoQtf
         UNqYlnyHV/mdviE3v/xkQ3Ihv/uVGMCfAkJYM5N9MroeKtkE65bu5yK5FdSJOY8ozfIE
         htYRyD2tWwDkoZKubx1F0/UivWxYq4ZjZNDN//irsxBz9V3TXZblRyPiB+BAvHTUZVad
         azzKqw8e0bNI+E0PSAceMfnAR8qQFG3iSF9TnNr5KIzLLXFjXXD5tlqUayGpfvMYIQm+
         JpJfEVDgyf3ZFyyIrzZrS9rNNkiT6p9qNkJIcI50/0qN+6zMRWJtMfOd1R/qISCM30L0
         n6Dw==
X-Gm-Message-State: APjAAAUyAVz9wq2Dv2GBkiHukUy6HWnPS4OixkBFFLIHjoofOLy06tOX
        QZjAkwktHPszoCw2mmCI2Vw=
X-Google-Smtp-Source: APXvYqxtziP5ATxi5cED6S8cnZK8oJZlDjzIpGwHS6yYOkJom4XxEYqlUAszNkOYSGX3GdfEnU1osg==
X-Received: by 2002:a63:10c:: with SMTP id 12mr12613470pgb.276.1556907426365;
        Fri, 03 May 2019 11:17:06 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k63sm15326pfb.108.2019.05.03.11.17.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 11:17:04 -0700 (PDT)
Date:   Fri, 3 May 2019 11:17:03 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo Serra <enric.balletbo@collabora.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/3] dt-bindings: power: supply: Add bindings for
 Microchip UCS1002
Message-ID: <20190503181703.GA5088@roeck-us.net>
References: <20190503170042.19334-1-andrew.smirnov@gmail.com>
 <20190503170042.19334-4-andrew.smirnov@gmail.com>
 <20190503170326.GB32529@roeck-us.net>
 <CAHQ1cqGkcOHnW1S8QGGcgY3qV6ErCq5gbYgGwspVeoEt_ce6tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQ1cqGkcOHnW1S8QGGcgY3qV6ErCq5gbYgGwspVeoEt_ce6tg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 03, 2019 at 12:33:40PM -0500, Andrey Smirnov wrote:
> On Fri, May 3, 2019 at 12:03 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Fri, May 03, 2019 at 10:00:42AM -0700, Andrey Smirnov wrote:
> > > Add bindings for Microchip UCS1002 Programmable USB Port Power
> > > Controller with Charger Emulation.
> > >
> > > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > > Reviewed-by: Rob Herring <robh+dt@kernel.org>
> > > Cc: Enric Balletbo Serra <enric.balletbo@collabora.com>
> > > Cc: Chris Healy <cphealy@gmail.com>
> > > Cc: Lucas Stach <l.stach@pengutronix.de>
> > > Cc: Fabio Estevam <festevam@gmail.com>
> > > Cc: Guenter Roeck <linux@roeck-us.net>
> > > Cc: Sebastian Reichel <sre@kernel.org>
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: linux-pm@vger.kernel.org
> > > ---
> > >  .../power/supply/microchip,ucs1002.txt        | 27 +++++++++++++++++++
> > >  1 file changed, 27 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt b/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
> > > new file mode 100644
> > > index 000000000000..1d284ad816bf
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
> > > @@ -0,0 +1,27 @@
> > > +Microchip UCS1002 USB Port Power Controller
> > > +
> > > +Required properties:
> > > +- compatible         : Should be "microchip,ucs1002";
> > > +- reg                        : I2C slave address
> > > +
> > > +Optional properties:
> > > +- interrupts         : A list of interrupts lines present (could be either
> > > +                       corresponding to A_DET# pin, ALERT# pin, or both)
> > > +- interrupt-names    : A list of interrupt names. Should contain (if
> > > +                       present):
> > > +                       - "a_det" for line connected to A_DET# pin
> > > +                       - "alert" for line connected to ALERT# pin
> > > +                       Both are expected to be IRQ_TYPE_EDGE_BOTH
> > > +Example:
> > > +
> > > +&i2c3 {
> > > +     charger@32 {
> > > +             compatible = "microchip,ucs1002";
> > > +             pinctrl-names = "default";
> > > +             pinctrl-0 = <&pinctrl_ucs1002_pins>;
> > > +             reg = <0x32>;
> > > +             interrupts-extended = <&gpio5 2 IRQ_TYPE_EDGE_BOTH>,
> > > +                                   <&gpio3 21 IRQ_TYPE_EDGE_BOTH>;
> >
> > interrupts ?
> 
> Can't really use it here since it assumes single "interrupt-parent"
> (we have gpio5 and gpio3 as parents above)
> 
Ah, ok. Thanks for the clarification.

Guenter
