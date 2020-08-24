Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3D224FB13
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 12:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgHXKKg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 06:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgHXKKf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 06:10:35 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F133AC061573;
        Mon, 24 Aug 2020 03:10:34 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 185so8944287ljj.7;
        Mon, 24 Aug 2020 03:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x93o9Ze9wonDsohwEBfMVygsM1mTSOR04rKY13SszEQ=;
        b=RLwZtEkAaczJQh0dU0GWmBd9aRie8c3MS2bhEi5Ei9djtYTQwiUsS6cgnxsdAZ1XuV
         Hmw57FpotA6eujKbeFVU6r/4nbH823zgiBSrIzdNard3Ulj50VtTWO12k0au3Ei9QJyB
         nc9wjZmwStqMK/UhEVp6tl+lnPeM0qQHtbW9UYtzQXEOYzydFd8LMGeMHdpQz1LFQqrT
         PYHFegf2srXX/BTn5OTLD+JZWEwXpPFhh7EEjEShW+NTaBX9T84yLiFwpj9ixe8qQ+a0
         YKLmbhfRWmgjBogWTIHzwoOPOjtGw/7fyW7NQMXlZCr9Aa4+Lla4YN+ZUb6H7lrhjjQD
         og8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x93o9Ze9wonDsohwEBfMVygsM1mTSOR04rKY13SszEQ=;
        b=JneO/g1Cy7YxjIfiOY9dYIUG0zKR1YXLlsEHkIoFLsOAG6wq1/CCOmt0sExfB3aWlz
         wOZI39Yay9DJAFfmxEhZmUIIIDu7SQ/xCS8G67saaA78nYQ+AKxvXCs9FoXObZU40M2/
         dqG2DMNVeNfvFnLtuRfziW7wlzQ/x2AgJzwC5+NugMb6ImOW9ijHaBYnYawEIjTcoltY
         8oN/EWMlJuoE7+FnRqmZOoCqzTwHuBVYLwSyk9LagDl5r9GuOVk6UPgFM1HBYbNDuiYi
         4SJ43VpIcsIJ8AVcpji2ctl9I64CpIfLwk1xSB+wPrnB9p50M4A/6bdZ9z0hvV2vBxVU
         qMng==
X-Gm-Message-State: AOAM531DpiOWHkZS3OA/PYvELasoRA17hzzaSrVdRRxCrM1FJVl3nPn3
        8Ok0gH/MF47G84v+oBXV8jNBPSHE+94=
X-Google-Smtp-Source: ABdhPJyI9JA/VyF2PViMdLqi24cc5CkoEXhATc8iJZli7eqj8kR/a5nrqyGYMhAsFG5a3v/p/vCqwg==
X-Received: by 2002:a05:651c:221:: with SMTP id z1mr2159730ljn.52.1598263832577;
        Mon, 24 Aug 2020 03:10:32 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id j11sm1306277lfe.96.2020.08.24.03.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 03:10:32 -0700 (PDT)
Subject: Re: [PATCH v1 1/6] mfd: Add driver for Embedded Controller found on
 Acer Iconia Tab A500
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200823140846.19299-1-digetx@gmail.com>
 <20200823140846.19299-2-digetx@gmail.com>
 <20200823181653.GC209852@demiurge.local>
 <82abab10-9af6-a9c4-b241-d5a3af5b588d@gmail.com>
 <20200824073331.GG3248864@dell>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f12d287a-f088-4c43-479d-5c044e554b30@gmail.com>
Date:   Mon, 24 Aug 2020 13:10:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824073331.GG3248864@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

24.08.2020 10:33, Lee Jones пишет:
>> ...
>>>> +static struct a500_ec *a500_ec_scratch;
>>>
>>> If this is only used for power_off, please rename it. I've been told to
>>> do so in my driver: https://lore.kernel.org/lkml/20200519104933.GX271301@dell/
>>
>> I don't mind to rename the variable, but not sure whether it will be a
>> worthwhile change since _scratch is also a common naming scheme among
>> MFD drivers. Please see max77620_scratch for example, which I added
>> about a year ago.
> 
> If something is used once, it does not make it 'common'.
> 
> Not sure how this slipped my notice before, but I don't like it.
> 
> Ensure any global struct used for power_off only includes items
> required for this purpose.  It's unfortunate this API requires a
> global variable at all.
> 

Okay! I'll change it in the v2, thanks!

Thierry Reding was working on the shutdown API which should replace the
global variables, unfortunately he doesn't have enough time to finish
that work yet.
