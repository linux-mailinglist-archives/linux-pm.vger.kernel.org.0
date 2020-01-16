Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64A8A13EBFD
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 18:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732916AbgAPRyD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 12:54:03 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49994 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394450AbgAPRxo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 12:53:44 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00GHreoJ007619;
        Thu, 16 Jan 2020 11:53:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579197220;
        bh=iaXTo2WLoSeG9gSntibFwuA1dkUbJiAzx2kVpo1emsw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wRgJjSBf9g9pu+pI93Qu74RVO7ZWg6+U99QhTXu7WYHzB0ZkRyaxNcZcz32uwhia0
         eG/R+g+Vq8uSQ2J+F8m8ucKG9OUo/Lo9NbavQpPyVDZ5MF6Gs//bd2sYUqlm3bj7gO
         3233fTGt/MqBikg5buGXVtgabrQv2vJEqfiTSUYc=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00GHre8F128703
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Jan 2020 11:53:40 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 16
 Jan 2020 11:53:40 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 16 Jan 2020 11:53:40 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00GHre4S002991;
        Thu, 16 Jan 2020 11:53:40 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <sebastian.reichel@collabora.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v4 1/4] power: supply: core: Update sysfs-class-power ABI document
Date:   Thu, 16 Jan 2020 11:50:36 -0600
Message-ID: <20200116175039.1317-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116175039.1317-1-dmurphy@ti.com>
References: <20200116175039.1317-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the "Over Current" string to /sys/class/power_supply/<supply_name>/health
description.

Fixes: e3e83cc601e57 ("power: supply: core: Add POWER_SUPPLY_HEALTH_OVERCURRENT constant")
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 Documentation/ABI/testing/sysfs-class-power | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 27edc06e2495..bf3b48f022dc 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -189,7 +189,8 @@ Description:
 		Access: Read
 		Valid values: "Unknown", "Good", "Overheat", "Dead",
 			      "Over voltage", "Unspecified failure", "Cold",
-			      "Watchdog timer expire", "Safety timer expire"
+			      "Watchdog timer expire", "Safety timer expire",
+			      "Over current"
 
 What:		/sys/class/power_supply/<supply_name>/precharge_current
 Date:		June 2017
-- 
2.25.0

