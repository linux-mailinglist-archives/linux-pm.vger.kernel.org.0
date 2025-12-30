Return-Path: <linux-pm+bounces-40059-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37939CEA941
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 21:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01A5F3014D8C
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 20:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDAA2750FB;
	Tue, 30 Dec 2025 20:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtwZUZKt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A32419D071
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 20:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767125141; cv=none; b=p6tyV6+Z/vZOTehO9sx/DGX7QDTNd4mWZG1XuSpgaPqDWeUnNDikvS3XRIlOQmed5xHVQOdSElEhpYwRNSIGuemG+HTOAKd9AoAHfROd/Btv4SDBlwdb/vxt49kGkMgdh0FpDXHdNY8ZPKHYzOriZaSOxI1koMMEWPfLVrEXo/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767125141; c=relaxed/simple;
	bh=a9IYvFqlG/UaJElPMyJFzg5gch1C9rdzE80DQMDwPnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfBh14e85/2bGUwdkvgmSZGMtzt5RC5Nn90BQH3i3XcrV/b4/93nNzgz0OHHhAgmpEajDXJK08NJC7du9gJBeIrVhdwp6fBPebiNEF0HJJw9EVxrziRaFTOzlFeQCFkbBAUqEU9pyXlg/Ag6py9eFQGe+QzVYGOY5l+nDo6VMqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtwZUZKt; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-55fe7eb1ad1so8183623e0c.1
        for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 12:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767125138; x=1767729938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqq42GMedrB/T6d7mRybr+4FEurk5kHOMzPka2Yicmo=;
        b=LtwZUZKt102BidF+Amp5CLLgT91epP3TWJjvWYRi8VXZly9JLgB3Y8ZsIMPF6K+TYR
         Xm1h/q/NRxa8Ji/mNqtAW79Egr841Hf/QklECCQHRDdZUVjrSy4jL2M1Com8aUTOCVuk
         lhSWDxGhzditcJOyQOpHOe7SJspBOQ02zCSKSSLs8mxQhkpOh1NCw18Nfv3B8Xp56esj
         0pDW4A0u395UR+wloY4TV940nzhCRtV1cLd354VGGKmkyCgxbBcqwztyMY3Dj6jBgKdg
         eId87dlyDfiQaNNIs79/I5diXN2UmNhx0eIJX/fKcg91SuTzFx+dZOR/Ci2KXgDzvePd
         9nlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767125138; x=1767729938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vqq42GMedrB/T6d7mRybr+4FEurk5kHOMzPka2Yicmo=;
        b=qg+9fzDoKfWG5MTEVrVh+W1iL/2f1ND9XYat8lkS2Pd+lDkaNNF1LimXPfTlPg9G+n
         dTCAMlYkvHpOh7h4/yB+pa3hONfherr5/6iNyPqrFxP9IH9sREW3XfW/0PHvjn/hZZ14
         G4/oS4TnErkgOC97OtzoNlxmjfonKmpnnIQiShjVjFG0WwhdkkZWEGAY1JPv++Rs+2BB
         xkoxRPbk5c87eMG7UgdTzDFzKYwb9aSeL5jLHaEfrPJDiDP/WX6Y+xvJZsyqqJxZ8bFT
         x3eeOSrqdCI1vf35kN4OW2dlPvVXR9Voxnaiads30CowPDPpntwK84mJ+Yoa0jB759C9
         XcEw==
X-Forwarded-Encrypted: i=1; AJvYcCVZs1dok4GcOLOq2MMQfF8IxCtKNQxaiJpnqfbOqEdB2sO0wfHkby49fAPSVANrJchjLNCNV41DQA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg0BOp/sBVxXnqCZjK4H61LpyZt2d8FdHW3zRM/beF08HkzW+a
	oU7piU/i4/wEq/roDdVPWyKkeBTpLsN57x/AkGy7WZ4AerN5yw/L95rm
