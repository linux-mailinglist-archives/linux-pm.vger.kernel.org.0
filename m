Return-Path: <linux-pm+bounces-40493-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB5AD05238
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 18:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B71F8302F7AD
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 17:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538A02F7468;
	Thu,  8 Jan 2026 17:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0FBovyG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBF02D8393;
	Thu,  8 Jan 2026 17:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767893264; cv=none; b=UAtbBT2HSc0BVxX6GNaFcGVvuOPGX7wrryVShUD0ualSY4M0qzZaD7uf1jK77OTKcBKZXwhWJMwez8ixov3kZD514CmeKqD5HmGsfFtDTg3ewA7WIuFOqA+LYn5paxi/POczZqE+aqi97+4BaVN+l2uYuITLnUnURglnawQ0MdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767893264; c=relaxed/simple;
	bh=APV5ntxxphrtGu3GlOx83NQKoLOGqOjtVFfujzMMhq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXRxKQTobV1mdIfFd7PZcuetylHr1s2CLB9SfAftksOfPX0ZQ89L21g/9MA6fRDoY7zgO7pDFW6P5nteXT8r3/JT67l1wIMIx4jq825k5WNzVEZe/joexItvMdMN/jRH/8Vw/hdoxW3grcB4wUYzkT/3rzdKhW5Xzz4iLxaceNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0FBovyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815F9C19423;
	Thu,  8 Jan 2026 17:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767893263;
	bh=APV5ntxxphrtGu3GlOx83NQKoLOGqOjtVFfujzMMhq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N0FBovyGKwCwkTIJuCh1zGkP/oWG4lKPf6IiQfeuU2LN4kc976awuf3/X2D2xAAB7
	 LSKRUoCxbPJZIwaqYn+C4npMd37Ve+nIRHg2x+BDFN0At0t2CktFKPwzBLBBeLQs14
	 n3zbghAwkPFw2OXWcSJbp91R2QPQSe87Rf0aJgVlP1/MyTdeF5Xv2r7qne0jGycf6B
	 CZV2OqJ9uIgwqtWpFnstWl06+WZsSpMniCdMKfk/f6YfWFYJaUU09mlbR0KtTEjXr0
	 MmDGdC8QT3RwC+ep6naAsPhVG3dMR/xxB2oHYfq13lE77IqkkhY+QrIL1ZVFf1Zxix
	 Ebid9/i+qEKrA==
Date: Thu, 8 Jan 2026 17:27:35 +0000
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
	Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH RESEND v6 00/17] Support ROHM BD72720 PMIC
Message-ID: <20260108172735.GK302752@google.com>
References: <cover.1765804226.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1765804226.git.mazziesaccount@gmail.com>

On Mon, 15 Dec 2025, Matti Vaittinen wrote:

