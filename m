Return-Path: <linux-pm+bounces-40442-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09053D028D6
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 13:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC17C3042813
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 12:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9F3389466;
	Thu,  8 Jan 2026 10:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaDugw29"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0641D34FF4D
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767866518; cv=none; b=Frh2Ig/Jq6fixX+e93LhUcIb4hQi9yj00zhbs+MlpMlc/cGfvKsoLaq/vi2nkiOej+y9u4J9f20gz/qMyJ4vefnBEo61rLFiudeqTEI1mzjGZUGSSJFOUGCkYvpfFz2SRSUCHwwRPvNV7ostSQHWbqDA9vsWCjFWRZBZRxdRq58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767866518; c=relaxed/simple;
	bh=+em6k554hiEdgZ3gCIS3vNjm0IbnUUOfSriX33xjyhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QNHWxEX/sl4bTT3vpHhtH62nLIvKu0yev3N63boULOMyW3aeWNiUvPjbuwnITuLtaaSOyqD0VpqPNC74lUFnoV+X7ALoCsJ4brw+ONiwMOnhw+EbHpxr3ilF/4/a4yqaGGoT7P2LSuMY1GhaHaH0kCne9eFLlgFabgLmLRpQXck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaDugw29; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-563497c549cso1126293e0c.3
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 02:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767866514; x=1768471314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9Cv7mdPPcZ8e/4RiioRb+FP1zONlTuWhguDLBncdBY=;
        b=aaDugw29nj6lxfLg3oA7Cyq8Wp9wozeCM6Nxmjt/p3GyxpIEhFDamk4kgLo1Tl+LZN
         j7NG0UyDJl6Vatrr/JnuNVVLCfLNAz4KAsK5Oa21lQ7iukqcMEa0UsO3X2/D53TzLtcy
         Q+iAR5+YHBnKfvzakVTJmIlWMDEJzMSIZosZuTkGqNTS+Oa02mnMy6ziFnFtghMDvKoT
         cnu6A2HByn6euG4/pHEtzqsPpxo7I4fBrdHp0k9T7E4azcqfxpTZzFaSs5At0f/ZQwHw
         0d0JIw+zGLqUARkado6b2teBdeSWI7NKK49plz3demfWfzKNHALIvIkervrOITlEEscG
         fqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767866514; x=1768471314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s9Cv7mdPPcZ8e/4RiioRb+FP1zONlTuWhguDLBncdBY=;
        b=RNjhdiztrve+GxD0UXv6xnsUvR/yG/RZw7ZmAOH1A3TrSP2vPUqnFoYtb50VC9LX/e
         jNrGJcbCzypZ4IVAZkcXiMnHe8F/5YtElgnZri3PfkHTOxgFO6odlCGrmCJg2pvBZG0L
         S9NitgNRA5WOssj/4pjJ51NPZduJizRbgnO2bvAaemZAk/mjiajR4V74biwYlvxZOmv7
         e9Nzug5Yti9zV/tudTqHbBy2hoBv1YpJzyQJ+s5mcUuCr9b0jZON59EDHUZOriN7X3/K
         Vi2HAqPrO+ViXuAF5lwsCe0KQaCBJpHbTtl0hPQJMkQcCI+7x7we0xXCB6DvS1oanWX0
         G6ag==
X-Forwarded-Encrypted: i=1; AJvYcCVfSDzGvtmvGQtO53m9LWv6PSXuutpeBpxSX/ksIWgHgyds8od6OUJngH/IkHmTxq3OdW/bQGmvKw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw25NFEI7tx4g3Cz62JkAU8cs3cL26HSXhrO0f8Mvom+sQjT5OV
	crkL4bevPWFHwNtRl3kGGoLZKIqTAGWRTULBb7NkM1xu7M2F6TQGhyh5ks7Hvw==
