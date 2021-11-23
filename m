Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F9745AC22
	for <lists+linux-pm@lfdr.de>; Tue, 23 Nov 2021 20:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhKWTV7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Nov 2021 14:21:59 -0500
Received: from vie01a-dmta-pe04-2.mx.upcmail.net ([62.179.121.164]:57285 "EHLO
        vie01a-dmta-pe04-2.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231732AbhKWTV6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Nov 2021 14:21:58 -0500
Received: from [172.31.216.234] (helo=vie01a-pemc-psmtp-pe11.mail.upcmail.net)
        by vie01a-dmta-pe04.mx.upcmail.net with esmtp (Exim 4.92)
        (envelope-from <thomas.zeitlhofer+lkml@ze-it.at>)
        id 1mpbJX-005Ncw-T4
        for linux-pm@vger.kernel.org; Tue, 23 Nov 2021 20:18:47 +0100
Received: from mr2 ([80.108.17.71])
        by vie01a-pemc-psmtp-pe11.mail.upcmail.net with ESMTP
        id pbJXmWvuk2A4vpbJXm0HWE; Tue, 23 Nov 2021 20:18:47 +0100
X-Env-Mailfrom: thomas.zeitlhofer+lkml@ze-it.at
X-Env-Rcptto: linux-pm@vger.kernel.org
X-SourceIP: 80.108.17.71
X-CNFS-Analysis: v=2.3 cv=bNRo382Z c=1 sm=1 tr=0
 a=dwg5kdmUixIXdJRX1f/MsQ==:117 a=dwg5kdmUixIXdJRX1f/MsQ==:17
 a=kj9zAlcOel0A:10 a=c1rmdDCgkvaRRWvxFoYA:9 a=CjuIK1q_8ugA:10
Date:   Tue, 23 Nov 2021 20:18:43 +0100
From:   Thomas Zeitlhofer <thomas.zeitlhofer+lkml@ze-it.at>
To:     linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH] PM: hibernate: use correct mode for swsusp_close()
Message-ID: <YZ0+k4Vy7SJ1D8kH@x1.ze-it.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CMAE-Envelope: MS4wfAHb0jGF07yZv3TJTeIvXA2B0i5C5HK2SAp/VDGyXpWQUijMAR3PsHPUZTaNdUZyseaH1DD00YEaihLlTBtXLKHpKzqiJ32lF0n+0CHUTqU1jIQw5tJ0
 JhX/xPYAD2rOr36kpI15GHJ6DPxAMyaVttLi0usb7DtTRMFuWaAshu7a/BGuIWTwMQzvydB9gzkOVJeX19bRUnCGECyEQ+P43d2LMak3kryEyy5j6IzpaLZ8
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in
swsusp_check()") changed the opening mode of the block device to
(FMODE_READ | FMODE_EXCL).

In the corresponding calls to swsusp_close(), the mode is still just
FMODE_READ which triggers the warning in blkdev_flush_mapping() on resume
from hibernate.

So, use the mode (FMODE_READ | FMODE_EXCL) also when closing the device.

Fixes: 39fbef4b0f77 ("PM: hibernate: Get block device exclusively in swsusp_check()")
Signed-off-by: Thomas Zeitlhofer <thomas.zeitlhofer+lkml@ze-it.at>

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 559acef3fddb..b0888e9224da 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -691,7 +691,7 @@ static int load_image_and_restore(void)
 		goto Unlock;
 
 	error = swsusp_read(&flags);
-	swsusp_close(FMODE_READ);
+	swsusp_close(FMODE_READ | FMODE_EXCL);
 	if (!error)
 		error = hibernation_restore(flags & SF_PLATFORM_MODE);
 
@@ -981,7 +981,7 @@ static int software_resume(void)
 	/* The snapshot device should not be opened while we're running */
 	if (!hibernate_acquire()) {
 		error = -EBUSY;
-		swsusp_close(FMODE_READ);
+		swsusp_close(FMODE_READ | FMODE_EXCL);
 		goto Unlock;
 	}
 
@@ -1016,7 +1016,7 @@ static int software_resume(void)
 	pm_pr_dbg("Hibernation image not present or could not be loaded.\n");
 	return error;
  Close_Finish:
-	swsusp_close(FMODE_READ);
+	swsusp_close(FMODE_READ | FMODE_EXCL);
 	goto Finish;
 }
 
