Return-Path: <linux-pm+bounces-40057-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C99F0CEA913
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 20:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C36F3012BED
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 19:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F6E31961F;
	Tue, 30 Dec 2025 19:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ji+E9FLh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F66B2F1FD5
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 19:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767124531; cv=none; b=leGv9em+4pEF7Mv8ZPgmu5XjNINWusnd9elyk5UDbGJRbTl2Q2rb1SKLKrzLi/66GJu+BMvzHwHVyZjaSMHkMzEw+2CsHi2mhqsFMC02dZ9qMbjTEp2RkoCSJ3gNmBOJAGRMbzf7dTXsf60NXb91hdIB+CyJGKltrr1Rac2v4JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767124531; c=relaxed/simple;
	bh=UfuU7YANuY2DtAb1JPJwiKh/zNCqLQCQAfbDrFS7vE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DTJ8UGE6TJThBhKc1dmwoWqCcNCfwLDy85jsfXUsw0twBsR3w/lSD9RGsGB0LuLKpIBCNTVP0dJCuX/1J8Quinb1fkQRWvxq0ONu8jGBVDNj05YQckJ9mIDzRXXmb03gHPoen+lzHB7QKXaQ1Rxu9XCcJwelVbsKHJXpDyvnmns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ji+E9FLh; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c7533dbd87so7632433a34.2
        for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 11:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767124529; x=1767729329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83p8xxawIJkmopSMpAdalPGsHw+uQLv1ciZtoS9EH+c=;
        b=Ji+E9FLhEYJ0SQD1sp0VrSTRtxLQXGgvVFQVi0aLQkGTP88dLMjUFSawvxUQtDpOFi
         /IJ5RPf26BFbN6GgMEOiCvoUl88OQTcA2EvtiR2tPxWzUb3T5OAHrOU9+W4aQiZWWm2M
         C4FCJ1qjc26URypCDvgPHI9wD/yHVtkJQQPAqhzuob+eAN7C2f5mPtu35UtIoJhEIEj0
         lrQJuV4t98LScGlxj7QYRxvQng39Ede6tYKAMUmBYVAtNshjTzDj4zlOEiAedZooLRJg
         FTUsFRqajr6+Xmt1R5HQU3OOLHnENnUkoYnZody+K9dWRkFWhU9fmz3cqo5yi/IbVEGI
         ebow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767124529; x=1767729329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=83p8xxawIJkmopSMpAdalPGsHw+uQLv1ciZtoS9EH+c=;
        b=UWWzLfRWT2j/UZmrV8PXX8xtsrsLSFEAmxjuJxWPKTsUjhZzPiMu2MR3mdyH7hIjug
         QERZfWVhLitWmhC5uW6yAon7AKyXH9ksEkFeXF2Sd8I+jbzpxY8vi+OUpTSCshAoAnzZ
         7e8wL/YBgFEXQN4mdmyhUqKI6rlj98oZ2T13Pi1c8/hHPPkMwQOUdO40cyqEfF2sf4z4
         TjKlMcAYHctW6HiuFkr1/vntnPIQce+7MB3CtNENmbkXIQ4yDu1hkm9+lLLakRyVwv5S
         tO7e9DvJes2FZPSDtkcSqDFX9mAEY/7PvalN1xhKgwyn559eP6JDAsSqJkaN3qjQ2HZ3
         PXFA==
X-Forwarded-Encrypted: i=1; AJvYcCUd4hbaCeMp9psBoBxq5sLawXeixd5ADtitraawt0dYUedjKzl6R0f6+1XkL9chzaSubhC3arVKRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDw6MJL9oldiVEyD2hZ21tyZPd8ZUggu0uH0DjtwjyyY3Fo5HJ
	QmQJN3aOAZ6ijdnZMZRw0CRZc7KM4KgY82d50LhJzU+y9gE8SFT5I0yvLwiJEg==
