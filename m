Return-Path: <linux-pm+bounces-34077-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7E5B476F8
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 22:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4A517C60CF
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 20:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A2E29AB0E;
	Sat,  6 Sep 2025 20:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLnRBI/Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EFE28468C;
	Sat,  6 Sep 2025 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757189856; cv=none; b=JDWCPHmY4VJt13Mex8/VzDAZNS29MzfiEn/d8UtfRvCapZggcVGK1ziizFtldzinz6gG1xPePIOgvrxPkUiWK0vZWgDcLJ0yRLumh5avUjDdsIeQMqYZ5RYLuoudkjz1F+BotXepsXTP6Y5bRNihS5/wt9//n03QPqt6ceywwVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757189856; c=relaxed/simple;
	bh=RH2DS5U3ZIYWTXSob6kMDF+ndcbMhkNkeprzmxlsBGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s3nBunnK7unDuCFadQN4YOFIyKljufVSUQjbawPhXKFFpF+lD4zR4djH5XkZjfvEanftPyXGOm0n8i2/+T/C/dE+R12boPfr0QhhNHNw448chBy1RNVtz0ZXnSxfvgghTv9nWxi+1m68R2uu8gBTdHZoTYv8YOHPy90KB4b3i0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLnRBI/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84217C4AF09;
	Sat,  6 Sep 2025 20:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757189855;
	bh=RH2DS5U3ZIYWTXSob6kMDF+ndcbMhkNkeprzmxlsBGA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oLnRBI/QPrTgvxR+FkkxmXmfrDxTWqfZIBsXbUyIBnKmDEazH7m5H1hxlLkYz9Dfv
	 P0KFLNVFvsxCQx7QpLWOzpBp6HXE3ciRwQyDaLvmNkWwCZSonh1k6AHIUmRXgDdZ/P
	 vHMNVyjRgG/Klg9DR1g/7Mdsn4DKoEg89IEiAdobMN0Y9NbBE3gwYZj9i22WrE7FES
	 kV36uZrD9CzJPuHQLvhdzkjoJb7uJwZkk7mrH5aAl5e1xmhd0XdNIP/IcSExBeOki2
	 WDkcTaFM82bPBM0AaokwDy+nnBTIQJ4iuoBENLJTzI1F1t+EPPluGI8i0xl78rcmxK
	 maZmF2V5hWkKA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0FBCA101F;
	Sat,  6 Sep 2025 20:17:35 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Sat, 06 Sep 2025 15:16:52 -0500
Subject: [PATCH v3 2/9] dt-bindings: memory: tegra210: emc: Document OPP
 table and interconnect
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-t210-actmon-v3-2-1403365d571e@gmail.com>
References: <20250906-t210-actmon-v3-0-1403365d571e@gmail.com>
In-Reply-To: <20250906-t210-actmon-v3-0-1403365d571e@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757189854; l=1483;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=Db/RIle5/AqORG8wYHRgMmE0c+WgodTWsv0fav4CnnQ=;
 b=0BZh+ZvuQY/xP39Pqj0cEHRlDNsV+M8A9tUSMuq+PTdVrvd9lw7YYRl/R2rHaze3mvR1RGFcm
 LftN6NFg34HCcVoEXi3Pkljrn8kCvrD3jEhRuqwoa2KURA86mjwo46c
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
2.50.1