X-Gm-Gg: AY/fxX5m1vZYpVSOcQGcxXoozTVbSe+yH6ExC1Q60W06z95YXgq2dXt8bTyE9+qdAKD
	w3fTUDS4s/q39eQnAQR13TBJlGzK2IhCQF+GfxJ4i6B599GPHNuVRPjEyH5RCYHKfTrJLMLq0we
	DKuQvkS8jeRXcXUCejZNMqpfW/6mZXvTptHOqmNPfi5pxJCe9dX2KFYJV0CkNycMuxm+uWOrq6L
	BYAZaPGf7FjW+w0mHgY6AM1uT1lkbEQhZflmen3lfdB/gW7YER8bL4J201cluKGQQ2NOEginqeo
	FonljLREaelCPIVcFxEzb6hTw3Beol0sTFaJCXrD/nvq4pLLcyo08+WiiyheY21aDl+RAmkslG5
	8ypE1+/E3v/qtl+5YS1Um87v5fxrS/fNfS6VJiLHTx27OhHKn9CkC7IaR8JsRyZlpSQBLSvhiRb
	uKsDC2ty2uXURHpmUqYxa1V1YKFgusF8k7CZQ7Q/Z1dtQo0tSydPPhEQKl1B+3agCw0ZGpUerbH
	ffvIXnDop2PVNJqWTkY7g==
X-Google-Smtp-Source: AGHT+IGG4IvGkIealWBZgvBLq7nxU8BQLyVFrfwWxsNjASkIojjiGo3aO9o10cXPbEY9owzzFvEfpg==
X-Received: by 2002:a17:902:e748:b0:295:738f:73fe with SMTP id d9443c01a7336-2a2f2732287mr344445935ad.30.1767118253801;
        Tue, 30 Dec 2025 10:10:53 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7bc69728sm29598278a12.19.2025.12.30.10.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 10:10:53 -0800 (PST)
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
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 1/6] dt-bindings: serial: google,goldfish-tty: Convert to DT schema
Date: Tue, 30 Dec 2025 18:10:26 +0000
Message-ID: <20251230181031.3191565-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
In-Reply-To: <20251230181031.3191565-1-visitorckw@gmail.com>
References: <20251230181031.3191565-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Google Goldfish TTY binding to DT schema format.
Move the file to the serial directory to match the subsystem.
Update the example node name to 'serial' to comply with generic node
naming standards.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 .../devicetree/bindings/goldfish/tty.txt      | 17 ---------
 .../bindings/serial/google,goldfish-tty.yaml  | 38 +++++++++++++++++++
 2 files changed, 38 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/goldfish/tty.txt
 create mode 100644 Documentation/devicetree/bindings/serial/google,goldfish-tty.yaml

diff --git a/Documentation/devicetree/bindings/goldfish/tty.txt b/Documentation/devicetree/bindings/goldfish/tty.txt
deleted file mode 100644
index 82648278da77..000000000000
--- a/Documentation/devicetree/bindings/goldfish/tty.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Android Goldfish TTY
-
-Android goldfish tty device generated by android emulator.
-
-Required properties:
-
-- compatible : should contain "google,goldfish-tty" to match emulator
-- reg        : <registers mapping>
-- interrupts : <interrupt mapping>
-
-Example:
-
-	goldfish_tty@1f004000 {
-		compatible = "google,goldfish-tty";
-		reg = <0x1f004000 0x1000>;
-		interrupts = <0xc>;
-	};
diff --git a/Documentation/devicetree/bindings/serial/google,goldfish-tty.yaml b/Documentation/devicetree/bindings/serial/google,goldfish-tty.yaml
new file mode 100644
index 000000000000..08fa12449a01
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/google,goldfish-tty.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/google,goldfish-tty.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google Goldfish TTY
+
+maintainers:
+  - Kuan-Wei Chiu <visitorckw@gmail.com>
+
+description:
+  Android goldfish TTY device generated by Android emulator.
+
+properties:
+  compatible:
+    const: google,goldfish-tty
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
+    serial@1f004000 {
+        compatible = "google,goldfish-tty";
+        reg = <0x1f004000 0x1000>;
+        interrupts = <0xc>;
+    };
-- 
2.52.0.358.g0dd7633a29-goog


