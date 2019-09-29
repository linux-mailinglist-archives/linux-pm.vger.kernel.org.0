Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF63C18ED
	for <lists+linux-pm@lfdr.de>; Sun, 29 Sep 2019 20:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbfI2STS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Sep 2019 14:19:18 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36996 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729044AbfI2STS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Sep 2019 14:19:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id y5so4225258pfo.4
        for <linux-pm@vger.kernel.org>; Sun, 29 Sep 2019 11:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=65Whwopcw85NQTCWGFtmXbrzKQyWnHggD3EOKfGTEwM=;
        b=TgW9h/Qpup/7ceB8FSCXKEO5Bc7K04xHHs63oMT0mSDMTPU5QC1Bou0Wg9Yz2grZ+G
         V0SEJViqn1PhhF93Dfqxyz81eUVvp1J6g0M7+VRFSKRUxw4m9yXWPHawCViS11Xobbta
         Jzl22ilhL5YB9KOKJs43teGgQLvkyvyFqb3HigTle5cjCoFiX94ffh/gcStiTafbfLkh
         5sutP4w83spLuoENDbL/LZObaWF3NnLCGYdD79lRK0reECyh51xYOH0sEn8nH/xi3X2H
         mw1ojGq/bKxKdMPuvJjKiSw4PlPfyvXg6/Ho1U9S5wxREejNMv2gaMNW9E12s0xZzJ/+
         iRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=65Whwopcw85NQTCWGFtmXbrzKQyWnHggD3EOKfGTEwM=;
        b=ksKpCfI6WRNGzyjz4hDLCOoghJv/eOgBqc622/DbsEb72aIW78UonXS9otPlaGmjsm
         mQDyCHJ8fyzWqkmLgIdjJY9Qj1RNUs0DLlkNl7dedeePZnNIuA+PbAbNJgS4umNRBTLs
         unWdbHMbO0mCZqM0z3TZeqgPY4zc3hyMl+FGQ1jIYXhvbxpcm7Hq4fvyG/c5c4VddNo9
         ZVGN9o0lGv1KNBuuzZbrThezyyZQFjh2NZOIP6pAdYvW8QRjajxS1L5AOnJ90jRcL0Gb
         t9y1sZ4rod7cYWeIzkkGD4bVdSwUIW2YLd9cOZEV2G2cDx4U1+arL0LX0h8wkpRAgGAS
         3Gng==
X-Gm-Message-State: APjAAAVWo/+zV0f9tRAfj/M+C/Jpgjqsvl2t58BXv31N9t7Ya1+a/7KJ
        ELlMeZYNyj3OSBRoYZyODS0FRmfMQeE=
X-Google-Smtp-Source: APXvYqwS4tHcNc+ngdA6Ge+YXyySNlu68rZXMLNbhMRmpTMRUcfiSVC8NoaE+4gQCXWkFYul+SgiGg==
X-Received: by 2002:a63:a051:: with SMTP id u17mr20100481pgn.7.1569781156271;
        Sun, 29 Sep 2019 11:19:16 -0700 (PDT)
Received: from madhuparna-HP-Notebook ([2402:3a80:51e:fd84:cd82:94a1:ffba:66f9])
        by smtp.gmail.com with ESMTPSA id k3sm12116276pgl.9.2019.09.29.11.19.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Sep 2019 11:19:15 -0700 (PDT)
Date:   Sun, 29 Sep 2019 23:49:10 +0530
From:   Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     sre@kernel.org, madhuparnabhowmik03@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH 4/4] Driver: Power: Supply: abx500_chargalg: Fixed a few
 coding style errors
Message-ID: <20190929181906.GA21828@madhuparna-HP-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch fixes a few coding style errors and warnings
detected by checkpatch.pl:

WARNING: please, no space before tabs
ERROR: code indent should use tabs where possible
WARNING: please, no spaces at the start of a line
WARNING: Unnecessary parentheses
WARNING: Block comments use a trailing */ on a separate line
WARNING: Prefer 'long' over 'long int' as the int is unnecessary

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
---
 drivers/power/supply/abx500_chargalg.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/power/supply/abx500_chargalg.c b/drivers/power/supply/abx500_chargalg.c
