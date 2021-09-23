Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC6141656E
	for <lists+linux-pm@lfdr.de>; Thu, 23 Sep 2021 20:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242727AbhIWSwt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Sep 2021 14:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242794AbhIWSwr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Sep 2021 14:52:47 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F08C061574;
        Thu, 23 Sep 2021 11:51:15 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id g184so7263699pgc.6;
        Thu, 23 Sep 2021 11:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JQGflSQTqqTDCv3KaowX8c30Psro3zRNDRr+HJv+0Q0=;
        b=aUH2OdABfEQcGDWFNa0+TZtHDhjfOZeVr3FNt/rFCcI0FRBHRryIZJqatuQdZIixzI
         e/uifJpMfX++BsAMvg9PRJRjGNAcREE3rrHABdx71CHarJNr9LuwMNH9tZj9e1e8UyTL
         sWn3Tu95lpLyfMAxX15yP5J6Dq1Rzq346qRITXl27RVMPameAQX/qVf71CaS7bs6jOwW
         uGZSxY2BIwaVXgCsTOlOP3mOHkFxi/+qVUGqWj3jNdM3pWb/FovTIO7+m4rzB0okxt/3
         wkBwKnvz1i2BdqlVNs36hMZNZe/G5k8KP4LsFc7Bt8RkYhWCroYRCsCZ89imIvMkJVYz
         bj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JQGflSQTqqTDCv3KaowX8c30Psro3zRNDRr+HJv+0Q0=;
        b=t6eeB1t+KYzMHsVF7BJFyp7N6ekQxj6o9ODc+bdK5VCDau7YwbDda6Fs2MIzkS0oNF
         1ez6AheCyhE3bR/znE9a9fvDOpUF8yi5y6+U9zvmrwktNt7ZPVTxtHl67tESo8FBSv2Q
         FzqAOOLvgrt3aD8YqXoLYj11IAaPpstDIARp1DjlGBa/jClR22iabQvs6/meNcHCkdpf
         m5kW//iY6Y4LhukEkzFvcv/F/HOrN5FHSnoIRt/P2AXsgQDO8DtYvoaMM8ArVYZzR2/8
         fgMhsyKPM4LasnKRgDynic4kyi9IK+DYkai50labJfksxjV50OG/I9/RB3JQue4BzHa5
         Xspg==
X-Gm-Message-State: AOAM531N7SzBVG0CBWfNrbClHrf6HlwZbyaKt8JorIiNPId6BRwqOMp/
        BtcJD/fqY/hRuyK0wUQPQ0Rp+b5pyNc=
X-Google-Smtp-Source: ABdhPJx8H9TtwN2h/bm3PoOl3LvApUb3/LngUX+eu0Wg0ah/Nx3FGWHQSAedkWY4w9leaby1N+++0A==
X-Received: by 2002:a63:205:: with SMTP id 5mr154850pgc.433.1632423074841;
        Thu, 23 Sep 2021 11:51:14 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h10sm9300294pjs.51.2021.09.23.11.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 11:51:14 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend,
        aka swsusp))
Subject: [PATCH] PM / Suspend: Avoid soft lockup warning with suspend_test
Date:   Thu, 23 Sep 2021 11:51:05 -0700
Message-Id: <20210923185106.501848-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When testing with a large (>= 22 seconds) pm_test_delay we can see the
NMI soft lockup barfing at us because a task has been blocked for too
long. This can be reproduced with:

	echo devices > /sys/power/pm_test
	echo 30 > /sys/module/suspend/parameters/pm_test_delay

Unroll the loop and touch the NMI watchdog every 1s to avoid the lockup
warnings.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 kernel/power/suspend.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index eb75f394a059..7441f0011ccd 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -30,6 +30,7 @@
 #include <trace/events/power.h>
 #include <linux/compiler.h>
 #include <linux/moduleparam.h>
+#include <linux/nmi.h>
 
 #include "power.h"
 
@@ -324,10 +325,15 @@ MODULE_PARM_DESC(pm_test_delay,
 static int suspend_test(int level)
 {
 #ifdef CONFIG_PM_DEBUG
+	unsigned int i;
+
 	if (pm_test_level == level) {
 		pr_info("suspend debug: Waiting for %d second(s).\n",
 				pm_test_delay);
-		mdelay(pm_test_delay * 1000);
+		for (i = 0; i < pm_test_delay; i++) {
+			mdelay(1000);
+			touch_nmi_watchdog();
+		}
 		return 1;
 	}
 #endif /* !CONFIG_PM_DEBUG */
-- 
2.25.1

