Return-Path: <linux-pm+bounces-35242-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB3FB96E7C
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 19:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E79D4833A2
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 17:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E322737FB;
	Tue, 23 Sep 2025 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beNAfci8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9DB2236E8;
	Tue, 23 Sep 2025 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758647135; cv=none; b=W3++3f7VckxnhybS2vZrMyTCSl8D1+Z5nlOW4fO+BZ21DLs7TVHrgykYu2ywpcc0d4Ldy0N+ymz1PMQIiuMCEbMs8CexHNw19vig/b5PbDXnj5mODGvdT47VOKhQx25rzM36VX1PTZdtJkSCRG8NjwcMkfdRMjnKmwJCDuVnunE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758647135; c=relaxed/simple;
	bh=KXS3nXEKv7z+24LNwa8e8cQqaHUz64wU+g3oWwczZYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T8fBmfQNh0OfBIxJmxXffKy/UuevlAg/R/Q0vX8Iah7FMv4jZcx0LuqFENmd7pMobMEmcQPBJBwNS9VwKBLO7pogrMfpJnpUxhlqGP5j+IOzmodm54E/WzzO6tg6hGkVVNISKRxn9daXmKgTjhqjTva2OHlaUtuLj1gh0ZwOXjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beNAfci8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4425C116D0;
	Tue, 23 Sep 2025 17:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758647134;
	bh=KXS3nXEKv7z+24LNwa8e8cQqaHUz64wU+g3oWwczZYA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=beNAfci8lPWIGTjykwHB6i5JXPFXUYJlXJIwZCl9yx2T1NukDkWyo9k63Lgl8cUTt
	 TZe0UAuRl5uh4smQLkgnatEQfJBmBTL/srQGFxDL6A+o2LnGVT0VnvD/fLAitLk7yJ
	 ccpDZwwBPCdcoQz05b4IE5kQiIA+rHI0h7fw7aNYiGSBChsFY0LQx8B6t5J1cN5mi5
	 I6+ikJbhplWif5ZKx6U3nvkt8pLGVLz3tgFHFsLlJLRs5fbyREcbb4rOoApQKGsGV6
	 8VLqB6/Fl8vsOx6YpEnHpyH2Tfy0P+/3jKPrXak6Uy3XAtVlJmJcTY+8qu8D73DoIN
	 t+b89q+zwQ3yQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9004ACAC5AE;
	Tue, 23 Sep 2025 17:05:34 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Tue, 23 Sep 2025 12:05:28 -0500
Subject: [PATCH v4 2/9] dt-bindings: memory: tegra210: emc: Document OPP
 table and interconnect
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-t210-actmon-v4-2-442d1eb6377c@gmail.com>
References: <20250923-t210-actmon-v4-0-442d1eb6377c@gmail.com>
In-Reply-To: <20250923-t210-actmon-v4-0-442d1eb6377c@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Dmitry Osipenko <digetx@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758647133; l=1483;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=fxGzLjsrwN+Xeyvc5NaaaQzuBIaA9YsbdpmmFPCmyp0=;
 b=hsOiaV/M2VIhcGeveysR5AylGa8wKtzkvFzMsLB0LmWqQ9yElaof7IxTy7UypEi4KSFa6j5QG
 bMn3IHN0avfD2gIfvZ2Bc6q8xOdm4mm20/s7uq0xIGMVQOlNVMsEE03
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

These are needed for dynamic frequency scaling of the EMC controller.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 .../bindings/memory-controllers/nvidia,tegra210-emc.yaml      | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra210-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra210-emc.yaml
index bc8477e7ab193b7880bb681037985f3fccebf02f..4e4fb4acd7f9d376379a19b5f8e0256baaed5697 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra210-emc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra210-emc.yaml
@@ -33,6 +33,9 @@ properties:
     items:
       - description: EMC general interrupt
 
+  "#interconnect-cells":
+    const: 0
+
   memory-region:
     maxItems: 1
     description:
@@ -44,6 +47,11 @@ properties:
     description:
       phandle of the memory controller node
 
+  operating-points-v2:
+    description:
+      Should contain freqs and voltages and opp-supported-hw property, which
+      is a bitfield indicating SoC speedo ID mask.
+
 required:
   - compatible
   - reg
@@ -79,4 +87,7 @@ examples:
         interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
         memory-region = <&emc_table>;
         nvidia,memory-controller = <&mc>;
+        operating-points-v2 = <&dvfs_opp_table>;
+
+        #interconnect-cells = <0>;
     };

-- 
2.51.0



