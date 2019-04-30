Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE1C10267
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2019 00:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfD3Wck (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 18:32:40 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40717 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfD3Wck (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 18:32:40 -0400
Received: by mail-oi1-f194.google.com with SMTP id y64so7100743oia.7;
        Tue, 30 Apr 2019 15:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TAGKPLLmuM7M+yddHmL2VZU0kSXEXyUPE5K9476P65c=;
        b=ZLPkKV9Sd56C8NpzfKv8upcwpl22jMNAUPoV+bDoQYA40eu3K+k7xvLDaufECxPpG7
         ZmtozL7C1fFxOuFyVx8P3c9eUgDcaQOsV9tcm5ITxx/kGMIV5bGWVX8k0uxxGq7+enrg
         /py6/aUuS3ejmVJ5JZuajTTsUQrjxlbfBRXa1Y33dBKgD2Xwr7j+FuQDeglJHQMaNQbq
         JdSgyZfJ+mqqbjUbUhhA30LcnZ8wKXsx4Ad1pc5XyIWjCCtdNkS4wlN0Pm47eN3912nt
         mbfUrOjHd5yC2F7Z8/Dtqs6AE8TVq+30rYILmvP4RG4Yn6JQAtgPPF1HAE51IDjlF8Rz
         exRQ==
X-Gm-Message-State: APjAAAVP10obKPV057XP64vAXyF8EF4DnW08HdP8TldToVFjhnDCxUEM
        DkAw9sfvoAV1DnkUdFX5eg==
X-Google-Smtp-Source: APXvYqwjn/okpaWBrRAU8O/dYyclhRAHEd7w9vrJ4+KZwEMgTIbfNh3wLZDJhAaiRAmjgsYxGuCX4A==
X-Received: by 2002:aca:4857:: with SMTP id v84mr1864424oia.131.1556663558678;
        Tue, 30 Apr 2019 15:32:38 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z90sm9693323otb.9.2019.04.30.15.32.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 15:32:37 -0700 (PDT)
Date:   Tue, 30 Apr 2019 17:32:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-pm@vger.kernel.org,
        Enric Balletbo Serra <enric.balletbo@collabora.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        devicetree@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] dt-bindings: power: supply: Add bindings for
 Microchip UCS1002
Message-ID: <20190430223236.GA10236@bogus>
References: <20190430064557.28469-1-andrew.smirnov@gmail.com>
 <20190430064557.28469-4-andrew.smirnov@gmail.com>
 <20190430161542.GB731@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430161542.GB731@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 30, 2019 at 09:15:42AM -0700, Guenter Roeck wrote:
> On Mon, Apr 29, 2019 at 11:45:57PM -0700, Andrey Smirnov wrote:
> > Add bindings for Microchip UCS1002 Programmable USB Port Power
> > Controller with Charger Emulation.
> > 
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Enric Balletbo Serra <enric.balletbo@collabora.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: devicetree@vger.kernel.org
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
> > index 000000000000..021fd7aba75e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/supply/microchip,ucs1002.txt
> > @@ -0,0 +1,27 @@
> > +Microchip UCS1002 USB Port Power Controller
> > +
> > +Required properties:
> > +- compatible		: Should be "microchip,ucs1002";
> > +- reg			: I2C slave address
> > +
> > +Optional properties:
> > +- interrupts-extended	: A list of interrupts lines present (could be either
> > +			  corresponding to A_DET# pin, ALERT# pin, or both)

Just make this 'interrupts'. Support for 'interrupts-extended' is 
implied.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> > +- interrupt-names	: A list of interrupt names. Should contain (if
> > +			  present):
> > +			  - "a_det" for line connected to A_DET# pin
> > +			  - "alert" for line connected to ALERT# pin
> > +			  Both are expected to be IRQ_TYPE_EDGE_BOTH
> > +Example:
> > +
> > +&i2c3 {
> > +	charger@32 {
> > +		compatible = "microchip,ucs1002";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_ucs1002_pins>;
> 
> Document the above ? Or is that optional ?

I would have said to document this, but recently we had some discussion 
about allowing this to be implied when there's only a 'default' entry. 
We'll add it automatically for schemas.

Rob
