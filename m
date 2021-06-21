Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568173AE94C
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 14:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhFUMpV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 08:45:21 -0400
Received: from mx2.tinno.com ([58.61.149.250]:59713 "EHLO spam.tinno.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229736AbhFUMpV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 21 Jun 2021 08:45:21 -0400
X-Greylist: delayed 1700 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Jun 2021 08:45:20 EDT
Received: from spam.tinno.com (localhost [127.0.0.2] (may be forged))
        by spam.tinno.com with ESMTP id 15LCEiLR019249;
        Mon, 21 Jun 2021 20:14:44 +0800 (GMT-8)
        (envelope-from kezhou.li@tinno.com)
Received: from mailbox01.tinno.com (mailbox01.tinno.com [172.16.5.25])
        by spam.tinno.com with ESMTPS id 15LCEVSO019168
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jun 2021 20:14:31 +0800 (GMT-8)
        (envelope-from kezhou.li@tinno.com)
Received: from localhost (172.16.63.58) by mailbox01.tinno.com (172.16.5.27)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 21 Jun 2021 20:14:03
 +0800
From:   Kezhou Li <kezhou.li@tinno.com>
To:     <pali@kernel.org>, <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kezhou Li <kezhou.li@tinno.com>
Subject: [External][PATCH] power: supply: bq2415x: fix deadlock in
 bq2415x_set_autotimer
Date:   Mon, 21 Jun 2021 20:14:20 +0800
Message-ID: <1624277660-11440-1-git-send-email-kezhou.li@tinno.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.63.58]
X-ClientProxiedBy: mailbox01.tinno.com (172.16.5.27) To mailbox01.tinno.com
 (172.16.5.27)
X-DNSRBL: 
X-MAIL: spam.tinno.com 15LCEiLR019249
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Kezhou Li" <kezhou.li@tinno.com>

The bq2415x_timer_error called by bq2415x_timer_work when some error
happens, and then calls cancel_delayed_work_sync(&bq->work). Finally
this function is waiting for the work to finish but the work is
waiting for the return of the function. So it causes a deadlock.

Signed-off-by: Kezhou Li <kezhou.li@tinno.com>
---
 drivers/power/supply/bq2415x_charger.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/supply/bq2415x_charger.c
index 5724001..7889edb 100644
--- a/drivers/power/supply/bq2415x_charger.c
+++ b/drivers/power/supply/bq2415x_charger.c
@@ -862,8 +862,6 @@ static void bq2415x_set_autotimer(struct bq2415x_device *bq, int state)
 		schedule_delayed_work(&bq->work, BQ2415X_TIMER_TIMEOUT * HZ);
 		bq2415x_exec_command(bq, BQ2415X_TIMER_RESET);
 		bq->timer_error = NULL;
-	} else {
-		cancel_delayed_work_sync(&bq->work);
 	}
 
 	mutex_unlock(&bq2415x_timer_mutex);
-- 
1.9.1

