Return-Path: <linux-pm+bounces-38031-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B18B3C5CD82
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 12:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0673C4F094B
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 11:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316E9313537;
	Fri, 14 Nov 2025 11:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="b8JITQcs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419502FB0A0;
	Fri, 14 Nov 2025 11:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763119142; cv=none; b=pnKZVFXx4wftVJyU7PMarGan3LqhU5z5l8ffqzjyV5TO1DVWRTgO1yIlqMWYw3+I7a18PiV8h2j8+oJ5MkrkpHYmQ00U5FaUJJm5Rre374mdYaEn1eRDcv3ZNR4AStGLXDLfduO5bHUi13WfvFQkyVC/DwKj1Nx+xPnCmHWSh2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763119142; c=relaxed/simple;
	bh=z6ucqdb/0st4NAumZ4Bw1GemAW/J5iVOQBoH6CJ5vm0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EHOtx9q6hvmf/0gYnsM3wuL3y7FXS71dy4DvuZcnFqGvzRHvQRzdnQfk1ofJttKaEAb5+ERIFB2byN0jpOOXQEFYQw5v8948zBuAJwjLhdPJyCZ4Y5nP3rNK3aKM+NggoXf0R+mf7NUMbZn9yhWKOKW+Kirhf1QTDcQbU6kTWEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=b8JITQcs; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=z6ucqdb/0st4NAumZ4Bw1GemAW/J5iVOQBoH6CJ5vm0=; b=b8JITQcs5h8uu12DVMMbHGo5/2
	iaSj7J2xvpXFExT2UxyuuCyNqm563s3uaM12qiASLQyhDt30y6aWAcOYQ9wfJVWcswZYUjLUyVX/w
	0W8RzXSFGcnKUFamVrOeaRsWMi+B32eYK6HXddUU3LTM/IeVBu03q5mQvQvvLSts/57Z3/cTKiA7M
	6VIwjWkCfFpvOeIH/T9briF4qGSQ41ZRtXAtMHVM50fDJ3UoieVRCXgCB3C0gHnQ/UyEx7jkIKEtM
	bDkIbGKVaQH/imazPtm2/vT0FrwRLj7lNsy4Stc9uSpa7wfGKXpZwdrPt3OO1AAB1/kulFx7b3WCH
	IIYRztcw==;
Date: Fri, 14 Nov 2025 12:15:09 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Lee Jones <lee@kernel.org>, Pavel
 Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v4 14/16] power: supply: bd71828: Support wider register
 addresses
Message-ID: <20251114121509.629d171b@kemnade.info>
In-Reply-To: <6248200397d3582fe926938736da66d6bbf9535d.1763022807.git.mazziesaccount@gmail.com>
References: <cover.1763022807.git.mazziesaccount@gmail.com>
	<6248200397d3582fe926938736da66d6bbf9535d.1763022807.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Nov 2025 10:55:39 +0200
Matti Vaittinen <matti.vaittinen@linux.dev> wrote:

> As a side note, we can reduce the "wasted space / member / instance" from
> 3 bytes to 1 byte, by using u16 instead of the unsigned int if needed. I
> rather use unsigned int to be initially prepared for devices with 32 bit
> registers if there is no need to count bytes.

Well, this is totally internal to the module, so no ABI/API changes, so
there is no advantage of using 32bit now I think. We can switch any time.
But we have 32bit stuff in the regmap cache anyways, so that is not above
the general level of wasting space.

Regards,
Andreas

