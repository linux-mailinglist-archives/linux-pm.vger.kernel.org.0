Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F7533F1B3
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 14:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhCQNtz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 09:49:55 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56190 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbhCQNtP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 09:49:15 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 315A61F44A2D
Received: by jupiter.universe (Postfix, from userid 1000)
        id 2A5F848011F; Wed, 17 Mar 2021 14:49:06 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 37/38] dt-bindings: power: supply: Fix remaining battery.txt links
Date:   Wed, 17 Mar 2021 14:49:03 +0100
Message-Id: <20210317134904.80737-38-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210317134904.80737-1-sebastian.reichel@collabora.com>
References: <20210317134904.80737-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/devicetree/bindings/power/supply/battery.txt     | 3 ---
 Documentation/devicetree/bindings/power/supply/bq27xxx.yaml    | 2 +-
 .../devicetree/bindings/power/supply/rohm,bd99954.yaml         | 2 +-
 3 files changed, 2 insertions(+), 5 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/battery.txt

diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
deleted file mode 100644
index a9f80cc49068..000000000000
--- a/Documentation/devicetree/bindings/power/supply/battery.txt
+++ /dev/null
@@ -1,3 +0,0 @@
-The contents of this file has been moved to battery.yaml
-
-Please note that not all charger drivers respect all of the properties.
diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
index 45beefccf31a..4da17065422a 100644
--- a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
@@ -65,7 +65,7 @@ properties:
        - charge-full-design-microamp-hours
        - voltage-min-design-microvolt
        Both or neither of the *-full-design-*-hours properties must be set.
-       See Documentation/devicetree/bindings/power/supply/battery.txt
+       See Documentation/devicetree/bindings/power/supply/battery.yaml
 
   power-supplies: true
 
diff --git a/Documentation/devicetree/bindings/power/supply/rohm,bd99954.yaml b/Documentation/devicetree/bindings/power/supply/rohm,bd99954.yaml
index 9852d2febf65..24b06957b4ca 100644
--- a/Documentation/devicetree/bindings/power/supply/rohm,bd99954.yaml
+++ b/Documentation/devicetree/bindings/power/supply/rohm,bd99954.yaml
@@ -110,7 +110,7 @@ properties:
 #     multipleOf: 64000
 #     a charge cycle terminates when the battery voltage is above recharge
 #     threshold, and the current is below this setting (7 in above chart)
-#   See also Documentation/devicetree/bindings/power/supply/battery.txt
+#   See also Documentation/devicetree/bindings/power/supply/battery.yaml
 
   reg:
     maxItems: 1
-- 
2.30.2

