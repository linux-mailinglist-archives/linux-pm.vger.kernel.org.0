Return-Path: <linux-pm+bounces-35970-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FA6BD32AF
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 15:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6145F4F159D
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 13:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C13C274B39;
	Mon, 13 Oct 2025 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="yPRCbj3w"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B108A1FDA;
	Mon, 13 Oct 2025 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760361559; cv=none; b=tB65P+t61kuxRcbFzyPvONoPIAqd4SqpJ6HBQt95aEDe/ZsfYFb23fBJLRNyimWZx28WcLTUx0T86CA+wShzVAdnraIfMWXeBYzx2d4+FFZuoLd50tFDlFGPke3p9dwzlOOgc0DXRWzwQiPBuOWLz+SADPwV5yKxAvP3FjMLiJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760361559; c=relaxed/simple;
	bh=b+tLPeMD1Z5B1winxVP0fpDzZ4Ft1DgcmZYnxUfJFCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g0qvyUYZSDw6kiKEKWATmi1y64bQ7Y4DmPC9432WmwxxDjnQH+DAjrq4cbl37Cyg4jhMhQPdO0LI+cAkWozZzQbYbnxXB5csZpDNsKcxmsuf/t/tHD+TlX3lhIPZ0apxiuiZB9AsKAJuqtEWQjXjQO2M/xw2TPZvoEqNbEf+ya8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=yPRCbj3w; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=cpFL1cZfIfuJbSy7oDZfLNOPydM7RMbiykjJfKLFtHQ=; b=yPRCbj3w+JzG2CxEWEcVvcjBza
	hkRNX7lqUR5By+Cmgf8/uqmkX24qVNgDoa3x8PbKuUv6UjeNsOJxDSx5yciVVNZbfExnzKfJI0GGT
	Y7hg2WN5XBcJqLyWQPP04Ru9M8Z0eepchHT+D9spikwHkELmqnNxbvbAAJyz7NPDJ+jybyHA+8wku
	2pRjIZ9FPfgP+6ywNrFskufsFV4Jh0uSzKcEN8P88dFmNqBAIqhkpHAKzwboeFW3JLXmJcqmYy+cG
	sABRGdGAF7n1+NvMYbqvXXcvveoBG/Th5A3Bo1FqRKmvIir+JuI0nOIKMoUdfGX99g4uIhFDS6MK/
	XROuw62A==;
Date: Mon, 13 Oct 2025 15:19:00 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Pavel Machek <pavel@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus
 Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-gpio@vger.kernel.org
Subject: Re: [RFC PATCH 06/13] mfd: bd71828: Support ROHM BD72720
Message-ID: <20251013151900.3e4cc69f@kemnade.info>
In-Reply-To: <d2295506-bf70-4142-8537-0fdf9cb04a30@gmail.com>
References: <cover.1759824376.git.mazziesaccount@gmail.com>
	<93142a80d90a0ac80b27090d0c83914675aad94d.1759824376.git.mazziesaccount@gmail.com>
	<20251009161847.GE2890766@google.com>
	<8ea507eb-f78c-4a16-882b-112e277fa1b6@gmail.com>
	<20251010150317.07bfdbe8@kemnade.info>
	<d2295506-bf70-4142-8537-0fdf9cb04a30@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Oct 2025 12:27:33 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Hi Andreas!
> 
> First of all, thanks for taking a look at this!
> 
> On 10/10/2025 16:03, Andreas Kemnade wrote:
> > On Fri, 10 Oct 2025 15:09:07 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >>>> +static int bd72720_get_secondary_regmap(struct i2c_client *i2c,  
> >>>
> >>> Does this 'secondary' have a specific purpose or a better name?  
> >>
> >> I am not entirely sure. When I asked this from the designers they just
> >> told me that they needed more than 255 registers so they added another
> >> slave address... (I'm not sure what would have been wrong with using a
> >> page register). So, I assume they just placed stuff that didn't fit in
> >> first 255 register there. But yeah, it looks like most of the registers
> >> there are related to the charger. So, perhaps it isn't completely
> >> misleading to use "charger regmap"? The data-sheet seems to be just
> >> using "Register map 1" and "Register map 2" in the tables listing these
> >> registers. I kind of like using something which maps easily to the
> >> data-sheet, but I really have no strong opinion on this.  
> > 
> > just another idea: What about one regmap with custom functions covering
> > both these adresses? Maybe that could even be added to the regmap
> > functionality, maybe with a 0x100 offset for the second range.
> > That way the rest of the code only needs to real with one regmap
> > and properly defined registers.  
> 
> Interesting idea.
> 
> I suppose you mean something like implementing custom remap_read() and 
> regmap_write() - which would practically select the I2C adapter to use 
> based on the register address - and then doing same thing as the 
> regmap_i2c_smbus_i2c_write() / regmap_i2c_smbus_i2c_read() do?
> 
> I suppose this would mean duplicating the functionality provided by the 
> regmap_i2c_smbus_i2c_write() and the regmap_i2c_smbus_i2c_read(), which 
> are static. It'd also mean we'll lose the 1 to 1 mapping between the 
> register addresses in driver and addresses in the data-sheet. I agree 
> this wouldn't be such a huge thing if we used offset like 0x100 though.
> 
Well, you could also stack regmaps like ntxec.c is doing (but there
for some very weird reason). That would avoid duplicating code.

I have no strong opinion here.

Regards,
Andreas

