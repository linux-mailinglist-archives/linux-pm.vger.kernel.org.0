Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFB58BDCA0
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 13:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732096AbfIYLDt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 07:03:49 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52906 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbfIYLDt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2019 07:03:49 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8PAsTQT039691;
        Wed, 25 Sep 2019 11:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=IYWpZAQIHKMc6HkvVn4XgPwE5pwLThlzNnT3qmCRbPo=;
 b=IX0zGerXgD1H5vfYuZXU7fvQQ8aDHhF3hnfDwVea5a5ZtZJlZwAyuX/L6892Wj1ryqjH
 ETjTJymm0/2XQ+9mxsOLThtKrd+z89RaQdk91vSbDIheoUhxjEwKw33/ALPA+5Z/CWHu
 P9Yt3mqiQG11dSIHOQpwOFXO6y0jMnBNRaetX5vfEV4NU8J/srdLy5nmi8nrJVe7vMIY
 KXZD/gvdjWNBWOvkAj30lyEMOX95XgJeg9a6kMEWnyOMuNuUSvk+sFfXFURK9LOv3Nmi
 Liy9OlYsXZL3IBItFmiDDKGH1BzaQpr9qMqKAwjOoaXlJL2H1lypbDONk3V0eHJ9R+K6 WQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2v5btq3wnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Sep 2019 11:03:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8PAwlNG034178;
        Wed, 25 Sep 2019 11:01:43 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2v7vnxsdxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Sep 2019 11:01:43 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8PB1gAC029816;
        Wed, 25 Sep 2019 11:01:43 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Sep 2019 04:01:41 -0700
Date:   Wed, 25 Sep 2019 14:01:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rhyland Klein <rklein@nvidia.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] power: supply: sbs-battery: Fix a signedness bug in
 sbs_get_battery_capacity()
Message-ID: <20190925110128.GM3264@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9390 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909250112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9390 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909250112
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The "mode" variable is an enum and in this context GCC treats it as an
unsigned int so the error handling is never triggered.

Fixes: 51d075660457 ("bq20z75: Add support for charge properties")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/power/supply/sbs-battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index f8d74e9f7931..62110af1abcf 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -555,7 +555,7 @@ static int sbs_get_battery_capacity(struct i2c_client *client,
 		mode = BATTERY_MODE_AMPS;
 
 	mode = sbs_set_battery_mode(client, mode);
-	if (mode < 0)
+	if ((int)mode < 0)
 		return mode;
 
 	ret = sbs_read_word_data(client, sbs_data[reg_offset].addr);
-- 
2.20.1

