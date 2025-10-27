Return-Path: <linux-pm+bounces-36931-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B93C118A1
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 22:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 785955676A6
	for <lists+linux-pm@lfdr.de>; Mon, 27 Oct 2025 21:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F0E32A3C1;
	Mon, 27 Oct 2025 21:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="e3aTg1F2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF372D12EB;
	Mon, 27 Oct 2025 21:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761600048; cv=none; b=i3C8uvVKQkWWfh28EASEland1k1oOjCr1QWQoYrq0Mgq8u3gwYGMqGJk3vQw+gMNL2aQUVkG8O4h0LU1vnFu0RC2VnLm46LQYfzwzqhqConB1VjeCVmVcTmN7AYu5UaPeuW7oR+gZs1M52JsxeqhsLMCCNx7OOSXzBIZ09yr0x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761600048; c=relaxed/simple;
	bh=WdB03435Zh9oOe8E/xtnII4LlDCfPD1BB+UpVU/QVcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XsocM5/aJEUT6fWQmFWafn7wSLV0/DLR0TM27RMOl9PVVW8vHGg7c7lhD0aZaXcAgjypd5OVu84N1ARrlaOYdVJatmtLx1g7m0bZg+kCWSQ3I4GRV8dQadlLxk5o4k9V1R8s6GsOC0PM1wSjckdSVAxodDQvvBx9/SFWZ6vcVfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=e3aTg1F2; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=BbTTW4ZryieMhzoDKkZ0R/XcaSkMUIf9Zm/D+nSMP0c=; b=e3aTg1F2EmnARg+p4YrNnlxjDU
	HKu7S/7SIIVSul5g3RVRZ4lsErNmPkPv13WiObugYbaG1Q6zgXX6CFCu30+U5cGWXx31ClPq0mxJR
	O6ZAWHOXTT9t4JjXun+cy3t4T33ZM+xZAMXyfQMGdv6YeFmwiUajfSSwH1xSf4wYFj6H8Zi3it+Eg
	kI+NeHTDBY18M+bImUbkpF98yceVUnfkQA8FQEsfsx2ph0Emhy3WmRDDogxRkYoevu5UIshbhVcoJ
	K3VGATU+2qJR6lPaA//igBcOgbBQBPe7oulUGGwduxOmenYYtCBkbnKciTuNHzRVuIBpBhIEpsZdD
	z6ZkWRqA==;
Date: Mon, 27 Oct 2025 22:20:30 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lee Jones
 <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2 04/15] dt-bindings: mfd: ROHM BD72720
Message-ID: <20251027222030.560def67@kemnade.info>
In-Reply-To: <a5957c4f83724d4f32527fb892fc340af4eeddde.1761564043.git.mazziesaccount@gmail.com>
References: <cover.1761564043.git.mazziesaccount@gmail.com>
	<a5957c4f83724d4f32527fb892fc340af4eeddde.1761564043.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Oct 2025 13:45:46 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The ROHM BD72720 is a power management IC integrating regulators, GPIOs,
> charger, LEDs, RTC and a clock gate.
> 
> Add dt-binding doc for ROHM BD72720.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
[...]
> +
> +  rohm,charger-sense-resistor-milli-ohms:
> +    minimum: 10
> +    maximum: 50
> +    description: |
> +      BD72720 has a SAR ADC for measuring charging currents. External sense
> +      resistor (RSENSE in data sheet) should be used. If some other but
> +      30 mOhm resistor is used the resistance value should be given here in
> +      milli Ohms.
> +
rohm,bd71828.yaml has rohm,charger-sense-resistor-micro-ohms, lets
keep that unified.

Regards,
Andreas

