Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7569A3458C4
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 08:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhCWHe0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 03:34:26 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48218 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229437AbhCWHdz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Mar 2021 03:33:55 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E00B1200223;
        Tue, 23 Mar 2021 08:33:53 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2969D20023C;
        Tue, 23 Mar 2021 08:33:49 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 611BF4029B;
        Tue, 23 Mar 2021 08:33:43 +0100 (CET)
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V2 RESEND 2/4] PM / devfreq: Remove the invalid description for get_target_freq
Date:   Tue, 23 Mar 2021 15:20:09 +0800
Message-Id: <1616484011-26702-3-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616484011-26702-1-git-send-email-aisheng.dong@nxp.com>
References: <1616484011-26702-1-git-send-email-aisheng.dong@nxp.com>
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
index 386bc230a33d..5e6b74f30406 100644
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
index 244634465170..2d69a0ce6291 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -57,8 +57,6 @@
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

