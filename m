Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA9FA75D26
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2019 04:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfGZCqi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 22:46:38 -0400
Received: from anchovy2.45ru.net.au ([203.30.46.146]:45085 "EHLO
        anchovy2.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfGZCqi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 22:46:38 -0400
Received: (qmail 30833 invoked by uid 5089); 26 Jul 2019 02:46:34 -0000
Received: by simscan 1.2.0 ppid: 30700, pid: 30704, t: 0.4346s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950 spam: 3.1.4
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on anchovy2
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=6.0 tests=ALL_TRUSTED,AWL
        autolearn=disabled version=3.4.1
Received: from unknown (HELO ?192.168.0.34?) (rtresidd@electromag.com.au@203.59.235.95)
  by anchovy3.45ru.net.au with ESMTPA; 26 Jul 2019 02:46:33 -0000
Subject: Re: [PATCH 1/1] power/supply/sbs-battery: Fix confusing battery
 status when idle or empty
To:     Guenter Roeck <groeck@google.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nick Crews <ncrews@chromium.org>, andrew.smirnov@gmail.com,
        Guenter Roeck <groeck@chromium.org>, david@lechnology.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rfontana@redhat.com, allison@lohutok.net, baolin.wang@linaro.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1564043102-25298-1-git-send-email-rtresidd@electromag.com.au>
 <CABXOdTdz=+P-HXaUbGAuLBjNE1GA0C8o4OPmF996DOrXxkQJAg@mail.gmail.com>
From:   Richard Tresidder <rtresidd@electromag.com.au>
Message-ID: <71a968f7-88c9-aa6c-6822-edfc12484d91@electromag.com.au>
Date:   Fri, 26 Jul 2019 10:46:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CABXOdTdz=+P-HXaUbGAuLBjNE1GA0C8o4OPmF996DOrXxkQJAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-AU
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Guenter
    Yep sorry there was a merge that I missed during that initial send 
of the patch.
I sent a version 2 shortly after.

Regards
    Richard Tresidder

On 25/07/2019 9:39 pm, Guenter Roeck wrote:
> On Thu, Jul 25, 2019 at 1:25 AM Richard Tresidder
> <rtresidd@electromag.com.au> wrote:
>> When a battery or batteries in a system are in parallel then one or more
>> may not be providing any current to the system.
>> This fixes an incorrect
>> status indication of FULL for the battery simply because it wasn't
>> discharging at that point in time.
>> The battery will now be flagged as IDLE.
>> Have also added the additional check for the battery FULL DISCHARGED flag
>> which will now flag a status of EMPTY.
>>
>> Signed-off-by: Richard Tresidder <rtresidd@electromag.com.au>
>> ---
>>
>> Notes:
>>      power/supply/sbs-battery: Fix confusing battery status when idle or empty
>>
>>      When a battery or batteries in a system are in parallel then one or more
>>      may not be providing any current to the system.
>>      This fixes an incorrect
>>      status indication of FULL for the battery simply because it wasn't
>>      discharging at that point in time.
>>      The battery will now be flagged as IDLE.
>>      Have also added the additional check for the battery FULL DISCHARGED flag
>>      which will now flag a status of EMPTY.
>>
>>   drivers/power/supply/power_supply_sysfs.c |  3 ++-
>>   drivers/power/supply/sbs-battery.c        | 28 ++++++++++++++--------------
>>   include/linux/power_supply.h              |  2 ++
>>   3 files changed, 18 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
>> index ce6671c..68ec49d 100644
>> --- a/drivers/power/supply/power_supply_sysfs.c
>> +++ b/drivers/power/supply/power_supply_sysfs.c
>> @@ -51,7 +51,8 @@
>>   };
>>
>>   static const char * const power_supply_status_text[] = {
>> -       "Unknown", "Charging", "Discharging", "Not charging", "Full"
>> +       "Unknown", "Charging", "Discharging", "Not charging", "Full",
>> +       "Empty", "Idle"
>>   };
>>
>>   static const char * const power_supply_charge_type_text[] = {
>> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
>> index ea8ba3e..e6c636c 100644
>> --- a/drivers/power/supply/sbs-battery.c
>> +++ b/drivers/power/supply/sbs-battery.c
>> @@ -294,14 +294,10 @@ static int sbs_status_correct(struct i2c_client *client, int *intval)
>>
>>          ret = (s16)ret;
>>
>> -       /* Not drawing current means full (cannot be not charging) */
>> -       if (ret == 0)
>> -               *intval = POWER_SUPPLY_STATUS_FULL;
>> -
>> -       if (*intval == POWER_SUPPLY_STATUS_FULL) {
>> -               /* Drawing or providing current when full */
>> -               if (ret > 0)
>> -                       *intval = POWER_SUPPLY_STATUS_CHARGING;
>> +       if (*intval == POWER_SUPPLY_STATUS_DISCHARGING) {
>> +               /* Charging indicator not set in battery */
>> +               if (ret == 0)
>> +                       *intval = POWER_SUPPLY_STATUS_IDLE;
> But doesn't the above already indicate that it _is_ discharging ?
>
>>                  else if (ret < 0)
>>                          *intval = POWER_SUPPLY_STATUS_DISCHARGING;
> This doesn't make sense. *intval is already set to
> POWER_SUPPLY_STATUS_DISCHARGING
> in this situation.
>
>>          }
>> @@ -424,10 +420,12 @@ static int sbs_get_battery_property(struct i2c_client *client,
>>
>>                  if (ret & BATTERY_FULL_CHARGED)
>>                          val->intval = POWER_SUPPLY_STATUS_FULL;
>> -               else if (ret & BATTERY_DISCHARGING)
>> -                       val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
>> -               else
>> +               else if (ret & BATTERY_FULL_DISCHARGED)
>> +                       val->intval = POWER_SUPPLY_STATUS_EMPTY;
>> +               else if (!(ret & BATTERY_DISCHARGING))
>>                          val->intval = POWER_SUPPLY_STATUS_CHARGING;
>> +               else
>> +                       val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
>>
>>                  sbs_status_correct(client, &val->intval);
>>
>> @@ -781,10 +779,12 @@ static void sbs_delayed_work(struct work_struct *work)
>>
>>          if (ret & BATTERY_FULL_CHARGED)
>>                  ret = POWER_SUPPLY_STATUS_FULL;
>> -       else if (ret & BATTERY_DISCHARGING)
>> -               ret = POWER_SUPPLY_STATUS_DISCHARGING;
>> -       else
>> +       else if (ret & BATTERY_FULL_DISCHARGED)
>> +               ret = POWER_SUPPLY_STATUS_EMPTY;
>> +       else if (!(ret & BATTERY_DISCHARGING))
>>                  ret = POWER_SUPPLY_STATUS_CHARGING;
>> +       else
>> +               ret = POWER_SUPPLY_STATUS_DISCHARGING;
>>
>>          sbs_status_correct(chip->client, &ret);
>>
>> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
>> index 28413f7..c9f3347 100644
>> --- a/include/linux/power_supply.h
>> +++ b/include/linux/power_supply.h
>> @@ -37,6 +37,8 @@ enum {
>>          POWER_SUPPLY_STATUS_DISCHARGING,
>>          POWER_SUPPLY_STATUS_NOT_CHARGING,
>>          POWER_SUPPLY_STATUS_FULL,
>> +       POWER_SUPPLY_STATUS_EMPTY,
>> +       POWER_SUPPLY_STATUS_IDLE,
>>   };
>>
>>   /* What algorithm is the charger using? */
>> --
>> 1.8.3.1
>>
>

