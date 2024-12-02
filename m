Return-Path: <linux-pm+bounces-18349-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E479E02DC
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 14:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F12285B0F
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 13:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECACD1FECA1;
	Mon,  2 Dec 2024 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHZk/A6i"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA7AA95C;
	Mon,  2 Dec 2024 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733144901; cv=none; b=hyCIQmiuNPqwPD0Ceewzxwfj3YABLsvFmNl+Kttg9Sh6ZeAD68dV5/glRSSm1Sb+vT5t93VLP5C2UwGSL1644ddd1Fg/TceZmdu8SBQO3YjIbQcXwCF5IimQacTJY2W0VGAb8EQ/zvsdGazc2DuhupC4J2ZWGzdArKOjRfw2We0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733144901; c=relaxed/simple;
	bh=jEINaNWGAcKMa2bATL8ktCQNfAWj8oZ7TAUZr3ESYOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T7RHcxYUXuo941odrcC8/HCE3MrGAz2SVhOAa5w8LZR7QiZV/p72oaKN8QTdRF9NXWGYhYK7M7wNfjGTa84iT6UX4e1XNjIgBQHS0+JBlC1V9a03NQ1s1PLB9FvEUzI1UQQJCNtin4RgJP31xC2NUlbspamhcttF3kAIbTvmbvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHZk/A6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53B2AC4CEDE;
	Mon,  2 Dec 2024 13:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733144901;
	bh=jEINaNWGAcKMa2bATL8ktCQNfAWj8oZ7TAUZr3ESYOI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JHZk/A6i6SsD16eTksSkewswkSr6FifkMku5R3Wk5YVIwXPHjeCf9xqtwvOM5wb99
	 dhwqmSFWznNwGR1fvGGGS2Rk8GOJCpQ6r2IATIJRzsnl7Sf95x1p37xuyTTXxk/xeH
	 C+/7ULdyRLCBcyrtSjgpqE3BW7Eetk+UBCQFN/ne6aRagI5xjcPOrusXK/XJhL3vRj
	 XUsV1NVRgkJQJcHPQ46rJEw0yM6z8NOZ87xFHl0lp2zCzl+h6Eb4G8jv2az3dox2oa
	 Rlo46AmrKTM6FauX8Hju/PPOMlWeROSQlVLUipQuXLWuFEsT9LL92mgNRBJrAOHj1R
	 uNrdYJit1o+eg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D9BD7831D;
	Mon,  2 Dec 2024 13:08:21 +0000 (UTC)
From: Thomas Antoine via B4 Relay <devnull+t.antoine.uclouvain.be@kernel.org>
Date: Mon, 02 Dec 2024 14:07:16 +0100
Subject: [PATCH 2/4] dt-bindings: power: supply: add max77759-fg flavor and
 don't require nvme address
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-b4-gs101_max77759_fg-v1-2-98d2fa7bfe30@uclouvain.be>
References: <20241202-b4-gs101_max77759_fg-v1-0-98d2fa7bfe30@uclouvain.be>
In-Reply-To: <20241202-b4-gs101_max77759_fg-v1-0-98d2fa7bfe30@uclouvain.be>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, Thomas Antoine <t.antoine@uclouvain.be>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733144859; l=1565;
 i=t.antoine@uclouvain.be; s=20241202; h=from:subject:message-id;
 bh=RTgptgGDXIpNksG2RFyyX00KmvPw//2EuQKYPNbTnPY=;
 b=lCO1iSdVtfEpPAC77nh9P49nbswY9iqm8xcrLTlOoQ/khMbOZuUNCBRNJ2ElFwDs5zIuHMEQL
 lx6XWdp54GpALvXJ3t8KOkKVW/Map6F2UCEye4rZu31wIix5Hm/sjwH
X-Developer-Key: i=t.antoine@uclouvain.be; a=ed25519;
 pk=sw7UYl31W1LTpgWRiX4xIF5x6ok7YWZ6XZnHqy/d3dY=
X-Endpoint-Received: by B4 Relay for t.antoine@uclouvain.be/20241202 with
 auth_id=289
X-Original-From: Thomas Antoine <t.antoine@uclouvain.be>
Reply-To: t.antoine@uclouvain.be

From: Thomas Antoine <t.antoine@uclouvain.be>

As the Maxim max77759 fuel gauge has no non-volatile memory slave address,
make it non-obligatory. Except for this, the max77759 seems to behave the
same as the max1720x.

Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
---
 .../devicetree/bindings/power/supply/maxim,max17201.yaml   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17201.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17201.yaml
index fe3dd9bd5585618e45220c51023391a5b21acfd2..417fc2c4a1c1961654bc54ec1ac24602012f3335 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max17201.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17201.yaml
@@ -16,6 +16,7 @@ properties:
   compatible:
     oneOf:
       - const: maxim,max17201
+      - const: maxim,max77759-fg
       - items:
           - enum:
               - maxim,max17205
@@ -25,11 +26,13 @@ properties:
     items:
       - description: ModelGauge m5 registers
       - description: Nonvolatile registers
+    minItems: 1
 
   reg-names:
     items:
       - const: m5
       - const: nvmem
+    minItems: 1
 
   interrupts:
     maxItems: 1
@@ -56,3 +59,14 @@ examples:
         interrupts = <31 IRQ_TYPE_LEVEL_LOW>;
       };
     };
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      fuel-gauge@36 {
+        compatible = "maxim,max77759-fg";
+        reg = <0x36>;
+        reg-names = "m5";
+      };
+    };

-- 
2.47.1



