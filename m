Return-Path: <linux-pm+bounces-32473-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD26B29225
	for <lists+linux-pm@lfdr.de>; Sun, 17 Aug 2025 10:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0E416FB92
	for <lists+linux-pm@lfdr.de>; Sun, 17 Aug 2025 08:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C281A704B;
	Sun, 17 Aug 2025 08:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="ptp9HLYf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439AC3176F3;
	Sun, 17 Aug 2025 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755418297; cv=none; b=l34JiBF2SN7Gx51+ZLfFbOKHlwikKlyvIRhEtUiiDfZhBPvZKrXPMVBSao699C9ECiIxsx9TvE6xjCS3x+h1KpCKB3CEFMZdK8p87SJc9vHK++cNe3OuOlYeDi8ffmwUHLhXXocBcB4k+SEtF47Yi6swoxCJ8eoCskwHDqqgQqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755418297; c=relaxed/simple;
	bh=9cKIpwfpd76s4SX839MHd2puU8y0zvewU1dqpii8VLM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V3f/Xp9IoYjKVys2eyznBY4XKnQ4+AgQmCaYdVpSVi1eW6l99eJ6k6UF44a5+tUEW5gshgWBkP2y0jxjgoXUOu6DyU32bgpB6MA8oqjbQldRK00o128rzR2vDvb0GsIEhsjzAGHwYGR2S2iUwaxditBtN+a42cU0Xi3Vxl4LP5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=ptp9HLYf; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Yzrez2PhIRgnpgnDDYVXxuPWw4oVVXpF1zgwKJH2Owg=; b=ptp9HLYfZsA43eVAwwpIh2GGmv
	NB93PtELwRF2bkSt17oZAneVKaFXDvv1XDWvRldaRhPMcq9Pv6UOYEvwNSj8AC2AHzXX9nYqp14dt
	63q9o9O4LCdW0YJLKqXer59OVO3wH33sNaVtZUv6d3Fl+Be8rI58Wd1Ydj1zdt1S3jddZYbaEyQ5H
	DDkZS3ACnNej/LuqYQmFhPgfHAXkq4MqKrF91IPbMcHRXteQE3Hxc0vuGfDlGM3GegBfAEFP6uXy1
	0e473GF4gPZKR7I9F/z4bpIPPujMuEt3/AMetDQoGA92DSaBDQdwRrDQMyPYyLSzYu4YXKbtVUhRx
	zq6njp+Q==;
Date: Sun, 17 Aug 2025 10:11:21 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Lee Jones <lee@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: Add bd718(15/28/78) charger driver
Message-ID: <20250817101121.19a86716@akair>
In-Reply-To: <bf82cd81-bcc7-4929-aa84-b749533d5b95@kernel.org>
References: <20250816-bd71828-charger-v1-0-71b11bde5c73@kemnade.info>
	<20250816-bd71828-charger-v1-2-71b11bde5c73@kemnade.info>
	<bf82cd81-bcc7-4929-aa84-b749533d5b95@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Sun, 17 Aug 2025 07:58:35 +0200
schrieb Krzysztof Kozlowski <krzk@kernel.org>:

> On 16/08/2025 21:19, Andreas Kemnade wrote:
> > Add charger driver for ROHM BD718(15/28/78) PMIC charger block.
> > It is a stripped down version of the driver here:
> > https://lore.kernel.org/lkml/dbd97c1b0d715aa35a8b4d79741e433d97c562aa.1637061794.git.matti.vaittinen@fi.rohmeurope.com/  
> 
> Why are you duplicating the driver? Why original cannot be used?
> 
> 
I am not duplicating the driver. That patch series never went in. I am
stripping it down to let things go in step by step. I have also talked
with Sebastian about this. And he also prefers a step by step approach
to have it more easily reviewed.
I also do not have the infrastructure to test things like capacity
degradation over time. There is non-trivial rebasing work involved, so
I even do not feel confident submitting such at all.
> ...
> 
> > +
> > +#define RSENS_DEFAULT_30MOHM 30000 /* 30 mOhm in uOhms*/
> > +
> > +static int bd7182x_get_rsens(struct bd71828_power *pwr)
> > +{
> > +	u64 tmp = RSENS_CURR;
> > +	int rsens_ohm = RSENS_DEFAULT_30MOHM;
> > +	struct fwnode_handle *node = NULL;
> > +
> > +	if (pwr->dev->parent)
> > +		node = dev_fwnode(pwr->dev->parent);
> > +
> > +	if (node) {
> > +		int ret;
> > +		uint32_t rs;
> > +
> > +		ret = fwnode_property_read_u32(node,
> > +					       "rohm,charger-sense-resistor-micro-ohms",  
> 
> Hm? Are you writing ACPI or DT driver?
> 
I am writing a driver for a platform device which gets information via
dt properties. The property is defined in
Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml

[...]

> > +	pwr->bat = devm_power_supply_register(&pdev->dev, &bd71828_bat_desc,
> > +					      &bat_cfg);
> > +	if (IS_ERR(pwr->bat)) {
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(pwr->bat),
> > +				     "failed to register bat\n");
> > +	}
> > +
> > +	ret = bd7182x_get_irqs(pdev, pwr);
> > +	if (ret) {  
> 
> Please run scripts/checkpatch.pl on the patches and fix reported
> warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
> patches and (probably) fix more warnings. Some warnings can be ignored,
> especially from --strict run, but the code here looks like it needs a
> fix. Feel free to get in touch if the warning is not clear.
> 
> Drop {}
> 
> This applies to other places as well.
>
ok, I have forgotten the --strict. And {} around multiline things do
not trigger anything at my brain, even if it just a single statement.
BTW: Is there any way to mark warnings as handled if they can be
ignored, so that I do not see them in subsequent submissions?

Regards,
Andreas

