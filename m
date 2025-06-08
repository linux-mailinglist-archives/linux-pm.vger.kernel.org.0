Return-Path: <linux-pm+bounces-28280-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2D3AD14B7
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 23:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41B511887472
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 21:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914EA211A00;
	Sun,  8 Jun 2025 21:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="w9VG/uwr"
X-Original-To: linux-pm@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB3026AEC;
	Sun,  8 Jun 2025 21:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749418321; cv=none; b=CpVptAhiB0EHL7fUbUNcBBMQil3R2mWBtegvRmpLuYZ37NBLndDr5qOA5OVWcSZRyxCcAjLvaq5vXKfXjlInE0svYAejJlAahiARt85rF/jWtKaiq25a4gb+I6A12weCJS054hU6j4ZynUtDWxtiopJw7AOGXhnj9vvxMQj4J9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749418321; c=relaxed/simple;
	bh=ulUePR5jT4qAREe0JlQxVCloNhSU+AG4wpLgSicpXVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ap7n79IiT76/tx5ab+wcmkvfny4n+yfCyrMl6PbADAhTep9FuyrbTdfUUJ0X10/wrNilfH7qgMyGz7WRp1qm/OjxgVX3b2Ycgn6qFHaQqat7gojSjKUneicONGpC8KvrZKJrXCZW4y98NQ4w7tCmGSViwMIW2jGUS32EKiFCoWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=w9VG/uwr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cNR/B7AqzdKfH857DzdE8tOVpJSvBSdIIAm71LoG8+Q=; b=w9VG/uwrH6ldVIbDNCSzexwlcA
	0IkhUzqmyvjr8S5smyyX/m9une4wVH4uaSieDcpqc0vdEgdI/OJckwaOmoF0++WOuysWVwbdKKNOO
	DZiNCTs/0sijtcNrgbwvQmednFxrbPPUH+WXRH8ZYxfB17hNyUJj3xP7iMFp8IU13dFI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uONcB-00F6it-L9; Sun, 08 Jun 2025 23:31:39 +0200
Date: Sun, 8 Jun 2025 23:31:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Wunderlich <linux@fw-web.de>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Jia-Wei Chang <jia-wei.chang@mediatek.com>,
	Johnson Wang <johnson.wang@mediatek.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 12/13] arm64: dts: mediatek: mt7988a-bpi-r4: add sfp
 cages and link to gmac
Message-ID: <934b1515-2da1-4479-848e-cd2475ebe98d@lunn.ch>
References: <20250608211452.72920-1-linux@fw-web.de>
 <20250608211452.72920-13-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250608211452.72920-13-linux@fw-web.de>

> +&gmac1 {
> +	phy-mode = "internal";
> +	phy-connection-type = "internal";

ethernet-controller.yaml says:

  phy-connection-type:
    description:
      Specifies interface type between the Ethernet device and a physical
      layer (PHY) device.
    enum:
      # There is not a standard bus between the MAC and the PHY,
      # something proprietary is being used to embed the PHY in the
      # MAC.
      - internal
      - mii
      - gmii
  ...

  phy-mode:
    $ref: "#/properties/phy-connection-type"


so phy-mode and phy-connection-type are the same thing.

> +	/* SFP2 cage (LAN) */
> +	sfp2: sfp2 {
> +		compatible = "sff,sfp";
> +		i2c-bus = <&i2c_sfp2>;
> +		los-gpios = <&pio 2 GPIO_ACTIVE_HIGH>;
> +		mod-def0-gpios = <&pio 83 GPIO_ACTIVE_LOW>;
> +		tx-disable-gpios = <&pio 0 GPIO_ACTIVE_HIGH>;
> +		tx-fault-gpios = <&pio 1 GPIO_ACTIVE_HIGH>;
> +		rate-select0-gpios = <&pio 3 GPIO_ACTIVE_LOW>;
> +		maximum-power-milliwatt = <3000>;

sff,sfp.yaml says:

  maximum-power-milliwatt:
    minimum: 1000
    default: 1000
    description:
      Maximum module power consumption Specifies the maximum power consumption
      allowable by a module in the slot, in milli-Watts. Presently, modules can
      be up to 1W, 1.5W or 2W.

I've no idea what will happen when the SFP core sees 3000. Is the
comment out of date?

	Andrew


