Return-Path: <linux-pm+bounces-24692-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A939A7787F
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 12:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489CD163435
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 10:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D201EF39A;
	Tue,  1 Apr 2025 10:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kAQ9TJw9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46831F03EC
	for <linux-pm@vger.kernel.org>; Tue,  1 Apr 2025 10:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743502273; cv=none; b=PB4rQaN9Ddaz564mNyb0aFIcS46Xz3OCilhrxVJWzm9kdTDKhLfFXcoTqEc1RCWQ7Y7MZdEmQbDgcDQYoVjDTJPp1j/PuVHfwAj97TkPod8QEBAdrC4x+oxLRe8bxqOMnZbdbehVzNchWVRvxEPIblFgm+51qNiW/0/sb7lQnaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743502273; c=relaxed/simple;
	bh=ri0c6XAKIbAL5r1pMx1YsjfpBuk6BBaZV7LqaDJixho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rHPJnUVqA0SVdoy+ncScWzkBB9e6Iz3+1H+TPG5VhwYT8qyQUm7RgiYv5gIaSY6UEYyyM47uqHn68w+IW5MmhgPGqw4UKM1fp23CBCM0EfwrzEGf0XcWWLewp/XCfRF6sYZyLrdCcFDWaL0AgfDQ+2bf2xQi8E/5RWkgDBcxKQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kAQ9TJw9; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so804659766b.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Apr 2025 03:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743502270; x=1744107070; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0fLcWG3xRCCoczcLQcRJk5lZ+cdqHvZLEk7m94iuVA=;
        b=kAQ9TJw9GuspSLgSC2f2kFrc8YWz0y5QB39dvHfXL0rItj4MT9bhCXIoc5qUBjzjnY
         z7CWPKC9TX3sRuJZVJ6+cRTsN/rJUW0dJ4zuaOo/odFW9qnhOP40aUG1c4bDc6556KYz
         2tU4m+dENAgd4Bd+bvu09Oqm9nQ2fqa5kgMtwwUmuu9IYCK3TRefc/vy9Ou/KmCaAuvZ
         DhAFSqzE+Il4/WLCvtYT/NV5FFHft5nfbVXfdB7snNgSyObEe30iKWIbWyJI5P7jKAWu
         BjCFirZ59QKtCE3PansEfCPvqxccFTCBt2lG7eYruN4/MHRXWKok+JaZHM818haualK8
         MFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743502270; x=1744107070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0fLcWG3xRCCoczcLQcRJk5lZ+cdqHvZLEk7m94iuVA=;
        b=gZkUXYoHH2fFQf1Dpz09LWmMMdA3LMpvMQknW+RU/8AHGuEimkMR6jOE4pQOJOIRXV
         KidUGqv2H6sjJQcn1N6ALKhvMftBh7SxGk9Lu20Y0/V1VYFT6kPa6cR/VBzRQRuBwsgV
         tQegy9LVvha3+TQIiik0WBlWNhxk4DRURzzzZMmb9cx6SSEMR5PXdXGU/NEV+6J7i7dR
         upEIyvVHan7mIrt7IOufGJgbJ/Uy8S+qbmMHFcWHDzGnM46pkkP7h4oUz9Wf3uQeN7wf
         Elg/6vQAAVIFRBGOBFs5Dsyozn8Eo7SCUinQODrB9ihiYGdy3Ixgb866R6BmtfTF89dp
         mMqg==
X-Forwarded-Encrypted: i=1; AJvYcCXUSYt6gIikKBudpPfAhMjeJs+PK+h8HAhC9u6JExqZU3dMShOgFz2v1t33gjezgA8VpagDKwliHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQJt9fs1nI1GYfmdbcM0rH5JRfflCV9U+9rLURlfAdWNEYmsEA
	63DUTL41psE9ajgdrh6UeAggFjBU/xPB+1Nv8bx+dwtrWTrPvVTB87IrFbnoU9o=
X-Gm-Gg: ASbGnct9Ed0dhoYxOWr5gcx14pMJAIFgG2Kyogp4DZDRUWbDYeM2vIsN8mxMm6e/JUx
	Dmjk5t2OxC11IgptEsGylCma8P2f6uNvCWgNl+ihkD8+KKB5iDJNVkPn+aeI5DE+PpOQ9OA6/Vv
	OH6LCycx/mvSLVGGEsn9Olk7/XeaMJfBSAGw/TcU1luAKSTK+61LIp7HFq9WMQ2Z9UWHUUjTzII
	H7DfhYsuikAojEOELQDOORm+95qZGVa7mcPCsXEc9uIWiEBcDyyIiLK6IdzwjFlozVbKT84w9BE
	5UkxBeIKv3dbQTG25sTYcPWVb6qMPJJC2IbLVbmk56VKcuhxtkthKBzUkaWLP2wHoCjm+mflMn6
	QgKGZzrZZF+gakxrozCKq9hqBde1T
X-Google-Smtp-Source: AGHT+IELZUBLM5q9YYlt+lD2I0tWCOgW2YPV6e8Gm9HIS3wyPkKW8jVGcaajvDyvq1766HKI/b1QYg==
X-Received: by 2002:a17:907:7eaa:b0:ac3:45c6:a1ec with SMTP id a640c23a62f3a-ac738a841a3mr1407550166b.25.1743502269931;
        Tue, 01 Apr 2025 03:11:09 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71967ffcdsm757406966b.140.2025.04.01.03.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 03:11:09 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 01 Apr 2025 11:11:02 +0100
Subject: [PATCH v5 1/2] dt-bindings: reset: syscon-reboot: add
 google,gs101-reboot
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250401-syscon-reboot-reset-mode-v5-1-5b9357442363@linaro.org>
References: <20250401-syscon-reboot-reset-mode-v5-0-5b9357442363@linaro.org>
In-Reply-To: <20250401-syscon-reboot-reset-mode-v5-0-5b9357442363@linaro.org>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

GS101 supports a couple different reset types via certain registers in
the SYSCON register map.

Add a compatible for it. When in effect, all register values and offsets
are implied, hence they shall not be specified in that case.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 .../bindings/power/reset/syscon-reboot.yaml        | 42 +++++++++++++++-------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
index 19d3093e6cd2f7e39d94c56636dc202a4427ffc3..ccd5558700943ef56f5e1c866400bcc21c0115f0 100644
--- a/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
+++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
@@ -21,7 +21,9 @@ description: |+
 
 properties:
   compatible:
-    const: syscon-reboot
+    enum:
+      - syscon-reboot
+      - google,gs101-reboot
 
   mask:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -49,12 +51,6 @@ properties:
   priority:
     default: 192
 
-oneOf:
-  - required:
-      - offset
-  - required:
-      - reg
-
 required:
   - compatible
 
@@ -63,12 +59,29 @@ additionalProperties: false
 allOf:
   - $ref: restart-handler.yaml#
   - if:
-      not:
-        required:
-          - mask
+      properties:
+        compatible:
+          contains:
+            const: google,gs101-reboot
     then:
-      required:
-        - value
+      properties:
+        mask: false
+        offset: false
+        reg: false
+        value: false
+
+    else:
+      if:
+        not:
+          required:
+            - mask
+      then:
+        required:
+          - value
+
+      oneOf:
+        - required: [offset]
+        - required: [reg]
 
 examples:
   - |
@@ -78,3 +91,8 @@ examples:
         offset = <0x0>;
         mask = <0x1>;
     };
+
+  - |
+    reboot {
+        compatible = "google,gs101-reboot";
+    };

-- 
2.49.0.472.ge94155a9ec-goog


