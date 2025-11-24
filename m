Return-Path: <linux-pm+bounces-38441-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A000C80168
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 12:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AC424E35A1
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 11:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8622F6561;
	Mon, 24 Nov 2025 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="CHSDHiOX"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D872566E9;
	Mon, 24 Nov 2025 11:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763982444; cv=pass; b=PSLoXSPASHt4n4EJjMWcjZ30fU0fIHGCCHkhHd7Y2frnHsXOIOXceNdmEpuAQuzPtgoLEuTQSxl4qFiaknF11uX6a0REzbHu6tE8QsFY3UglWB7mUK8XuIcNfeMyKum2AfkWK1tdTlz6RlQ2KN2R19BEaoJXBQk/Oky1qb/J2QM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763982444; c=relaxed/simple;
	bh=ce9o5irmwpfyD6PvU9+tPvHBWgCNiUXyQdvKFSFXd9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CL3Gyl/6e6nDtBvma1snWM8xLtpgJcbJpnBbhS0Ao3AzgLT2fbCzjohKlLDxO3mEWS5FapyKJ+mrhpTjzIwqzcLiNRuxD9KifJtH5gb93RONfYT1aFTdszgjmVr2KMXIOLK9QBL3Ujz9u9S3vMA6/1MRAhbHqd11305iD5wCr98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=CHSDHiOX; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1763982425; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GIDjin3ux68yiT6EZRYQQur4rqwNVp6nrqgpkzK+fkBKr+OUxBHyE8vwCxoNL5M4VPgn+xe9PJYpWhb0rZryyIA2SE/3K3d/xbZn82OlQzk/s6EfSbDgqnKSGGA4NvG0S3yLf1WW3Yt0NpNDvuINH46Z8roO0/vHb5iDA1sskbY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763982425; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sDH7HsjdBxRxUiiInPpbiefmMzWljb8Ji5v3kIQhv8U=; 
	b=Lp7Ky71BPDjvNXkeaDUSsxH1y5OfKIFjAUdxYuiRtRcovvfHJuQh4orsexa1Qul/Jp96lljD44uQz8PWoLS2l2Z+f90X2tVpPhKWx2bVLik3K7Zf+h/HAYUDCYkXIFxkqaey2zrjrS5+vGk5c2T8v/UTGF+71HOq/RaH1nhHhiI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763982424;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=sDH7HsjdBxRxUiiInPpbiefmMzWljb8Ji5v3kIQhv8U=;
	b=CHSDHiOXDNaqdYcV5n1kT87LkxJ54yOXkEc1brL6ngioDl7xEUX2A+jGr0FWeLBi
	FvLhxBg+SqTTsvP9FA0YMrUwJah84b00ZtvV5KiDAHtsuyEtonPEq3GPpiqOrOKNrYh
	Ar937mq5VNlhh1mqE7HRuzjzEpmfsqIrpDuzvf8U=
Received: by mx.zohomail.com with SMTPS id 1763982424035518.2881808242608;
	Mon, 24 Nov 2025 03:07:04 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 24 Nov 2025 12:06:51 +0100
Subject: [PATCH v2 02/13] dt-bindings: soc: mediatek: dvfsrc: Document
 clock
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-mt8196-dvfsrc-v2-2-d9c1334db9f3@collabora.com>
References: <20251124-mt8196-dvfsrc-v2-0-d9c1334db9f3@collabora.com>
In-Reply-To: <20251124-mt8196-dvfsrc-v2-0-d9c1334db9f3@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Henry Chen <henryc.chen@mediatek.com>, Georgi Djakov <djakov@kernel.org>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.3

The DVFSRC hardware has a clock on all platforms.

Instead or proliferating the culture of omitting clock descriptions in
the clock controller drivers or marking them critical instead of
declaring these types of relationships, add this one to the binding.

Any device that wishes to use this binding should figure out their
incomplete or incorrect clock situation first before piling more
features on top.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 .../devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml    | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml
index 5673d242afcb..d5c42f992a21 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mt8183-dvfsrc.yaml
@@ -35,6 +35,10 @@ properties:
     maxItems: 1
     description: DVFSRC common register address and length.
 
+  clocks:
+    items:
+      - description: Clock that drives the DVFSRC MCU
+
   regulators:
     type: object
     $ref: /schemas/regulator/mediatek,mt6873-dvfsrc-regulator.yaml#
@@ -51,6 +55,7 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/clock/mt8195-clk.h>
     soc {
         #address-cells = <2>;
         #size-cells = <2>;
@@ -58,6 +63,7 @@ examples:
         system-controller@10012000 {
             compatible = "mediatek,mt8195-dvfsrc";
             reg = <0 0x10012000 0 0x1000>;
+            clocks = <&topckgen CLK_TOP_DVFSRC>;
 
             regulators {
                 compatible = "mediatek,mt8195-dvfsrc-regulator";

-- 
2.52.0


