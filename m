Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695661C6F9B
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 13:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgEFLqN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 07:46:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3866 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725887AbgEFLqN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 6 May 2020 07:46:13 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 00E935DF7238A183430A;
        Wed,  6 May 2020 19:46:12 +0800 (CST)
Received: from huawei.com (10.67.174.156) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 6 May 2020
 19:46:02 +0800
From:   ChenTao <chentao107@huawei.com>
To:     <t.schramm@manjaro.org>, <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chentao107@huawei.com>
Subject: [PATCH -next] power/supply/cw2015: Make some symbols static
Date:   Wed, 6 May 2020 19:45:18 +0800
Message-ID: <20200506114519.238186-1-chentao107@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.156]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix the following warning:

drivers/power/supply/cw2015_battery.c:96:5: warning:
'cw_update_profile' was not declared. Should it be static?
drivers/power/supply/cw2015_battery.c:712:1: warning:
'cw_bat_pm_ops' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: ChenTao <chentao107@huawei.com>
---
 drivers/power/supply/cw2015_battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
index 8603da6f4593..19f62ea957ee 100644
--- a/drivers/power/supply/cw2015_battery.c
+++ b/drivers/power/supply/cw2015_battery.c
@@ -93,7 +93,7 @@ static int cw_read_word(struct cw_battery *cw_bat, u8 reg, u16 *val)
 	return 0;
 }
 
-int cw_update_profile(struct cw_battery *cw_bat)
+static int cw_update_profile(struct cw_battery *cw_bat)
 {
 	int ret;
 	unsigned int reg_val;
@@ -709,7 +709,7 @@ static int __maybe_unused cw_bat_resume(struct device *dev)
 	return 0;
 }
 
-SIMPLE_DEV_PM_OPS(cw_bat_pm_ops, cw_bat_suspend, cw_bat_resume);
+static SIMPLE_DEV_PM_OPS(cw_bat_pm_ops, cw_bat_suspend, cw_bat_resume);
 
 static int cw_bat_remove(struct i2c_client *client)
 {
-- 
2.22.0