> Resending the v6
> 
> Series is same as v6 _except_ being rebased on v6.19-rc1 - and adding rb
> tags which were replied to v6.
> 
> The ROHM BD72720 is a new power management IC for portable, battery
> powered devices. It integrates 10 BUCKs and 11 LDOs, RTC, charger, LEDs,
> GPIOs and a clock gate. To me the BD72720 seems like a successor to the
> BD71828 and BD71815 PMICs.
> 
> This series depends on
> 5bff79dad20a ("power: supply: Add bd718(15/28/78) charger driver")
> which is in power-supply tree, for-next. Thus, the series is based on
> it.
> 
> The testing since v4 has suffered some hardware-issues after I
> accidentally enabled charging while the PMIC's battery pin was connected
> to the I/O domain. Some heat was generated, not terribly lot smoke
> though...
> 
> After the incident I've had occasional I2C failures. I, however, suspect
> the root cause is HW damage in I/O lines.
> 
> Revision history:
>   v6 resend:
>   - Rebased on v6.19-rc1 and collected rb-tags from v6.
> 
>   v5 => v6:
>   - MFD fixes as suggested by Lee
>     - Styling mostly
>     - New patch to Fix comment style for MFD driver
>   More accurate changelog in individual patches
> 
>   v4 => v5:
>   - dt-binding fixes as discussed in v4 reviews.
>     - Drop rohm,vdr-battery.yaml and add vdr properties to battery.yaml
>     - Drop 'rohm,' -vendor-prefix from vdr properties
>   - Link to v4:
>     https://lore.kernel.org/all/cover.1763022807.git.mazziesaccount@gmail.com/
>   More accurate changelog in individual patches
> 
>   v3 => v4:
>   - dt-binding fixes to the BD72720 MFD example and regulator bindings
>   More accurate changelog in individual patches
> 
>   v2 => v3:
>   - rebased to power-supply/for-next as dependencies are merged to there
>   - plenty of dt-binding changes as suggested by reviewers
>   - add new patch to better document existing 'trickle-charging' property
>   More accurate changelog in individual patches
> 
>   RFCv1 => v2:
>   - Drop RFC status
>   - Use stacked regmaps to hide secondary map from the sub-drivers
>   - Quite a few styling fixes and improvements as suggested by
>     reviewers. More accurate changelog in individual patches.
>   - Link to v1:
>     https://lore.kernel.org/all/cover.1759824376.git.mazziesaccount@gmail.com/
> 
> ---
> 
> Matti Vaittinen (17):
>   dt-bindings: regulator: ROHM BD72720
>   dt-bindings: battery: Clarify trickle-charge
>   dt-bindings: battery: Add trickle-charge upper limit
>   dt-bindings: battery: Voltage drop properties
>   dt-bindings: mfd: ROHM BD72720
>   dt-bindings: leds: bd72720: Add BD72720
>   mfd: rohm-bd71828: Use regmap_reg_range()
>   mfd: rohm-bd71828: Use standard file header format
>   mfd: rohm-bd71828: Support ROHM BD72720
>   regulator: bd71828: rename IC specific entities
>   regulator: bd71828: Support ROHM BD72720
>   gpio: Support ROHM BD72720 gpios
>   clk: clk-bd718x7: Support BD72720 clk gate
>   rtc: bd70528: Support BD72720 rtc
>   power: supply: bd71828: Support wider register addresses
>   power: supply: bd71828-power: Support ROHM BD72720
>   MAINTAINERS: Add ROHM BD72720 PMIC
> 
>  .../bindings/leds/rohm,bd71828-leds.yaml      |    7 +-
>  .../bindings/mfd/rohm,bd72720-pmic.yaml       |  339 ++++++
>  .../bindings/power/supply/battery.yaml        |   33 +-
>  .../regulator/rohm,bd72720-regulator.yaml     |  148 +++
>  MAINTAINERS                                   |    2 +
>  drivers/clk/Kconfig                           |    4 +-
>  drivers/clk/clk-bd718x7.c                     |   10 +-
>  drivers/gpio/Kconfig                          |    9 +
>  drivers/gpio/Makefile                         |    1 +
>  drivers/gpio/gpio-bd72720.c                   |  281 +++++
>  drivers/mfd/Kconfig                           |   18 +-
>  drivers/mfd/rohm-bd71828.c                    |  555 ++++++++-
>  drivers/power/supply/bd71828-power.c          |  160 ++-
>  drivers/regulator/Kconfig                     |    8 +-
>  drivers/regulator/bd71828-regulator.c         | 1025 ++++++++++++++++-
>  drivers/rtc/Kconfig                           |    3 +-
>  drivers/rtc/rtc-bd70528.c                     |   21 +-
>  include/linux/mfd/rohm-bd72720.h              |  634 ++++++++++
>  include/linux/mfd/rohm-generic.h              |    1 +
>  19 files changed, 3127 insertions(+), 132 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml
>  create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd72720-regulator.yaml
>  create mode 100644 drivers/gpio/gpio-bd72720.c
>  create mode 100644 include/linux/mfd/rohm-bd72720.h

The MFD parts LGTM.

What Acks are you waiting on?  What's the merge strategy?

> -- 
> 2.52.0
> 



-- 
Lee Jones [李琼斯]

