Return-Path: <linux-pm+bounces-40692-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B752D15390
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 21:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8199D302B776
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 20:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B80533372A;
	Mon, 12 Jan 2026 20:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipDp7YMX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E7631326C
	for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 20:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768249788; cv=none; b=SPlT91hMXudNm/9fQY3Be7UZpKG4Hoc9cABj1gpJtjssYsQAbBWLQcR4NHx65vEtUfhNDtK7o/KKy6zpYavjp/idXNsbspWH/VH2efe0aKbDG2nvq8wJn29fB4artd2IB4IaLqjKjzj/KFVtcngHc+up0EBHH4ayEcMLHC+zuCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768249788; c=relaxed/simple;
	bh=x1koErt0KZrKg7lQQJMxHMUYCfWzQV0KokubZfs0FJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jr0DGmgGmjNQZH06cjINChiRiCHIGB9oiGIE9LuZ+MRly2P7oHdd3y6cMQG048oIP+mtafuctmx2YDMgLmgoWVMgUL6fOy5ZTdehLoJDMkVitQmTJKrgP3HhmkzZ/4LZYEJCvAzSao0skjvS2VbjechMkbjsVOkMjW2lXfY26OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipDp7YMX; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b1bfd4b3deso607912685a.2
        for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 12:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768249786; x=1768854586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnJl4mjA928H7c6+CxPcUynMWnjGzO8z//ft5AvFLSQ=;
        b=ipDp7YMX/3ui+xeDZF4+aMZPSOoCZR+PBY97xeKC9a9fEbKI5TL5XncaTzz+x7mbPp
         jnmXrz2eRCuIXPB4+j6cRTAKe+S9i6cyrOGeip77vvXyqUubkJZddRn/gGpDvTKUpu/j
         qV8PR6j1gztvZn1TlTADKWWxMHiefqv0kPjywJiJRFVdQ6IORbLWiX8SepfB26Ffg9s1
         5yYQobbIVFBQXaJ1oE2KJL1Xz1LY5XuSotq4Wf/I3OAOe0M6wfFiUEm29k+ztKo24Q5X
         Mhq/OCQiE7HWuxPcIoWzghmCC7MpLgZZExJmmkOMcWWqe0MkxpsF8Cg2+UiZQCERmiIa
         Undg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768249786; x=1768854586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MnJl4mjA928H7c6+CxPcUynMWnjGzO8z//ft5AvFLSQ=;
        b=J1B8uhD00p3oIr+7lUj9g5BlPd8jv76VQnxcMpAK8uDS8TAIKIaO5EmNE/R7pnZyUu
         sB0UBm1HCjWDj8mhtRdPbCh+wj8+/FlpbFLl/q+iLWQ5h258JEVHh1gLh4se2w5k8Bmv
         RZb+4uHQoSuSx8LMGJGCA5WuDV6zM1nnEp7LtBP/nh4QsV1/2q0JJEpSn/q8sezfX/3G
         0sUdG1HWiyJr+o+pxGP4pgtZHRGcVRGWdnXoZO0pgBLZjfoOlks484l89IErj91o8L1N
         XPGEugcSZIBxpvUs+teKXZaaKYl9AmHrDjiUcxSDNwJpKr3vJ3b1YhhY4lgcs/Lxz76F
         vIug==
X-Forwarded-Encrypted: i=1; AJvYcCUOKOFvx40sUlrHByfM5uZdrqXEIhukbP8O7jQgXhR/l7PAGtsAiDrnaajr/D7TbV0nsQy15LQ9yg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdgCtRE/X7Cy4T1HnpTCuOIEflkUMoLelttL1qA/3KDjElq/rP
	sV/OjcWIMYhisj4LlQD8OTwaqFJkugBRSycom5bq83KmJhdt3JLeDJMdDs+2WA==
X-Gm-Gg: AY/fxX7sMK47NT5OMjtIODWedui2nHYFuL2b4W5D+HE2H71NP9Lbn1PFZ2HNxCeHJVT
	yK00MaSer4BcumMDqFxk1F1sgXMRmkMGkHkW+WR7cFR3Dmb4nQbEgyOtMlRQec0CDzo19JzwrpD
	hB+PXjfKcdp+eP3mXjOp5MLNpzteJz4EH4Ci+mf/TH8mOEaYjaSXIc+YGjsQkyoVeikLKBQk2t4
	HMaWFJl8YfokZ7Rthi1edYRFbVlTXRTSsKXSQKxX7T3/HG4bfa/LSZl/LhCVOwfd3B2gSF3qlSO
	glBLKqLe4nCQBgNmQuxiXOGA5rYhbmUvA2MD0KNK7Okgf8P19cOjCc1jvcgysJ7tTtOEsHl/p74
	DL1kBfa48UVU9jnYqDaZYdx3U25/N0Msj820MFjrNFR7oi0KRg/9k4HHOhb+ihbEvdgsb5TTIRU
	EcCCs9XuZniqax6GBL+DaUvWjPZrN608CzJYOCre5G701pBy4bkG2LNvtipYtVmTwLUtL1WDFQ+
	sbm0X4e/GaoTjXICSAyMA==
X-Google-Smtp-Source: AGHT+IFEOJtKiZOekw3QKky7cg+SUdsdDlCfIy6gQ1Y92OIF6fv5PXYBPdHBg9wlGXMZd4H/lsyNmg==
X-Received: by 2002:a05:6a20:3952:b0:366:584c:62fa with SMTP id adf61e73a8af0-3898f9053f9mr18835078637.21.1768243935601;
        Mon, 12 Jan 2026 10:52:15 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cca06b16fsm18874197a12.31.2026.01.12.10.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:52:15 -0800 (PST)
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
Subject: [PATCH v3 6/6] dt-bindings: display: google,goldfish-fb: Convert to DT schema
Date: Mon, 12 Jan 2026 18:50:44 +0000
Message-ID: <20260112185044.1865605-7-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
In-Reply-To: <20260112185044.1865605-1-visitorckw@gmail.com>
References: <20260112185044.1865605-1-visitorckw@gmail.com>
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
Changes in v3:
- Use decimal format for interrupts in the example.

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
index 000000000000..36ed77cbbcd7
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
+        interrupts = <16>;
+    };
-- 
2.52.0.457.g6b5491de43-goog


