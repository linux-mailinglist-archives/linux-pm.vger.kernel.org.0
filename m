Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355DA266408
	for <lists+linux-pm@lfdr.de>; Fri, 11 Sep 2020 18:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgIKQ3b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Sep 2020 12:29:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgIKQ2E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Sep 2020 12:28:04 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5DFC2220D;
        Fri, 11 Sep 2020 16:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599841664;
        bh=y1LJBbMFa89dqzjbeHMhQ4rAd65Fc+zMq+ReRBh/ovM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TmyVGJIAPADskTsILeikOFLbmcSyzw7En3FjZH2oKTx0CCKg/mM0eAUJjse+7NxoL
         pAMR08AXz3O9TtOM2/9R8ZjEF2CtxL+wS4DHPoCB5dNZB/NZpuu1TfijL1GWSRk2BV
         Ebgqmln4MsOo3b5sUFkUAdlso6AnuV9wc+/RVgwo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Jonathan Bakker <xc-racer2@live.ca>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 6/7] power: supply: charger-manager: drop unused charger assignment
Date:   Fri, 11 Sep 2020 18:27:28 +0200
Message-Id: <20200911162729.3022-6-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200911162729.3022-1-krzk@kernel.org>
References: <20200911162729.3022-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The 'charger' variable in error path is assigned but never used:

  drivers/power/supply/charger-manager.c: In function 'charger_manager_probe':
  drivers/power/supply/charger-manager.c:1626:29: warning: variable 'charger' set but not used [-Wunused-but-set-variable]

Fixes: c1f73028f75d ("power: supply: charger-manager: Update extcon functions")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/charger-manager.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 07992821e252..b2ca79173f95 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1622,13 +1622,8 @@ static int charger_manager_probe(struct platform_device *pdev)
 	return 0;
 
 err_reg_extcon:
-	for (i = 0; i < desc->num_charger_regulators; i++) {
-		struct charger_regulator *charger;
-
-		charger = &desc->charger_regulators[i];
-
+	for (i = 0; i < desc->num_charger_regulators; i++)
 		regulator_put(desc->charger_regulators[i].consumer);
-	}
 
 	power_supply_unregister(cm->charger_psy);
 
-- 
2.17.1

