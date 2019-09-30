Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14207C231E
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 16:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731441AbfI3OYo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 10:24:44 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33602 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730809AbfI3OYn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2019 10:24:43 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8UEOgav033420;
        Mon, 30 Sep 2019 09:24:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1569853482;
        bh=OdgxqyUdXWuWEOFnd3GhwaGyIsu5p0JZKq2/4UKgGF8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VLZKtMgMtw938/HIg0L5eTppq60iKtYRgt3JytsqwLK+M6G2HHaUxXZGBEcLJbNgU
         +BlwUJaIqSXTPa/eU6jGtc7qU1Ame9ySXSI+i5zgIw++szCv0hOz0MF93H2jZ+PR8E
         +J9ifad/DxkjTPJ8ahJJhvoux+hmQUiqDVlmFJQ8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8UEOgPP115410
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Sep 2019 09:24:42 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 30
 Sep 2019 09:24:42 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 30 Sep 2019 09:24:32 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8UEOfa8062238;
        Mon, 30 Sep 2019 09:24:42 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 2/3] dt: power: Add the bq2515x family dt bindings
Date:   Mon, 30 Sep 2019 09:31:36 -0500
Message-ID: <20190930143137.21624-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.22.0.214.g8dca754b1e
In-Reply-To: <20190930143137.21624-1-dmurphy@ti.com>
References: <20190930143137.21624-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the bindings for the bq25150 and bq25155 500mA
 charging IC from Texas Instruments.

Datasheet:
http://www.ti.com/lit/ds/symlink/bq25150.pdf
http://www.ti.com/lit/ds/symlink/bq25155.pdf

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../bindings/power/supply/bq2515x.txt         | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/bq2515x.txt

diff --git a/Documentation/devicetree/bindings/power/supply/bq2515x.txt b/Documentation/devicetree/bindings/power/supply/bq2515x.txt
new file mode 100644
index 000000000000..98203ab53d44
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/bq2515x.txt
@@ -0,0 +1,48 @@
+Binding for TI bq25150 500-mA Linear charger
+
+The BQ25150 is a highly integrated battery charge management IC that integrates
+the most common functions for wearable devices, namely a charger, an
+output voltage rail, ADC for battery and system monitoring, and
+push-button controller.
+
+Required Properties:
+	- compatible: Should contain one of the following:
+		"ti,bq25150"
+		"ti,bq25155"
+	- reg: int I2c address 0x6b
+	- #address-cells: 1;
+	- #size-cells: = 0;
+
+Optional Properties:
+	- ti,battery-regulation-voltage: integer, maximum charging voltage in mV.
+		Values range from 3600->4600mV
+	- ti,charge-current: integer, maximum charging current in mA.
+		Values range from 50->600mA
+	- reset-gpios: GPIO used for Master reset
+	- low-power-gpios: GPIO used for low power mode of IC.
+	- charge-enable-gpios: GPIO used to turn on and off charging.
+	- pg-gpios: GPIO used for connecting the bq2515x device PG (Power Good)
+		pin.  This pin should be used if possible as this is the
+		recommended way to obtain the charger's input PG state.
+		If this pin is not specified a software-based approach for PG
+		detection is used.
+
+Example
+bq25150@6b {
+	compatible = "ti,bq25150";
+	reg = <0x6b>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	pg-gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
+	low-power-gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>;
+	charge-enable-gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
+
+	ti,charge-current = <300>;
+	ti,battery-regulation-voltage = <4200>;
+};
+
+Reference Datasheet:
+http://www.ti.com/lit/ds/symlink/bq25150.pdf
+http://www.ti.com/lit/ds/symlink/bq25155.pdf
-- 
2.22.0.214.g8dca754b1e

