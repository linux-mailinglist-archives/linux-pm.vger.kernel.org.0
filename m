Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A61A1160F2A
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2020 10:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgBQJsn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Feb 2020 04:48:43 -0500
Received: from inva020.nxp.com ([92.121.34.13]:39958 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgBQJsn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Feb 2020 04:48:43 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1DD311A03D5;
        Mon, 17 Feb 2020 10:48:42 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D20DD1A03B2;
        Mon, 17 Feb 2020 10:48:36 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 46132402A7;
        Mon, 17 Feb 2020 17:48:30 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] cpufreq: imx-cpufreq-dt: Add "cpu-supply" property check
Date:   Mon, 17 Feb 2020 17:42:55 +0800
Message-Id: <1581932575-13177-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cpufreq-dt driver allows cpufreq driver enabled without valid
regulator assigned, however, all i.MX platforms using cpufreq-dt
driver now require valid regulator, add "cpu-supply" property check
to avoid i.MX platforms' cpufreq enabled without valid regulator
and lead to system unstable.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/cpufreq/imx-cpufreq-dt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpufreq-dt.c
index 6cb8193..0e29d88 100644
--- a/drivers/cpufreq/imx-cpufreq-dt.c
+++ b/drivers/cpufreq/imx-cpufreq-dt.c
@@ -31,6 +31,9 @@ static int imx_cpufreq_dt_probe(struct platform_device *pdev)
 	int speed_grade, mkt_segment;
 	int ret;
 
+	if (!of_find_property(cpu_dev->of_node, "cpu-supply", NULL))
+		return -ENODEV;
+
 	ret = nvmem_cell_read_u32(cpu_dev, "speed_grade", &cell_value);
 	if (ret)
 		return ret;
-- 
2.7.4

