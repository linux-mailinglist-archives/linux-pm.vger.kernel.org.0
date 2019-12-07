Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19753115FC6
	for <lists+linux-pm@lfdr.de>; Sat,  7 Dec 2019 23:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfLGW4S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 7 Dec 2019 17:56:18 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36062 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfLGW4S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 7 Dec 2019 17:56:18 -0500
Received: by mail-lj1-f196.google.com with SMTP id r19so11527750ljg.3;
        Sat, 07 Dec 2019 14:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IsnSBoN+fwOzxmivDinxRwK3zClWTRv2W0eL1VAkO8E=;
        b=Tln8Umty/zgE4Rgx8ztur2ltZw5xsfva86tnrDpps5QQQLESxqv6/28VZRQGHzHbDp
         bsKpgpLbxgT22t1ra/Mm42ZunSpJKmdHPbQsRzmiky9fONgCohCtB7J4IIvwuTUWDpPu
         zPLw8SuVZ7u/X8ujMumkZixpqdUx8oRdvgO9CpVMW2s8xQJEJSKVgPt0AUyjofoolPXv
         UzyJq/gXg1ij00bo30XBVMIkOc+jLcoEG0QBeWUUoQY6gDrp0zTKUzDpDUVjbw28HpvJ
         8NYQC5LaJIZ+i/2zUBBDPfzoDFXuLw1ATAogAHnzf9MVfETVORcAVYUQDCY4F1cC64Ey
         Y2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IsnSBoN+fwOzxmivDinxRwK3zClWTRv2W0eL1VAkO8E=;
        b=M0/d5h+DmBS844W53hdJ/vDl3lfTxhnDVoPT3D3KnepSN+zpW64+1Ha4QHyrl3W7R9
         qJpsm1n9lbgwvz3wIYkpveRc2RPRSQZCSp738wX0LsYH96K3E2IjagQHZt6+ZZntShKx
         ZwzK8V40Ahqp7tHEPQCfEOesY10i3DQiHTNLLbShBaWfBQ+cJBfBfOf7IzPanuD737x/
         AlNfbgqWgfzsunyajoZPTwfpq4IG1kINLRiVUOaEOW/90enD2zEycK1m6iPcSGzkROww
         CMVRw6WpwrFtnL/KyHa2YLKFGjN6MKwrHFLMpncTuJJcx5kaFYX0NKLz+UYxWnqGAqmI
         NtTA==
X-Gm-Message-State: APjAAAWq4h9i1SBQEr+8b+l4Buhdsq9DvGOy2fEUAAnVS2mLrYbWV7WI
        53dJRBomCwpfik/oolp0jm2hIXBz
X-Google-Smtp-Source: APXvYqzmKKCtKd4Mdn7tovgKMDuVANKbiOT7PKAcz4fygzKh9FwMQN/eJXX+uOz01aPZceDmBUvw1w==
X-Received: by 2002:a2e:3609:: with SMTP id d9mr5794277lja.188.1575759375612;
        Sat, 07 Dec 2019 14:56:15 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id e14sm10014105ljj.36.2019.12.07.14.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2019 14:56:15 -0800 (PST)
Subject: Re: [PATCH v8 00/19] Consolidate and improve NVIDIA Tegra CPUIDLE
 driver(s)
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191203004116.11771-1-digetx@gmail.com>
 <20191207215216.GA9561@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0b3a861d-e5e8-ddca-ac60-0a3c61a9d9dc@gmail.com>
Date:   Sun, 8 Dec 2019 01:56:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191207215216.GA9561@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

08.12.2019 00:52, Michał Mirosław пишет:
> On Tue, Dec 03, 2019 at 03:40:57AM +0300, Dmitry Osipenko wrote:
>> Hello,
>>
>> This series does the following:
>>
>>   1. Unifies Tegra20/30/114 drivers into a single driver and moves it out
>>      into common drivers/cpuidle/ directory.
>>
>>   2. Enables CPU cluster power-down idling state on Tegra30.
>>
>> In the end there is a quite nice clean up of the Tegra CPUIDLE drivers
>> and of the Tegra's arch code in general. Please review, thanks!
> 
> I did a quick smoke test for this series on top of Linus' master:
>  - rebuilding with the patches applied, CONFIG_ARM_TEGRA_CPUIDLE=n - works
>  - building with CONFIG_ARM_TEGRA_CPUIDLE=y - doesn't boot
> 
> The hang is somewhere early in the boot process, before simplefb can
> take the console and show any logs. If I get BOOTFB to work again I might
> be able to get some more info.

Thank you very much for trying these patches!

Could you please try to make ARM_TEGRA_CPUIDLE "tristate" in the Kconfig
and compile it as a loadable module? That way you'll get framebuffer
shown before the hang happens.

Does LP2 suspend/resume work for you? There should be
"nvidia,suspend-mode = <2>" in the PMC's node of device-tree.
