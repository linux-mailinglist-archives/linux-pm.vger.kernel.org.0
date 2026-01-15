Return-Path: <linux-pm+bounces-40932-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F07E3D24CEC
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 14:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBD5330248A6
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 13:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC75339E6EB;
	Thu, 15 Jan 2026 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7e6QAJ4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B660130EF95;
	Thu, 15 Jan 2026 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768484983; cv=none; b=MFnJ5269ePCELYGKSn2Zd7ABE58JFVdJQWsjVpfWyAQI25t9bFo8Eoa0hFqk0lZjUF8Xu6Fy7qkLbDouyNRzWJenyzMpiAEnrU+VPRU/lOAKI2wTaJQxhIjThafrYlVfyBY2EWsR4TfXUYGnw+9nLq7oijn5UwLBOaINh3gKcL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768484983; c=relaxed/simple;
	bh=mLm6QqFggcSSbVGl21YSwdDfGF0CDC1QFc128taHR8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcJbkkZErsXkElGBl80yYZBS7cAvD1duJ6Y487f+VD+vkoKxTXG67cq4Uj1nlydmGPGuaWZo8G/rXos242lNRjEU4xaLp0L6dqZfFzlpFpW3cQfVqlsJsM3dhHQ8XoG2x0av9voji1GkyUGKGA4YyRAWD00uKGXBwEZwnbYV3YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7e6QAJ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46A6C116D0;
	Thu, 15 Jan 2026 13:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768484983;
	bh=mLm6QqFggcSSbVGl21YSwdDfGF0CDC1QFc128taHR8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i7e6QAJ44Bf2JaIwbYSBiJpGbCRthi2VIqme1Ke1ACn2O5pMFo2NNQIQRSedVmmnC
	 4KRmtTWiuXjx+zMOqoflPZ7CIjshWguMaz0biDqMMujSveVX2Jp/xlQXZicZi2dwiw
	 fa+G9LKOcSF9JgrPyf2X9FgxE2sN7N8MMkVsPn1SZoZqcjc54W5rudRiKPyYoOZAZC
	 Sz7VayUPxIYPaO1ACAL99ztt1iBUUQ9tawYYDfsEnmbSZJutfz0mWGRnjR3NtSc6Jj
	 0a6z10JdqG3JfovaLgaXg2zg5zD64tPyxVGTRrShfqI8iLsk+kwXper360+6MEiig2
	 BxYKjFdkDiwBA==
Date: Thu, 15 Jan 2026 13:49:35 +0000
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
Subject: [GIT PULL] Immutable branch between MFD, Clk, GPIO, Power, Regulator
 and RTC due for the v6.20 merge window
Message-ID: <20260115134935.GD2842980@google.com>
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

Enjoy!

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-clk-gpio-power-regulator-rtc-v6.20

for you to fetch changes up to e39951f8ad500648b9ab132f8042d6e47da441cf:

  MAINTAINERS: Add ROHM BD72720 PMIC (2026-01-13 12:50:37 +0000)

----------------------------------------------------------------
Immutable branch between MFD, Clk, GPIO, Power, Regulator and RTC due for the v6.20 merge window

----------------------------------------------------------------
Matti Vaittinen (17):
      dt-bindings: regulator: ROHM BD72720
      dt-bindings: battery: Clarify trickle-charge
      dt-bindings: battery: Add trickle-charge upper limit
      dt-bindings: battery: Voltage drop properties
      dt-bindings: mfd: ROHM BD72720
      dt-bindings: leds: bd72720: Add BD72720
      mfd: rohm-bd71828: Use regmap_reg_range()
      mfd: rohm-bd71828: Use standard file header format
      mfd: rohm-bd71828: Support ROHM BD72720
      regulator: bd71828: rename IC specific entities
      regulator: bd71828: Support ROHM BD72720
      gpio: Support ROHM BD72720 gpios
      clk: clk-bd718x7: Support BD72720 clk gate
      rtc: bd70528: Support BD72720 rtc
      power: supply: bd71828: Support wider register addresses
      power: supply: bd71828-power: Support ROHM BD72720
      MAINTAINERS: Add ROHM BD72720 PMIC

 .../bindings/leds/rohm,bd71828-leds.yaml           |    7 +-
 .../devicetree/bindings/mfd/rohm,bd72720-pmic.yaml |  339 +++++++
 .../devicetree/bindings/power/supply/battery.yaml  |   33 +-
 .../bindings/regulator/rohm,bd72720-regulator.yaml |  148 +++
 MAINTAINERS                                        |    2 +
 drivers/clk/Kconfig                                |    4 +-
 drivers/clk/clk-bd718x7.c                          |   10 +-
 drivers/gpio/Kconfig                               |    9 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-bd72720.c                        |  281 ++++++
 drivers/mfd/Kconfig                                |   18 +-
 drivers/mfd/rohm-bd71828.c                         |  555 ++++++++++-
 drivers/power/supply/bd71828-power.c               |  160 ++-
 drivers/regulator/Kconfig                          |    8 +-
 drivers/regulator/bd71828-regulator.c              | 1025 +++++++++++++++++++-
 drivers/rtc/Kconfig                                |    3 +-
 drivers/rtc/rtc-bd70528.c                          |   21 +-
 include/linux/mfd/rohm-bd72720.h                   |  634 ++++++++++++
 include/linux/mfd/rohm-generic.h                   |    1 +
 19 files changed, 3127 insertions(+), 132 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd72720-pmic.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd72720-regulator.yaml
 create mode 100644 drivers/gpio/gpio-bd72720.c
 create mode 100644 include/linux/mfd/rohm-bd72720.h

-- 
Lee Jones [李琼斯]

