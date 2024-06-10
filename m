Return-Path: <linux-pm+bounces-8841-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C128901D69
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 10:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1E01F21790
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 08:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE316F313;
	Mon, 10 Jun 2024 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="2ukVLBeF"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE4C558A0;
	Mon, 10 Jun 2024 08:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009863; cv=none; b=aAGqbuxP9GonGIYMQq5+xUNIBixiVTvVhe7InDNedpaZAOWjxUyhJslYYLdx9mLxpqp14HNDh2bJ0M4331pKrJD5lAiZqkqTVFe36AQRXkzuCsLxp+kJ6JxU0mImkQtwlsNAgVsHDN3Gv5CUca7SruESq0kiTm6z6mjOFfAtWF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009863; c=relaxed/simple;
	bh=ak9iMxzR5wI0q0Y5ejWbpnQ2VmKOGNNj5JqFLaW1eiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tRgGhnStDtFX6DBBgJsptE6L+QEvBO5hdpSaLWKgnNFC/D6rWkoRDPmXhH/9W4Sj6TFUBYzq6FoAJzMmnqHNjzH+VPc/1KSJPl3R4y9aq53zIvulnP+URtPhKUgZa9bvy6BBCFVx8kgBxK1mG+exWdTbO1V0+HLHxJfXO9qL2D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=2ukVLBeF; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718009860;
	bh=ak9iMxzR5wI0q0Y5ejWbpnQ2VmKOGNNj5JqFLaW1eiw=;
	h=From:To:Cc:Subject:Date:From;
	b=2ukVLBeFLc3sJOocUgGKwE1/1LXJaZhAMo/CZwA2yTqzWrZvmZ0zGmSRQrzgO72SZ
	 TYi+urYGz6AIOD4YsYvukPNf8I1DtIW32mbAD30y0AcOUF4PZ11jwiJxycbLowqhuf
	 +6y3LDryfchTeHPzVOCUtTt+Z7Zo80Bxt5JpepxaHLiA0k1VXDGXgyiQmM9eICDcp5
	 mbCvCgNXOgjxgn4C914a7RorddpK7qMs6fC0eCnkMxcVhXSoev4Ln2+9RTG/tp2rzV
	 lIMhwtm9D46FRVog/WyHVrJ0Yyt6ClkV92WWHPI6/EOE6aXHi08mcTkwlPMwfI1v2J
	 /4FTFRgSxs2UQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 175B5378214E;
	Mon, 10 Jun 2024 08:57:39 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: djakov@kernel.org
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	keescook@chromium.org,
	gustavoars@kernel.org,
	henryc.chen@mediatek.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	wenst@chromium.org,
	amergnat@baylibre.com
Subject: [PATCH v6 0/7] MediaTek DVFSRC Bus Bandwidth and Regulator knobs
Date: Mon, 10 Jun 2024 10:57:28 +0200
Message-ID: <20240610085735.147134-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v6:
 - Fixed build with clang (thanks Nathan!)
 - Removed unused mtk_rmw() macro in mtk-dvfsrc.c
 - Added MODULE_DESCRIPTION() to mtk-dvfsrc-regulator.c

Changes in v5:
 - Fixed Kconfig dependencies in interconnect
 - Fixed module build for dvfsrc and interconnect

Changes in v4:
 - Updated patch [3/7] to actually remove address/size cells
   as the old version got unexpectedly pushed in v3.

Changes in v3:
 - Removed examples from interconnect and regulator bindings
   and kept example node with interconnect and regulator in
   the main DVFSRC binding as suggested
 - Removed 'reg' from interconnect and regulator, removed both
   address and size cells from the main DVFSRC binding as that
   was not really needed
 - Added anyOf-required entries in the regulator binding as it
   doesn't make sense to probe it without any regulator subnode

Changes in v2:
 - Fixed issues with regulator binding about useless quotes and
   wrong binding path (oops)
 - Removed useless 'items' from DVFSRC main binding
 - Allowed address/size cells to DVFSRC main binding to resolve
   validation issues on the regulator and interconnect bindings
 - Changed dvfsrc node name to `system-controller`, as the DVFSRC
   is actually able to control multiple system components.
 - Added a commit to remove mtk-dvfs-regulator.c before adding the
   new, refactored regulator driver


This series adds support for the MediaTek Dynamic Voltage and Frequency
Scaling Resource Controller (DVFSRC), found on many MediaTek SoCs.

This hardware collects requests from both software and the various remote
processors embededd into the SoC, and decides about a minimum operating
voltage and a minimum DRAM frequency to fulfill those requests, in an
effort to provide the best achievable performance per watt.

Such hardware IP is capable of transparently performing direct register
R/W on all of the DVFSRC-controlled regulators and SoC bandwidth knobs.

