Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD033133B39
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 06:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbgAHFem (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 00:34:42 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:44314 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgAHFem (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 00:34:42 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0085TZAE073063;
        Wed, 8 Jan 2020 05:34:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=Y0nRxvFnlwm/w8fldZ84iPvdgUL+DTApQsSuDHD8AsM=;
 b=mwJJ5uC2acnj6s3YSsWWpSCE0E/pwqD7nT7W7vlTBTU4bbJy4sQT5jxgAiQBiAy5HRF8
 h16OlD44RutT0UJEc9TkA5MRY+Nc8kQWGBFZBgnSDbF8u3AdzSuvdtS3cD4pDQOhbsh1
 yU/YcKhFaERv5vsEROy3/058cY7dtqxzsCa8tBqmSARM9C2t8hvsgoiykhNTkI9Ab0d9
 h9hVDYffOdmIvotqBQqNz6S4vax8RQA1X49q0B/RWpc2XQ2sn+SLW1EQ9JudMEnlnbQt
 eaWcu3ATtTsaOIirb9z5r6LfhoZnZ8p44lwCZfBxR7xMOI5K1GK51TmMzyvGMLWGbnr/ nw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2xajnq1mud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jan 2020 05:34:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0085YA2c014405;
        Wed, 8 Jan 2020 05:34:31 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2xcjvesuxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jan 2020 05:34:31 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0085YTN6010818;
        Wed, 8 Jan 2020 05:34:29 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Jan 2020 21:34:29 -0800
Date:   Wed, 8 Jan 2020 08:34:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andy Gross <agross@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] power: avs: qcom-cpr: Fix error code in
 cpr_fuse_corner_init()
Message-ID: <20200108053418.tjc62uppube6q4q3@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9493 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001080048
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9493 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001080048
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We're returning the wrong variable.  "ret" isn't initialized.

Fixes: bf6910abf548 ("power: avs: Add support for CPR (Core Power Reduction)")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/power/avs/qcom-cpr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/avs/qcom-cpr.c b/drivers/power/avs/qcom-cpr.c
index 9247f53550b3..0321729431a5 100644
--- a/drivers/power/avs/qcom-cpr.c
+++ b/drivers/power/avs/qcom-cpr.c
@@ -922,7 +922,7 @@ static int cpr_fuse_corner_init(struct cpr_drv *drv)
 		uV = cpr_read_fuse_uV(desc, fdata, fuses->init_voltage,
 				      step_volt, drv);
 		if (uV < 0)
-			return ret;
+			return uV;
 
 		fuse->min_uV = fdata->min_uV;
 		fuse->max_uV = fdata->max_uV;
-- 
2.11.0

