Return-Path: <linux-pm+bounces-35480-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4110BA4A71
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 18:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EDC34C05F6
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 16:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0B52E9EBE;
	Fri, 26 Sep 2025 16:34:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C55A202F7B;
	Fri, 26 Sep 2025 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904474; cv=none; b=qgdk+zKPwnG4JuK0f42xPlZjuabZNdkunEjD+A+iDq6nEDXUqaeZWJRcygUcaH954MJYzGT5gyx/X47HAxBprN+IibZ7158QlWDwfeMp2Shw4VA0T5wIYdY9oE2KJfU/PaLWy/zDDPHv5Jt9yeLuTk/UycynJ4Gfxf7t5PeWKNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904474; c=relaxed/simple;
	bh=tgqsf4Ecr3URSbxtzrxUja8Hphhy7XTQA2zzZlWR61k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PaSg3Z+cyhtFBfggRQb9dH2cMlg5VgWicyz2maZ2Z0MhGNNgUc5m2/B3B7zj+jxNEqtUj0TGt4bFwcANig+Ts6UD4ox1zkzCIomFcyiyK94atgtqXnuaCr7vZ4RKamm2rs6wMB+ejessJG0/+76Ar7kwdbqieplStf0imW/dxdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Received: from srv01.abscue.de (localhost [127.0.0.1])
	by spamfilter.srv.local (Postfix) with ESMTP id 42A1F1C2508;
	Fri, 26 Sep 2025 18:27:07 +0200 (CEST)
X-Spam-Level: 
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cdf8:0:ec51:b786:a581:3dd1])
	by srv01.abscue.de (Postfix) with ESMTPSA id A47B91C2505;
	Fri, 26 Sep 2025 18:27:06 +0200 (CEST)
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Fri, 26 Sep 2025 18:23:24 +0200
Subject: [PATCH 2/5] dt-bindings: mfd: sc2731: Reference
 sprd,sc2731-poweroff
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250926-sc2730-reboot-v1-2-62ebfd3d31bb@abscue.de>
References: <20250926-sc2730-reboot-v1-0-62ebfd3d31bb@abscue.de>
In-Reply-To: <20250926-sc2730-reboot-v1-0-62ebfd3d31bb@abscue.de>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Lee Jones <lee@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
X-Mailer: b4 0.14.2

Reference the new sprd,sc2731-poweroff bindings and add an example.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml b/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
index b023e1ef8d3ccdb1d82d64ed1a60d5a712a1b910..a78d7e26b3a2c77b84da84fc23e52f3a22ab14df 100644
--- a/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
+++ b/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
@@ -52,6 +52,10 @@ properties:
   '#size-cells':
     const: 0
 
+  poweroff:
+    type: object
+    $ref: /schemas/power/reset/sprd,sc2731-poweroff.yaml#
+
   regulators:
     type: object
     $ref: /schemas/regulator/sprd,sc2731-regulator.yaml#
@@ -221,6 +225,10 @@ examples:
           reg = <0xec8>;
         };
 
+        poweroff {
+          compatible = "sprd,sc2731-poweroff";
+        };
+
         regulators {
           compatible = "sprd,sc2731-regulator";
 

-- 
2.50.0


