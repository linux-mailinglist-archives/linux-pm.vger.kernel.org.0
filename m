Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEB948F061
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jan 2022 20:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237190AbiANTPr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jan 2022 14:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237142AbiANTPr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jan 2022 14:15:47 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CA2C061574
        for <linux-pm@vger.kernel.org>; Fri, 14 Jan 2022 11:15:46 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id ay4-20020a05600c1e0400b0034a81a94607so6537197wmb.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Jan 2022 11:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5O0itJH/lA0xL1Qeu26uLRfy7v6Frt7SWsYJfZo+GRs=;
        b=qrpgTl0YvHFsqgPrrVazrqsWQOZI6z1+Q/Ufhev5VMCqjyDHqE1Q4r/hYnxNbxjkp1
         MdTlvnDLCFR9GBHgwoz5EEGcHQLgoO5oiS5brC0h2GHkJ1GdSYb2LZd1wOqpuIbxpicM
         j5KMMIo2NvoBZp9M8RLxnDiyulqoUGNkCIi4dAGvzIGiKgguH4skU5zYcutDZEwLR0rc
         f4UC2/n3fv0h6T+/Cwa/km+2ZUK5VEUThJnQ3fzfMQrkp3wm9vTQMKZw3lvEXtUK3KVd
         Iy8MfhkkUgT63miF+IXV0Eb9Nz2A+usm+2cTLhhtxGjwNuIsBv6LBatuAsjSvJUn63xs
         RtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5O0itJH/lA0xL1Qeu26uLRfy7v6Frt7SWsYJfZo+GRs=;
        b=QCBsGbupfrogQ8jLrTNadQY5+fTvPc4f4ozfNsThcGH3AvF4+W5IrXLWe90WcUxmAT
         ubSIYql33SPrf+m6CZ7HbVED5Rj/TxTspQHikahwj7APNKbMLxtZ9hTp1LiTfJ2i5GGs
         CtifiEAg3KTXTcBisQRVMJeraeWN7lJM34WSSSnKyxR1qVxuwPP9CDl68IjetSvuWBzE
         JXZadufpnwmBsBAOsySWwaXAErue27nKr9xpMkgliHrn+n0UgCGu1XAg1JdiIAQNo28S
         QU+Pdc5GAxO9hAqvKcJOdYpBrHpvMVlWJJk/OlE6apXFZgwJXzxRREW97hGs5zurxfMS
         jJhg==
X-Gm-Message-State: AOAM53066j1oFaJKr+Lb4pNoSJB7UyQ4tdx55WEasdx4IO1TLCvad675
        4HTp3eQSIGcHcEc5wAyKi7PrFg==
X-Google-Smtp-Source: ABdhPJwo5MssbUuw4kvYQHZD6yQxQX46bPr4V+0dl/+6Kv9YXMg4oWtbOQxgGYGY7eemE0/eWIxHcQ==
X-Received: by 2002:a5d:4ad2:: with SMTP id y18mr9611772wrs.141.1642187745297;
        Fri, 14 Jan 2022 11:15:45 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:f91b:86ca:f5d4:288e? ([2a01:e34:ed2f:f020:f91b:86ca:f5d4:288e])
        by smtp.googlemail.com with ESMTPSA id p13sm4063939wmq.40.2022.01.14.11.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 11:15:44 -0800 (PST)
Subject: Re: [PATCH v5 2/6] powercap/drivers/dtpm: Add hierarchy creation
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     rjw@rjwysocki.net, lukasz.luba@arm.com, robh@kernel.org,
        heiko@sntech.de, arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
References: <20211218130014.4037640-1-daniel.lezcano@linaro.org>
 <20211218130014.4037640-3-daniel.lezcano@linaro.org>
 <CAPDyKFrLTsUxG8JHdK33h2BT8pxeHk6kiU-4uGrvxUhcQKg3Sw@mail.gmail.com>
 <8fcc0ef8-b0c7-da73-434f-31c88896aed5@linaro.org>
 <CAPDyKFqzxnfh0kow5mzoApFMQpKOAv=e1b7Cy9H-iEh99Wmagw@mail.gmail.com>
 <cbc70ea7-39b4-b5e8-b5c0-45fb436f53eb@linaro.org>
 <CAPDyKFoFpEjakaeb1JvYg47qoagGnzwyh2T1SpHQiwB3sFgkoA@mail.gmail.com>
 <aad4eb52-67b0-a486-53c6-755de3dee6be@linaro.org>
 <CAPDyKFrYTbVRUcYT8DMbdz4HXTbOz-xHsvUiAtmCGYdPNuOUOg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d2a9dd86-ea16-55e9-f890-d5f384373b81@linaro.org>
