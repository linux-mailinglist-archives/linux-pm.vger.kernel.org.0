Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E216A121DB
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 20:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfEBS10 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 May 2019 14:27:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42020 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBS10 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2019 14:27:26 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gportay)
        with ESMTPSA id 330D6260AC5
From:   =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org
Cc:     =?utf-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>
Subject: [PATCH] PM / devfreq: Fix spelling typo
Date:   Thu,  2 May 2019 14:27:36 -0400
Message-Id: <20190502182736.5587-1-gael.portay@collabora.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add missing 'r' in "monitoing".

Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
---
 drivers/devfreq/devfreq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 0ae3de76833b..20d1afa2d474 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -400,7 +400,7 @@ static void devfreq_monitor(struct work_struct *work)
  * devfreq_monitor_start() - Start load monitoring of devfreq instance
  * @devfreq:	the devfreq instance.
  *
- * Helper function for starting devfreq device load monitoing. By
+ * Helper function for starting devfreq device load monitoring. By
  * default delayed work based monitoring is supported. Function
  * to be called from governor in response to DEVFREQ_GOV_START
  * event when device is added to devfreq framework.
@@ -418,7 +418,7 @@ EXPORT_SYMBOL(devfreq_monitor_start);
  * devfreq_monitor_stop() - Stop load monitoring of a devfreq instance
  * @devfreq:	the devfreq instance.
  *
- * Helper function to stop devfreq device load monitoing. Function
+ * Helper function to stop devfreq device load monitoring. Function
  * to be called from governor in response to DEVFREQ_GOV_STOP
  * event when device is removed from devfreq framework.
  */
@@ -432,7 +432,7 @@ EXPORT_SYMBOL(devfreq_monitor_stop);
  * devfreq_monitor_suspend() - Suspend load monitoring of a devfreq instance
  * @devfreq:	the devfreq instance.
  *
- * Helper function to suspend devfreq device load monitoing. Function
+ * Helper function to suspend devfreq device load monitoring. Function
  * to be called from governor in response to DEVFREQ_GOV_SUSPEND
  * event or when polling interval is set to zero.
  *
@@ -459,7 +459,7 @@ EXPORT_SYMBOL(devfreq_monitor_suspend);
  * devfreq_monitor_resume() - Resume load monitoring of a devfreq instance
  * @devfreq:    the devfreq instance.
  *
- * Helper function to resume devfreq device load monitoing. Function
+ * Helper function to resume devfreq device load monitoring. Function
  * to be called from governor in response to DEVFREQ_GOV_RESUME
  * event or when polling interval is set to non-zero.
  */
-- 
2.21.0

