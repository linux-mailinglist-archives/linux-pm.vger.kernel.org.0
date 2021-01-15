Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C737B2F7C47
	for <lists+linux-pm@lfdr.de>; Fri, 15 Jan 2021 14:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbhAONQJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jan 2021 08:16:09 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42283 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729498AbhAONQJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jan 2021 08:16:09 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1l0Owm-00024N-GV; Fri, 15 Jan 2021 13:15:24 +0000
From:   Colin King <colin.king@canonical.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] power: supply: cpcap-charger: Fix power_supply_put on null battery pointer
Date:   Fri, 15 Jan 2021 13:15:24 +0000
Message-Id: <20210115131524.71339-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently if the pointer battery is null there is a null pointer
dereference on the call to power_supply_put.  Fix this by only
performing the put if battery is not null.

Addresses-Coverity: ("Dereference after null check")
Fixes: 4bff91bb3231 ("power: supply: cpcap-charger: Fix missing power_supply_put()")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/power/supply/cpcap-charger.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
index 823d666f09e0..641dcad1133f 100644
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -300,8 +300,9 @@ cpcap_charger_get_bat_const_charge_voltage(struct cpcap_charger_ddata *ddata)
 				&prop);
 		if (!error)
 			voltage = prop.intval;
+
+		power_supply_put(battery);
 	}
-	power_supply_put(battery);
 
 	return voltage;
 }
-- 
2.29.2

