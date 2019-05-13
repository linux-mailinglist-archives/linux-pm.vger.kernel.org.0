Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA79A1BD14
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 20:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfEMSS1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 May 2019 14:18:27 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:36308 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfEMSS0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 May 2019 14:18:26 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4DI930Y192247;
        Mon, 13 May 2019 18:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=jEo7XXReHN0uERTLv2oWaZLB7A14Y+Lgsoo0DPWLjoY=;
 b=Ve4OTmksm2WSMfYxN+RnYGbqbDL3b/CVuS2KcU0UCsUwzlOiMSAttHBzi1NMeawScoqE
 y+FEkbUF9FUpw1bvT6VcjcwAcmZjFhA9fcrkFFnQ2YuIAq0sO6pQ5UU4ypONK+9hYzri
 mCU5jGNbPjYZ1Tq1H3/oepmZGEImgSKJPQ7d03HFAk5+wttUTqxYyKFGUEwCcNjb8zVH
 y/UsUxHPdYDdB0pMb7Qn2NdzWjhZdjwp9ihWLFRbA9guqdNNuyRP2sYEs79dJ7+OB0A3
 jboEdgEIJzwRo0M65/DCESi/8E0FJSue2MB3egBxLRTY7kevjFuDQhuVxYXKBv7h+asb dw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2sdkwdh1w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 May 2019 18:18:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4DIHG9M064632;
        Mon, 13 May 2019 18:18:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2sdmean0jm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 May 2019 18:18:24 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4DIIN7L001267;
        Mon, 13 May 2019 18:18:23 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 May 2019 11:18:23 -0700
Date:   Mon, 13 May 2019 21:18:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     amit.kucheria@linaro.org
Cc:     linux-pm@vger.kernel.org
Subject: [bug report] drivers: thermal: tsens: Add new operation to check if
 a sensor is enabled
Message-ID: <20190513181814.GA25056@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9256 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=905
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905130124
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9256 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=943 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905130124
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Amit Kucheria,

The patch 686539daac9f: "drivers: thermal: tsens: Add new operation
to check if a sensor is enabled" from Mar 20, 2019, leads to the
following static checker warning:

	drivers/thermal/qcom/tsens-common.c:73 is_sensor_enabled()
	warn: signedness bug returning '(-22)'

drivers/thermal/qcom/tsens-common.c
    67  bool is_sensor_enabled(struct tsens_priv *priv, u32 hw_id)
        ^^^^

    68  {
    69          u32 val;
    70          int ret;
    71  
    72          if ((hw_id > (priv->num_sensors - 1)) || (hw_id < 0))
    73                  return -EINVAL;
                        ^^^^^^^^^^^^^^
    74          ret = regmap_field_read(priv->rf[SENSOR_EN], &val);
    75          if (ret)
    76                  return ret;
                        ^^^^^^^^^^
    77  
    78          return val & (1 << hw_id);
    79  }


regards,
dan carpenter
