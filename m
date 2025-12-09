Return-Path: <linux-pm+bounces-39336-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4043ACAF661
	for <lists+linux-pm@lfdr.de>; Tue, 09 Dec 2025 10:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8FB0300A6E8
	for <lists+linux-pm@lfdr.de>; Tue,  9 Dec 2025 09:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE702BE032;
	Tue,  9 Dec 2025 09:11:32 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90DD24E4A1;
	Tue,  9 Dec 2025 09:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765271492; cv=none; b=ZksjEHv1xaVa/IApkZvQGUr2um1Abd3LVAoJGM++gVXCxot7Uwg3g+y/E/SDnmpLNmoe32kAvq2mLJhoLSzjr657+/MWT5UbiTuddb+sfVLngGUEhLgSt3nrBlPeZi9wmbndKEIGT+4T3WN71+7S++sBv32BwCDqe3L+57+jFN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765271492; c=relaxed/simple;
	bh=I0WLAcciWt+I/dI2m/npfg4aWWAPK+75bXQuDma2y9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=erIT2NvJX1Hn5VOiE0gPHkw2BkMZgEI9r44ogOBX3oZ+v25ep2gtYhH+SedBEgrkuhouuxnsqjAcYiYitWdfXgArjZ/OOMAnsuX2Omog4YhujVWCEK44HrqRrrfHOdMCfhuc97H2a1ec/wZmu8upQ3ydYbVXEyXuLM8lphyCjd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 0vLYpdu/QYeodDNmhFOthg==
X-CSE-MsgGUID: oNUwAd5vQ269OfzEXGyctA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 09 Dec 2025 18:11:22 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.124])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id BC5A440071EC;
	Tue,  9 Dec 2025 18:11:16 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: john.madieu.xa@bp.renesas.com,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH 0/3] Add TSU support for the Renesas RZ/V2N SoC
Date: Tue,  9 Dec 2025 09:11:12 +0000
Message-ID: <20251209091115.8541-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series adds TSU support for the Renesas RZ/V2N SoC.

The Renesas RZ/V2N SoC includes a Thermal Sensor Unit (TSU) block designed
to measure the junction temperature. The device provides real-time
temperature measurements for thermal management, utilizing two dedicated
channels for temperature sensing.

The Renesas RZ/V2N SoC is using the same TSU IP found on the RZ/G3E SoC,
the only difference being that it has two channels instead of one.

Note: this series depends on series [1], to avoid a possible conflict
in renesas,r9a09g047-tsu.yaml.

[1] https://lore.kernel.org/all/20251126130356.2768625-1-cosmin-gabriel.tanislav.xa@renesas.com/

Best regards,
Ovidiu

Ovidiu Panait (3):
  dt-bindings: thermal: r9a09g047-tsu: Document RZ/V2N TSU
  clk: renesas: r9a09g056: Add clock and reset entries for TSU
  arm64: dts: renesas: r9a09g056: Add TSU nodes

 .../thermal/renesas,r9a09g047-tsu.yaml        |  4 +-
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi    | 75 +++++++++++++++++++
 drivers/clk/renesas/r9a09g056-cpg.c           |  6 ++
 3 files changed, 84 insertions(+), 1 deletion(-)

-- 
2.51.0


