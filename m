Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B13CC15BCB3
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 11:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbgBMKZR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 05:25:17 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37374 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbgBMKZR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2020 05:25:17 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01DAOv5H103276;
        Thu, 13 Feb 2020 04:24:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581589497;
        bh=txHZv0otXJyIYJZzcbb6130T3NOshgUyHxIn6qc3fv8=;
        h=From:To:CC:Subject:Date;
        b=JNxjVO4sms3FgjgLVnw0JAYNTpfkMkN7+WW1ldfXT9hbEMoNxMqawc6QIjVPv5RV9
         LiOS/P3uNmwyNynXRZt7PC7EwXIiURd2zR5m1qhtanO+DTjrliLQIdu6jcOu6WKkm9
         /TpDSuUL1wHXuOSMXPoLfgQFf4U50jjtV5XQrkq0=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01DAOvEl074336
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Feb 2020 04:24:57 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 13
 Feb 2020 04:24:56 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 13 Feb 2020 04:24:56 -0600
Received: from a0393675ula.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01DAOqpX011317;
        Thu, 13 Feb 2020 04:24:53 -0600
From:   Keerthy <j-keerthy@ti.com>
To:     <rui.zhang@intel.com>, <robh+dt@kernel.org>,
        <daniel.lezcano@linaro.org>
CC:     <j-keerthy@ti.com>, <amit.kucheria@verdurent.com>,
        <t-kristo@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <mark.rutland@arm.com>
Subject: [PATCH 0/4] thermal: k3: Add support for bandgap sensors
Date:   Thu, 13 Feb 2020 15:54:36 +0530
Message-ID: <20200213102440.20539-1-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add VTM thermal support. In the Voltage Thermal
Management Module(VTM), K3 AM654 supplies a voltage
reference and a temperature sensor feature that are gathered in the band
gap voltage and temperature sensor (VBGAPTS) module. The band
gap provides current and voltage reference for its internal
circuits and other analog IP blocks. The analog-to-digital
converter (ADC) produces an output value that is proportional
to the silicon temperature.

Add support for bandgap sensors. Currently reading temperatures
and trend computing is supported. 

Keerthy (4):
  dt-bindings: thermal: k3: Add VTM bindings documentation
  thermal: k3: Add support for bandgap sensors
  arm64: dts: ti: am654: Add thermal zones
  arm64: dts: ti: am6: Add VTM node

 .../bindings/thermal/ti,am654-thermal.yaml    |  59 +++
 .../boot/dts/ti/am654-industrial-thermal.dtsi |  45 +++
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi    |  11 +
 drivers/thermal/Kconfig                       |  12 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/k3_bandgap.c                  | 342 ++++++++++++++++++
 6 files changed, 470 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
 create mode 100644 arch/arm64/boot/dts/ti/am654-industrial-thermal.dtsi
 create mode 100644 drivers/thermal/k3_bandgap.c

-- 
2.17.1

