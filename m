Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52A93458C8
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 08:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhCWHe1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 03:34:27 -0400
Received: from inva020.nxp.com ([92.121.34.13]:38562 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229504AbhCWHd6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Mar 2021 03:33:58 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B84381A0A70;
        Tue, 23 Mar 2021 08:33:52 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 05BD71A0A4F;
        Tue, 23 Mar 2021 08:33:48 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 35D15402BB;
        Tue, 23 Mar 2021 08:33:42 +0100 (CET)
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V2 RESEND 1/4] PM / devfreq: Use more accurate returned new_freq as resume_freq
Date:   Tue, 23 Mar 2021 15:20:08 +0800
Message-Id: <1616484011-26702-2-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616484011-26702-1-git-send-email-aisheng.dong@nxp.com>
References: <1616484011-26702-1-git-send-email-aisheng.dong@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the more accurate returned new_freq as resume_freq.
It's the same as how devfreq->previous_freq was updated.

Fixes: 83f8ca45afbf0 ("PM / devfreq: add support for suspend/resume of a
devfreq device")
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index b6d3e7db0b09..85927bd7ee76 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -388,7 +388,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 	devfreq->previous_freq = new_freq;
 
 	if (devfreq->suspend_freq)
-		devfreq->resume_freq = cur_freq;
+		devfreq->resume_freq = new_freq;
 
 	return err;
 }
-- 
2.25.1

