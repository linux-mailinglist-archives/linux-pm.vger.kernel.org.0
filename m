Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F95B1B82F4
	for <lists+linux-pm@lfdr.de>; Sat, 25 Apr 2020 03:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgDYBBF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Apr 2020 21:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgDYBBF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2020 21:01:05 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A80C09B049
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 18:01:04 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id k12so4472897wmj.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2020 18:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=19e/LVpgOk6qaDpmJIsv6ccOxNArnGGm2tBYuM7tNNU=;
        b=elmlnGJTxoaWd7Pd9V6pI4Z5pEbckSz6YZTD9lFP6JDAkZ2dZSOf+Z21on/jspgFmI
         b8oIVsrVhFTY3Js8N/VvygSqhzQpVwmXwSWJlt4FNJR5JQtlxRQp+a/QrAw8ZGDqtcsJ
         tRcF2/dzl+NIq8nHklhVT5v5N+PIk/rXNlBUwWNPcsKSEku9gyehblgxp/x8O6lU4ft+
         tPopMuydVQibWn0EYwfcHl8D0zLW1qiy1gXmH/6eHOgH9jC5wZtydJb9p7iD+Pn43TD8
         OHRKSUzWrePopthJ8EHBb3kw/bSYTpiBvUgWZ7NtwRCSe1IdidXOXej2oUtWMxoVqDed
         Ogdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=19e/LVpgOk6qaDpmJIsv6ccOxNArnGGm2tBYuM7tNNU=;
        b=ilRMXHxE1alhjA0L8CbW4CKpFWx+drXuJSxehMPiwzqy5ZHRCONBLz+g7EokvGMD5S
         1j7AhMCbS5Ak35DGwW7MgZKzkdK+OmJINVph+bE1jAnOhBfPxdOD+9+rI9bQi5U3cnLg
         pNh+KLVcdCfZm6hMn2z7b3KNPBhWwknXCWGogwpytbIPxtAJ4A9BwXqEOkqVXNAO6b9Z
         P9xKdyMgd3zi/315zaFvpNxf3bMGgzlCn4u04xAV7g+6TM7IttJNH6bOfqGIw7Ulj7dc
         YQdMTkAw/x4BAV5iBJt0waV1VtUedCQ3nFaCyC81b68/fjysgVne6L4hGKG6uG4RK39+
         KZ/w==
X-Gm-Message-State: AGi0PuYD9ZUFGIDqEZ1uQSZZvBCfaKS9Nnv+vlt6o7kIu+G4AzU3n5bY
        PGJ/poQX623VyjVd/AyGMr9YJ9Tg
X-Google-Smtp-Source: APiQypIS+y25nVZgW9+ck8X8Ps1DESqM63wu8cmrOltVxNhifueFzKoZy1BvqrsaOdHUad2r0wXtfw==
X-Received: by 2002:a05:600c:2f88:: with SMTP id t8mr12764619wmn.46.1587776463377;
        Fri, 24 Apr 2020 18:01:03 -0700 (PDT)
Received: from tool.localnet ([213.177.195.242])
        by smtp.googlemail.com with ESMTPSA id k17sm5093438wmi.10.2020.04.24.18.01.02
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 18:01:02 -0700 (PDT)
From:   Daniel =?ISO-8859-1?Q?Gonz=E1lez?= Cabanelas <dgcbueu@gmail.com>
To:     linux-pm@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: power: reset: add yaml bindings for LinkStation power off
Date:   Sat, 25 Apr 2020 03:01:01 +0200
Message-ID: <23544181.H47qXO15o3@tool>
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
 .../power/reset/linkstation-poweroff.yaml     | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/linkstati=
on-poweroff.yaml

diff --git a/Documentation/devicetree/bindings/power/reset/linkstation-powe=
roff.yaml b/Documentation/devicetree/bindings/power/reset/linkstation-power=
off.yaml
new file mode 100644
index 0000000000..b647baecf3
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/linkstation-poweroff.ya=
ml
@@ -0,0 +1,42 @@
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
+  This driver is used to add the power off function to some Buffalo=20
+  LinkStations (ARM MVEBU boards). They use a LED output pin at the=20
+  ethernet PHY to inform the board if the power off operation must be
+  performed after restarting.
+
+  When the power-off handler is called, the ethernet PHY LED2 ouptut is
+  set to OFF. If the restart command is executed then the PHY LED2 output
+  is asserted to ON.
+
+properties:
+  compatible:
+    const: linkstation,power-off
+
+  phy-handle,led:
+    description: Phandle to a node of the ethernet PHY used for the power=
=20
+      function. If this optional property is not specified, then the first
+      PHY found in the MDIO bus will be used.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    poweroff {
+        compatible =3D "linkstation,power-off";
+        phy-handle,led =3D <&ethphy0>;
+    };
=2D-=20
2.26.2




