Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA5D134D32
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 21:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgAHU0J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 15:26:09 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38896 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgAHU0J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 15:26:09 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 008KQ5uv048589;
        Wed, 8 Jan 2020 14:26:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578515165;
        bh=bRLiZQC+afP0FFyxjLUWm3wOocymxs69WM2nUZ0kmtA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xWXLn0E8ZRK+13AiP5O6ruYJ9SAUcKUPyXFNl4hkp06gJFOWRung+Jh4r+UssuO5z
         A2RvXsV7irc1WBIyBhYeG13SVXeQdF+bLDfkFylNArfKzDkO8gMerElCLoYqbWzZLd
         uQk89s0aWiqv5HAhCjjgp5Yfas+LfbDxR7+ALrWo=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 008KQ5Y1036032
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Jan 2020 14:26:05 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Jan
 2020 14:26:05 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Jan 2020 14:26:04 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 008KQ573081928;
        Wed, 8 Jan 2020 14:26:05 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <sebastian.reichel@collabora.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v3 1/4] power: supply: core: Update sysfs-class-power ABI document
Date:   Wed, 8 Jan 2020 14:23:11 -0600
Message-ID: <20200108202314.11791-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200108202314.11791-1-dmurphy@ti.com>
References: <20200108202314.11791-1-dmurphy@ti.com>
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
2.23.0

