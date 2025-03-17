Return-Path: <linux-pm+bounces-24181-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26084A653C7
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 15:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CF793A5C7E
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 14:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8C8243371;
	Mon, 17 Mar 2025 14:38:54 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE33243364;
	Mon, 17 Mar 2025 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742222334; cv=none; b=U6GV3LwRet4ZCuwmX2xexOwfnrtm4sNfa4o8p0QSTb/b32NOxccgoYE/0T+JeoL4z/5hpkfvkbxzj/EWaAFAQkQa4LcEtZn8zDw9f7USQ86DIrcApWsPu0CanL/+Ov4PnujxTvIJFL+Vlc1Pi7sIYz+bn289BiQdlEZs7xaJ7LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742222334; c=relaxed/simple;
	bh=o/Q72SbAFLIeIKcMmBjNv06VKL5qWKFA5ZM4mJnjfDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=baFiyvduvEinXefzfyXq7yXFqn/eYxG3+F6QavQF/vl6sPkZHesbUNzPLJtlWvq2tWQjjQO7pTJJC8Frq50pM5nHw27aArEJc5J1Xu/TBhi40QRBYTwZ34Ouq/0wzkdQGkXV3i+J+NvtFV0UCzLYwZIezpHk48/Pl1bq+hbwX1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: BW5lC7U3TBatQXyFE42jtA==
X-CSE-MsgGUID: eoiSUUEzTQaIGzYVX68NoA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 17 Mar 2025 23:38:49 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.200])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 80B63401A473;
	Mon, 17 Mar 2025 23:38:44 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: geert+renesas@glider.be,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: magnus.damm@gmail.com,
	devicetree@vger.kernel.org,
	john.madieu@gmail.com,
	rui.zhang@intel.com,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	sboyd@kernel.org,
	biju.das.jz@bp.renesas.com,
	linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH v4 0/5] thermal: renesas: Add support fot RZ/G3E
Date: Mon, 17 Mar 2025 15:34:27 +0100
Message-ID: <20250317143442.100590-1-john.madieu.xa@bp.renesas.com>
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
- patch 1/5:    adds syscon/regmap support for accessing system controller
                registers, enabling access to TSU calibration values

- patches 2-5/5:  add dt-bindings, actual driver, DT node, and config symbol.

Changes:

v1 -> v2
 * Fix yaml warnings from dt-binding
 * Update IRQ names to reflect TSU expectations

v2 -> v3
 * Remove useless 'renesas,tsu-operating-mode' property

v3 -> v4
 * Improve some commit messages
 * Fix interrupt description in YAML binding file

Regards,

John Madieu (5):
  soc: renesas: rz-sysc: add syscon/regmap support
  dt-bindings: thermal: r9a09g047-tsu: Document the TSU unit
  thermal: renesas: rzg3e: Add thermal driver for the Renesas RZ/G3E SoC
  arm64: dts: renesas: r9a09g047: Add TSU node
  arm64: defconfig: Enable the Renesas RZ/G3E thermal driver

 .../thermal/renesas,r9a09g047-tsu.yaml        |  81 ++++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  48 ++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/soc/renesas/Kconfig                   |   1 +
 drivers/soc/renesas/r9a09g047-sys.c           |   1 +
 drivers/soc/renesas/rz-sysc.c                 |  30 +-
 drivers/soc/renesas/rz-sysc.h                 |   2 +
 drivers/thermal/renesas/Kconfig               |   7 +
 drivers/thermal/renesas/Makefile              |   1 +
 drivers/thermal/renesas/rzg3e_thermal.c       | 445 ++++++++++++++++++
 11 files changed, 623 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
 create mode 100644 drivers/thermal/renesas/rzg3e_thermal.c

-- 
2.25.1


