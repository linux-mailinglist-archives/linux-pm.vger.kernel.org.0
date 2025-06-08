Return-Path: <linux-pm+bounces-28279-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72440AD14B2
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 23:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 909BE7A2DD0
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 21:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B643C2629C;
	Sun,  8 Jun 2025 21:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TKVshFrl"
X-Original-To: linux-pm@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2140B25C70C;
	Sun,  8 Jun 2025 21:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749417933; cv=none; b=o40/AU1c8hnd1OgxO/3PpRwTwerfQIWr8kapqQOSaQjAAnm9fimqMCELW9Dx+Av0L7NbWyfdNy+MAPYuX2tZ1fyzrJbRn3VJJvN0+p34b9qvhD577o9M77aQJchy+38XKm++44RYNYONJ7c5HKtwntjJ8gNQr9jycHiOMWSRqXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749417933; c=relaxed/simple;
	bh=xl4y0i3YhCOPQ0cTxa+mPgTY1GeEUKzUFI1a2mwOvH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNcHhnhe7mD4Vr0iSrqBEhx9vun2Xl8UphC0Ia2lHuUuGQDbz0SXPIhHKk3/JfBezMJBUJMwbtCYMfXCKAXLM8rTckLN4uy1KiqRxEwCFrJHv7WpDeCFEWx6NIirMzVJ1ussDpatbzRQm60/NUbSTDQE4vzZRr048IqzHQlFVQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TKVshFrl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=E/mQ7BoLcVrO59Xnl3ZQlHndr969rCpRyg45FKaGvoI=; b=TKVshFrl5DXthqifrs05BGdJyK
	m8KjuamhBugZEL/wfcv5dN1DjtwKrWBClnWVuqVwuPgQd1VAe48o6HiestzuDpnHgwFmkwUJG7mKM
	yWD6DPX6+v2jJXY25PcJGwPiROdNZ3cbFLznRaparNONitVTfLHH1/MwmKmBaayYjDlw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uONVw-00F6gT-IO; Sun, 08 Jun 2025 23:25:12 +0200
Date: Sun, 8 Jun 2025 23:25:12 +0200
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
Subject: Re: [PATCH v3 07/13] arm64: dts: mediatek: mt7988: add switch node
Message-ID: <1fdfba6b-1bf6-4865-be21-2b4d716fbfc0@lunn.ch>
References: <20250608211452.72920-1-linux@fw-web.de>
 <20250608211452.72920-8-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250608211452.72920-8-linux@fw-web.de>

> +			mdio {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				mediatek,pio = <&pio>;
> +
> +				gsw_phy0: ethernet-phy@0 {
> +					compatible = "ethernet-phy-ieee802.3-c22";
> +					reg = <0>;
> +					interrupts = <0>;
> +					phy-mode = "internal";

More phys with a phy-mode?

	Andrew

