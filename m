Return-Path: <linux-pm+bounces-36693-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C4BBFFD57
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 10:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC8254E7C43
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 08:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C7E2F28E5;
	Thu, 23 Oct 2025 08:20:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B079014A9B;
	Thu, 23 Oct 2025 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207604; cv=none; b=OoSME8YYwvu1Z+ER2GGzVdT03M1qm6FGJMi1z4EMm9GZ3QG+i1uul38FkUrsNrvGUPvDhw6nizMJf/u9vt9NiU82boFPcKRvX3VZ41dztgOzxSrniJ+lqoGnL6zKuqp2BSURI7aczwpJpN/cUGe8X46x22a2onog+ibbywsWY3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207604; c=relaxed/simple;
	bh=7JVn6je+XWVPseD1Rs6Bg/qAvSZPM2H9/QJ62sUT08w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q204xlDOByx7baQ0dBRsstq7AzWgpW4myu4E1FiqQto9Tw2RRqqgFdmT49T/rVMAIdXaI2MeLAcrJhn2L7Xy4wdUjIOUSilEdIO/eGaEF2n6maLzRHfH90JYsMseSBbRt1WjNwxSmwD7nfO2HeLR8ai4WQ/OoUpr4ZrD5y4HSYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: iyhE11bsQwyz/35ivY+AVw==
X-CSE-MsgGUID: BfRsIhk8QxSDqQ2oT9NBmA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 23 Oct 2025 17:20:00 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.77])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9DD5F417CA7F;
	Thu, 23 Oct 2025 17:19:54 +0900 (JST)
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
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 00/10] Add TSU support for RZ/T2H and RZ/N2H
Date: Thu, 23 Oct 2025 11:19:14 +0300
Message-ID: <20251023081925.2412325-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.1.dirty
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

Cosmin Tanislav (10):
  clk: renesas: r9a09g077: add TSU module clock
  thermal: renesas: rzg3e: make reset optional
  thermal: renesas: rzg3e: make min and max temperature per-chip
  thermal: renesas: rzg3e: make calibration value retrieval per-chip
  dt-bindings: thermal: r9a09g047-tsu: document RZ/T2H and RZ/N2H
  thermal: renesas: rzg3e: add support for RZ/T2H and RZ/N2H
  arm64: dts: renesas: r9a09g077: add OPP table
  arm64: dts: renesas: r9a09g087: add OPP table
  arm64: dts: renesas: r9a09g077: add TSU and thermal zones support
  arm64: dts: renesas: r9a09g087: add TSU and thermal zones support

 .../thermal/renesas,r9a09g047-tsu.yaml        |  22 ++-
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi    |  65 +++++++++
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi    |  65 +++++++++
 drivers/clk/renesas/r9a09g077-cpg.c           |   1 +
 drivers/thermal/renesas/rzg3e_thermal.c       | 125 ++++++++++++------
 5 files changed, 232 insertions(+), 46 deletions(-)

-- 
2.51.1.dirty


