Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103D02F2A6B
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 09:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389011AbhALI50 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 03:57:26 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59444 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731316AbhALI50 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 03:57:26 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10C8n8CT135173;
        Tue, 12 Jan 2021 08:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=s9Fs0MM60cKUnx56MqHSPifPR8CzlhkEo00u1YWO0h8=;
 b=PxyppCKWnQBsM7h5Df/+EmAk31oBm9axPGYLW3H3Jy3yawjZei/USSKm2tnje+rLQGFF
 5/4r5+dRPYZ/gL5Syz05lHKlxtCge0wEW81KHQIsPfWGURGJX7rUHHmZF91MZ4WeWhzu
 y2Ih5GlWVgm1JwpXfnkNLJ8hqd3Mynur1rm4zOMHxh6O3dl8ycYPpP+dypEb4cFHL9df
 iOqSbnxzEocANFopzZ6RW0GjFJoqCAQAeV42nSesZ8Y1XUngloQB6Yx4NheX4j6OM1X6
 dhbhZRyfISDAww5WOI82hGVMmJ7MA7VamlFauMCIAkGU0TblDZipwaI8COXYTysflPRz Hg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 360kvjw2wb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Jan 2021 08:56:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10C8o0rY175891;
        Tue, 12 Jan 2021 08:54:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 360kexghhg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 08:54:42 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10C8sf55028278;
        Tue, 12 Jan 2021 08:54:41 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 00:54:40 -0800
Date:   Tue, 12 Jan 2021 11:54:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     r-rivera-matos@ti.com
Cc:     linux-pm@vger.kernel.org
Subject: [bug report] power: supply: bq256xx: Introduce the BQ256XX charger
 driver
Message-ID: <X/1jy5+2elOl3Lm8@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120049
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1011 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120049
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Ricardo Rivera-Matos,

The patch 32e4978bb920: "power: supply: bq256xx: Introduce the
BQ256XX charger driver" from Jan 6, 2021, leads to the following
static checker warning:

	drivers/power/supply/bq256xx_charger.c:1512 bq256xx_hw_init()
	error: buffer overflow 'bq256xx_watchdog_time' 8 <= 8

drivers/power/supply/bq256xx_charger.c
  1503  static int bq256xx_hw_init(struct bq256xx_device *bq)
  1504  {
  1505          struct power_supply_battery_info bat_info = { };
  1506          int wd_reg_val = BQ256XX_WATCHDOG_DIS;
  1507          int ret = 0;
  1508          int i;
  1509  
  1510          for (i = 0; i < BQ256XX_NUM_WD_VAL; i++) {
  1511                  if (bq->watchdog_timer > bq256xx_watchdog_time[i] &&
  1512                      bq->watchdog_timer < bq256xx_watchdog_time[i + 1])
                                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The last four members of this array are all zero.

On the last iteration through the loop this will read beyond the end of
the array possibly setting "wd_reg_val = 7" uninitentionally.

  1513                          wd_reg_val = i;
  1514          }
  1515          ret = regmap_update_bits(bq->regmap, BQ256XX_CHARGER_CONTROL_1,
  1516                                   BQ256XX_WATCHDOG_MASK, wd_reg_val <<
  1517                                                  BQ256XX_WDT_BIT_SHIFT);

regards,
dan carpenter
