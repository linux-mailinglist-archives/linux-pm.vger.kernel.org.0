Return-Path: <linux-pm+bounces-36470-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2864EBF1DC8
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 16:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA3F93B603E
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 14:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD01221578;
	Mon, 20 Oct 2025 14:31:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E671421FF4D;
	Mon, 20 Oct 2025 14:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760970688; cv=none; b=iMpKMTS7KFr9NH5eqoOoRp4CYJijcxwf/kQJqRDREjLfQ1B1w241dvNHy5g6B6B1rEjt6rLg+A++hQyh6LOg34K9sXRcvtu5MFcRW4Ml6DP5/yhavitstl+9GM3RLp8XyNNV8LI5fRyKbuBrOi+h6G7F7bGkmZ3y0hhlbuwTpSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760970688; c=relaxed/simple;
	bh=RmDctZXm85kTLVYOSDkgdDNVCzPmUFMnuvpzQZziQro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Do4MmNsbRPEVz0BPaym//+1cJQioSHKo+cXwKjuUeoE0c+47AGYL4s6hLeSVSMMJg7fJC4c57GI7DfXW2KnlTPbEB0HBFUBoYHpTw1X7KLaGOu+LzxswdjldxcXQ3FaasyKRZ8ZhE6ii5cjNAAKi/YwIhpT/vuQi9RWAOj3967U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: safs7Iz4ROaWEswTR1lfVw==
X-CSE-MsgGUID: JiGLIIcsTXWmbAUrnk3ZTQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Oct 2025 23:31:25 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.23])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 77D6541CCD99;
	Mon, 20 Oct 2025 23:31:20 +0900 (JST)
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
Subject: [PATCH v2 2/3] dt-bindings: thermal: r9a09g047-tsu: Document RZ/V2H TSU
Date: Mon, 20 Oct 2025 14:31:06 +0000
Message-ID: <20251020143107.13974-3-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251020143107.13974-1-ovidiu.panait.rb@renesas.com>
References: <20251020143107.13974-1-ovidiu.panait.rb@renesas.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v2 changes:
- dropped unneeded "items" from compatible list
- added "Reviewed-by:" tag from Krzysztof

 .../devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml  | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
index 8d3f3c24f0f2..befdc8b7a082 100644
--- a/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
+++ b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
@@ -16,7 +16,11 @@ description:
 
 properties:
   compatible:
-    const: renesas,r9a09g047-tsu
+    oneOf:
+      - const: renesas,r9a09g047-tsu # RZ/G3E
+      - items:
+          - const: renesas,r9a09g057-tsu # RZ/V2H
+          - const: renesas,r9a09g047-tsu # RZ/G3E
 
   reg:
     maxItems: 1
-- 
2.51.0


