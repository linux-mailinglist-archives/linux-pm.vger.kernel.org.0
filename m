Return-Path: <linux-pm+bounces-34900-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2027B811A4
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 19:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738401C2535E
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 17:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0C32FC01F;
	Wed, 17 Sep 2025 17:02:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C56E2FC008;
	Wed, 17 Sep 2025 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758128565; cv=none; b=kwd+ogfemeRXf8PA22iwQW/kS0ycq59vb7GYSfNA9MYW5su4hm1nzDpNfgTjN5qc37M9hv8A7bI8L+spw5BF8xrCBt8mOVknAYO3m5m6XPApj9lx+n4G70R+EsqaVMBJeWhDloPw9xd81msLkz2JuOi7sA5OMBtcKkk/3S5xm2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758128565; c=relaxed/simple;
	bh=Ra7ELyvkrvjPj5kJJl1XqUiGbNP3FDS6arlEPpA0NnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RZJDz0UOuh9VEngB0zuWPhfsTjmjQ1Rf2GASbXox4Fd1r4hE4UUnjvRTwqpY3SzqubgyeNvSCtjhhwRPUMIF7mjLRUqWd6Es81aznu+8ZopdQdmyaBz3XKorPiI26mTeBpZLp4da3BUFZO7jBvEeM3Dn80U40QYWjvECyfa+JG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: nWiUG+2HTwmdvkbVXtXFOg==
X-CSE-MsgGUID: WtFN+q4pQR6IBM9rkpKZbQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 18 Sep 2025 02:02:35 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.24.0.45])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0E67F400F755;
	Thu, 18 Sep 2025 02:02:28 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: conor+dt@kernel.org,
	daniel.lezcano@linaro.org,
	geert+renesas@glider.be,
	krzk+dt@kernel.org,
	lukasz.luba@arm.com,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	robh@kernel.org,
	rui.zhang@intel.com,
	sboyd@kernel.org,
	will@kernel.org
Cc: biju.das.jz@bp.renesas.com,
	catalin.marinas@arm.com,
	devicetree@vger.kernel.org,
	john.madieu@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	p.zabel@pengutronix.de,
	rafael@kernel.org,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH v9 0/4] thermal: renesas: Add support for RZ/G3E
Date: Wed, 17 Sep 2025 19:01:54 +0200
Message-ID: <20250917170202.197929-1-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the temperature sensor unit (TSU) found on the
Renesas RZ/G3E SoC.

The initial syscon patch [1] the series depends on has already been accepted.

Changes:

v9:
 * Remove driver-specific read/write indirection and use readl/writel
 * Use devm_mutex_init()
 * Switch to syscon_regmap_lookup_by_phandle_args()

v8:
 * Use of_parse_phandle_with_fixed_args() for trim values
 * Update binding doc and collect Rb tag from Rob
 * Use millidegree computation to for better precision

v6 -> v7
 * Update DTS trim priperty name and specifier, updading the documentation
 accordingly
 * Refactor main driver: remove spinlock usage, using polling timeout as computed
 from datasheet. Also use polling for get_temp() while using IRQ for trip-point
 cross detection, and finally add both runtime and sleep PM support.
 * Add new patch to update sys #address-cells as trim specifier now requires an
 offset from sys base

v5 -> v6
 * Minor typo fix
 * Constify regmap config in patch 1/5

v4 -> v5
 * Remove useless curly braces on single line-protected scoped guards

v3 -> v4
 * Improve commit messages

v2 -> v3
 * Remove useless 'renesas,tsu-operating-mode' property

v1 -> v2
 * Fix yaml warnings from dt-binding
 * Update IRQ names to reflect TSU expectations

Regards,

[1] https://lore.kernel.org/linux-devicetree/20250818162859.9661-2-john.madieu.xa@bp.renesas.com/


John Madieu (4):
  dt-bindings: thermal: r9a09g047-tsu: Document the TSU unit
  thermal: renesas: rzg3e: Add thermal driver for the Renesas RZ/G3E SoC
  arm64: dts: renesas: r9a09g047: Add TSU node
  arm64: defconfig: Enable the Renesas RZ/G3E thermal driver

 .../thermal/renesas,r9a09g047-tsu.yaml        |  87 +++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  48 ++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/thermal/renesas/Kconfig               |   7 +
 drivers/thermal/renesas/Makefile              |   1 +
 drivers/thermal/renesas/rzg3e_thermal.c       | 547 ++++++++++++++++++
 7 files changed, 698 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
 create mode 100644 drivers/thermal/renesas/rzg3e_thermal.c

-- 
2.25.1


