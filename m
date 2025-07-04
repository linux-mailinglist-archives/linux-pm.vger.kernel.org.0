Return-Path: <linux-pm+bounces-30190-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 464CAAF9CC7
	for <lists+linux-pm@lfdr.de>; Sat,  5 Jul 2025 01:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAEF33B02FE
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 23:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4CD28DB59;
	Fri,  4 Jul 2025 23:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLLLE9mM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06FB20DD47;
	Fri,  4 Jul 2025 23:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751672369; cv=none; b=lDUCNe5lp3Pe3Rr0Xjg94G13olbugw8akJRek9w3h04dSZOtJiZyhjdM40IPBpz2nlOu1qkoP0/bMBweuZG8obM4HACJeohnBLRnzL0NWH1bwst3jp6SM0et0julJTFb7awF67ZnKXP1QT8aYqnTmmvkHBkl6Zi832r0Y5M5IMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751672369; c=relaxed/simple;
	bh=fKc2CBvxFCq+B2haVK3HmW9Bg7QD1GL8cTAjph0WirA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PG+nECgaIn+D2pTe75V1zMUUXX1qFyqSVi54gtrhFns8iHDvtmFx2cv7vkd0ckL+ZRylPO+U2h7J5HZWtEnDJAds5aI7UH8gnPX+y8gC3bl5gwXM5VDsVx1lw1uxKzWzHFjOyLPzPKbYArHWqV/8wPoBFlRt7hb2xxDDhvyDCZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLLLE9mM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B466BC4CEE3;
	Fri,  4 Jul 2025 23:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751672368;
	bh=fKc2CBvxFCq+B2haVK3HmW9Bg7QD1GL8cTAjph0WirA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RLLLE9mMqF3iGPWWe2juUIfhpLu/PtNYKi49cW2qQpHhvxO+LEMjjrZvBLN9nXbsi
	 /AppM130O98amWqQhFNduSpkus64svll2vr6NDvLTyqYfgvs6rbXWniy4iPPo4Ofjs
	 ELmAX0tiRjMAKF0cU0JpkMTr9XFquAWj8Hi3lvyDAA6AkpiRACHz7ENfuFqzphapuJ
	 Km+kTNjMg4DvhIWqdcAqWiHZgZLoNSM6se/5oDtEfV4s4pon82ku6ugC2R5fh8P/Yb
	 AjRhYLnv55PXcYrXEDvh/zVceh5XG2EP3pA59KyyO9kijEbFrFKfz1Zj0uyghvEdNg
	 0pxw4iuN6ZASg==
