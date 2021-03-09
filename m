Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A07D332638
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 14:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhCINMz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 08:12:55 -0500
Received: from inva020.nxp.com ([92.121.34.13]:46896 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229900AbhCINM3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Mar 2021 08:12:29 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5E0AC1A100D;
        Tue,  9 Mar 2021 14:12:28 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 388151A1005;
        Tue,  9 Mar 2021 14:12:22 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 6873440310;
        Tue,  9 Mar 2021 14:12:11 +0100 (CET)
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 04/11] PM / devfreq: bail out early if no freq changes in devfreq_set_target
Date:   Tue,  9 Mar 2021 20:58:34 +0800
Message-Id: <1615294733-22761-5-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's unnecessary to set the same freq again and run notifier calls.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/devfreq/devfreq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index bf3047896e41..6e80bf70e7b3 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -358,6 +358,9 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 	else
 		cur_freq = devfreq->previous_freq;
 
+	if (new_freq == cur_freq)
+		return 0;
+
 	freqs.old = cur_freq;
 	freqs.new = new_freq;
 	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
@@ -374,7 +377,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 	 * and DEVFREQ_POSTCHANGE because for showing the correct frequency
 	 * change order of between devfreq device and passive devfreq device.
 	 */
-	if (trace_devfreq_frequency_enabled() && new_freq != cur_freq)
+	if (trace_devfreq_frequency_enabled())
 		trace_devfreq_frequency(devfreq, new_freq, cur_freq);
 
 	freqs.new = new_freq;
-- 
2.25.1

