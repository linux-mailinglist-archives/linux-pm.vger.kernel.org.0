Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D12332642
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 14:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhCINM5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 08:12:57 -0500
Received: from inva021.nxp.com ([92.121.34.21]:57958 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230421AbhCINMg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Mar 2021 08:12:36 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B9DD0200FD1;
        Tue,  9 Mar 2021 14:12:34 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 93152200FC4;
        Tue,  9 Mar 2021 14:12:28 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id AC10B402A7;
        Tue,  9 Mar 2021 14:12:19 +0100 (CET)
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 10/11] PM / devfreq: imx8m-ddrc: remove imx8m_ddrc_get_dev_status
Date:   Tue,  9 Mar 2021 20:58:40 +0800
Message-Id: <1615294733-22761-11-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Current driver actually does not support simple ondemand governor
as it's unable to provide device load information. So removing
the unnecessary callback to avoid confusing.
Right now the driver is using userspace governor by default.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/devfreq/imx8m-ddrc.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
index bc82d3653bff..0a6b7a1c829d 100644
--- a/drivers/devfreq/imx8m-ddrc.c
+++ b/drivers/devfreq/imx8m-ddrc.c
@@ -280,18 +280,6 @@ static int imx8m_ddrc_get_cur_freq(struct device *dev, unsigned long *freq)
 	return 0;
 }
 
-static int imx8m_ddrc_get_dev_status(struct device *dev,
-				     struct devfreq_dev_status *stat)
-{
-	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
-
-	stat->busy_time = 0;
-	stat->total_time = 0;
-	stat->current_frequency = clk_get_rate(priv->dram_core);
-
-	return 0;
-}
-
 static int imx8m_ddrc_init_freq_info(struct device *dev)
 {
 	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
@@ -431,7 +419,6 @@ static int imx8m_ddrc_probe(struct platform_device *pdev)
 
 	priv->profile.polling_ms = 1000;
 	priv->profile.target = imx8m_ddrc_target;
-	priv->profile.get_dev_status = imx8m_ddrc_get_dev_status;
 	priv->profile.exit = imx8m_ddrc_exit;
 	priv->profile.get_cur_freq = imx8m_ddrc_get_cur_freq;
 	priv->profile.initial_freq = clk_get_rate(priv->dram_core);
-- 
2.25.1

