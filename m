Return-Path: <linux-pm+bounces-1710-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0E3821548
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jan 2024 21:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 955AA1C20A4F
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jan 2024 20:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D61DF4F;
	Mon,  1 Jan 2024 20:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1ASRYrh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82852DF44;
	Mon,  1 Jan 2024 20:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-552d39ac3ccso16973820a12.0;
        Mon, 01 Jan 2024 12:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704142331; x=1704747131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aE1J9ZdSIsaif3IEOtDgCaGNtPVNpbYHzuk9B6CwMoA=;
        b=Y1ASRYrhNzzLwMeK55rh4pvRPpbGt/bMzypwgHSvZGZcXTkqkahIu2kV+/wE87ck/N
         1J/zhYnoMyyUf22JBs5r8q8ODHDSBA24yY8HsIU+i6rY8hI32TAxxso5B2+/ry8U4bkz
         Suo/kW9NGtTReoi9CHXvtrMRlMBFoVtCWJLqKLhN8lU12oE5Ae0knKe3dQSApiXQ/DOF
         aM58llp83hc2fwoZNxEKfsGg6TjE0qa9d6ztQFVbOR/jwk32yxLnYUP+Dfk33pSLpCQe
         ie8IAZ9s029htKL9kL91iq/hQq8eAr3nHGfX070U8GIaNy/Uf6bjsjEtpxR9U4mv4qzR
         +ibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704142331; x=1704747131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aE1J9ZdSIsaif3IEOtDgCaGNtPVNpbYHzuk9B6CwMoA=;
        b=v5tgNg8JaSwaH1yEDXPAGPASoLk9LOGh+pD7ZcnPl0Swi883uHMXwJ/Gl9DfqcMCXC
         LrzT8AsYqcerAjjdhnK3uk1podDOXPzvz72omtVdxXLBd6FOfgjeAZp4SkLljbOMOyI2
         JPq0g+6HNhpEa5G/S2cYaLfeG/FiZaUC0XI4aKMRDfQ2pNnzzrHShMl56vH2UhAL6VJA
         IB+qdULKfIrkqrfWiHmhALHcxVuMX/+nSCMPw2IZH95Y60dmBcsD2duPz/GoK/YsShxX
         iL4/Ki53wSyosKC1hYtW0Z6pYS82dbVje8xGCoFbx921qDktbEyJ7mILSTIVdSJ5YxAe
         20fw==
X-Gm-Message-State: AOJu0YzGtBnGV+tz/MALYaKXjIQf/o5FwIxCx7CrKlf4FhImhNKczj76
	74aXH+aBZ6FPUztWg0XjoKs=
X-Google-Smtp-Source: AGHT+IF8AMKWQ1GDq0sqtcPmdt0bqmeWcWfh4R3E1F8LuUh6BJQgqEEASeIR5ke3EP3K+0QxNyC3dw==
X-Received: by 2002:a17:906:c7c6:b0:a1c:a542:2fcb with SMTP id dc6-20020a170906c7c600b00a1ca5422fcbmr12456721ejb.31.1704142330488;
        Mon, 01 Jan 2024 12:52:10 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id ft33-20020a170907802100b00a26a5632d8fsm11029227ejc.13.2024.01.01.12.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 12:52:10 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Daniel Golle <daniel@makrotopia.org>,
	Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH] dt-bindings: thermal: mediatek,thermal: document AUXADC 32k clock
Date: Mon,  1 Jan 2024 21:51:34 +0100
Message-Id: <20240101205134.9886-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

SoCs MT7981 and MT7986 include a newer thermal block (V3) that requires
enabling one more clock called AUXADC 32k. Require it in binding.

Cc: Daniel Golle <daniel@makrotopia.org>
Cc: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../bindings/thermal/mediatek,thermal.yaml    | 24 ++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek,thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,thermal.yaml
index d96a2e32bd8f..a76be9c47fb5 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek,thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/mediatek,thermal.yaml
@@ -15,9 +15,6 @@ description:
   controls a mux in the apmixedsys register space via AHB bus accesses, so a
   phandle to the APMIXEDSYS is also needed.
 
-allOf:
-  - $ref: thermal-sensor.yaml#
-
 properties:
   compatible:
     enum:
@@ -38,14 +35,18 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 2
     items:
       - description: Main clock needed for register access
       - description: The AUXADC clock
+      - description: AUXADC 32k clock
 
   clock-names:
+    minItems: 2
     items:
       - const: therm
       - const: auxadc
+      - const: adc_32k
 
   mediatek,auxadc:
     $ref: /schemas/types.yaml#/definitions/phandle
@@ -76,6 +77,23 @@ required:
   - mediatek,auxadc
   - mediatek,apmixedsys
 
+allOf:
+  - $ref: thermal-sensor.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt7981-thermal
+              - mediatek,mt7986-thermal
+    then:
+      properties:
+        clocks:
+          minItems: 3
+
+        clock-names:
+          minItems: 3
+
 unevaluatedProperties: false
 
 examples:
-- 
2.35.3


