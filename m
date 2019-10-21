Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04AC6DF1D9
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 17:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfJUPoH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Oct 2019 11:44:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49026 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726289AbfJUPoH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 21 Oct 2019 11:44:07 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4C2A82344871C2782850;
        Mon, 21 Oct 2019 23:44:02 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Mon, 21 Oct 2019 23:43:53 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhongjiang@huawei.com>
Subject: [PATCH] power: supply: cpcap-charger: Make cpcap_charger_voltage_to_regval static
Date:   Mon, 21 Oct 2019 23:40:07 +0800
Message-ID: <1571672407-58950-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The GCC complains the following case when compiling kernel.

drivers/power/supply/cpcap-charger.c:563:5: warning: symbol 'cpcap_charger_voltage_to_regval' was not declared. Should it be static?

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/power/supply/cpcap-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
index 40d96b8..c0d452e 100644
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -560,7 +560,7 @@ static void cpcap_charger_update_state(struct cpcap_charger_ddata *ddata,
 	dev_dbg(ddata->dev, "state: %s\n", status);
 }
 
-int cpcap_charger_voltage_to_regval(int voltage)
+static int cpcap_charger_voltage_to_regval(int voltage)
 {
 	int offset;
 
-- 
1.7.12.4

