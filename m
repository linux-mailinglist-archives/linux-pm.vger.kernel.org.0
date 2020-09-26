Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FDA279B7B
	for <lists+linux-pm@lfdr.de>; Sat, 26 Sep 2020 19:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbgIZRgT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Sep 2020 13:36:19 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:36666 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgIZRgT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Sep 2020 13:36:19 -0400
Received: from relay11.mail.gandi.net (unknown [217.70.178.231])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 6B26B3A2296;
        Sat, 26 Sep 2020 17:36:17 +0000 (UTC)
Received: from pc.localdomain (unknown [195.189.32.242])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id C1A97100007;
        Sat, 26 Sep 2020 17:35:54 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/2] dt-bindings: power: ingenic,battery: add new compatibles
Date:   Sat, 26 Sep 2020 19:35:29 +0200
Message-Id: <20200926173529.25238-2-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200926173529.25238-1-contact@artur-rojek.eu>
References: <20200926173529.25238-1-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This binding can support Ingenic JZ4725B and JZ4770 SoCs, as they are
compatible with Ingenic JZ4740 battery.

Introduce the following compatible property combinations:
 compatible = "ingenic,jz4725b-battery", "ingenic,jz4740-battery",
 compatible = "ingenic,jz4770-battery", "ingenic,jz4740-battery"

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes:
    v2: new patch
    
    v3: no change

 .../devicetree/bindings/power/supply/ingenic,battery.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml b/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml
index 658ef92a5b82..683fa79ba2f3 100644
--- a/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml
@@ -12,7 +12,13 @@ maintainers:
 
 properties:
   compatible:
-    const: ingenic,jz4740-battery
+    oneOf:
+      - const: ingenic,jz4740-battery
+      - items:
+        - enum:
+          - ingenic,jz4725b-battery
+          - ingenic,jz4770-battery
+        - const: ingenic,jz4740-battery
 
   io-channels:
     maxItems: 1
-- 
2.28.0

