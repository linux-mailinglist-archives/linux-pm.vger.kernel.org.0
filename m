Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D2F3AE66E
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 11:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhFUJta (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 05:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbhFUJtO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 05:49:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0C5C061574
        for <linux-pm@vger.kernel.org>; Mon, 21 Jun 2021 02:47:00 -0700 (PDT)
Date:   Mon, 21 Jun 2021 09:46:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624268808;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZE1GS2GRGo3+MFscuXcY687Z0vlbMDNep2bKCnefIhY=;
        b=GGjsUKkgddgI6Mt8fGG2nnACsiA27W3z+zFYrxb3WStUfBYOR55VGqZSlw1EqwYotBrPSm
        zZCrRZyms8O9zkL2mD/mE1mghUDCqGHELZHQmN3nWYmfSzZflDPt9Af/NALHc/saAmDo6N
        Vf9xRThHmimnTcG3akunGhyVkbTPKzmiUuqei2rxmON2x4WcLN4i/xTlcOg+B7rxb+1fZj
        qS+HVMSPJu7LZfFWEnR77UdL+IlfrA4ZJzyUJPqMRdMFCl+81ginMKLkTLuQyrB0dKmavC
        Cm+6zZez5xq1LKrqMZImX2jMS/+0IWihR1Dj0TtDJt0b8D9w+GUczcIQhPLedA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624268808;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZE1GS2GRGo3+MFscuXcY687Z0vlbMDNep2bKCnefIhY=;
        b=74SuaVr1vSi7Lw9JeZf607Wm1mgI1q4v+PGfm3GlgMJ+0KKOvkpg5ImkEc22CbLiLeLBOi
        ToaSWegi3Yi8PpCA==
From:   "thermal-bot for Yang Yingliang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Correct function name
 thermal_zone_device_unregister()
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210517051020.3463536-1-yangyingliang@huawei.com>
References: <20210517051020.3463536-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Message-ID: <162426880793.395.4471689555151351510.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     a052b5118f13febac1bd901fe0b7a807b9d6b51c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//a052b5118f13febac1bd901fe0b7a807b9d6b51c
Author:        Yang Yingliang <yangyingliang@huawei.com>
AuthorDate:    Mon, 17 May 2021 13:10:20 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 12 Jun 2021 21:10:06 +02:00

thermal/core: Correct function name thermal_zone_device_unregister()

Fix the following make W=1 kernel build warning:

  drivers/thermal/thermal_core.c:1376: warning: expecting prototype for thermal_device_unregister(). Prototype was for thermal_zone_device_unregister() instead

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210517051020.3463536-1-yangyingliang@huawei.com
---
 drivers/thermal/thermal_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d20b25f..142dcf5 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1369,7 +1369,7 @@ free_tz:
 EXPORT_SYMBOL_GPL(thermal_zone_device_register);
 
 /**
- * thermal_device_unregister - removes the registered thermal zone device
+ * thermal_zone_device_unregister - removes the registered thermal zone device
  * @tz: the thermal zone device to remove
  */
 void thermal_zone_device_unregister(struct thermal_zone_device *tz)
