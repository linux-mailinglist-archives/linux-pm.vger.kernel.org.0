Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360E41B8E83
	for <lists+linux-pm@lfdr.de>; Sun, 26 Apr 2020 11:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgDZJnb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Apr 2020 05:43:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33930 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726251AbgDZJnb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 26 Apr 2020 05:43:31 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EC4C64095CE78C2A81DE;
        Sun, 26 Apr 2020 17:43:29 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Sun, 26 Apr 2020
 17:43:23 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <sre@kernel.org>, <linus.walleij@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] power: supply: ab8500_fg: remove comparison to bool
Date:   Sun, 26 Apr 2020 17:42:50 +0800
Message-ID: <20200426094250.23995-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix the following coccicheck warning:

drivers/power/supply/ab8500_fg.c:2402:5-24: WARNING: Comparison to bool

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/power/supply/ab8500_fg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index b96f90a82ecf..751c4f6c7487 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2399,7 +2399,7 @@ static void ab8500_fg_reinit_work(struct work_struct *work)
 	struct ab8500_fg *di = container_of(work, struct ab8500_fg,
 		fg_reinit_work.work);
 
-	if (di->flags.calibrate == false) {
+	if (!di->flags.calibrate) {
 		dev_dbg(di->dev, "Resetting FG state machine to init.\n");
 		ab8500_fg_clear_cap_samples(di);
 		ab8500_fg_calc_cap_discharge_voltage(di, true);
-- 
2.21.1

