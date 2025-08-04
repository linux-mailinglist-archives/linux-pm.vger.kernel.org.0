Return-Path: <linux-pm+bounces-31898-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E68B1A345
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 15:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0206189DB8B
	for <lists+linux-pm@lfdr.de>; Mon,  4 Aug 2025 13:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FC6269806;
	Mon,  4 Aug 2025 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pl0Ry/jv"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5093645029;
	Mon,  4 Aug 2025 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754314360; cv=none; b=NnszyRw0/YwetW/WcNLkp5G1uXC0UUzl/UZ4C2pWzldqlJ3lp1mayS4xgAo00kGJOpknqfyXIgUjroupd+ICfeMenXJjm35+L6lKYQPNPlta5tfj4IU382EekXouI4UooIQkw+zOtB97ANZaiACdCX+h0copAptlWK8fKJJIl4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754314360; c=relaxed/simple;
	bh=apsk0n9LP0pfN4KmEcA5GNt1BPZ+Gwl5lIX8tFwQFk4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RoMd7+e4l/Rq1ajND87YQIu2PEzP12ibmzKdu/Ym35iTD37faHMmV3NCClofUeQp5Bb6wvtaCqhIiRpMSWZW3KL6XR1a0Ny1hk9RYmRaW5EZrOKWTxCCUYPQnQ0fa1BWlVaN8s6BxRtgCR7tY5zaX9aJHC0prTIvJGE/UuH28Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pl0Ry/jv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754314356;
	bh=apsk0n9LP0pfN4KmEcA5GNt1BPZ+Gwl5lIX8tFwQFk4=;
	h=From:To:Cc:Subject:Date:From;
	b=pl0Ry/jvdhKA/z/wi+zcPJ7W8w6g3k+avsURYBivl533nXCMujcmRiHWBJRpCxrh7
	 MqLonjRjl9oGgI4Oa0/Ers4XMlLAAf06hkL8CfVnt1l1XM1KGNCBFiDCONMSzguAoz
	 JnZ6NrAmMNR8Ci+DsAGwPzfqeSjqj6FUFirqOOFULtQKCZx7Ps76k0MBmAiCZpgd4Y
	 U2QTMPcLKHKP5hBCWeifawBtbBT2R2xRpED14vYao4zL7yQXZF+9S76zms9AZTCXAF
	 nAPt6HpzwsXVbKHpxTbVJD4j68UqixEaYyA1ReAujlf3tvwkl5gW6NIdOFiaGj5nAW
	 iT3CvEG6jIpbg==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:865e:547d:4830:837d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1A9DD17E0258;
	Mon,  4 Aug 2025 15:32:34 +0200 (CEST)
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
Subject: [PATCH v3 0/9] Add thermal sensor driver support for Mediatek MT8196
Date: Mon,  4 Aug 2025 15:30:26 +0200
Message-Id: <20250804133035.309990-1-laura.nao@collabora.com>
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

MT8196 requires a different implementation of the lvts_temp_to_raw()
function.

To support this, the series introduces:

- A new struct lvts_platform_ops to allow platform-specific
  conversion logic between raw sensor values and temperature
- A variant of the lvts_temp_to_raw() implementation
- Platform data and controller definitions for MT8196

Link to v2: https://lore.kernel.org/all/20250730152128.311109-1-laura.nao@collabora.com/

Changes in v3:
- Make ops in struct lvts_data a pointer to const struct lvts_platform_ops
- Changed mediatek,mt8188-efuse const entry in eFuse binding to an enum
with mediatek,mt8196-efuse and mediatek,mt8188-efuse, dropped mediatek,mt8196-efuse
const entry

Laura Nao (9):
  dt-bindings: thermal: mediatek: Add LVTS thermal controller support
    for MT8196
  thermal/drivers/mediatek/lvts: Make number of calibration offsets
    configurable
  thermal/drivers/mediatek/lvts: Guard against zero temp_factor in
    lvts_raw_to_temp
  thermal: mediatek: lvts: Add platform ops to support alternative
    conversion logic
  thermal/drivers/mediatek/lvts: Add lvts_temp_to_raw variant
  thermal/drivers/mediatek/lvts: Add support for ATP mode
  thermal/drivers/mediatek/lvts: Support MSR offset for 16-bit
    calibration data
  thermal/drivers/mediatek/lvts_thermal: Add MT8196 support
  dt-bindings: nvmem: mediatek: efuse: Add support for MT8196

 .../bindings/nvmem/mediatek,efuse.yaml        |   4 +-
 .../thermal/mediatek,lvts-thermal.yaml        |   2 +
 drivers/thermal/mediatek/lvts_thermal.c       | 305 ++++++++++++++++--
 .../thermal/mediatek,lvts-thermal.h           |  26 ++
 4 files changed, 314 insertions(+), 23 deletions(-)

-- 
2.39.5


