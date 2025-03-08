Return-Path: <linux-pm+bounces-23670-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28428A578B4
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 06:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75FC51890B96
	for <lists+linux-pm@lfdr.de>; Sat,  8 Mar 2025 05:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A534D184540;
	Sat,  8 Mar 2025 05:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yZXZnV9A"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D3415E5B8;
	Sat,  8 Mar 2025 05:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741413442; cv=none; b=Xym0oEg5ZAF4IKfFqSl/15rIH0+ME6lRavCgPt7UhkSuA35aSGUKoEuZi9qpEp7uw1D/RILMV5Yi8Wctuv0eJhO59KO6V80FrPMmUSQpFW8t0jd3EQgqAaRDGhVNu/bL5+PYj64FfnVgz0War9CkL15HG6/jDtlt+jpvv1u6iFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741413442; c=relaxed/simple;
	bh=JzmsDg9DtrYfYPjoGVH8JHEuPvWz63npzYi59wS/Dbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPv98TnPkVAorrlZITNLDIHrPJJPWDp5yB14BL71+jC1pZ5t5sztdqRzVmP0QeUUdSTadSK46QTaExlkGd2I45bz04aACWCDCMX2gVPhZf4uTAjauvG/G4eE7SwKHWbOc6kMvVj9DpA8296xvcqy0LzAKfVeyjgLwUc8asXWCuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yZXZnV9A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44473C4CEE0;
	Sat,  8 Mar 2025 05:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741413441;
	bh=JzmsDg9DtrYfYPjoGVH8JHEuPvWz63npzYi59wS/Dbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yZXZnV9AmVNu6/JIAb7/rajXcgFg/OOZi5E/jFwrcbUN3gk6TfQ5whJXfXQDSEmF0
	 6sLCxGLENX/sRKHsXBt1IHqRqQEezypOjXL7g1V/m8qbcwbz7Bv7G34cpBOLglpaCj
	 b8n7VDOqPs/KqxnDYAz+lripf6iaSPcuLFU8lvEc=
Date: Sat, 8 Mar 2025 06:57:18 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Mark Brown <broonie@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Samuel Holland <samuel@sholland.org>,
	David Lechner <david@lechnology.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 3/7] usb: common: usb-conn-gpio: switch psy_cfg from
 of_node to fwnode
Message-ID: <2025030845-pectin-facility-a474@gregkh>
References: <20250225-psy-core-convert-to-fwnode-v1-0-d5e4369936bb@collabora.com>
 <20250225-psy-core-convert-to-fwnode-v1-3-d5e4369936bb@collabora.com>
 <2025022542-recital-ebony-d9b5@gregkh>
 <lhtljyn52wkhotaf2cn6fcj2vqx3dzipv2663kzwtw2tjjlxye@5l3xytkyvocy>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lhtljyn52wkhotaf2cn6fcj2vqx3dzipv2663kzwtw2tjjlxye@5l3xytkyvocy>

On Sat, Mar 08, 2025 at 02:10:29AM +0100, Sebastian Reichel wrote:
> Hello Greg,
> 
> On Tue, Feb 25, 2025 at 04:32:50AM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Feb 25, 2025 at 12:21:36AM +0100, Sebastian Reichel wrote:
> > > In order to remove .of_node from the power_supply_config struct,
> > > use .fwnode instead.
> > > 
> > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > ---
> > >  drivers/usb/common/usb-conn-gpio.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
> > > index aa710b50791b0282be0a6a26cffdd981b794acaa..1e36be2a28fd5ca5e1495b7923e4d3e25d7cedef 100644
> > > --- a/drivers/usb/common/usb-conn-gpio.c
> > > +++ b/drivers/usb/common/usb-conn-gpio.c
> > > @@ -158,7 +158,7 @@ static int usb_conn_psy_register(struct usb_conn_info *info)
> > >  	struct device *dev = info->dev;
> > >  	struct power_supply_desc *desc = &info->desc;
> > >  	struct power_supply_config cfg = {
> > > -		.of_node = dev->of_node,
> > > +		.fwnode = dev_fwnode(dev),
> > >  	};
> > >  
> > >  	desc->name = "usb-charger";
> > > 
> > > -- 
> > > 2.47.2
> > 
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Please just merge this patch through the USB tree.
> 
> There are no dependencies and I will send a new version for the
> later patches, but they won't make it to 6.15 as I want enough
> time in linux-next for them. This patch is rather simple and
> getting it merged now means we avoid immutable branches or
> merging through the wrong tree in the 6.16 cycle.

Attempting to merge a single patch out of a series is hard with our
current tools, you know that.  Please resend just the single patch if
you want that applied.

thanks,

greg k-h

