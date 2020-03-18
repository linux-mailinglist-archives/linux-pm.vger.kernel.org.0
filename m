Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B965189733
	for <lists+linux-pm@lfdr.de>; Wed, 18 Mar 2020 09:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbgCRIao (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Mar 2020 04:30:44 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36046 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgCRIao (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2020 04:30:44 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02I8UUaG041006;
        Wed, 18 Mar 2020 03:30:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584520230;
        bh=jGa+GktmlDStzmVOTq3HJze3DKU2zZ2qyKfIt2MEWjc=;
        h=From:To:CC:Subject:Date;
        b=VIwNlZNtM2IJ9ZRJQeWs07/yGjX+i5jXirzSLjOYuc3xPOFnKdTU2Quiobr4v1YH+
         dxNW7K3BcaOQGj9JXNer0j/EZ9qTLGI2QsTIMp4TFKlXyM+1Wlncn3uXgoUypwyVfk
         FStEFSqXt6ALPmqVdR3JRznHwk3wlE+9xESFpipk=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02I8UUMF029778;
        Wed, 18 Mar 2020 03:30:30 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 18
 Mar 2020 03:30:30 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 18 Mar 2020 03:30:30 -0500
Received: from a0393675ula.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02I8UQ8E108598;
        Wed, 18 Mar 2020 03:30:27 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <rui.zhang@intel.com>, <robh+dt@kernel.org>,
        <daniel.lezcano@linaro.org>
CC:     <j-keerthy@ti.com>, <amit.kucheria@verdurent.com>,
        <t-kristo@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <mark.rutland@arm.com>
Subject: [PATCH v4 0/4] thermal: k3: Add support for bandgap sensors
Date:   Wed, 18 Mar 2020 14:00:24 +0530
Message-ID: <20200318083028.9984-1-j-keerthy@ti.com>
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

Changes in v4:

  * Fixed comments from Daniel to remove trend function.
  * Mostly cleaned up all the unused variables.
  * Driver from bool to tristate.

Changes in v3:

  * Fixed errors seen with:
    dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml

Changes in v2:

  * Fixed yaml errors
  * renamed am654-industrial-thermal.dtsi to k3-am654-industrial-thermal.dtsi
    to follow the convention for k3 family.

Keerthy (4):
  dt-bindings: thermal: k3: Add VTM bindings documentation
  thermal: k3: Add support for bandgap sensors
  arm64: dts: ti: am654: Add thermal zones
  arm64: dts: ti: am6: Add VTM node

 .../bindings/thermal/ti,am654-thermal.yaml    |  56 ++++
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi    |  11 +
 .../dts/ti/k3-am654-industrial-thermal.dtsi   |  45 +++
 drivers/thermal/Kconfig                       |  11 +
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/k3_bandgap.c                  | 288 ++++++++++++++++++
 6 files changed, 412 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
 create mode 100644 arch/arm64/boot/dts/ti/k3-am654-industrial-thermal.dtsi
 create mode 100644 drivers/thermal/k3_bandgap.c

-- 
2.17.1

