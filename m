Return-Path: <linux-pm+bounces-32569-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDE0B2AE41
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 18:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B131963E92
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 16:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABEF317718;
	Mon, 18 Aug 2025 16:34:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F2A1487F6;
	Mon, 18 Aug 2025 16:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755534867; cv=none; b=M2PKfFGwQg+OnKzJwYFa9FcccuL0ryV6VtKV5Hep/Tvoh0qL2Ay2YWYtvf3bO+LnvaMg3MXWINJSucbLfZhvc7FjSL6zlhWlkzNqkBZ12LkB2qy5ApFyCXQzLxm6qr4yF3ZCxPddwTzDUUJowKhQ+SngdQ0uW32XcpRufLd+rDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755534867; c=relaxed/simple;
	bh=b+8xl3kJyoIBoGBShp8jqH4z1P8YP+8Xxs9gdLHGlqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K4TLZ1ADM9x121CX8xCmM+CWd4K8WTgH2jpOB9+Qr2RDahgJyN1hqT5oMtDA0c8v5grshnFwLBwjRU/gIr7ynfSEB90WnAYJvbtP+hyMOxWUQdb8xO7tDp6UXKsgjc4MsWav6aHL7FG+qOpdrxuIsP6KKbfnnRHvHcl3DuVxrJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: LqwVSRBoTjiY8DtsXwpQtw==
X-CSE-MsgGUID: tSnWmMSYTWGUQCIhitJZog==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 19 Aug 2025 01:29:14 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.24.0.173])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C6E784016EDD;
	Tue, 19 Aug 2025 01:29:07 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: john.madieu@gmail.com,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	biju.das.jz@bp.renesas.com,
	linux-arm-kernel@lists.infradead.org,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH v7 0/6] thermal: renesas: Add support for RZ/G3E
Date: Mon, 18 Aug 2025 18:28:46 +0200
Message-ID: <20250818162859.9661-1-john.madieu.xa@bp.renesas.com>
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

The series consists of 5 patches (one of which is not related to the thermal
framework) that progressively add TSU support as follows:
- patch 1/6:    adds syscon/regmap support for accessing system controller
                registers, enabling access to TSU calibration values

- patch 2-6/6:  adds dt-bindings, actual driver, DT node, and config symbol.

Patch 1/6 has been duplicated at [1] in USB series. This series addresses comments
got from there.

Changes:

v1 -> v2
 * Fix yaml warnings from dt-binding
 * Update IRQ names to reflect TSU expectations

v2 -> v3
 * Remove useless 'renesas,tsu-operating-mode' property

v3 -> v4
 * Improve commit messages

v4 -> v5
 * Remove useless curly braces on single line-protected scoped guards

v5 -> v6
 * Minor typo fix
 * Constify regmap config in patch 1/5

v6 -> v7
 * Update DTS trim priperty name and specifier, updading the documentation
 accordingly
 * Refactor main driver: remove spinlock usage, using polling timeout as computed
 from datasheet. Also use polling for get_temp() while using IRQ for trip-point
 cross detection, and finally add both runtime and sleep PM support.
 * Add new patch to update sys #address-cells as trim specifier now requires an
 offet from sys base

Regards,

[1] https://lore.kernel.org/all/20250808061806.2729274-2-claudiu.beznea.uj@bp.renesas.com/


John Madieu (6):
  soc: renesas: rz-sysc: Add syscon/regmap support
  dt-bindings: thermal: r9a09g047-tsu: Document the TSU unit
  thermal: renesas: rzg3e: Add thermal driver for the Renesas RZ/G3E SoC
  arm64: dts: renesas: r9a09g047: Add #address-cells property in sys
    node
  arm64: dts: renesas: r9a09g047: Add TSU node
  arm64: defconfig: Enable the Renesas RZ/G3E thermal driver

 .../thermal/renesas,r9a09g047-tsu.yaml        |  87 +++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  49 ++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/soc/renesas/Kconfig                   |   1 +
 drivers/soc/renesas/r9a08g045-sysc.c          |   1 +
 drivers/soc/renesas/r9a09g047-sys.c           |   1 +
 drivers/soc/renesas/r9a09g057-sys.c           |   1 +
 drivers/soc/renesas/rz-sysc.c                 |  28 +-
 drivers/soc/renesas/rz-sysc.h                 |   2 +
 drivers/thermal/renesas/Kconfig               |   7 +
 drivers/thermal/renesas/Makefile              |   1 +
 drivers/thermal/renesas/rzg3e_thermal.c       | 575 ++++++++++++++++++
 13 files changed, 760 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
 create mode 100644 drivers/thermal/renesas/rzg3e_thermal.c

-- 
2.25.1


