Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC0C79EB6
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 04:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731296AbfG3CbF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 22:31:05 -0400
Received: from inva021.nxp.com ([92.121.34.21]:36120 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731282AbfG3CbF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Jul 2019 22:31:05 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5512E200538;
        Tue, 30 Jul 2019 04:31:03 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6CC73200527;
        Tue, 30 Jul 2019 04:30:58 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 26C5D402E0;
        Tue, 30 Jul 2019 10:30:52 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V3 5/5] dt-bindings: thermal: qoriq: Add optional clocks property
Date:   Tue, 30 Jul 2019 10:21:26 +0800
Message-Id: <20190730022126.17883-5-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190730022126.17883-1-Anson.Huang@nxp.com>
References: <20190730022126.17883-1-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Some platforms like i.MX8M series SoCs have clock control for TMU,
add optional clocks property to the binding doc.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
No changes, noted the i.MX8M series SoCs need this clock in commit log.
---
 Documentation/devicetree/bindings/thermal/qoriq-thermal.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
index 04cbb90..28f2cba 100644
--- a/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
@@ -23,6 +23,7 @@ Required properties:
 Optional property:
 - little-endian : If present, the TMU registers are little endian. If absent,
 	the default is big endian.
+- clocks : the clock for clocking the TMU silicon.
 
 Example:
 
-- 
2.7.4

