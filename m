Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785691F82FA
	for <lists+linux-pm@lfdr.de>; Sat, 13 Jun 2020 12:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgFMKa7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Jun 2020 06:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgFMK2S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 13 Jun 2020 06:28:18 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30683C08C5C1;
        Sat, 13 Jun 2020 03:28:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l10so12311458wrr.10;
        Sat, 13 Jun 2020 03:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CfKhED64oLaPofTx2Q7mRbBkPCUu8RE1WsA06aG6ESQ=;
        b=Adt+01OvZnlV1RrvecuxyW4SEA4dZnanaqeAD41hygNms9UWj7AcThLg828cVnoK76
         MIOPqAmQQindK6CQg4QwyhWb7qLXGjRU2QB9qXnIe7a1BvcaRCyLFFyK4JTbVwmq+A6J
         0zDo9uoYxRbBTZEE9w74rgFg7emd/7FN91mT4YXdz9v6zCunO4FWLqznBN1rKBKfpZ0U
         tYYPXGutKTEXj/oIrWBGDlHNeCnMIhhvxIci5eObxsaTevG8ruC+6QiNEMwOENWWEsCL
         hmxIRqCvzv076BcN1mfPOPQZvKohmo4o36KsC6WNWk+eyk95sMedFYh0ZHRnc+fA88vT
         L0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CfKhED64oLaPofTx2Q7mRbBkPCUu8RE1WsA06aG6ESQ=;
        b=VWb0PGxvOR/uDxT6cbraTmRRWohXDJuQIe+Cw6gdASrKSvfaygSGObnAqMt8qqgFVP
         LR3JqwUUdf1qCFOgsDFkfQEHkVtOwQ7wPNBYUSj2QvF/Rqb6Ry47KaTuuYbahdM9nO7B
         IGM9SbjaEEjMJfKsTu8rNWudQlsqr+H1EqE62qDO7a1qYOq3OdS5Via2beiHCCKcsAP7
         6aeM5M/DyLm4RZNJo7v4HcyGUTBRbl4d8YxjdD1FHKbeTbYaSwY9qMHv5WN1tN9LCdHh
         KX8D0gHGb7cBoVNQBKXvcEqoZEv4Mgui1lDVhxzvOB/cjBs+QUVfgFIwPatWl5XUbCMn
         yc2w==
X-Gm-Message-State: AOAM530YiPZm2pWZ/erVuE4BDPk4W4nYjR448PD3VrFW5yvERJMlmqhU
        pXP6cO7VzaxDGMgmuteY4u0OoEOP+To=
X-Google-Smtp-Source: ABdhPJzG3+UFV8B8ZsieoRQk27HAWc5kuM0HPqHA+oDPfem17OOJmYmlDXpsZBg20tyrVUQdCDPtNg==
X-Received: by 2002:adf:b355:: with SMTP id k21mr19028713wrd.76.1592044095570;
        Sat, 13 Jun 2020 03:28:15 -0700 (PDT)
Received: from tool.localnet ([213.177.199.127])
        by smtp.googlemail.com with ESMTPSA id v66sm13822310wme.13.2020.06.13.03.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 03:28:14 -0700 (PDT)
From:   Daniel =?ISO-8859-1?Q?Gonz=E1lez?= Cabanelas <dgcbueu@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     sre@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 2/2] dt-bindings: power: reset: add yaml bindings for LinkStation power off
Date:   Sat, 13 Jun 2020 12:26:56 +0200
Message-ID: <2774047.62mrzoXREp@tool>
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
Changes in v3:
  - "phy-handle,intn" property deleted. Now autodetection used.
  - Cosmetic changes
Changes in v2:
  - Changed the required properties and description to adjust to the new
    driver now enabling the WoL feature on the device.

 .../power/reset/linkstation-poweroff.yaml     | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/linkstati=
on-poweroff.yaml

diff --git a/Documentation/devicetree/bindings/power/reset/linkstation-powe=
roff.yaml b/Documentation/devicetree/bindings/power/reset/linkstation-power=
off.yaml
new file mode 100644
index 0000000000..8845333ca4
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/linkstation-poweroff.ya=
ml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/linkstation-poweroff.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Buffalo Linkstation poweroff Binding
+
+maintainers:
+  - Daniel Gonz=C3=A1lez Cabanelas <dgcbueu@gmail.com>
+
+description: |
+  Some Buffalo LinkStations (ARM MVEBU boards) use an output pin at the et=
hernet
+  PHY (LED2/INTn) to inform the board if the power off operation must be p=
erformed
+  at restart time. This pin is ORed with the power switch and allows the W=
OL
+  function to be also used.
+
+  When the power-off handler is called, the ethernet PHY INTn ouptut is se=
t to
+  LOW state. If the restart command is executed then the PHY INTn output is
+  forced to HIGH state.
+
+properties:
+  compatible:
+    const: linkstation,power-off
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
+    };
=2D-=20
2.27.0




