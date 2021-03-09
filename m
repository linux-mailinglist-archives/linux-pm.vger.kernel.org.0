Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F30332643
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 14:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhCINM5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 08:12:57 -0500
Received: from inva021.nxp.com ([92.121.34.21]:57892 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230328AbhCINMf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Mar 2021 08:12:35 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 13BAD200FC9;
        Tue,  9 Mar 2021 14:12:34 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DE767200FAC;
        Tue,  9 Mar 2021 14:12:27 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0CF7740338;
        Tue,  9 Mar 2021 14:12:16 +0100 (CET)
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 08/11] PM / devfreq: check get_dev_status in devfreq_update_stats
Date:   Tue,  9 Mar 2021 20:58:38 +0800
Message-Id: <1615294733-22761-9-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Check .get_dev_status() in devfreq_update_stats in case it's abused
when a device does not provide it.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/devfreq/governor.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index 31af6d072a10..67a6dbdd5d23 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -89,6 +89,9 @@ int devfreq_update_target(struct devfreq *devfreq, unsigned long freq);
 
 static inline int devfreq_update_stats(struct devfreq *df)
 {
+	if (!df->profile->get_dev_status)
+		return -EINVAL;
+
 	return df->profile->get_dev_status(df->dev.parent, &df->last_status);
 }
 #endif /* _GOVERNOR_H */
-- 
2.25.1

