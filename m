Return-Path: <linux-pm+bounces-38622-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F7FC85EA3
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 17:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 447D54E2D62
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 16:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF542238176;
	Tue, 25 Nov 2025 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OD+EaOhp"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8FC1E9B35;
	Tue, 25 Nov 2025 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087460; cv=none; b=pasfJQ0aAvxU8AY32MY+uvhFiAUfE4gUQm3hGk0m3Djz0CXaSjQ0uR+bsiOsraACGw61qS46HAurrCQAbGnWpX8St728qg4CCz6O0HNYc6sPp8T0P0vYH3UmgARxvpSjPIzgf9O2K+tWxGNl9AdaZuMdp1gEnpEkllTf5wj1yoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087460; c=relaxed/simple;
	bh=B2nk7PV+5zaefXrB72GFZ6SD1N4A8I+iUXxYutK2H0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VbHplXntuG2D2m4Rap2slFyqK+t4/WMBW6PGNlRYEJPxODDNT8/28jcIbGoK0w4Hx77S5bDFNxEuDg9oQF4VQ1hjBCVgq14ykAPosDdwDrEWUwT0lMq9UM97DdkclyRnCEomlOe6F9bP12D7eOaZVGTYs+jsFh/3/3aemgrfJFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OD+EaOhp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1764087456;
	bh=B2nk7PV+5zaefXrB72GFZ6SD1N4A8I+iUXxYutK2H0s=;
	h=From:To:Cc:Subject:Date:From;
	b=OD+EaOhpDL4UiZ+EO/YsVjRFyw0CoiJAO7B8aMXG2WtH6KLmuuKmvC0qzTW4ehYRD
	 PxxVpFmUsZ8jqwO8DGZ6bm93MrMezla+J+X9eeO/qkY4h1Fpn95brJ2iBot4Lvm5W6
	 sL1U0Lz4hFDfETbsP8Sv0vcuC97ySF59xXKaBWCtIRNwh3zx1rFU1QlkNCpPXy/kXo
	 N5L/p0ayZmvKgYpZlDc56uEXFIqadO70elP/vRr4ZWzy0oc4R9u2AfkPNxN+8BxHdi
	 lxSBfqzq3MPGX94PRegcdYriPtwxiGRJ2Y+Z+N+3u4QCavanSMDxbNlVvHf/RiuBrs
	 LpHCB1waW+teQ==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:feae:4183:be92:e051])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 64BF717E04D6;
	Tue, 25 Nov 2025 17:17:35 +0100 (CET)
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
	wenst@chromium.org,
	fshao@chromium.org,
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH v5 0/8] Add thermal sensor driver support for Mediatek MT8196
Date: Tue, 25 Nov 2025 17:16:50 +0100
Message-Id: <20251125-mt8196-lvts-v4-v5-0-6db7eb903fb7@collabora.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251121-mt8196-lvts-v4-a61fb5c27216
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

Link to v4: https://lore.kernel.org/r/20251121-mt8196-lvts-v4-v4-0-357f955a3176@collabora.com

Changes in v5:
- Dropped patch 3
- Added LVTS_NUM_CAL_OFFSETS_MT7988/LVTS_NUM_CAL_OFFSETS_MT8196 defines
- Moved code that assembles calibration bytes from the efuse data into 
  a dedicated lvts_decode_sensor_calibration() helper
- Fixed prefix in patch 4 commit message
- Dropped R-b/T-b tags on patch 2

---
Laura Nao (8):
      dt-bindings: thermal: mediatek: Add LVTS thermal controller support for MT8196
      thermal/drivers/mediatek/lvts: Make number of calibration offsets configurable
      thermal/drivers/mediatek/lvts: Add platform ops to support alternative conversion logic
      thermal/drivers/mediatek/lvts: Add lvts_temp_to_raw variant
      thermal/drivers/mediatek/lvts: Add support for ATP mode
      thermal/drivers/mediatek/lvts: Support MSR offset for 16-bit calibration data
      thermal/drivers/mediatek/lvts_thermal: Add MT8196 support
      dt-bindings: nvmem: mediatek: efuse: Add support for MT8196

 .../devicetree/bindings/nvmem/mediatek,efuse.yaml  |   1 +
 .../bindings/thermal/mediatek,lvts-thermal.yaml    |   2 +
 drivers/thermal/mediatek/lvts_thermal.c            | 326 +++++++++++++++++++--
 .../dt-bindings/thermal/mediatek,lvts-thermal.h    |  26 ++
 4 files changed, 333 insertions(+), 22 deletions(-)
---
base-commit: abadc219d77ce0e61fcac0147cc6cc69164af43e
change-id: 20251121-mt8196-lvts-v4-a61fb5c27216

Best regards,
-- 
Laura Nao <laura.nao@collabora.com>

