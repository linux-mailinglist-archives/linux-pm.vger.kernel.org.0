Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08834303A21
	for <lists+linux-pm@lfdr.de>; Tue, 26 Jan 2021 11:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391860AbhAZKWj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Jan 2021 05:22:39 -0500
Received: from m12-18.163.com ([220.181.12.18]:34164 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391657AbhAZKV3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 Jan 2021 05:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=PgTMq
        TZn7npXraokTycNIhlMSf+uj61Uk0lqhNzYuKY=; b=aKU4BSjw31sUQfWrUhc0L
        JbmuCXTftdKu7dpY6VpIZ1tcmHyxv6q4pf84FvprEtC5SJRO0Jwsv0KgQ206mLxb
        jPihZZKij7z6B7K0dDQ6lA7FyY96yY5r1i12UWmkjlNmEyAV+g3E6WXHmrnDrKdo
        mxU/6iNMwk5KpyUAb09drc=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
        by smtp14 (Coremail) with SMTP id EsCowAAXHgry6A9goABtRA--.24561S2;
        Tue, 26 Jan 2021 18:03:34 +0800 (CST)
From:   zuoqilin1@163.com
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zuoqilin <zuoqilin@yulong.com>
Subject: [PATCH] drivers/power/supply: fix typo
Date:   Tue, 26 Jan 2021 18:03:26 +0800
Message-Id: <20210126100326.869-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowAAXHgry6A9goABtRA--.24561S2
X-Coremail-Antispam: 1Uf129KBjvJXoWruFy8KryxGFWkXF17GF47twb_yoW8Jr18pa
        n2vFnrWw4jyFWUJa4DA3ya9FyYganakrWj9w4fG3WrZF43Xws3Wr15tF47Xr1IyryxXF4S
        qasIyw4xtF1jkr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jESoXUUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/1tbipRYmiVUMcELpTQAAsT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: zuoqilin <zuoqilin@yulong.com>

Change 'exeeds' to 'exceeds'.

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 drivers/power/supply/charger-manager.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 6fcebe4..731351d8 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -570,7 +570,7 @@ static int cm_get_target_status(struct charger_manager *cm)
 		return POWER_SUPPLY_STATUS_DISCHARGING;
 
 	if (cm_check_thermal_status(cm)) {
-		/* Check if discharging duration exeeds limit. */
+		/* Check if discharging duration exceeds limit. */
 		if (check_charging_duration(cm))
 			goto charging_ok;
 		return POWER_SUPPLY_STATUS_NOT_CHARGING;
@@ -578,7 +578,7 @@ static int cm_get_target_status(struct charger_manager *cm)
 
 	switch (cm->battery_status) {
 	case POWER_SUPPLY_STATUS_CHARGING:
-		/* Check if charging duration exeeds limit. */
+		/* Check if charging duration exceeds limit. */
 		if (check_charging_duration(cm))
 			return POWER_SUPPLY_STATUS_FULL;
 		fallthrough;
-- 
1.9.1


