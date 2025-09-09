Return-Path: <linux-pm+bounces-34244-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8213B4AC99
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 13:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0C21C24926
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 11:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75008326D4C;
	Tue,  9 Sep 2025 11:44:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966FD32C33E;
	Tue,  9 Sep 2025 11:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418246; cv=none; b=Ls+piOcU80I3kyculbPMnOVg9b9Au0+DAUJ02sl+TzygfTHoqRndU8IIIBBIJRaEMwms+LEU5a2OOh6W2kSXyFRVkRv6vRRdIDeSXZpUzgMtz6sGE5OMg5W0ZVeN1O++NEX5a0YZgkwSDrNtx+OqBKAsUNajVlQwJ3bjBsKUQZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418246; c=relaxed/simple;
	bh=3n0UwFNgByRMKfIH6Iz2pf1mluhISV3dL7F6q2aUMIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=awifcFNYlT4BNcKnAMYroMn75uNFdmhOEUDxkdMS9lQaJyjyC9LMDRZGHob6pFKDg/h6UkVeUWWOmfvFxBKZHUWjSPuNweYN+FL2jeRnjiWfyARyO+rlzJ9frzuIO+Ha3HFvFyZF9yZ/2EQzn4rh3nnTYqFf1ewRc29eex2N8bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 5J2F5CjWQh+YoGlKPOAH3A==
X-CSE-MsgGUID: YrNEyb6QT36IFFdU8D8ozw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 09 Sep 2025 20:38:54 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.24.0.1])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0EB52401E4F5;
	Tue,  9 Sep 2025 20:38:46 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: catalin.marinas@arm.com,
	conor+dt@kernel.org,
	daniel.lezcano@linaro.org,
	geert+renesas@glider.be,
	krzk+dt@kernel.org,
	lukasz.luba@arm.com,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	p.zabel@pengutronix.de,
	robh@kernel.org,
	rui.zhang@intel.com,
	sboyd@kernel.org,
	will@kernel.org
Cc: biju.das.jz@bp.renesas.com,
	devicetree@vger.kernel.org,
	john.madieu@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	rafael@kernel.org,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH v8 0/4] thermal: renesas: Add support for RZ/G3E
Date: Tue,  9 Sep 2025 13:38:35 +0200
Message-ID: <20250909113840.122785-1-john.madieu.xa@bp.renesas.com>
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

The series depends on this syscon patch [1] that has already been queued.

Changes:

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
 drivers/thermal/renesas/rzg3e_thermal.c       | 564 ++++++++++++++++++
 7 files changed, 715 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
 create mode 100644 drivers/thermal/renesas/rzg3e_thermal.c

-- 
2.25.1


