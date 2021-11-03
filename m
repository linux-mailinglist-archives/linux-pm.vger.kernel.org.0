Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6512244448A
	for <lists+linux-pm@lfdr.de>; Wed,  3 Nov 2021 16:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbhKCPWk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Nov 2021 11:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhKCPWk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Nov 2021 11:22:40 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B527C061714
        for <linux-pm@vger.kernel.org>; Wed,  3 Nov 2021 08:20:03 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u1so4077766wru.13
        for <linux-pm@vger.kernel.org>; Wed, 03 Nov 2021 08:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W1A7MT5G15UN43PmwCA+/v/rMYKRIQlPMS3qruXpK28=;
        b=XgejUpvqcZc72WidE/eUiGGVOpDy0lZMNKNmFEKfs637ySI3FaMOyWadTNo8UkCXDO
         Gng/JSPeraDJoq+4DMDajWpVCDJhp6D4v8M9vecLYLnn4hYwo+zZfkI9LKeXPdJ7aAku
         vUinTX6v8064wTIpHQNhxUr7ZTtrQprRD6Grv8VBR/DuMzryZam4gx5eIeRjKsV5aqIp
         1ZZymBzxJUF4jjzWQd8kpvhJAQHXIFDUCHDtlv7UYKeXKv4z+JT7sMCtY3lrNxQv5+Cd
         givgoTngKOodzd/ytudPAQjeMHXvrpTJIEvm1WkzQ14/RY46RKqAendQ7kgKs7YySXsq
         whLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W1A7MT5G15UN43PmwCA+/v/rMYKRIQlPMS3qruXpK28=;
        b=tdyVcyyQFTxuAgW5iV7EkKkMuFYK6tFul3iIv+jY8xHpmuFCaR0lnqM07/dv8ZKVSF
         7M6PoXD+hfKTpl5JZeryhHs6MRecA46JL2fjsQDnSi2qbwE7Fv0KP835N7HSCLXQ6LHy
         5zJTu17QxnXkg2DZ6h8xhSsOqFbHlGkbGArJzDxlM+fq65I2eaeJw8SqEZUECkTkBWkL
         bARXaMLeAZQmHwfANcBen8VFBLrP34QAFXwv6jr02G7sNmhj9v3mYIB34XDjCU+ji6V9
         KA1kteM705PFpLEtJ7ytJxTAghhfp/rjdgo9a3o/ndpddzqYTrBxS6lAdVCaRbx/X6ru
         xoyQ==
X-Gm-Message-State: AOAM531jKE0B8w1h/r4lE1x1dnZtiVKFACJGmT3jvTHzdYZggWIMfPkl
        zgjURkE9MhL9t/Aub6ojon6D5Q==
X-Google-Smtp-Source: ABdhPJx+GSa10mXbUP7WX6ifh8ehXT2M+Qv3DbjtWAJDIp/IJ7HmNasEjtVAGO3ZrDVnIKBDO/3yHg==
X-Received: by 2002:adf:ee04:: with SMTP id y4mr47249586wrn.0.1635952802040;
        Wed, 03 Nov 2021 08:20:02 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:aaa0:cb1f:c758:aafc? ([2a01:e34:ed2f:f020:aaa0:cb1f:c758:aafc])
        by smtp.googlemail.com with ESMTPSA id h18sm2405216wre.46.2021.11.03.08.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 08:20:01 -0700 (PDT)
Subject: Re: [GIT PULL] Thermal control updates for v5.16-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAJZ5v0hnj0zCXsZy0=Ukud3U_cn054GULmHmpz7Qrpg_TkLLqA@mail.gmail.com>
 <CAHk-=wijOKZNA0Ahd0fNDDa8pc6abv9wUHbxBf8giOeERHkW0g@mail.gmail.com>
 <60950c33-a5be-c465-cb5a-9e33b13a1ee4@linaro.org>
 <CAHk-=wjf_FrwxU0mAR_27cmmmr3n35fMyuJ2D+g2baeroTCFOQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <52e3ba9a-6324-5d62-8327-048dd03dfc5d@linaro.org>
Date:   Wed, 3 Nov 2021 16:20:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjf_FrwxU0mAR_27cmmmr3n35fMyuJ2D+g2baeroTCFOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03/11/2021 16:03, Linus Torvalds wrote:
> On Wed, Nov 3, 2021 at 12:53 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> Is the platform with 19 thermal zones and default thermal policy set to
>> userspace governor ?
> 
> I think it has 11 thermal zones judging by
> /sys/class/thermal/thermal_zone* going from 0 to 10.
> 
> And the kernel default seems to be
> 
>    CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
> 
> but presumably this is F34 then setting it to 'userspace' (the kernel
> config comes from the F34 one too, although it's been tweaked for the
> machine).
> 
> I suspect I could just turn off THERMAL_GOV_USER_SPACE and get rid of
> the message, that's not the issue.
> 
> The issue is "why is the kernel spewing pointlessly the same message
> over and over again?"

Yes, I agree and I will provide a patch to convert it to pr_warn_once
but having 19 messages sounds like the policy was set several times and
that is surprising.

This is why I asked about the configuration because the message should
appear when one thermal zone is changing the policy to 'user_space' and
that happens once per thermal zone, logically.

I'll send a fix for that and try to figure out what f34 is doing with
the thermal governors.

Thanks

  -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
