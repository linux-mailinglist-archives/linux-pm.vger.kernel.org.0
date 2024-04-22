Return-Path: <linux-pm+bounces-6786-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8732F8ACB63
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 12:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 260C6B22F00
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 10:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E94F14E2F2;
	Mon, 22 Apr 2024 10:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="SQ4hJWQy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6745914A084
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 10:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713783252; cv=none; b=ikwjIzqMWoGe3/mYlhIILXrJB9WNVR7xo/6LIyRLomNd2yGJNLoKNdKdU650XqHeNK2Eg382rPN5NrKbkIcfyf4gNg5izDYMZNtGRl1TsQgV+KrFPBhgAXZhgy8Lh50yCLD/saRQV0WttwI6Bs2CtceAg5azXjtC9BdkFI19Nfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713783252; c=relaxed/simple;
	bh=kzfvIn5qFtOm6vevv9sfzeyre/RzrlRI0FWCZfrI0GU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q5+rDh+gAtAZDOqOfdMOal8TWxPY2ntclDwbdhW+UDO5s8ClKeO2ApVMeKMPLqR8h3RopXW70S2K1I0O1DIEvKoFopObapLOsaL/kmb9gybDkg/DOOyJefpSD5Gs+9Rr/wIfpP5jf+0JyC5K4SZY+omrmrIu8xLDIXYNN+f3O6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=SQ4hJWQy; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41a7820620dso3181165e9.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 03:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713783249; x=1714388049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAwRmO5huM+GW70T/FweuVU9CTXqYucZc7ooxGC0kuI=;
        b=SQ4hJWQyAtvmdGSz4SPh+XAXccAatxOvppBULVv4ubGy27283MCeWt9IdbxeoiUbcN
         yOtrlStrZDMNtn/TUIJ1m7KDpA5O//ZCijp64Wn8t5IhWfxp6RVPbNOzrmkMlt/TvZWR
         J//2B9E+LehGJFt5oDERe/BxtnOm78LkCdoNWs+PAj7R5d4isr5SSyShfv0EHt4YC7kW
         SuEZVThW2dwDSclnaLqoNMQesjbCiuMrSOGH6CQsjheITB3pCEMNJqRtaplFHdsjbINt
         1Rs6+tgysxGGbmPUMSwK1O98nUtsTl631zuAzgcO2GZ05tR9dfKpqcy+/7a0XLdb4LRI
         xbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713783249; x=1714388049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAwRmO5huM+GW70T/FweuVU9CTXqYucZc7ooxGC0kuI=;
        b=d0sbRqLB//PwBA4Fu3/92XCDg9nXML/cpjf4ZuDKLGK8kuJvyjNuEnQTo6ynxteuU4
         6shsj3vmKDtCVx5W0ZGPf7HI6vy8Hp6cV3fGtex4KfDKmA7mfv7WztPCmb6KEyVUcG1G
         ZWFB6N964+jcbCNr8zKvhweqXdem2yd8BKJRYbNmaKGTq5I5+1EBOuOlHx7nkgrlMzDU
         LkyeETCrull2uivps65sraYCKriOnsJsz/eAXrMfiagGplpKRIYtI64uZXVENIegWGf2
         Gy6ZTiVPpOIVQ2Rp8jdVyFfytWwBnyovdycWxZZC/9rKDVhoTcQT3U7zcJ2nLfUiidka
         PmMA==
X-Forwarded-Encrypted: i=1; AJvYcCVGujrO+mGuu3TUELpTd0l9VxKniFvmBtIPOtdaP7cfw/hcdRL7EctDahzOZd/qlDn+hxsYnHRPricDTJhLl7hbxnAFCtubjlQ=
X-Gm-Message-State: AOJu0YwoMIGe/KMk8jAi55KjWiKVa5XEM+DYWYF5Fiod17CE02t2buOz
	195r1l3WrLUMPS8xgni3I5UOF480o79qkxJ1cDeqryBuKz3BWCon4GmY2KlNhqg=
X-Google-Smtp-Source: AGHT+IEgDwCgT5pzkeoswqG4nrQ8rtrCIWqKFBOLuvMt3yy55K/3kxVfAmsfO2HIlU7iiEbI5HsUnA==
X-Received: by 2002:a05:600c:1c9e:b0:418:a5fc:5a5b with SMTP id k30-20020a05600c1c9e00b00418a5fc5a5bmr6945379wms.36.1713783248921;
        Mon, 22 Apr 2024 03:54:08 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.53])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b0041a3f700ccesm4321037wmn.40.2024.04.22.03.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 03:54:08 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	magnus.damm@gmail.com,
	ulf.hansson@linaro.org
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 5/8] dt-bindings: clock: renesas,rzg2l-cpg: Update #power-domain-cells = <1> for RZ/G3S
Date: Mon, 22 Apr 2024 13:53:52 +0300
Message-Id: <20240422105355.1622177-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240422105355.1622177-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240422105355.1622177-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The driver will be modified (in the next commits) to be able to specify
individual power domain ID for each IP. The driver will still
support #power-domain-cells = <0>, thus, previous users are not
affected.

The #power-domain-cells = <1> has been instantiated only for RZ/G3S at
the moment as individual platform clock drivers need to be adapted for
this to be supported on the rest of the SoCs.

Also, the description for #power-domain-cells was updated with the links
to per-SoC power domain IDs.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- none

Changes in v3:
- collected tags

Changes in v2:
- updated patch title and description
- kept both 0 and 1 for #power-domain-cells as not all the drivers,
  device trees are adpated with this series
- added a reference to dt-bindings/clock/r9a0*-cpg.h for power domain
  specifiers
- dropped the changes from examples section

 .../bindings/clock/renesas,rzg2l-cpg.yaml      | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml b/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
index 80a8c7114c31..4e3b0c45124a 100644
--- a/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
+++ b/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
@@ -57,7 +57,8 @@ properties:
       can be power-managed through Module Standby should refer to the CPG device
       node in their "power-domains" property, as documented by the generic PM
       Domain bindings in Documentation/devicetree/bindings/power/power-domain.yaml.
-    const: 0
+      The power domain specifiers defined in <dt-bindings/clock/r9a0*-cpg.h> could
+      be used to reference individual CPG power domains.
 
   '#reset-cells':
     description:
@@ -76,6 +77,21 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a08g045-cpg
+    then:
+      properties:
+        '#power-domain-cells':
+          const: 1
+    else:
+      properties:
+        '#power-domain-cells':
+          const: 0
+
 examples:
   - |
     cpg: clock-controller@11010000 {
-- 
2.39.2


