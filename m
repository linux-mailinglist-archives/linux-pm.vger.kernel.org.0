Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2DBB397724
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 17:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbhFAPuP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Jun 2021 11:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbhFAPuN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Jun 2021 11:50:13 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09945C061574;
        Tue,  1 Jun 2021 08:48:31 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id v5so19872871ljg.12;
        Tue, 01 Jun 2021 08:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YUGtVN8Gnr12tiawIay9gy72JML+eakTViuP73Eai20=;
        b=OJHtzK/coti4vjRxZPZ/gnY6fyiDLjcVi5yyKAV5aAu49hIcJUlgBlzgOpxcV7ZW/Q
         VcwOW+Q3H8BWNtus7+7KcmdItodLuh6uiGe2EMpNMDTItylMvfnhILJyCTLDDRGW1lVl
         3hDqx/QjZ1gliKtam64xa0u0VUCGqx8V9eX3fOoJ2SSkfF8oh9S96iWNsLkoX0LdVsqQ
         oD3msqwPq2aN+J7XKeDJ8Lodcq7jxZuzYkMsiN3uDi3GeJE6ZnwUTBw3qwp1ZyPEznQg
         oPZD7I1TVPyO2CH8AbfyZNOYwtPoB5/MPjkKMZCEEz1XVjUjjczIBiwI05VokIAbAyWD
         ZayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YUGtVN8Gnr12tiawIay9gy72JML+eakTViuP73Eai20=;
        b=dCPgdDHXU3mrvMMgcPhkGzrOA0h32S5f2fNMyoOy8RiJ2Fd0LQpMLkW8f2j1Etesvg
         BnWcNYo3tNOT4eTAiQUIUakYHCIljZut9Hp7c21ureHpr81AcY9AOoD+w0nByJeNwkiH
         Jo7QAXJuQ7e+DlO0QpL8w6Ifif8wsR1baqILU6N78kT5iDmLiMy+oJkjJSz2/YVkOXhK
         V5Hrl1V0FqQEHiIG7OuymDQ3k8yaFVdFxjJgireLQAU4kghQ3S3uIZMMX8gZCNhAr7/Z
         EUk0OJdeg1sEnUegg95ninoKVSwu230y7UbEN/+H0Fn5TJGtYEjuAtwH8gyOXuB3dN2t
         NMqA==
X-Gm-Message-State: AOAM5337jeo6nfhlJbz5cP5vW63mqD/9wXtk8yje88MV21TB5UJP68iz
        ZdG47wndozRMy1ge/lygMpQq9MWZbFI=
X-Google-Smtp-Source: ABdhPJy9rttrLcHdkOGUm+CtfYDWnuKNVHXP04yxuBgVs4bozqSmAzJsjrF93eQcp/YPsbt4c4qcNQ==
X-Received: by 2002:a05:651c:550:: with SMTP id q16mr21146284ljp.433.1622562508733;
        Tue, 01 Jun 2021 08:48:28 -0700 (PDT)
Received: from [192.168.2.145] (79-139-170-222.dynamic.spd-mgts.ru. [79.139.170.222])
        by smtp.googlemail.com with ESMTPSA id b23sm334560ljk.18.2021.06.01.08.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 08:48:28 -0700 (PDT)
Subject: Re: [PATCH v2 13/14] soc/tegra: pmc: Add core power domain
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        =?UTF-8?Q?Nikola_Milosavljevi=c4=87?= <mnidza@outlook.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
References: <20210523231335.8238-1-digetx@gmail.com>
 <20210523231335.8238-14-digetx@gmail.com>
 <CAPDyKFrto2cosX3Ben_QWCYVqgeoF1Yv=8gEx4Y86WNyjeHvdg@mail.gmail.com>
 <f0b1bea7-0752-5584-8bcc-d8b602f22c13@gmail.com>
 <CAPDyKFq0EpVjUg9RV7qR3_qywUQHKqStPNSFY==6AFBNC6m3KQ@mail.gmail.com>
 <3d8d195f-d325-1b27-21f4-c1fb593678d1@gmail.com>
 <CAPDyKFqktwCWMBDcoa7HDg6aCayPSSYG5QkekaxPaiL6kgAZmQ@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6c1e69b3-5c13-5be6-5a8d-1eecaaa45aa7@gmail.com>
Date:   Tue, 1 Jun 2021 18:48:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqktwCWMBDcoa7HDg6aCayPSSYG5QkekaxPaiL6kgAZmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.06.2021 13:19, Ulf Hansson пишет:
...
>> This is not sufficient for Tegra because we have individual OPP tables for the root PLLs, system clocks and device clocks. The device clocks could be muxed to a different PLLs, depending on clk requirements of a particular board.
> 
> Are you saying that the clock providers for the "root PLLs" and
> "system clocks" have OPP tables themselves? If so, would you mind
> posting a patch for an updated DT binding for these changes, so it can
> be discussed separately?

I will post all those patches soon, thank you.

...
>> The device drivers don't manage the parent clocks directly and OPP core doesn't support this use-case where OPP needs to be applied to a generic/parent PLL clock. Moving the OPP management to the clk driver is the easy solution which works good in practice for Tegra, it also removes a need to switch each driver to dev_pm_opp_set_rate() usage.
> 
> I admit, if clock consumer drivers could avoid calling
> dev_pm_opp_set_rate|opp(), that would be nice. But, as I stated, it's
> a fragile path from locking point of view, to call
> dev_pm_opp_set_rate|opp() from a clock provider driver. Personally, I
> think it's better to avoid it.
> 
> More importantly, you also need to convince the clock subsystem
> maintainers, that setting an OPP internally from the clock provider
> driver is a good idea. As far as I can tell, they have said *no* to
> this, since the common clock framework was invented, I believe for
> good reasons.

Pushing the OPP into a CCF driver is indeed not ideal. I'm open to new
ideas. I will post those patches where we could discuss this in a more
details.

...
>> For example please see clock@60006000 and pmc@7000e400 nodes of [1].
>>
>> [1] https://github.com/grate-driver/linux/blob/master/arch/arm/boot/dts/tegra30.dtsi
> 
> Thanks, that certainly helped me understand better!
> 
> I see that you want to add OPP tables to clock provider nodes. As I
> said above, an updated DT binding is probably a good idea to discuss
> separately.
...
> 
> Okay, to not stall things from moving forward, may I suggest that you
> simply drop the call to lockdep_set_class() (and the corresponding
> comment) for now.
> 
> Then you can continue to post the next parts - and if it turns out
> that lockdep_set_class() becomes needed, you can always add it back
> then.

Thank you very much for helping with reviewing this all. I'll drop the
lockdep_set_class() and post the v7 shortly. Afterwards, I'll send the
rest of clk, device-tree and etc related patches targeting 5.15.
