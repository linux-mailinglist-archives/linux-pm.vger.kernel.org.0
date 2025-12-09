Return-Path: <linux-pm+bounces-39337-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1338CAF667
	for <lists+linux-pm@lfdr.de>; Tue, 09 Dec 2025 10:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F09C1300CA29
	for <lists+linux-pm@lfdr.de>; Tue,  9 Dec 2025 09:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5152C0274;
	Tue,  9 Dec 2025 09:11:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB282D12ED;
	Tue,  9 Dec 2025 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765271495; cv=none; b=WooppnqwKzzwDR4IcAu9hVERZUVJosFCdV4NrEMSuvTuBfqfUzFrYFsNGpyPAuwQMmI245mdCoQebfXI2yGUkjleT8+chSBAckJ9XiZT9jgN3juk8HkL99R5Paw71tQFO87/DznpHcrWU3o6v2ptFuxmsfOtliWOSeR5OVmPHkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765271495; c=relaxed/simple;
	bh=jjCcNU6521+jhdzUHgDC++nvbAEjOdLIhUK5/nIcTMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAVVNHdQP76Sro8KwwJbj19g1nBn7ENtLU6eYoc0gB6INmh1U6yB+ATUYR1x3jDac32sepcCrve1BLtxN1s4Pk0l2gqfLZf0bKHoSQtpMYBjRUcV6VOMFQq94FR3Fab4jW5uR6uXCHos6ESAEA8mIth0dgWpMhnPx5hsVhY1QzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 7GT+ANnEQc2bnUysy6oDww==
X-CSE-MsgGUID: zw9vNks8QFOJPMS711FY6A==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 09 Dec 2025 18:11:27 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.124])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9C5CA40071EC;
	Tue,  9 Dec 2025 18:11:22 +0900 (JST)
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
Subject: [PATCH 1/3] dt-bindings: thermal: r9a09g047-tsu: Document RZ/V2N TSU
Date: Tue,  9 Dec 2025 09:11:13 +0000
Message-ID: <20251209091115.8541-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209091115.8541-1-ovidiu.panait.rb@renesas.com>
References: <20251209091115.8541-1-ovidiu.panait.rb@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Renesas RZ/V2N SoC includes a Thermal Sensor Unit (TSU) block designed
to measure the junction temperature. The device provides real-time
temperature measurements for thermal management, utilizing two dedicated
channels for temperature sensing.

The Renesas RZ/V2N SoC is using the same TSU IP found on the RZ/G3E SoC,
the only difference being that it has two channels instead of one.

Add new compatible string "renesas,r9a09g056-tsu" for RZ/V2N and use
"renesas,r9a09g047-tsu" as a fallback compatible to indicate hardware
compatibility with the RZ/G3E implementation.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
index a04e5048eadf..d560c58be4d6 100644
--- a/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
+++ b/Documentation/devicetree/bindings/thermal/renesas,r9a09g047-tsu.yaml
@@ -21,7 +21,9 @@ properties:
           - renesas,r9a09g047-tsu # RZ/G3E
           - renesas,r9a09g077-tsu # RZ/T2H
       - items:
-          - const: renesas,r9a09g057-tsu # RZ/V2H
+          - enum:
+              - renesas,r9a09g056-tsu # RZ/V2N
+              - renesas,r9a09g057-tsu # RZ/V2H
           - const: renesas,r9a09g047-tsu # RZ/G3E
       - items:
           - const: renesas,r9a09g087-tsu # RZ/N2H
-- 
2.51.0


