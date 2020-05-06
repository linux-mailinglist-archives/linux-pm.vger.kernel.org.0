Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230CB1C6590
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 03:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbgEFBgQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 May 2020 21:36:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44100 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729647AbgEFBgP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 5 May 2020 21:36:15 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 46E85C72239DDB71EF6C;
        Wed,  6 May 2020 09:36:11 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Wed, 6 May 2020 09:36:00 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Micha Mirosaw <mirq-linux@rere.qmqm.pl>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-pm@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] power: supply: bq25890_charger: fix missing unlock on error in bq25890_resume()
Date:   Wed, 6 May 2020 01:40:08 +0000
Message-ID: <20200506014008.59755-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the missing unlock before return from function bq25890_resume()
in the error handling case.

Fixes: 72d9cd9cdc18 ("power: bq25890: protect view of the chip's state")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/power/supply/bq25890_charger.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 9339e216651f..cd9c5ed9bc0c 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -977,14 +977,18 @@ static int bq25890_resume(struct device *dev)
 	mutex_lock(&bq->lock);
 
 	ret = bq25890_get_chip_state(bq, &bq->state);
-	if (ret < 0)
+	if (ret < 0) {
+		mutex_unlock(&bq->lock);
 		return ret;
+	}
 
 	/* Re-enable ADC only if charger is plugged in. */
 	if (bq->state.online) {
 		ret = bq25890_field_write(bq, F_CONV_START, 1);
-		if (ret < 0)
+		if (ret < 0) {
+			mutex_unlock(&bq->lock);
 			return ret;
+		}
 	}
 
 	/* signal userspace, maybe state changed while suspended */



