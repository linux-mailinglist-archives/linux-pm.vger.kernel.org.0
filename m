Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D844734BC6
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 17:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfFDPPn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 11:15:43 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43166 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbfFDPPm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2019 11:15:42 -0400
Received: by mail-lf1-f68.google.com with SMTP id j29so2834560lfk.10;
        Tue, 04 Jun 2019 08:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dqsJKzxhe80xvf5e11Y99K/RlIOiTj57Fl1tDHoqcJY=;
        b=Z9EC/wHs4twCaHh7hj1ljtETiisVZ7buWrCY9QRqMW88GgnAa3wTunzZlleg7pNvsq
         DKwxcqr62xjN0sICdxWiwpTIrZMppBfgWYEhecXE8f/Oj7JWvZ06xTX6ncOI0vSr2yRX
         ydEx3617QoZpVPPrHuTZtBpb89HJMRoO1IadzjswrJu9HvpP/j6lw0izfsrfkyBjpltC
         mEU4DVLXMPhHeUtt4Ch3lOvz5z2uWz4OIeYJiC8WudrhkJUZ4ns8nwWhiUbpS/dTDD8m
         I65uOaiuqi/H+JcAnbkOaOyAxkHiZxhPBupvUPfHaNgZt8l54qNiuwKg3RDCG0oEOI8A
         En3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dqsJKzxhe80xvf5e11Y99K/RlIOiTj57Fl1tDHoqcJY=;
        b=WdAOIsCDAedXIoA9PjeoH8bxTXrQhBerWf+YIVa4fvbs17GM84+xSwLf6jXCqihkZj
         3mrtqLXdUYSjuSsQiiaEYKNDYYQbofUj2pjspQv/VLu4jQftnzpAg1zyulbDJDeoLkb6
         kUZO0sFhiE3+tn8lbMNRnANDnd62CrPw4oh5nYhcXCaGlSjc750guyPgyXSTv8RJbHMn
         hbYVTT/CFAa/bDdFcsmiMMj3NgzbD1H6QkHyIQNVEhGSTuI7cnQpaYFZ9AJ0FMmk9Lrw
         0EzvcEmuFhprH5Rxe50hOQcsrzYuFHktIb3hfNexWdyNqn8jwjtON6sO3BxCfjrgEs9H
         VZQg==
X-Gm-Message-State: APjAAAXtaQ1sRWC+0yDicnfOQrXaVGvFdXKjc1IDLGlKsF5fhWH3fjVG
        PmYLI05xgKUdjZfvAzR67IKj0iHi
X-Google-Smtp-Source: APXvYqy6EGXCoVgKm+GfOiye5cEkZPDhJ0doR7YOee1h8sHokhBSoV/SVCCtG9iawwWJNkOeQN0Dvg==
X-Received: by 2002:a19:5515:: with SMTP id n21mr10561863lfe.26.1559661339169;
        Tue, 04 Jun 2019 08:15:39 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.35.141])
        by smtp.googlemail.com with ESMTPSA id l15sm3833814lji.5.2019.06.04.08.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 08:15:37 -0700 (PDT)
Subject: Re: [PATCH v4 14/16] PM / devfreq: tegra: Enable COMPILE_TEST for the
 driver
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190501233815.32643-1-digetx@gmail.com>
 <20190501233815.32643-15-digetx@gmail.com> <20190604112026.GN16519@ulmo>
 <ed2c502f-8f49-d89b-32c6-4b5415e1fa47@gmail.com> <20190604141031.GB397@ulmo>
 <20190604141824.GC397@ulmo> <02a6651f-17f3-2e79-7780-57657596ba23@gmail.com>
 <20190604145004.GA3208@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <df040294-37d1-064c-009e-ba2fcac90364@gmail.com>
Date:   Tue, 4 Jun 2019 18:15:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190604145004.GA3208@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

