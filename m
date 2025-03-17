Return-Path: <linux-pm+bounces-24186-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2741FA653E4
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 15:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 411F77A3D9A
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 14:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ECE24A060;
	Mon, 17 Mar 2025 14:39:23 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03194243364;
	Mon, 17 Mar 2025 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742222363; cv=none; b=FET0TIQWwtNswXzMmkugn0VUKd/7nT00zNvXHUKS+210Q2ETXs9IEA2mwIMnxDH+FgqbyIQ2vlaGRDl5mrolEAwB4cvK477Kh94lKjuT/cpG2mIp6gtx6ALITcneUyUdKpLwfo/N4mHHziEvW+j25RXy4JI+oX/2hJZoxQ7IvEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742222363; c=relaxed/simple;
	bh=h4t8HdhbrF5Cpe1e2wtehxAfQUoqVDl5cs2TPn7pbL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2a+WiKMDzrUCsxhOXf2jSVLHEs5yGded1yim0MI7uCuSyeiu8wpP0Dp3W1YzYYsTYxwFhOIcZafmfRQ+fALj2WpJoutAjb2bk8qFX5i6pKJU7hQIQRBrBW/tWF7Yxsqd0ZDGMx9TLiggvd8C23PEMOaottfV8hXOfjbd2TaLcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: KjQO1TRuTNO6P+DZB225HQ==
X-CSE-MsgGUID: BP0xsG2HR/a8Y3AFUPIKpQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 17 Mar 2025 23:39:20 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.200])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9E642401A637;
	Mon, 17 Mar 2025 23:39:14 +0900 (JST)
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
Subject: [PATCH v4 5/5] arm64: defconfig: Enable the Renesas RZ/G3E thermal driver
Date: Mon, 17 Mar 2025 15:34:32 +0100
Message-ID: <20250317143442.100590-6-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250317143442.100590-1-john.madieu.xa@bp.renesas.com>
References: <20250317143442.100590-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the Renesas RZ/G3E thermal driver, as used on the Renesas
RZ/G3E SMARC EVK board.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
v1 -> v2: no changes
v2 -> v3: no changes
v3 -> v4: update commit message

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a1cc3814b09b..91136c0196b5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -714,6 +714,7 @@ CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_RCAR_THERMAL=y
 CONFIG_RCAR_GEN3_THERMAL=y
 CONFIG_RZG2L_THERMAL=y
+CONFIG_RZG3E_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
 CONFIG_MTK_THERMAL=m
 CONFIG_MTK_LVTS_THERMAL=m
-- 
2.25.1


