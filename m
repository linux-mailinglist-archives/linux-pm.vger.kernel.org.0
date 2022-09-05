Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7F25AD01E
	for <lists+linux-pm@lfdr.de>; Mon,  5 Sep 2022 12:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiIEKZB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Sep 2022 06:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236255AbiIEKZA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Sep 2022 06:25:00 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DEB13F31
        for <linux-pm@vger.kernel.org>; Mon,  5 Sep 2022 03:24:58 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso11810921pjk.0
        for <linux-pm@vger.kernel.org>; Mon, 05 Sep 2022 03:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=RC1MSKJ91kE9VBSLGcvF2T8FuZi4s6PvS0kJeDsg13Q=;
        b=rhGk45ZKJN2ivW+NW17AIxS89sPD21k1J61nT2CXdYeiqSrNW2FMzmyvb8zOhEeo7Y
         9uLwi6b2hiCjK3GAAcd7D8szhwLFnHosp3R2j0vcK8Pt8blFA6HwjlIPwXjVxiBhcJUI
         NWHzrSS+MVuLEZE6PmieyZZHbfnoPvyYhZUvhHIJDksRjq5bi44xb7PCDS8g6//zQr3n
         RWqTELi6y7mc8Jt1TiEAe6Q3ZmuhKfU70vvKQk+dw+kozyHIsJ8sIU6WSatzXORzL4So
         zdV6fg8A/P9ZU4RunJzpx4Plu2Zzf301YMsBBrU9uXGmjPtwrvtpCckpjOsjPVogFK4+
         0e3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=RC1MSKJ91kE9VBSLGcvF2T8FuZi4s6PvS0kJeDsg13Q=;
        b=ZKgACAxytXQ2Qy92zMHuu2t3nkWRrmDwjtKGr8i3gvpkNa81pl+f9o743LoX2Uipix
         Pfn9r9AFcZ1l0IJUjfROU1hvxdPprBpqg7o3uUXuwH9o8vUwcZd3VmxiOKkxAIIoIwqw
         XGzB5Imi5FDb2yBnxggxU1j+kHCcVpss3e+4hbymTNTAEjkTDMin/n9kbedTNHQDXVSR
         7UkM9SISs2p9nrZS8fSm5waIQhFpQi7NTRe8dfq9zVCJiAbpMesHMI4Fif/UWrapF+YG
         8xUXuC3gqdfZDDkG6MGUIL3OrM0AvbOjD8StEGZTq5xw1U1EkPeEjDjFomlddw6q38fP
         Vcgg==
X-Gm-Message-State: ACgBeo1mTDFaXnmoRXQe/IC7XNBRNYhNbYfwPSQuRuDmJ5cR/88PymP+
        bT+Y/cJrHmiOBgGR6ZXHN1Qb/Q==
X-Google-Smtp-Source: AA6agR4wQJnwiv1+ayV7588uzNRZI7k6/zGvPYuFTCEmTRWDIUOzYjsTn9OqHUcRs87tSjgbpF9jXw==
X-Received: by 2002:a17:90b:1e0f:b0:200:61cb:c718 with SMTP id pg15-20020a17090b1e0f00b0020061cbc718mr4729792pjb.36.1662373497952;
        Mon, 05 Sep 2022 03:24:57 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id u75-20020a62794e000000b005382b7c1015sm7376718pfc.182.2022.09.05.03.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 03:24:57 -0700 (PDT)
Date:   Mon, 5 Sep 2022 15:54:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     k.konieczny@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        "open list:ALLWINNER CPUFREQ DRIVER" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] opp: core: add regulators enable and disable
Message-ID: <20220905102454.4f77gyos476lbcws@vireshk-i7>
References: <cover.1589528491.git.viresh.kumar@linaro.org>
 <CAJiuCceftArjKPyiEW8AnT5TtuCJFsRGGA-_8y2zG5GDTxHO4Q@mail.gmail.com>
 <CAJiuCcejjaM=+XWsmOe93idbC8TyyxLj30+Lf+5C=yv=hxT80g@mail.gmail.com>
 <CAJiuCccmVtyHbd7ZvEwmw67aesyPe=eVzSE5z_KjCC5__7brjQ@mail.gmail.com>
 <20220905043543.huxq7mmpclto2h7k@vireshk-i7>
 <CAJiuCceTkz0c6FrGWuEb1589t6EcPoN7aC9Oe4Rxhr-4RCXU9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJiuCceTkz0c6FrGWuEb1589t6EcPoN7aC9Oe4Rxhr-4RCXU9g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-09-22, 10:28, Clément Péron wrote:
> Hi Viresh,
> 
> On Mon, 5 Sept 2022 at 06:35, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 03-09-22, 22:35, Clément Péron wrote:
> > > Today, I compiled my kernel without any program requiring GPU
> > > computing at boot.

I thought you disabled most of GPU stuff here and so thought panfrost
devfreq will be gone too :)

> > > This makes the dev_pm_opp_set_rate() to never be
> > > called and so the regulator is not enabled before the regulator
> > > framework switches off all the regulators that haven't been enabled.
> > >
> > > Unfortunately switching off the GPU regulator makes my board hang..
> >
> > Why does the board hang? I mean the kernel should boot fine with the
> > GPU disabled, isn't it ? Or is the regulator shared with some other
> > critical resource, or something else.
> 
> The regulator is dedicated to the GPU and the board could certainly
> run without GPU, the issue is that the driver (here panfrost) may do
> some regular access to GPU memory (I suppose).

So we do need GPU to be functional at this point ? i.e. both
clk/regulators should be enabled.

> The code I'm pointing is panfrost_devfreq_init() in
> drivers/gpu/drm/panfrost/panfrost_devfreq.c

I think it would be better to call dev_pm_opp_set_opp() after calling
devfreq_recommended_opp() in this driver, since you already have the
OPP known to you.

-- 
viresh
