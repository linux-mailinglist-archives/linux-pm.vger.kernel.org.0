Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5531D2D990E
	for <lists+linux-pm@lfdr.de>; Mon, 14 Dec 2020 14:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408014AbgLNNk1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Dec 2020 08:40:27 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9175 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729832AbgLNNkX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2020 08:40:23 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CvjCm4FR5z15Xwp;
        Mon, 14 Dec 2020 21:39:00 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Mon, 14 Dec 2020 21:39:29 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] power: supply: ab8500_fg: convert comma to semicolon
Date:   Mon, 14 Dec 2020 21:40:00 +0800
Message-ID: <20201214134000.4243-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/power/supply/ab8500_fg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 592a73d4dde6..6594f09c993c 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -857,7 +857,7 @@ static int ab8500_fg_volt_to_capacity(struct ab8500_fg *di, int voltage)
 	const struct abx500_v_to_cap *tbl;
 	int cap = 0;
 
-	tbl = di->bm->bat_type[di->bm->batt_id].v_to_cap_tbl,
+	tbl = di->bm->bat_type[di->bm->batt_id].v_to_cap_tbl;
 	tbl_size = di->bm->bat_type[di->bm->batt_id].n_v_cap_tbl_elements;
 
 	for (i = 0; i < tbl_size; ++i) {
-- 
2.22.0

