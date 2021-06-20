Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789F23AE052
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jun 2021 22:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhFTUht (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Jun 2021 16:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhFTUhs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Jun 2021 16:37:48 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78721C061574;
        Sun, 20 Jun 2021 13:35:34 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id f8so14805756lfu.6;
        Sun, 20 Jun 2021 13:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h7qy3vsXHdigHBzb/NyGdUZpvcQTxWroavq6cxrlgrU=;
        b=Btk7qYK3cuIjJG70Wd/CdQyik6FRcf7NkbaeLKdXQ8EfUJVLVOJXJyVT0AfFFkZ5HX
         KRthrLtmpbmtwnav53QuXUqfulOH0mZ0BhTI/IIVQs62u//haV0ZOnbLKk8fW/yRdiRd
         dQbAFKoN+rCYZSvbxUN18b6RehqOr+Y1y+qLVpSPGsR9klV5ixxtp67axlZjyDVs11Hi
         oDGd0Z9sYfz807Up17DrEfqedQLt30hKltSzgvhRzZj3st0kze7RDzHtLArKx5XgbqTe
         saOuHrwYo4t2CcBEt585IbbPMam2DTv6SELZKsObgCLwzdgXqZ49xwW4fUna5e3s9+GZ
         Xjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h7qy3vsXHdigHBzb/NyGdUZpvcQTxWroavq6cxrlgrU=;
        b=kGpFAExK8u1Wk89usRfzMNYtjjYtL94kau8kfP57MiAz7GH+eL+V3peY9l5oMITq3f
         FjPLyaBaFd9G9CyJlKICqoNbyITuDiwoVFGWg6F1zKFzyB0SbzOfuexIGIRR7XT3WHLF
         AUOUT3WFqtOQ+TjF33xp76eGSnnrFsH/bLy9TuXgL7yRwLKXkHpMNlXz2EZP1tM7Emsn
         ogQ44DD/wz8ECrcdDIEcpMpnxCXJFXzX4vbCwbnThn3/AqPS0Du2NmuevI6NSDnXauf2
         Ja2ljb1U9IThDaMsJvwd5AWUGtsM2fMYMyBDSBQWs6gpD18dspqQ1gTTN/C4GFSMZ3aD
         13MA==
X-Gm-Message-State: AOAM533/BLjHjp/dwYp3eLlI+7w/Jwuj/eXrXQjnpyw6MVr9am57LxKF
        0lCdhoaFN1lcKUvFkV/GsKxqninfT4E=
X-Google-Smtp-Source: ABdhPJy2QDvhHZzX8bLZV5CJENS4/s2JkNM/+OmtNh27GCujgDHvSadOKkXf+/kSAVAiSAkMkq7kiw==
X-Received: by 2002:a05:6512:3f8d:: with SMTP id x13mr11719547lfa.278.1624221332611;
        Sun, 20 Jun 2021 13:35:32 -0700 (PDT)
Received: from [192.168.2.145] (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.googlemail.com with ESMTPSA id g16sm1860932ljn.103.2021.06.20.13.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jun 2021 13:35:31 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] hwmon: Support set_trips() of thermal device ops
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20210620161223.16844-1-digetx@gmail.com>
 <20210620161223.16844-2-digetx@gmail.com>
 <20210620172329.GA3850372@roeck-us.net>
 <1cb97f70-9fdd-e7d5-da73-dc5c42a53104@gmail.com>
 <20210620192124.GA3853199@roeck-us.net>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4d12b57c-3dbb-e290-3f82-eb30aefa7dd4@gmail.com>
Date:   Sun, 20 Jun 2021 23:35:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210620192124.GA3853199@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

20.06.2021 22:21, Guenter Roeck пишет:
> On Sun, Jun 20, 2021 at 08:38:27PM +0300, Dmitry Osipenko wrote:
>> 20.06.2021 20:23, Guenter Roeck пишет:
>>> On Sun, Jun 20, 2021 at 07:12:22PM +0300, Dmitry Osipenko wrote:
>>>> Support set_trips() callback of thermal device ops. This allows HWMON
>>>> device to operatively notify thermal core about temperature changes, which
>>>> is very handy to have in a case where HWMON sensor is used by CPU thermal
>>>> zone that performs passive cooling and emergency shutdown on overheat.
>>>> Thermal core will be able to react faster to temperature changes.
>>>>
>>>
>>> Why would this require a driver callback, and why can it not be handled
>>> in the hwmon core alone ? The hwmon core could register a set_trip function
>>> if the chip (driver) supports setting low and high limits, and it could
>>> call the appropriate driver functions when hwmon_thermal_set_trips()
>>> is called.
>>
>> I wasn't sure about what other hwmon drivers may need and want to do for
>> programming of the trips, so decided to start with this variant. I'll
>> prepare v2 since you're suggesting that the universal callback should
>> work okay for all drivers, thanks.
> 
> It will require some checks during probe to make sure that writeable limits
> exist, but that is still better than per-driver code. If for whatever
> reason some platform expects a different set of registers (say,
> critical limits instead of warning limits to attach to trip points),
> or if some platform expects that limits are _not_ used as trip points,
> that would not be driver but platform specific. You would not be able
> to address that on driver level with a single callback either (after all,
> lm90 compatible chips support up to three sets of limits).
> That means you already made an implementation specific choice with your
> code, by selecting one of those three sets of limits to act as trip
> points, and by making trip point support mandatory for all lm90 compatible
> chips. If we need to make that configurable, we'll need a better solution
> than a single driver callback, and that solution may as well be generic
> and driver independent.

Thank you for the clarification! If device makes a special use of lm90,
then very likely that it won't attach sensor to thermal zone. At least
all devices supported by mainline kernel should be okay here.

I think other sensors should be in a similar position. If a more complex
solution will be needed, then indeed hwmon API could be improved
further. The thermal device is created only for hwmon sensors that are
attached to thermal zone in a device-tree, so the scope of potentially
affected device should be small. Seems lm90 is actually the only hwmon
sensor that is used by thermal zones today.

AFAICS, all drivers return -EOPNOTSUPP if limits can't be changed, so we
could equal this error code to success in a case of set_trips(). The
set_trips() is very optional, if driver can't set limits, then the trips
won't trigger and thermal core will continue to work like set_trips()
wasn't hooked up. I'll implement this in v2.