index 23757fb10479..a779fcabe3c6 100644
--- a/drivers/power/supply/abx500_chargalg.c
+++ b/drivers/power/supply/abx500_chargalg.c
@@ -219,7 +219,7 @@ enum maxim_ret {
  * @chg_info:		information about connected charger types
  * @batt_data:		data of the battery
  * @susp_status:	current charger suspension status
- * @bm:           	Platform specific battery management information
+ * @bm:			Platform specific battery management information
  * @curr_status:	Current step status for over-current protection
  * @parent:		pointer to the struct abx500
  * @chargalg_psy:	structure that holds the battery properties exposed by
@@ -354,13 +354,13 @@ static int abx500_chargalg_check_charger_enable(struct abx500_chargalg *di)
 
 	if (di->chg_info.charger_type & USB_CHG) {
 		return di->usb_chg->ops.check_enable(di->usb_chg,
-                         di->bm->bat_type[di->bm->batt_id].normal_vol_lvl,
-                         di->bm->bat_type[di->bm->batt_id].normal_cur_lvl);
+			di->bm->bat_type[di->bm->batt_id].normal_vol_lvl,
+			di->bm->bat_type[di->bm->batt_id].normal_cur_lvl);
 	} else if ((di->chg_info.charger_type & AC_CHG) &&
 		   !(di->ac_chg->external)) {
 		return di->ac_chg->ops.check_enable(di->ac_chg,
-                         di->bm->bat_type[di->bm->batt_id].normal_vol_lvl,
-                         di->bm->bat_type[di->bm->batt_id].normal_cur_lvl);
+			di->bm->bat_type[di->bm->batt_id].normal_vol_lvl,
+			di->bm->bat_type[di->bm->batt_id].normal_cur_lvl);
 	}
 	return 0;
 }
@@ -865,7 +865,7 @@ static enum maxim_ret abx500_chargalg_chg_curr_maxim(struct abx500_chargalg *di)
 
 	di->ccm.wait_cnt = 0;
 
-	if ((di->batt_data.inst_curr > di->ccm.original_iset)) {
+	if (di->batt_data.inst_curr > di->ccm.original_iset) {
 		dev_dbg(di->dev, " Maximization Ibat (%dmA) too high"
 			" (limit %dmA) (current iset: %dmA)!\n",
 			di->batt_data.inst_curr, di->ccm.original_iset,
@@ -967,7 +967,8 @@ static int abx500_chargalg_get_ext_psy_data(struct device *dev, void *data)
 
 		/*
 		 * Initialize chargers if not already done.
-		 * The ab8500_charger*/
+		 * The ab8500_charger
+		 */
 		if (!di->ac_chg &&
 			ext->desc->type == POWER_SUPPLY_TYPE_MAINS)
 			di->ac_chg = psy_to_ux500_charger(ext);
@@ -1173,7 +1174,8 @@ static int abx500_chargalg_get_ext_psy_data(struct device *dev, void *data)
 			switch (ext->desc->type) {
 			case POWER_SUPPLY_TYPE_MAINS:
 				/* AVG is used to indicate when we are
-				 * in CV mode */
+				 * in CV mode
+				 */
 				if (ret.intval)
 					di->events.ac_cv_active = true;
 				else
@@ -1182,7 +1184,8 @@ static int abx500_chargalg_get_ext_psy_data(struct device *dev, void *data)
 				break;
 			case POWER_SUPPLY_TYPE_USB:
 				/* AVG is used to indicate when we are
-				 * in CV mode */
+				 * in CV mode
+				 */
 				if (ret.intval)
 					di->events.usb_cv_active = true;
 				else
@@ -1750,7 +1753,7 @@ static ssize_t abx500_chargalg_curr_step_show(struct abx500_chargalg *di,
 static ssize_t abx500_chargalg_curr_step_store(struct abx500_chargalg *di,
 					       const char *buf, size_t length)
 {
-	long int param;
+	long param;
 	int ret;
 
 	ret = kstrtol(buf, 10, &param);
@@ -1783,7 +1786,7 @@ static ssize_t abx500_chargalg_en_show(struct abx500_chargalg *di,
 static ssize_t abx500_chargalg_en_store(struct abx500_chargalg *di,
 	const char *buf, size_t length)
 {
-	long int param;
+	long param;
 	int ac_usb;
 	int ret;
 
-- 
2.17.1

