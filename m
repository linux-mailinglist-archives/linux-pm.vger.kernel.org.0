Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A52223F274
	for <lists+linux-pm@lfdr.de>; Fri,  7 Aug 2020 20:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgHGSGy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Aug 2020 14:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgHGSGx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Aug 2020 14:06:53 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744B6C061757
        for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2020 11:06:53 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 184so2683951wmb.0
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2020 11:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tpabc+dhQPZMaSfy3eZRqVNk+pKX/o3PXA4QYyMUyT8=;
        b=X1fHuPdee3miTqzeiRI6HPkJli5bqvS3wz2BzKtIXDUu9z/BCm42GjemMhNoetbUSP
         +drUx71hZXHDWIRyY6xM/zIqF4Z3/NNNDy552yHGJvsl+5+t9NyoN6M03a9OVJZgm4TR
         n+XQIFVhXqLy+pTCNoCQwZTzh4yjx5HshUyQaJYRln6uHVvej7M2GL9kYnQWNRzVnQj1
         +Fm79NqHDx3WOT2LT9J4JUG8kuMLlSqrcyEsyqUirNhCWS5+ksNSu7+5OXSrZT6PeQjx
         Mky59QXOyulr3WPh2QIQOGCLe3Ojuz06TGxF2wu+8pCnblEVM9lz5Y/pmYRuuqEmtlIy
         xG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tpabc+dhQPZMaSfy3eZRqVNk+pKX/o3PXA4QYyMUyT8=;
        b=BzY8szhJAFKFYxje5mE+JZmiC6SwaJwGOVBKa7b/w8wLO56/d+kz9Ax89BHXnrz3GE
         HTMlwI+4O+q9aLobNJacTaIv9HHMdML10f/EoZbm7iIkLiT1XAOAI+TAxZdsEFEITNL4
         Q1WApzaxHyQ+tw6L2SiVKMxcdEDdGrhUMo1Ng2WUyFKhuECq/hKfD5hm8zonN5dOr4DC
         2oPs92CIFz2uz/8aDhcbGDBdZZC75Osd8ijMK+S7Zw2ObbcW3klctpAKeWQ0lT1N6FiL
         2yd1Zmh9e+jEVojfUd6lUA26UcdJSqoYZH6VcFVmn1UZ0mHvHPBNpGyFlbzML72EVYDX
         cw1g==
X-Gm-Message-State: AOAM533o9qAtmaNzNW4JL7TgMQ0wBM5YPQZiprgNZvmmMNsFX05WJkBh
        glXeyW3wYWHXGi4y7Nd9h0LnUQ==
X-Google-Smtp-Source: ABdhPJy8cM5YxawMXXvMgK4ekM6+8WQD6gYzzmGT9vpjcS+Zwld44Q9XWWhM4WjSV3BnyG0ieow2kw==
X-Received: by 2002:a1c:1d91:: with SMTP id d139mr14374581wmd.144.1596823611492;
        Fri, 07 Aug 2020 11:06:51 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a9ac:cbdb:2935:5df0? ([2a01:e34:ed2f:f020:a9ac:cbdb:2935:5df0])
        by smtp.googlemail.com with ESMTPSA id t13sm10898775wru.65.2020.08.07.11.06.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 11:06:50 -0700 (PDT)
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
 <b903cdd8-cbb5-1a6a-3943-9bb019f1eed7@linaro.org>
 <CAHk-=wgSJwbghhQYCoAVq6ewGKZ+rZvxeKvxb-o_gMt7d7-Nbw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <88678a80-4ca2-5cb0-d9c5-3e64b7f113f5@linaro.org>
Date:   Fri, 7 Aug 2020 20:06:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgSJwbghhQYCoAVq6ewGKZ+rZvxeKvxb-o_gMt7d7-Nbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/08/2020 17:54, Linus Torvalds wrote:
> On Fri, Aug 7, 2020 at 2:40 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> It defaults to 'y' because the previous (but unused) implementation was
>> unconditionally compiled-in and because of the thermal users needs.
>>
>> Is default=y wrong given this history?
> 
> One million percent wrong.
> 
> The fact that the old implementation was never used just shows that
> it's not so important, and it shouldn't be default 'y'. Not having it
> doesn't break anything.
> 
> And the new implementation presumably isn't even compatible with the
> old format also means that it shouldn't be default 'y'. Building it in
> wouldn't help anyway.
> 
> And the fact that _some_ users might want it does not mean that it
> should be default 'y', because those users presumably _know_ they want
> it.
> 
> IOW, defaulting to 'y' is just wrong in every possible way. This is
> not some kind of "to maintain compatibility and not break existing
> users we should enable this" kind of thing.
> 
> And it's not some kind of "everybody should have it" thing either,
> since presumably nobody has the user-space support for it anyway.
> 
> It's something that a new distro would enable _if_ they actually end
> up supporting the user space. Not something the kernel should enable
> "just because".
> 
> Really: "default y" is _wrong_. Every developer thinks that _their_
> code is so magical and special that everybody should run it.
> 
> And every developer is almost always wrong. Unless you have a "not
> having this will break existing users", you don't do it.

Ok, I will send a fix.

Thanks for taking the time to clarify that.

  -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
