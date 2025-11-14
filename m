Return-Path: <linux-pm+bounces-38059-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EEBC5E73C
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 18:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 553834FC3D9
	for <lists+linux-pm@lfdr.de>; Fri, 14 Nov 2025 16:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F307F2C2ACE;
	Fri, 14 Nov 2025 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Iq4swSny"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D162328241;
	Fri, 14 Nov 2025 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763139270; cv=pass; b=suPNnIcAaDyxQg7q9N8PA+pnI25WlQhHTzVFx5qoWSeSGhW3FjvUOMxGckL+Lit9opdDfL5NkJshtvA1LbTIIJnULgItr8Fru1i6TpIZXn+YqDONeXHqSORdCQjGXpBSFgLlIDBMKf4VUymKJmQDVfFXjeMbRdLpMpJ3dJSSuDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763139270; c=relaxed/simple;
	bh=4ErT8br9c59q6A5eVvlFusaTZ4w9cvxeskZ/nrHV+LM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=atNA66+vrglt5dr+lH1/LawQgdHNnSOCfjvYNoOHEjyS8PXIXdT5BJQmAlhUzWlQlcZz/J6/H8zEMpSvONpVDdk2OBJrFYecTMpyctZcJKcGKzPJFXV1Ydtf6KHIAZDIwoEZPylP0xT7LWO75LXCqd9cS7uO9qAlqUR42LD5gkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=Iq4swSny; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1763139252; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EcubB+FlthGOcdddqr2fiMH/egGcEyM21Bq0AQC4Hib8caM1/akVFQp3T/rh4TMfwc1QxzZRI2I257tYhFup2N0ZbPCAMKNomfIkeJc9C58kvtn6swbRNGbKaUVql5WkvCQ3jSoE6r7ryaoTjXWkwWOmgTDfD9Yn2ByZNuCFA4w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763139252; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ALLlgNtEbrcNNupb9C7qQMRXoEtImQc3n5pZXYbdkxU=; 
	b=V2k3a38SICQdN93IP/m125EN8/HvDUJoFX+bY6xo/g9ok6msM41+Q7P0VxrtylaPRBST+2L4tgFqLpLvy/ruwdAkb33YgmNPo0mwA7swKGJJ1oH1v3wtiTGsB2aQBbej3UV4dVTP7ndhdNLCEWZgzwudGvekvytT+VTrecxv388=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763139252;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=ALLlgNtEbrcNNupb9C7qQMRXoEtImQc3n5pZXYbdkxU=;
	b=Iq4swSnyL05xUSjkZFTmczvsfzkvtbLoB4Qt09H3UJeAYmgW/ntahbZBZT4T605D
	885QAgXK2mAOS6AJ2dZ12sr31MSiKocog7QeaSFlm1Qw2RapA/B29w2jlCcRsg5QRyZ
	BReL+die6jrkMU1M3FM2AAIR5EzZsPxxrU5C/kBg=
Received: by mx.zohomail.com with SMTPS id 1763139251662608.2963493539693;
	Fri, 14 Nov 2025 08:54:11 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 14 Nov 2025 17:53:56 +0100
Subject: [PATCH 02/13] dt-bindings: soc: mediatek: dvfsrc: Document clock
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-mt8196-dvfsrc-v1-2-b956d4631468@collabora.com>
References: <20251114-mt8196-dvfsrc-v1-0-b956d4631468@collabora.com>
In-Reply-To: <20251114-mt8196-dvfsrc-v1-0-b956d4631468@collabora.com>
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
2.51.2


