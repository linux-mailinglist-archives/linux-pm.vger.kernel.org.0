Return-Path: <linux-pm+bounces-38721-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7BDC8A5A1
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 15:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C55F93527C7
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 14:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2749730217E;
	Wed, 26 Nov 2025 14:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXGQULyX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19B21EA7CC;
	Wed, 26 Nov 2025 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764167593; cv=none; b=iOVvWzVD/iQbPQa3Wid8BEj1S/gLnlaOmHpllobUooMJ4XbnFjlqtTvH7GYx/hbC45w6s/M6uMhxNPoP+FuyK+vLV0HiI9y/kY1xTY8/PoK6i+S8epaXDCNCHcfuP/Wj4jhk7E3fET7RA+6P1Jq40XdhYeFMXxFKxhNBOiOLWc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764167593; c=relaxed/simple;
	bh=3kLYYlGyDPHSsE6wcJ2XsDDhl/NGDbPeXtDpM7DF2vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qig0YYq8Hbl8jTCQQlB4spm/3R5ORHfcxzcW9cI/3nGVPih6bFBjNhEMUD1VetLiK0WnJr+ej6dHZ1X9zsfGMdWLyPRRlSsyYaP+MktjciUu7bntbgTe/wfvSjSaj2nqwrpAgcM27wm0i5nOwOitv+TLnRIX6qwkw2VXDxmrTfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXGQULyX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF377C2BCFB;
	Wed, 26 Nov 2025 14:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764167592;
	bh=3kLYYlGyDPHSsE6wcJ2XsDDhl/NGDbPeXtDpM7DF2vo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WXGQULyXc18uR2+ihgtWOAIxSzN1ZxFrYzI1MQF4ZyK+9LYwJtBz58sOKogc39hMS
	 SskktgRiFDH2URe0f58AtzRB+0fp6P4T3GzOZkiUylSOWLPvvOp09GBmVG/Insmtq4
	 lwhvG3GEE2qTp0kzvlGnLwKbbCzl7vgOJbc+90x2++7OIDPw6zzkXc+MVi8nbCkvJj
	 xK0rriKdxfoMKMoYZbvCL82s2/zpyzfpRxB9dXQS7qMQ2lzCzWbufnyZR/OxzF+8E6
	 1bETaOzF9d78Noi3lDfyule/rfRoddI0VQSdLb0OCkQ2FlyTd2GA34G3ieAsBRCcmA
	 WOqfu5c35FWwQ==
Date: Wed, 26 Nov 2025 14:33:04 +0000
From: Lee Jones <lee@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH v5 07/16] mfd: rohm-bd71828: Use regmap_reg_range()
Message-ID: <20251126143304.GE3070764@google.com>
References: <cover.1763625920.git.mazziesaccount@gmail.com>
 <b0c6256deb1388f0774b3c855c0614d363aa003b.1763625920.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0c6256deb1388f0774b3c855c0614d363aa003b.1763625920.git.mazziesaccount@gmail.com>

On Thu, 20 Nov 2025, Matti Vaittinen wrote:

> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> The regmap range tables tend to be somewhat verbose. Using the
> regmap_reg_range() can make the definitions slightly mode compact.
> 
> Tidy the regmap range tables by using the regmap_reg_range().
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
> Revision history:
>  v2 => :
>  - no changes
>  RFCv1 => v2:
>  - New patch
> ---
>  drivers/mfd/rohm-bd71828.c | 64 +++++++++++---------------------------
>  1 file changed, 18 insertions(+), 46 deletions(-)

LGTM.

Once everything is in order, I plan to merge the set through MFD.

-- 
Lee Jones [李琼斯]

