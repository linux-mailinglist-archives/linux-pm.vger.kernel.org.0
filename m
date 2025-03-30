Return-Path: <linux-pm+bounces-24611-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F255DA75D1B
	for <lists+linux-pm@lfdr.de>; Mon, 31 Mar 2025 00:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B2E97A3A34
	for <lists+linux-pm@lfdr.de>; Sun, 30 Mar 2025 22:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411DF1DE88A;
	Sun, 30 Mar 2025 22:12:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B67360;
	Sun, 30 Mar 2025 22:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743372736; cv=none; b=KynsR+4Eiu7wdeDu0wLuW7/y6jUPO4tbwvcFnJCZhM+3iPcrO3CRiBPwEAXAZSFfa89HWc/x4XbEriT4IJuKuQZA1Ib/gqUeRi9rzWGU29BHi0jBPNRA1OMDlME2o2EJr5Zrxk7HXatsWpNcqOBSuBwT8AF3UfDkfETdTWRgINQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743372736; c=relaxed/simple;
	bh=zxs9NK/7J6cF5yXN8WD4I9b3sTnPdCT6V9gjOyMpCIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=umEPCn5cbKg0GMRHhln1EsRQ1+sziE34db5kHWZMYm5k+DeozSJ1lz7Fodp2joMdB6nVoj3J389BfERLhQfyGJWev941d3m2t7YQaLO9KDh+GWR8hj9W7NTBKa99v6k0DNNV/nU19SmHxFQ97D6EP9odSxFozcnYLXC+ykv+XZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 3qadkYhTSR+fjAvV7NR60Q==
X-CSE-MsgGUID: fnE7wi0MSCqL6LvANbyRyQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 31 Mar 2025 07:12:11 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.1])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 80B9840078C5;
	Mon, 31 Mar 2025 07:12:06 +0900 (JST)
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
Subject: [PATCH v5 0/5] thermal: renesas: Add support fot RZ/G3E
Date: Sun, 30 Mar 2025 23:49:36 +0200
Message-ID: <20250330214945.185725-1-john.madieu.xa@bp.renesas.com>
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

- patch 2-5/5:  adds dt-bindings, actual driver, DT node, and config symbol.

Note to Maintainers: There is a false positive warning reported by
checkpatch.pl on patch 1/5 stating that the regmap_config struct should be
const, despite the fact it's updated in probe().

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
 drivers/thermal/renesas/rzg3e_thermal.c       | 443 ++++++++++++++++++
 11 files changed, 621 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
 create mode 100644 drivers/thermal/renesas/rzg3e_thermal.c

-- 
2.25.1


