Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1F633263D
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 14:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhCINM4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 08:12:56 -0500
Received: from inva020.nxp.com ([92.121.34.13]:46976 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230299AbhCINMe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Mar 2021 08:12:34 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D8C111A09B2;
        Tue,  9 Mar 2021 14:12:32 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B01CA1A1010;
        Tue,  9 Mar 2021 14:12:26 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id AB619402EB;
        Tue,  9 Mar 2021 14:12:15 +0100 (CET)
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 07/11] PM / devfreq: check get_dev_status before start monitor
Date:   Tue,  9 Mar 2021 20:58:37 +0800
Message-Id: <1615294733-22761-8-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The devfreq monitor depends on the device to provide load information
by .get_dev_status() to calculate the next target freq.

And this will cause changing governor to simple ondemand fail
if device can't support.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/devfreq/devfreq.c                 | 10 +++++++---
 drivers/devfreq/governor.h                |  2 +-
 drivers/devfreq/governor_simpleondemand.c |  3 +--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 7231fe6862a2..d1787b6c7d7c 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -482,10 +482,13 @@ static void devfreq_monitor(struct work_struct *work)
  * to be called from governor in response to DEVFREQ_GOV_START
  * event when device is added to devfreq framework.
  */
-void devfreq_monitor_start(struct devfreq *devfreq)
+int devfreq_monitor_start(struct devfreq *devfreq)
 {
 	if (IS_SUPPORTED_FLAG(devfreq->governor->flags, IRQ_DRIVEN))
-		return;
+		return 0;
+
+	if (!devfreq->profile->get_dev_status)
+		return -EINVAL;
 
 	switch (devfreq->profile->timer) {
 	case DEVFREQ_TIMER_DEFERRABLE:
@@ -495,12 +498,13 @@ void devfreq_monitor_start(struct devfreq *devfreq)
 		INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
 		break;
 	default:
-		return;
+		return -EINVAL;
 	}
 
 	if (devfreq->profile->polling_ms)
 		queue_delayed_work(devfreq_wq, &devfreq->work,
 			msecs_to_jiffies(devfreq->profile->polling_ms));
+	return 0;
 }
 EXPORT_SYMBOL(devfreq_monitor_start);
 
diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index 5cee3f64fe2b..31af6d072a10 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -75,7 +75,7 @@ struct devfreq_governor {
 				unsigned int event, void *data);
 };
 
-void devfreq_monitor_start(struct devfreq *devfreq);
+int devfreq_monitor_start(struct devfreq *devfreq);
 void devfreq_monitor_stop(struct devfreq *devfreq);
 void devfreq_monitor_suspend(struct devfreq *devfreq);
 void devfreq_monitor_resume(struct devfreq *devfreq);
diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index d57b82a2b570..ea287b57cbf3 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -89,8 +89,7 @@ static int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
 {
 	switch (event) {
 	case DEVFREQ_GOV_START:
-		devfreq_monitor_start(devfreq);
-		break;
+		return devfreq_monitor_start(devfreq);
 
 	case DEVFREQ_GOV_STOP:
 		devfreq_monitor_stop(devfreq);
-- 
2.25.1