Summarizing how the DVFSRC works for Interconnect:

             ICC provider         ICC Nodes
                              ----          ----
             _________       |CPU |   |--- |VPU |
    _____   |         |-----  ----    |     ----
   |     |->|  DRAM   |       ----    |     ----
   |DRAM |->|scheduler|----- |GPU |   |--- |DISP|
   |     |->|  (EMI)  |       ----    |     ----
   |_____|->|_________|---.   -----   |     ----
               /|\         `-|MMSYS|--|--- |VDEC|
                |             -----   |     ----
                |                     |     ----
                | change DRAM freq    |--- |VENC|
             --------                 |     ----
    SMC --> | DVFSRC |                |     ----
             --------                 |--- |IMG |
                                      |     ----
                                      |     ----
                                      |--- |CAM |
                                            ----

...and for regulators, it's simply...
   SMC -> DVFSRC -> Regulator voltage decider -> (vreg) Registers R/W

Please note that this series is based on an old (abandoned) series from
MediaTek [1], and reuses some parts of the code found in that.

Besides, included in this series, there's also a refactoring of the
mtk-dvfsrc-regulator driver, which never got compiled at all, and would
not build anyway because of missing headers and typos: that commit did
not get any Fixes tag because, well, backporting makes no sense at all
as the DVFSRC support - which is critical for that driver to work - is
introduced with *this series*! :-)

P.S.: The DVFSRC regulator is a requirement for the MediaTek UFSHCI
      controller's crypto boost feature, which is already upstream but
      lacking the actual regulator to work....... :-)

[1]: https://lore.kernel.org/all/20210812085846.2628-1-dawei.chien@mediatek.com/

AngeloGioacchino Del Regno (7):
  dt-bindings: regulator: Add bindings for MediaTek DVFSRC Regulators
  dt-bindings: interconnect: Add MediaTek EMI Interconnect bindings
  dt-bindings: soc: mediatek: Add DVFSRC bindings for MT8183 and MT8195
  soc: mediatek: Add MediaTek DVFS Resource Collector (DVFSRC) driver
  regulator: Remove mtk-dvfsrc-regulator.c
  regulator: Add refactored mtk-dvfsrc-regulator driver
  interconnect: mediatek: Add MediaTek MT8183/8195 EMI Interconnect
    driver

 .../interconnect/mediatek,mt8183-emi.yaml     |  51 ++
 .../mediatek,mt6873-dvfsrc-regulator.yaml     |  43 ++
 .../soc/mediatek/mediatek,mt8183-dvfsrc.yaml  |  83 +++
 drivers/interconnect/Kconfig                  |   1 +
 drivers/interconnect/Makefile                 |   1 +
 drivers/interconnect/mediatek/Kconfig         |  29 +
 drivers/interconnect/mediatek/Makefile        |   5 +
 drivers/interconnect/mediatek/icc-emi.c       | 153 +++++
 drivers/interconnect/mediatek/icc-emi.h       |  40 ++
 drivers/interconnect/mediatek/mt8183.c        | 143 +++++
 drivers/interconnect/mediatek/mt8195.c        | 339 +++++++++++
 drivers/regulator/mtk-dvfsrc-regulator.c      | 248 ++++----
 drivers/soc/mediatek/Kconfig                  |  11 +
 drivers/soc/mediatek/Makefile                 |   1 +
 drivers/soc/mediatek/mtk-dvfsrc.c             | 545 ++++++++++++++++++
 .../interconnect/mediatek,mt8183.h            |  23 +
 .../interconnect/mediatek,mt8195.h            |  44 ++
 include/linux/soc/mediatek/dvfsrc.h           |  36 ++
 include/linux/soc/mediatek/mtk_sip_svc.h      |   3 +
 19 files changed, 1666 insertions(+), 133 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/mediatek,mt8183-emi.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6873-dvfsrc-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml
 create mode 100644 drivers/interconnect/mediatek/Kconfig
 create mode 100644 drivers/interconnect/mediatek/Makefile
 create mode 100644 drivers/interconnect/mediatek/icc-emi.c
 create mode 100644 drivers/interconnect/mediatek/icc-emi.h
 create mode 100644 drivers/interconnect/mediatek/mt8183.c
 create mode 100644 drivers/interconnect/mediatek/mt8195.c
 create mode 100644 drivers/soc/mediatek/mtk-dvfsrc.c
 create mode 100644 include/dt-bindings/interconnect/mediatek,mt8183.h
 create mode 100644 include/dt-bindings/interconnect/mediatek,mt8195.h
 create mode 100644 include/linux/soc/mediatek/dvfsrc.h

-- 
2.45.2


