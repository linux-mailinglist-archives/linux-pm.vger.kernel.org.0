Return-Path: <linux-pm+bounces-12734-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE3F95BA36
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 17:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC384281330
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 15:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69611CDFDF;
	Thu, 22 Aug 2024 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="NZlEQ91a"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F311CDFBE
	for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724340511; cv=none; b=oiTL4qQIBIdv1FvhycwZhycmC7kAWp0reKejsfPsZmPNkxtAVHkhP+TaHzqUnREjaLy9GlOpHdZqQZLGW7kGH9GAvjrcfW9CxdImoU0rCrLP+/57HuPDeP1rzRhSeB+trGVSnQmfHz9x6FUYHVRvVz6KeMx8ZGv08vBig7oqLbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724340511; c=relaxed/simple;
	bh=zmBwUlxzBuNbxMboR4M8TMw3ngUJf31gnqIxK23PZOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pzqsShgP3cMk7qayXwosIsSaV9Bc7D4+P2Ft2eDSnh8rs47ZMm/3f0TaLUIXrD/Cgowqjt6lQEI2sQQ0k5hQhViVRCU4JfpTyhR7JwgDLi6XPVDBxma4XaL1TiuKoiaV1mS3MfWTzFVvnZU1W6kaqOatWOuHtThFv/lXoMKtQ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=NZlEQ91a; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so6745185e9.2
        for <linux-pm@vger.kernel.org>; Thu, 22 Aug 2024 08:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724340508; x=1724945308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYtknRff4T33No5Y++IYUbUSWOUqzPRe+qwJzBDRLKk=;
        b=NZlEQ91aOEwlAJTyDEtAMA7OXAnkdiFOqWu4VHghX27x4ncQ88c++bZNRDCXPHts3d
         7VYQW10RNde4dZ5ZVdU3yZnnNjAMfgOwm0HAX5pi7asTUtcZGrSBC6x9vCThqbPp2XFA
         DC+UPs+AYVx8GW5LGCM5LZU0a+EqrLHSNJXI7+yo0AkPLAtkHVa9o8NbY7JQxSfhhRsd
         A1ajfNSZik7bTh2bC65il9/3/gD+STkftzLb0eZBFiHA6ZccDSWPptAygz5i6KF+COJt
         5PlDDxvczjkKy4KtrSjxLwpj2RNV2HHeRDRcJrIh7vAGZkkYJGxwL7aNgEFf8QWto89Z
         59Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724340508; x=1724945308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYtknRff4T33No5Y++IYUbUSWOUqzPRe+qwJzBDRLKk=;
        b=ZJ3ulCeeJRgJTO4MXfQNqpt9FzTCovEtvjdPCYYieBIkNS1tuNCkRCqlbWybX9TAxB
         7bNP5hT9t2UlosIONExRE7GDHjwTObL/i/v/NKiZvqElVXkQWHkv8qP8UKYM/okyYkit
         IyU+cX/BSunj9VKmip0jQ+BXP7iilLS0qXoAYelPJYol5u10dsZm2c7aY+MVoHvPLzmV
         k3CEDBIlmRd6guc5T+614eS9V3JwzmPs7JexdncSyTQrgNxWsMsHzMvHz3lSqrj0T//y
         kOQXTuNYlvT/HgcJJMbszT5qqpxlMSHuSQWe4UaelUa0JLmPsBz7LUH7jAyLFh2/AZkO
         vmGA==
X-Forwarded-Encrypted: i=1; AJvYcCXK2bCHRQKRa10hcLJRH8aq9ulM2o9bdNfx2ydU0MvSx7Pw0WM7w75APWv0fdFn8QgNB1dLfjSmmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ+YRO+rlnHdUZBGN/OrQkAPRjklOzJ60mcmEvoKRKKfkuRFm/
	agr7tuez29DC/sb9oBuI1A53bB16zHj4dhJk8Z8WMQT2xqfrNlSqUM2GdM+ENfU=
X-Google-Smtp-Source: AGHT+IFJJW8cbQ+Z6hZ+0qBX8ovTCGv9ZpRZ4mNlCVMcK82sY8yzcRU23B/c+aKa1+lhTAIB2iIHXA==
X-Received: by 2002:a5d:4289:0:b0:360:791c:aff2 with SMTP id ffacd0b85a97d-37308d725c1mr1462761f8f.47.1724340508459;
        Thu, 22 Aug 2024 08:28:28 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f484dc5sm134189166b.171.2024.08.22.08.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 08:28:27 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	gregkh@linuxfoundation.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	yoshihiro.shimoda.uh@renesas.com,
	biju.das.jz@bp.renesas.com,
	ulf.hansson@linaro.org
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 06/16] dt-bindings: reset: renesas,rzg2l-usbphy-ctrl: Document RZ/G3S SoC
Date: Thu, 22 Aug 2024 18:27:51 +0300
Message-Id: <20240822152801.602318-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Document the Renesas RZ/G3S USB PHY Control IP. This is similar with the
one found on the RZ/G2L SoC the exception being that the SYSC USB specific
signal need to be configured before accessing the USB area. This is
done though a reset signal.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../reset/renesas,rzg2l-usbphy-ctrl.yaml      | 35 +++++++++++++++----
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml b/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml
index b0b20af15313..5f053981474e 100644
--- a/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml
+++ b/Documentation/devicetree/bindings/reset/renesas,rzg2l-usbphy-ctrl.yaml
@@ -15,12 +15,15 @@ description:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - renesas,r9a07g043-usbphy-ctrl # RZ/G2UL and RZ/Five
-          - renesas,r9a07g044-usbphy-ctrl # RZ/G2{L,LC}
-          - renesas,r9a07g054-usbphy-ctrl # RZ/V2L
-      - const: renesas,rzg2l-usbphy-ctrl
+    oneOf:
+      - const: renesas,r9a08g045-usbphy-ctrl # RZ/G3S
+
+      - items:
+          - enum:
+              - renesas,r9a07g043-usbphy-ctrl # RZ/G2UL and RZ/Five
+              - renesas,r9a07g044-usbphy-ctrl # RZ/G2{L,LC}
+              - renesas,r9a07g054-usbphy-ctrl # RZ/V2L
+          - const: renesas,rzg2l-usbphy-ctrl
 
   reg:
     maxItems: 1
@@ -29,7 +32,8 @@ properties:
     maxItems: 1
 
   resets:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   power-domains:
     maxItems: 1
@@ -59,6 +63,23 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a08g045-usbphy-ctrl
+    then:
+      properties:
+        resets:
+          items:
+            - description: USB PHY Control module reset
+            - description: USB area reset
+    else:
+      properties:
+        resets:
+          maxItems: 1
+
 examples:
   - |
     #include <dt-bindings/clock/r9a07g044-cpg.h>
-- 
2.39.2


