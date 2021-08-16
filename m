Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C1A3EDD6C
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 20:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhHPS5b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 14:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhHPS5a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Aug 2021 14:57:30 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A503C0613CF
        for <linux-pm@vger.kernel.org>; Mon, 16 Aug 2021 11:56:58 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u15so12180032wmj.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Aug 2021 11:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m7ZOM7cdRkICqtiyacBDNsj4qURRxO1sWw5i5EgJhx0=;
        b=HzJ75RUvClIBbqraulv6LCtCEKRyhF9l86bNICahsL0BMDn+tr2MAGedaCoiS/M7HI
         3Ttln2ZDTzMQV/73OAgb5gWdhqVTcAfaMui/jwC/yGkqKyrWPECIE5BGB9wuRotTtJZR
         n8glPdDvrAkL6NsfQuijpU7NTf+EitF7KrlYHBWiagTBD87z3EiqPC6ePhyVfex4LW1R
         bzJOqbK5rRd2/pUmjgicupfKYa5CF6ZgyjklG6WR05kEG1tJglD4u63hsIct80uAMX0l
         mufsLlgPEG0x9jXY+YS8QfK1nmsTKOsGjQu5tgwNUmQkNLRKK/BFJRlM20iaJgIeqnG2
         Ks6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m7ZOM7cdRkICqtiyacBDNsj4qURRxO1sWw5i5EgJhx0=;
        b=XHBWss9l3rMUXr96kgjn8lL+jypx9e8WU6E/JXrUP6Xt066QJe2lGbaMUOpd/9WHAZ
         3zLmqi0adWRwE2F3hgiYF/qzak64BV/sTSIoDsXJI/pwq9KLOsCFk6Uv05rvSkv0mAhb
         Z0we9MOr1vZxGVelBDV32ZqSnqd8CVxPoa1V5/SsolUX69rx2rUfOpJmFotybvmQlJ8D
         KMD/VE+RsCdiAWZTCGq5ARrOYqsJjdhFyzoo7O4nDxcGt7kd4eFe8LkF29Kn3El/yH95
         HZWvUMSZm+TgehN2+qBvhtLJWlhTHk4YMPT1ySP8q0LIn2VPtB4LAdjVsLhSR9wPnrH7
         93Qg==
X-Gm-Message-State: AOAM533tvh5rptdCSnPqSJjpMwx8gNBwPll9G+QltGdH49EFWe5+xwWS
        6Y9reKOpaLUoCxfMXe6WXNp+sA==
X-Google-Smtp-Source: ABdhPJzoBGbVSUBBJBd79CzIiBUvM5rY3Ebc57V8YSLGDbhAuaNana1b9dAMLW1tLEGIgbbn9dJJ0g==
X-Received: by 2002:a1c:f414:: with SMTP id z20mr524519wma.94.1629140216638;
        Mon, 16 Aug 2021 11:56:56 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:e1b0:48c1:6199:9cb4? ([2a01:e34:ed2f:f020:e1b0:48c1:6199:9cb4])
        by smtp.googlemail.com with ESMTPSA id g9sm386690wmk.34.2021.08.16.11.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 11:56:56 -0700 (PDT)
Subject: Re: [PATCH v5 2/3] thermal: mediatek: Add LVTS drivers for SoC
 theraml zones
To:     Ben Tseng <ben.tseng@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        srv_heupstream@mediatek.com
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, hsinyi@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Michael Kao <michael.kao@mediatek.com>,
        Yu-Chia Chang <ethan.chang@mediatek.com>
References: <20210617114707.10618-1-ben.tseng@mediatek.com>
 <20210617114707.10618-3-ben.tseng@mediatek.com>
 <06b1804c-4675-2997-8c5c-bcdffbcfc4a1@linaro.org>
 <1f92b245537d6390b7b2bde62ce8b99a3df9d445.camel@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8a38b9fe-0448-3ddc-9ffc-c43137b5ecaa@linaro.org>
Date:   Mon, 16 Aug 2021 20:56:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1f92b245537d6390b7b2bde62ce8b99a3df9d445.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Ben,

On 23/07/2021 08:17, Ben Tseng wrote:
> On Mon, 2021-06-21 at 13:26 +0200, Daniel Lezcano wrote:
>> On 17/06/2021 13:47, Ben Tseng wrote:
>>> From: Michael Kao <michael.kao@mediatek.com>
>>>
>>> Add a LVTS (Low voltage thermal sensor) driver to report junction
>>> temperatures in Mediatek SoC and register the maximum temperature
>>> of sensors and each sensor as a thermal zone.
>>
>> I think we already talked about that. We don't want a thermal sensor
>> driver to aggregate the temperatures but create some kindof virtual
>> sensor with a property (min, max, avg, ...) which is usable by
>> anyone.
>>
>> [ ... ]
>>
>>
>>
> 
> Dear Daniel,
> 
> Sorry for the late reply.

sorry too, missed to answer. Another thread pointed to this one and I
figured out I forgot to answer.

> After survey ,I'm not sure whether the patch[1] is the architecture of
> virtual thermal sensor which you commented.

Ah, yes that is kind of what it would be requested but really generic so
anyone can use it.

> Or, is there any existing framework on mainline already support virtual
> sensor?

No unfortunately, it is not done [yet].

> Could you help to provide reference to us?

Ok, we had this discussion several times on the mailing list and at the
different events like the Linux Plumbers conference. But I was not able
to find out a pointer.

Basically the idea is simple, we don't want drivers doing weird things
in their get_temp callback. This callback must return the temperature
associated to a physical sensor in a 1:1 manner.

However, some people want to define a thermal zone but with an
aggregation of different sensors.

At this point, we are unsure how to do that.

Having a virtual sensor would be more adequate as it won't impact
anything except the DT for a configuration. And we can make it to evolve
without having to change all the thermal framework internals.

From a DT point of view, a virtual sensor device cuold have phandles to
the different sensors and let's say a property telling what do to (avg,
min, max, ...). The thermal zone will point to the virtual device.

In the driver itself, the get_temp will just call get_temp of all the
sensors and do the operation specified in the property.

With that, the drivers stay consistent and we have the flexibility to do
whatever we want.

Does it make sense ?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
