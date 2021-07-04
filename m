Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C8C3BABE7
	for <lists+linux-pm@lfdr.de>; Sun,  4 Jul 2021 09:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhGDH4z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 03:56:55 -0400
Received: from comms.puri.sm ([159.203.221.185]:33876 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229492AbhGDH4z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 4 Jul 2021 03:56:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id E0C7FDFF0F;
        Sun,  4 Jul 2021 00:54:19 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fT1MghGrs0sK; Sun,  4 Jul 2021 00:54:18 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     martin.kepplinger@puri.sm, bvanassche@acm.org
Cc:     hch@infradead.org, jejb@linux.ibm.com, kernel@puri.sm,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        stern@rowland.harvard.edu
Subject: [PATCH v6 1/3] scsi: devinfo: add new flag BLIST_MEDIA_CHANGE
Date:   Sun,  4 Jul 2021 09:54:01 +0200
Message-Id: <20210704075403.147114-2-martin.kepplinger@puri.sm>
In-Reply-To: <20210704075403.147114-1-martin.kepplinger@puri.sm>
References: <20210704075403.147114-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

add a new flag for devices that issue MEDIA CHANGE unit attentions
when actually no medium changed. Drivers can then act accordingly in
case they need to work around it, i.e. in resume().

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
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

