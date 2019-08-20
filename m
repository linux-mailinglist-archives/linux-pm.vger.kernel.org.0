Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A84195F2E
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2019 14:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbfHTMu6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 08:50:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49632 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729203AbfHTMu6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2019 08:50:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7KCnAWX094483;
        Tue, 20 Aug 2019 12:50:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=FX9vpQ0F7VT7cT3mMMps7pL7To7fZpr6cY/dPrecwDk=;
 b=anR2hAhX/Ri5y60LQMJ4nbZfAKKI8LChOtMjwWAO0S4UX3bUKLZAhwodiQZvCHejEbuf
 RFFJmVLUb+sLmUf1FfuJOg1lI9aQSnfOJvTsLbGojBrtcUw/yl40IwtRot7CKIGva1XR
 ndBc33kMFtKUm3WpPF94+9gxImem5IGFIulcR41DclpRG8TS/UL5DOnVI9X/AUoC97RA
 zztf+z+2zTXPv2V1oV7JYYzKXA3qbNt/YQm0s1CHnOGkgA2q4D8U+BlBmKZq1t56smMy
 BbEE2jmz364CPF1+sid8qDEm73ULZQJTdFR1A1PJe2bBo8kVGHjgNJfupZVly4psbPAA NQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2ue90te7eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Aug 2019 12:50:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7KCmBCA005490;
        Tue, 20 Aug 2019 12:50:55 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2ug268my7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Aug 2019 12:50:54 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7KCorU6012594;
        Tue, 20 Aug 2019 12:50:53 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 20 Aug 2019 05:50:53 -0700
Date:   Tue, 20 Aug 2019 15:50:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     f.fainelli@gmail.com
Cc:     linux-pm@vger.kernel.org
Subject: [bug report] cpufreq: brcmstb-avs-cpufreq: Fix initial command check
Message-ID: <20190820125047.GA11755@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9354 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908200134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9354 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908200135
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Florian Fainelli,

The patch 22a26cc6a51e: "cpufreq: brcmstb-avs-cpufreq: Fix initial
command check" from May 22, 2019, leads to the following static
checker warning:

	drivers/cpufreq/brcmstb-avs-cpufreq.c:449 brcm_avs_is_firmware_loaded()
	warn: was && intended here instead of ||?

drivers/cpufreq/brcmstb-avs-cpufreq.c
   435  /*
   436   * To ensure the right firmware is running we need to
   437   *    - check the MAGIC matches what we expect
   438   *    - brcm_avs_get_pmap() doesn't return -ENOTSUPP or -EINVAL
   439   * We need to set up our interrupt handling before calling brcm_avs_get_pmap()!
   440   */
   441  static bool brcm_avs_is_firmware_loaded(struct private_data *priv)
   442  {
   443          u32 magic;
   444          int rc;
   445  
   446          rc = brcm_avs_get_pmap(priv, NULL);
   447          magic = readl(priv->base + AVS_MBOX_MAGIC);
   448  
   449          return (magic == AVS_FIRMWARE_MAGIC) && ((rc != -ENOTSUPP) ||
   450                  (rc != -EINVAL));

This is quite an interesting one because originally this was && instead
of || as the static checker suggests.  Obviously "(rc != -ENOTSUPP ||
rc != -EINVAL) is always true because "rc" can't possibly be both values
at the same time.

I see the comment at the top of the function, but I don't understand why
those particular error codes are special.  The temptation for me would
be to do:

	rc = brcm_avs_get_pmap(priv, NULL);
	if (rc)
		return false;

	magic = readl(priv->base + AVS_MBOX_MAGIC);
	return magic == AVS_FIRMWARE_MAGIC;

But I'm clearly missing some information so I'm just going to report
this bug instead.

   451  }

regards,
dan carpenter
