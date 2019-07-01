Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 502FA5BDC4
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2019 16:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbfGAONI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jul 2019 10:13:08 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46886 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbfGAONI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2019 10:13:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id e5so7407040pls.13;
        Mon, 01 Jul 2019 07:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ABKX75OjoI/drYi7g1T9gujM5GgZzvWrhlpWZ5iT72I=;
        b=HfuK/NeDPjSzXaiehf3+R9ap0zoStELMasKK9LEPlnFCnePRrf4BoU+7c4M4IWT9Wi
         H9pK+PMAXGBcmMHfGsxHUMdIHS3Ka7TuPHiy+tvr1C4HZ1jvRRO8y2nvVOxmmcd3BX/d
         /ZcNei6CvUgAUk4D3fehlq+zlSunMPs62VfadgOyyEJpPne5Tv1ZA9wDYn8L9ZIHO1y5
         tVtZ2tCbqO3qx/eynkJ/WdjrTsLbwaw32/iIFFOJ3Gsh0u6MeE24+2cBBNvDoztUsDiw
         1/Ps9eXbOwuMlJ6WB/EbDXFXJDZlKCW/ZikM/S4Q8w9oiKmqUgvBbp0isCNQOF0NQ8Fg
         4tWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ABKX75OjoI/drYi7g1T9gujM5GgZzvWrhlpWZ5iT72I=;
        b=OizoRhc3Bf0xuMCV52yAluU/HcSkAyp0gPyea/awTOCUCZRJaDvzGTTL3acAc9xuf6
         Ht0MAHqSQ7T01obgrRSyFgWNvdnBbY4DCSJOaTK1/lQulwQSUrYXx2fnEShII2+fsF9x
         R0krmBNjsLJboxcr7cEX8F3h7s3hOBM3hUXvTPvntFQhsM/buLTbJHQabD+C2ic4Uwjy
         cxBZyreKuvkSIO6/DDeBDJtw/bR3LDJy1n4R132QluTF4qtPtJ08ORQn63qjNE+2rgq+
         JAaUpKAhqF5R6w7HLvHTa4NceNPBOoBB/ALTxWmsXMIYM235s3TWMcU1alGGaw1Lilzl
         4jTw==
X-Gm-Message-State: APjAAAWUmpH8b4vwTrn2uXqSliGAoukdNRd6Qi2slZxJnIKI/fhixYou
        ep4WPWZtCFGwYuYfHqsSj1A=
X-Google-Smtp-Source: APXvYqymfe41rO+LAzdfCkwWUQVxxkz33YfcMQpy8dexI8rEYYWxAOyBNTmHwUINZ2slQh41R1MYEQ==
X-Received: by 2002:a17:902:2aa9:: with SMTP id j38mr28101901plb.206.1561990387588;
        Mon, 01 Jul 2019 07:13:07 -0700 (PDT)
Received: from mita-MS-7A45.lan ([240f:34:212d:1:368e:e048:68f1:84e7])
        by smtp.gmail.com with ESMTPSA id n19sm11383871pfa.11.2019.07.01.07.13.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Jul 2019 07:13:07 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Rob Herring <robh@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v5 2/4] dt-bindings: thermal: nvme: Add binding documentation
Date:   Mon,  1 Jul 2019 23:12:32 +0900
Message-Id: <1561990354-4084-3-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561990354-4084-1-git-send-email-akinobu.mita@gmail.com>
References: <1561990354-4084-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add thermal binding documentation for NVMe temperature sensor.

Cc: Rob Herring <robh@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Kenneth Heitke <kenneth.heitke@intel.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v5
- New patch

 Documentation/devicetree/bindings/thermal/nvme.txt | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/nvme.txt

diff --git a/Documentation/devicetree/bindings/thermal/nvme.txt b/Documentation/devicetree/bindings/thermal/nvme.txt
new file mode 100644
index 0000000..60b90de
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/nvme.txt
@@ -0,0 +1,56 @@
+Binding for NVMe temperature sensor
+
+An NVMe controller reports up to nine temperature values in the SMART / Health
+log.
+
+Required properties:
+- reg: A five-cell address encoded as (phys.hi phys.mid phys.lo size.hi
+  size.lo). phys.hi should contain the device's BDF (Bus/Device/Function)
+  as 0b00000000 bbbbbbbb dddddfff 00000000. The other cells should be zero.
+  See also Documentation/devicetree/bindings/pci/pci.txt
+
+- #thermal-sensor-cells: Must be 1. See ./thermal.txt for a description.
+  In the thermal-sensors property, the sensor ID 0 for composite temperature,
+  1 through 8 for NVMe temperature sensor N.
+
+Example:
+
+&pcie0 {
+	...
+	nvme: nvme@0,0 {
+		reg = <0x0000 0 0 0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+
+		nvmetemp: nvmetemp {
+			reg = <0x0000 0 0 0 0>; /* DEVFN = 0x00 (0:0) */
+			#thermal-sensor-cells = <1>;
+		};
+	};
+};
+
+&thermal_zones {
+	nvme_thermal: nvme {
+		polling-delay-passive = <2000>; /* milliseconds */
+		polling-delay = <0>; /* asynchronous event driven */
+
+				/* sensor	ID */
+		thermal-sensors = <&nvmetemp	0>;
+
+		trips {
+			nvme_alert0: nvme_alert0 {
+				temperature = <80000>; /* millicelsius */
+				hysteresis = <2000>; /* millicelsius */
+				type = "passive";
+			};
+		};
+
+		cooling-maps {
+			map0 {
+				trip = <&nvme_alert0>;
+				cooling-device =
+				<&fan0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+			};
+		};
+	};
+};
-- 
2.7.4

