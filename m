Return-Path: <linux-pm+bounces-2813-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 565E083DF3E
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jan 2024 17:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBAD11F27E8C
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jan 2024 16:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A531C1DDF5;
	Fri, 26 Jan 2024 16:52:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167B21DFF8
	for <linux-pm@vger.kernel.org>; Fri, 26 Jan 2024 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706287936; cv=none; b=btzKFpIAkv7+wGRc7G0aFNIKu+msrMB4IkDZY9Wvs8a6UuyKs/I5TBIKPK/IM1/56U07zx1tZ6WJQpPr1cuuwPhYsmD/auShY5364ogyoH7u2tpWJOm8BrWftziT8Z6lRh3aJ9iuqNl1s6h5RX+2PTp8aTZDvcTy8e6ZXuJbNOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706287936; c=relaxed/simple;
	bh=W2rg+Qlv7l5DQXS9S0LSqEVQ2IDHN1Raczz6L69DN6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XspmnceIakT1qY/zF72hEmSvqmlKpK5THp2IoZSNNvLQyaQZ4guQWgsrPfQOXVYGO6nkwc5hP2MzcUeQofBCTKD44SPGtWKatkFApKCM5L4c4I3Mf1FJbiF9io3dCIb2LFe6BbJ24ylpLDnqi/bqT5taQtJ38MA8i6/BD5Two2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rTPQo-00021k-Um; Fri, 26 Jan 2024 17:51:54 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rTPQn-002YB1-O1; Fri, 26 Jan 2024 17:51:53 +0100
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rTPQn-001yTx-Kl; Fri, 26 Jan 2024 17:51:53 +0100
Date: Fri, 26 Jan 2024 17:51:53 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	kernel@pengutronix.de, linux-pm@vger.kernel.org,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH v2 4/8] dt-bindings: power: reset: add bindings for NVMEM
 hardware storing PSCR Data
Message-ID: <20240126165153.GA468528@pengutronix.de>
References: <20240124122204.730370-1-o.rempel@pengutronix.de>
 <20240124122204.730370-5-o.rempel@pengutronix.de>
 <4e14b7c7-7f0a-437b-aa84-20fdc30a2361@linaro.org>
 <20240125171146.GC381737@pengutronix.de>
 <58d24ddc-4e8f-4932-ac37-c9a699d36425@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58d24ddc-4e8f-4932-ac37-c9a699d36425@linaro.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

On Fri, Jan 26, 2024 at 10:03:51AM +0100, Krzysztof Kozlowski wrote:
> On 25/01/2024 18:11, Oleksij Rempel wrote:
> > On Thu, Jan 25, 2024 at 11:57:18AM +0100, Krzysztof Kozlowski wrote:
> >> On 24/01/2024 13:22, Oleksij Rempel wrote:
> >>> Add device tree bindings that describe hardware implementations of
> >>> Non-Volatile Memory (NVMEM) used for storing Power State Change Reasons
> >>> (PSCR).
> >>> +  that stores Power State Change Reasons (PSCR).
> >>> +
> >>> +allOf:
> >>> +  - $ref: pscrr.yaml#
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    const: pscrr-nvmem
> >>> +
> >>
> >> So that's a driver :/. Maybe Rob will like it, but it's a no from me.
> >> Please come up with something really suiting DEVICES, not DRIVERS.
> > 
> > If I understand your distinction between 'DEVICES' and 'DRIVERS'
> > correctly, 'DEVICES' in the device tree context are meant to represent
> > physical hardware components, while 'DRIVERS' refer to software
> 
> Yes.
> 
> > abstractions of these components. However, there are numerous device
> > tree instances, like software-based implementations for SPI, I2C, or
> > GPIO, which could also be interpreted as 'DRIVERS' in the context of
> 
> True. Yet they are still for physical interfaces. There is no DTS having
> some virtual I2C for a board which does not have I2C.
> 
> > your email. Similarly, the binding for PSCRR represents functionality not
> > fully implemented in hardware but supported by the hardware component of
> > NVMEM, akin to how ramoops or other functionalities are represented.
> 
> You don't need a binding for your case. Instantiate it whatever you wish
> - modprobe for example - and configure through approved kernel
> interfaces - sysfs for example.

About using sysfs for the NVMEM cell, it won't work for my needs because
I have to know about reboot events before the filesystem is ready. So,
I'm thinking of using a boot parameter for the kernel. It would look
like this: pscrr-nvmem.nvmem_cell_alias=nvmem-cell0. This way, I can set
up the NVMEM cell right at the system's start. I'll need to use stable
NVMEM cell names for this. Is it ok to introduce NVMEM cell aliases in
the devicetree?

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

