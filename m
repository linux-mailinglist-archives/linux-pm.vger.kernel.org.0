Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5B9126FCC
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 22:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfLSViu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 16:38:50 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46364 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfLSViu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 16:38:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id y14so4005794pfm.13;
        Thu, 19 Dec 2019 13:38:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=A8qzfXgJqfz0JsylJ7w5yc0iwoDWilLcpVP41fGSaVY=;
        b=sp6jN/DAYmh1enzLowAxt+CQNyzsEJFI4+AW3rDNa98uIQiqkHydnmsh4uBOi0hujT
         hM+8ZT5cd1m5ZN7C10poqLosAYdj4Hi2i3bIaYJ3ksj/3Ibko6A/nJeCmwcMM58c3f4V
         PHvHESWX3AQIOHxMkssH6KXSfZr1g1xwXk8AgBDtkkz2jvGkfe5l0yGqV0AYao8YuUdl
         KDowwrZsS5ynK6XrZf+Dc/Bty4NpMwCVVxaBnbXXhb13V214oME/1nosB6bFQTrHrCBL
         PAOl23apfnUVawQ72qrtdc74WHa5c1NmgC9V54FZjDIX2jwdfOXEN7GpZDO7QaeakdzI
         DUYA==
X-Gm-Message-State: APjAAAVd2O+lEC7uBWbOsslf5W9RabYx83PsGHK9Mtoi5hrHfWlWP1wf
        ozyDDNbgp9th1RpaPEhrRw==
X-Google-Smtp-Source: APXvYqxZh6usqcMuDpjIzx8tWU+6WwnJbiDYBNuEG9Di9Qzpk8aU8oFtnRSoasoMfjjZop8d7zm5Lw==
X-Received: by 2002:a63:a707:: with SMTP id d7mr10954574pgf.93.1576791529663;
        Thu, 19 Dec 2019 13:38:49 -0800 (PST)
Received: from localhost ([172.58.27.162])
        by smtp.gmail.com with ESMTPSA id p5sm8161313pgs.28.2019.12.19.13.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 13:38:48 -0800 (PST)
Date:   Thu, 19 Dec 2019 13:38:45 -0800
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Peter Chen <peter.chen@nxp.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, od@zcrc.me,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 3/3] power/supply: Add generic USB charger driver
Message-ID: <20191219213845.GA3481@bogus>
References: <20191211155032.167032-1-paul@crapouillou.net>
 <20191211155032.167032-3-paul@crapouillou.net>
 <20191212091814.GA7035@b29397-desktop>
 <1576270147.3.0@crapouillou.net>
 <VI1PR04MB5327401FFD2D32E937548DD48B510@VI1PR04MB5327.eurprd04.prod.outlook.com>
 <1576493525.3.0@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1576493525.3.0@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 16, 2019 at 11:52:05AM +0100, Paul Cercueil wrote:
> Hi Peter,
> 
> 
> Le lun., déc. 16, 2019 at 01:24, Peter Chen <peter.chen@nxp.com> a écrit :
> > 
> > >  >>  +
> > >  >>  +	desc = &charger->desc;
> > >  >>  +	desc->name = "usb-charger";
> > >  >>  +	desc->properties = usb_charger_properties;
> > >  >>  +	desc->num_properties = ARRAY_SIZE(usb_charger_properties);
> > >  >>  +	desc->get_property = usb_charger_get_property;
> > >  >>  +	desc->type = POWER_SUPPLY_TYPE_USB;
> > >  >
> > >  > What's your further plan for this generic USB charger?
> > >  > To support BC1.2, we need to know charger type, and how we could
> > > get
> > >  > it?
> > >  >
> > >  > Peter
> > > 
> > >  Well I don't really know. The USB role framework does not give any
> > > info about
> > >  what's plugged.
> > > 
> > 
> > What's the use case for this patch set? How it be used?
> 
> My devicetree:
> 
> usb_otg: usb@13440000 {
> 	compatible = "ingenic,jz4770-musb", "simple-mfd";
> 	reg = <0x13440000 0x10000>;
> 	[...]
> 
> 	usb-role-switch;
> 
> 	connector {
> 		compatible = "gpio-usb-b-connector", "usb-b-connector";
> 		label = "mini-USB";
> 		type = "mini";
> 
> 		id-gpios = <&gpf 18 GPIO_ACTIVE_HIGH>;
> 		vbus-gpios = <&gpb 5 GPIO_ACTIVE_HIGH>;
> 		[...]
> 	};
> 
> 	usb_charger: usb-charger {
> 		compatible = "usb-charger";

What h/w device is this?

> 	};
> };
> 
> The new gpio-usb-connector driver uses the ID/VBUS GPIOs to detect in which
> state (device, host, unconnected) a OTG connector is. However, that means I
> cannot use the standard gpio-charger driver to detect the presence of a
> charger based on the state of the VBUS gpio, since it's already requested
> here. So the point of this patchset is to provide an alternative to
> gpio-charger that works with OTG controllers compatible with
> 'usb-role-switch'.

Why not fix gpio-charger or make whatever 'owns' vbus-gpios to register 
a charger device?

I guess you could have Vbus sensing with no charging capability, but 
that sounds like a new property, not a node to me.

Rob
