Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B8E3458CA
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 08:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhCWHe2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 03:34:28 -0400
Received: from inva020.nxp.com ([92.121.34.13]:38636 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhCWHd6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Mar 2021 03:33:58 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 114F61A1D04;
        Tue, 23 Mar 2021 08:33:55 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 50E221A1D09;
        Tue, 23 Mar 2021 08:33:50 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8376A402AC;
        Tue, 23 Mar 2021 08:33:44 +0100 (CET)
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V2 RESEND 3/4] PM / devfreq: bail out early if no freq changes in devfreq_set_target
Date:   Tue, 23 Mar 2021 15:20:10 +0800
Message-Id: <1616484011-26702-4-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616484011-26702-1-git-send-email-aisheng.dong@nxp.com>
References: <1616484011-26702-1-git-send-email-aisheng.dong@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's unnecessary to set the same freq again and run notifier calls.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/devfreq/devfreq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 85927bd7ee76..a6ee91dd17bd 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -352,13 +352,16 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 {
 	struct devfreq_freqs freqs;
 	unsigned long cur_freq;
-	int err = 0;
+	int err;
 
 	if (devfreq->profile->get_cur_freq)
 		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
 	else
 		cur_freq = devfreq->previous_freq;
 
+	if (new_freq == cur_freq)
+		return 0;
+
 	freqs.old = cur_freq;
 	freqs.new = new_freq;
 	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
@@ -375,7 +378,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 	 * and DEVFREQ_POSTCHANGE because for showing the correct frequency
 	 * change order of between devfreq device and passive devfreq device.
 	 */
-	if (trace_devfreq_frequency_enabled() && new_freq != cur_freq)
+	if (trace_devfreq_frequency_enabled())
 		trace_devfreq_frequency(devfreq, new_freq, cur_freq);
 
 	freqs.new = new_freq;
@@ -390,7 +393,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 	if (devfreq->suspend_freq)
 		devfreq->resume_freq = new_freq;
 
-	return err;
+	return 0;
 }
 
 /**
-- 
2.25.1

