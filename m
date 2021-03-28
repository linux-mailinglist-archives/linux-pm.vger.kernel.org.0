Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76E534BC0B
	for <lists+linux-pm@lfdr.de>; Sun, 28 Mar 2021 12:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhC1K0l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Mar 2021 06:26:41 -0400
Received: from comms.puri.sm ([159.203.221.185]:56204 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230209AbhC1K0X (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 28 Mar 2021 06:26:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id D4BC1E01F7;
        Sun, 28 Mar 2021 03:25:53 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ePzUWSYUeNv5; Sun, 28 Mar 2021 03:25:53 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     martin.kepplinger@puri.sm
Cc:     bvanassche@acm.org, jejb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-pm@vger.kernel.org, martin.petersen@oracle.com,
        stern@rowland.harvard.edu
Subject: [PATCH v3 3/4] scsi: sd: use expecting_media_change for BLIST_MEDIA_CHANGE devices
Date:   Sun, 28 Mar 2021 12:25:30 +0200
Message-Id: <20210328102531.1114535-4-martin.kepplinger@puri.sm>
In-Reply-To: <20210328102531.1114535-1-martin.kepplinger@puri.sm>
References: <20210328102531.1114535-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For SD cardreader devices that have the BLIST_MEDIA_CHANGE flag set,
ignore one MEDIA CHANGE unit attention after resuming from runtime
suspend. These devices issue said unit attention when resuming
even when no medium changed.

expecting_media_change is the device flag that is being clearing in
the error path.

The "downside" is that for these devices we now rely on users not to
really change the medium (SD card) *during* a runtime suspend/resume
cycle, i.e. when not unmounting.

Since these devices don't distinguish between resume and medium changed
there's no better solution.

To enable runtime PM for an SD cardreader (device number 0:0:0:0), do:

echo 0 > /sys/module/block/parameters/events_dfl_poll_msecs
echo 1000 > /sys/bus/scsi/devices/0:0:0:0/power/autosuspend_delay_ms
echo auto > /sys/bus/scsi/devices/0:0:0:0/power/control

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 drivers/scsi/sd.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 91c34ee972c7..0a6413a4c629 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -63,6 +63,7 @@
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_dbg.h>
 #include <scsi/scsi_device.h>
+#include <scsi/scsi_devinfo.h>
 #include <scsi/scsi_driver.h>
 #include <scsi/scsi_eh.h>
 #include <scsi/scsi_host.h>
@@ -114,6 +115,7 @@ static void sd_shutdown(struct device *);
 static int sd_suspend_system(struct device *);
 static int sd_suspend_runtime(struct device *);
 static int sd_resume(struct device *);
+static int sd_resume_runtime(struct device *);
 static void sd_rescan(struct device *);
 static blk_status_t sd_init_command(struct scsi_cmnd *SCpnt);
 static void sd_uninit_command(struct scsi_cmnd *SCpnt);
@@ -608,7 +610,7 @@ static const struct dev_pm_ops sd_pm_ops = {
 	.poweroff		= sd_suspend_system,
 	.restore		= sd_resume,
 	.runtime_suspend	= sd_suspend_runtime,
-	.runtime_resume		= sd_resume,
+	.runtime_resume		= sd_resume_runtime,
 };
 
 static struct scsi_driver sd_template = {
@@ -3701,6 +3703,25 @@ static int sd_resume(struct device *dev)
 	return ret;
 }
 
+static int sd_resume_runtime(struct device *dev)
+{
+	struct scsi_disk *sdkp = dev_get_drvdata(dev);
+	struct scsi_device *sdp = sdkp->device;
+	int ret;
+
+	if (!sdkp)	/* E.g.: runtime resume at the start of sd_probe() */
+		return 0;
+
+	/*
+	 * This device issues a MEDIA CHANGE unit attention when
+	 * resuming from suspend. Ignore the next one from now.
+	 */
+	if (sdp->sdev_bflags & BLIST_MEDIA_CHANGE)
+		sdkp->device->expecting_media_change = 1;
+
+	return sd_resume(dev);
+}
+
 /**
  *	init_sd - entry point for this driver (both when built in or when
  *	a module).
-- 
2.30.2

