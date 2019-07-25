Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A516C7477C
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 08:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfGYGuy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 02:50:54 -0400
Received: from icp-osb-irony-out1.external.iinet.net.au ([203.59.1.210]:59557
        "EHLO icp-osb-irony-out1.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725808AbfGYGuy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 02:50:54 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2A9BwA9UDld/1/rO8tkghmDdhIXE40?=
 =?us-ascii?q?ZiBcBgkMBg1mFU5EZCQEBAQEBAQEBARscAQGEOgSDADcGDgEDAQEBBAEBAQE?=
 =?us-ascii?q?FAW2EZUWGJ3IHaRKDIoF3E64SiHaBSIE0hwmEboFAP4ERgmRshAMKG4VdIgS?=
 =?us-ascii?q?VN5U1CYEld5QSGZgLLYNoh0uBWJljIoFYTR8ZgyeCeY4aNTCLeIJSAQE?=
X-IPAS-Result: =?us-ascii?q?A2A9BwA9UDld/1/rO8tkghmDdhIXE40ZiBcBgkMBg1mFU?=
 =?us-ascii?q?5EZCQEBAQEBAQEBARscAQGEOgSDADcGDgEDAQEBBAEBAQEFAW2EZUWGJ3IHa?=
 =?us-ascii?q?RKDIoF3E64SiHaBSIE0hwmEboFAP4ERgmRshAMKG4VdIgSVN5U1CYEld5QSG?=
 =?us-ascii?q?ZgLLYNoh0uBWJljIoFYTR8ZgyeCeY4aNTCLeIJSAQE?=
X-IronPort-AV: E=Sophos;i="5.64,305,1559491200"; 
   d="scan'208";a="228527497"
Received: from 203-59-235-95.perm.iinet.net.au (HELO rtcentos7.electromag.com.au) ([203.59.235.95])
  by icp-osb-irony-out1.iinet.net.au with ESMTP; 25 Jul 2019 14:50:49 +0800
From:   Richard Tresidder <rtresidd@electromag.com.au>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rtresidd@electromag.com.au, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] dt-bindings: power/supply/sbs_sbs-battery: Addition of force_load binding Add device tree binding documentation for addition of force_load boolean value to allow loading a battery during boot even if not present at that time.
Date:   Thu, 25 Jul 2019 14:50:45 +0800
Message-Id: <1564037445-22936-1-git-send-email-rtresidd@electromag.com.au>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Richard Tresidder <rtresidd@electromag.com.au>
---

Notes:
    Add device tree binding documentation for addition of force_load
    boolean value to allow loading a battery during boot even if not
    present at that time.
    Accompanying patch to drivers/power/supply/sbs-battery.c submitted to linux-pm@vger.kernel.org

 Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
index 4e78e51..187d7bb 100644
--- a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
@@ -15,7 +15,8 @@ Optional properties :
    after an external change notification.
  - sbs,battery-detect-gpios : The gpio which signals battery detection and
    a flag specifying its polarity.
-
+ - sbs,force-load : Allow loading of a hot-pluggable battery when there is no
+   GPIO detect available and the module is statically built.
 Example:
 
 	battery@b {
@@ -24,4 +25,5 @@ Example:
 		sbs,i2c-retry-count = <2>;
 		sbs,poll-retry-count = <10>;
 		sbs,battery-detect-gpios = <&gpio-controller 122 1>;
+		sbs,force-load;
 	}
-- 
1.8.3.1

