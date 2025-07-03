Return-Path: <linux-pm+bounces-30037-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C3EAF7296
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 13:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CECD4E5933
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 11:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B982E427C;
	Thu,  3 Jul 2025 11:36:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E122E4279;
	Thu,  3 Jul 2025 11:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751542591; cv=none; b=efa7bUz7NEJPP8Wjb36QgO740maQbWqH7bRHFHm+AqrdtYBzgDqJiws/27TaYmnhAVy75g+w6GkK76LrD4AbIi4ShlMl6VeANILMOqIYIE+MbmIdUbdbglR9hFcUsBipUcvsXwZ9mjyM6vq2eLOchWMXR240ZzNqqfi+musPdIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751542591; c=relaxed/simple;
	bh=Sy5KK+ahsW1yAaKri1MbI11E8xyt8D6mK1pL569PzGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzCbqxIusMJgH8Mn6n38uag2zlPgrwLErbnq9YDsYXQ2YB0X4n9lx8rzykbZNcEm8kcRkdESS17iOPCDtlhA3zEgn25CohOhotSeBcSHn0TkuHHD7hSqGx86f0DhTgmQqOO+Ak1BZG7zTGb0WM1sWtGeQQas/W4rRQRq+sOjHk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uXIES-000000004sT-1IDF;
	Thu, 03 Jul 2025 11:36:00 +0000
Date: Thu, 3 Jul 2025 12:35:56 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Frank Wunderlich (linux)" <linux@fw-web.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, frank-w@public-files.de,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Johnson Wang <johnson.wang@mediatek.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v7 01/14] dt-bindings: net: mediatek,net: allow irq names
Message-ID: <aGZrHMnpMMzNkIjF@makrotopia.org>
References: <20250628165451.85884-1-linux@fw-web.de>
 <20250628165451.85884-2-linux@fw-web.de>
 <20250701-wisteria-walrus-of-perfection-bdfbec@krzk-bin>
 <9AF787EF-A184-4492-A6F1-50B069D780E7@public-files.de>
 <158755b2-7b1c-4b1c-8577-b00acbfadbdc@kernel.org>
 <b68435e3e44de0532fc1e0c2e7f7bf54@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b68435e3e44de0532fc1e0c2e7f7bf54@fw-web.de>

On Thu, Jul 03, 2025 at 01:01:40PM +0200, Frank Wunderlich (linux) wrote:
> Am 2025-07-02 08:27, schrieb Krzysztof Kozlowski:
> > On 01/07/2025 12:51, Frank Wunderlich wrote:
> > > Am 1. Juli 2025 08:44:02 MESZ schrieb Krzysztof Kozlowski
> > > <krzk@kernel.org>:
> > > > On Sat, Jun 28, 2025 at 06:54:36PM +0200, Frank Wunderlich wrote:
> > > > > From: Frank Wunderlich <frank-w@public-files.de>
> > > > > 
> > > > > In preparation for MT7988 and RSS/LRO allow the interrupt-names
> > > > 
> > > > Why? What preparation, what is the purpose of adding the names,
> > > > what do
> > > > they solve?
> > > 
> > > Devicetree handled by the mtk_eth_soc driver have
> > > a wild mix of shared and non-shared irq definitions
> > > accessed by index (shared use index 0,
> > > non-shared
> > > using 1+2). Some soc have only 3 FE irqs (like mt7622).
> > > 
> > > This makes it unclear which irq is used for what
> > > on which SoC. Adding names for irq cleans this a bit
> > > in device tree and driver.
> > 
> > It's implied ABI now, even if the binding did not express that. But
> > interrupt-names are not necessary to express that at all. Look at other
> > bindings: we express the list by describing the items:
> > items:
> >   - description: foo
> >   - ... bar
> 
> ok, so i need to define descriptions for all interrupts instead of only
> increasing the count. Ok, was not clear to me.
> 
> so something like this:
> 
> item0: on SoCs with shared IRQ (mt762[18]) used for RX+TX, on other free to
> be used
> item1: on non-shared SoCs used for TX
> item2: on non-shared SoCs used for RX (except RSS/LRO is used)
> item3: reserved / currently unused
> item4-7: IRQs for RSS/LRO

These descriptions match the current *software* use of those interrupts,
however, DT should describe the hardware and esp. item0 up to item3 could
be used in different ways in the future (by programming MTK_FE_INT_GRP
register differently).

I think using interrupt-names fe0...fe3 and pdma0...pdma3 is still the
best option, so the driver can request the interrupts by name which is
much more readable in the driver code and SoC's dtsi than relying on a
specific order.

> > 
> > There were only 4 before and you do not explain why all devices get 8.
> > You mentioned that MT7988 has 8 but now make 8 for all other variants!
> > 
> > Why you are not answering this question?
> 
> The original binding excluded the 4 RSS/LRO IRQs as this is an optional
> feature not
> yet available in driver. It is needed to get the full speed on the 10G
> interfaces.
> MT7988 is the first SoC which has 10G MACs. Older Socs like mt7986 and
> mt7981 can also
> support RSS/LRO to reduce cpu load. But here we will run into the "new
> kernel - old
> devicetree" issue, if we try to upstream this. Maybe we do not add this
> because these
> only have 2.5G MACs.

It might be important to note that

MT7621, MT7628: 1 IRQ
MT7622, MT7623: 3 IRQs (only two used by the driver for now)
MT7981, MT7986: 4 IRQs (only two used by the driver for now)

While older SoCs MT7981 and MT7986 have limited support for *either LRO
or RSS* in hardware, only MT7988 got 4 frame-engine IRQs like MT7981 and
MT7986 and an additional 4 IRQs for the 4 RX DMA rings on top of that,
so a total of 8, and can do both RSS and LRO.

