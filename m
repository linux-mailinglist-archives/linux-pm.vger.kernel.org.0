Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829E03AAC8B
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jun 2021 08:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhFQGmC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Jun 2021 02:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhFQGmB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jun 2021 02:42:01 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721F9C06175F;
        Wed, 16 Jun 2021 23:39:54 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y15so4203454pfl.4;
        Wed, 16 Jun 2021 23:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3c+7D3426Z3aclSIEt2nDTfGpaHgF5oXTySH+Anf78k=;
        b=DsiA/OHOXeLRPwemFwMe/Zp1PYmbDerspIMt7cOqn3wyfoHLBJj+Ced3CPhNRgpitL
         xoDu5YUQbKmtfW13GEj429XK4m9QT2oh2k8iVI/pWR8YVQLijUiJtX/Prr9xiHLSqnq+
         SevVqg+vOkP2MbpF2ejZY3PXcfy7R46aBSHecuYhXuLlQMP83kQXFBYIT+7gZrM8odxd
         nCBy+Chubtt5D6xx102jkZP+kN39UAUODLAlFiVOE6RL7w6Q00w6DkCq144m848wr431
         yo/cHpkDFrdzvo6Ek3pPm2zKIW9LL9a5Jxp8UtdrjKf5rBTI4vBLv5S9s3GuuXJHJrCP
         VnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3c+7D3426Z3aclSIEt2nDTfGpaHgF5oXTySH+Anf78k=;
        b=NxiDS6mCPH5vhBTM+ZkYoKQ3Usu5VKwYotjLw7MTL401hW1xEfzNRgGTT2dU8M/9mN
         +4OWjm8RUZM4hRgxCTTAMIxD8PZ9LC/0oipOkdjpDw8Dl3N/MBbeaIKtgR8pDnqsgYXe
         yM1047hIJKjpr6JQ8qyRCp8lwlXfaDEgDRRH1LtZDGW7VwWFxAJVYb1tVke1t/R++msJ
         lEZxdXSz8mUlq4eDlk893VEfCuvoUvF9LNY2aleroP2L/LGxe/RtHh++o54T8gC8Lbg+
         eyLoIrW816g1gLIc2O+iige0z0s96kCFwh6eESt7Sx6EuewzQvvGv+gJkNPiHDPIEapC
         3Y5w==
X-Gm-Message-State: AOAM532Ij+s9w/W/KwNcIoe7WHWbkLqxjp4VpkO6f82pzKsQhxgPIFtb
        RkdWiCuEDPJEvJn1MEGNRlE=
X-Google-Smtp-Source: ABdhPJwecDN3dI4toxn9FfTRz+gyv/a0xyyYpF8hY4fOWjZ2lix0SPGU54VaNJfBFfkkYMFhra6hqA==
X-Received: by 2002:a63:8c05:: with SMTP id m5mr3549092pgd.223.1623911993924;
        Wed, 16 Jun 2021 23:39:53 -0700 (PDT)
Received: from localhost ([223.184.24.109])
        by smtp.gmail.com with ESMTPSA id s22sm4228256pfd.94.2021.06.16.23.39.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jun 2021 23:39:52 -0700 (PDT)
Date:   Thu, 17 Jun 2021 12:09:46 +0530
From:   Shubhankar Kuranagatti <shubhankarvk@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanjanasrinidhi1810@gmail.com
Subject: [PATCH] drivers: power: supply: ab8500_charger.c: Add blank line
 after declaration
Message-ID: <20210617063946.ziyswdxsk46xw63a@kewl-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Added blank line after declaration
Removed repetition of "the" in comment block
Fixed indentation of conditional statement
Replaced spaces with tabs
This is done to manintain uniformity in coding style

Signed-off-by: Shubhankar Kuranagatti <shubhankarvk@gmail.com>
---
 drivers/power/supply/ab8500_charger.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index ac77c8882d17..4d71e1a769b2 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -237,7 +237,7 @@ struct ab8500_charger_max_usb_in_curr {
  * @adc_main_charger_c	ADC channel for main charger current
  * @adc_vbus_v		ADC channel for USB charger voltage
  * @adc_usb_charger_c	ADC channel for USB charger current
- * @bm:           	Platform specific battery management information
+ * @bm:			Platform specific battery management information
  * @flags:		Structure for information about events triggered
  * @usb_state:		Structure for usb stack information
  * @max_usb_in_curr:	Max USB charger input current
@@ -1059,6 +1059,7 @@ static int ab8500_vbus_in_curr_to_regval(struct ab8500_charger *di, int curr)
 static int ab8500_charger_get_usb_cur(struct ab8500_charger *di)
 {
 	int ret = 0;
+
 	switch (di->usb_state.usb_current) {
 	case 100:
 		di->max_usb_in_curr.usb_type_max = USB_CH_IP_CUR_LVL_0P09;
@@ -1206,6 +1207,7 @@ static int ab8500_charger_set_current(struct ab8500_charger *di,
 		}
 	} else {
 		bool allow = true;
+
 		for (i = prev_curr_index + 1; i <= curr_index && allow; i++) {
 			dev_dbg(di->dev, "curr change_2 to: %x for 0x%02x\n",
 				(u8)i << shift_value, reg);
@@ -1893,6 +1895,7 @@ static int ab8500_charger_get_ext_psy_data(struct device *dev, void *data)
 	/* Go through all properties for the psy */
 	for (j = 0; j < ext->desc->num_properties; j++) {
 		enum power_supply_property prop;
+
 		prop = ext->desc->properties[j];
 
 		if (power_supply_get_property(ext, prop, &ret))
@@ -1922,7 +1925,7 @@ static int ab8500_charger_get_ext_psy_data(struct device *dev, void *data)
  * Due to a asic bug it is necessary to lower the input current to the vbus
  * charger when charging with at some specific levels. This issue is only valid
  * for below a certain battery voltage. This function makes sure that the
- * the allowed current limit isn't exceeded.
+ * allowed current limit isn't exceeded.
  */
 static void ab8500_charger_check_vbat_work(struct work_struct *work)
 {
@@ -1958,7 +1961,7 @@ static void ab8500_charger_check_vbat_work(struct work_struct *work)
 	 */
 	if (di->vbat < (VBAT_TRESH_IP_CUR_RED + 100) &&
 		(di->vbat > (VBAT_TRESH_IP_CUR_RED - 100)))
-			t = 1;
+		t = 1;
 
 	queue_delayed_work(di->charger_wq, &di->check_vbat_work, t * HZ);
 }
-- 
2.17.1

