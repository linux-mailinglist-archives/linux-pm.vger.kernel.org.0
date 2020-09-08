Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79103260BEB
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 09:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgIHH0Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 03:26:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43822 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbgIHH0X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 03:26:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0887JCrE066271;
        Tue, 8 Sep 2020 07:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=bawZ+qkotJJUNR3jAzaw4OMRLke9UerfCkDJof+Pk2o=;
 b=r09QjtYOWQuYJlWBzVXwnbFqfSatriWYDe/PR35BhgwqArEGkZnPN+g1wbhjOFPhNs8e
 danQd4r8jWOgN2mliGbgWY/EZD0ETS3/AyfPEKMfYioKUzLc6rDizyoTw+6uIxICnKxl
 eLy2rb8eooVHDVmyVICrzplnDbPh3fi6RYMyp+DaWoDwhs7gAHgKRqqaIcxrb/STZb+P
 pMV5qrZHxy3+RekIe3Gk9fDV15diamNlWtAC8uiRmcLUzajxhp4ADM+OV0tCEG1JyMqv
 lXTdWXvFi/vJEC/Sqa+VM8oNOcWudZxlWDgpkxwvAx852nGO9ZKNX2u6kwvWlOVEleMI 3w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 33c23qskxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 08 Sep 2020 07:26:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0887QHcc119885;
        Tue, 8 Sep 2020 07:26:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 33cmkvfg79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Sep 2020 07:26:17 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0887Q57x027851;
        Tue, 8 Sep 2020 07:26:05 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Sep 2020 00:26:05 -0700
Date:   Tue, 8 Sep 2020 10:25:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] PM / devfreq: tegra30:  disable clock on error in probe
Message-ID: <20200908072557.GC294938@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9737 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009080069
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9737 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009080068
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This error path needs to call clk_disable_unprepare().

Fixes: 7296443b900e ("PM / devfreq: tegra30: Handle possible round-rate error")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
---
 drivers/devfreq/tegra30-devfreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index e94a27804c20..dedd39de7367 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -836,7 +836,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	rate = clk_round_rate(tegra->emc_clock, ULONG_MAX);
 	if (rate < 0) {
 		dev_err(&pdev->dev, "Failed to round clock rate: %ld\n", rate);
-		return rate;
+		err = rate;
+		goto disable_clk;
 	}
 
 	tegra->max_freq = rate / KHZ;
@@ -897,6 +898,7 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	dev_pm_opp_remove_all_dynamic(&pdev->dev);
 
 	reset_control_reset(tegra->reset);
+disable_clk:
 	clk_disable_unprepare(tegra->clock);
 
 	return err;
-- 
2.28.0

