Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7EB3AA48A
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 21:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhFPTrv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 15:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbhFPTrv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 15:47:51 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7BDC061574;
        Wed, 16 Jun 2021 12:45:43 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id q20so6234255lfo.2;
        Wed, 16 Jun 2021 12:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5JtRZxTuUJ4EnVsYU6nZw97+hdKw7/ckY6wQRNL1dqM=;
        b=lYyZtxBPjHTAXY8nH4uV41RWMJugT2fTUXkWY/3d9KVyWmPprpXZMfztMo3mMb9uhy
         ITjUnabS+ruMNE3/tIwdLhMpVUtjBaTOfPfG1+v8ODoQl8iYqLc4F5vCFc6h/57duW1t
         DH4Jip2xsWDsMWHDSLVk1UOx85S9LK+iOzXLTiDSFlwMyiL//4GUPKpVCEQBLKRZYHen
         +CGqmWDZ0yQ8s6H1R1Xif4N73UglESKnZda1e3W4R5p+u23C+iI1wmjvzSxHew5LTWx1
         Ofbwddd+uAORLB62AbqrJG4wjooNRcm4vMCIVvUibQDZYA0oxbCOjmA0ukGnFdGIUBo1
         Aplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5JtRZxTuUJ4EnVsYU6nZw97+hdKw7/ckY6wQRNL1dqM=;
        b=r0687QgbcHajFj37wW/hhS3Vzq0pyHtHlt+OeKhIh1eCPDfkbPZ/OqKx0IDpfinb80
         xHeHOwWzqL7uaN6WzSjvxY7e6sPqlilhO2KjYN2Eu9qb7XQkuJlKcXfpqJyT/6UJ4I+y
         vwrofvrznjhngJA5hYLu9k4YB2Ogx/BbjNZs+LBAq2rI9MpfVnbugtRy5/7072haaqlH
         6K+iZP8cG30zk5PJkr4BqBSFQvWNO+goTL0assFsSRZ7bQsay5apl+NC4swqgrvt4lud
         /CiJi3g0TIAOog75KBFXVANNHDICGSV2ynBUTJT9pZREO8b23w46GraMuX3aozEQtGIr
         YZuw==
X-Gm-Message-State: AOAM532MZV++Yps6eXH1/9Xqq4m5zZwfmAVtG02tzHy1h3EoJGcrR+dP
        znexH96qXHAnndMry7+WptJf2aQzdoY=
X-Google-Smtp-Source: ABdhPJwqAL/aUrcmRUNgAGdHK3CONaBgSkBaP+uVinCxAUbBY2/XwgMRU1TiQuW76Atr597eFvb5Vw==
X-Received: by 2002:ac2:51b3:: with SMTP id f19mr1054692lfk.218.1623872741895;
        Wed, 16 Jun 2021 12:45:41 -0700 (PDT)
Received: from [192.168.2.145] (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.googlemail.com with ESMTPSA id h22sm416352ljl.126.2021.06.16.12.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 12:45:41 -0700 (PDT)
Subject: Re: [PATCH v1 5/5] cpuidle: tegra: Enable compile testing
From:   Dmitry Osipenko <digetx@gmail.com>
To:     kernel test robot <lkp@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20210606222817.12388-6-digetx@gmail.com>
 <202106161518.TD3LfT4A-lkp@intel.com>
 <ced4dd2f-770e-95a1-f4ee-9d3f9d50087d@gmail.com>
Message-ID: <4de3f38b-72be-b7d7-a291-0da75dc8455d@gmail.com>
Date:   Wed, 16 Jun 2021 22:45:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <ced4dd2f-770e-95a1-f4ee-9d3f9d50087d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

16.06.2021 22:24, Dmitry Osipenko пишет:
> 16.06.2021 10:37, kernel test robot пишет:
>> Hi Dmitry,
>>
>> I love your patch! Yet something to improve:
>>
>> [auto build test ERROR on tegra/for-next]
>> [also build test ERROR on next-20210615]
>> [cannot apply to pm/linux-next daniel.lezcano/clockevents/next v5.13-rc6]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/0day-ci/linux/commits/Dmitry-Osipenko/Compile-test-NVIDIA-Tegra-CPUIDLE-driver/20210607-063217
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
>> config: arm-randconfig-r005-20210616 (attached as .config)
>> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # https://github.com/0day-ci/linux/commit/53a9ab1dfd605ffae44d67f01a07a18b8ecbb1be
>>         git remote add linux-review https://github.com/0day-ci/linux
>>         git fetch --no-tags linux-review Dmitry-Osipenko/Compile-test-NVIDIA-Tegra-CPUIDLE-driver/20210607-063217
>>         git checkout 53a9ab1dfd605ffae44d67f01a07a18b8ecbb1be
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm 
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>    arm-linux-gnueabi-ld: arch/arm/kernel/sleep.o: in function `__cpu_suspend':
>>>> (.text+0x68): undefined reference to `cpu_sa110_suspend_size'
>>    arm-linux-gnueabi-ld: arch/arm/kernel/suspend.o: in function `__cpu_suspend_save':
>>>> suspend.c:(.text+0x118): undefined reference to `cpu_sa110_do_suspend'
>>>> arm-linux-gnueabi-ld: suspend.c:(.text+0x13c): undefined reference to `cpu_sa110_do_resume'
> 
> I can't find where cpu_sa110_do_resume is specified in kernel.
> 
>> Kconfig warnings: (for reference only)
>>    WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
>>    Depends on ARCH_SUSPEND_POSSIBLE
>>    Selected by
>>    - ARM_TEGRA_CPUIDLE && CPU_IDLE && (ARM || ARM64) && (ARCH_TEGRA || COMPILE_TEST && !ARM64
> 
> There are other Kconfig.arm entries that are compile-tested and select
> ARM_CPU_SUSPEND. Do they get the same warning? Should I do something
> about it?

Although, I see now that the other entries have dependencies which
should protect them indirectly from this warning. Perhaps adding
dependency on MMU, like QCOM driver does it, should help. I'll fix it in
the next version.
