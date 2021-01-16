Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFE52F8D36
	for <lists+linux-pm@lfdr.de>; Sat, 16 Jan 2021 13:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbhAPMBm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 16 Jan 2021 07:01:42 -0500
Received: from m12-12.163.com ([220.181.12.12]:57152 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbhAPMBl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 16 Jan 2021 07:01:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=PL/Jq
        HSck/4HYIlMBJO7I9Krmfq9sE0LU3UwCK14FsA=; b=oF7csRQpgjxY1Rk7eykVO
        ZM+UVqiDRg9Boa/wfs9y1KMx289//0Ki0qjWmUbNWyPYz4wGrmVGyoxzPBsP1rJD
        Y+TeWW8AXHXoxuEF4qn7NFwgGkcGyLMBCIGHhAx1HJE+mWB2wUkobFxvlzk0UfLG
        yLtAKW44Epn2GjldXmI4NE=
Received: from yangjunlin.ccdomain.com (unknown [119.137.52.218])
        by smtp8 (Coremail) with SMTP id DMCowAAXWOM40QJgnUpiMQ--.32724S2;
        Sat, 16 Jan 2021 19:42:49 +0800 (CST)
From:   angkery <angkery@163.com>
To:     sre@kernel.org, yangjunlin@yulong.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: charger-manager: fix the wrong status of health
Date:   Sat, 16 Jan 2021 19:41:20 +0800
Message-Id: <20210116114120.3531-1-angkery@163.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowAAXWOM40QJgnUpiMQ--.32724S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4UXr4DXryxJr1UKF1kuFg_yoWkGrgEka
        ykA340qFya9r1ayrnrKFn3Zry09ayrXayxWa92grZ8A3WYqw4kJrykZF98Jw47GF43uFZI
        qas8JFn5CFy8KjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5HxR3UUUUU==
X-Originating-IP: [119.137.52.218]
X-CM-SenderInfo: 5dqjyvlu16il2tof0z/xtbBFBkcI1aD+EUA9AAAsu
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Junlin Yang <yangjunlin@yulong.com>

cm->emergency_stop will only be the value in the enumeration,
and can not be less than zero, it will get an exception value.
So replace it with the corresponding value.

Signed-off-by: Junlin Yang <yangjunlin@yulong.com>
---
 drivers/power/supply/charger-manager.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 6fcebe4..0d28741 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -723,9 +723,9 @@ static int charger_get_property(struct power_supply *psy,
 		val->intval = cm->battery_status;
 		break;
 	case POWER_SUPPLY_PROP_HEALTH:
-		if (cm->emergency_stop > 0)
+		if (cm->emergency_stop == CM_BATT_OVERHEAT)
 			val->intval = POWER_SUPPLY_HEALTH_OVERHEAT;
-		else if (cm->emergency_stop < 0)
+		else if (cm->emergency_stop == CM_BATT_COLD)
 			val->intval = POWER_SUPPLY_HEALTH_COLD;
 		else
 			val->intval = POWER_SUPPLY_HEALTH_GOOD;
-- 
1.9.1


