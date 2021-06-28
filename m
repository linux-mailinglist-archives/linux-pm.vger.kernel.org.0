Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7491E3B5F05
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jun 2021 15:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhF1NhX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Jun 2021 09:37:23 -0400
Received: from comms.puri.sm ([159.203.221.185]:47356 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232087AbhF1NhA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Jun 2021 09:37:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 8A547E01BB;
        Mon, 28 Jun 2021 06:34:33 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XCCfshehQNc1; Mon, 28 Jun 2021 06:34:32 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     martin.kepplinger@puri.sm
Cc:     bvanassche@acm.org, jejb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        stern@rowland.harvard.edu
Subject: [PATCH v4 1/3] scsi: devinfo: add new flag BLIST_MEDIA_CHANGE
Date:   Mon, 28 Jun 2021 15:34:10 +0200
Message-Id: <20210628133412.1172068-2-martin.kepplinger@puri.sm>
In-Reply-To: <20210628133412.1172068-1-martin.kepplinger@puri.sm>
References: <20210628133412.1172068-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

add a new flag for devices that issue MEDIA CHANGE unit attentions
when actually no medium changed. Drivers can then act accordingly in
case they need to work around it, i.e. in resume().

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 include/scsi/scsi_devinfo.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/scsi/scsi_devinfo.h b/include/scsi/scsi_devinfo.h
index 3fdb322d4c4b..766fa876598e 100644
--- a/include/scsi/scsi_devinfo.h
+++ b/include/scsi/scsi_devinfo.h
@@ -28,7 +28,8 @@
 #define BLIST_LARGELUN		((__force blist_flags_t)(1ULL << 9))
 /* override additional length field */
 #define BLIST_INQUIRY_36	((__force blist_flags_t)(1ULL << 10))
-#define __BLIST_UNUSED_11	((__force blist_flags_t)(1ULL << 11))
+/* ignore one MEDIA CHANGE unit attention after resuming from runtime suspend */
+#define BLIST_MEDIA_CHANGE	((__force blist_flags_t)(1ULL << 11))
 /* do not do automatic start on add */
 #define BLIST_NOSTARTONADD	((__force blist_flags_t)(1ULL << 12))
 #define __BLIST_UNUSED_13	((__force blist_flags_t)(1ULL << 13))
@@ -73,8 +74,7 @@
 #define __BLIST_HIGH_UNUSED (~(__BLIST_LAST_USED | \
 			       (__force blist_flags_t) \
 			       ((__force __u64)__BLIST_LAST_USED - 1ULL)))
-#define __BLIST_UNUSED_MASK (__BLIST_UNUSED_11 | \
-			     __BLIST_UNUSED_13 | \
+#define __BLIST_UNUSED_MASK (__BLIST_UNUSED_13 | \
 			     __BLIST_UNUSED_14 | \
 			     __BLIST_UNUSED_15 | \
 			     __BLIST_UNUSED_16 | \
-- 
2.30.2

