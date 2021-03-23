Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A362B345601
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 04:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhCWDNI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 23:13:08 -0400
Received: from inva020.nxp.com ([92.121.34.13]:36552 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229810AbhCWDNG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Mar 2021 23:13:06 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A69491A4D2F;
        Tue, 23 Mar 2021 04:13:04 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F40831A09AA;
        Tue, 23 Mar 2021 04:12:59 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 58923402D3;
        Tue, 23 Mar 2021 04:12:53 +0100 (CET)
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V2 3/6] PM / devfreq: Remove the invalid description for get_target_freq
Date:   Tue, 23 Mar 2021 10:59:16 +0800
Message-Id: <1616468359-14513-4-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616468359-14513-1-git-send-email-aisheng.dong@nxp.com>
References: <1616468359-14513-1-git-send-email-aisheng.dong@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

First of all, no_central_polling was removed since
commit 7e6fdd4bad03 ("PM / devfreq: Core updates to support devices
which can idle")
Secondly, get_target_freq() is not only called only with update_devfreq()
notified by OPP now, but also min/max freq qos notifier.

So remove this invalid description now to avoid confusing.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 Documentation/ABI/testing/sysfs-class-devfreq | 5 +----
 drivers/devfreq/governor.h                    | 2 --
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
index 22408cfa7ed2..e71595c84f22 100644
--- a/Documentation/ABI/testing/sysfs-class-devfreq
+++ b/Documentation/ABI/testing/sysfs-class-devfreq
@@ -97,10 +97,7 @@ Description:
 		object. The values are represented in ms. If the value is
 		less than 1 jiffy, it is considered to be 0, which means
 		no polling. This value is meaningless if the governor is
-		not polling; thus. If the governor is not using
-		devfreq-provided central polling
-		(/sys/class/devfreq/.../central_polling is 0), this value
-		may be useless.
+		not polling.
 
 		A list of governors that support the node:
 		- simple_ondmenad
diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index 48736a2ae970..9d72f5b66bfa 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -67,8 +67,6 @@
  *			Basically, get_target_freq will run
  *			devfreq_dev_profile.get_dev_status() to get the
  *			status of the device (load = busy_time / total_time).
- *			If no_central_polling is set, this callback is called
- *			only with update_devfreq() notified by OPP.
  * @event_handler:      Callback for devfreq core framework to notify events
  *                      to governors. Events include per device governor
  *                      init and exit, opp changes out of devfreq, suspend
-- 
2.25.1

