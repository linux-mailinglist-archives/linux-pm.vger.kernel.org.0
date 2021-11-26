Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3048645EEFA
	for <lists+linux-pm@lfdr.de>; Fri, 26 Nov 2021 14:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhKZNVc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Nov 2021 08:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbhKZNTb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Nov 2021 08:19:31 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDEFC08E897;
        Fri, 26 Nov 2021 04:35:23 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id c32so24005277lfv.4;
        Fri, 26 Nov 2021 04:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=jqeuCZHzeT66ujUYaqAxXooaJuks6pu0YjEfTL9/Z7c=;
        b=BTcgSMd6YVmVcYLI28V7t1qPSaE77PJuacsBKncVV2l+O+OqB2BxcVjK6eLHQxxVJb
         YSgltEogTQfdqN84xc7P68wde1lzAjWxEuDLXDq5a5LQbL/nSy/XQFrHr15ImIbBzNnh
         B+ggVsywLJfepddvhblS9KXXKWzx+igsO7W1JrNTpL0Jg1PY/lW/JS+a+puPn89XSBfu
         e2aDD3TjMHcDwqw6D8ES6nEqZ/lb4HrnZFAptSEfSOrTP4p0KJs4jSBnQ4C5FJ0KHoR7
         ov9/N96ySXVseIRAtg+XfCGPpp2JreItc7qxjVbxQCmfw0wLeAhWwmX7NQjCgbrfDot8
         qn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=jqeuCZHzeT66ujUYaqAxXooaJuks6pu0YjEfTL9/Z7c=;
        b=n3xrorW0x5i1iQy2GxL3GkbnqOiJpWW1G1tMKkWmxQDQ2Mj1Y3s5aGgBeJqjBLQDHR
         jSog9Gfy2nynmHNiNyy1WFZRtw5X3iE11jbAtfqH/EzqHkgtr2ATHpy8r4SdvwCDFGSn
         Uopf+TNZPpkB1hfz3veh3QYhUs7Hx+QPGNG+BuvVb3+HA2BhklUAL6kmfHVpsGk6ffNn
         K/6BokEf8irUmcLTxP+QgOeipEFr4Egrunpxu3K+DqYHbCk8qYA04MK0A04f3gBKYp+c
         DxVMAV84VZh1tBroQ12eVYwqbFckR2T1Gj26VW0kZahkJOpK8aixZD06aCjI7vSlFusn
         nYkg==
X-Gm-Message-State: AOAM532ib8JuEKQiCVr2h/kRnpQftkFfc5eKV5FVKQWDT1I3JfbBxfn3
        amHlKXne/5ltUfQJRle5P1E=
X-Google-Smtp-Source: ABdhPJwO6IDiKlprHADj4orVmMF5Vnpj3QD/0XIGqV0vnGOhn3o4aDHxhVIQX5G6/NALqpAv6VkPqA==
X-Received: by 2002:a05:6512:2618:: with SMTP id bt24mr28715100lfb.46.1637930121494;
        Fri, 26 Nov 2021 04:35:21 -0800 (PST)
Received: from ?IPV6:2001:14ba:16ee:fa00::4? (dc73szyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::4])
        by smtp.gmail.com with ESMTPSA id n7sm495101lfu.116.2021.11.26.04.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 04:35:20 -0800 (PST)
Message-ID: <28df4678-345b-78e0-06f0-1fdcbaff455d@gmail.com>
Date:   Fri, 26 Nov 2021 14:35:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "rostokus@gmail.com" <rostokus@gmail.com>,
        "fan.chen@mediatek.com" <fan.chen@mediatek.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
References: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
 <6123f62ac44e6513a498d15034a4b6b22abe5f5b.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
 <CACRpkdbKeW+pJ8SZ0fPD+9kEtgHgi2A9U=f6XyKTHogKU-9F9g@mail.gmail.com>
 <7b34e88f-54f3-6d0a-293e-b2b411d1c5c2@fi.rohmeurope.com>
 <676253b9-ff69-7891-1f26-a8b5bb5a421b@fi.rohmeurope.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [RFC PATCH v3 3/9] power: supply: Support DT originated
 temperature-capacity tables
In-Reply-To: <676253b9-ff69-7891-1f26-a8b5bb5a421b@fi.rohmeurope.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/26/21 13:56, Vaittinen, Matti wrote:
> Hi dee Ho again,
> 
> On 11/18/21 08:11, Matti Vaittinen wrote:
>> Hi Linus,
>>
>> On 11/18/21 04:10, Linus Walleij wrote:
>>> On Tue, Nov 16, 2021 at 1:26 PM Matti Vaittinen
>>> <matti.vaittinen@fi.rohmeurope.com> wrote:
>>>
>>>> Support obtaining the "capacity degradation by temperature" - tables
>>>> from device-tree to batinfo.
>>>>
>>>> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
>>>
>>> Same questions as on the binding patch.
>>>
>>> If we already support different degradation by temperature tables,
>>> why do we need a second mechanism for the same thing?
>>
>> Thanks for bringing this up. As I said, I didn't notice that we could
>> indeed use the CAP-OCV tables for different temperatures to bring in
>> this information :) I see certain benefit from the possibility of not
>> requiring to measure the OCV at different temperatures - but it may not
>> be meaningful. As I replied to your patch 1/9 review - I need to (try
>> to) do some more research...
> 
> 
> I don't see providing OCV tables at different temperature gives the
> degradation of battery capacity. Whoah. A big thought for Friday.
> 
> We get the OCV => SOC correspondance at different temperatures. I
> however don't see how this gives the OCV => energy relation.

After reading what I wrote even I didn't know what I tried to say. Well, 
I think I tried to explain that I don't see how we can use this 
information to do any estimation what the Coulomb Counter reading 
represent at the given temperature. This is what the 
temperature-degradation tables aim to give us.

  As far as I
> know both the OCV and the 'amount of uAhs battery is able to store' are
> impacted by temperature change. This means, seeing the OCV => SOC at
> different temperatures does not tell us what is the impact of
> temperature to the OCV, and what is the impact to SOC.

I think I tried to say that these curves don't help us to tell how many 
uAhs we have in battery with different temperatures when battery is 
empty, or half full or, ... Again, what we would like to know is what 
SOC our CC value represents - and use OCV to just adjust this further 
(or in some cases to correct the CC value using OCV - if we can trust 
the battery to be properly relaxed).

Hope this did clarify. Afraid it didn't :)

Best Regards
	-- Matti Vaittinen

