Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1367B1C5A7
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2019 11:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfENJGt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 May 2019 05:06:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47144 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfENJGs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 May 2019 05:06:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4E94G1o081272;
        Tue, 14 May 2019 09:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=AFcPid8g1evBUZbdGB5w31PAavHQp4SXmHUvWUHa/V4=;
 b=T283ubYR2SjszhxiJktfMFutYpivzz3oQAt0HLtUk8qE/wsdlem/pC6AMX8mFwfyzbWA
 hleQ+aalGa0KEsaoGqtbZAGyQf3FvM4DqrGIrp4lf8bjGFRhGA5xXLjozzlwYELAwaL6
 opSwqkS3xJ+9ke5xgTe7t5/2f9XU/cn9BxXqx4aZAc+NYTgfINPHwwGf7MB8ewTXpvJ8
 F/v1fj06Bly8QylsIUTsmQj/OeNP0sCvLe27xZQCzatIvgkGPXsHLZleVdjXA/Pa7sBT
 JCAi3E6ymjO4y4tpm4mBGftRUZ6+AUsQlLECsSrxXGQOV6yvMqFuN2h786bZ19RR0HSL vA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2sdnttmhe9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 09:06:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4E96AbX104265;
        Tue, 14 May 2019 09:06:43 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2sf3cn53eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 09:06:43 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4E96gIV012039;
        Tue, 14 May 2019 09:06:42 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 May 2019 02:06:42 -0700
Date:   Tue, 14 May 2019 12:06:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     amit.kucheria@linaro.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [bug report] drivers: thermal: tsens: Merge tsens-8974 into
 tsens-v0_1
Message-ID: <20190514090635.GA21833@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9256 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=575
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905140066
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9256 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=607 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905140067
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Amit Kucheria,

The patch c80cbb79e851: "drivers: thermal: tsens: Merge tsens-8974
into tsens-v0_1" from Mar 20, 2019, leads to the following static
checker warning:

	drivers/thermal/qcom/tsens-v0_1.c:237 calibrate_8974()
	warn: mask and shift to zero

drivers/thermal/qcom/tsens-v0_1.c
   226                  case ONE_PT_CALIB:
   227                  case ONE_PT_CALIB2:
   228                          base1 = bkp[0] & BASE1_MASK;
   229                          p1[0] = (bkp[0] & S0_P1_MASK) >> S0_P1_SHIFT;
   230                          p1[1] = (bkp[0] & S1_P1_MASK) >> S1_P1_SHIFT;
   231                          p1[2] = (bkp[0] & S2_P1_MASK) >> S2_P1_SHIFT;
   232                          p1[3] = (bkp[0] & S3_P1_MASK) >> S3_P1_SHIFT;
   233                          p1[4] = (bkp[1] & S4_P1_MASK);
   234                          p1[5] = (bkp[1] & S5_P1_MASK) >> S5_P1_SHIFT;
   235                          p1[6] = (bkp[1] & S6_P1_MASK) >> S6_P1_SHIFT;
   236                          p1[7] = (bkp[1] & S7_P1_MASK) >> S7_P1_SHIFT;
   237                          p1[8] = (bkp[2] & S8_P1_MASK_BKP) >> S8_P1_SHIFT;
                                                  ^^^^^^^^^^^^^^     ^^^^^^^^^^^
#define S8_P1_MASK_BKP          0x3f
#define S8_P1_SHIFT 24

Other places define S8_P1_SHIFT as 4, so that's maybe something to
consider.

   238                          p1[9] = (bkp[2] & S9_P1_MASK_BKP) >> S9_P1_BKP_SHIFT;
   239                          p1[10] = (bkp[2] & S10_P1_MASK_BKP) >> S10_P1_BKP_SHIFT;
   240                          break;
   241                  }
   242          } else {
   243                  mode = (calib[1] & CAL_SEL_0_1) >> CAL_SEL_SHIFT;
   244                  mode |= (calib[3] & CAL_SEL_2) >> CAL_SEL_SHIFT_2;

regards,
dan carpenter
