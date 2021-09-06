Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1164401FC1
	for <lists+linux-pm@lfdr.de>; Mon,  6 Sep 2021 20:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhIFShC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Sep 2021 14:37:02 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:44097 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhIFShC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Sep 2021 14:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1630953357; x=1662489357;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zyMK5O/PHL1QnpDxO+QE66IrpDGM25Huc+ptLFymepw=;
  b=MFTS+78AoJZrkCoTXnpgUtFWG7gCoNzRR627Cg12Vs7JPOmrGLReUJWg
   r+xCgBdkNIMgpWH8DL3t4zkQtK2ByA4jXGOaq6hv4cTrUFs2hKEuJfEP6
   y/lqyC2OPqZRHOue7XBKT+RrBFcU9lEU0wL8Rm+lhVbTmIWQqNBUQ9dCi
   8=;
X-IronPort-AV: E=Sophos;i="5.85,273,1624320000"; 
   d="scan'208";a="157935869"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 06 Sep 2021 18:35:49 +0000
Received: from EX13D16EUB004.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (Postfix) with ESMTPS id EA0A4A1EBF;
        Mon,  6 Sep 2021 18:35:47 +0000 (UTC)
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D16EUB004.ant.amazon.com (10.43.166.11) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Mon, 6 Sep 2021 18:35:46 +0000
Received: from dev-dsk-anelkz-1b-031e727b.eu-west-1.amazon.com (10.13.225.27)
 by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1497.23 via Frontend Transport; Mon, 6 Sep 2021 18:35:45 +0000
Received: by dev-dsk-anelkz-1b-031e727b.eu-west-1.amazon.com (Postfix, from userid 14141144)
        id F0A6F593A; Mon,  6 Sep 2021 18:35:44 +0000 (UTC)
From:   Anel Orazgaliyeva <anelkz@amazon.de>
CC:     <anelkz@amazon.de>, Aman Priyadarshi <apeureka@amazon.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpuidle: Fix memory leaks
Date:   Mon, 6 Sep 2021 18:34:40 +0000
Message-ID: <20210906183440.85710-1-anelkz@amazon.de>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit c343bf1ba5ef ("cpuidle: Fix three reference count leaks")
fixes the cleanup of kobjects; however, it removes kfree() calls
altogether, leading to memory leaks.

Fix those and also defer the initialization of dev->kobj_dev until
after the error check, so that we do not end up with a dangling
pointer.

Signed-off-by: Anel Orazgaliyeva <anelkz@amazon.de>
Suggested-by: Aman Priyadarshi <apeureka@amazon.de>
---
 drivers/cpuidle/sysfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index 53ec9585ccd4..469e18547d06 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -488,6 +488,7 @@ static int cpuidle_add_state_sysfs(struct cpuidle_device *device)
 					   &kdev->kobj, "state%d", i);
 		if (ret) {
 			kobject_put(&kobj->kobj);
+			kfree(kobj);
 			goto error_state;
 		}
 		cpuidle_add_s2idle_attr_group(kobj);
@@ -619,6 +620,7 @@ static int cpuidle_add_driver_sysfs(struct cpuidle_device *dev)
 				   &kdev->kobj, "driver");
 	if (ret) {
 		kobject_put(&kdrv->kobj);
+		kfree(kdrv);
 		return ret;
 	}
 
@@ -705,7 +707,6 @@ int cpuidle_add_sysfs(struct cpuidle_device *dev)
 	if (!kdev)
 		return -ENOMEM;
 	kdev->dev = dev;
-	dev->kobj_dev = kdev;
 
 	init_completion(&kdev->kobj_unregister);
 
@@ -713,9 +714,11 @@ int cpuidle_add_sysfs(struct cpuidle_device *dev)
 				   "cpuidle");
 	if (error) {
 		kobject_put(&kdev->kobj);
+		kfree(kdev);
 		return error;
 	}
 
+	dev->kobj_dev = kdev;
 	kobject_uevent(&kdev->kobj, KOBJ_ADD);
 
 	return 0;
-- 
2.32.0




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



