Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62032365717
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 13:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhDTLFr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 07:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbhDTLFo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Apr 2021 07:05:44 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A16EC06174A
        for <linux-pm@vger.kernel.org>; Tue, 20 Apr 2021 04:05:12 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j18so60880110lfg.5
        for <linux-pm@vger.kernel.org>; Tue, 20 Apr 2021 04:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yby1MZHetzrLpDlh9hqU2iGcc7v/3UbC/Dq+9NtR4Rg=;
        b=lw7XAJaEyaH4jemk1VW6LGOMcg3LiIeJpftjAJjYQI4aOIDOt1QagIudvuM978plac
         3zZpLJ/DIK2L92z8c11sskW7WyaMLwI4Ko5Gl/jhEhss76piilPBpHubiw52+OFTrfw9
         6nCTLQXvsGra4AMmaMRyr7wuHF3WW/Aan+/RQo5L0SRsIhaGfFvW4BNKeWY3e9tqVA0m
         mNSYMH+66J8pTfH6+AV+v7DlfxWUSv4zuYU6PPP2lp0znrh/PAAgAU7iV4hNO45FQi8D
         PHIwvhLrhNJejGa40kmA2ueda5zXqakT8ig8x2lbv0SYNb7HltBfUaGIbfovl29zgeA4
         2x/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yby1MZHetzrLpDlh9hqU2iGcc7v/3UbC/Dq+9NtR4Rg=;
        b=fhH7FET3tRtSmCfyjJZUyLux4gdj4KWDliHz/Q5/9r9vpPPt+ZSLIYB1IPCE4+Lj7O
         0kbOEMvJJr0hlvd5VdaI6g2NxtJAYUD3cNK+7QaU38tEjZTOPB/IWZZn5eUNhP8oaSG5
         K5MW+rGv2ZhA+WkBkLq+Yf5M2VnQS8QuvMFrVmxStZYTsl+m0laWfyrklI84WZ9oi2Xp
         nvAZboIxdowljG12pLovh7tuNtMjJhEzd3YvH36wesx2jf+hV7lb5mNY/i6k5/eZ6AcB
         tk7GJkHXIJiXHVILQKg734oDhZxfGYyRrfEB+jUwgRY/dj3RT7ArPh8Rel/thkt1CWh5
         oRsg==
X-Gm-Message-State: AOAM532vUrra48t+6j1NAQXemikshOfz/YC9AIjbBfWLKZz/T86Pspof
        URrXqVZ8U5XECq+Ng5L6ic5Iv6ibWvn6owZo9/E=
X-Google-Smtp-Source: ABdhPJzgI+YpNLns8qWPFjMohjS7Z8N8EXzPZKF/qe3tiJh5Vw6LzH3M7QO4rUWcee7FYSy/IoQXUeq3LgdV9UAVzU4=
X-Received: by 2002:a05:6512:1106:: with SMTP id l6mr5277831lfg.653.1618916710449;
 Tue, 20 Apr 2021 04:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <161848823868.29796.2378720492280917598.tip-bot2@tip-bot2>
 <202104160110.kPF71m4S-lkp@intel.com> <CA+_ehUzAhPhqn62ivcxF+giMUy430eija7_sOSoNmC=291wq-g@mail.gmail.com>
 <4187051b-4dcf-88e0-ac3d-fb47ff42e3ef@linaro.org> <CA+_ehUziRf7Ls8PByz-9_L8SKB26+yRY-MrZK_26GqdycCkNhg@mail.gmail.com>
 <7019d902-885f-d9ea-e24d-64ee8dd5aa0e@linaro.org>
In-Reply-To: <7019d902-885f-d9ea-e24d-64ee8dd5aa0e@linaro.org>
From:   Ansuel Smith <ansuelsmth@gmail.com>
Date:   Tue, 20 Apr 2021 13:04:58 +0200
Message-ID: <CA+_ehUwzYLU5W0452Lvryb41w=-U_SgwGBePVhQA-3UBBZUOig@mail.gmail.com>
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
> On 19/04/2021 14:08, Ansuel Smith wrote:
>
> [ ... ]
>
> >>>> vim +193 drivers/thermal/qcom/tsens-8960.c
> >>
> >> [ ... ]
> >>
> >>> What happened here? This doesn't seem right.
> >>
> >> Yes, it is. It means the series is not git bisect safe.
> >>
> >> Please fix it.
> >>
> >>
> >
> > I'm a bit confused. Should I send just a patch to fix this or I
> > need to send the series again rebased with the new changes?
>
> The latter, I've dropped your series from the thermal/next branch
>

Ok I will resend the series. I notice it has been applied to linux-next,
will that be a problem?

>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
