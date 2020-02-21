Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFEA8166C26
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 01:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbgBUA63 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 19:58:29 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:40906 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729419AbgBUA63 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 19:58:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1582246707; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=hNL2y+v5S7yvFXD6Rd5po+APK5tuBqigpYaXtPqV024=;
        b=jCUJOUi1gluCYom/AohDJtxmfoHUs4bc/3sNRCuZM+k8k5ZgldreudXZVS/NRDW5Eqp1Tm
        9EAZyZijg3TEISAQHsTq/7LrQqkADmC/wvbjV2C5BbFbWxIE7lDkvbVRbiUdd3w9jTgrKr
        sgWOM/jKG2qHiEP5XgCYIx0y7jI3jlo=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     od@zcrc.me, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] power/supply: ingenic-battery: Don't print error on -EPROBE_DEFER
Date:   Thu, 20 Feb 2020 21:58:12 -0300
Message-Id: <20200221005812.271187-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Don't print an error message if devm_power_supply_register() returns
-EPROBE_DEFER, since the driver will simply re-probe later.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/power/supply/ingenic-battery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/ingenic-battery.c b/drivers/power/supply/ingenic-battery.c
index 2748715c4c75..dd3d93dfe3eb 100644
--- a/drivers/power/supply/ingenic-battery.c
+++ b/drivers/power/supply/ingenic-battery.c
@@ -148,7 +148,8 @@ static int ingenic_battery_probe(struct platform_device *pdev)
 
 	bat->battery = devm_power_supply_register(dev, desc, &psy_cfg);
 	if (IS_ERR(bat->battery)) {
-		dev_err(dev, "Unable to register battery\n");
+		if (PTR_ERR(bat->battery) != -EPROBE_DEFER)
+			dev_err(dev, "Unable to register battery\n");
 		return PTR_ERR(bat->battery);
 	}
 
-- 
2.25.0

