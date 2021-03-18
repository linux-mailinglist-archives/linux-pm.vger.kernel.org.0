Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED8F340309
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 11:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhCRKUl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 06:20:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35282 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhCRKUM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 06:20:12 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12IAIPNk011079;
        Thu, 18 Mar 2021 10:20:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=HfGy1Gt50MrB2ms6e6bpGD4GndTuQ/zskbnkRRmoSGk=;
 b=0IiaVbTU7UDnce4F/7JbsewHYlBENYP7UZYJ1htU/yGU6mJ1Bf5B3x85ZdDUBr6PBL5p
 ZaSD9Pq5lX1ilVTjWDpHEnrtcBmM5vEqgqVCzdzTimgrwNN/bPK7nllQ6lFpmqVhCvxu
 0sCa8620KpFEBVMMTtcrwOfWm0UuOqoYYNJAimBLfN0Wa+uGeQNOn9dJB9pJCcaJ7zex
 YCm8RoD564pG4HlxfL6KCvMdm/J2Gx8LGDG5uLtY1xXftCdhnFzpRgYDM10D1Sd/hHuJ
 6ReMTL3hhRlOAB4e7wybcGEqTyea73EhH+GgRr1gLxo5C7IK+aQpM6Kt6eBHuvnowUWA +A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37a4ekuwta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Mar 2021 10:20:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12IAElAm018882;
        Thu, 18 Mar 2021 10:20:07 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 3796yw102x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Mar 2021 10:20:07 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12IAK678002197;
        Thu, 18 Mar 2021 10:20:06 GMT
Received: from mwanda (/10.175.214.245)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 18 Mar 2021 10:20:06 +0000
Date:   Thu, 18 Mar 2021 13:20:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org
Subject: [bug report] thermal/drivers/cpuidle_cooling: Use device name
 instead of auto-numbering
Message-ID: <YFMpUDNGIiLOzr0/@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9926 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=921 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103180075
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9926 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=831 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103180076
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Daniel Lezcano,

The patch 6fd1b186d900: "thermal/drivers/cpuidle_cooling: Use device
name instead of auto-numbering" from Mar 14, 2021, leads to the
following static checker warning:

	drivers/thermal/cpuidle_cooling.c:218 __cpuidle_cooling_register()
	warn: 'name' was already freed.

drivers/thermal/cpuidle_cooling.c
   200  
   201          dev = get_cpu_device(cpumask_first(drv->cpumask));
   202  
   203          name = kasprintf(GFP_KERNEL, "idle-%s", dev_name(dev));
   204          if (!name) {
   205                  ret = -ENOMEM;
   206                  goto out_unregister;
   207          }
   208  
   209          cdev = thermal_of_cooling_device_register(np, name, idle_cdev,
   210                                                    &cpuidle_cooling_ops);
   211          kfree(name);
                ^^^^^^^^^^^^

   212  
   213          if (IS_ERR(cdev)) {
   214                  ret = PTR_ERR(cdev);
   215                  goto out_unregister;
   216          }
   217  
   218          pr_debug("%s: Idle injection set with idle duration=%u, latency=%u\n",
   219                   name, idle_duration_us, latency_us);
                         ^^^^
Used after free

   220  
   221          return 0;
   222  
   223  out_unregister:
   224          idle_inject_unregister(ii_dev);
   225  out_kfree:
   226          kfree(idle_cdev);
   227  out:
   228          return ret;
   229  }

regards,
dan carpenter
