Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8111A3BABEA
	for <lists+linux-pm@lfdr.de>; Sun,  4 Jul 2021 09:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhGDH5A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 03:57:00 -0400
Received: from comms.puri.sm ([159.203.221.185]:33930 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229614AbhGDH47 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 4 Jul 2021 03:56:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 6F293DF4A4;
        Sun,  4 Jul 2021 00:54:24 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZQPgz9CQlyPN; Sun,  4 Jul 2021 00:54:23 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     martin.kepplinger@puri.sm, bvanassche@acm.org
Cc:     hch@infradead.org, jejb@linux.ibm.com, kernel@puri.sm,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        stern@rowland.harvard.edu
Subject: [PATCH v6 3/3] scsi: devinfo: add BLIST_MEDIA_CHANGE for Ultra HS-SD/MMC usb cardreaders
Date:   Sun,  4 Jul 2021 09:54:03 +0200
Message-Id: <20210704075403.147114-4-martin.kepplinger@puri.sm>
In-Reply-To: <20210704075403.147114-1-martin.kepplinger@puri.sm>
References: <20210704075403.147114-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

These cardreader devices issue a MEDIA CHANGE unit attention not only
when actually a medium changed but also simply when resuming from suspend.

Setting the BLIST_MEDIA_CHANGE flag enables using runtime pm for SD cardreaders.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_devinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
index d33355ab6e14..8ac0a11ac541 100644
--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -171,6 +171,7 @@ static struct {
 	{"FUJITSU", "ETERNUS_DXM", "*", BLIST_RETRY_ASC_C1},
 	{"Generic", "USB SD Reader", "1.00", BLIST_FORCELUN | BLIST_INQUIRY_36},
 	{"Generic", "USB Storage-SMC", NULL, BLIST_FORCELUN | BLIST_INQUIRY_36}, /* FW: 0180 and 0207 */
+	{"Generic", "Ultra HS-SD/MMC", "2.09", BLIST_MEDIA_CHANGE | BLIST_INQUIRY_36},
 	{"HITACHI", "DF400", "*", BLIST_REPORTLUN2},
 	{"HITACHI", "DF500", "*", BLIST_REPORTLUN2},
 	{"HITACHI", "DISK-SUBSYSTEM", "*", BLIST_REPORTLUN2},
-- 
2.30.2

