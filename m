Return-Path: <linux-pm+bounces-19325-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 031969F36FE
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 18:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3507F161589
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2024 17:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7A01F706A;
	Mon, 16 Dec 2024 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+Y3Vdok"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB34D126BF7;
	Mon, 16 Dec 2024 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734368835; cv=none; b=WrB8j6JhgU1+0XJoecRW/G/Sv80PhREEbwRwWcPa0IAiXHdmmahxSlqlWf31ESqJJlOBMlo7v/84ELbw/vkiyP474CROLHQY/vr8PUJdv4N/A6+Z5Va/NCdNacURNsSDe6VReBYLEcP8dLisjSwUbA2PCllIUjv/40ft/sUM6nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734368835; c=relaxed/simple;
	bh=nqa0yKrGVipzt1i8ai3QnkH5EdsUmx2Gx1mXizMu/eo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Rc8meLH7S2vJsgpsS4cRp2ZkLJIm53SL7dFIMaUjii+dGwne8g5mVTCEejVImvt4zuTrQLa5s1Ooe7XAqg5QPPd1AvVcsK8QKnIqfnmMwCQ8yEvQJAOE0MYI+kQfHS+0kXlJSECNH0B2DTt0FmSDBIU4fWqPZofglqPIuhbaE0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+Y3Vdok; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-728f337a921so4516231b3a.3;
        Mon, 16 Dec 2024 09:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734368833; x=1734973633; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T34+DtDD0wVqr5IGCJJ2F6eVKGhKWw09EE8E7qNOEug=;
        b=j+Y3VdoklYmihwDvmgQQ4ZTGJNu/SG4fmTnwHPOzp2meNp1DTRGt6jvlcWAj6wEZwJ
         q6BRISUwnWOSRCslQcHX9qXnifB1gAM6U6mU7eNXg9M24VlcEYb+t41kMFoCo5f36QG7
         Ufj7b5u+WN4UUIBZHKe9Tf+yRTVvDLMcZ460yb7rLAXM83GoWC6cxddrmSASeUCHZx66
         7sJ6SuhRjbd/DFFTB2f0fC9UBCgZnrBrrA7QcY8k2ZR/pTXScJCAqQWhbBSg0CK0XsDU
         78v9X6xZStxpyjlX70SZywoKSNRUNv/gOLwyVOkepm4FD5GS9TQ6FwHeocJtH1QZKamD
         MLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734368833; x=1734973633;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T34+DtDD0wVqr5IGCJJ2F6eVKGhKWw09EE8E7qNOEug=;
        b=RiwuZo3K5iv2U8j8Usr0wdVOkclIyDPg7FQ7oMNTjbFTg4A+BhIsk1+ikrv2+yX1Qt
         E3Ozkq9SnBAtdXwdUVQK7kTAutWmqbE+u/riaU+EJJkM8oMhdXNxkSQyl0jpIpGX+51/
         qnChZNkyVIz3ck/3l/h5ZiprRBqQrI15lk1mqCJ1AQLMLpbKrwxTM+W+DgUou4ckWVdO
         weEwjEwuSLS1+921iARe6zL4XTxGgAeZYFuDjEnp7AKvYaIjaZkm7reHvBitmIRO8iJW
         gsL3v/kOcugCRyaO7jbOgREmyPIcPRKTknvGV3kttmjYlVC/oZ9YMulHVsX/82Hl4zrc
         MEFw==
X-Forwarded-Encrypted: i=1; AJvYcCVBwzHSm0CP317g+iLt4WR0wibxje6rJVP96wZf9zXgnRJVphZyKPyOnNWw91HxAO91h56SW+YVV+Q=@vger.kernel.org, AJvYcCWgKK5kaYZusPv2gBDP2GOIEXPS/G2XRqnpGDISjspfOgaImNDi7h3mX3Jurqt4fVcGQ8COtNkWtIXZ5f0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB0Gy9l8zwzLBFFD3d73IeZWOkwDJE0A5FvmxphhA4JgMx0Mqp
	l1ziQ/kVV0bz6CvRfn+d3jyDWzR9+xmIryD4FFB5qyy9ZJhmxfSl24MDuiM4BII=