04.06.2019 17:50, Thierry Reding пишет:
> On Tue, Jun 04, 2019 at 05:41:53PM +0300, Dmitry Osipenko wrote:
>> 04.06.2019 17:18, Thierry Reding пишет:
>>> On Tue, Jun 04, 2019 at 04:10:31PM +0200, Thierry Reding wrote:
>>>> On Tue, Jun 04, 2019 at 04:53:17PM +0300, Dmitry Osipenko wrote:
>>>>> 04.06.2019 14:20, Thierry Reding пишет:
>>>>>> On Thu, May 02, 2019 at 02:38:13AM +0300, Dmitry Osipenko wrote:
>>>>>>> The driver's compilation doesn't have any specific dependencies, hence
>>>>>>> the COMPILE_TEST option can be supported in Kconfig.
>>>>>>>
>>>>>>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>>> ---
>>>>>>>  drivers/devfreq/Kconfig | 2 +-
>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>>>>>>> index 56db9dc05edb..a6bba6e1e7d9 100644
>>>>>>> --- a/drivers/devfreq/Kconfig
>>>>>>> +++ b/drivers/devfreq/Kconfig
>>>>>>> @@ -93,7 +93,7 @@ config ARM_EXYNOS_BUS_DEVFREQ
>>>>>>>  
>>>>>>>  config ARM_TEGRA_DEVFREQ
>>>>>>>  	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
>>>>>>> -	depends on ARCH_TEGRA
>>>>>>> +	depends on ARCH_TEGRA || COMPILE_TEST
>>>>>>>  	select PM_OPP
>>>>>>>  	help
>>>>>>>  	  This adds the DEVFREQ driver for the Tegra family of SoCs.
>>>>>>
>>>>>> You need to be careful with these. You're using I/O register accessors,
>>>>>> which are not supported on the UM architecture, for example.
>>>>>>
>>>>>> This may end up getting flagged during build testing.
>>>>>
>>>>> We have similar cases in other drivers and it doesn't cause any known
>>>>> problems because (I think) build-bots are aware of this detail. Hence
>>>>
>>>> I don't understand how the build-bots would be aware of this detail.
>>>> Unless you explicitly state what the dependencies are, how would the
>>>> build-bots know? Perhaps there's some logic built-in somewhere that I
>>>> don't know about?
>>>
>>> So looks like COMPILE_TEST has a !UML dependency, so this might just
>>> work.
>>>
>>> Acked-by: Thierry Reding <treding@nvidia.com>
>>>
>>
>> Thank you very much for the clarification! Certainly that would caused
>> problems already since there are such cases all over the kernel,
>> including Tegra drivers.
> 
> In the cases that I'm aware of we used to explicitly list all the
> dependencies that would've otherwise been pulled in by the ARCH_TEGRA
> dependency to make sure there were no issues.
> 
> Now that we've been discussing this I vaguely recall a discussion about
> the only real issue nowadays being HAS_IOMEM and since that's only
> missing on UML, that may have been the reason for why the !UML
> dependency was added.
> 
> Yes, looks like that was it:
> 
> 	commit bc083a64b6c035135c0f80718f9e9192cc0867c6
> 	Author: Richard Weinberger <richard@nod.at>
> 	Date:   Tue Aug 2 14:03:27 2016 -0700
> 
> 	    init/Kconfig: make COMPILE_TEST depend on !UML
> 
> 	    UML is a bit special since it does not have iomem nor dma.  That means a
> 	    lot of drivers will not build if they miss a dependency on HAS_IOMEM.
> 	    s390 used to have the same issues but since it gained PCI support UML is
> 	    the only stranger.
> 
> 	    We are tired of patching dozens of new drivers after every merge window
> 	    just to un-break allmod/yesconfig UML builds.  One could argue that a
> 	    decent driver has to know on what it depends and therefore a missing
> 	    HAS_IOMEM dependency is a clear driver bug.  But the dependency not
> 	    obvious and not everyone does UML builds with COMPILE_TEST enabled when
> 	    developing a device driver.
> 
> 	    A possible solution to make these builds succeed on UML would be
> 	    providing stub functions for ioremap() and friends which fail upon
> 	    runtime.  Another one is simply disabling COMPILE_TEST for UML.  Since
> 	    it is the least hassle and does not force use to fake iomem support
> 	    let's do the latter.
> 
> 	    Link: http://lkml.kernel.org/r/1466152995-28367-1-git-send-email-richard@nod.at
> 	    Signed-off-by: Richard Weinberger <richard@nod.at>
> 	    Acked-by: Arnd Bergmann <arnd@arndb.de>
> 	    Cc: Al Viro <viro@zeniv.linux.org.uk>
> 	    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 	    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

That was a wise solution. Thank you very much again for the detailed
comment! Very appreciate that!

> Oh wow... almost three years now.

Please don't pay much attention to the time, it never stops. Live in the
moment :)
