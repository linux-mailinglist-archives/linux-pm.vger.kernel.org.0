Return-Path: <linux-pm+bounces-28305-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E5EAD1CEA
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 14:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9663ACD36
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 12:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F332571A2;
	Mon,  9 Jun 2025 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GELQe7zl"
X-Original-To: linux-pm@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AB4256C9B;
	Mon,  9 Jun 2025 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749471204; cv=none; b=nLGD8XeGwDo6F8sa7V/YBCarmGhvhxQAJeqr0vLscJOCAeJq/XscTeyd5UP6VBx7QlXXUvJOsXKaf8jdCWZTgRofZIbdH1ZO5Eui4PjbroVjbJQsS/Zowp5wi1Je5nOJcgYQH06cMN8xGymFjPd/444BbpeUpv01agpGJ4Um5mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749471204; c=relaxed/simple;
	bh=PjWv2JVHoaGy0VTS2P6IlLGrSZt154xP1RtHIPoptTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvv+ko017wQbNuw37KAUBVKkGJNFFzzyFyAScw2AdV/1rMMVyiwfXkjxts6sLbSgYWlnrvYo9wTx31NqfNpNC7NSW0WbSZLrb9n4VQ4jAE9ef9/y848KSKlPT2YjmUyQ8P5yWcYCLydz0WJh3BQlIpOo1nxHbifcaV7c+j2YrVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GELQe7zl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NueSzK31DadYmmhRVawstIJJP48eqaOR7oYF5vEnWFE=; b=GELQe7zlFulZ3w8scQGOg8Bdph
	qmSuWlEQovDrrtDkxsJHB8b7o9FWIvW5gzD/DF+r0DMgiYc5LOhBBw+OhvM2B1pPGkUzM7riKoSc7
	xsFzUDNgO29L1XHNB9QZWzUSYJBTUV4grY00EkB+ig27NwqE82kIMJl39FuFa8HLAvVQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uObMx-00F9CK-5J; Mon, 09 Jun 2025 14:12:51 +0200
Date: Mon, 9 Jun 2025 14:12:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Wunderlich <frank-w@public-files.de>
Cc: linux@fw-web.de, daniel@makrotopia.org, myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com, cw00.choi@samsung.com, djakov@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, jia-wei.chang@mediatek.com,
	johnson.wang@mediatek.com, arinc.unal@arinc9.com,
	Landen.Chao@mediatek.com, dqfext@gmail.com, sean.wang@mediatek.com,
	lorenzo@kernel.org, nbd@nbd.name, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: Re: [PATCH v3 06/13] arm64: dts: mediatek: mt7988: add basic
 ethernet-nodes
Message-ID: <9d27e0d3-5ecb-4dcd-b8aa-d4e0affbb915@lunn.ch>
References: <20250608211452.72920-1-linux@fw-web.de>
 <20250608211452.72920-7-linux@fw-web.de>
 <cc73b532-f31b-443e-8127-0e5667c3f9c3@lunn.ch>
 <trinity-87fadcdb-eee3-4e66-b62d-5cef65f1462d-1749464918307@trinity-msg-rest-gmx-gmx-live-5d9b465786-mldbm>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-87fadcdb-eee3-4e66-b62d-5cef65f1462d-1749464918307@trinity-msg-rest-gmx-gmx-live-5d9b465786-mldbm>

> > > +			gmac0: mac@0 {
> > > +				compatible = "mediatek,eth-mac";
> > > +				reg = <0>;
> > > +				phy-mode = "internal";
> > > +
> > > +				fixed-link {
> > > +					speed = <10000>;
> > > +					full-duplex;
> > > +					pause;
> > > +				};
> > 
> > Maybe i've asked this before? What is on the other end of this link?
> > phy-mode internal and fixed link seems an odd combination. It might
> > just need some comments, if this is internally connected to a switch.
> 
> yes you've asked in v1 and i responded :)
> 
> https://patchwork.kernel.org/project/linux-mediatek/patch/20250511141942.10284-9-linux@fw-web.de/
> 
> connected to internal (mt7530) switch. Which kind of comment do you want here? Only "connected to internal switch"
> or some more details?

"Connected to internal switch" will do. The word switch explains the
fixed-link, and internal the phy-mode.

It is not the case here, but i've seen DT misused like this because
the MAC is connected to a PHY and there is no PHY driver yet, so a
fixed link is used instead.

> > > +			mdio_bus: mdio-bus {
> > > +				#address-cells = <1>;
> > > +				#size-cells = <0>;
> > > +
> > > +				/* internal 2.5G PHY */
> > > +				int_2p5g_phy: ethernet-phy@f {
> > > +					reg = <15>;
> > 
> > It is a bit odd mixing hex and decimal.
> 
> do you prefer hex or decimal for both? for r3mini i used decimal for both, so i would change unit-address
> to 15.

I suspect decimal is more common, but i don't care.

> 
> > > +					compatible = "ethernet-phy-ieee802.3-c45";
> > 
> > I _think_ the coding standard say the compatible should be first.
> 
> i can move this up of course
> 
> > > +					phy-mode = "internal";
> > 
> > A phy should not have a phy-mode.
> 
> not sure if this is needed for mt7988 internal 2.5g phy driver, but seems not when i look at the driver
> (drivers/net/phy/mediatek/mtk-2p5ge.c). The switch phys also use this and also here i do not see any
> access in the driver (drivers/net/dsa/mt7530-mmio.c + mt7530.c) on a quick look.
> Afaik binding required the property and should be read by phylink (to be not unknown, but looks like
> handled the same way).

Which binding requires this? This is a PHY node, but i don't see
anything about it in ethernet-phy.yaml.

	Andrew

