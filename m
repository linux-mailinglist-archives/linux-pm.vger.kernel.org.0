Return-Path: <linux-pm+bounces-38352-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EC7C78C1B
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 12:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39A904F0996
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 11:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4914F2F1FCF;
	Fri, 21 Nov 2025 11:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PJRQcbgV"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9585E34321A;
	Fri, 21 Nov 2025 11:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763723834; cv=none; b=VVshZsEuIZF0wgu4D2Ey9ptl0ItSa/YOyGga6bO77GABAzE9GyaorZSJ9iGEdOafxbEt/U/Eyo2cpEWHRNOVzNSMMTSLb6+XwlORyag1IRvjRX351V8lwQuOj2HBbHKakZzumIp4q7OPY17P9otjGfW/pvYapsN0kV88B02eULk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763723834; c=relaxed/simple;
	bh=WsrtTZZgN5cpcaeLfhfmV5Uwfe5UlDUKhrY36z8jPVY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Qrp5XgA3AIQMwUvGIHbjSSLl6Nr1YQXMiLH9XN0x1oAZQQ/phoza9XkgvHKma6kXw2ORu8Kj/yjhZQxEaPEdaISVrJyOvSHwBBJWBsU6x7e626A3zDSqs6tr7mtam9tmeHhWIhFj5MjAqXoJMvQR42IJN9Q686zGK5oPQ7fXq64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PJRQcbgV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763723822;
	bh=WsrtTZZgN5cpcaeLfhfmV5Uwfe5UlDUKhrY36z8jPVY=;
	h=From:To:Cc:Subject:Date:From;
	b=PJRQcbgVZNrXjk2K7ARdstUNgf7FfKlfkA8MvpZ/bHvoYpQyg8zo4nY1Jv1yYREXB
	 N1CUgsZzeJfDrvKTpee+EnO9/nZ2MWvEYaG4YeWr3Bgv1EYQ8Gg08LfhgubBEQBYIR
	 ecR1C9k1IqakxfHE3w0hcbDeC/x5+/1c/PocO5ciQOsZtVUIzntrVAcPm2VCv2nI97
	 cmV8vDVCOB4lO/BOstQ0NHEGMmyUQmoMl7IHuOOnmte5p3B3chBjV4qSsWN1AxS/tt
	 5IGkmGouqRre/IrgbCkjjBOCS++FJN3SZrErhKzKmm8h27XxsE8VFpsVxkZ+GVq0e0
	 hX6vFchJfs2yA==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:c4bf:9969:6e1c:dc69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A007417E05BE;
	Fri, 21 Nov 2025 12:17:01 +0100 (CET)
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
	wenst@chromium.org,
	fshao@chromium.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH v4 0/9] Add thermal sensor driver support for Mediatek MT8196
Date: Fri, 21 Nov 2025 12:16:33 +0100
Message-Id: <20251121-mt8196-lvts-v4-v4-0-357f955a3176@collabora.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This patch series extends the MediaTek LVTS thermal driver to support the
MT8196 SoC.

MT8196 requires a different implementation of the lvts_temp_to_raw()
function.

To support this, the series introduces:

- A new struct lvts_platform_ops to allow platform-specific
  conversion logic between raw sensor values and temperature
- A variant of the lvts_temp_to_raw() implementation
- Platform data and controller definitions for MT8196

Link to v3: https://lore.kernel.org/all/20251016142158.740242-1-laura.nao@collabora.com/

Changes in v4:
- Dropped v1/v2 suffixes, replaced with mt7988/mt8196
- Added lvts_raw_to_temp/lvts_temp_to_raw functions, which return the 
  corresponding SoC-specific ops.
- Changed probe logic to fail when temp_factor == 0, dropped checks at
  runtime
- Dropped R-b/T-b tags on affected patches (3 and 4)

---
Laura Nao (9):
      dt-bindings: thermal: mediatek: Add LVTS thermal controller support for MT8196
      thermal/drivers/mediatek/lvts: Make number of calibration offsets configurable
      thermal/drivers/mediatek/lvts: Fail probe if temp_factor is zero
      thermal: mediatek: lvts: Add platform ops to support alternative conversion logic
      thermal/drivers/mediatek/lvts: Add lvts_temp_to_raw variant
      thermal/drivers/mediatek/lvts: Add support for ATP mode
      thermal/drivers/mediatek/lvts: Support MSR offset for 16-bit calibration data
      thermal/drivers/mediatek/lvts_thermal: Add MT8196 support
      dt-bindings: nvmem: mediatek: efuse: Add support for MT8196

 .../devicetree/bindings/nvmem/mediatek,efuse.yaml  |   1 +
 .../bindings/thermal/mediatek,lvts-thermal.yaml    |   2 +
 drivers/thermal/mediatek/lvts_thermal.c            | 307 +++++++++++++++++++--
 .../dt-bindings/thermal/mediatek,lvts-thermal.h    |  26 ++
 4 files changed, 315 insertions(+), 21 deletions(-)
---
base-commit: abadc219d77ce0e61fcac0147cc6cc69164af43e
change-id: 20251121-mt8196-lvts-v4-a61fb5c27216

Best regards,
-- 
Laura Nao <laura.nao@collabora.com>

