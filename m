Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 878241EAFA
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2019 11:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbfEOJef (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 May 2019 05:34:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43860 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfEOJef (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 May 2019 05:34:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4F9OKDw107179;
        Wed, 15 May 2019 09:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=GUI7ZbGATOrJEgO4TwLWVEHn+UrdekXRQuwSfP9RpvI=;
 b=u0q6UkQ0/t170K/e7xsR0gLqwxWaU/i+UtI+vnDXqSIcjg4p0b7Cwdsg7LTmwFnhFe2Y
 Tkklp2I0VK4pj0+LZc+PqOWyL5km30X+Vex/NNrkyVXj80OypLBknrNUy8qJ6Kjyr3CU
 4Pkjq+kLmP9VUFJ02CkOn4VfBel2XE/UrNkEpl8gfOBRiYPk1B1W5ZSsesBsOcgtYbHx
 CtLZCUg7FvtNYMJtXEMBFLR4Yu5CWR2CW6MouKg+5xmiVw44+FdNuAEcFSz7wUxwK7fS
 Hj1d+WG666of5O0CIpfdzuvRYsjB+Zct8Ze7xlVic4cDeSYZPWkUYPoTM0AfeOf9ezbr 5A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2sdq1qkgrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 May 2019 09:34:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4F9XffB097925;
        Wed, 15 May 2019 09:34:30 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2sdnqk4484-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 May 2019 09:34:30 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4F9YTHN027732;
        Wed, 15 May 2019 09:34:29 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 May 2019 02:34:28 -0700
Date:   Wed, 15 May 2019 12:34:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Talel Shenhar <talel@amazon.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] thermal: mmio: remove some dead code
Message-ID: <20190515093420.GC3409@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9257 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905150061
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9257 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905150061
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The platform_get_resource() function doesn't return error pointers, it
returns NULL.  The way this is normally done, is that we pass the NULL
resource to devm_ioremap_resource() and then check for errors from that.
See the comment in front of devm_ioremap_resource() for more details.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/thermal/thermal_mmio.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/thermal/thermal_mmio.c b/drivers/thermal/thermal_mmio.c
index de3cceea23bc..40524fa13533 100644
--- a/drivers/thermal/thermal_mmio.c
+++ b/drivers/thermal/thermal_mmio.c
@@ -53,13 +53,6 @@ static int thermal_mmio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (IS_ERR(resource)) {
-		dev_err(&pdev->dev,
-			"fail to get platform memory resource (%ld)\n",
-			PTR_ERR(resource));
-		return PTR_ERR(resource);
-	}
-
 	sensor->mmio_base = devm_ioremap_resource(&pdev->dev, resource);
 	if (IS_ERR(sensor->mmio_base)) {
 		dev_err(&pdev->dev, "failed to ioremap memory (%ld)\n",
-- 
2.20.1
