Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B74E1D95CE
	for <lists+linux-pm@lfdr.de>; Tue, 19 May 2020 14:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgESMDM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 May 2020 08:03:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35138 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgESMDM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 May 2020 08:03:12 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04JC36om118363;
        Tue, 19 May 2020 12:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=jZMwShTybmkTcclY7Hu7TMQtBKNHU0kfnfdEefM5Djc=;
 b=nvw9x9cCXDnrZfr+ZyndNBmyYBPPCq1zPmjWFE7zQzj7Z4BKoPtPJmoJlJOKArU5GcNX
 dvslc2mwYalwGfZAXunPNoAGqbgl755QtePkh5Mg19TcyeHyTGcUOdu9KvqJ+xWyRYYu
 GtZ9QE57p8qmLGSU3uIuHTYdgqtC9J+YAohb5smZdUUOk9a5Y+TTa4HaF6sb6DdEHyxo
 9+GHC/YEbmpPER/hScfGXxrUIhnZEH2Te9Sj1wjy/wPIzTIvZJhUbr+7+rQ2xn+4+Af/
 0LwrCxmlCNQ8mHrkyFgeliJCjyaQwYipqu9KTmkX6NmiDcVFYks3yoJvHnaFTnBrP9da gg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3127kr4x23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 May 2020 12:02:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04JC2XEk084199;
        Tue, 19 May 2020 12:02:40 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 313gj1j6q5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 May 2020 12:02:40 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04JC2bH1018200;
        Tue, 19 May 2020 12:02:39 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 May 2020 05:02:37 -0700
Date:   Tue, 19 May 2020 15:02:31 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     k.konieczny@samsung.com
Cc:     linux-pm@vger.kernel.org
Subject: [bug report] opp: core: add regulators enable and disable
Message-ID: <20200519120231.GB42765@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9625 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=3 mlxlogscore=836
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005190109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9625 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 impostorscore=0
 suspectscore=3 mlxlogscore=867 malwarescore=0 cotscore=-2147483648
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005190109
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Kamil Konieczny,

This is a semi-automatic email about new static checker warnings.

The patch f4111e2e1ae1: "opp: core: add regulators enable and
disable" from Jul 19, 2019, leads to the following Smatch complaint:

    drivers/opp/core.c:846 dev_pm_opp_set_rate()
    error: we previously assumed 'opp_table->regulators' could be null (see line 840)

drivers/opp/core.c
   839	
   840			if (!opp_table->required_opp_tables && !opp_table->regulators) {
                                                            ^^
Should this && be ||?

   841				dev_err(dev, "target frequency can't be 0\n");
                                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^
This error message is confusing.

   842				ret = -EINVAL;
   843			}
   844	
   845			if (opp_table->regulator_enabled) {
   846				regulator_disable(opp_table->regulators[0]);
                                                  ^^^^^^^^^^^^^^^^^^^^^
Unchecked dereference.

   847				opp_table->regulator_enabled = false;
   848			}

regards,
dan carpenter
