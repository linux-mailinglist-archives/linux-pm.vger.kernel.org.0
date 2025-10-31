Return-Path: <linux-pm+bounces-37171-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 207C5C2474E
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 11:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F111891D63
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 10:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ED833F8D3;
	Fri, 31 Oct 2025 10:24:36 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDF0334372
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 10:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761906276; cv=none; b=BcyLla+qPINE/9X+BIXY8wzoLjSL74FlfG02Us2rjKA+LiVpZri8O+VOmUuhWyET763nm6+ZrUa8USi5CweUKit0q+b+5DRUw+GArdnRBWW9FDO939X92Uy4J2HCz1oKBG9MP4LkTUW47mp0k2g9mGqSoBy1YBvCUEj4D7Wuubs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761906276; c=relaxed/simple;
	bh=bB4dBgq8JceBVE4ay8NezjomTCpN/4Np2k+Y1PYEtu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADvx6aMMO2uyIzJbwE6tvRv8nBPpfZeJwzV+ggQS7m2zE8W+WjbY8ixthGTy4QpjCdrPK1PyJsNjvWdT3KQ/XIK+QZsIu7P/OmWDJGeNz22rw0Xj52KiGJmzwy39+OlAaMsMG0CbA/EX+qniNR1kKP7gMQ6AUd97E1S/beuJvBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3DB40226DF;
	Fri, 31 Oct 2025 10:24:32 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8AD3713991;
	Fri, 31 Oct 2025 10:24:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cPk+IF+OBGlqEgAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Fri, 31 Oct 2025 10:24:31 +0000
From: Stanimir Varbanov <svarbanov@suse.de>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-pm@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Lee Jones <lee@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Willow Cunningham <willow.e.cunningham@gmail.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Saenz Julienne <nsaenz@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>
Subject: [PATCH v2 2/4] dt-bindings: soc: bcm: Add bcm2712 compatible
Date: Fri, 31 Oct 2025 12:24:21 +0200
Message-ID: <20251031102423.1150093-3-svarbanov@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251031102423.1150093-1-svarbanov@suse.de>
References: <20251031102423.1150093-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[dt]
X-Rspamd-Queue-Id: 3DB40226DF
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

Add bcm2712-pm compatible and update the bindings to satisfy it's
requirements. The PM hardware block inside bcm2712 lacks the "asb"
and "rpivid_asb" register ranges and also does not have clocks, update
the bindings accordingly.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 .../bindings/soc/bcm/brcm,bcm2835-pm.yaml     | 38 ++++++++++++++++---
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
index e28ef198a801..ce910802ee9d 100644
--- a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
+++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
@@ -13,23 +13,21 @@ description: |
 maintainers:
   - Nicolas Saenz Julienne <nsaenz@kernel.org>
 
-allOf:
-  - $ref: /schemas/watchdog/watchdog.yaml#
-
 properties:
   compatible:
     items:
       - enum:
           - brcm,bcm2835-pm
           - brcm,bcm2711-pm
+          - brcm,bcm2712-pm
       - const: brcm,bcm2835-pm-wdt
 
   reg:
-    minItems: 2
+    minItems: 1
     maxItems: 3
 
   reg-names:
-    minItems: 2
+    minItems: 1
     items:
       - const: pm
       - const: asb
@@ -62,7 +60,35 @@ required:
   - reg
   - "#power-domain-cells"
   - "#reset-cells"
-  - clocks
+
+allOf:
+  - $ref: /schemas/watchdog/watchdog.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - brcm,bcm2835-pm
+              - brcm,bcm2711-pm
+    then:
+      required:
+        - clocks
+
+      properties:
+        reg:
+          minItems: 2
+
+        reg-names:
+          minItems: 2
+
+    else:
+      properties:
+        reg:
+          minItems: 1
+
+        reg-names:
+          minItems: 1
 
 additionalProperties: false
 
-- 
2.47.0


