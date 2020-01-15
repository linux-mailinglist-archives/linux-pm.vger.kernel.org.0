Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58FE113C373
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 14:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgAONoy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 08:44:54 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9621 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726071AbgAONoy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 Jan 2020 08:44:54 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 29DD0B034D19079293BE;
        Wed, 15 Jan 2020 21:44:51 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Wed, 15 Jan 2020 21:44:44 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH] power: remove unneeded semicolon
Date:   Wed, 15 Jan 2020 21:40:10 +0800
Message-ID: <20200115134010.60385-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fixes coccicheck warning:

./drivers/power/supply/ipaq_micro_battery.c:188:2-3: Unneeded semicolon
./drivers/power/supply/ipaq_micro_battery.c:152:3-4: Unneeded semicolon
./drivers/power/supply/ipaq_micro_battery.c:171:2-3: Unneeded semicolon

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/power/supply/ipaq_micro_battery.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/ipaq_micro_battery.c b/drivers/power/supply/ipaq_micro_battery.c
index 03592ce..192d9db 100644
--- a/drivers/power/supply/ipaq_micro_battery.c
+++ b/drivers/power/supply/ipaq_micro_battery.c
@@ -149,7 +149,7 @@ static int micro_batt_get_property(struct power_supply *b,
 		default:
 			val->intval = POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
 			break;
-		};
+		}
 		break;
 	case POWER_SUPPLY_PROP_STATUS:
 		val->intval = get_status(b);
@@ -168,7 +168,7 @@ static int micro_batt_get_property(struct power_supply *b,
 		break;
 	default:
 		return -EINVAL;
-	};
+	}
 
 	return 0;
 }
@@ -185,7 +185,7 @@ static int micro_ac_get_property(struct power_supply *b,
 		break;
 	default:
 		return -EINVAL;
-	};
+	}
 
 	return 0;
 }
-- 
2.7.4

