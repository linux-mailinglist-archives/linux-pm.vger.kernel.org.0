Return-Path: <linux-pm+bounces-27523-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4659AC1335
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 20:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 119D87B64BF
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 18:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D281B1A01C6;
	Thu, 22 May 2025 18:23:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B6D208AD;
	Thu, 22 May 2025 18:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747938199; cv=none; b=qxca8OgLV8PW32xTXgzTUUtoir9dDm6lAIwVvfkFaT20X41DrsLYh6akFEvO3cX+o5PYTnqzR3Zewi6+u57oxC7ySwnt0RHO1pRxd1Yhf7HEI+aOIs8GyQOn3pnPY/x0xsYFo2fTyPAUMTsdFsJMjWUHQwcDYf79w0BxtwKJVqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747938199; c=relaxed/simple;
	bh=0uIGB6AYp+NE4k2Bu8VAEfPMGxGU7Esz8GDtIMONpwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kywsPPpoIo7TZHebJHkh/D96095kMeWyZfXDIXnLwOtTp4netC2pLQzHYr1cEjlDxvbaTETv/iEpANNsDOdRgls/z5WYslA1IPuG5sVDhweyXxiZt1gJEHM8H8Li5fllKCh03EuacG5jnq/HLjG8mMwwQRHksYb0XDpSTTGUHM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: lVALX+CIRDaxcGjvIGti8Q==
X-CSE-MsgGUID: 125OKLfMTqqzJmWG9TmdZw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 23 May 2025 03:23:14 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.203])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B78784061FFE;
	Fri, 23 May 2025 03:23:09 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: john.madieu.xa@bp.renesas.com,
	conor+dt@kernel.org,
	daniel.lezcano@linaro.org,
	geert+renesas@glider.be,
	krzk+dt@kernel.org,
	rafael@kernel.org
Cc: biju.das.jz@bp.renesas.com,
	devicetree@vger.kernel.org,
	john.madieu@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	lukasz.luba@arm.com,
	magnus.damm@gmail.com,
	robh@kernel.org,
	rui.zhang@intel.com,
	sboyd@kernel.org,
	niklas.soderlund+renesas@ragnatech.se
Subject: [PATCH v6 0/5] thermal: renesas: Add support for RZ/G3E
Date: Thu, 22 May 2025 20:22:43 +0200
Message-ID: <20250522182252.1593159-1-john.madieu.xa@bp.renesas.com>
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

Patch 1/5 has been duplicated at [1] in USB series. Since it was not reviewed
nor merged yet, I use it here to ease the review, so that which ever is
reviewed first get merged.

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

Regards,

[1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20250521140943.3830195-2-claudiu.beznea.uj@bp.renesas.com/

John Madieu (5):
  soc: renesas: rz-sysc: Add syscon/regmap support
  dt-bindings: thermal: r9a09g047-tsu: Document the TSU unit
  thermal: renesas: rzg3e: Add thermal driver for the Renesas RZ/G3E SoC
  arm64: dts: renesas: r9a09g047: Add TSU node
  arm64: defconfig: Enable the Renesas RZ/G3E thermal driver

 .../thermal/renesas,r9a09g047-tsu.yaml        |  81 ++++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  48 ++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/soc/renesas/Kconfig                   |   1 +
 drivers/soc/renesas/r9a08g045-sysc.c          |  10 +
 drivers/soc/renesas/r9a09g047-sys.c           |  10 +
 drivers/soc/renesas/r9a09g057-sys.c           |  10 +
 drivers/soc/renesas/rz-sysc.c                 |  17 +-
 drivers/soc/renesas/rz-sysc.h                 |   3 +
 drivers/thermal/renesas/Kconfig               |   7 +
 drivers/thermal/renesas/Makefile              |   1 +
 drivers/thermal/renesas/rzg3e_thermal.c       | 443 ++++++++++++++++++
 13 files changed, 638 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
 create mode 100644 drivers/thermal/renesas/rzg3e_thermal.c

-- 
2.25.1


