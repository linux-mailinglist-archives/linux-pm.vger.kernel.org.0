Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8659E1C0A
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 15:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391235AbfJWNNe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 09:13:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47540 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391166AbfJWNNd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2019 09:13:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9ND9KoV145856;
        Wed, 23 Oct 2019 13:13:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=/V+jrEbYQL21SB6hbLXZllu4Hk/oxIkJfbhRlkAi2W4=;
 b=NFT/60ctEzC6gSf6EJTLvuNaagzoje6qdDZXFh+OVlyBlRuhkaIeFPJdZf4Svtgkg7y8
 fkKajPprtUgmRIIcj26Zdn9ZspcsqR6jqz10oilSxJT+MdUd8Pna2AWbHI8cLAg/4vW1
 Cz2bVtgAi4dmhkYi1ATvrM1ff9vZsVhZccXaqnVAnJqbGb3RvOGg4a23hy2M30V5VYNH
 MbTV+H9I/uUYVizqf6wpimuxg9HMTNsccCef2yjt9M+Wy3lSpgxqNjJ7qowWzXmqFQUZ
 uoC3rVhl8xZ0sqIrDQ/BJgc9WMEsip2mFzeoqchzdoYHnYHhvIHhzKwr1c3toW2Bcwm0 pA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vqu4qw2h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 13:13:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9ND4euJ091848;
        Wed, 23 Oct 2019 13:11:30 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vtm2252fh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 13:11:30 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9NDBTlx009289;
        Wed, 23 Oct 2019 13:11:29 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Oct 2019 06:11:29 -0700
Date:   Wed, 23 Oct 2019 16:11:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kholk11@gmail.com
Cc:     linux-pm@vger.kernel.org
Subject: [bug report] thermal: qcom: tsens-v1: Add support for MSM8956 and
 MSM8976
Message-ID: <20191023131119.GA3987@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9418 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=933
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910230134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9418 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910230135
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello AngeloGioacchino Del Regno,

The patch 95ededc17e4e: "thermal: qcom: tsens-v1: Add support for
MSM8956 and MSM8976" from Oct 5, 2019, leads to the following static
checker warning:

	drivers/thermal/qcom/tsens-v1.c:253 calibrate_8976()
	warn: mask and shift to zero

drivers/thermal/qcom/tsens-v1.c
   235  static int calibrate_8976(struct tsens_priv *priv)
   236  {
   237          int base0 = 0, base1 = 0, i;
   238          u32 p1[11], p2[11];
   239          int mode = 0, tmp = 0;
   240          u32 *qfprom_cdata;
   241  
   242          qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
   243          if (IS_ERR(qfprom_cdata)) {
   244                  kfree(qfprom_cdata);
   245                  return PTR_ERR(qfprom_cdata);
   246          }
   247  
   248          mode = (qfprom_cdata[4] & MSM8976_CAL_SEL_MASK);
   249          dev_dbg(priv->dev, "calibration mode is %d\n", mode);
   250  
   251          switch (mode) {
   252          case TWO_PT_CALIB:
   253                  base1 = (qfprom_cdata[2] & MSM8976_BASE1_MASK) >> MSM8976_BASE1_SHIFT;
                                                   ^^^^^^^^^^^^^^^^^^     ^^^^^^^^^^^^^^^^^^^
                                                   0xff                >> 8
base1 is always going to be zero.

   254                  p2[0] = (qfprom_cdata[0] & MSM8976_S0_P2_MASK) >> MSM8976_S0_P2_SHIFT;
   255                  p2[1] = (qfprom_cdata[0] & MSM8976_S1_P2_MASK) >> MSM8976_S1_P2_SHIFT;
   256                  p2[2] = (qfprom_cdata[1] & MSM8976_S2_P2_MASK) >> MSM8976_S2_P2_SHIFT;
   257                  p2[3] = (qfprom_cdata[1] & MSM8976_S3_P2_MASK) >> MSM8976_S3_P2_SHIFT;
   258                  p2[4] = (qfprom_cdata[2] & MSM8976_S4_P2_MASK) >> MSM8976_S4_P2_SHIFT;
   259                  p2[5] = (qfprom_cdata[2] & MSM8976_S5_P2_MASK) >> MSM8976_S5_P2_SHIFT;
   260                  p2[6] = (qfprom_cdata[3] & MSM8976_S6_P2_MASK) >> MSM8976_S6_P2_SHIFT;
   261                  p2[7] = (qfprom_cdata[3] & MSM8976_S7_P2_MASK) >> MSM8976_S7_P2_SHIFT;
   262                  p2[8] = (qfprom_cdata[4] & MSM8976_S8_P2_MASK) >> MSM8976_S8_P2_SHIFT;
   263                  p2[9] = (qfprom_cdata[4] & MSM8976_S9_P2_MASK) >> MSM8976_S9_P2_SHIFT;
   264                  p2[10] = (qfprom_cdata[5] & MSM8976_S10_P2_MASK) >> MSM8976_S10_P2_SHIFT;
   265  
   266                  for (i = 0; i < priv->num_sensors; i++)
   267                          p2[i] = ((base1 + p2[i]) << 2);
   268                  /* Fall through */

regards,
dan carpenter
