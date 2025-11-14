Return-Path: <linux-pm+bounces-38010-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76841C5B3E4
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 04:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 511423B7606
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 03:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4934270541;
	Fri, 14 Nov 2025 03:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0l14hSd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936A5258CF0;
	Fri, 14 Nov 2025 03:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763092394; cv=none; b=pYc+Z9termWXZaJzKGyjmm1f2pMK3s1efbBKaXSb9uOnBHxWafq2lVHi8F3X0o5sro8kYLm8LDOKg8BMnhsxmvu3xVMT0j/p2M3CLARTWnfmqctFQrAJ8WmxNMrHH2asdXcvBwFJWKUZjrmUoCdbDAzyP3ynzygXoDmKt8XicBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763092394; c=relaxed/simple;
	bh=DuBjJuFRKUpFXwJ785dS3UGxZUQ5KPJP2I7pnElYD78=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=K550eVDCpu2kA5oi8VYmlPAdU6Ec5sQp+zXmci3mNnS2kWa2dv9P4mmw5grpWGOZrifNRazlIVWh68TALnsCsGyIn0ZonQV6ZMXPvJe7ESmuBrX59sxGVJrDH3q+oOAjCxGBE7jQ0DUXlLIXkK/C/EbS+5CT7uFhQZEbdUU1I68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0l14hSd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128A5C4CEF1;
	Fri, 14 Nov 2025 03:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763092392;
	bh=DuBjJuFRKUpFXwJ785dS3UGxZUQ5KPJP2I7pnElYD78=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=G0l14hSdwNg85QdevSgBa7tqTSZRGuKgiigBDJF4YRYXZzT5E56mg9ld1pKWM4xwW
	 Zjg5GQ0dFt1UKQPzsrl8tiw4AsBfgiKTlP6WeAH7z/eNNW3mJxJsn9wAhMWyl1158D
	 vXWvBhudgMJ874wViCW6F4+7NM1lyxsE72nLF+IEjD/x/8rOqxi6DQlDdFaRXUOkh/
	 M7Ix3k/SYAHdVS/hQDBlDlARpaneh4aZNesbN/cT7is0EXkXD6czwBITXjo4kyLE+J
	 rQ/vufXOauZF/6ZE7UDgEGvtZ6/CzO1SMDR1cmkSZqKE0klVXQ8B3V9J/J+t/CJqdV
	 8kF9iK72nVyrQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <16c92cc14da67ec6354ee0ac4e1faef4af4d0994.1763022807.git.mazziesaccount@gmail.com>
References: <cover.1763022807.git.mazziesaccount@gmail.com> <16c92cc14da67ec6354ee0ac4e1faef4af4d0994.1763022807.git.mazziesaccount@gmail.com>
Subject: Re: [PATCH v4 12/16] clk: clk-bd718x7: Support BD72720 clk gate
From: Stephen Boyd <sboyd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Matti Vaittinen <mazziesaccount@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Matti Vaittinen <matti.vaittinen@linux.dev>, Matti Vaittinen <mazziesaccount@gmail.com>
Date: Thu, 13 Nov 2025 19:53:09 -0800
Message-ID: <176309238996.11952.1859040027915941428@lazor>
User-Agent: alot/0.11

Quoting Matti Vaittinen (2025-11-13 00:55:05)
> From: Matti Vaittinen <mazziesaccount@gmail.com>
>=20
> The BD72720 has similar simple clk gate as a few other ROHM PMICs.
>=20
> Add support for BD72720 clk gate.
>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>=20
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

