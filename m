Return-Path: <linux-pm+bounces-38706-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6C7C89E6F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 14:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 830073564D6
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 13:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B38B1EF0B0;
	Wed, 26 Nov 2025 13:04:53 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C4D1D63E4;
	Wed, 26 Nov 2025 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764162293; cv=none; b=upZ+8txPvlXqkJK0JFu9DeZLHeR3LqMi8jT6oOqfnDu2jHc8KPCh+ris1zglKwB/sdeoKtp7ISUV7WgZParps9ikE6nt5ys+AU3NJY7RVKyRg/2rRMEZCvbbh4gh+qhsFwuZC8sW9SQwdP/XXZhhg8QvMNGnpExkcoLm9JZ1r+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764162293; c=relaxed/simple;
	bh=nMIzZOP0boaK60mwVU9Tkf09hRsPUTN8b+JJ1k8hqWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r9dcLHQVyTcW7SSzmxTT+B+g+WI/5+iVYrWEGomI2HFqvZJaxOEFvWuKHfKzrSAdVRzlDlW5Dx7a+GyQYcEHefkyZFrLHpdZGbmjQEnZyLWaVTnrcvOSuog5GXQFO2Ic6NRsCFYS28IhzML4k40Zpo8CHDLoM4M9cwlvEB48sFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: laUAQCBgQK2WFQ2YG6l6zA==
X-CSE-MsgGUID: 4hWilme1Q9OkQB5YLtpVaw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 26 Nov 2025 22:04:43 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.98])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id A6650400EF74;
	Wed, 26 Nov 2025 22:04:38 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v3 0/9] Add TSU support for RZ/T2H and RZ/N2H
Date: Wed, 26 Nov 2025 15:03:47 +0200
Message-ID: <20251126130356.2768625-1-cosmin-gabriel.tanislav.xa@renesas.com>
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

V3:
 * dt-bindings: rebase on top of [1]
 * dt-bindings: conditionally add `resets: false` and
   `renesas,tsu-trim: false` for renesas,r9a09g077-tsu compatibles

V2:
 * drop clk patch already present in linux-next
 * dt-bindings: merge two items into a single enum

[1]: https://patchwork.kernel.org/project/linux-pm/cover/20251020143107.13974-1-ovidiu.panait.rb@renesas.com/

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

 .../thermal/renesas,r9a09g047-tsu.yaml        |  30 ++++-
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi    |  65 +++++++++
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi    |  65 +++++++++
 drivers/thermal/renesas/rzg3e_thermal.c       | 125 ++++++++++++------
 4 files changed, 239 insertions(+), 46 deletions(-)

-- 
2.52.0


