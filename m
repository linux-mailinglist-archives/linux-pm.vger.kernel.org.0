Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2136C3AA443
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 21:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbhFPT1F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 15:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbhFPT1F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 15:27:05 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21DEC061574;
        Wed, 16 Jun 2021 12:24:58 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id r198so6061838lff.11;
        Wed, 16 Jun 2021 12:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pkR9B7CUCd/Xb9A+bBUd5E8+FpPhZajqebbesGuSC2Y=;
        b=j7NJJI9jFEtOhoJLOq8rDrszZ10Ds1kA+A7eHZOmBdI+o4SCdbkvFE7FPhtQyy7eiK
         fRhxkfYnhpcZSMH61apvhtJWlqL/tbwerMN1pnBUFCrNONvC9rlPIVl29DloqQvud9Ed
         GmskciZtdXm8gVW1eXDUV84RaGMePAatIC9BUXpvNYe9t/QFhYGgT1ZSnxJLhmj5sI1C
         nmJxkPWAdIiKHD6TJNEB7NiD4SBkzAB5gjpYydo58WVx6WqHHf0pS0ff6CTWtaIOHMuG
         HocyRKkVQcYCuP/FcU1aOMFCWhc7z29vO93y7QzoWrFFxl12o9skhBYn51HVpnc9zxzn
         xxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pkR9B7CUCd/Xb9A+bBUd5E8+FpPhZajqebbesGuSC2Y=;
        b=dZltFat2982S76osSYDw9M8Z64lJOWEWSHoZt8pJdUtGE1O/Ak8BfsweIy0uhIIyri
         Cv1ySdBMEkPQ0cKY0w7l5rL8+jQRLTZ4bvI2HhsRT+Y1sLOwptihHDunzFq8RNNJUwOL
         NWZOPQARceLcDP/7a6WVurf1h/Ej7SOwhe0H4UN7DsoJQFHZOK0KOa96/cHJ2frnN29K
         Y3ek96/xA2iIx+gXGaKspGTeTrQjTyrSc0x49wP5qya4lXOLEymUPP0poISCDgH8K83J
         Ou80MDlVvE4tqVrZadbuoJkyk+27Is7xZMsD3mhdTnEkovg3yenAwNDdKmRmS7R05lL/
         Nw7A==
X-Gm-Message-State: AOAM531HNtb72obkEzPrRQV4Xv75bNqxgFR9UsHln6ZEUxN9JtISXF3g
        t8RWdtTs59gxgOxZ4/3qTl9IMv3flfQ=
X-Google-Smtp-Source: ABdhPJx93evgZTTeUv9fEUWTxN1RvZw2O7Uqx5I4Kg8iFMf+VV3y4anAhhvpSubsdbyDqXGUGkq6eQ==
X-Received: by 2002:a05:6512:3f9b:: with SMTP id x27mr935329lfa.279.1623871496906;
        Wed, 16 Jun 2021 12:24:56 -0700 (PDT)
Received: from [192.168.2.145] (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.googlemail.com with ESMTPSA id q21sm366828lfp.260.2021.06.16.12.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 12:24:56 -0700 (PDT)
Subject: Re: [PATCH v1 5/5] cpuidle: tegra: Enable compile testing
To:     kernel test robot <lkp@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20210606222817.12388-6-digetx@gmail.com>
 <202106161518.TD3LfT4A-lkp@intel.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ced4dd2f-770e-95a1-f4ee-9d3f9d50087d@gmail.com>
Date:   Wed, 16 Jun 2021 22:24:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <202106161518.TD3LfT4A-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

16.06.2021 10:37, kernel test robot пишет:
> Hi Dmitry,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on tegra/for-next]
> [also build test ERROR on next-20210615]
> [cannot apply to pm/linux-next daniel.lezcano/clockevents/next v5.13-rc6]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Dmitry-Osipenko/Compile-test-NVIDIA-Tegra-CPUIDLE-driver/20210607-063217
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
> config: arm-randconfig-r005-20210616 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/53a9ab1dfd605ffae44d67f01a07a18b8ecbb1be
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Dmitry-Osipenko/Compile-test-NVIDIA-Tegra-CPUIDLE-driver/20210607-063217
>         git checkout 53a9ab1dfd605ffae44d67f01a07a18b8ecbb1be
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arm-linux-gnueabi-ld: arch/arm/kernel/sleep.o: in function `__cpu_suspend':
>>> (.text+0x68): undefined reference to `cpu_sa110_suspend_size'
>    arm-linux-gnueabi-ld: arch/arm/kernel/suspend.o: in function `__cpu_suspend_save':
>>> suspend.c:(.text+0x118): undefined reference to `cpu_sa110_do_suspend'
>>> arm-linux-gnueabi-ld: suspend.c:(.text+0x13c): undefined reference to `cpu_sa110_do_resume'

I can't find where cpu_sa110_do_resume is specified in kernel.

> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
>    Depends on ARCH_SUSPEND_POSSIBLE
>    Selected by
>    - ARM_TEGRA_CPUIDLE && CPU_IDLE && (ARM || ARM64) && (ARCH_TEGRA || COMPILE_TEST && !ARM64

There are other Kconfig.arm entries that are compile-tested and select
ARM_CPU_SUSPEND. Do they get the same warning? Should I do something
about it?
