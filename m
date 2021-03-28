Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D148F34BC03
	for <lists+linux-pm@lfdr.de>; Sun, 28 Mar 2021 12:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbhC1K0H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Mar 2021 06:26:07 -0400
Received: from comms.puri.sm ([159.203.221.185]:56192 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230209AbhC1KZ4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 28 Mar 2021 06:25:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 347E2E01BB;
        Sun, 28 Mar 2021 03:25:56 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AQs_YIyE9e5a; Sun, 28 Mar 2021 03:25:55 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     martin.kepplinger@puri.sm
Cc:     bvanassche@acm.org, jejb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-pm@vger.kernel.org, martin.petersen@oracle.com,
        stern@rowland.harvard.edu
Subject: [PATCH v3 4/4] scsi: devinfo: add BLIST_MEDIA_CHANGE for Ultra HS-SD/MMC usb cardreaders
Date:   Sun, 28 Mar 2021 12:25:31 +0200
Message-Id: <20210328102531.1114535-5-martin.kepplinger@puri.sm>
In-Reply-To: <20210328102531.1114535-1-martin.kepplinger@puri.sm>
References: <20210328102531.1114535-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This cardreader device issues a MEDIA CHANGE unit attention not only
when actually a medium changed but also simply when resuming from suspend.
(probably because the device can't know what happens during suspend and
want to say "medium could have changed").

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 drivers/scsi/scsi_devinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
index d92cec12454c..7d6446f81908 100644
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

