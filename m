Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51BF365F86
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 20:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbhDTShF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 14:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbhDTShC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Apr 2021 14:37:02 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EBEC06174A
        for <linux-pm@vger.kernel.org>; Tue, 20 Apr 2021 11:36:28 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x19so32578433lfa.2
        for <linux-pm@vger.kernel.org>; Tue, 20 Apr 2021 11:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oBBhB8YfakUnrjN6ZIDlc6HbRqFOSIF+RBm9yxqJPuY=;
        b=RppMIyPFwayrXyYA5qJEJKIIDC25DFc8XU6IUD95aT4qzJrx8W37qyMcQdLxH2jj2w
         M3Io38e+EyQh+playUTnsIweiLil8nKsBqucEK3mJwqyRV5FbIGMgKmj3RtYYVRJjLCZ
         ks75r9IcFfM6L3PcautnzH244xO7yvCrLyyh0lE2Zz3mp/gVZindbqNstoPkM3jeMh9j
         SYSq2JVN5lp9TxeF5wizluyX+d3BuCG1plKIHkHM8BhTiwzwlteEUvxUgMF6SeMWQtvz
         YW4SxXQRUvDWDAqJb2ebWqZOKk747AUXUPUqcfRCNPJ2T0v3Vv9PwCgBX3eTB0b6vP7n
         a54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oBBhB8YfakUnrjN6ZIDlc6HbRqFOSIF+RBm9yxqJPuY=;
        b=CPtWqpBDkgyluKI5rza5K/10MFOfxLu+2l1ck/V9xlBm38/xK6GIOfHHomE+M7T0wN
         8P1uarL9bpHkHd8yQz7m3TsW67Q4SP3vKtt2iXGA4cV6y0aV8wHdjYD4qLWpyurHNyh7
         gTyvXHQmv5hsLmZjkUTJruvRaph7fJQu3+TW0MCPFIOYP/D6srv6bMRgEYPxy+LcM97g
         vQP4e74Yj5ciHXNBFaKdREubjIHdE0okEq7g9JtLQoBQcoptLzk++nrM1MPlByhYYne8
         AT9YQu6zPuH8rn8WlbrfdSPDXeM7wFcVOydo91dnuK2kN1BMIv05+66FQclRAqsdtEYV
         4GYw==
X-Gm-Message-State: AOAM531TBQVgc7ad7jG57cgq5TTRccmuEF97hy8aa9IDO3jfx0ALsi9M
        xi2jQbwF59yXKr/DEOPRSvpi18TUrZsyQxvs4NY=
X-Google-Smtp-Source: ABdhPJzxnLDP5wtzVaVdCDkuaD1WdMx6g+gC6Yto50DyjlU36qUAxcLG0hNtreXkVKUsXER0zOy8mMx/XTgRv/nQJqQ=
X-Received: by 2002:ac2:4187:: with SMTP id z7mr16459722lfh.4.1618943786942;
 Tue, 20 Apr 2021 11:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <161848823868.29796.2378720492280917598.tip-bot2@tip-bot2>
 <202104160110.kPF71m4S-lkp@intel.com> <CA+_ehUzAhPhqn62ivcxF+giMUy430eija7_sOSoNmC=291wq-g@mail.gmail.com>
 <4187051b-4dcf-88e0-ac3d-fb47ff42e3ef@linaro.org> <CA+_ehUziRf7Ls8PByz-9_L8SKB26+yRY-MrZK_26GqdycCkNhg@mail.gmail.com>
 <7019d902-885f-d9ea-e24d-64ee8dd5aa0e@linaro.org> <CA+_ehUwzYLU5W0452Lvryb41w=-U_SgwGBePVhQA-3UBBZUOig@mail.gmail.com>
 <e92be9ae-1ce9-adf1-86b9-0193cce708ea@linaro.org>
In-Reply-To: <e92be9ae-1ce9-adf1-86b9-0193cce708ea@linaro.org>
From:   Ansuel Smith <ansuelsmth@gmail.com>
Date:   Tue, 20 Apr 2021 20:36:15 +0200
Message-ID: <CA+_ehUxbw7scg_59OA8v+QQ+PUyZATs7+bNYKrGR17r6fY9eZw@mail.gmail.com>
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
> On 20/04/2021 13:04, Ansuel Smith wrote:
> >>
> >> On 19/04/2021 14:08, Ansuel Smith wrote:
> >>
> >> [ ... ]
> >>
> >>>>>> vim +193 drivers/thermal/qcom/tsens-8960.c
> >>>>
> >>>> [ ... ]
> >>>>
> >>>>> What happened here? This doesn't seem right.
> >>>>
> >>>> Yes, it is. It means the series is not git bisect safe.
> >>>>
> >>>> Please fix it.
> >>>>
> >>>>
> >>>
> >>> I'm a bit confused. Should I send just a patch to fix this or I
> >>> need to send the series again rebased with the new changes?
> >>
> >> The latter, I've dropped your series from the thermal/next branch
> >>
> >
> > Ok I will resend the series. I notice it has been applied to linux-next=
,
> > will that be a problem?
>
> No, it is fine. linux-next uses thermal/linux-next and it is allowed to
> rebase the branch.
>
> I've just updated it with your v14 series dropped.
>

I have just sent v15 series hoping it's more bisect friendly. Hope it's
good now and sorry for the mess.

>
> >> --
> >> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs
> >>
> >> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> >> <http://twitter.com/#!/linaroorg> Twitter |
> >> <http://www.linaro.org/linaro-blog/> Blog
>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
