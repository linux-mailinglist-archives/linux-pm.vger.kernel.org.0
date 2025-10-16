Return-Path: <linux-pm+bounces-36252-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F94BE3A51
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 15:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C8DD1A65402
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 13:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DC41E0DEA;
	Thu, 16 Oct 2025 13:18:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0267B1D63F0;
	Thu, 16 Oct 2025 13:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760620725; cv=none; b=rtTeDHMOGQy2o9XC4UTQrjShd+GKo9Kg2CPQNYUBKZcmVT8RReUJL9YNv/SyhNYm38YjZ60Vsx8aCeqKGMCvX0hf6jf7/bHwnYDj7CKWtEo45lRx6zk8go1sz3/SvlX2zWHXRKUp3L8ENpqthY/zVdH/COh5A1ynBsI9KKpDTE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760620725; c=relaxed/simple;
	bh=Nn7uOs5GW1/6qUmPIXfE6B6oLA5OjxF+GXumtCmXsT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NOaDcKgbTX2RY/WDtj1X8/HwFqqwRlyEy/AfkFFPc5433p8nZuFGcAaAowBXOam/jABY2fVNs/ig0gHTT3vX/kKDZWNRwm0a3j2o33kXPI/zqBoKsbtXgCoOiNF9PO2+rDK7eHARkHCZz24qhuZFFQVNwq+s1OXDDjk27ev/2dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: kq3DJWO5QvWrHalCYR1dHQ==
X-CSE-MsgGUID: LG5HJzMWSj+XSTpU4hcFtA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Oct 2025 22:13:34 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.8])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B3F2D41CB11F;
	Thu, 16 Oct 2025 22:13:28 +0900 (JST)
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
Subject: [PATCH 0/3] Add TSU support for the Renesas RZ/V2H SoC
Date: Thu, 16 Oct 2025 13:13:24 +0000
Message-ID: <20251016131327.19141-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series adds TSU support for the Renesas RZ/V2H SoC.

The Renesas RZ/V2H SoC includes a Thermal Sensor Unit (TSU) block designed
to measure the junction temperature. The device provides real-time
temperature measurements for thermal management, utilizing two dedicated
channels for temperature sensing.

The Renesas RZ/V2H SoC is using the same TSU IP found on the RZ/G3E SoC,
the only difference being that it has two channels instead of one.

Best regards,
Ovidiu

Ovidiu Panait (3):
  clk: renesas: r9a09g057: Add clock and reset entries for TSU
  dt-bindings: thermal: r9a09g047-tsu: Document RZ/V2H TSU
  arm64: dts: renesas: r9a09g057: Add TSU nodes

 .../thermal/renesas,r9a09g047-tsu.yaml        |  7 +-
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi    | 75 +++++++++++++++++++
 drivers/clk/renesas/r9a09g057-cpg.c           |  6 ++
 3 files changed, 87 insertions(+), 1 deletion(-)

-- 
2.51.0


