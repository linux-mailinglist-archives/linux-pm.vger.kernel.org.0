Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4859434BBFE
	for <lists+linux-pm@lfdr.de>; Sun, 28 Mar 2021 12:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhC1K0G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Mar 2021 06:26:06 -0400
Received: from comms.puri.sm ([159.203.221.185]:56142 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230092AbhC1KZt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 28 Mar 2021 06:25:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 71432E01F7;
        Sun, 28 Mar 2021 03:25:49 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xLhsW1HiZtqA; Sun, 28 Mar 2021 03:25:48 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     martin.kepplinger@puri.sm
Cc:     bvanassche@acm.org, jejb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-pm@vger.kernel.org, martin.petersen@oracle.com,
        stern@rowland.harvard.edu
Subject: [PATCH v3 1/4] scsi: add expecting_media_change flag to error path
Date:   Sun, 28 Mar 2021 12:25:28 +0200
Message-Id: <20210328102531.1114535-2-martin.kepplinger@puri.sm>
In-Reply-To: <20210328102531.1114535-1-martin.kepplinger@puri.sm>
References: <20210328102531.1114535-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SD Cardreaders (especially) sometimes lose the state during suspend
and deliver a "media changed" unit attention when really only a
(runtime) suspend/resume cycle has been done.

For such devices, I/O fails when runtime PM is enabled, see below.
That's the motivation to add this flag. If set by a driver the
one following MEDIA CHANGE unit attention will be ignored.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 drivers/scsi/scsi_error.c  | 36 +++++++++++++++++++++++++++++++-----
 include/scsi/scsi_device.h |  1 +
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 08c06c56331c..c62915d34ba4 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -585,6 +585,18 @@ int scsi_check_sense(struct scsi_cmnd *scmd)
 				return NEEDS_RETRY;
 			}
 		}
+		if (scmd->device->expecting_media_change) {
+			if (sshdr.asc == 0x28 && sshdr.ascq == 0x00) {
+				/*
+				 * clear the expecting_media_change in
+				 * scsi_decide_disposition() because we
+				 * need to catch possible "fail fast" overrides
+				 * that block readahead can cause.
+				 */
+				return NEEDS_RETRY;
+			}
+		}
+
 		/*
 		 * we might also expect a cc/ua if another LUN on the target
 		 * reported a UA with an ASC/ASCQ of 3F 0E -
@@ -1977,14 +1989,28 @@ int scsi_decide_disposition(struct scsi_cmnd *scmd)
 	 * the request was not marked fast fail.  Note that above,
 	 * even if the request is marked fast fail, we still requeue
 	 * for queue congestion conditions (QUEUE_FULL or BUSY) */
-	if (scsi_cmd_retry_allowed(scmd) && !scsi_noretry_cmd(scmd)) {
-		return NEEDS_RETRY;
-	} else {
-		/*
-		 * no more retries - report this one back to upper level.
+	if (scsi_cmd_retry_allowed(scmd)) {
+		/* but scsi_noretry_cmd() cannot override the
+		 * expecting_media_change flag.
 		 */
+		if (!scsi_noretry_cmd(scmd) ||
+		    scmd->device->expecting_media_change) {
+			scmd->device->expecting_media_change = 0;
+			return NEEDS_RETRY;
+		}
+
+		/* Not marked fail fast, or marked but not expected.
+		 * Clear the flag too because it's meant for the
+		 * next UA only.
+		 */
+		scmd->device->expecting_media_change = 0;
 		return SUCCESS;
 	}
+
+	/*
+	 * no more retries - report this one back to upper level.
+	 */
+	return SUCCESS;
 }
 
 static void eh_lock_door_done(struct request *req, blk_status_t status)
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 05c7c320ef32..926b42ce1dc4 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -171,6 +171,7 @@ struct scsi_device {
 				 * this device */
 	unsigned expecting_cc_ua:1; /* Expecting a CHECK_CONDITION/UNIT_ATTN
 				     * because we did a bus reset. */
+	unsigned expecting_media_change:1; /* Expecting "media changed" UA */
 	unsigned use_10_for_rw:1; /* first try 10-byte read / write */
 	unsigned use_10_for_ms:1; /* first try 10-byte mode sense/select */
 	unsigned set_dbd_for_ms:1; /* Set "DBD" field in mode sense */
-- 
2.30.2

