Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86F1616503
	for <lists+linux-pm@lfdr.de>; Wed,  2 Nov 2022 15:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiKBOWa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Nov 2022 10:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiKBOV4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Nov 2022 10:21:56 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162A627CD1
        for <linux-pm@vger.kernel.org>; Wed,  2 Nov 2022 07:21:53 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id p15-20020a17090a348f00b002141615576dso2236352pjb.4
        for <linux-pm@vger.kernel.org>; Wed, 02 Nov 2022 07:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GG7lcQ6B6Fm/T8LV8zudWuwDEbtHmTF64TDq9Olscfs=;
        b=PvzIPDEaMTxlCBzHeWB28vY0jwJKBCLL1AR3V06rmFooumUv1jPop0oiy7VlFAab+8
         9X2W/hENaPNuh5hwH030LiHExwbxx4PlOmsmhD37ydMeugOoka5U3ADPw4TZkwYvqPG8
         IcWS6xYmcj32PB2fh79Kk7136zg1voEKRW91DGoBHR+kFgIL69TrJ5foYR3hrZlaOdxQ
         o7m+EMklaYGDOO2e0ROew1+eXiH0eV1GwwXB9b893TqSRX7QJr9c/57qQENio0fe+fih
         z2gjPV6x1XGWkeSYnElgigWVp0yt8ShTlAptC14iiTL/YHnjSE2qi7Efuo1um5IF/s5V
         p2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GG7lcQ6B6Fm/T8LV8zudWuwDEbtHmTF64TDq9Olscfs=;
        b=bWuYCOClZUBdMmG+63bUL6VmnukpJGo9DyPFCdr2b9mcrWUZ/evo5v1IIMNl9zifTm
         Ev4wfbyS0GKz3B7l7UDhpQY4P1OW0OoMy0uIC++sayK5WkQzwUpmMkQw2UBUjcAz/H9f
         QTU9eb2JgbmwLNpWCsJvhWCAKbCQDdLsP8nBC05FkreIrPvE0Ww0r533mJY3nm3MaFh3
         F+DGxIRDd+6i0OWVfydye7ZbOp724DYKepanIG63+UB8DWTFwGvE+G60drH0syYe8iMx
         TiUhzdI8ZhbPB35L+VPEjPNyyxmkirIE81k6ahq7hZR0OqVxJO26Ez6WhfbUcy5uXdwm
         2EbQ==
X-Gm-Message-State: ACrzQf3VZCap03J9iE/prIHPnvNcmh18DCs2D6OPr74tXtQwK4+Chrs8
        HKknba9ervfOIPKcjdPw51PmpA==
X-Google-Smtp-Source: AMsMyM6/WinPB5KRYZObewr0hl5APcRQ/dnj/+cDkzbklVPh+D60qhSJi1NZIsDHkDGFkh0xYnj2Gw==
X-Received: by 2002:a17:902:8a93:b0:17f:66ae:b6c with SMTP id p19-20020a1709028a9300b0017f66ae0b6cmr25058677plo.94.1667398912588;
        Wed, 02 Nov 2022 07:21:52 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id o28-20020aa7979c000000b0056b8181861esm8817773pfp.19.2022.11.02.07.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:21:52 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 3/4] PM: domains: Consolidate genpd_restore_noirq() and genpd_resume_noirq()
Date:   Wed,  2 Nov 2022 22:21:03 +0800
Message-Id: <20221102142104.2006554-4-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102142104.2006554-1-shawn.guo@linaro.org>
References: <20221102142104.2006554-1-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Most of the logic between genpd_restore_noirq() and genpd_resume_noirq()
are identical.  The suspended_count decrement for restore should be the
right thing to do anyway, considering there is an increment in
genpd_finish_suspend() for hibernation.  So consolidate these two
functions into genpd_finish_resume().

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 41 +++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index f18b8b1bc17a..7cee9439fd21 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1247,12 +1247,14 @@ static int genpd_suspend_noirq(struct device *dev)
 }
 
 /**
- * genpd_resume_noirq - Start of resume of device in an I/O PM domain.
+ * genpd_finish_resume - Completion of resume of device in an I/O PM domain.
  * @dev: Device to resume.
+ * @resume_noirq: Generic resume_noirq callback.
  *
  * Restore power to the device's PM domain, if necessary, and start the device.
  */
-static int genpd_resume_noirq(struct device *dev)
+static int genpd_finish_resume(struct device *dev,
+			       int (*resume_noirq)(struct device *dev))
 {
 	struct generic_pm_domain *genpd;
 	int ret;
@@ -1264,7 +1266,7 @@ static int genpd_resume_noirq(struct device *dev)
 		return -EINVAL;
 
 	if (device_wakeup_path(dev) && genpd_is_active_wakeup(genpd))
-		return pm_generic_resume_noirq(dev);
+		return resume_noirq(dev);
 
 	genpd_lock(genpd);
 	genpd_sync_power_on(genpd, true, 0);
@@ -1281,6 +1283,19 @@ static int genpd_resume_noirq(struct device *dev)
 	return pm_generic_resume_noirq(dev);
 }
 
+/**
+ * genpd_resume_noirq - Start of resume of device in an I/O PM domain.
+ * @dev: Device to resume.
+ *
+ * Restore power to the device's PM domain, if necessary, and start the device.
+ */
+static int genpd_resume_noirq(struct device *dev)
+{
+	dev_dbg(dev, "%s()\n", __func__);
+
+	return genpd_finish_resume(dev, pm_generic_resume_noirq);
+}
+
 /**
  * genpd_freeze_noirq - Completion of freezing a device in an I/O PM domain.
  * @dev: Device to freeze.
@@ -1366,27 +1381,9 @@ static int genpd_poweroff_noirq(struct device *dev)
  */
 static int genpd_restore_noirq(struct device *dev)
 {
-	struct generic_pm_domain *genpd;
-	int ret = 0;
-
 	dev_dbg(dev, "%s()\n", __func__);
 
-	genpd = dev_to_genpd(dev);
-	if (IS_ERR(genpd))
-		return -EINVAL;
-
-	genpd_lock(genpd);
-	genpd_sync_power_on(genpd, true, 0);
-	genpd_unlock(genpd);
-
-	if (genpd->dev_ops.stop && genpd->dev_ops.start &&
-	    !pm_runtime_status_suspended(dev)) {
-		ret = genpd_start_dev(genpd, dev);
-		if (ret)
-			return ret;
-	}
-
-	return pm_generic_restore_noirq(dev);
+	return genpd_finish_resume(dev, pm_generic_restore_noirq);
 }
 
 /**
-- 
2.25.1