X-Gm-Gg: AY/fxX6rxQbRecDB3o60f6uBnIRDvF+wnd6umkCYCQ9ufVAcW2KuiPx4Ui0WytJA+LB
	uMRNLmfi0eOGLvWPgr/HfVnhAQgCsaRTD2VChw2VLDsxtAaS01Fc2EEp1H2pOL+TUTVqhKmPDdQ
	vi5/0JW99wYE2+7PnlCaKi7X9Lz18OQ3PTUf/zGKs3GklpGhaSdiqOAZg3KGHNa7gQlcip/8ai4
	WYDeV7w9n4yyjAvERws12Hy6JH7R3rK9EBnv0J3Av+ESdI6ekwq/ypwEHach6fwT0L84oe+CpsA
	ezrBmEei+J7DS5bfdNL4FVbwIeUt43TRQCY0CHaXGRfvItEkXbO/IY5Vlgj3j8iuDdDuueCNNLQ
	DHiuwFeZ3t+NPrjX2vsPOUtOi/WN6YOcw/o2lyqpYifdVGOQsoAfk3xLQ4mbsD8n8H9839AatBq
	U3ltTlUolQGvu0y7Y5PqAOyl2htP0V0ceySKgh+QpvD4FZQyggaRDdUNZYnxo1yDdpAEdeUp5+o
	jTnijlHTZLOBB74Y6ox2Q==
X-Google-Smtp-Source: AGHT+IE5lf3uPbw8VErEKzhFGGbzHGx8u/fDHReHMHASFjL4yvedLS17Wjxspaaf5SF45aWguaeksQ==
X-Received: by 2002:a05:6a00:8c10:b0:7f7:497d:8118 with SMTP id d2e1a72fcca58-81b7eb26e99mr4452899b3a.7.1767859776927;
        Thu, 08 Jan 2026 00:09:36 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819bafe991dsm6900582b3a.16.2026.01.08.00.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 00:09:36 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dmitry.torokhov@gmail.com,
	sre@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org
Cc: jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-sound@vger.kernel.org,
	krzysztof.kozlowski@oss.qualcomm.com,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 6/6] dt-bindings: display: google,goldfish-fb: Convert to DT schema
Date: Thu,  8 Jan 2026 08:08:36 +0000
Message-ID: <20260108080836.3777829-7-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To: <20260108080836.3777829-1-visitorckw@gmail.com>
References: <20260108080836.3777829-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Android Goldfish Framebuffer binding to DT schema format.
Update the example node name to 'display' to comply with generic node
naming standards.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v2:
- None.

 .../bindings/display/google,goldfish-fb.txt   | 17 ---------
 .../bindings/display/google,goldfish-fb.yaml  | 38 +++++++++++++++++++
 2 files changed, 38 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/google,goldfish-fb.txt
 create mode 100644 Documentation/devicetree/bindings/display/google,goldfish-fb.yaml

diff --git a/Documentation/devicetree/bindings/display/google,goldfish-fb.txt b/Documentation/devicetree/bindings/display/google,goldfish-fb.txt
deleted file mode 100644
index 751fa9f51e5d..000000000000
--- a/Documentation/devicetree/bindings/display/google,goldfish-fb.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Android Goldfish framebuffer
-
-Android Goldfish framebuffer device used by Android emulator.
-
-Required properties:
-
-- compatible : should contain "google,goldfish-fb"
-- reg        : <registers mapping>
-- interrupts : <interrupt mapping>
-
-Example:
-
-	display-controller@1f008000 {
-		compatible = "google,goldfish-fb";
-		interrupts = <0x10>;
-		reg = <0x1f008000 0x100>;
-	};
diff --git a/Documentation/devicetree/bindings/display/google,goldfish-fb.yaml b/Documentation/devicetree/bindings/display/google,goldfish-fb.yaml
new file mode 100644
index 000000000000..48b9c056d9ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/google,goldfish-fb.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/google,goldfish-fb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Android Goldfish Framebuffer
+
+maintainers:
+  - Kuan-Wei Chiu <visitorckw@gmail.com>
+
+description:
+  Android Goldfish framebuffer device used by Android emulator.
+
+properties:
+  compatible:
+    const: google,goldfish-fb
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    display@1f008000 {
+        compatible = "google,goldfish-fb";
+        reg = <0x1f008000 0x100>;
+        interrupts = <0x10>;
+    };
-- 
2.52.0.457.g6b5491de43-goog


