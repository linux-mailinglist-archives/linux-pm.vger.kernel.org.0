Return-Path: <linux-pm+bounces-36469-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B919BBF1DB6
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 16:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB9E24F6701
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 14:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73C520D51C;
	Mon, 20 Oct 2025 14:31:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678C51A239A;
	Mon, 20 Oct 2025 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760970684; cv=none; b=ZJZ8+rx5vK+kEy9ofroqbgF8I5Q/qAWFiD3vhflR/Cqul0TTKGgRbo62uPE//Osn/HJTh8LqMBdwznmEAQWxpAhGDRAq6IjabcX8qmbs1Unpj5n+Mwqk0dCX1F2eAq5Vx/PjK+hgCl89YJf181ToxE7igCwvpwFXqy2yc7Mj+uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760970684; c=relaxed/simple;
	bh=BRhmsRc0I/U90tySmc1W3dDFOEcpSBuOh2riT89cVfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MJcLqd06KLC7vGttCeK6JgI7Bm8BS937vH68mGfBLs2+ihIyjzO22bbN2IR6rIS2REhpFtTke35vy8ok8RMMVHDs7ZiBYxZOHjUMeFa/oZWGH6XBrnnwoURy5Axgd9qq8a+Ha027WzoNXMLkW+vUgn4NNuRNkg7ajfvsjVRCp4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: EgD152R9Q7KUIvjCt7wLmw==
X-CSE-MsgGUID: pecVp6alSMGua6RKoTeLyg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Oct 2025 23:31:14 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.23])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D919141CCD99;
	Mon, 20 Oct 2025 23:31:08 +0900 (JST)
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
Subject: [PATCH v2 0/3] Add TSU support for the Renesas RZ/V2H SoC
Date: Mon, 20 Oct 2025 14:31:04 +0000
Message-ID: <20251020143107.13974-1-ovidiu.panait.rb@renesas.com>
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

v2:
- Dropped unneeded "items" from bindings compatible list.
- Added "Reviewed-by:" tag from Krzysztof for the bindings patch.


Ovidiu Panait (3):
  clk: renesas: r9a09g057: Add clock and reset entries for TSU
  dt-bindings: thermal: r9a09g047-tsu: Document RZ/V2H TSU
  arm64: dts: renesas: r9a09g057: Add TSU nodes

 .../thermal/renesas,r9a09g047-tsu.yaml        |  6 +-
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi    | 75 +++++++++++++++++++
 drivers/clk/renesas/r9a09g057-cpg.c           |  6 ++
 3 files changed, 86 insertions(+), 1 deletion(-)

-- 
2.51.0


