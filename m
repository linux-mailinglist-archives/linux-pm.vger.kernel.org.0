Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55FC92F40AD
	for <lists+linux-pm@lfdr.de>; Wed, 13 Jan 2021 01:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393627AbhAMAnC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 19:43:02 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47486 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390430AbhALXqb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 18:46:31 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10CNireg045135;
        Tue, 12 Jan 2021 17:44:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610495093;
        bh=7/0ruDU9mU6ZquxSnJ3W4pd4JINdjABWsegVS43LhGo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pwtzB7Uk9epk88WGoBOrFEgLLY8XVMgR6nuj4vyaEbKhBlLsi3ls6SRzVOCJUn4L2
         UK7uCHX+hkMplYWAbGDYESPogoM1STTntsv/hLIP5MIfzQfAXSJ9BMOpnqYG+GI3Km
         sWanwGt2AHC+aarmUJZ0gLVocYX7o4gBHwAjRJzE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10CNir7Y069494
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Jan 2021 17:44:53 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 12
 Jan 2021 17:44:52 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 12 Jan 2021 17:44:53 -0600
Received: from [10.250.64.103] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10CNiqCU019337;
        Tue, 12 Jan 2021 17:44:53 -0600
Subject: Re: [EXTERNAL] [bug report] power: supply: bq256xx: Introduce the
 BQ256XX charger driver
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     <linux-pm@vger.kernel.org>
References: <X/1jy5+2elOl3Lm8@mwanda>
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Message-ID: <d0a0fccf-d7c5-c5a4-c4f0-68a8a01b7c34@ti.com>
Date:   Tue, 12 Jan 2021 17:44:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X/1jy5+2elOl3Lm8@mwanda>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dan,

On 1/12/21 2:54 AM, Dan Carpenter wrote:
> Hello Ricardo Rivera-Matos,
>
> The patch 32e4978bb920: "power: supply: bq256xx: Introduce the
> BQ256XX charger driver" from Jan 6, 2021, leads to the following
> static checker warning:
>
> 	drivers/power/supply/bq256xx_charger.c:1512 bq256xx_hw_init()
> 	error: buffer overflow 'bq256xx_watchdog_time' 8 <= 8
>
> drivers/power/supply/bq256xx_charger.c
>    1503  static int bq256xx_hw_init(struct bq256xx_device *bq)
>    1504  {
>    1505          struct power_supply_battery_info bat_info = { };
>    1506          int wd_reg_val = BQ256XX_WATCHDOG_DIS;
>    1507          int ret = 0;
>    1508          int i;
>    1509
>    1510          for (i = 0; i < BQ256XX_NUM_WD_VAL; i++) {
>    1511                  if (bq->watchdog_timer > bq256xx_watchdog_time[i] &&
>    1512                      bq->watchdog_timer < bq256xx_watchdog_time[i + 1])
>                                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> The last four members of this array are all zero.
ACK, BQ256XX_NUM_WD_VAL should actually be 4 instead of 8
>
> On the last iteration through the loop this will read beyond the end of
> the array possibly setting "wd_reg_val = 7" uninitentionally.
ACK, bq256xx_parse_dt() will clamp bq->watchdog_timer so then in 
bq256xx_hw_init()

     for (i = 0; i < BQ256XX_NUM_WD_VAL; i++) {
         if (bq->watchdog_timer == bq256xx_watchdog_time[i]) {
             wd_reg_val = i;
             break;
         }
         if (bq->watchdog_timer > bq256xx_watchdog_time[i] &&
             bq->watchdog_timer < bq256xx_watchdog_time[i + 1])
             wd_reg_val = i;
     }

The first if will catch the exact matches and the second if will catch 
the "in-betweens" and round down. The final iteration will always fall 
into the first if statement and break.

>
>    1513                          wd_reg_val = i;
>    1514          }
>    1515          ret = regmap_update_bits(bq->regmap, BQ256XX_CHARGER_CONTROL_1,
>    1516                                   BQ256XX_WATCHDOG_MASK, wd_reg_val <<
>    1517                                                  BQ256XX_WDT_BIT_SHIFT);
>
> regards,
> dan carpenter
Ricardo
