Return-Path: <linux-pm+bounces-40487-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B18D052F8
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 18:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE43431EE28A
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 16:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB322EC080;
	Thu,  8 Jan 2026 16:54:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C83F2DCF46;
	Thu,  8 Jan 2026 16:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767891288; cv=none; b=GpQOCzG+DVFtOJqQWKgoiFyhIBzQ8/62tNwp/Olba/D+wUP8vxpKTp32z/qNyNCkCFwTeOeNe6byXRt18JODBuKwl6IPZKdkDA+lYSpv3wGlUFZ6FCOSxsHpBXQWtuuMIoGtfsur7dAZWpGcThMBPASLdFUhB41aP3cW54EY0lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767891288; c=relaxed/simple;
	bh=SXCIemVsSq+men+Rn57f4sIO/YU2PfLkAli871bNEdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lM+4MmBgz6Rle95GKj3Evvj3ZIroVP9I+KMW36UN9IoJ+P3th6hvBbS2nNlsDKQuBjsuOlhtorow9hlF2tB7yhZZWQRXuGi/EEdEoq0x53VaoU9nj8HQjMdOz0xe7BcX7t2myYEbVGW2ahtqRassF0p24muIgjgIfJePdJEY9ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: /yMf67akRw6C6sks2BJknQ==
X-CSE-MsgGUID: AkLhgZ2sQgag+jRrEIQk+g==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 09 Jan 2026 01:54:39 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.68])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 70D8B403137F;
	Fri,  9 Jan 2026 01:54:34 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: Add TSU support for RZ/T2H and RZ/N2H
Date: Thu,  8 Jan 2026 18:53:19 +0200
Message-ID: <20260108165324.11376-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs expose the
temperature calibration via SMC SIP and do not have a reset for the
TSU peripheral, and use different minimum and maximum temperature values
compared to RZ/G3E.

Although the calibration data is stored in an OTP memory, the OTP itself
is not memory-mapped, and instead, access to it is done through an OTP
controller. The OTP controller is only accessible from the secure world,
but the temperature calibration data stored in the OTP is exposed via
SMC.

V4:
 * pick up Geert's Reviewed-by
 * pick up John's Reviewed-by and Tested-by
 * pick up Conor's Acked-by
 * replace new macro TSU_TEMP_MASK usage with existing macro
   TSU_CODE_MAX
 * remove "Validate calibration data" comments
 * inline rzg3e_validate_calibration() into rzg3e_thermal_probe()
 * drop dts patches queued up by Geert

V3:
 * dt-bindings: rebase on top of [1]
 * dt-bindings: conditionally add `resets: false` and
   `renesas,tsu-trim: false` for renesas,r9a09g077-tsu compatibles

V2:
 * drop clk patch already present in linux-next
 * dt-bindings: merge two items into a single enum

[1]: https://patchwork.kernel.org/project/linux-pm/cover/20251020143107.13974-1-ovidiu.panait.rb@renesas.com/

Cosmin Tanislav (5):
  thermal: renesas: rzg3e: make reset optional
  thermal: renesas: rzg3e: make min and max temperature per-chip
  thermal: renesas: rzg3e: make calibration value retrieval per-chip
  dt-bindings: thermal: r9a09g047-tsu: document RZ/T2H and RZ/N2H
  thermal: renesas: rzg3e: add support for RZ/T2H and RZ/N2H

 .../thermal/renesas,r9a09g047-tsu.yaml        |  30 ++++-
 drivers/thermal/renesas/rzg3e_thermal.c       | 122 +++++++++++-------
 2 files changed, 100 insertions(+), 52 deletions(-)

-- 
2.52.0


