Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675A43CF623
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jul 2021 10:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbhGTHsw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Jul 2021 03:48:52 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:53960
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232349AbhGTHsu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jul 2021 03:48:50 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 8E5FA404A2;
        Tue, 20 Jul 2021 08:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626769767;
        bh=CC18GBbjPHCdP1gYvQIWC86yDSWhY5wuo6EYPhoHKD0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=S/IlXY962gz4RCNv/Vl+M+/z6FCsjXFHc5w7KU9mfr1adh9AXtWgpx7GQDbFLRBYN
         Ih0nFcmPsJWWm6bHTee+ykSCemBfsmcjdhNLr9B0hhx7lEgEvyNJHIG4jiuPr/7Uka
         edolGhjd8+dnzvErPvQqWHtRxDNTXdAdZAXYRV6lSiMJQ/IZ7BK3e57UoQ//kidKeE
         m7A3Ls6/Fy7+apNpcOjvrMSkkXnTCplJ5aReUoTp4VI2PjSbAf8z2tGTY8FNTFdtX3
         HDtkjadjfBYu2n6do9Hcr+6I2CwXBfBiUikwDL1TbSQq4STfplfieR5dsDQI3orDT3
         SoLHViO5Odz+Q==
From:   Colin King <colin.king@canonical.com>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2][next] power: supply: ab8500: clean up warnings found by checkpatch
Date:   Tue, 20 Jul 2021 09:29:22 +0100
Message-Id: <20210720082922.6398-2-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210720082922.6398-1-colin.king@canonical.com>
References: <20210720082922.6398-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Clean up a handful of checkpatch warnings:
 - static const char * array should probably be static const char * const
 - function arguments should have identifier names
 - else should follow close brace '}'
 - suspect code indent for conditional statements
 - unnecessary parentheses in an if condition
 - avoid multiple line dereference
 - remove debug showing function execution, ftrace can trace these better
 - prefer 'long' over 'long int' as the int is unnecessary

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
V2: Fix subject, s/cppcheck/checkpatch/
    Remove debug, ftrace can track these better.
---
 drivers/power/supply/ab8500_chargalg.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/supply/ab8500_chargalg.c
index 46b0c9fedebb..ff4b26b1ceca 100644
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@ -123,7 +123,7 @@ enum ab8500_chargalg_states {
 	STATE_WD_EXPIRED,
 };
 
-static const char *states[] = {
+static const char * const states[] = {
 	"HANDHELD_INIT",
 	"HANDHELD",
 	"CHG_NOT_OK_INIT",
@@ -274,8 +274,8 @@ static enum power_supply_property ab8500_chargalg_props[] = {
 
 struct ab8500_chargalg_sysfs_entry {
 	struct attribute attr;
-	ssize_t (*show)(struct ab8500_chargalg *, char *);
-	ssize_t (*store)(struct ab8500_chargalg *, const char *, size_t);
+	ssize_t (*show)(struct ab8500_chargalg *di, char *buf);
+	ssize_t (*store)(struct ab8500_chargalg *di, const char *buf, size_t length);
 };
 
 /**
@@ -526,8 +526,7 @@ static int ab8500_chargalg_kick_watchdog(struct ab8500_chargalg *di)
 			di->usb_chg->ops.kick_wd(di->usb_chg);
 
 		return di->ac_chg->ops.kick_wd(di->ac_chg);
-	}
-	else if (di->usb_chg && di->usb_chg->ops.kick_wd &&
+	} else if (di->usb_chg && di->usb_chg->ops.kick_wd &&
 			di->chg_info.online_chg & USB_CHG)
 		return di->usb_chg->ops.kick_wd(di->usb_chg);
 
@@ -750,8 +749,8 @@ static void ab8500_chargalg_check_temp(struct ab8500_chargalg *di)
 			di->t_hyst_norm = 0;
 			di->t_hyst_lowhigh = di->bm->temp_hysteresis;
 		} else {
-		/* Within hysteresis */
-		dev_dbg(di->dev, "Within hysteresis limit temp: %d "
+			/* Within hysteresis */
+			dev_dbg(di->dev, "Within hysteresis limit temp: %d "
 				"hyst_lowhigh %d, hyst normal %d\n",
 				di->batt_data.temp, di->t_hyst_lowhigh,
 				di->t_hyst_norm);
@@ -867,7 +866,7 @@ static enum maxim_ret ab8500_chargalg_chg_curr_maxim(struct ab8500_chargalg *di)
 
 	di->ccm.wait_cnt = 0;
 
-	if ((di->batt_data.inst_curr > di->ccm.original_iset)) {
+	if (di->batt_data.inst_curr > di->ccm.original_iset) {
 		dev_dbg(di->dev, " Maximization Ibat (%dmA) too high"
 			" (limit %dmA) (current iset: %dmA)!\n",
 			di->batt_data.inst_curr, di->ccm.original_iset,
@@ -1545,8 +1544,7 @@ static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
 
 	case STATE_WAIT_FOR_RECHARGE:
 		if (di->batt_data.percent <=
-		    di->bm->bat_type[di->bm->batt_id].
-		    recharge_cap)
+		    di->bm->bat_type[di->bm->batt_id].recharge_cap)
 			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
 		break;
 
@@ -1676,8 +1674,6 @@ static void ab8500_chargalg_wd_work(struct work_struct *work)
 	struct ab8500_chargalg *di = container_of(work,
 		struct ab8500_chargalg, chargalg_wd_work.work);
 
-	dev_dbg(di->dev, "ab8500_chargalg_wd_work\n");
-
 	ret = ab8500_chargalg_kick_watchdog(di);
 	if (ret < 0)
 		dev_err(di->dev, "failed to kick watchdog\n");
@@ -1754,7 +1750,7 @@ static ssize_t ab8500_chargalg_curr_step_show(struct ab8500_chargalg *di,
 static ssize_t ab8500_chargalg_curr_step_store(struct ab8500_chargalg *di,
 					       const char *buf, size_t length)
 {
-	long int param;
+	long param;
 	int ret;
 
 	ret = kstrtol(buf, 10, &param);
@@ -1787,7 +1783,7 @@ static ssize_t ab8500_chargalg_en_show(struct ab8500_chargalg *di,
 static ssize_t ab8500_chargalg_en_store(struct ab8500_chargalg *di,
 	const char *buf, size_t length)
 {
-	long int param;
+	long param;
 	int ac_usb;
 	int ret;
 
-- 
2.31.1

