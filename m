Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B591B4508C3
	for <lists+linux-pm@lfdr.de>; Mon, 15 Nov 2021 16:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbhKOPnw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Nov 2021 10:43:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60665 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236588AbhKOPnv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Nov 2021 10:43:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636990855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jOlyV7EOyHv5WlsQP7dPeTU0BSFS3H/KIdZNLcVQqGM=;
        b=NieGkXbqy5u4CXmaw4NE/4xFCg/8LckIvY9+ZmGa07I1eWQvFE9RgYu6tbce4UdaNlT+WS
        +2BafqihTtIBFqeOzD2b4FWT3kYnx9dLctRPaKvyQgciEJvL/WWAmoVWmU6v4rWCmvwa1t
        fD81ogl1D0pa3IzdPMlOXL4h2eL8rH8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375--HQ7-XPqPhWioeZW45QNFA-1; Mon, 15 Nov 2021 10:40:54 -0500
X-MC-Unique: -HQ7-XPqPhWioeZW45QNFA-1
Received: by mail-ed1-f72.google.com with SMTP id w13-20020a05640234cd00b003e2fde5ff8aso14304855edc.14
        for <linux-pm@vger.kernel.org>; Mon, 15 Nov 2021 07:40:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jOlyV7EOyHv5WlsQP7dPeTU0BSFS3H/KIdZNLcVQqGM=;
        b=0jtcrISy1FUCKFmIgImhzmNBszFyh6B1EgNoWDkbGl9bZ/rG1N2sS8aOJYdd8ZJrYS
         ZHMRM/YzbXlZeODmQyqlNjKGndjLXT0OHMInL4eHXm7HuYjU+Zyu15aw+3KPunUFHXYP
         qGhtdNpT22ofr1wq25u5otKXv/yqC9sw6KPSzTGH8IdhAqC0xj2q2mSEzMGgHd756aGt
         lxR0NoRKd2PA7zIhOJ09z0F+2yhz4BKq9EyD7cnZJyNo1gUNpLIBgRQm2kShREONIRhW
         HSdSEgMZWqBNnIaJLcoQ0M0e7KCBgPqX90b/FTa72YetuXYov40LY0zKfXGtdcw/+Nti
         AZsQ==
X-Gm-Message-State: AOAM5304X3Hi4IrfkZ437ifRKSRxlbfQ8Td/QOzPUCQjySh+oW/1rB2i
        uhxXUFx4y5JHGi9EzjSnf438BP79A8sYTN1O6i8FfjzlbM5p2MIJYWhzH3aQmEHeSLLcAnUPA7z
        zcASIMo+cd3ZZUmxrZeo=
X-Received: by 2002:a05:6402:5113:: with SMTP id m19mr57416008edd.306.1636990853170;
        Mon, 15 Nov 2021 07:40:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwDPKyyEb11g+BKxLwXQwZFfVyv+tGgMUtQwlKJf4Z9WueZJD2cZ4u8Pyzde3iKzatd6+lNig==
X-Received: by 2002:a05:6402:5113:: with SMTP id m19mr57415979edd.306.1636990852965;
        Mon, 15 Nov 2021 07:40:52 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id gt18sm6918918ejc.46.2021.11.15.07.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 07:40:52 -0800 (PST)
Message-ID: <facf6787-9ad2-c75f-8a0e-786093125a10@redhat.com>
Date:   Mon, 15 Nov 2021 16:40:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 4/4] bq25890_charger: Enable continuous conversion for ADC
 at charging
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211107202001.54579-1-jekhor@gmail.com>
 <20211107202001.54579-4-jekhor@gmail.com>
 <3414874a-3dd0-24b2-92be-f59392dba810@redhat.com>
 <20211115152313.5ls7asfwuj4eclzb@earth.universe>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211115152313.5ls7asfwuj4eclzb@earth.universe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 11/15/21 16:23, Sebastian Reichel wrote:
> Hi,
> 
> On Sun, Nov 07, 2021 at 09:48:38PM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 11/7/21 21:20, Yauhen Kharuzhy wrote:
>>> Instead of one shot run of ADC at beginning of charging, run continuous
>>> conversion to ensure that all charging-related values are monitored
>>> properly (input voltage, input current, themperature etc.).
>>>
>>> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
>>
>> Thank you for finding this! This explains why all the ADC returned
>> values like current_now where 0 when charging, I thought this was
>> just something which was only supported while not charging, heh.
>>
>> As before, the patch subject prefix should be: "power: supply: bq25890: "
>>
>> Otherwise the patch looks good to me:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
>> Sebastian, this really is a pure bug-fix patch, any chance you
>> can pick this up for a future 5.16-rc# pull-req ? 
>>
>> Regards,
>>
>> Hans
> 
> Thanks, queued to power-supply's fixes branch.

Thank you.

Note I also added this to my:

[PATCH v2 00/20] power-suppy/i2c/extcon: Fix charger setup on Xiaomi Mi Pad 2 and Lenovo Yogabook

Series, together with 2 of the 3 other patches from this series
(with some minor fixes applied to one of them).

So you can skip:

[PATCH v2 02/20] power: supply: bq25890: Fix ADC continuous conversion setting when charging

from that series (I reworded the commit msg subject a bit,
but it is the exact same patch).

If I end up doing a v3, I'll drop this patch.

Regards,

Hans

