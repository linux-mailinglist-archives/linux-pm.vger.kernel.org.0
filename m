Return-Path: <linux-pm+bounces-36971-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B1420C14D1B
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 14:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27D914EE870
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 13:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F79E3043AF;
	Tue, 28 Oct 2025 13:25:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F394204F8B;
	Tue, 28 Oct 2025 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761657959; cv=none; b=rwSYD9QDYSYu5UQUqewu3YL4qdZVWXUwxJSBV5W7NO0buWRZqlJ0kzdBAUIP0BYzkUKToPGKnRS/amm8+zl2/PzAGgYCbPgBg1VQ7y0h4UjXYacyoRyU1OlbxXRN85o3QZRwLMZdA2s+HwmHA5QJ6RpNavSzsB3F4HZlFPYxdvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761657959; c=relaxed/simple;
	bh=1BBU9WDw7qdTRE7UOJ91zXlUXSSF4iWrmf0R5SGfxVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LBbnhNVZ63/WUFPkO6Uctku1l+uegFzFpzsB+x8J1cGnwwpOqN+CxmkiA3krj4qq1PMLiLkR4DS8eEtlFDwCif6dtX8moxPeVg08YPBMYmjMcdNBxc/1xX3ckI7fi+GRtxwxXabNUuUq+SsIOsz2rDvQooSTcYZaFqEImE3Ryzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: +4XZSKA7RsW2Owz6ieAiaQ==
X-CSE-MsgGUID: 32MqCp2zRUK8ycUwMlo8Ng==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 28 Oct 2025 22:25:54 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.5])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id A740940078A8;
	Tue, 28 Oct 2025 22:25:49 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: 
Cc: John Madieu <john.madieu.xa@bp.renesas.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v2 0/9] Add TSU support for RZ/T2H and RZ/N2H
Date: Tue, 28 Oct 2025 15:25:08 +0200
Message-ID: <20251028132519.1472676-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.1
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

V2:
 * drop clk patch already present in linux-next
 * dt-bindings: merge two items into a single enum

Cosmin Tanislav (9):
  thermal: renesas: rzg3e: make reset optional
  thermal: renesas: rzg3e: make min and max temperature per-chip
  thermal: renesas: rzg3e: make calibration value retrieval per-chip
  dt-bindings: thermal: r9a09g047-tsu: document RZ/T2H and RZ/N2H
  thermal: renesas: rzg3e: add support for RZ/T2H and RZ/N2H
  arm64: dts: renesas: r9a09g077: add OPP table
  arm64: dts: renesas: r9a09g087: add OPP table
  arm64: dts: renesas: r9a09g077: add TSU and thermal zones support
  arm64: dts: renesas: r9a09g087: add TSU and thermal zones support

 .../thermal/renesas,r9a09g047-tsu.yaml        |  21 ++-
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi    |  65 +++++++++
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi    |  65 +++++++++
 drivers/thermal/renesas/rzg3e_thermal.c       | 125 ++++++++++++------
 4 files changed, 230 insertions(+), 46 deletions(-)

-- 
2.51.1


