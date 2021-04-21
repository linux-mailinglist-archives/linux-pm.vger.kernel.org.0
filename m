Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07013366AB4
	for <lists+linux-pm@lfdr.de>; Wed, 21 Apr 2021 14:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238702AbhDUM1E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Apr 2021 08:27:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45891 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235145AbhDUM1D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Apr 2021 08:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619007990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JiwbXjmwv7WSPaNysAbVhn2SptL19dKY+XRIVBMw2AM=;
        b=CRbJnXzNEuxsl9oJ/8fSufw7SkKE4Jd72SMGl5kUvy5PdhVz/1IqKLpMKovkkbn6NqNEXT
        BdYo+jyj3HizX/x270tA9SIaGH8zWR55t3hyH8TCy6zm97pjPqCMjOnVd5GNNpXS0p4fwK
        1G4lJucOS0/Nmtjv+VLN26fYkmR7D98=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-_kvsGx7pPiGI0MrQolALhw-1; Wed, 21 Apr 2021 08:26:28 -0400
X-MC-Unique: _kvsGx7pPiGI0MrQolALhw-1
Received: by mail-ej1-f71.google.com with SMTP id r14-20020a1709062cceb0290373a80b4002so5798826ejr.20
        for <linux-pm@vger.kernel.org>; Wed, 21 Apr 2021 05:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JiwbXjmwv7WSPaNysAbVhn2SptL19dKY+XRIVBMw2AM=;
        b=dWR5fMFc555Ur2CfsCjCpxRgKFeeJYNjG5AfMEBWjP6KDZuP65vspKvc8Ghg5yqOSM
         7CJlOBA4uyYxxOULjvJT0Mn76t9Y+s1WDURZxOd1hIUyNwM9NTtUpr1ejcSxghD217zV
         AcMluRDhzNHF0ZAG4JCAzUrcprnRSyUxZ7dJdpRAdCpU8P/WWkOmISBNCSUG6GGzeLlb
         ROHqONISQiqORiUEatDBM633Cx1e7z9FZhZYH+kiLi+7KACyFRlEMcNmMXDo3yCgDueo
         U4sEvd/Q9+G+I8TPTml7AoFikSf0EffnDPgsaFGZcziYRqSRwxyBgGVHPe1qulwVcCUK
         s2Zg==
X-Gm-Message-State: AOAM5312zSI3iHNQgboToNdNM1Dd2MJd/p3OtJvPpym5Hk2I0Z/jg0Q0
        xmYlVQ4fzJy/wFx1Ql7DP6Z4QgvUnjSsHxz+csv7pMh07gaodnLyAJukLrMaf4iur+wcTlgqxKX
        oQ9f6mbXqh1vL0IBwehA=
X-Received: by 2002:a05:6402:2794:: with SMTP id b20mr20506132ede.48.1619007987359;
        Wed, 21 Apr 2021 05:26:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7yRkfzjtIoczfISFbr/N7MhY4x+m8ezWTbWctqf/bSo8LTZjrsr4mbWZVCx6Lxhbh1fXM5g==
X-Received: by 2002:a05:6402:2794:: with SMTP id b20mr20506111ede.48.1619007987227;
        Wed, 21 Apr 2021 05:26:27 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id u23sm3146200eds.8.2021.04.21.05.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 05:26:26 -0700 (PDT)
Subject: Re: [PATCH v3 2/8] MAINTAINERS: Add entry for devm helpers
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "wens@csie.org" <wens@csie.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "agross@kernel.org" <agross@kernel.org>,
        "cw00.choi@samsung.com" <cw00.choi@samsung.com>,
        "broonie@kernel.org" <broonie@kernel.org>
References: <cover.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
 <eec1797734e3d080662aa732c565ed4a3c261799.1616506559.git.matti.vaittinen@fi.rohmeurope.com>
 <e064fdd7-b276-6732-16fe-2eb2564b2179@redhat.com>
 <YFn5CSB1O3i+SzgR@kroah.com>
 <da0233f3223d7c0816581afe0969caf0abe20378.camel@fi.rohmeurope.com>
 <96935c55-c799-595e-024c-56fd352f279e@redhat.com>
 <2f6d096c30a6d1d22422cf9c3553d74132f75708.camel@fi.rohmeurope.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <171af93e-e5be-b35f-23d4-0ccf37062902@redhat.com>
Date:   Wed, 21 Apr 2021 14:26:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2f6d096c30a6d1d22422cf9c3553d74132f75708.camel@fi.rohmeurope.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 4/21/21 2:17 PM, Vaittinen, Matti wrote:
> 
> On Wed, 2021-04-21 at 13:58 +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 4/21/21 9:51 AM, Matti Vaittinen wrote:
>>> On Tue, 2021-03-23 at 15:19 +0100, Greg KH wrote:
>>>> On Tue, Mar 23, 2021 at 02:58:28PM +0100, Hans de Goede wrote:
>>>>> Hi,
>>>>>
>>>>> On 3/23/21 2:56 PM, Matti Vaittinen wrote:
>>>>>> Devm helper header containing small inline helpers was added.
>>>>>> Hans promised to maintain it.
>>>>>>
>>>>>> Add Hans as maintainer and myself as designated reviewer.
>>>>>>
>>>>> Ultimately this is up to Greg though, so lets wait and see what
>>>>> Greg has to say about this.
>>>>
>>>> Can we move some of the devm_* calls in include/device.h into
>>>> here as
>>>> well so that you all can be in charge of them instead of me?
>>>
>>> Seems like this was left w/o answer. I guess the question was
>>> pointed
>>> to Hans
>>
>> I believe that Greg was (mostly) joking here. At least that is how
>> I interpreted Greg's reply,which is why I did not answer.
> 
> Ah. I missed the sarcastic tone of typing. I should've noted that by
> the font :]
> 
>> Also note that Greg merged this series, but not this patch,
>> so the new devm-helpers.h file will presumably be maintained by Greg.
> 
> Hmm. Are you sure?
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=driver-core-next&id=2077ca682169afb212d8a887c70057a660290df9

Ah, you're right.

I was looking at the wrong branch, sorry about the confusion.

Ok, so I guess I do maintain the new devm-helpers.h file, that is fine.

Which makes your email from earlier today more relevant:

> but what comes to my (not always so humble) opinion - most of
> the devm functions in device.h are tightly related to the device
> interface or devres. Thus the device.h feels like appropriate place for
> most of those.

I agree with you that most devm_ functions in device.h are probably
left there. Moving them will also mean modifying all the drivers
which use them to include the new devm-helpers.h include file
which seems like needless churn.

> OTOH, the kmalloc/kfree related functions, strdub and
> kmemdub might be candidates for move - those are not really "device
> things".

I'm certainly open to moving some functions to devm-helpers.h, but
also see above about needless churn.

Regards,

Hans

