Return-Path: <linux-pm+bounces-24086-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 803CBA628BA
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 09:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98BDC3B3697
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 08:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DFC1DE2DB;
	Sat, 15 Mar 2025 08:12:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B628633F;
	Sat, 15 Mar 2025 08:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742026358; cv=none; b=tvVsQFP5rkm1/RPP/19pZ55+IWFBYfSsd4zzIiBlJ+Nwdv/PpcuSLHn/QTjW4edL/rTql5Opv55sHsC1amkp9iFDLUfARITy9Rag5Hp0NHCJsCN7cuV2LT9u2W3/3iJeudbsOIjX3WLBKHIjAUmd2g3h33xtzy6vbB1zA3JlUoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742026358; c=relaxed/simple;
	bh=jG9oPcjZqHlbR4d47jM7VKXo5P/tae2bdnMELTmPOaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i2bFk9sTTs9FHFRA84i1QPccASBbg4kqCPK5/kUU3R7Y5I6iEQU9naXOOMlKpkdG+NIKSy9ofqZyMfRqNCmDeul/uqUrmIODgONtWPe+Bu5uqj4eFRoayA5weHauAUb6qMoxJ5IuAtpMp9lJi8oRvLlZ7hpmbzveVAWodEFRH14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: ZMxv4JYITJmRHA9upJO4aQ==
X-CSE-MsgGUID: n+2J8ZdeRyaN7PalhWpnvg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 15 Mar 2025 17:12:33 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.58])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E69F641BFA40;
	Sat, 15 Mar 2025 17:12:28 +0900 (JST)
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
Subject: [PATCH v3 0/6] thermal: renesas: Add support fot RZ/G3E
Date: Sat, 15 Mar 2025 09:12:10 +0100
Message-ID: <20250315081225.92118-1-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This series adds support for the temperature sensor unit (TSU) found on the
Renesas RZ/G3E SoC.

The series consists of 7 patches (some of which are not related to the thermal
framework) that progressively add TSU support as follows:
- patch 1/6:    adds syscon/regmap support for accessing system controller
                registers, enabling access to TSU calibration values

- patch 2/6:    adds dt-bindings
- patch 3/6:    adds the actual TSU driver for the RZ/G3E
- patch 4/6:    adds safety mechanism to make sure we we protect the chip in
                case of consecutive read failures
- patch 4-6/6:  add DT node and defconfig enablement


Changes:

v1 -> v2
 * Fix yaml warnings from dt-binding
 * Update IRQ names to reflect TSU expectations

v2 -> v3
 * Remove useless 'renesas,tsu-operating-mode' property

Regards,

John Madieu (6):
  soc: renesas: rz-sysc: add syscon/regmap support
  dt-bindings: thermal: r9a09g047-tsu: Document the TSU unit
  thermal: renesas: rzg3e: Add thermal driver for the Renesas RZ/G3E SoC
  thermal: renesas: rzg3e: Add safety check when reading temperature
  arm64: dts: renesas: r9a09g047: Add TSU node
  arm64: defconfig: Enable RZ/G3E thermal

 .../thermal/renesas,r9a09g047-tsu.yaml        | 113 +++++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  48 ++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/soc/renesas/Kconfig                   |   1 +
 drivers/soc/renesas/r9a09g047-sys.c           |   1 +
 drivers/soc/renesas/rz-sysc.c                 |  30 +-
 drivers/soc/renesas/rz-sysc.h                 |   2 +
 drivers/thermal/renesas/Kconfig               |   7 +
 drivers/thermal/renesas/Makefile              |   1 +
 drivers/thermal/renesas/rzg3e_thermal.c       | 479 ++++++++++++++++++
 11 files changed, 689 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
 create mode 100644 drivers/thermal/renesas/rzg3e_thermal.c

-- 
2.25.1


