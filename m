Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D754E1C6E23
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 12:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbgEFKNe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 06:13:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38392 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbgEFKNe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2020 06:13:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046A7gKA057628;
        Wed, 6 May 2020 10:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=rGiMFnz3aalGI9XNT+6CwURr7hDON45HJKdkM6LWG2Y=;
 b=b8XY/VmknTvMtZeSuTcJ7GZaxlqigUfCk7VnMPqiNs4tgYBVYb1Mzr0uQxYwm+MW6hLI
 29i+1JZBt4O8ZRoRW3K3nD5FaEx3/qityOeNKOBM1K8zUWmNPg6GRqg/kJouJr/5DZAH
 KY+ZdMh/eow2h3Jg6ct4fvl2aj2U9MgxvFbtusAGZcbqftzkRWXdjzcLUjkEfm436XsJ
 70lEL1uOS/GW/n53YGzcadEoyIUBBsC6BBeae/F6AHMnlzlV6Ak7esMv8UdDATmpLBDR
 OCmCrP1Cr9E191qy5HxIutlx6fSvd9HDyjOEIu+VBVTlcG3IOjNV7mLDUzHMyC4y+F1y 9A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 30s09r9hm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 10:13:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046A4val023704;
        Wed, 6 May 2020 10:11:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 30sjdv4v3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 10:11:24 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 046ABMFi013926;
        Wed, 6 May 2020 10:11:22 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 03:11:21 -0700
Date:   Wed, 6 May 2020 13:11:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sebastian Reichel <sre@kernel.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] power: bq25890: unlock on error paths in bq25890_resume()
Message-ID: <20200506101116.GA77004@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005060079
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We introduced some new locking here, but need to update the error
paths so they unlock before returning.

Fixes: 72d9cd9cdc18 ("power: bq25890: protect view of the chip's state")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/power/supply/bq25890_charger.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 9339e216651ff..20b9824ef5acd 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -978,21 +978,22 @@ static int bq25890_resume(struct device *dev)
 
 	ret = bq25890_get_chip_state(bq, &bq->state);
 	if (ret < 0)
-		return ret;
+		goto unlock;
 
 	/* Re-enable ADC only if charger is plugged in. */
 	if (bq->state.online) {
 		ret = bq25890_field_write(bq, F_CONV_START, 1);
 		if (ret < 0)
-			return ret;
+			goto unlock;
 	}
 
 	/* signal userspace, maybe state changed while suspended */
 	power_supply_changed(bq->charger);
 
+unlock:
 	mutex_unlock(&bq->lock);
 
-	return 0;
+	return ret;
 }
 #endif
 
-- 
2.26.2

