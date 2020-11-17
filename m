Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C162B5BB7
	for <lists+linux-pm@lfdr.de>; Tue, 17 Nov 2020 10:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbgKQJWI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Nov 2020 04:22:08 -0500
Received: from foss.arm.com ([217.140.110.172]:52654 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbgKQJWH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Nov 2020 04:22:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B486D1042;
        Tue, 17 Nov 2020 01:22:06 -0800 (PST)
Received: from [10.57.25.49] (unknown [10.57.25.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E7E43F719;
        Tue, 17 Nov 2020 01:22:05 -0800 (PST)
Subject: Re: [PATCH] powercap: Adjust printing the constraint name with new
 line
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20201109172452.6923-1-lukasz.luba@arm.com>
 <CAJZ5v0gQj8cNHgXkgwGeNcegAmP2xxqPQXz1kGNqFFDDCgfX_w@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <6d29b192-bad4-3abc-96fd-dfe12cc402e4@arm.com>
Date:   Tue, 17 Nov 2020 09:22:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gQj8cNHgXkgwGeNcegAmP2xxqPQXz1kGNqFFDDCgfX_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On 11/10/20 7:19 PM, Rafael J. Wysocki wrote:
> On Mon, Nov 9, 2020 at 6:25 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> The constraint name has limit of size 30, which sometimes might be hit.
>> When this happens the new line might be lost. Prevent this and set the
>> new line when the name string is too long."
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/powercap/powercap_sys.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
>> index f808c5fa9838..575f9fdb810e 100644
>> --- a/drivers/powercap/powercap_sys.c
>> +++ b/drivers/powercap/powercap_sys.c
>> @@ -174,6 +174,10 @@ static ssize_t show_constraint_name(struct device *dev,
>>                                                                  "%s\n", name);
>>                          buf[POWERCAP_CONSTRAINT_NAME_LEN] = '\0';
>>                          len = strlen(buf);
>> +
>> +                       /* When the 'name' is too long, don't lose new line */
>> +                       if (strlen(name) >= POWERCAP_CONSTRAINT_NAME_LEN)
>> +                               buf[POWERCAP_CONSTRAINT_NAME_LEN - 1] = '\n';
> 
> Wouldn't it be better to pass POWERCAP_CONSTRAINT_NAME_LEN - 1 to
> snprintf() above?

My apologies for delay, I was on holidays.

The snprintf() overwrites the '\n' in that case also. I've experimented
with it a bit more and tried to come with a bit 'cleaner' solution.

What we are looking is probably: "%.*s\n" semantic.
Another solution would be:
------------------------------8<---------------------------
                 if (name) {
-                       snprintf(buf, POWERCAP_CONSTRAINT_NAME_LEN,
-                                                               "%s\n", 
name);
-                       buf[POWERCAP_CONSTRAINT_NAME_LEN] = '\0';
+                       sprintf(buf, "%.*s\n", 
POWERCAP_CONSTRAINT_NAME_LEN -1,
+                               name);
                         len = strlen(buf);
                 }

----------------------------->8----------------------------

I've check this and it behaves very well.

It looks cleaner and it is a used pattern in the kernel.
What do you think? Is it good for v2?

Regards,
Lukasz


