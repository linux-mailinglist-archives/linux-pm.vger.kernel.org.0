Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3C61C4566
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 20:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbgEDSOy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 14:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730931AbgEDSAF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 14:00:05 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38518C061A0E
        for <linux-pm@vger.kernel.org>; Mon,  4 May 2020 11:00:05 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 188so495649wmc.2
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2020 11:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qbmRVkJVnDjRqhdFY+l/ig1wTrc758l+/8RY3n4wjFc=;
        b=PrJGfQ5M+WmbbFqCXZZjiflyl42zUUO4bLQu04MZySO3vfwbQdagYqYvMO3ZIrSDhJ
         sAN7Jsw5y4Mza7k/s9JBHHJSP2HPGKEH2TetQbSDCpiBPhTD6wk2+F9hXVZBP9RVntHX
         AW+BB6OaY2nEIZ0A4HTMAHB5Embv9TjRxxTo5Rh8NUgzPcL8owogcYqYQGer8s5ff1vX
         KdAmLsOiE5kSh36ooaNRl3L8gIi3GTtH4wn5CesKc255fvNyK37iyO00+PR/Z/Iss5xX
         m32segT/SepHrM+2ty1btGlebX9G3wH2nCvorA4B1gQwxr4Pt8V/KBw3cYw3545uKHQm
         JkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qbmRVkJVnDjRqhdFY+l/ig1wTrc758l+/8RY3n4wjFc=;
        b=Q2SH1suJyhb1PaoJsxWlLiFX/s8W78tlTljHe0V5DZ/oynDXqRUoB01Cto9nttpPYe
         v+5vy36f2gupDsv9TmUKCn6TceUaSiXEIPTZnwjcUeWWs/wVBsfBvopv2d9LlcdD9KXH
         z5HGi10yF6QpcjTApjF0VqxffyB3NzAiDBMMoPLiD3Xt4OTQJpNUsk6mSbQ9vE/Z/fp/
         xbhSpf/ngsL8wMiS27jRl3apsQtEPMQAV840rB2WB7pSEZ7PPGhbtdRvF8q0yKKjc57P
         P2hNalbLXKOZ7XBip6Fbm8esZZ30VqBFBTKtunsIZOA7rj45wzbLEOMh7A72kLVRos+5
         nIdQ==
X-Gm-Message-State: AGi0PuaWxHFXUxB5vGPWrvK2SYs8dHNOLhp7HScMkcPaSlzxztR0KCG+
        hB5yvqqSHpJofYBaNBjFR23WAw==
X-Google-Smtp-Source: APiQypIIewN+KD0rmmmMDEFgyICcmHYy6pzcXOsTGiaXb7cTDdxUe2Z9XD2ayjd0GNyIyyvA4SuvFA==
X-Received: by 2002:a05:600c:1008:: with SMTP id c8mr15239758wmc.14.1588615203806;
        Mon, 04 May 2020 11:00:03 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:1938:2e25:c14c:a06e? ([2a01:e34:ed2f:f020:1938:2e25:c14c:a06e])
        by smtp.googlemail.com with ESMTPSA id w83sm267860wmb.37.2020.05.04.11.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 11:00:02 -0700 (PDT)
Subject: Re: [PATCH v4 4/4] thermal: cpuidle: Register cpuidle cooling device
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>, rui.zhang@intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "open list:CPU IDLE TIME MANAGEMENT FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CPUIDLE DRIVER - ARM PSCI" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200429103644.5492-1-daniel.lezcano@linaro.org>
 <20200429103644.5492-4-daniel.lezcano@linaro.org>
 <99b3bc79-f48a-3d51-a8ae-8b9ca4856d36@arm.com>
 <04b5da25-d591-b08a-e554-6e084d7ea908@linaro.org>
Message-ID: <f3cee834-4946-10bd-a504-df6cf62d9e90@linaro.org>
Date:   Mon, 4 May 2020 20:00:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <04b5da25-d591-b08a-e554-6e084d7ea908@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi,

On 29/04/2020 23:01, Daniel Lezcano wrote:
> On 29/04/2020 22:02, Lukasz Luba wrote:
>>
>>
>> On 4/29/20 11:36 AM, Daniel Lezcano wrote:
>>> The cpuidle driver can be used as a cooling device by injecting idle
>>> cycles. The DT binding for the idle state added an optional
>>>
>>> When the property is set, register the cpuidle driver with the idle
>>> state node pointer as a cooling device. The thermal framework will do
>>> the association automatically with the thermal zone via the
>>> cooling-device defined in the device tree cooling-maps section.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> ---
>>>   - V4:
>>>     - Do not check the return value as the function does no longer
>>> return one
>>> ---
> 
> [ ... ]
> 
>> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> Thanks Lukasz for the review.
> 
> Rafael, as Lorenzo and Sudeep are not responsive, could you consider ack
> this patch so I can merge the series through the thermal tree ?

Gentle ping ... Sudeep, Lorenzo or Rafael ?

Thanks

  -- Danie



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