X-Gm-Gg: ASbGncsDOtt93BAUOLLHY/qG538pZY4xIaFGioMPs4kYSPmBBC7dsIJ5nB1CGDktI+b
	DLzDpHWhq6Ld/x20AytA3dvrppFp/CGuPWGCedxnGCWvw2CnbuDCBLP0+fG+QvNf9bsCur+BLK0
	ucLmDy0dTy21S3sBGAm2eB2ioEKGjFx6M9g0PBjxM71KqQqLqRky/sQ25Hdp/FTjeGaWD+xDQ6H
	MZcaJ+B8Bj+vJPhLSzjJztznWa6/NvH0CmqGXsTOemMvRx3CmPcN+g=
X-Google-Smtp-Source: AGHT+IHNWKzG4P2yf8XN1h6ogBXeP9L1IgkZcGt+PLq7zz8qiHMZjIJXiPRDxktgo/QPd+mZGcAxyQ==
X-Received: by 2002:a05:6a21:6d88:b0:1e0:de01:4407 with SMTP id adf61e73a8af0-1e1dfe22fbbmr21873712637.37.1734368832710;
        Mon, 16 Dec 2024 09:07:12 -0800 (PST)
Received: from Emma ([2401:4900:1c94:5875:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ac53cdsm5144550b3a.23.2024.12.16.09.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 09:07:12 -0800 (PST)
From: Karan Sanghavi <karansanghvi98@gmail.com>
Date: Mon, 16 Dec 2024 17:07:00 +0000
Subject: [PATCH v5] dt-bindings: power: Convert raspberrypi,bcm2835-power
 to Dt schema
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-raspberrypi-bcm2835-power-v5-1-222fc244132b@gmail.com>
X-B4-Tracking: v=1; b=H4sIADNeYGcC/43NwQ6CMAyA4VcxOzvDupaBJ9/DeBij4BIRshnUG
 N7d6Qk5ENPT36RfXyJy8BzFfvMSgUcffX9NQduNcGd7bVn6OrWADFBlqpTBxqHiEJ6Dl5XroNA
 kh/7OQZJF0KrioqRSpPshcOMfX/t4Sn328daH5/fVqD7bf9RRSSUNcQlYO22QDm1n/WXn+k581
 BFmEsCaBElSFm2Rhow2S0nPpXxN0knKc1CcGaq1bpYSzqViTcIkWdcg2qpGan6kaZre0u8yD6A
 BAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Alexander Aring <alex.aring@gmail.com>, Eric Anholt <eric@anholt.net>, 
 Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Karan Sanghavi <karansanghvi98@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734368828; l=4303;
 i=karansanghvi98@gmail.com; s=20241017; h=from:subject:message-id;
 bh=nqa0yKrGVipzt1i8ai3QnkH5EdsUmx2Gx1mXizMu/eo=;
 b=XMdBfFMw2Ua7oi8W6VLKMIB+O3aFeyg/K8cbMgxL7pMjxHQSjqMAJnxjkKYkce0fExwSdJBcx
 mj5a4OY3uycB7bZpU01/VAxC97jTIucxQJMNCPKxMib3mU6cSHQzac0
X-Developer-Key: i=karansanghvi98@gmail.com; a=ed25519;
 pk=UAcbefT1C06npNVDJHdgpPqTm4WE9IhaA1fmJb3A37Y=

Convert the raspberrypi,bcm2835-power binding to Dt schema

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
---
Changes in v5:
- Added maintainers for the power domain
- Link to v4: https://lore.kernel.org/r/20241028-raspberrypi-bcm2835-power-v4-1-acf44abd45ff@gmail.com

Changes in v4:
- Corrected misindentations and random differences.
- Link to v3: https://lore.kernel.org/r/20241026-raspberrypi-bcm2835-power-v3-1-6621e075d33f@gmail.com

Changes in v3:
- Applied changes as per the feedback received for title and description
- Removed power label and renamed node to power-controller	
- Moved the file from bindings/soc/bcm to bindings/power
- Link to v2: https://lore.kernel.org/r/20241022-raspberrypi-bcm2835-power-v2-1-1a4a8a8a5737@gmail.com

Changes in v2:
- Added original file maintainers
- Removed unnecessary headers from example and formating from description 
- Link to v1: https://lore.kernel.org/r/20241019-raspberrypi-bcm2835-power-v1-1-75e924dc3745@gmail.com
---
 .../bindings/power/raspberrypi,bcm2835-power.yaml  | 42 +++++++++++++++++++
 .../bindings/soc/bcm/raspberrypi,bcm2835-power.txt | 47 ----------------------
 2 files changed, 42 insertions(+), 47 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/raspberrypi,bcm2835-power.yaml b/Documentation/devicetree/bindings/power/raspberrypi,bcm2835-power.yaml
new file mode 100644
index 000000000000..259e1d9b3fab
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/raspberrypi,bcm2835-power.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/raspberrypi,bcm2835-power.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM2835 power domain
+
+maintainers:
+  - Alexander Aring <alex.aring@gmail.com>
+  - Eric Anholt <eric@anholt.net>
+
+description:
+  The Raspberry Pi power domain manages power for various subsystems
+  in the Raspberry Pi BCM2835 SoC.
+
+properties:
+  compatible:
+    enum:
+      - raspberrypi,bcm2835-power
+
+  firmware:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Reference to the RPi firmware device node
+
+  "#power-domain-cells":
+    const: 1
+
+required:
+  - compatible
+  - firmware
+  - "#power-domain-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    power-controller {
+      compatible = "raspberrypi,bcm2835-power";
+      firmware = <&firmware>;
+      #power-domain-cells = <1>;
+    };
diff --git a/Documentation/devicetree/bindings/soc/bcm/raspberrypi,bcm2835-power.txt b/Documentation/devicetree/bindings/soc/bcm/raspberrypi,bcm2835-power.txt
deleted file mode 100644
index 30942cf7992b..000000000000
--- a/Documentation/devicetree/bindings/soc/bcm/raspberrypi,bcm2835-power.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-Raspberry Pi power domain driver
-
-Required properties:
-
-- compatible:		Should be "raspberrypi,bcm2835-power".
-- firmware:		Reference to the RPi firmware device node.
-- #power-domain-cells:	Should be <1>, we providing multiple power domains.
-
-The valid defines for power domain are:
-
- RPI_POWER_DOMAIN_I2C0
- RPI_POWER_DOMAIN_I2C1
- RPI_POWER_DOMAIN_I2C2
- RPI_POWER_DOMAIN_VIDEO_SCALER
- RPI_POWER_DOMAIN_VPU1
- RPI_POWER_DOMAIN_HDMI
- RPI_POWER_DOMAIN_USB
- RPI_POWER_DOMAIN_VEC
- RPI_POWER_DOMAIN_JPEG
- RPI_POWER_DOMAIN_H264
- RPI_POWER_DOMAIN_V3D
- RPI_POWER_DOMAIN_ISP
- RPI_POWER_DOMAIN_UNICAM0
- RPI_POWER_DOMAIN_UNICAM1
- RPI_POWER_DOMAIN_CCP2RX
- RPI_POWER_DOMAIN_CSI2
- RPI_POWER_DOMAIN_CPI
- RPI_POWER_DOMAIN_DSI0
- RPI_POWER_DOMAIN_DSI1
- RPI_POWER_DOMAIN_TRANSPOSER
- RPI_POWER_DOMAIN_CCP2TX
- RPI_POWER_DOMAIN_CDP
- RPI_POWER_DOMAIN_ARM
-
-Example:
-
-power: power {
-	compatible = "raspberrypi,bcm2835-power";
-	firmware = <&firmware>;
-	#power-domain-cells = <1>;
-};
-
-Example for using power domain:
-
-&usb {
-       power-domains = <&power RPI_POWER_DOMAIN_USB>;
-};

---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241019-raspberrypi-bcm2835-power-5a4231be8959

Best regards,
-- 
Karan Sanghavi <karansanghvi98@gmail.com>


