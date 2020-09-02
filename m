Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC5C25AFED
	for <lists+linux-pm@lfdr.de>; Wed,  2 Sep 2020 17:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgIBPr2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 11:47:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54363 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgIBNbh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2020 09:31:37 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kDSr7-00023z-S9; Wed, 02 Sep 2020 13:31:17 +0000
From:   Colin King <colin.king@canonical.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Myungjoo Ham <myungjoo.ham@samsung.com>,
        Anton Vorontsov <anton.vorontsov@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] charger-manager: fix incorrect check on charging_duration_ms
Date:   Wed,  2 Sep 2020 14:31:17 +0100
Message-Id: <20200902133117.108025-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the duration check on the discharging duration setting is
checking the charging duration rather than the discharging duration
due to a cut-n-paste coding error. Fix this by checking the value
desc->charging_max_duration_ms.

Addresses-Coverity: ("Copy-paste-error")
Fixes: 8fcfe088e21a ("charger-manager: Support limit of maximum possible")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/power/supply/charger-manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 07992821e252..44d919954e9e 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -471,7 +471,7 @@ static int check_charging_duration(struct charger_manager *cm)
 	} else if (cm->battery_status == POWER_SUPPLY_STATUS_NOT_CHARGING) {
 		duration = curr - cm->charging_end_time;
 
-		if (duration > desc->charging_max_duration_ms) {
+		if (duration > desc->discharging_max_duration_ms) {
 			dev_info(cm->dev, "Discharging duration exceed %ums\n",
 				 desc->discharging_max_duration_ms);
 			ret = true;
-- 
2.27.0

