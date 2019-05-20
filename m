Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60A82230B1
	for <lists+linux-pm@lfdr.de>; Mon, 20 May 2019 11:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbfETJvF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 May 2019 05:51:05 -0400
Received: from inva021.nxp.com ([92.121.34.21]:38404 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730435AbfETJvE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 May 2019 05:51:04 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5B08F20017C;
        Mon, 20 May 2019 11:51:02 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8BD2D20016E;
        Mon, 20 May 2019 11:50:56 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 35546402DF;
        Mon, 20 May 2019 17:50:49 +0800 (SGT)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH v4 2/3] Documentation: dt: binding: fsl: Add 'little-endian' and update Chassis define
Date:   Mon, 20 May 2019 17:52:37 +0800
Message-Id: <20190520095238.29210-2-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190520095238.29210-1-ran.wang_1@nxp.com>
References: <20190520095238.29210-1-ran.wang_1@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

By default, QorIQ SoC's RCPM register block is Big Endian. But
there are some exceptions, such as LS1088A and LS2088A, are Little
Endian. So add this optional property to help identify them.

Actually LS2021A and other Layerscapes won't totally follow Chassis
2.1, so separate them from powerpc SoC.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Change in v4:
	- Adjust indectation of 'ls1021a, ls1012a, ls1043a, ls1046a'.

Change in v3:
	- None.

Change in v2:
	- None.

 Documentation/devicetree/bindings/soc/fsl/rcpm.txt |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
index e284e4e..058154c 100644
--- a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
+++ b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
@@ -20,6 +20,7 @@ Required properites:
 	* "fsl,qoriq-rcpm-1.0": for chassis 1.0 rcpm
 	* "fsl,qoriq-rcpm-2.0": for chassis 2.0 rcpm
 	* "fsl,qoriq-rcpm-2.1": for chassis 2.1 rcpm
+	* "fsl,qoriq-rcpm-2.1+": for chassis 2.1+ rcpm
 
 All references to "1.0" and "2.0" refer to the QorIQ chassis version to
 which the chip complies.
@@ -27,7 +28,12 @@ Chassis Version		Example Chips
 ---------------		-------------------------------
 1.0				p4080, p5020, p5040, p2041, p3041
 2.0				t4240, b4860, b4420
-2.1				t1040, ls1021
+2.1				t1040,
+2.1+				ls1021a, ls1012a, ls1043a, ls1046a
+
+Optional properties:
+ - little-endian : RCPM register block is Little Endian. Without it RCPM
+   will be Big Endian (default case).
 
 Example:
 The RCPM node for T4240:
-- 
1.7.1

