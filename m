Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B6F33264D
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 14:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhCINNC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 08:13:02 -0500
Received: from inva021.nxp.com ([92.121.34.21]:58492 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230521AbhCINMx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Mar 2021 08:12:53 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BBE79200FBB;
        Tue,  9 Mar 2021 14:12:52 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 93E9D200FAC;
        Tue,  9 Mar 2021 14:12:46 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1A959402AC;
        Tue,  9 Mar 2021 14:12:39 +0100 (CET)
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 11/11] PM / devfreq: imx8m-ddrc: drop polling_ms
Date:   Tue,  9 Mar 2021 20:58:53 +0800
Message-Id: <1615294733-22761-24-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

polling_ms is only used by simple ondemand governor which
this driver can't support. Drop it to avoid confusing.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/devfreq/imx8m-ddrc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
index 0a6b7a1c829d..ecb9375aa877 100644
--- a/drivers/devfreq/imx8m-ddrc.c
+++ b/drivers/devfreq/imx8m-ddrc.c
@@ -417,7 +417,6 @@ static int imx8m_ddrc_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err;
 
-	priv->profile.polling_ms = 1000;
 	priv->profile.target = imx8m_ddrc_target;
 	priv->profile.exit = imx8m_ddrc_exit;
 	priv->profile.get_cur_freq = imx8m_ddrc_get_cur_freq;
-- 
2.25.1

