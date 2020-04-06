Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B828019F2D3
	for <lists+linux-pm@lfdr.de>; Mon,  6 Apr 2020 11:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgDFJpP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Apr 2020 05:45:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41788 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgDFJpO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2020 05:45:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id h9so16603791wrc.8
        for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2020 02:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/tAldBf8G4P8zLxLg45vHYhasSD0RWL4EXZe8LNxOmk=;
        b=Bs1CDKGvtaL3YuqnE22w7H1CiaBIfDjxL1m17ETo9LLPVuQXPJOUPTOa66YSUqS9wg
         zEBp4r88NOGWETG934877OOzkOpHpVtQiRIReeb8B6KZtQ6ZHDdYbbb1fFdNljgP9Dm5
         TRT3s5wbiK4nQvngNSCs8Ie3iQ8CioAxql6pl+7gl6pxwUH1iD/2AILlo9nLIPYGhRX6
         762chlNkdodPxCtLCd7bZ7ci6OxcxQiB0KhLqfReCRcB4hHFm9PtA8bGTBzKZT290VvZ
         3xWGoo+S/2O+19WiMpn0Ud8HuLHT9+WUNe4Y+ackea1NrR7qTv+pU8G2fGI0XoVZMgFa
         8xtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/tAldBf8G4P8zLxLg45vHYhasSD0RWL4EXZe8LNxOmk=;
        b=B9+DtxN5ZIsOMcW+I2X3v9oj1mzmw0ugNa6Z991gY3WCXgWu3DfbjJvk3tN8KFTebQ
         tLZFjsztJq9hdDE5Q//ur8GEEHYPApFl638umP69u1rbT7f5VArh2iI1dHkXF4GKiV2p
         86Rf5sIJ2scONFHPL4rEvnypyd0UKO+esE79bDK/1EzzpsvH8Pive2/zojrhd2aeflqX
         69UuIvjBdHfxD923OxuHLko+b3O11IDYLW1r0BLIEtrnq0inc+sCJBasU2j9olRVQGnF
         n7+anA85Mp/wSM9yO6r6jFDegV5z45bPxUH/q14yMUZUSQC5RRqiceF1g2GL9TL61stB
         Z2nA==
X-Gm-Message-State: AGi0Puaxp+aoeV08xV5vNXJf/S6vOTjqH22YFMKdJwKoXQ+jq1bZnMaS
        aNpvyV5dysZ1zM6NF+QF8YeMiQ==
X-Google-Smtp-Source: APiQypJFm0mX9OvGjd7tv7at0Nn+E0BhUS33ZRGbzsFhYfxlNTqRquWtriNOyNWJ/gYRKzSWLfhj0A==
X-Received: by 2002:adf:9168:: with SMTP id j95mr22186195wrj.145.1586166312081;
        Mon, 06 Apr 2020 02:45:12 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:b51c:42dc:1499:2880? ([2a01:e34:ed2f:f020:b51c:42dc:1499:2880])
        by smtp.googlemail.com with ESMTPSA id f12sm25965374wrm.94.2020.04.06.02.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 02:45:11 -0700 (PDT)
Subject: Re: [PATCH] thermal: core: Send a sysfs notification on trip points
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <a7e8287d-72be-7ab0-697a-9de40eb3f81f@linaro.org>
 <20200402142116.22869-1-daniel.lezcano@linaro.org>
 <20200403144009.szjoss5ecleisg2f@axis.com>
 <e0c819ce-31f4-cee1-c7cc-7ecb73d374a3@linaro.org>
 <20200406074525.2bhseq3n5bw7dd2t@axis.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <62f5e0d0-155a-7520-cb1b-2113a2b711b3@linaro.org>
Date:   Mon, 6 Apr 2020 11:45:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200406074525.2bhseq3n5bw7dd2t@axis.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06/04/2020 09:45, Vincent Whitchurch wrote:
> On Fri, Apr 03, 2020 at 05:26:39PM +0200, Daniel Lezcano wrote:
>> On 03/04/2020 16:40, Vincent Whitchurch wrote:
>>> Normally sysfs_notify() is used to notify userspace that the
>>> value of the sysfs file has changed, but in this case it's
>>> being used on a sysfs file whose value never changes.  I don't
>>> know if there are other drivers that do something similar.
>>
>> I think so:
>>
>> eg.
>>
>> drivers/hwmon/adt7x10.c: sysfs_notify(&dev->kobj, NULL,
>> "temp1_max_alarm"); drivers/hwmon/adt7x10.c:
>> sysfs_notify(&dev->kobj, NULL, "temp1_min_alarm");
>> drivers/hwmon/adt7x10.c: sysfs_notify(&dev->kobj, NULL,
>> "temp1_crit_alarm");
>>
>> drivers/hwmon/abx500.c: sysfs_notify(&data->pdev->dev.kobj, NULL,
>> alarm_node); drivers/hwmon/abx500.c:
>> sysfs_notify(&data->pdev->dev.kobj, NULL, alarm_node);
>>
>> drivers/hwmon/stts751.c: sysfs_notify(&priv->dev->kobj, NULL,
>> "temp1_max_alarm"); drivers/hwmon/stts751.c:
>> sysfs_notify(&priv->dev->kobj, NULL, "temp1_min_alarm");
>>
>> There are also some other places I believe they are doing the
>> same like:
>>
>> drivers/md/md.c: sysfs_notify(&mddev->kobj, NULL,
>> "sync_completed"); drivers/md/md.c: sysfs_notify(&mddev->kobj,
>> NULL, "degraded");
>
> AFAICS all these drivers (including the hwmon ones) use
> sysfs_notify() to notify that the value of the sysfs file has
> changed, unlike your proposed patch.

Sorry, I don't have the same understanding:

drivers/hwmon/adt7x10.c:

 - receives an interrupt because one of the programmed temperature is
reached
 - reads the status to know which one and sends a sysfs notification

drivers/hwmon/stts751.c:

 - receives an I2C alert message, checks if it is a temperature alert
and then sends a sysfs notification

drivers/hwmon/abx500:

 - This one is probably sending a notification on a change

The documentation also is giving the semantic for sysfs_notify for
certain sysfs nodes:

Documentation/misc-devices/apds990x.txt:             sysfs_notify
called when threshold interrupt occurs
Documentation/misc-devices/bh1770glc.txt:            sysfs_notify
called when threshold interrupt occurs

AFAICT, it is a matter of documenting the notification for
trip_point_*_temp.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
