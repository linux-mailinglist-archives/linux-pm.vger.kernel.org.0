Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E5C2C8088
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 10:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbgK3JE0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 04:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbgK3JEZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2020 04:04:25 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05FAC0613CF;
        Mon, 30 Nov 2020 01:03:44 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id k65so10702304ybk.5;
        Mon, 30 Nov 2020 01:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+2ZRUyIjSZgEt9jrdh2AvSfUjnbTRrg7lUQuyst/vJU=;
        b=kNDxG8ug0FrzPr6xyuTvBrlFGslARPWOIXfDSC2LECGMlAYZba6VjXMSoAJoDUWx0t
         KvFcSNL6TQ3O7NjU9+A93NuzTli6K3mNbhlTAufspUOXoDABbJmtVWerTgsfHM0y+Vdx
         TETdMIxDuwgT+TmECGeApk8t29prFoDjFMFlBkqpvW2+OzGerRNsWKWzpT3xc5/XIf1B
         XxbUsxUpIeGV9X4K0L/Friqk4LA2B6dOeDbvvPVJJQfwyDaRG6eP703uvN0bU9iI2eca
         H+NK7+cY2MahY+smxi7lk7yVbKm9dw7J2sdZlMIDMNzqx6ORnqQrp71MrGg6HVEib17w
         vxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+2ZRUyIjSZgEt9jrdh2AvSfUjnbTRrg7lUQuyst/vJU=;
        b=A95LmN+rYx2I3Rp1/0Z5GMVwSM3o+tnkPWV5Yt7/kXf0y/n1VEVSC7BkZ6RNdGAFrE
         JyI7YUaNz0bUyBVPq2pxswmByqkSyrX0TxuOeQvejoFBmoRNIgKUvp8sB+KjGPUbrs+e
         lJr6y6Bg2EYrY8WNQjceavUJJGPZogfQWONRlC5GmugJ9hSa/ZdHxPTpfrDu9VcIC1FN
         Yi0Xb1uw549Lwu47ROLrQNNaOjhqQeCShNXw5OPADz3xMs/ioSLZjTsXJ5T6yP8BRO8/
         krtSDw9ww3DnCS0yxVW/xyFXqWcEYY8dklcNaGDxA5W7JqY5JRoee2JgiBJvRH5XP7S3
         GRNQ==
X-Gm-Message-State: AOAM5304x3z9sXa5+xHrAsyShJkZhBujzNsrxvnTLumH/1xmbfakaCtS
        zuqSKIl3+A6SuT+YSpKTucyyJ7QzKi7Lcu220a4=
X-Google-Smtp-Source: ABdhPJzwXVVu1TaFVSyPXmmUoH5/53lLiX+2hkppSUADqrzNcbDlp1CM7kkS+zm8sADITtvhKyCb5TdinZSOxRAQjkw=
X-Received: by 2002:a25:848e:: with SMTP id v14mr25950548ybk.153.1606727023979;
 Mon, 30 Nov 2020 01:03:43 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:63b6:b029:2b:7e30:9bac with HTTP; Mon, 30 Nov 2020
 01:03:43 -0800 (PST)
In-Reply-To: <fc2e095f-d417-1547-4075-9ece1aeaaf4d@arm.com>
References: <1606466112-31584-1-git-send-email-gao.yunxiao6@gmail.com>
 <724ddf78-483c-2cf3-441c-4885af8425a9@arm.com> <1af5220c-f598-58f4-488e-fdd505477ed5@linaro.org>
 <fc2e095f-d417-1547-4075-9ece1aeaaf4d@arm.com>
From:   gao yunxiao <gao.yunxiao6@gmail.com>
Date:   Mon, 30 Nov 2020 17:03:43 +0800
Message-ID: <CANO_MS+n6CTom-o7Hs4dKtPf-2uih5R7_8BnU_b4Jv8g1a5dkg@mail.gmail.com>
Subject: Re: [RFC 1/2] dt-bindings: thermal: sprd: Add virtual thermal documentation
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        amitk@kernel.org, robh+dt@kernel.org, javi.merino@kernel.org,
        linux-pm@vger.kernel.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        orsonzhai@gmail.com, zhang.lyra@gmail.com,
        "jeson.gao" <jeson.gao@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel

Thank you for your the new information

I have a question trouble to you
We should choose which per-core thermal zone as the IPA's input
reference temperature in the current kernel version? thank you.

On 27/11/2020, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
> On 11/27/20 1:26 PM, Daniel Lezcano wrote:
>>
>> Hi Lukasz,
>>
>> On 27/11/2020 10:27, Lukasz Luba wrote:
>>>
>>>
>>> On 11/27/20 8:35 AM, gao.yunxiao6@gmail.com wrote:
>>>> From: "jeson.gao" <jeson.gao@unisoc.com>
>>>>
>>>> virtual thermal node definition description in dts file
>>>>
>>>> Signed-off-by: jeson.gao <jeson.gao@unisoc.com>
>>>> ---
>>
>> [ ... ]
>>
>>> It's coming back. There were attempts to solve this problem.
>>> Javi tried to solved this using hierarchical thermal zones [1].
>>> It was even agreed (IIRC during LPC) but couldn't continue. Then Eduardo
>>> was going to continue this (last message at [3]). Unfortunately,
>>> development stopped.
>>>
>>> I also have out-of-tree similar implementation for my Odroid-xu4,
>>> which does no have an 'SoC' sensor, but have CPU sensors and needs
>>> some aggregation function to get temperature.
>>>
>>> I can pick up Javi's patches and continue 'hierarchical thermal zones'
>>> approach.
>>>
>>> Javi, Daniel, Rui what do you think?
>>
>> I already worked on the hierarchical thermal zones and my opinion is
>> that fits not really well.
>>
>> We want to define a new feature because the thermal framework is built
>> on the 1:1 relationship between a governor and a thermal zone.
>>
>> Practically speaking, we want to mitigate two thermal zones from one
>> governor, especially here the IPA governor.
>>
>> The DTPM framework is being implemented to solve that by providing an
>> automatic power rebalancing between the power manageable capable devices.
>>
>> In our case, the IPA would stick on the 'sustainable-power' resulting on
>> the aggregation of the two performance domains and set the power limit
>> on the parent node. The automatic power rebalancing will ensure maximum
>> throughput between the two performance domains instead of capping the
>> whole.
>>
>>
>
> Make sense. Thank you for sharing valuable opinion.
>
> Regards,
> Lukasz
>
