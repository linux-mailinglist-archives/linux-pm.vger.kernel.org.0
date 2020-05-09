Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A441CBC9A
	for <lists+linux-pm@lfdr.de>; Sat,  9 May 2020 04:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgEICnS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 22:43:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38056 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728575AbgEICnR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 May 2020 22:43:17 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EF549E9B17E7738F01BD;
        Sat,  9 May 2020 10:43:14 +0800 (CST)
Received: from euler.huawei.com (10.175.101.6) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Sat, 9 May 2020 10:43:06 +0800
From:   Hongbo Yao <yaohongbo@huawei.com>
To:     <sre@kernel.org>
CC:     <yaohongbo@huawei.com>, <chenzhou10@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH -next] power: reset: ltc2952: remove set but used variable
Date:   Sat, 9 May 2020 18:36:11 +0800
Message-ID: <20200509103611.29551-1-yaohongbo@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:
drivers/power/reset/ltc2952-poweroff.c:97:16: warning: variable
‘overruns’ set but not used [-Wunused-but-set-variable]
  unsigned long overruns;

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
---
 drivers/power/reset/ltc2952-poweroff.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset/ltc2952-poweroff.c
index e4a0cc45b3d1..318927938b05 100644
--- a/drivers/power/reset/ltc2952-poweroff.c
+++ b/drivers/power/reset/ltc2952-poweroff.c
@@ -94,7 +94,6 @@ static enum hrtimer_restart ltc2952_poweroff_timer_wde(struct hrtimer *timer)
 {
 	ktime_t now;
 	int state;
-	unsigned long overruns;
 	struct ltc2952_poweroff *data = to_ltc2952(timer, timer_wde);
 
 	if (data->kernel_panic)
@@ -104,7 +103,7 @@ static enum hrtimer_restart ltc2952_poweroff_timer_wde(struct hrtimer *timer)
 	gpiod_set_value(data->gpio_watchdog, !state);
 
 	now = hrtimer_cb_get_time(timer);
-	overruns = hrtimer_forward(timer, now, data->wde_interval);
+	hrtimer_forward(timer, now, data->wde_interval);
 
 	return HRTIMER_RESTART;
 }
-- 
2.20.1

