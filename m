Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D2F1F6EBF
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jun 2020 22:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgFKU3k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Jun 2020 16:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgFKU3j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jun 2020 16:29:39 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F08EC08C5C1;
        Thu, 11 Jun 2020 13:29:39 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f185so6308482wmf.3;
        Thu, 11 Jun 2020 13:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=InfuSQrhqozKhlVQhqZ021Atyx36SWr0cccknHigJNQ=;
        b=ZbHpE7PO9ECOREBHZOn1Qa17WdoSlpuNcwmIezC6weQHEgDIphFklrPVQjMV24Q+F7
         oCRaY5gbpuY8AR9tozQwtS16khDIyeCwMEVEwlFMQ5OVQj+SX9IwKZdWzRueZ+sQfRiM
         I8UwMn2hOprSlrGjKjUETdEq2M0ucrxDkDIWFOEpxmvh5F5JmsgGpG7y1BVZsXHKMcVc
         ZvJ49HMlwWilSBCfJvmQwFWURmy0Ol9BUhSeyi0TodmGiiCHAnTqZA3+O/W2fclUZhSL
         LBDY8Grc1EcJ/UjSJTUwYdhTzDPmW+W/Cj+9EG4h0WUzNUbs7PVuS6VsBO1bATfktoyh
         58hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=InfuSQrhqozKhlVQhqZ021Atyx36SWr0cccknHigJNQ=;
        b=p5GbpAbQuULIA3mE+oyUxiQW5sGVaNpx0dXoWnEzakaOGa1KnJsivFha7LL8ORlcHX
         WVLSXAwsmZJQl8H/MN/MDjBIa2yfbg5I7XG0YDuSOiFyFg1wc7YmSFrNjt5x3iaE6bEN
         5DELckFXGZRViQT3bNhXEP04hDL717YObs4vOGOdl5VfM4gEMxudGjhAUMUWvJh0CYUf
         d0FzivcK8FWN1x9fulE7lnm+ntc4CLgvScGSdbNvR96Ax9UCvu85xqNESi+Ejr8PThrr
         FuqT259Yv+1wcqaglCinMGcoNqPyhSdLJYlEgJaJ7tOsxv0Fh2LbyPT95PsQ5wlNHR5L
         GOlw==
X-Gm-Message-State: AOAM531VH459QTnuf49mDS8/IvM8MXFik6u0IjU4zSjAnjH04vQuyYhP
        bXZA0iDLwUiRSTg8vHjr45+2w4f7RUk=
X-Google-Smtp-Source: ABdhPJwvme8MOHRP1Z0T/DDWG+CftmsV9ffhkQBubQ9OXPfEQiHP/ly330+hQDhvX4QRxEGnLENdEg==
X-Received: by 2002:a1c:1d49:: with SMTP id d70mr9813351wmd.49.1591907377821;
        Thu, 11 Jun 2020 13:29:37 -0700 (PDT)
Received: from tool.localnet ([213.177.199.127])
        by smtp.googlemail.com with ESMTPSA id t14sm6785910wrb.94.2020.06.11.13.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 13:29:37 -0700 (PDT)
From:   Daniel =?ISO-8859-1?Q?Gonz=E1lez?= Cabanelas <dgcbueu@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     sre@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/2 v2] dt-bindings: power: reset: add yaml bindings for LinkStation power off
Date:   Thu, 11 Jun 2020 22:29:22 +0200
Message-ID: <2886932.VqVLtP53aq@tool>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add Linkstation poweroff bindings documentation.=20

Signed-off-by: Daniel Gonz=C3=A1lez Cabanelas <dgcbueu@gmail.com>
=2D--
Changes in v2:
  - Changed the required properties and description to adjust to the new
    driver now enabling the WoL feature on the device.

 .../power/reset/linkstation-poweroff.yaml     | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/linkstati=
on-poweroff.yaml

diff --git a/Documentation/devicetree/bindings/power/reset/linkstation-powe=
roff.yaml b/Documentation/devicetree/bindings/power/reset/linkstation-power=
off.yaml
new file mode 100644
index 0000000000..475eab8225
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/linkstation-poweroff.ya=
ml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/linkstation-poweroff.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Buffalo Linkstation poweroff driver
+
+maintainers:
+  - Daniel Gonz=C3=A1lez Cabanelas <dgcbueu@gmail.com>
+
+description: |
+  This driver is used to add the power off function to some Buffalo
+  LinkStations (ARM MVEBU boards). They use an output pin at the ethernet =
PHY
+  (LED2/INTn) to inform the board if the power off operation must be perfo=
rmed
+  at restart time. This pin is ORed with the power switch and allows the W=
OL=20
+  function to be also used.
+
+  When the power-off handler is called, the ethernet PHY INTn ouptut is se=
t to
+  LOW state. If the restart command is executed then the PHY INTn output i=
s=20
+  forced to HIGH state.
+
+properties:
+  compatible:
+    const: linkstation,power-off
+
+  phy-handle,intn:
+    description: Phandle to a node of the ethernet PHY used for the power
+      function.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - phy-handle,intn
+
+additionalProperties: false
+
+examples:
+  - |
+    poweroff {
+        compatible =3D "linkstation,power-off";
+        phy-handle,intn =3D <&ethphy0>;
+    };
=2D-=20
2.27.0




