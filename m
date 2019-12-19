Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEC012595A
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 02:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfLSBqM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 20:46:12 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:40196 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbfLSBqM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Dec 2019 20:46:12 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CA6E66EA38BA326ABEE9;
        Thu, 19 Dec 2019 09:46:08 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Thu, 19 Dec 2019 09:46:01 +0800
From:   Ma Feng <mafeng.ma@huawei.com>
To:     Sebastian Reichel <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ma Feng <mafeng.ma@huawei.com>
Subject: [PATCH 3/3] power: supply: abx500_chargalg: Remove unneeded semicolon
Date:   Thu, 19 Dec 2019 09:46:31 +0800
Message-ID: <1576719991-109247-3-git-send-email-mafeng.ma@huawei.com>
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

drivers/power/supply/abx500_chargalg.c:1826:2-3: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ma Feng <mafeng.ma@huawei.com>
---
 drivers/power/supply/abx500_chargalg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/abx500_chargalg.c b/drivers/power/supply/abx500_chargalg.c
index e6e37d4..2fb33a0 100644
--- a/drivers/power/supply/abx500_chargalg.c
+++ b/drivers/power/supply/abx500_chargalg.c
@@ -1823,7 +1823,7 @@ static ssize_t abx500_chargalg_en_store(struct abx500_chargalg *di,
 			"Enter 0. Disable AC/USB Charging\n"
 			"1. Enable AC charging\n"
 			"2. Enable USB Charging\n");
-	};
+	}
 	return strlen(buf);
 }
 
-- 
2.6.2

