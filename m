Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63355433BA8
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 18:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbhJSQI7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 12:08:59 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:41142 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbhJSQI7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 12:08:59 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19JG6gwt086746;
        Tue, 19 Oct 2021 11:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1634659602;
        bh=/6hSDYVfbxRDMXK0dyZcJ7b11KcOEEQfrn4mNzvy0ow=;
        h=From:To:CC:Subject:Date;
        b=WyvvNj72pQln7gxgaH1xvk8WvRc1EghZAR0/bA/b4JSwgMXw+KeOXKYnRLRWrEKLV
         3uwcfHg7qojxptPzA460Fcc3wthXvhz/h+MMCHSPaozwdgJhpcuwHJrM9YIxw57oUp
         RIly2RgIaumZK8xEMC1hD5hMO/pwlDZtZguggFhs=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19JG6gEH050391
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Oct 2021 11:06:42 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 19
 Oct 2021 11:06:41 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 19 Oct 2021 11:06:42 -0500
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19JG6cCn005621;
        Tue, 19 Oct 2021 11:06:39 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <robh+dt@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <amitk@kernel.org>, <kristo@kernel.org>
CC:     <j-keerthy@ti.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/4] thermal: k3_j72xx_bandgap: Add the bandgap driver support
Date:   Tue, 19 Oct 2021 21:36:27 +0530
Message-ID: <20211019160631.31192-1-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add VTM thermal support. In the Voltage Thermal Management
Module(VTM), K3 J72XX supplies a voltage reference and a temperature
sensor feature that are gathered in the band gap voltage and
temperature sensor (VBGAPTS) module. The band gap provides current and
voltage reference for its internal circuits and other analog IP
blocks. The analog-to-digital converter (ADC) produces an output value
that is proportional to the silicon temperature.

Currently reading temperatures only is supported.  There are no
active/passive cooling agent supported.

J721e SoCs have errata i2128: https://www.ti.com/lit/pdf/sprz455

The series also incorporates workaround for Errata i2128.

Keerthy (4):
  dt-bindings: thermal: k3-j72xx: Add VTM bindings documentation
  arm64: dts: ti: j721e: Add VTM node
  arm64: dts: ti: j7200: Add VTM node
  thermal: k3_j72xx_bandgap: Add the bandgap driver support

 .../bindings/thermal/ti,j72xx-thermal.yaml    |  62 ++
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      |   9 +
 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi  |  45 +
 arch/arm64/boot/dts/ti/k3-j7200.dtsi          |   4 +
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |   9 +
 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi  |  73 ++
 arch/arm64/boot/dts/ti/k3-j721e.dtsi          |   4 +
 drivers/thermal/Makefile                      |   2 +-
 drivers/thermal/k3_j72xx_bandgap.c            | 772 ++++++++++++++++++
 9 files changed, 979 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi
 create mode 100644 drivers/thermal/k3_j72xx_bandgap.c

-- 
2.17.1

