Return-Path: <linux-pm+bounces-20183-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6476EA08977
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 09:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59818168B52
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 08:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DCF2066FD;
	Fri, 10 Jan 2025 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hzYwwVlA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C531AA1D8;
	Fri, 10 Jan 2025 08:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736496180; cv=none; b=MERS71COTlug7zkOeThY2hacn76tRp5rpGNiEICFT0tymxq2yD1YRVCFkqQcqde1OhD1z4RJljl6pbCYkHqB3p3l1muB7OGWWX1e8H1WF6SlvIIKT+x3wme2sOsuS4W62ZNlZ9Ciz5o8PpuRjzAq0ScIVJdr4L43is5UxRAgtPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736496180; c=relaxed/simple;
	bh=+YTpb7gXl5spuvPYUIaSWQ5ZI3af8p65ev/HuMODgb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yq4znUTFWDyxzDqfzoonKisGV68aHC22EXlsTHasDx0DERNPT69IrpJ4V+Zn+FpNH/+eoeDtsVE7TWXWMe/v3C5YyKZUEPL/dHbSrhWZzZBFisXixYL8t6tNXKmjxma1vyy/tVLjV9TAszIFZJhuYzbzj5YcQdvMTN4hJH7uUIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hzYwwVlA; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A6l7ke002131;
	Fri, 10 Jan 2025 03:02:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=CKYYh
	E3mFhlHoXG1QiVgZfhKxYyCyZtVq36+3YqYaGI=; b=hzYwwVlAMwCzUAG54e069
	lJ9V06YKmB3/kolqyU0vAjcHvii7HAuIJPnVbDDztD3i82VIMN4qgdIef0vASp6j
	IUXVZpDD53MySd4H1gxZyEPqUbEBlnavAxcFsJ00eMJvzX3sOvCTuRE5apBsUPmC
	YnlzbsfXb4ZyFT8T/y/8xsh0i7cDdDmKIg3/RKw5V67Hjtt1+eZ/aSKU/uSCILR2
	v1qWi9OdApfd5u1EqBB5n9sOGdw3q6ySj/Rr0r9nMhjZ2kkDZSiABKp46xrR/TlL
	lo9qvYxByT7YFQuYpoD7HvDmQV5LOAYIVk6EZcoJ2YdKGhOdhsvRMTVfe9AGo0y0
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 442mavap8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 03:02:55 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 50A82sWj053907
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 10 Jan 2025 03:02:54 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 10 Jan
 2025 03:02:54 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 10 Jan 2025 03:02:54 -0500
Received: from JGERONI2-L01.ad.analog.com (JGERONI2-L01.ad.analog.com [10.117.223.12])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50A82hMI006597;
	Fri, 10 Jan 2025 03:02:50 -0500
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH 1/2] dt-bindings: power: supply: add adi,lt8491.yaml
Date: Fri, 10 Jan 2025 16:02:34 +0800
Message-ID: <20250110080235.54808-2-johnerasmusmari.geronimo@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250110080235.54808-1-johnerasmusmari.geronimo@analog.com>
References: <20250110080235.54808-1-johnerasmusmari.geronimo@analog.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: SuK_j1r4H5FS192RXgVmRKbMj_ZY72gv
X-Proofpoint-GUID: SuK_j1r4H5FS192RXgVmRKbMj_ZY72gv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 clxscore=1011 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100065

Add documentation for devicetree bindings for LT8491

Signed-off-by: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
---
 .../bindings/power/supply/adi,lt8491.yaml     | 89 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/adi,lt8491.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/adi,lt8491.yaml b/Documentation/devicetree/bindings/power/supply/adi,lt8491.yaml
new file mode 100644
index 000000000..1451fa1d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/adi,lt8491.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/adi,lt8491.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Linear Technology (Analog Devices) LT8491 Battery Charger
+
+maintainers:
+  - John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
+
+description: |
+  The LT8491 is a buck-boost switching regulator battery charger that implements
+  a constant-current constant-voltage (CCCV) charging profile used for most
+  battery types, including sealed lead-acid (SLA), flooded, gel and lithium-ion.
+
+  Specifications about the charger can be found at:
+    https://www.analog.com/en/products/lt8491.html
+
+properties:
+  compatible:
+    enum:
+      - adi,lt8491
+
+  reg:
+    maxItems: 1
+
+  adi,rsense1-micro-ohms:
+    description: Resistance value of RSENSE1 in micro ohms.
+
+  adi,rimon-out-ohms:
+    description: Resistance value of RIMON_OUT in ohms.
+
+  adi,rsense2-micro-ohms:
+    description: Resistance value of RSENSE2 in micro ohms.
+
+  adi,rdaco-ohms:
+    description: Resistance value of RDACO1 + RDACO2 in ohms.
+
+  adi,rfbout1-ohms:
+    description: Resistance value of RFBOUT1 in ohms.
+
+  adi,rfbout2-ohms:
+    description: Resistance value of RFBOUT2 in ohms.
+
+  adi,rdaci-ohms:
+    description: Resistance value of RDACI1 + RDACI2 in ohms.
+
+  adi,rfbin2-ohms:
+    description: Resistance value of RFBIN2 in ohms.
+
+  adi,rfbin1-ohms:
+    description: Resistance value of RFBIN1 in ohms.
+
+required:
+  - compatible
+  - reg
+  - adi,rsense1-micro-ohms
+  - adi,rimon-out-ohms
+  - adi,rsense2-micro-ohms
+  - adi,rdaco-ohms
+  - adi,rfbout1-ohms
+  - adi,rfbout2-ohms
+  - adi,rdaci-ohms
+  - adi,rfbin2-ohms
+  - adi,rfbin1-ohms
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        battery-charger@10 {
+            compatible = "adi,lt8491";
+            reg = <0x10>;
+            adi,rsense1-micro-ohms = <5000>;
+            adi,rimon-out-ohms = <124000>;
+            adi,rsense2-micro-ohms = <3000>;
+            adi,rdaco-ohms = <64900>;
+            adi,rfbout1-ohms = <113000>;
+            adi,rfbout2-ohms = <10000>;
+            adi,rdaci-ohms = <7000>;
+            adi,rfbin2-ohms = <3480>;
+            adi,rfbin1-ohms = <102000>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 6e04c83eb..96f510358 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13559,6 +13559,12 @@ L:	linux-scsi@vger.kernel.org
 S:	Maintained
 F:	drivers/scsi/sym53c8xx_2/
 
+LT8491 BATTERY CHARGER DRIVER
+M:	John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/supply/adi,lt8491.yaml
+
 LTC1660 DAC DRIVER
 M:	Marcus Folkesson <marcus.folkesson@gmail.com>
 L:	linux-iio@vger.kernel.org
-- 
2.34.1


