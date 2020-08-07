Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F019A23EA96
	for <lists+linux-pm@lfdr.de>; Fri,  7 Aug 2020 11:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgHGJkI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Aug 2020 05:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgHGJkG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Aug 2020 05:40:06 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F33C061574
        for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2020 02:40:06 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x5so1163278wmi.2
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2020 02:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2ygenASuFAVHeSxyfRvlwBCfbX67rwOVVS8/a2O5+lk=;
        b=vCUz+KQVy1TVKykoi2FIr81nxc/Dlf66XKmkkyc6xVTHk6IfWWXk8aLggri1BoX4H4
         sd7UJ6SnzD3ZBnabDJrahu1OR8ZiELVkKEruE9wzBCo49m6qx+FmF6bBcoSBGUFMB00H
         ewDq5c8XABr7mfCaZs0P1qvsYSwa405Uz9XwsefdjgcGd1udB3OPZSKOY+4eLYUtFX68
         DNPTHTwYSkcuLiQBDBZKukk/kijCebWpgd3EYFC/b37S9S6QEYFlwUP1voaQvpuX6AbT
         YhwKAZVGHquNbMMhmdZu8YrzITupoPwk6x7lTE7yu1s302i33Rhvoyp3lM7Xk1yAiD7V
         PbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2ygenASuFAVHeSxyfRvlwBCfbX67rwOVVS8/a2O5+lk=;
        b=pGodLcNuN4aHrBR2M8/aUalFs3og7v73cn6nMM9OnAzpJzPa0nkQ2OquGNpCpJeRyh
         KEYeUtmCu8rENRkALFlzizz1q8sP2K+Xdmh9SGFGfqqF4bqyagQcV9e8+qCctl+Zr5um
         0RklZ43GdhSZP7KmKP6ouXaYRsMsnmfxbOmu6bcaZfX+HXLjxFCdm7MlqNg02QdRDaDS
         H5ppYVDt7r77JMhzSG8PVFS6P7w8qqXb9HDM3hIF0hHM3A7beVCIf+yIRlGCve2F3vaT
         Ctm79os6+tmX0jaCUq1ipCmIsugv5skeIuWcBYynMhKF4j6OsxFUOQ6j6tWfSEGXGi2j
         g8FQ==
X-Gm-Message-State: AOAM533UeMwJtAPU7ym5WNFnqSjjW54nsPQLECQ6H/XL4H3FTGFRVhhi
        JwN3ZKdMTqNQtBjIu4kAg9vwtw==
X-Google-Smtp-Source: ABdhPJwuqQGf4ihtasBI+Gyuf4ZsDRFnz4dqvO8MH6E2ks+1/REokqPvz45ZuYKgSxuFeG9iFggAhA==
X-Received: by 2002:a1c:7d55:: with SMTP id y82mr11787250wmc.186.1596793204726;
        Fri, 07 Aug 2020 02:40:04 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:f457:5fc1:5262:84c? ([2a01:e34:ed2f:f020:f457:5fc1:5262:84c])
        by smtp.googlemail.com with ESMTPSA id o10sm9397248wrw.79.2020.08.07.02.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 02:40:04 -0700 (PDT)
Subject: Re: [GIT PULL] RESEND: thermal for v5.9-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Colin King <colin.king@canonical.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Lukasz Luba <Lukasz.Luba@arm.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Henry Yen <henry.yen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Marian-Cristian Rotariu 
        <marian-cristian.rotariu.rb@bp.renesas.com>
References: <db1dc155-0c7c-f4eb-7fa6-047a78829a82@linaro.org>
 <CAHk-=wgLt61owJ_eKwy43bBujxy3-s=xQXwsSi6VHME7SiAgiA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b903cdd8-cbb5-1a6a-3943-9bb019f1eed7@linaro.org>
Date:   Fri, 7 Aug 2020 11:40:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgLt61owJ_eKwy43bBujxy3-s=xQXwsSi6VHME7SiAgiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Linus,


On 07/08/2020 04:43, Linus Torvalds wrote:
> On Thu, Aug 6, 2020 at 1:19 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>>
>> - Add generic netlink support for userspace notifications: events,
>> temperature
>>   and discovery commands (Daniel Lezcano)
> 
> This is "default y".
> 
> Why?
> 
> The help text doesn't explain either.
> 
> Please explain, or remove the default y. We don't add new features and
> then try to force people to use them by enabling them by default.
> 
> "default y" is mainly for when something unconditional gets split up
> and becomes conditional (so now "default y" means that you don't break
> peoples setups when they don't even know what it is).
> 
> Alternatively, "default y" is for things that are make peoples lives
> immeasurably better somehow, and it would be a crime to not enable it
> because it's _so_ wonderful.

Well, I won't argue the netlink notification is so that fantastic but it
is a feature that was needed since a long time. A previous partial
implementation was directly compiled-in and then removed [1] because
there were no user as it is and we wanted to introduce a clean new
notification framework based in our previous discussion at Linux
Plumbers Conference [2] but that needed some cleanups of the thermal
core code before.

This netlink framework fulfills the needs of the thermal daemons for
Intel, Android HAL and SoC vendors which are hacking the thermal
framework or constantly polling the temperature.

Because the compilation failed if CONFIG_NET=n, the Kconfig option was
introduced afterwards [3]. It could have been directly handled in the
code with a 'ifdef' directive without option but it sounded more
convenient to at least give the opportunity to opt-out the notification.

It defaults to 'y' because the previous (but unused) implementation was
unconditionally compiled-in and because of the thermal users needs.

Is default=y wrong given this history?

 -- Daniel


[1] https://patchwork.kernel.org/patch/11202093/
[2]
https://www.linuxplumbersconf.org/event/2/contributions/185/attachments/39/46/LPC_2018_Thermal-Srinivas-Rui.pdf
[3]
https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/commit/?h=thermal/next&id=5b8583d3bd7fc10cea07e4a5bfa59465758a39dc


> So far, I'm not convinced we've ever hit that second case.
> 
> Convince me that the thermal layer is so magical that it really
> warrants it. Tell me why and how my life is improved by enabling it.
> 
>              Linus
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
