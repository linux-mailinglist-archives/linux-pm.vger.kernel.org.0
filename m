Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C742C3B5F06
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jun 2021 15:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhF1NhY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Jun 2021 09:37:24 -0400
Received: from comms.puri.sm ([159.203.221.185]:47374 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232141AbhF1NhB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Jun 2021 09:37:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 977AAE01BC;
        Mon, 28 Jun 2021 06:34:35 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qDthHyxKZd8L; Mon, 28 Jun 2021 06:34:34 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     martin.kepplinger@puri.sm
Cc:     bvanassche@acm.org, jejb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        stern@rowland.harvard.edu
Subject: [PATCH v4 2/3] scsi: sd: send REQUEST SENSE for BLIST_MEDIA_CHANGE devices in runtime_resume()
Date:   Mon, 28 Jun 2021 15:34:11 +0200
Message-Id: <20210628133412.1172068-3-martin.kepplinger@puri.sm>
In-Reply-To: <20210628133412.1172068-1-martin.kepplinger@puri.sm>
References: <20210628133412.1172068-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For SD cardreader devices that have the BLIST_MEDIA_CHANGE flag set,
a MEDIA CHANGE unit attention is received after resuming from runtime
suspend. Send REQUEST SENSE to avoid that.

The "downside" is that for these devices we now rely on users not to
really change the medium (SD card) *during* a runtime suspend/resume
cycle, i.e. when not unmounting.

To enable runtime PM for an SD cardreader (device number 0:0:0:0), do:

echo 0 > /sys/module/block/parameters/events_dfl_poll_msecs
echo 1000 > /sys/bus/scsi/devices/0:0:0:0/power/autosuspend_delay_ms
echo auto > /sys/bus/scsi/devices/0:0:0:0/power/control

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 drivers/scsi/sd.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 6d2d63629a90..0acc732f1933 100644
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
@@ -3720,6 +3722,39 @@ static int sd_resume(struct device *dev)
 	return ret;
 }
 
+static int sd_resume_runtime(struct device *dev)
+{
+	struct scsi_disk *sdkp = dev_get_drvdata(dev);
+	struct scsi_device *sdp;
+	int timeout, retries, res;
+	struct scsi_sense_hdr my_sshdr;
+
+	if (!sdkp)	/* E.g.: runtime resume at the start of sd_probe() */
+		return 0;
+
+	sdp = sdkp->device;
+	timeout = sdp->request_queue->rq_timeout * SD_FLUSH_TIMEOUT_MULTIPLIER;
+
+	if (sdp->sdev_bflags & BLIST_MEDIA_CHANGE) {
+		for (retries = 3; retries > 0; --retries) {
+			unsigned char cmd[10] = { 0 };
+
+			cmd[0] = REQUEST_SENSE;
+			/*
+			 * Leave the rest of the command zero to indicate
+			 * flush everything.
+			 */
+			res = scsi_execute(sdp, cmd, DMA_NONE, NULL, 0, NULL,
+					   &my_sshdr, timeout,
+					   sdkp->max_retries, 0, RQF_PM, NULL);
+			if (res == 0)
+				break;
+		}
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