X-Gm-Gg: AY/fxX4xsksjehmWS+jA/LzhdNbzf/rBSDJvZdWbXcTUOzlNpSmybkEs+BBXrdWIVMu
	H5Fq4z5NDobaTqjtC2Yw2RtMy9zFutqB8qwr4TAwRH6CbdA+70lchgCsyqLB2cKwPWhxQYiAK7F
	3XB5FHOJXEnO4U6aYOa9jm226F9xZLI7BuWMU3b8Jm8UHYQBANwJTSVEp+Hp+DMRKUYP0JJZFHP
	fQHLL9NSX0aLfIjcxOJhmrx0sfJolASV31BLrrtFVRoK/X/MPoy0ihk9t8LYSMn7FsU7cqdbzg/
	ADjuBX3dRNSH/ie/qs+79hQ0Ecf2L4HcCIDh+obFzPZxKh5UZy1pMY5GC1MJ4mhivVSTG3Om/6D
	FmLJeZjfQZ+m81BbR1q0OuIXw4Uufhn8MDWHIGLKm0pV8ravSQObLDsjvaNudIAayVG1IxdtIom
	hAgyciE8Mq01tGi/NVFq1eNauGOuUnVuYvowBAkZc6+ic8M0z3JAdcOk0YNOxY/i/nAPbTqubxT
	HmYjzbpc2WhNnrYWAlNOQ==
X-Google-Smtp-Source: AGHT+IFIRsb1yFLdQjiEzch59E2/VO7Id1WJQzqg0S6DL4+slVXOXOweBZRKfGEK/PtM3/p1UkcWag==
X-Received: by 2002:a17:90b:3f08:b0:341:8601:d77a with SMTP id 98e67ed59e1d1-34e921ccb3bmr30732436a91.29.1767118270582;
        Tue, 30 Dec 2025 10:11:10 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7bc69728sm29598278a12.19.2025.12.30.10.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 10:11:10 -0800 (PST)
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
Subject: [PATCH 4/6] dt-bindings: power: supply: google,goldfish-battery: Convert to DT schema
Date: Tue, 30 Dec 2025 18:10:29 +0000
Message-ID: <20251230181031.3191565-5-visitorckw@gmail.com>
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

Convert the Android Goldfish Battery binding to DT schema format.
Move the file to the power/supply directory to match the subsystem.
Update the example node name to 'battery' to comply with generic node
naming standards.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 .../devicetree/bindings/goldfish/battery.txt  | 17 ---------
 .../power/supply/google,goldfish-battery.yaml | 38 +++++++++++++++++++
 2 files changed, 38 insertions(+), 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/goldfish/battery.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/google,goldfish-battery.yaml

diff --git a/Documentation/devicetree/bindings/goldfish/battery.txt b/Documentation/devicetree/bindings/goldfish/battery.txt
deleted file mode 100644
index 4fb613933214..000000000000
--- a/Documentation/devicetree/bindings/goldfish/battery.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Android Goldfish Battery
-
-Android goldfish battery device generated by android emulator.
-
-Required properties:
-
-- compatible : should contain "google,goldfish-battery" to match emulator
-- reg        : <registers mapping>
-- interrupts : <interrupt mapping>
-
-Example:
-
-	goldfish_battery@9020000 {
-		compatible = "google,goldfish-battery";
-		reg = <0x9020000 0x1000>;
-		interrupts = <0x3>;
-	};
diff --git a/Documentation/devicetree/bindings/power/supply/google,goldfish-battery.yaml b/Documentation/devicetree/bindings/power/supply/google,goldfish-battery.yaml
new file mode 100644
index 000000000000..a7c98ef56201
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/google,goldfish-battery.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/google,goldfish-battery.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Android Goldfish Battery
+
+maintainers:
+  - Kuan-Wei Chiu <visitorckw@gmail.com>
+
+description:
+  Android goldfish battery device generated by Android emulator.
+
+properties:
+  compatible:
+    const: google,goldfish-battery
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
+    battery@9020000 {
+        compatible = "google,goldfish-battery";
+        reg = <0x9020000 0x1000>;
+        interrupts = <0x3>;
+    };
-- 
2.52.0.358.g0dd7633a29-goog


