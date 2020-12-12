Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15ABE2D8AA5
	for <lists+linux-pm@lfdr.de>; Sun, 13 Dec 2020 00:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393751AbgLLXkL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Dec 2020 18:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbgLLXkL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Dec 2020 18:40:11 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E503BC0613D3
        for <linux-pm@vger.kernel.org>; Sat, 12 Dec 2020 15:39:30 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id q75so11937389wme.2
        for <linux-pm@vger.kernel.org>; Sat, 12 Dec 2020 15:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3RA7b4gOSOMOF2MsxAHtn2aENtr19yvmNfEq8yHFz8U=;
        b=FrAF7Ou7p2Xmsy2mYbf3y2dqECOoelFe/cZKKPyeoD4YLU89gU/1mQ0wHL+2zMhKSi
         Z4VwxEVgVHD6ht6uVHyEevG2fnVfvV5ytx9fxSIg0/F/nb1PYKS+i6Nd1aWKewdVGvAE
         u7qhKzvHPc0RkpvjtEDpLuTJf6KCsZWCgnEQzJpn0K6B4Dj5zh7xsWeIKzDKNNCwQOZ3
         es39xHUCasEmu3IbdC5wXi4a0oSnOnZ7MpJgKpYU6JvPuftqEpK2X9P0N97sBnePYgY9
         jzf3yLo4UinmdTzZsXR5eV3XFkZuU3kAkM4XcVIlC8wrFrNi9/yrSuGxJQ1T3uBi+cj3
         wFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3RA7b4gOSOMOF2MsxAHtn2aENtr19yvmNfEq8yHFz8U=;
        b=S97GhWJiGAIyF6V+ip6SpD1M7TbJgGJTODJkQlY+/TTT5m2BxQ0YY5z6QNlwNqVgXe
         sHm5ImkrAptXKKKv8F1SRgK+RiI/Fw/Xelt0kjrpgtfiFrOH/UE4ny/gik3QCmsk6VTt
         JprQQQNzcqs7AyEhB8+xb4dLQeeMnX1R64ETFjpIVO4jK9KLmUoiTa38T4yjMftfbNaN
         /Mc6RbpRPkD4SHHJNzhIbUok+9AVW69tu1zGIByMch6MvGkJvSvMHGU2CBqQdNASHJon
         7YfXfGtVJ2NMXMPJ9pJ5g4ovevzeGzHhQ+Wb3ONvfnlzFva5jMJSR7SokKuD8chiT2fJ
         5xOQ==
X-Gm-Message-State: AOAM531dFT1VQykXeo2yo6p3Bo34Xf226n5Ly30Piip/9RGYG1XS2GzK
        KoKd+gG0i78phWs8wbTNH/ileA==
X-Google-Smtp-Source: ABdhPJxnc44nkAyYl2TTEvZs1Q4LGKIKq9jDhWN3hzL1fJUEGZYYhkzZrEV+o/2aIEoMZFGRhCgp5w==
X-Received: by 2002:a1c:3902:: with SMTP id g2mr20337872wma.117.1607816369152;
        Sat, 12 Dec 2020 15:39:29 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:fd07:6f0a:92a7:a3a0? ([2a01:e34:ed2f:f020:fd07:6f0a:92a7:a3a0])
        by smtp.googlemail.com with ESMTPSA id w17sm23443556wru.82.2020.12.12.15.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Dec 2020 15:39:28 -0800 (PST)
Subject: Re: [PATCH] thermal/core: Make 'forced_passive' as obsolete candidate
To:     Matthew Garrett <mjg59@codon.org.uk>
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, amitk@kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>
References: <20201208153046.297456-1-daniel.lezcano@linaro.org>
 <cc2085ca-ada9-d616-eed5-3496889da3bb@linaro.org>
 <20201212035012.GA11926@codon.org.uk>
 <20015331-955b-756f-3dce-4eb78e473704@linaro.org>
 <20201212200806.GA19048@codon.org.uk>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6105a8e5-7590-5ba1-5f2b-aa24bf286150@linaro.org>
Date:   Sun, 13 Dec 2020 00:39:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201212200806.GA19048@codon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/12/2020 21:08, Matthew Garrett wrote:
> On Sat, Dec 12, 2020 at 10:11:31AM +0100, Daniel Lezcano wrote:
>> On 12/12/2020 04:50, Matthew Garrett wrote:
>>> Yes - what's the reason to do so?
>>
>> I'm cleaning up the thermal core code, so questioning every old ABI.
>>
>>> The code isn't specific to ACPI,
>>> so being able to override ACPI tables doesn't seem to justify it.
>>
>> I agree, the code is no specific to ACPI.
>>
>> What non-ACPI architecture, without device tree or platform data would
>> need the 'passive' option today ?
> 
> Anything that provides a trip point that has no active notifications and
> doesn't provide any information that tells the kernel to poll it.

I'm not able to create a setup as you describe working correctly with
the forced passive trip point.

The forced passive trip can not be detected as there is no comparison
with the defined temperature in the thermal_zone_device_update() function.

The commit 0c01ebbfd3caf1 may be responsible of this.

If my analysis is correct, this 'feature' is broken since years, more
than 8 years to be exact and nobody complained.

If I'm right, we can remove this feature directly.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
