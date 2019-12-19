Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCDE125958
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 02:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfLSBqG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 20:46:06 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7712 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbfLSBqG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Dec 2019 20:46:06 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B14AAB727CA01EDE59BB;
        Thu, 19 Dec 2019 09:46:03 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Thu, 19 Dec 2019 09:45:55 +0800
From:   Ma Feng <mafeng.ma@huawei.com>
To:     Sebastian Reichel <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ma Feng <mafeng.ma@huawei.com>
Subject: [PATCH 2/3] power: supply: ab8500_charger: Remove unneeded semicolon
Date:   Thu, 19 Dec 2019 09:46:30 +0800
Message-ID: <1576719991-109247-2-git-send-email-mafeng.ma@huawei.com>
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1576719991-109247-1-git-send-email-mafeng.ma@huawei.com>
References: <1576719991-109247-1-git-send-email-mafeng.ma@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fixes coccicheck warning:

drivers/power/supply/ab8500_charger.c:1082:2-3: Unneeded semicolon
drivers/power/supply/ab8500_charger.c:792:2-3: Unneeded semicolon
drivers/power/supply/ab8500_charger.c:2430:2-3: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ma Feng <mafeng.ma@huawei.com>
---
 drivers/power/supply/ab8500_charger.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 8a0f9d7..f69550d 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -789,7 +789,7 @@ static int ab8500_charger_max_usb_curr(struct ab8500_charger *di,
 		di->max_usb_in_curr.usb_type_max = USB_CH_IP_CUR_LVL_0P05;
 		ret = -ENXIO;
 		break;
-	};
+	}
 
 	di->max_usb_in_curr.set_max = di->max_usb_in_curr.usb_type_max;
 	dev_dbg(di->dev, "USB Type - 0x%02x MaxCurr: %d",
@@ -1079,7 +1079,7 @@ static int ab8500_charger_get_usb_cur(struct ab8500_charger *di)
 		di->max_usb_in_curr.usb_type_max = USB_CH_IP_CUR_LVL_0P05;
 		ret = -EPERM;
 		break;
-	};
+	}
 	di->max_usb_in_curr.set_max = di->max_usb_in_curr.usb_type_max;
 	return ret;
 }
@@ -2427,7 +2427,7 @@ static void ab8500_charger_usb_state_changed_work(struct work_struct *work)
 
 	default:
 		break;
-	};
+	}
 }
 
 /**
-- 
2.6.2

