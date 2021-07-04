Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D60F3BABF0
	for <lists+linux-pm@lfdr.de>; Sun,  4 Jul 2021 09:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhGDH51 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 03:57:27 -0400
Received: from comms.puri.sm ([159.203.221.185]:34052 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhGDH50 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 4 Jul 2021 03:57:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 13087DF30C;
        Sun,  4 Jul 2021 00:54:22 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zPZxBJM7Ax6i; Sun,  4 Jul 2021 00:54:21 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     martin.kepplinger@puri.sm, bvanassche@acm.org
Cc:     hch@infradead.org, jejb@linux.ibm.com, kernel@puri.sm,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        stern@rowland.harvard.edu
Subject: [PATCH v6 2/3] scsi: sd: send REQUEST SENSE for BLIST_MEDIA_CHANGE devices in runtime_resume()
Date:   Sun,  4 Jul 2021 09:54:02 +0200
Message-Id: <20210704075403.147114-3-martin.kepplinger@puri.sm>
In-Reply-To: <20210704075403.147114-1-martin.kepplinger@puri.sm>
References: <20210704075403.147114-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For SD cardreader devices that have the BLIST_MEDIA_CHANGE flag set,
a MEDIA CHANGE unit attention is received after resuming from runtime
suspend. Send a REQUEST SENSE to avoid that.

The "downside" is that for these devices we now rely on users not to
really change the medium (SD card) *during* a runtime suspend/resume
cycle, i.e. when not unmounting.

To enable runtime PM for an SD cardreader (device number 0:0:0:0), do:

echo 0 > /sys/module/block/parameters/events_dfl_poll_msecs
echo 1000 > /sys/bus/scsi/devices/0:0:0:0/power/autosuspend_delay_ms
echo auto > /sys/bus/scsi/devices/0:0:0:0/power/control

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/sd.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 6d2d63629a90..34554224b89a 100644
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
@@ -3720,6 +3722,25 @@ static int sd_resume(struct device *dev)
 	return ret;
 }
 
+static int sd_resume_runtime(struct device *dev)
+{
+	struct scsi_disk *sdkp = dev_get_drvdata(dev);
+	struct scsi_device *sdp = sdkp->device;
+
+	if (sdp->sdev_bflags & BLIST_MEDIA_CHANGE) {
+		/* clear the devices' sense data */
+		static const u8 cmd[10] = { REQUEST_SENSE };
+
+		if (scsi_execute(sdp, cmd, DMA_NONE, NULL, 0, NULL,
+				 NULL, sdp->request_queue->rq_timeout, 1, 0,
+				 RQF_PM, NULL))
+			sd_printk(KERN_NOTICE, sdkp,
+				  "Failed to clear sense data\n");
+	}
+
+	return sd_resume(dev);
+}
+
 /**
  *	init_sd - entry point for this driver (both when built in or when
  *	a module).
-- 
2.30.2

