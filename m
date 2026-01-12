Return-Path: <linux-pm+bounces-40633-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DEAD10AFB
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 07:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C882D3014D06
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 06:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77C630FC3E;
	Mon, 12 Jan 2026 06:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="uq1dP1BV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0225D30F957;
	Mon, 12 Jan 2026 06:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768198350; cv=none; b=pnO5F9pCUazEwUp6/N8QNGGfsPldiL1EL2BFYSFeGvy35vkS70Knle2wKHTJ99r5UsmtZewglJuGcYGVbuhdfv2esf8gEQA0NH4FcOBqS5hgwGha1OlWK+4kX8Xxpl5thAw4T4LuKIOMytXX+t/KHHogvK4n4se43lMCN5vBZhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768198350; c=relaxed/simple;
	bh=+SGf4libGVdNXJV9v0/S0onexs0g3pT9eFFgCb00a10=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+LAjizWarx4BY+WlHlDbhnR7q32p5knhWBxkZHBGz/MYJft+8ETcLsIW8ndzG45GfBIlqRV61vcPKgVERi7cdpbxNIthVc8E2mdosUiG1bfh5n03mTEwWR/Yb8xmdel9YOuAaiox1Vvs1wgGEsasoaX4FjfLVzITElJ+rcPWkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=uq1dP1BV; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ve92YUW7iH3/QlkHPuIVpDeUN4D/2BbrxLi4m8BkSl8=; b=uq1dP1BVCEAF9MM+o2IEkLGwW7
	6wo0D+4c3S3qLC2iRmTdyQzEZjW/48XRKQrHnvrlLChVejQkou7dFkaGg5r1lqKfBK8EZs+AVEa0t
	7kc3v4Z1zRC7yATRQvbWSFbkdIbKkNVo5DH3jaNgHWzm5RQwDomMT0VWaNw+v615IbJ9lYnqQfHQj
	YF1dZkCg22Hf0I2vdsLOwZg4/VOrc6ilpv2JEhXlQ3NSc25/SX5f+kpkTix9EuBVnr0RchgTu6s22
	B3xu9EQFW1bFebjGWYsuV5zYeY2YeBHdSXHQbMTvx7WzSOkeUpd5vjZl8KjvWmv65CI4RQ1Mblqbd
	btdw1DFw==;
Date: Mon, 12 Jan 2026 07:11:57 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Lee Jones <lee@kernel.org>, Pavel
 Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Linus
 Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-rtc@vger.kernel.org
Subject: Re: [PATCH RESEND v6 16/17] power: supply: bd71828-power: Support
 ROHM BD72720
Message-ID: <20260112071157.1ce876d6@kemnade.info>
In-Reply-To: <aWRERf70jg-IzqIx@venus>
References: <cover.1765804226.git.mazziesaccount@gmail.com>
	<fb74c0cab3dfe534135d26dbbb9c66699678c2de.1765804226.git.mazziesaccount@gmail.com>
	<aWRERf70jg-IzqIx@venus>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Jan 2026 01:51:58 +0100
Sebastian Reichel <sebastian.reichel@collabora.com> wrote:

> Hi,
> 
> On Mon, Dec 15, 2025 at 03:21:19PM +0200, Matti Vaittinen wrote:
> > From: Matti Vaittinen <mazziesaccount@gmail.com>
> > 
> > The ROHM BD72720 is a power management IC with a charger and coulomb
> > counter block which is closely related to the charger / coulomb counter
> > found from the BD71815, BD71828, BD71879 which are all supported by the
> > bd71828-power driver. Due to the similarities it makes sense to support
> > also the BD72720 with the same driver.
> > 
> > Add basic support for the charger logic on ROHM BD72720.
> > 
> > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > 
> > ---
> > Revision history:
> >  v2 => :
> >  - No changes
> > 
> >  RFCv1 => v2:
> >  - Support using 9-bit register addresses (offset of 0x100) with the
> >    BD72720
> >  - Simplify probe and IC data as we don't need two regmaps
> >  - Drop two BD72720 specific functions as we no longer need different
> >    regmap for it.
> > 
> > Note: This patch depends on the series: "power: supply: add charger for
> > BD71828" by Andreas:
> > https://lore.kernel.org/all/20250918-bd71828-charger-v5-0-851164839c28@kemnade.info/  
> 
> That should be in v6.19?
> 
yes, it is.
Just this note survived...

Regards,
Andreas 

