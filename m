Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6EE19C8C3
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 20:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388880AbgDBS3g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 14:29:36 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35378 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732330AbgDBS3g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2020 14:29:36 -0400
Received: by mail-pj1-f68.google.com with SMTP id g9so1847184pjp.0;
        Thu, 02 Apr 2020 11:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CJcpbwB6tJvEn+YzHuaB7ycn7jq0/A3ed1+qxpcdFwA=;
        b=BKgBqksv4+LxEUQdzX3MiAK7xxMClLZ7h9+Cki2qOf9UdOBKMAmKEAGs4mOTEwmVFH
         Wkr/GN/iLyN5hJ2K8WJ7ZLkiaD0pHCGT6g5Da34zAExNpPQlzFRVy6MGT68fFvldpsCJ
         HgEgucJV4YP87I0HFtoKwZIJyCJZB+m3u6IaY8ajTBDRMOVyIKMMQO4MitHiKDfxRNnE
         gZCGVJz+BY68MrynfcBVe0K/j0gnmXo17GY9VnLjbdW8yZ+uQY3rD6xTVS2Slqr/ZQJM
         7CCFoeTW54qFcT27ziad4iZefsCCTv7N56McPRl3sImHeRvBv7OmPqb7J/T+SEk/YizU
         f1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=CJcpbwB6tJvEn+YzHuaB7ycn7jq0/A3ed1+qxpcdFwA=;
        b=UY/zUfqm2rtxMZsUDHh4TbDY1zRqJulozei5Ti4LRbO0l2/PAR3rL3WDbqgu7eKfZn
         Xd2DIICak/LY1LK8J+QGbN2HNGknVV9evcB3HBRT7hYU2BUdiEopCAONxTKDo/5fZKk+
         pOrxtOdLtdOLQbZGjuqK+M21gLhrkSV0TZk5kJJx+iL0STpd/azkufHKF+YDvG4/J1Ve
         1E++2L+0noC9G0HXAuumQ4ahO9KkBj+oxzjvRhL+01BQz30ghWO44jSwU7lD6kecU9Tp
         JtDZ17QYPqsYwgMtWsAdQdIF1ErKI8WkyMjHn6HYuOrA845xYlisrKoq1mokjtTd8HLO
         5loQ==
X-Gm-Message-State: AGi0PuYsu/3h1AxLuPLV5TWxCJz0TI5mnVmvDeql7zhZFs6Ft67qMbqi
        NcaAjwCgsGuYK9uoezHvq1zLEIM2
X-Google-Smtp-Source: APiQypJ6YeAsAN02d9RK5Nj6RhNdtN8TDdIaCrDQ0sgN42p6w9yH8o4rvZ/fBVdebir9C/SvLjPzxw==
X-Received: by 2002:a17:90a:d78b:: with SMTP id z11mr5240230pju.34.1585852174412;
        Thu, 02 Apr 2020 11:29:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id kr12sm4189707pjb.20.2020.04.02.11.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 11:29:33 -0700 (PDT)
Subject: Re: [PATCH 3/7] power: supply: core: fix HWMON temperature labels
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Sebastian Reichel "(maintainer:POWER" SUPPLY CLASS/SUBSYSTEM
         and "DRIVERS,blamed_fixes:1/1=100%)" 
        <sebastian.reichel@collabora.com>,
        "Andrey Smirnov (blamed_fixes:1/1=100%)" <andrew.smirnov@gmail.com>,
        "open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1585837575.git.mirq-linux@rere.qmqm.pl>
 <4a8ac6700e1503a69146f3eefd7cb515d11bfc9f.1585837575.git.mirq-linux@rere.qmqm.pl>
 <29d67963-c110-553a-fec4-b972953987b1@roeck-us.net>
 <20200402150029.GA8325@qmqm.qmqm.pl>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <32497230-7c83-4db5-0b0e-113558470d10@roeck-us.net>
Date:   Thu, 2 Apr 2020 11:29:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200402150029.GA8325@qmqm.qmqm.pl>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/2/20 8:00 AM, Micha³ Miros³aw wrote:
> On Thu, Apr 02, 2020 at 07:52:19AM -0700, Guenter Roeck wrote:
>> On 4/2/20 7:46 AM, Micha³ Miros³aw wrote:
>>> tempX_label files are swapped compared to what
>>> power_supply_hwmon_temp_to_property() uses. Make them match.
>>> While at it, make room for labeling other channels.
>>>
>>> Fixes: e67d4dfc9ff1 ("power: supply: Add HWMON compatibility layer")
>>> Signed-off-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
>>> ---
>>>  drivers/power/supply/power_supply_hwmon.c | 14 +++++++++++++-
>>>  1 file changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
>>> index 75cf861ba492..83318a21fb52 100644
>>> --- a/drivers/power/supply/power_supply_hwmon.c
>>> +++ b/drivers/power/supply/power_supply_hwmon.c
>>> @@ -43,6 +43,11 @@ static int power_supply_hwmon_curr_to_property(u32 attr)
>>>  	}
>>>  }
>>>  
>>> +static const char *const ps_temp_label[] = {
>>> +	"temp",
>>> +	"ambient temp",
>>> +};
>>> +
>>>  static int power_supply_hwmon_temp_to_property(u32 attr, int channel)
>>>  {
>>>  	if (channel) {
>>> @@ -144,7 +149,14 @@ static int power_supply_hwmon_read_string(struct device *dev,
>>>  					  u32 attr, int channel,
>>>  					  const char **str)
>>>  {
>>> -	*str = channel ? "temp" : "temp ambient";
>>> +	switch (type) {
>>> +	case hwmon_temp:
>>> +		*str = ps_temp_label[channel];
>>> +		break;
>>> +	default:
>>> +		break;
>>
>> That returns "no error" without setting *str, which is really asking for trouble.
> 
> This is carried over from earlier version. No bug though, but I'll add a
> patch while I'm at it.
> 

This is incorrect. The previous version does not check the type and always sets *str.

-	*str = channel ? "temp" : "temp ambient";

Guenter
