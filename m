Return-Path: <linux-pm+bounces-19406-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE609F5F4C
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 08:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3021696D2
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 07:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1270216191B;
	Wed, 18 Dec 2024 07:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkkOge7L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F4B1537B9;
	Wed, 18 Dec 2024 07:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734507046; cv=none; b=DDVQs8+ZHW+ZNpa55gvWeAACNPKk89td7jyC48cvJi5bA600xJXxgGq3sbAAwK8yj6y4pmGw7x9aQw9aM7Y7es9c9VaUbGbYYAWOZpy6ZtXEvdydMs6TOFfpEIlPISBOSKACdHrzWG38FvXWkeOIN2CDIcoYeDnpFNc3aLjv3vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734507046; c=relaxed/simple;
	bh=RSdMFumWyD7Mx4sKNxKfjNlsDJaTB6uemxsTmcKyHuo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Va54UlWRMPYtwqjENVB1iXP9tSmpmHr5BFBlTYwPtNREEOgmqES8wqNoxEjxRhf/QAt0AiWDyeezzBs764368opZ0HmhwZfqmnVtEQFSRuXJtiLftdA3zrRqrqIQcp1NL4EdJd2UZ0xfzkpnQWYdKWRHN8dyO9PDCt+Q+n2g0iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkkOge7L; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa6a92f863cso1233665766b.1;
        Tue, 17 Dec 2024 23:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734507042; x=1735111842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NRHQQGm7cGssgdoLEtNCNKA/IiRlPKI/cHGPt5rH+50=;
        b=EkkOge7LWVfJvHDTSYyApTqYKt9n9DQ+73Oy+gDnkjsBwXJ0/KnompZfH8lI5rQ2gx
         fTwUEVtu/fHSb+4lBw6bvdm0avbFO1gerIoxKJyWFyfznD6i51vLi+Earb0nL04AX7kx
         Y0l4BzG3+euUUTPL72Bu7srOOcbogEkLkDtSwLYXpJYqWD6P45Gqq/wA0Ear/La55NqU
         9jVILeK0omkhAEMAs3bDyj6iS9Ju9VhCmfs8JadJm29h7HGvqv7GS0dgS5Rm6bFqmbcz
         5P3pE75AzgJzkXqLnz4cTWYyAA9XUhaEFoz2MaPwXQEtOuZf/HX9ZLBb0+wQzP0UiKde
         PrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734507042; x=1735111842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NRHQQGm7cGssgdoLEtNCNKA/IiRlPKI/cHGPt5rH+50=;
        b=w3NjORxHBdArxOQBpg0ssMO2bxHqKeaAwWspO6pgdn5HNa1itl1WEu/StmGs4g1bpW
         m9O3Fploe4PVyQbLzQpt//x8wXgSq4MSdYhG+FLheKzNOtjCAO3QvfvnWLMPgLqxnn/J
         qtJHBLkVpv6FqmaMEGeXVzET8NGZka7vXxLB8gw00oe+dNvdJ2x4nGuF69rL/VUriRkh
         Jq8r46YdasVS3fbLWRiQhred0TggCybnyWwmppfr2yoLcLYxbV9WRIUAvQdeRWauHKQB
         5iqbgs/M3FoRBdL4CGHqYwZETDEmLIGHOA678Dnhp8oO/lmFCAW809s4aWN4QxoZgwrP
         tr2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0Dnk8IVfmZLxLC5mCLy5vWnclRkIZjzelhtnxgKekSfMtIuW25qaWPZDfegJ5yckiQFGlDKmmj71rXJk4@vger.kernel.org, AJvYcCVBtzCeXctfXQ1alm2ui8mLegUWWv3zW0tnkRj8Nbp+DbzbU+aaOImRQzcmbJnMMUfLrpY19YQja7g=@vger.kernel.org, AJvYcCXR5YsnHM13/ZXI1wtvJw0XWTP/5kXD1y4d9ciy2UXZDETut7vUvl4+3SLUj+Iv4FZ8khbBHF/pjMzK@vger.kernel.org
X-Gm-Message-State: AOJu0YyKBplLzEVkoOTvsdmntS+ZNaW9teNv1jru51mP9HjQG7g5VwGz
	OODcBjRwJRyrKbJAm+EGyH89lFSCMyQq16tzVAncnnN63U15m/EE
X-Gm-Gg: ASbGnctO6fGJHXtawdHdWSQRE69UfFxor2/AEJ4NhsU8wO9xUjzoJkyYd3Q4cex5Obw
	RZpwcsDs08g72/48u4pGy+Jn9dJmzIdUVC+7XjIpWGhnsfqmND+YV0kqpED6phEgoReUzaj0vSy
	iqs/8+jKQ0SzsAfKHp7NB8e6gKPwm2tONsgQK2fdDq9Dquo5TQpZw00hvRQescm02+Flm8TjTJR
	xU8QIXO1XId8+RvUeDpT2EZD6MTfHkPudKO9FfrcfNWXUDOUKrbkaD5kyBalhGUT2JcYO5zp4Dq
	x5a45YOSZoaBcI7vLjoVgHPZx2U/OCBqHuRzJF/1dVY=
X-Google-Smtp-Source: AGHT+IG4ns+Eg7oKR1Pc/Cp43bbqwarsbtkMQng+j8RWLT7msrs+OqYGJoo0M5isEr+oiutqKugTLQ==
X-Received: by 2002:a17:907:720c:b0:aa6:25c6:d94f with SMTP id a640c23a62f3a-aabf47baa99mr116051366b.31.1734507042111;
        Tue, 17 Dec 2024 23:30:42 -0800 (PST)
Received: from localhost.localdomain (host-80-181-61-65.pool80181.interbusiness.it. [80.181.61.65])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aab960062d3sm525607266b.16.2024.12.17.23.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 23:30:41 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [RESEND PATCH v4 1/2] dt-bindings: thermal: Add support for Airoha EN7581 thermal sensor
Date: Wed, 18 Dec 2024 08:29:56 +0100
Message-ID: <20241218073016.2200-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Airoha EN7581 thermal sensor and monitor. This is a
simple sensor for the CPU or SoC Package that provide thermal sensor and
trip point for hot low and critical condition to fire interrupt and
react on the abnormal state.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes v2:
- Add Reviewed-by tag

 .../thermal/airoha,en7581-thermal.yaml        | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/airoha,en7581-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/airoha,en7581-thermal.yaml b/Documentation/devicetree/bindings/thermal/airoha,en7581-thermal.yaml
new file mode 100644
index 000000000000..ca0242ef0378
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/airoha,en7581-thermal.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/airoha,en7581-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha EN7581 Thermal Sensor and Monitor
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+properties:
+  compatible:
+    const: airoha,en7581-thermal
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  airoha,chip-scu:
+    description: phandle to the chip SCU syscon
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  '#thermal-sensor-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - airoha,chip-scu
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    thermal-sensor@1efbd800 {
+        compatible = "airoha,en7581-thermal";
+        reg = <0x1efbd000 0xd5c>;
+        interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+        airoha,chip-scu = <&chip_scu>;
+
+        #thermal-sensor-cells = <0>;
+    };
-- 
2.45.2