Date:   Fri, 14 Jan 2022 20:15:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrYTbVRUcYT8DMbdz4HXTbOz-xHsvUiAtmCGYdPNuOUOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/01/2022 13:00, Ulf Hansson wrote:
> On Tue, 11 Jan 2022 at 18:52, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 11/01/2022 09:28, Ulf Hansson wrote:
>>> On Mon, 10 Jan 2022 at 16:55, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 07/01/2022 16:54, Ulf Hansson wrote:
>>>>> [...]
>>>>>
>>>>>>>> +static int dtpm_for_each_child(const struct dtpm_node *hierarchy,
>>>>>>>> +                              const struct dtpm_node *it, struct dtpm *parent)
>>>>>>>> +{
>>>>>>>> +       struct dtpm *dtpm;
>>>>>>>> +       int i, ret;
>>>>>>>> +
>>>>>>>> +       for (i = 0; hierarchy[i].name; i++) {
>>>>>>>> +
>>>>>>>> +               if (hierarchy[i].parent != it)
>>>>>>>> +                       continue;
>>>>>>>> +
>>>>>>>> +               dtpm = dtpm_node_callback[hierarchy[i].type](&hierarchy[i], parent);
>>>>>>>> +               if (!dtpm || IS_ERR(dtpm))
>>>>>>>> +                       continue;
>>>>>>>> +
>>>>>>>> +               ret = dtpm_for_each_child(hierarchy, &hierarchy[i], dtpm);
>>>>>>>
>>>>>>> Why do you need to recursively call dtpm_for_each_child() here?
>>>>>>>
>>>>>>> Is there a restriction on how the dtpm core code manages adding
>>>>>>> children/parents?
>>>>>>
>>>>>> [ ... ]
>>>>>>
>>>>>> The recursive call is needed given the structure of the tree in an array
>>>>>> in order to connect with the parent.
>>>>>
>>>>> Right, I believe I understand what you are trying to do here, but I am
>>>>> not sure if this is the best approach to do this. Maybe it is.
>>>>>
>>>>> The problem is that we are also allocating memory for a dtpm and we
>>>>> call dtpm_register() on it in this execution path - and this memory
>>>>> doesn't get freed up nor unregistered, if any of the later recursive
>>>>> calls to dtpm_for_each_child() fails.
>>>>>
>>>>> The point is, it looks like it can get rather messy with the recursive
>>>>> calls to cope with the error path. Maybe it's easier to store the
>>>>> allocated dtpms in a list somewhere and use this to also find a
>>>>> reference of a parent?
>>>>
>>>> I think it is better to continue the construction with other nodes even
>>>> some of them failed to create, it should be a non critical issue. As an
>>>> analogy, if one thermal zone fails to create, the other thermal zones
>>>> are not removed.
>>>
>>> Well, what if it fails because its "consumer part" is waiting for some
>>> resource to become available?
>>>
>>> Maybe the devfreq driver/subsystem isn't available yet and causes
>>> -EPROBE_DEFER, for example. Perhaps this isn't the way the dtpm
>>> registration works currently, but sure it's worth considering when
>>> going forward, no?
>>
>> It should be solved by the fact that the DTPM description is a module
>> and loaded after the system booted. The module loading ordering is
>> solved by userspace.
> 
> Ideally, yes. However, drivers/subsystems in the kernel should respect
> -EPROBE_DEFER. It's good practice to do that.

Certainly.

However, it does not make sense because dtpm is not a device and I don't
see a device returning EPROBE_DEFER right now.

Wanting to handle EPROBE_DEFER will make the code a gaz factory:
 - shall we destroy the hierarchy each time a device is returning a
EPROBE_DEFER ?
     * yes : then we need to recreate it every time we recall it and we
end with an empty tree in case of error
     * no : we have to keep track of what was created or not, in order
to attach the newly device to the tree with a the parent, etc ...

So an incredible complexity for actually having no device returning
EPROBE_DEFER.

In addition, let's imagine one of the component like cpufreq is a
module, no EPROBE_DEFER handling will prevent the description being
created before the cpufreq driver is loaded.

But... I agree the hierarchy creation function should be called after
all the devices were created. For that, I think the kernel is providing
what is needed:

1. We compile the SoC specific dtpm always as a module

	depends on ... && m

2. In the module we add the dependencies to other modules

	MODULE_SOFTDEP(post: panfrost)

And with that, all dependencies are explicitly described and the
hierarchy creation is safe.

Does it make sense ?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
