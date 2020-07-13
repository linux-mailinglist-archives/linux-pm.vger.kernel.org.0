Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED00E21D53B
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 13:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbgGMLrF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 07:47:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49748 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbgGMLrF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 07:47:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DBl26h034830;
        Mon, 13 Jul 2020 11:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=qKMvHCnAc5/FY10lx5s4SrenxH6VYwvPQdnxodFAVfE=;
 b=biqyHv71JVZIdHytAfCw0QtfgmholO/bi9k3ziStjRF5zSyyxCuvJBY8mhDbx0t6xLQA
 +e8OUnTYwG3B/CDeGt61VMT8lVkJYTZKSRKdCq9O/6eni6RrjdlZdlmrDTQRwCgghsoW
 RAhIeaKn92pneydeyM5qeY4yRSTnAveAC6W8F1P1PTRs7JNEuVCPanxFa18/bE9cdy66
 UYbQdFW1LvZDy1/amzq3gdmQB3Mf8gKOu8S5BUDIxcy/3hT3QFi3wlK8ysv5ikYBEx3b
 Mkywdkltv6SNR8XD0f2peBX+9WjsGfcLz3zcm9TJ/2MyTznIplL+77q7OPh5eV6fYfc4 9w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 32762n6cwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Jul 2020 11:47:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DBhkct106660;
        Mon, 13 Jul 2020 11:45:02 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 327q0m7k9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jul 2020 11:45:01 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06DBj0lO003174;
        Mon, 13 Jul 2020 11:45:00 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jul 2020 04:45:00 -0700
Date:   Mon, 13 Jul 2020 14:44:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     amit.kucheria@linaro.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [bug report] drivers: thermal: tsens: Merge tsens-8974 into
 tsens-v0_1
Message-ID: <20200713114454.GR2571@kadam>
References: <20190514090635.GA21833@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514090635.GA21833@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9680 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=944 bulkscore=0 adultscore=0 phishscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130088
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9680 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 clxscore=1011 priorityscore=1501 mlxlogscore=934 lowpriorityscore=0
 bulkscore=0 suspectscore=1 phishscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130088
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Did we ever look into this?

regards,
dan carpenter

On Tue, May 14, 2019 at 12:06:35PM +0300, Dan Carpenter wrote:
> Hello Amit Kucheria,
> 
> The patch c80cbb79e851: "drivers: thermal: tsens: Merge tsens-8974
> into tsens-v0_1" from Mar 20, 2019, leads to the following static
> checker warning:
> 
> 	drivers/thermal/qcom/tsens-v0_1.c:237 calibrate_8974()
> 	warn: mask and shift to zero
> 
> drivers/thermal/qcom/tsens-v0_1.c
>    226                  case ONE_PT_CALIB:
>    227                  case ONE_PT_CALIB2:
>    228                          base1 = bkp[0] & BASE1_MASK;
>    229                          p1[0] = (bkp[0] & S0_P1_MASK) >> S0_P1_SHIFT;
>    230                          p1[1] = (bkp[0] & S1_P1_MASK) >> S1_P1_SHIFT;
>    231                          p1[2] = (bkp[0] & S2_P1_MASK) >> S2_P1_SHIFT;
>    232                          p1[3] = (bkp[0] & S3_P1_MASK) >> S3_P1_SHIFT;
>    233                          p1[4] = (bkp[1] & S4_P1_MASK);
>    234                          p1[5] = (bkp[1] & S5_P1_MASK) >> S5_P1_SHIFT;
>    235                          p1[6] = (bkp[1] & S6_P1_MASK) >> S6_P1_SHIFT;
>    236                          p1[7] = (bkp[1] & S7_P1_MASK) >> S7_P1_SHIFT;
>    237                          p1[8] = (bkp[2] & S8_P1_MASK_BKP) >> S8_P1_SHIFT;
>                                                   ^^^^^^^^^^^^^^     ^^^^^^^^^^^
> #define S8_P1_MASK_BKP          0x3f
> #define S8_P1_SHIFT 24
> 
> Other places define S8_P1_SHIFT as 4, so that's maybe something to
> consider.
> 
>    238                          p1[9] = (bkp[2] & S9_P1_MASK_BKP) >> S9_P1_BKP_SHIFT;
>    239                          p1[10] = (bkp[2] & S10_P1_MASK_BKP) >> S10_P1_BKP_SHIFT;
>    240                          break;
>    241                  }
>    242          } else {
>    243                  mode = (calib[1] & CAL_SEL_0_1) >> CAL_SEL_SHIFT;
>    244                  mode |= (calib[3] & CAL_SEL_2) >> CAL_SEL_SHIFT_2;
> 
> regards,
> dan carpenter
