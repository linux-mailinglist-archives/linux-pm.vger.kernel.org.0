Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62A18632A7
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2019 10:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfGIIJm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jul 2019 04:09:42 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56376 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfGIIJm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Jul 2019 04:09:42 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 955721A053B;
        Tue,  9 Jul 2019 10:09:40 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 666491A0DBF;
        Tue,  9 Jul 2019 10:09:27 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id CBEE3402DF;
        Tue,  9 Jul 2019 16:09:13 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        leonard.crestez@nxp.com, p.zabel@pengutronix.de, ping.bai@nxp.com,
        daniel.baluta@nxp.com, l.stach@pengutronix.de, abel.vesa@nxp.com,
        angus@akkea.ca, andrew.smirnov@gmail.com, ccaione@baylibre.com,
        agx@sigxcpu.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 1/4] dt-bindings: opp: Support multiple opp-suspend properties
Date:   Tue,  9 Jul 2019 16:00:12 +0800
Message-Id: <20190709080015.43442-1-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Update opp-suspend property's description to support multiple
opp-suspend properties defined in DT, the OPP with highest opp-hz
and with opp-suspend property present will be used as suspend opp.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
New patch.
---
 Documentation/devicetree/bindings/opp/opp.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
index 76b6c79..6859227 100644
--- a/Documentation/devicetree/bindings/opp/opp.txt
+++ b/Documentation/devicetree/bindings/opp/opp.txt
@@ -140,8 +140,8 @@ Optional properties:
   frequency for a short duration of time limited by the device's power, current
   and thermal limits.
 
-- opp-suspend: Marks the OPP to be used during device suspend. Only one OPP in
-  the table should have this.
+- opp-suspend: Marks the OPP to be used during device suspend. If multiple OPPs
+  in the table have this, the OPP with highest opp-hz will be used.
 
 - opp-supported-hw: This enables us to select only a subset of OPPs from the
   larger OPP table, based on what version of the hardware we are running on. We
-- 
2.7.4

