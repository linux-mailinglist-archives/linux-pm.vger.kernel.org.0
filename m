Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8812FD429
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 16:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbhATPeZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 10:34:25 -0500
Received: from m12-14.163.com ([220.181.12.14]:52050 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390270AbhATPeE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 Jan 2021 10:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=91X/C
        uC+inNqElz0yh7ejsq+wKcYyR14IVBS4gV/fmM=; b=MN2st6R3L3ncWTXCieKVG
        QFAWed3pv34DSDPLQ99MiefWGibk/wR4i93gJakZy0lzb+U5P/4YTk2lbRfLjQ2Q
        rUPh1Qoi3X4Am/5OUvrWQjNx0UzrLYTG20ZBtUke+XMcKZcq36joTwvZtW9FI0br
        /aF9bsBlZU5UszonAmhIpQ=
Received: from yangjunlin.ccdomain.com (unknown [119.137.55.77])
        by smtp10 (Coremail) with SMTP id DsCowABnaRWhKAhgCXQAhA--.28868S2;
        Wed, 20 Jan 2021 20:57:06 +0800 (CST)
From:   angkery <angkery@163.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xinjian@yulong.com, Junlin Yang <yangjunlin@yulong.com>
Subject: [PATCH] power: supply: charger-manager: fix typo
Date:   Wed, 20 Jan 2021 20:45:53 +0800
Message-Id: <20210120124553.751-1-angkery@163.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowABnaRWhKAhgCXQAhA--.28868S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrZF1DJw45CFy3trWfGF1DGFg_yoW8Jr1kpa
        n2vFnrWw4jyFWUXa4DA3ya9Fy5uanakrWj9w4xG3W5XF43Xwn3Wr45tF47Xr1Iyr4xJF4S
        va4ayw4xtF1jkw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bjF4iUUUUU=
X-Originating-IP: [119.137.55.77]
X-CM-SenderInfo: 5dqjyvlu16il2tof0z/1tbiUAIgI1WBqSMq9QAAsQ
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Junlin Yang <yangjunlin@yulong.com>

Change 'exeeds' to 'exceeds'.

Signed-off-by: Junlin Yang <yangjunlin@yulong.com>
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


