Return-Path: <linux-pm+bounces-36253-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2953ABE3A63
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 15:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32EC41A65463
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 13:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106891F0E58;
	Thu, 16 Oct 2025 13:18:50 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AEF1D63F0;
	Thu, 16 Oct 2025 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760620730; cv=none; b=LC0nT6jjaPByK9kC5QS5EP3j+Lz4cDRVXEuHjOvFThKZi1XxwRDWNjAJ5g30sncEVWcbLxMw/tMpgaHtyJI37r2LUAT74m/Ewtt1eb8QhtZGfdz75FQxpk3X087WFDeyDfIG9ItvuGtWYmi3hJBMmThn1iLS2m179Qe50PwXBWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760620730; c=relaxed/simple;
	bh=zBXrZrK2pRBw62/rc5VYqqaYyjnXzLoQl9YKGS8Eivw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anHNGceuikx4OllfaQDc+DmrMTdV28lrJX+fDLsLmKja0dVYj2YKvXq6g3TAKfKRMTPLOVpR+6JPH7dBYA4g1nOFRdapT/WUzX2bNywVU7mTf8vj9pK3mDPAOXz9pQYdz7LBLePY7QeCkV+j3rOUxnM5IihSWveyvb2Dco+BaS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 1Q9Aj23YQpC/OfblMUuLWA==
X-CSE-MsgGUID: C109HfjMSFGLFhEVNyXkjA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Oct 2025 22:13:45 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.8])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7AB5941CB11F;
	Thu, 16 Oct 2025 22:13:40 +0900 (JST)
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
Subject: [PATCH 2/3] dt-bindings: thermal: r9a09g047-tsu: Document RZ/V2H TSU
Date: Thu, 16 Oct 2025 13:13:26 +0000
Message-ID: <20251016131327.19141-3-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016131327.19141-1-ovidiu.panait.rb@renesas.com>
References: <20251016131327.19141-1-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Renesas RZ/V2H SoC includes a Thermal Sensor Unit (TSU) block designed
to measure the junction temperature. The device provides real-time
temperature measurements for thermal management, utilizing two dedicated
channels for temperature sensing.

The Renesas RZ/V2H SoC is using the same TSU IP found on the RZ/G3E SoC,
the only difference being that it has two channels instead of one.

Add new compatible string "renesas,r9a09g057-tsu" for RZ/V2H and use
"renesas,r9a09g047-tsu" as a fallback compatible to indicate hardware
compatibility with the RZ/G3E implementation.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
index 8d3f3c24f0f2..274e96e37a12 100644
--- a/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
+++ b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
@@ -16,7 +16,12 @@ description:
 
 properties:
   compatible:
-    const: renesas,r9a09g047-tsu
+    oneOf:
+      - items:
+          - const: renesas,r9a09g047-tsu # RZ/G3E
+      - items:
+          - const: renesas,r9a09g057-tsu # RZ/V2H
+          - const: renesas,r9a09g047-tsu # RZ/G3E
 
   reg:
     maxItems: 1
-- 
2.51.0


