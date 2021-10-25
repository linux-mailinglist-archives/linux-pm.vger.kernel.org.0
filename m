Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30AB8439E13
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 20:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbhJYSIg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 14:08:36 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41184 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbhJYSIg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Oct 2021 14:08:36 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19PI69Kr004910;
        Mon, 25 Oct 2021 13:06:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1635185169;
        bh=Yrd+yUTsbGR89/ahPzrGQ0VTae+vnDUBOTH+jtgHwAI=;
        h=From:To:CC:Subject:Date;
        b=SzwAZBYDdmRMf9SVzBRaPjl5FaKKVAcBsco8Z8Yu0zNZDLHVX61N+nJQWBO3r/dYa
         WlhyINMQkXHK+2a6F1lnfWX32WixqdLgwktGsIE8IgMIsqywPSWIM+mE/swbehkLp0
         rp/ViIec5NAdzf3Kg6q9abtVNkZlgqtuWNNW21Mg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19PI69pm071970
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Oct 2021 13:06:09 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 25
 Oct 2021 13:06:09 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 25 Oct 2021 13:06:08 -0500
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19PI65CT056165;
        Mon, 25 Oct 2021 13:06:06 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <robh+dt@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <amitk@kernel.org>, <kristo@kernel.org>
CC:     <j-keerthy@ti.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/4]  thermal: k3_j72xx_bandgap: Add the bandgap driver support
Date:   Mon, 25 Oct 2021 23:35:59 +0530
Message-ID: <20211025180603.22290-1-j-keerthy@ti.com>
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

Changes in v3:

  * Removed static look up tables & added functions to dynamically generate them.


Changes in v2:

  * Fixed DT binding errors.

Keerthy (4):
  dt-bindings: thermal: k3-j72xx: Add VTM bindings documentation
  arm64: dts: ti: j721e: Add VTM node
  arm64: dts: ti: j7200: Add VTM node
  thermal: k3_j72xx_bandgap: Add the bandgap driver support

 .../bindings/thermal/ti,j72xx-thermal.yaml    |  62 ++
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      |   9 +
 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi  |  45 ++
 arch/arm64/boot/dts/ti/k3-j7200.dtsi          |   4 +
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |   9 +
 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi  |  73 ++
 arch/arm64/boot/dts/ti/k3-j721e.dtsi          |   4 +
 drivers/thermal/Makefile                      |   2 +-
 drivers/thermal/k3_j72xx_bandgap.c            | 635 ++++++++++++++++++
 9 files changed, 842 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-thermal.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-thermal.dtsi
 create mode 100644 drivers/thermal/k3_j72xx_bandgap.c

-- 
2.17.1

