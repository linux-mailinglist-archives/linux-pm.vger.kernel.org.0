Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C04471A1F36
	for <lists+linux-pm@lfdr.de>; Wed,  8 Apr 2020 12:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgDHKxI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Apr 2020 06:53:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55042 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgDHKxI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Apr 2020 06:53:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id h2so4666980wmb.4
        for <linux-pm@vger.kernel.org>; Wed, 08 Apr 2020 03:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=urGUcaHoOYUM5FPu/2/95ZPBaR2VlGmS9zoEil6aMBw=;
        b=rqva7QFyqWsxRa6X4mRYKo2igMyBc+MB0DFnNMcR20yq3mSPg13PXdmrOZRhubThk/
         jBgkY6a6YVdkabnRSIACYqsx7J9Re0A9Uk3SDHv7ccbgEUfKcUMFccnEb4UGw2CJZq/x
         hVm4E/4wuwBKNPddhYegDog0ueMtf87l1G8XUK5ukw5RPbCuCBsRP7depzKp4psAeu+H
         PuPBgc9TFklszqdRC8LD3AfjqsjNTMD8Ts/1uH8bLvLIT9AyJRkAYGdCb7gmcMK2AexM
         5zwaz8hcksnyXrIJcfoWlNiOFdFp8wiNs7PG7ekX0GwrUg72+SXC/JZlegKWCOSDlR8E
         PtoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=urGUcaHoOYUM5FPu/2/95ZPBaR2VlGmS9zoEil6aMBw=;
        b=Wol2VW4W6xnxI+D7Ox1Bg3t6L71cMW5f7tD8JStrjr9FICnH5KgaxHdmHwCdBeUZIU
         qUKHDKDsUjj1OA+y+0csxYTU8GQo7q6WNpSkWUTYzhhnKNqAYpKDzQyx6q1LxnbaW6Fx
         TNwqBJupyyV1F/5SxESJMG0eVaPbGvbgvH9/ClsO97M8eK49oB+cKDu5x4Y29F+E4X5b
         LOFHypqISNMGKOMc4Xwtp735tplwyQogFy+upv7R2869BItMIII7wCc8XdehrgfG0fYb
         e8YQ84rMrQT9fIpmYpqQ/a0H1CbnGRo3rofYb/iD77HQZK4UpNQowNvNl5BD2BQ7r+K2
         EZBw==
X-Gm-Message-State: AGi0PuaoCRJcg66DXuGBoYApIQOMlBwXKZPYuoIC2Gz94PvafLcLnJwE
        /J43XM4+Uhs/1MkR0EcbMSfMaA==
X-Google-Smtp-Source: APiQypJicFap+MLD9pPPPE/yE7cIO221IUi0LQ7UTChFWe3p8XtSrHleUHxGe+8OH3U3ZGZS7L7j5A==
X-Received: by 2002:a7b:c118:: with SMTP id w24mr3912929wmi.173.1586343187010;
        Wed, 08 Apr 2020 03:53:07 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5d56:fae1:b92:8fa0? ([2a01:e34:ed2f:f020:5d56:fae1:b92:8fa0])
        by smtp.googlemail.com with ESMTPSA id y189sm6668969wmb.26.2020.04.08.03.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:53:06 -0700 (PDT)
Subject: Re: [GIT PULL] thermal for v5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Willy Wolff <willy.mh.wolff.ml@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
References: <49c5b834-362d-0569-32c5-76d366cb0a44@linaro.org>
 <CAHk-=wjkEYLViZ6zBLaWaiTXZ4RqcR4DHkkY_PKJZ2-0HAX_Pw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2422ce89-5b76-f56e-2b62-c120062ce642@linaro.org>
Date:   Wed, 8 Apr 2020 12:53:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjkEYLViZ6zBLaWaiTXZ4RqcR4DHkkY_PKJZ2-0HAX_Pw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Linus,

On 08/04/2020 05:14, Linus Torvalds wrote:
> On Tue, Apr 7, 2020 at 4:26 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
>> tags/thermal-v5.7-rc1
> 
> Ho humm.
> 
> This caused a conflict between commit
> 
>   f12e4f66ab6a ("thermal/cpu-cooling: Update thermal pressure in case
> of a maximum frequency capping")
> 
> that came in through the scheduler updates from Ingo Molnar, and commit
> 
>   ff44f672d741 ("thermal/drivers/cpufreq_cooling: Fix return of
> cpufreq_set_cur_state")
> 
> from the thermal tree.
> 
> The conflict wasn't complicated, but the reason I mention it is that I
> resolved it in a way that neither of those commits had done.
> 
> In particular, the thermal tree did
> 
>   ret = freq_qos_update_request(..)
>   return ret < 0 ? ret : 0;
> 
> where that whole "return negative or zero" logic is new (it used to
> return positive values, the fix was to return zero instead).
> 
> The scheduler tree did
> 
>   ret = freq_qos_update_request(..)
>   if (ret > 0) {.. do thermal pressure thing ..}
>   return ret;
> 
> which obviously still returns that positive value.
> 
> My resolution to the conflict was to not take that return with a
> conditional operation, but instead just add a
> 
>   ret = 0;
> 
> to inside that thermal pressure if-statement, and avoid returning a
> non-zero positive value that way.
> 
> I just wanted both sides to be aware of my non-traditional merge
> resolution, and take a look.

The resolution looks correct to me.

Thanks

  -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