From: Mark Brown <broonie@kernel.org>
To: linux-pm@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
In-Reply-To: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
Subject: Re: (subset) [PATCH 00/80] treewide: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-Id: <175167236745.230968.2610293543805891976.b4-ty@kernel.org>
Date: Sat, 05 Jul 2025 00:39:27 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Fri, 04 Jul 2025 10:52:25 +0300, Sakari Ailus wrote:
> Sakari Ailus (80):
>   accel/ivpu: Remove redundant pm_runtime_mark_last_busy() calls
>   accel/amdxdna: Remove redundant pm_runtime_mark_last_busy() calls
>   Bluetooth: Remove redundant pm_runtime_mark_last_busy() calls
>   bus: sunxi-rsb: Remove redundant pm_runtime_mark_last_busy() calls
>   hwrng: Remove redundant pm_runtime_mark_last_busy() calls
>   clk: imx: Remove redundant pm_runtime_mark_last_busy() calls
>   clk: qcom: Remove redundant pm_runtime_mark_last_busy() calls
>   crypto: Remove redundant pm_runtime_mark_last_busy() calls
>   dmaengine: at_xdmac: Remove redundant pm_runtime_mark_last_busy()
>     calls
>   dmaengine: pl330: Remove redundant pm_runtime_mark_last_busy() calls
>   dmaengine: qcom: Remove redundant pm_runtime_mark_last_busy() calls
>   dmaengine: ste_dma40: Remove redundant pm_runtime_mark_last_busy()
>     calls
>   dmaengine: ti: Remove redundant pm_runtime_mark_last_busy() calls
>   dmaengine: zynqmp_dma: Remove redundant pm_runtime_mark_last_busy()
>     calls
>   gpio: arizona: Remove redundant pm_runtime_mark_last_busy() calls
>   drm/amd: Remove redundant pm_runtime_mark_last_busy() calls
>   drm/nouveau: Remove redundant pm_runtime_mark_last_busy() calls
>   drm/radeon: Remove redundant pm_runtime_mark_last_busy() calls
>   drm/panfrost: Remove redundant pm_runtime_mark_last_busy() calls
>   drivers: drm: Remove redundant pm_runtime_mark_last_busy() calls
>   HSI: omap_ssi_port: Remove redundant pm_runtime_mark_last_busy() calls
>   stm class: Remove redundant pm_runtime_mark_last_busy() calls
>   i2c: Remove redundant pm_runtime_mark_last_busy() calls
>   i3c: master: svc: Remove redundant pm_runtime_mark_last_busy() calls
>   i3c: dw: Remove redundant pm_runtime_mark_last_busy() calls
>   HID: intel-thc-hid: Remove redundant pm_runtime_mark_last_busy() calls
>   iio: accel: Remove redundant pm_runtime_mark_last_busy() calls
>   iio: adc: Remove redundant pm_runtime_mark_last_busy() calls
>   iio: chemical: Remove redundant pm_runtime_mark_last_busy() calls
>   iio: common: Remove redundant pm_runtime_mark_last_busy() calls
>   iio: dac: Remove redundant pm_runtime_mark_last_busy() calls
>   iio: gyro: Remove redundant pm_runtime_mark_last_busy() calls
>   iio: imu: Remove redundant pm_runtime_mark_last_busy() calls
>   iio: light: Remove redundant pm_runtime_mark_last_busy() calls
>   iio: magnetometer: Remove redundant pm_runtime_mark_last_busy() calls
>   iio: pressure: Remove redundant pm_runtime_mark_last_busy() calls
>   iio: proximity: Remove redundant pm_runtime_mark_last_busy() calls
>   iio: temperature: Remove redundant pm_runtime_mark_last_busy() calls
>   Input: omap4-keypad: Remove redundant pm_runtime_mark_last_busy()
>     calls
>   Input: cs40l50: Remove redundant pm_runtime_mark_last_busy() calls
>   media: Remove redundant pm_runtime_mark_last_busy() calls
>   mfd: Remove redundant pm_runtime_mark_last_busy() calls
>   mei: Remove redundant pm_runtime_mark_last_busy() calls
>   mmc: Remove redundant pm_runtime_mark_last_busy() calls
>   mtd: rawnand: gpmi: Remove redundant pm_runtime_mark_last_busy() calls
>   net: ethernet: Remove redundant pm_runtime_mark_last_busy() calls
>   net: ipa: Remove redundant pm_runtime_mark_last_busy() calls
>   net: wireless: Remove redundant pm_runtime_mark_last_busy() calls
>   net: wwan: Remove redundant pm_runtime_mark_last_busy() calls
>   nfc: trf7970a: Remove redundant pm_runtime_mark_last_busy() calls
>   PCI/portdrv: Remove redundant pm_runtime_mark_last_busy() calls
>   phy: motorola: phy-mapphone-mdm6600: Remove redundant
>     pm_runtime_mark_last_busy() calls
>   phy: ti: phy-twl4030-usb: Remove redundant pm_runtime_mark_last_busy()
>     calls
>   power: supply: bq24190: Remove redundant pm_runtime_mark_last_busy()
>     calls
>   power: supply: twl4030_charger: Remove redundant
>     pm_runtime_mark_last_busy() calls
>   pwm: img: Remove redundant pm_runtime_mark_last_busy() calls
>   regulator: stm32-vrefbuf: Remove redundant pm_runtime_mark_last_busy()
>     calls
>   remoteproc: omap: Remove redundant pm_runtime_mark_last_busy() calls
>   slimbus: Remove redundant pm_runtime_mark_last_busy() calls
>   soundwire: Remove redundant pm_runtime_mark_last_busy() calls
>   spi: Remove redundant pm_runtime_mark_last_busy() calls
>   staging: greybus: Remove redundant pm_runtime_mark_last_busy() calls
>   greybus: Remove redundant pm_runtime_mark_last_busy() calls
>   media: rkvdec: Remove redundant pm_runtime_mark_last_busy() calls
>   thunderbolt: Remove redundant pm_runtime_mark_last_busy() calls
>   serial: Remove redundant pm_runtime_mark_last_busy() calls
>   usb: Remove redundant pm_runtime_mark_last_busy() calls
>   w1: omap-hdq: Remove redundant pm_runtime_mark_last_busy() calls
>   ALSA: hda: Remove redundant pm_runtime_mark_last_busy() calls
>   ASoC: atmel: Remove redundant pm_runtime_mark_last_busy() calls
>   ASoC: codecs: Remove redundant pm_runtime_mark_last_busy() calls
>   ASoC: Intel: Remove redundant pm_runtime_mark_last_busy() calls
>   ASoC: component: Remove redundant pm_runtime_mark_last_busy() calls
>   ASoC: SOF: Remove redundant pm_runtime_mark_last_busy() calls
>   ALSA: intel_hdmi: Remove redundant pm_runtime_mark_last_busy() calls
>   soc: apple: mailbox: Remove redundant pm_runtime_mark_last_busy()
>     calls
>   block: pm: Remove redundant pm_runtime_mark_last_busy() calls
>   Input: cyapa - Remove redundant pm_runtime_mark_last_busy() calls
>   mei: Remove redundant pm_runtime_mark_last_busy() calls
>   scsi: block: pm: Remove redundant pm_runtime_mark_last_busy() calls
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[70/80] ASoC: atmel: Remove redundant pm_runtime_mark_last_busy() calls
        commit: 9069141d1d9c585a20e43037c2f9c00d9d3fc9eb
[71/80] ASoC: codecs: Remove redundant pm_runtime_mark_last_busy() calls
        commit: bbe5e3c433a34e7f7bc762c390abb38205f821c5
[72/80] ASoC: Intel: Remove redundant pm_runtime_mark_last_busy() calls
        commit: 077e700cd709b9a0334bd442a1a4090c9de0d152
[73/80] ASoC: component: Remove redundant pm_runtime_mark_last_busy() calls
        commit: e879f14d88c8ce4ecb647d80983f74b2fdd9f18b
[74/80] ASoC: SOF: Remove redundant pm_runtime_mark_last_busy() calls
        commit: 2bd9648d5a8d329ca734ca2c273a80934867471e

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


