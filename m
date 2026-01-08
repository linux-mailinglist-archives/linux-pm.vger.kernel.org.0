Return-Path: <linux-pm+bounces-40498-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C6AD05E9D
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 20:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E09FF3006E26
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 19:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95460328B45;
	Thu,  8 Jan 2026 19:53:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DB0308F33;
	Thu,  8 Jan 2026 19:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767902005; cv=none; b=TDOAunAGB1UKxgwrX+QB3GCcD2vRs3yI679PqdiIfnXjl9Uz2Tls3wV142p3Kflv9BEkrbN5bwqgyJefTaIkl1pI+CMqlyxV2Xgcsefc3Lya9MNuyZQ0wgvkt9/O5VCcxjg74XyRoaxryiaJEcfZ9OjsOE7q4ad9grhCUnwTjr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767902005; c=relaxed/simple;
	bh=CvLQVQpLrXBXuUU4FAyO2rVZyPZ7HkfpAN8oXOLXwEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p54dO78mYlPnTesIe6LCgbc6nA3G/K1RWK4996GCbantFZdjNXdaikCMtX0WFTlTW7diHq6ct+gD7pjV7Pzn4fZdj3alrwoYpvIbLQJ20cZjd/LqhdYjCkbo932BsL41j7PorsRTo1FaZyo9X9iNTLx6T7ViRfFFbRvY4lUIE5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: VnnBuhv7RmC3/zwjV2nDIg==
X-CSE-MsgGUID: rhFsdpAERwOc4BRVJf1lsg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 09 Jan 2026 04:53:21 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.68])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D1BFC475F1F5;
	Fri,  9 Jan 2026 04:53:16 +0900 (JST)
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
Subject: [PATCH v5 0/5] Add TSU support for RZ/T2H and RZ/N2H
Date: Thu,  8 Jan 2026 21:52:18 +0200
Message-ID: <20260108195223.193531-1-cosmin-gabriel.tanislav.xa@renesas.com>
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

V5:
 * replace hardcoded 0xFFF values with TSU_CODE_MAX
 * add arm-smccc.h include

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
 drivers/thermal/renesas/rzg3e_thermal.c       | 123 +++++++++++-------
 2 files changed, 101 insertions(+), 52 deletions(-)

-- 
2.52.0


