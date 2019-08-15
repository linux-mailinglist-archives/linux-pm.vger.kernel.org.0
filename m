Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD6F8EFDB
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2019 17:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfHOP7C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Aug 2019 11:59:02 -0400
Received: from mail.heine.tech ([195.201.24.99]:44184 "EHLO mail.heine.tech"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728662AbfHOP7B (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Aug 2019 11:59:01 -0400
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Aug 2019 11:59:01 EDT
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: michael@nosthoff.rocks)
        by mail.heine.tech (Postcow) with ESMTPSA id 8A6D11814A1;
        Thu, 15 Aug 2019 17:53:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heine.so; s=dkim;
        t=1565884407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BE1Zy5Qog+TxzY8S3tJkSl6a3YgdLE5ERaIG4+hlWjA=;
        b=dKS+jggoEJ3y6kCqy+xQfwW2KyZFLUFkQwQR0qAnACo0btZSpl6xa+mE1PqU+3aFr+PsKw
        PuY9B+kjsZUSFcG8rYuWJNNfi+1yHc0JM4mVoIKeCW3R47Yjb20FJEtK1vfn7zovppe+gA
        hps03dtZ9mx74tjSnu+nKFNM97SWrKw=
From:   Michael Nosthoff <committed@heine.so>
To:     linux-pm@vger.kernel.org
Cc:     briannorris@chromium.org, Michael Nosthoff <committed@heine.so>
Subject: [PATCH] power: supply: sbs-battery: use correct flags field
Date:   Thu, 15 Aug 2019 17:53:22 +0200
Message-Id: <20190815155322.20923-1-committed@heine.so>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

the type flag is stored in the chip->flags field not in the
client->flags field. This currently leads to never using the ti
specific function but always falling back to the general one.

Signed-off-by: Michael Nosthoff <committed@heine.so>
---
 drivers/power/supply/sbs-battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 048d205d7074..2e86cc1e0e35 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -620,7 +620,7 @@ static int sbs_get_property(struct power_supply *psy,
 	switch (psp) {
 	case POWER_SUPPLY_PROP_PRESENT:
 	case POWER_SUPPLY_PROP_HEALTH:
-		if (client->flags & SBS_FLAGS_TI_BQ20Z75)
+		if (chip->flags & SBS_FLAGS_TI_BQ20Z75)
 			ret = sbs_get_ti_battery_presence_and_health(client,
 								     psp, val);
 		else
-- 
2.20.1

