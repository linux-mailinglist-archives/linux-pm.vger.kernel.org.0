Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD0E3AF502
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 20:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhFUS2E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 14:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhFUS2D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 14:28:03 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF406C061574;
        Mon, 21 Jun 2021 11:25:48 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id q23so16120697ljh.0;
        Mon, 21 Jun 2021 11:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UE39sQE7FWv732rmh+5q2NvzRlkG3ZqyU7Z5WAw6Ojg=;
        b=Zw3+aaGW0rFR5WROkwj0e14WhYewwdlrzW+PlBTaANvZiH5VCbrd+DEy/Q3A+f5qCv
         wj6JTx4G7J2SWcV54HiHOM2l3oV8zlC5J/dN4JakBYSpekrapPIZux8eZ1S2f+bwhsIP
         FRaqDJTZFXcib9ON82HTr7qAHVONdvk5ACDfYOa1pieHpBi0M8iFJzZi8QvwiQY8pROq
         4EI1qHVPVFTHI2QR4NPrBXQeItOloyvsOd/lWCHHNxcvXyxkMnnPrQfSL/+oApLbcVLf
         zzARW5bX3RrDwgswakgKetw1rEKYEqhVZGbMU4GcHe+Vu8s0lU3LY2JLSMXkTCYxLRpf
         k6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UE39sQE7FWv732rmh+5q2NvzRlkG3ZqyU7Z5WAw6Ojg=;
        b=XGl7IibhvcHcVTN1vEdRpg5s34MNZtz0xGzNSjsV+/tnIYeaU6SbBJKMvYIYtl595m
         KDNJFA1ZEbY7a0yrnZbaKWmIC12F6kqbWr0JwFIfbQglN35GAcTQcL7uxee3Yj9w/Jgi
         gdxCDUS5R0+c4W+Mfi1qAkcaReCesJP9QRfqANpuDGTwS9//k0adtUqd/EI3w3xGGqUZ
         HUvOdm6pI9uVQ9wWrhq/hgEm7p9hGjcRdPAYHdIfUoo0wo+XsgB44DtJ2u2V1OFYXPmu
         rn9XP0SdmJAV9OpZ5OaLH4ZIH7o2BNbw54Pe+lNyf1t9hZt1vrfnslRuJWFfktwY9AY2
         Sqew==
X-Gm-Message-State: AOAM533lA95xyOZNHitg7GnXvundkk2NRCfpC2DBdpde9xht8MQOn/dk
        b627UAiIZKIJWvnmTQe9X95vmX1ujeg=
X-Google-Smtp-Source: ABdhPJzguFz7FhLyzTq9Ad9RccZfyhT4R1mFoXnQ0l3mtdB5WVsN/17wL/ch/cVKeEI73i3E86ayng==
X-Received: by 2002:a2e:870d:: with SMTP id m13mr23249096lji.250.1624299947185;
        Mon, 21 Jun 2021 11:25:47 -0700 (PDT)
Received: from [192.168.2.145] (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.googlemail.com with ESMTPSA id b11sm1948098lfi.292.2021.06.21.11.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 11:25:46 -0700 (PDT)
Subject: Re: [PATCH v4 0/6] Add driver for NVIDIA Tegra30 SoC Thermal sensor
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Ihor Didenko <tailormoon@rambler.ru>,
        Ion Agorria <ion@agorria.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210616190417.32214-1-digetx@gmail.com>
 <e1e3816a-ddf4-be13-0410-0b929f3be60b@linaro.org>
 <cdc3d6fe-f2a8-d50c-af11-98ab4f72b713@gmail.com>
 <1f938d62-aeac-325f-4735-80cccfd529c2@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fd2191fb-e102-03ab-386b-da8189252c19@gmail.com>
Date:   Mon, 21 Jun 2021 21:25:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1f938d62-aeac-325f-4735-80cccfd529c2@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

21.06.2021 21:16, Daniel Lezcano пишет:
> On 21/06/2021 19:26, Dmitry Osipenko wrote:
>> 21.06.2021 20:13, Daniel Lezcano пишет:
>>>
>>> Hi Dmitry,
>>>
>>> I compiled the your series and got these unresolved.
>>>
>>> arm-linux-gnueabi-ld: drivers/thermal/tegra/soctherm-fuse.o: in function
>>> `tegra_calc_shared_calib':
>>> soctherm-fuse.c:(.text+0x60): undefined reference to `tegra_fuse_readl'
>>> arm-linux-gnueabi-ld: soctherm-fuse.c:(.text+0xf0): undefined reference
>>> to `tegra_fuse_readl'
>>> arm-linux-gnueabi-ld: drivers/thermal/tegra/soctherm-fuse.o: in function
>>> `tegra_calc_tsensor_calib':
>>> soctherm-fuse.c:(.text+0x144): undefined reference to `tegra_fuse_readl'
>>> arm-linux-gnueabi-ld: drivers/thermal/tegra/tegra30-tsensor.o: in
>>> function `tegra_tsensor_fuse_read_spare':
>>> tegra30-tsensor.c:(.text+0x364): undefined reference to `tegra_fuse_readl'
>>> arm-linux-gnueabi-ld: drivers/thermal/tegra/tegra30-tsensor.o: in
>>> function `tegra_tsensor_probe':
>>> tegra30-tsensor.c:(.text+0x874): undefined reference to `tegra_fuse_readl'
>>> arm-linux-gnueabi-ld:
>>> drivers/thermal/tegra/tegra30-tsensor.o:tegra30-tsensor.c:(.text+0x904):
>>> more undefined references to `tegra_fuse_readl' follow
>>> make[1]: *** [/home/dlezcano/Work/src/linux/Makefile:1196: vmlinux] Error 1
>>> make: *** [/home/dlezcano/Work/src/linux/Makefile:215: __sub-make] Error 2
>>
>> The missing stub was added by [1]. I guess you could take [2] for the
>> base since Thierry already sent out PR for 5.14, or we could defer the
>> "thermal/drivers/tegra: Correct compile-testing of drivers" patch till
>> the next kernel version. Please choose whatever is easier for you.
> 
> I would like to prevent to have more patches floating around. As we are
> close the to the merge window, I think we can live with the missing
> stubs ATM. But in the future, provide an immutable branch with the
> fixes, so we can share it and prevent these issues.

Thank you! There were multiple issues like this during this kernel
release. It's not easy to track all dependencies, I keep forgetting when
and which patches are already applied. Hopefully nobody bisects code
with COMPILE_TEST=y, so this should be a minor issue. Sorry for the
inconvenience.
