Return-Path: <linux-pm+bounces-28276-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3825AAD14A8
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 23:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EFC47A4CCD
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 21:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFEE25D20B;
	Sun,  8 Jun 2025 21:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AE0wCESV"
X-Original-To: linux-pm@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156151DED52;
	Sun,  8 Jun 2025 21:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749417828; cv=none; b=GhvHF04KAwWSwRtqcPLZW3/FhonhG/60AfTDC4U35Xrfe0FTmXhFQgGyQHF8TSyQvIoII3kiCWc9kZ86i/irrSIfgzDibY/pWvqfNGCkaznRWQJFB8a7eu7MrupTPzG1K1tbPw41roShtPbs7s2ezIbUVyg3UVlQ+qkhWCMsaQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749417828; c=relaxed/simple;
	bh=WJEH2etwcynU+UPKgXiBrqtDc3afsRIYVIBs2k0FJhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eg3hpcDWsyaDLHJh3VFG7A+E+F0nPogprDSqlGbm1EZnCKA+keChYwFHkjDf/EZcRDveZV3kNHC8i58DuvqBiiRvflWMLceOFUglf1v/ksTqHDoimZCvMFkG0ogX9FnDk1LaYWydetC/QEElAb2G25fIL3ytQtHRSHoteTVekt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AE0wCESV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=t6K1DK8TwWXVFwtnP7hylwxjWAnaQ8nQe4sIAcH0KiI=; b=AE0wCESVzCTtp0M8ElqNVDGXRM
	oGFM+uCGOfAOyb9B0QkwBlohtYwCV54AeYrviLNRh09FEZZ1gi+HBm2qSYdOXZkp2gl1Os+5gOl2n
	JGHmqqGaG2RRZpE83eoNbG+VjkxTaZ/EzB1CHOFam8alz/6jwvvpf+eXZzU2QF1nwqtY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uONU2-00F6eS-Px; Sun, 08 Jun 2025 23:23:14 +0200
Date: Sun, 8 Jun 2025 23:23:14 +0200
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
Subject: Re: [PATCH v3 06/13] arm64: dts: mediatek: mt7988: add basic
 ethernet-nodes
Message-ID: <cc73b532-f31b-443e-8127-0e5667c3f9c3@lunn.ch>
References: <20250608211452.72920-1-linux@fw-web.de>
 <20250608211452.72920-7-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250608211452.72920-7-linux@fw-web.de>

> +			gmac0: mac@0 {
> +				compatible = "mediatek,eth-mac";
> +				reg = <0>;
> +				phy-mode = "internal";
> +
> +				fixed-link {
> +					speed = <10000>;
> +					full-duplex;
> +					pause;
> +				};

Maybe i've asked this before? What is on the other end of this link?
phy-mode internal and fixed link seems an odd combination. It might
just need some comments, if this is internally connected to a switch.

> +			mdio_bus: mdio-bus {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				/* internal 2.5G PHY */
> +				int_2p5g_phy: ethernet-phy@f {
> +					reg = <15>;

It is a bit odd mixing hex and decimal.

> +					compatible = "ethernet-phy-ieee802.3-c45";

I _think_ the coding standard say the compatible should be first.

> +					phy-mode = "internal";

A phy should not have a phy-mode.

	Andrew

