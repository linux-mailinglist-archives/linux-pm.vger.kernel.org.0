Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662092CA2F1
	for <lists+linux-pm@lfdr.de>; Tue,  1 Dec 2020 13:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbgLAMld (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Dec 2020 07:41:33 -0500
Received: from comms.puri.sm ([159.203.221.185]:35408 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729872AbgLAMlc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Dec 2020 07:41:32 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 2D3E7E0424;
        Tue,  1 Dec 2020 04:40:22 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SAy1r9kj4rRw; Tue,  1 Dec 2020 04:40:21 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, georgi.djakov@linaro.org,
        cdleonard@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2 4/7] dt-bindings: mxsfb: Add interconnect bindings for LCDIF path
Date:   Tue,  1 Dec 2020 13:39:29 +0100
Message-Id: <20201201123932.12312-5-martin.kepplinger@puri.sm>
In-Reply-To: <20201201123932.12312-1-martin.kepplinger@puri.sm>
References: <20201201123932.12312-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add optional interconnect properties for the dram path requests.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 Documentation/devicetree/bindings/display/mxsfb.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/mxsfb.txt b/Documentation/devicetree/bindings/display/mxsfb.txt
index c985871c46b3..d494a2674290 100644
--- a/Documentation/devicetree/bindings/display/mxsfb.txt
+++ b/Documentation/devicetree/bindings/display/mxsfb.txt
@@ -15,6 +15,12 @@ Required properties:
     - "pix" for the LCDIF block clock
     - (MX6SX-only) "axi", "disp_axi" for the bus interface clock
 
+Optional properties:
+- interconnects : interconnect path specifier for LCDIF according to
+		Documentation/devicetree/bindings/interconnect/interconnect.txt.
+- interconnect-names: the name describing the interconnect path.
+		Should be "dram" for i.MX8MQ.
+
 Required sub-nodes:
   - port: The connection to an encoder chip.
 
-- 
2.20.1

