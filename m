Return-Path: <linux-pm+bounces-31173-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C1EB0BE7B
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 10:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF3B179326
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 08:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CD4284B5D;
	Mon, 21 Jul 2025 08:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="d2vt7Ffj"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F18ABA27;
	Mon, 21 Jul 2025 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753085780; cv=none; b=c+2ih6KGl1JmyQuE6jBcNDaY2nuwULjMfa53PAPKj8/rAMWnsn60TYgnbMWFbuAwGAgbPysWpsCMOM8sF5M48gf/gXpd0n6Gm9VawtgTwQyA7oGM6sM6fKxD2U74B8CDn9ajZudDk5erK0Iagl+4MbPRcVU1Ll1PFvOIHdTb6F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753085780; c=relaxed/simple;
	bh=P/NW1/RI1132VsYmYKCFxP8GrB7AQikCUoRaUgB9NlU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fWVY8l+uG0x9MP70n0m6nijIq5A/kpvbMUdh4xYqL3PYvtiHZLK35akRrHLSZTmR+FNxhWi1nMlL9iFG0dkCX0vJ48/g0o273lNDcy0OAL2Nz+/uLkDKNw36atWDRBI8sG6AGzqC+m/G7Vdzw765xfDMue6rjfgFLqOvDZCm920=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=d2vt7Ffj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753085774;
	bh=P/NW1/RI1132VsYmYKCFxP8GrB7AQikCUoRaUgB9NlU=;
	h=From:To:Cc:Subject:Date:From;
	b=d2vt7FfjA92IQpPa27iET473qr9XduKfdAIj2hbhGq5weWnE7xeL/66k7rXl+I87V
	 Z8vTshWw+odRWdQoEPJmgNlJX+dEjy3kOM1eZT7SOwLkNb2WPfWsR+fD2GqfpfUo8x
	 a3UgMeVVuEzyX0PyQVBz9kP/l+vzenvMH2qmNs4e7tFC7UtBw7ILj9vSUrPF4pGBkR
	 dhwrKhpI9x8352MFWf4ZB1MDfIl4V8zYJfeD31DvN2DuzWsJSXY9A+w8Bh8W0QQrrF
	 /hkolxfiW/+DVotXZeT3Vk6IEAxhz8WKzM3VgQF+yGbYmsmzKaZB6ROrJAFoo/3EYC
	 TTjh8sVGcSzHQ==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:4487:69c6:40a:81be])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1BC7217E0F66;
	Mon, 21 Jul 2025 10:16:13 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: srini@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: nfraprado@collabora.com,
	arnd@arndb.de,
	colin.i.king@gmail.com,
	u.kleine-koenig@baylibre.com,
	andrew-ct.chen@mediatek.com,
	lala.lin@mediatek.com,
	bchihi@baylibre.com,
	frank-w@public-files.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH 0/9] Add thermal sensor driver support for Mediatek MT8196
Date: Mon, 21 Jul 2025 10:14:50 +0200
Message-Id: <20250721081459.16278-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series extends the MediaTek LVTS thermal driver to support the
MT8196 SoC.

MT8196 uses a positive temp_factor for temperature conversion, requiring
slight adjustments in the conversion logic.

To support this, the series introduces:

- A new struct lvts_platform_ops to allow platform-specific
  conversion logic between raw sensor values and temperature
- A variant of the lvts_temp_to_raw() implementation for SoCs with positive
  temp_factor values
- Platform data and controller definitions for MT8196

Laura Nao (9):
  dt-bindings: thermal: mediatek: Add LVTS thermal controller support
    for MT8196
  thermal/drivers/mediatek/lvts: Make number of calibration offsets
    configurable
  thermal/drivers/mediatek/lvts: Guard against zero temp_factor in
    lvts_raw_to_temp
  thermal: mediatek: lvts: Add platform ops to support alternative
    conversion logic
  thermal/drivers/mediatek/lvts: Add lvts_temp_to_raw variant for
    positive temp_factor
  thermal/drivers/mediatek/lvts: Add support for ATP mode
  thermal/drivers/mediatek/lvts: Support MSR offset for 16-bit
    calibration data
  thermal/drivers/mediatek/lvts_thermal: Add MT8196 support
  dt-bindings: nvmem: mediatek: efuse: Add support for MT8196

 .../bindings/nvmem/mediatek,efuse.yaml        |   1 +
 .../thermal/mediatek,lvts-thermal.yaml        |   2 +
 drivers/thermal/mediatek/lvts_thermal.c       | 315 ++++++++++++++++--
 .../thermal/mediatek,lvts-thermal.h           |  26 ++
 4 files changed, 325 insertions(+), 19 deletions(-)

-- 
2.39.5


