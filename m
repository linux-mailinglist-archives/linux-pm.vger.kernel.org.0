Return-Path: <linux-pm+bounces-35916-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 000D2BCD461
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 15:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7CDD4E7451
	for <lists+linux-pm@lfdr.de>; Fri, 10 Oct 2025 13:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF112EF667;
	Fri, 10 Oct 2025 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="0MKOFklB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEC636124;
	Fri, 10 Oct 2025 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760103145; cv=none; b=Sf+tXGarHrp7W/qZ0pY6mhs1M5z9KKHxAl8gY4NyDg+tqjwGVTTaaaQqRKzMDF6BnhcOGu44hjf6aegk4yL94+DnAA6PUTE6Hxj1gcPuJFLAggqMFJaqC77xMnpkflq664bLW40Z2c/FK3AW58H4iSF+XCXJGLHn/R3HJOvLGEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760103145; c=relaxed/simple;
	bh=L1mxjc3vEMzvfhqtIRO/TZU1fKDHV/7hfClukOwAZlo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BHVNafdfBDQx0bKKZekS0Z7OyatzvAe2LcZhRZALGcnaprF/bcR83pkJThNSdSZbDCySVkeKrEj9/7ATzzZYQizpHnHUBzMcTClDKYZ6wgSS3+CpIBfDtFC4601RqIr7vy2cQslGwZN8pmns8Lz6yEEks2nZm1i0wjF/clauzaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=0MKOFklB; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=3KMQtPTOJlK5A++4JQLg5NdQVOVsWRcGypuzvqgltuo=; b=0MKOFklBtsJ/K9bOi9B/H1SJ4L
	f5Qbm58Ui4astvMBmyVMZ+s5+l6ZsNb06Y5bwM+fPRXzcS/yO3TjjKs9acQwuYeHd3PAd32+QLGVd
	aOFjx5cC1NqB7jKZeEaHVpBfK2pPozN578PfIjO9yt/VYP4RMLW3gHnZR/QgL0z56+q9xJEQTt0Rb
	IvIOB7uf7lH0NcOv5QJqEPOhFySYaQM0FJ+8twRV8ehzLArz0fjO+xo50vpMSdYMPJPlduPUciXgA
	9ZETzZNOsLkWDdzUYLt1yKcdJSGh2M7RAsYZxlpfRuosH8D8DHkrDZGABG5GkZBsOUSslODnXjZ9I
	TSYUWu7g==;
Date: Fri, 10 Oct 2025 15:03:17 +0200
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
Message-ID: <20251010150317.07bfdbe8@kemnade.info>
In-Reply-To: <8ea507eb-f78c-4a16-882b-112e277fa1b6@gmail.com>
References: <cover.1759824376.git.mazziesaccount@gmail.com>
	<93142a80d90a0ac80b27090d0c83914675aad94d.1759824376.git.mazziesaccount@gmail.com>
	<20251009161847.GE2890766@google.com>
	<8ea507eb-f78c-4a16-882b-112e277fa1b6@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Oct 2025 15:09:07 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> >> +static int bd72720_get_secondary_regmap(struct i2c_client *i2c,  
> > 
> > Does this 'secondary' have a specific purpose or a better name?  
> 
> I am not entirely sure. When I asked this from the designers they just 
> told me that they needed more than 255 registers so they added another 
> slave address... (I'm not sure what would have been wrong with using a 
> page register). So, I assume they just placed stuff that didn't fit in 
> first 255 register there. But yeah, it looks like most of the registers 
> there are related to the charger. So, perhaps it isn't completely 
> misleading to use "charger regmap"? The data-sheet seems to be just 
> using "Register map 1" and "Register map 2" in the tables listing these 
> registers. I kind of like using something which maps easily to the 
> data-sheet, but I really have no strong opinion on this.

just another idea: What about one regmap with custom functions covering
both these adresses? Maybe that could even be added to the regmap
functionality, maybe with a 0x100 offset for the second range.
That way the rest of the code only needs to real with one regmap
and properly defined registers.

Regards,
Andreas

