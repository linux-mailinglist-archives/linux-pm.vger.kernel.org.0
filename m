Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA3E2F56F4
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jan 2021 02:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbhANBz6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Jan 2021 20:55:58 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37778 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbhAMXyU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jan 2021 18:54:20 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10DMpVXw030219;
        Wed, 13 Jan 2021 16:51:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610578291;
        bh=AMCB9l0RBsNgkb03+ed2+NVwg5pgcoyrXDqE0SivHmY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Z8fVKzQu1amuWvFVfXI3R/JT+DeDDwoTjhs0hhabIi3eVlsq+w2ewZB1c/6gMDTl+
         cChZ72WUBO+sMxjhkfb2H9nvH2S/DyAnYjZTbXO8DU6UTapEoFGhCG+d43ZFXU8vAy
         074gV0+s1we7fxjIt9mVIi2QWyrhRGDxi9QgOZHg=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10DMpVIn130069
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Jan 2021 16:51:31 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 13
 Jan 2021 16:51:31 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 13 Jan 2021 16:51:30 -0600
Received: from [10.250.42.35] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10DMpUIl036844;
        Wed, 13 Jan 2021 16:51:30 -0600
Subject: Re: [EXTERNAL] [bug report] power: supply: bq256xx: Introduce the
 BQ256XX charger driver
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <X/1jy5+2elOl3Lm8@mwanda>
 <d0a0fccf-d7c5-c5a4-c4f0-68a8a01b7c34@ti.com> <20210113091356.GF5105@kadam>
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Message-ID: <83f5532d-bc1d-2da0-e3b2-31d96ba62fce@ti.com>
Date:   Wed, 13 Jan 2021 16:51:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210113091356.GF5105@kadam>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dan,

On 1/13/21 3:13 AM, Dan Carpenter wrote:
> On Tue, Jan 12, 2021 at 05:44:52PM -0600, Ricardo Rivera-Matos wrote:
>> Dan,
>>
>> On 1/12/21 2:54 AM, Dan Carpenter wrote:
>>> Hello Ricardo Rivera-Matos,
>>>
>>> The patch 32e4978bb920: "power: supply: bq256xx: Introduce the
>>> BQ256XX charger driver" from Jan 6, 2021, leads to the following
>>> static checker warning:
>>>
>>> 	drivers/power/supply/bq256xx_charger.c:1512 bq256xx_hw_init()
>>> 	error: buffer overflow 'bq256xx_watchdog_time' 8 <= 8
>>>
>>> drivers/power/supply/bq256xx_charger.c
>>>     1503  static int bq256xx_hw_init(struct bq256xx_device *bq)
>>>     1504  {
>>>     1505          struct power_supply_battery_info bat_info = { };
>>>     1506          int wd_reg_val = BQ256XX_WATCHDOG_DIS;
>>>     1507          int ret = 0;
>>>     1508          int i;
>>>     1509
>>>     1510          for (i = 0; i < BQ256XX_NUM_WD_VAL; i++) {
>>>     1511                  if (bq->watchdog_timer > bq256xx_watchdog_time[i] &&
>>>     1512                      bq->watchdog_timer < bq256xx_watchdog_time[i + 1])
>>>                                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>> The last four members of this array are all zero.
>> ACK, BQ256XX_NUM_WD_VAL should actually be 4 instead of 8
>>> On the last iteration through the loop this will read beyond the end of
>>> the array possibly setting "wd_reg_val = 7" uninitentionally.
>> ACK, bq256xx_parse_dt() will clamp bq->watchdog_timer so then in
>> bq256xx_hw_init()
>>
>>      for (i = 0; i < BQ256XX_NUM_WD_VAL; i++) {
>>          if (bq->watchdog_timer == bq256xx_watchdog_time[i]) {
>>              wd_reg_val = i;
>>              break;
>>          }
>>          if (bq->watchdog_timer > bq256xx_watchdog_time[i] &&
>>              bq->watchdog_timer < bq256xx_watchdog_time[i + 1])
>>              wd_reg_val = i;
>>      }
>>
>> The first if will catch the exact matches and the second if will catch the
>> "in-betweens" and round down. The final iteration will always fall into the
>> first if statement and break.
>>
> This looks good.  This is a patch you are proposing or it's already
> merged in an upstream tree somewhere?  Either way, that sounds fine.
> Thank!
I am proposing it. I will CC you when I send off the patchset.
>
> regards,
> dan carpenter
>
Best Regards,
Ricardo
