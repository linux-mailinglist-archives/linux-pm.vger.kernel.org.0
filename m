Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420B4364141
	for <lists+linux-pm@lfdr.de>; Mon, 19 Apr 2021 14:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239027AbhDSMI5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Apr 2021 08:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239028AbhDSMIx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Apr 2021 08:08:53 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00491C06174A
        for <linux-pm@vger.kernel.org>; Mon, 19 Apr 2021 05:08:22 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id o5so5976909ljc.1
        for <linux-pm@vger.kernel.org>; Mon, 19 Apr 2021 05:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VSjvKiMi1irhY6O/Y+tKt8XEB0nyJMwoKJqR1icsgsc=;
        b=byhBv9E85/dEVMPgEEJYH+TxNAkSn9tds7mLrkNZFc7J7l1k8JjVnZuvdCleT/glaJ
         hhDXxNkV+A3rCei4VXjintWFyOUp1grHUKm7JvgZKoPsIy+Cr/bPDRIUSxhdc1A+N0+n
         2v4mBuYyUXEnKHzv2kH9rSFmyaEL7F/ZBesU1ru6MmyHPwrX7jLM/QoKII55h9+6HyCV
         ui6vslmCR8+REPA548G7O/uq9GkoFhE2Rf7LpubH11rVN+JnAi4EqEhPPR1ATGnVY6uw
         XOydT/Bau8WAavM6MTLyeyL6ap4iLPK4lEbnXCVJpjpQILMX2sbRmo2MA697eM+UKCma
         M7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VSjvKiMi1irhY6O/Y+tKt8XEB0nyJMwoKJqR1icsgsc=;
        b=mvetgITDYjhNfsRc3SzVKzxt6RgamzNrKkNNkgFVW9lYBcM8T9wGoN6Q3MA8KVH4Xf
         Ia24djHB5Thq4O+kLT6nSA7xS3bVdvv0eXYe/6KfnxMcTryTmXLmE7jSWlMy5LkGaoPB
         lf6n6eIzu355Ds1cUOZCnclGR/CtusSIWS+IhAkVyTBj6PLpa4i3yOAkE5VZIw6x8xPH
         4Cr/DrsyDpFJvKU+YVXyQUCDeuGQaXX0I4YB7CJ8tlj9vpi0cOXW1k59dNJkVMscxS5G
         y+0MWakwUeDBQ7eEQn895rOrdG212gHE7eYS7ypzxMymfPSSD+8cwtstCOZWT+9mozDW
         uEEA==
X-Gm-Message-State: AOAM533s8bvlPl69CGIMsfRhfUJYtpznIN2KynPhO7eGhHQQxvBkAMEd
        Rvy423yRCqzwtghq+AfA/3Y0vKQeCM+LuE3vOt0=
X-Google-Smtp-Source: ABdhPJxcZqdOsw7O7a29AYd+eShHhJ9+6r2HzxhLNT9gZWH3mJtUdnCG7GzIt+XgkvOtbl5ZIea9LBbB56dcP1VwnSs=
X-Received: by 2002:a2e:6f10:: with SMTP id k16mr9456112ljc.26.1618834101310;
 Mon, 19 Apr 2021 05:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <161848823868.29796.2378720492280917598.tip-bot2@tip-bot2>
 <202104160110.kPF71m4S-lkp@intel.com> <CA+_ehUzAhPhqn62ivcxF+giMUy430eija7_sOSoNmC=291wq-g@mail.gmail.com>
 <4187051b-4dcf-88e0-ac3d-fb47ff42e3ef@linaro.org>
In-Reply-To: <4187051b-4dcf-88e0-ac3d-fb47ff42e3ef@linaro.org>
From:   Ansuel Smith <ansuelsmth@gmail.com>
Date:   Mon, 19 Apr 2021 14:08:10 +0200
Message-ID: <CA+_ehUziRf7Ls8PByz-9_L8SKB26+yRY-MrZK_26GqdycCkNhg@mail.gmail.com>
Subject: Re: [thermal: thermal/next] thermal/drivers/tsens: Convert msm8960 to reg_field
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     kernel test robot <lkp@intel.com>,
        thermal-bot for Ansuel Smith <tip-bot2@linutronix.de>,
        "open list:QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096" 
        <linux-pm@vger.kernel.org>, kbuild-all@lists.01.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

>
> On 15/04/2021 20:52, Ansuel Smith wrote:
> >>
> >> Hi thermal-bot,
> >>
> >> Thank you for the patch! Yet something to improve:
> >>
> >> [auto build test ERROR on linus/master]
> >> [also build test ERROR on v5.12-rc7]
> >> [cannot apply to thermal/next next-20210415]
> >> [If your patch is applied to the wrong git tree, kindly drop us a note=
.
> >> And when submitting patch, we suggest to use '--base' as documented in
> >> https://git-scm.com/docs/git-format-patch]
> >>
> >> url:    https://github.com/0day-ci/linux/commits/thermal-bot-for-Ansue=
l-Smith/thermal-drivers-tsens-Convert-msm8960-to-reg_field/20210415-200542
> >> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux=
.git 7f75285ca572eaabc028cf78c6ab5473d0d160be
> >> config: arm-randconfig-r015-20210415 (attached as .config)
> >> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> >> reproduce (this is a W=3D1 build):
> >>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/=
sbin/make.cross -O ~/bin/make.cross
> >>         chmod +x ~/bin/make.cross
> >>         # https://github.com/0day-ci/linux/commit/efea0f0570b6b581bdb2=
fad978a35fd1a521385b
> >>         git remote add linux-review https://github.com/0day-ci/linux
> >>         git fetch --no-tags linux-review thermal-bot-for-Ansuel-Smith/=
thermal-drivers-tsens-Convert-msm8960-to-reg_field/20210415-200542
> >>         git checkout efea0f0570b6b581bdb2fad978a35fd1a521385b
> >>         # save the attached .config to linux build tree
> >>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-9.3.0 make.c=
ross W=3D1 ARCH=3Darm
> >>
> >> If you fix the issue, kindly add following tag as appropriate
> >> Reported-by: kernel test robot <lkp@intel.com>
> >>
> >> All errors (new ones prefixed by >>):
> >>
> >>    drivers/thermal/qcom/tsens-8960.c: In function 'init_8960':
> >>>> drivers/thermal/qcom/tsens-8960.c:193:29: error: 'S0_STATUS_ADDR' un=
declared (first use in this function); did you mean 'INT_STATUS_ADDR'?
> >>      193 |    priv->sensor[i].status =3D S0_STATUS_ADDR + 40;
> >>          |                             ^~~~~~~~~~~~~~
> >>          |                             INT_STATUS_ADDR
> >>    drivers/thermal/qcom/tsens-8960.c:193:29: note: each undeclared ide=
ntifier is reported only once for each function it appears in
> >>    drivers/thermal/qcom/tsens-8960.c: At top level:
> >>>> drivers/thermal/qcom/tsens-8960.c:284:15: error: 'VER_0' undeclared =
here (not in a function); did you mean 'VER_0_1'?
> >>      284 |  .ver_major =3D VER_0,
> >>          |               ^~~~~
> >>          |               VER_0_1
> >>
> >>
> >> vim +193 drivers/thermal/qcom/tsens-8960.c
>
> [ ... ]
>
> > What happened here? This doesn't seem right.
>
> Yes, it is. It means the series is not git bisect safe.
>
> Please fix it.
>
>

I'm a bit confused. Should I send just a patch to fix this or I
need to send the series again rebased with the new changes?

>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
