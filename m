Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1CF7B6D2A
	for <lists+linux-pm@lfdr.de>; Tue,  3 Oct 2023 17:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjJCPbn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Oct 2023 11:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjJCPbm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Oct 2023 11:31:42 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364C783
        for <linux-pm@vger.kernel.org>; Tue,  3 Oct 2023 08:31:39 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-59f4db9e11eso12537917b3.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Oct 2023 08:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696347098; x=1696951898; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rIprHvjnQ0jjh8gCopJoRqCFFfq7B4Ea/uYr1Nn1XhM=;
        b=Gx9ZD/Vd5mdt1/smwlQ+UVAydxNXFItuScF/mp9jjSldbWlg+RB8u728GLunzDCqmS
         yoEFOAjea2A33Hb0XOfVVa1P9ewsrJ9BUvQyrYv3W3IxgoCM/SHLEf4lAJcmrawHrQW+
         oiqHTb5BxaEf/W6efBItuethq+5zpjyin+9/vp0XJ/VNhVbK55kNrkMjVRIr/vJbXX5H
         TB9/qJngc7/fEJLiJLVkBIH6fhnxo7Rxg8E+LBE0xRTfcAKJbFsdoZMnESW7Gb6VAVhR
         c/ZbyXarQwjNepHEFfm4DKrjD/QayDsp2voqihAuhselV4GvPB2vbx8N7D15kRQ4FTxw
         MtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696347098; x=1696951898;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rIprHvjnQ0jjh8gCopJoRqCFFfq7B4Ea/uYr1Nn1XhM=;
        b=sw/Zw39Lr9sR9nXczml17uuCy7YV8VIfrNGhFCpKOxBKXGQIRwhvVPY2uRKXxU9OWC
         Y/n0flWSom9D/qRCDtg3VkuBwt+ofO/wnDLD3PnCevzHcW2JyHp9mnQPDwtDdtzcIRh0
         Enhh1fyIBgF1HY6L8wTu1TfqXPVEwl/Hlpul7mrPy/eHXn4m/87ps8gwHGe7VxspVmXa
         85bgz8FtXhKw1GY+Ux2BGY6UvsxA+cf6j/l8DxQH22KVsaPITqksD+0ncsLpalZuxcQm
         MoVyc0ks6WTd1opSIk4VF8PUQPw1SQScU+QpCbWIHslsAiEDu1lbsmQLjfgxU1BWhidU
         uAFA==
X-Gm-Message-State: AOJu0YyG19VNtP6x9HEZ6ZH45C4bmZjPAP+0W6TIOtOB6Hm5JdeVa8yD
        MwASJbyF6/Ime8rXeB1ZBH96aik5B96x3teE2LOG1g2uid8tioyzCLU=
X-Google-Smtp-Source: AGHT+IFFLi9zGgJz9udPCkb4GTdklX1CUJrGoUx+aAQUhdWGPtGBqD/W1zIHqbDenzhhDonQTNtmD+UVpwrFf27niac=
X-Received: by 2002:a81:48c7:0:b0:59f:5614:ebe8 with SMTP id
 v190-20020a8148c7000000b0059f5614ebe8mr15258036ywa.9.1696347098371; Tue, 03
 Oct 2023 08:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230827115033.935089-1-dmitry.baryshkov@linaro.org>
 <20230827115033.935089-6-dmitry.baryshkov@linaro.org> <493aff10d698c9ca5bdbeae45250f5fe.sboyd@kernel.org>
 <7312633f-3b53-43a1-b6e3-010513c2a1e2@linaro.org> <ZRwQvP_GbvwvLAn8@gerhold.net>
 <CAA8EJpr9WH+MQdOJQ5yockg9TsUnDcenGbs=dq4Nt0SSBaK=0A@mail.gmail.com> <ZRwia2_imBfRfv7X@gerhold.net>
In-Reply-To: <ZRwia2_imBfRfv7X@gerhold.net>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 3 Oct 2023 18:31:27 +0300
Message-ID: <CAA8EJppK6Qm22r0RhFJS6tSc=g-bLxOwDuxLCScRxS0MiZq3sA@mail.gmail.com>
Subject: Re: [PATCH v4 05/23] interconnect: icc-clk: add support for scaling
 using OPP
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 3 Oct 2023 at 17:17, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> On Tue, Oct 03, 2023 at 04:36:11PM +0300, Dmitry Baryshkov wrote:
> > On Tue, 3 Oct 2023 at 16:02, Stephan Gerhold <stephan@gerhold.net> wrote:
> > >
> > > On Tue, Oct 03, 2023 at 11:30:28AM +0300, Dmitry Baryshkov wrote:
> > > > On 28/08/2023 21:09, Stephen Boyd wrote:
> > > > > Quoting Dmitry Baryshkov (2023-08-27 04:50:15)
> > > > > > diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-clk.c
> > > > > > index d787f2ea36d9..45ffb068979d 100644
> > > > > > --- a/drivers/interconnect/icc-clk.c
> > > > > > +++ b/drivers/interconnect/icc-clk.c
> > > > > > @@ -25,12 +28,16 @@ struct icc_clk_provider {
> > > > > >   static int icc_clk_set(struct icc_node *src, struct icc_node *dst)
> > > > > >   {
> > > > > >          struct icc_clk_node *qn = src->data;
> > > > > > +       unsigned long rate = icc_units_to_bps(src->peak_bw);
> > > > > >          int ret;
> > > > > >          if (!qn || !qn->clk)
> > > > > >                  return 0;
> > > > > > -       if (!src->peak_bw) {
> > > > > > +       if (qn->opp)
> > > > > > +               return dev_pm_opp_set_rate(qn->dev, rate);
> > > > >
> > > > > Just curious how does lockdep do with this? Doesn't OPP call into
> > > > > interconnect code, so lockdep will complain about ABBA?
> > > >
> > > > Unfortunately it does. It seems, the icc-clk is not a proper way to go here.
> > > > I will take a look at reusing set_required_opps for this case.
> > > >
> > >
> > > Could you elaborate a bit which locks exactly cause trouble here?
> > > I'm probably missing something here.
> > >
> > > From a quick look at the OPP code I don't see a global lock taken there
> > > for the entire OPP switch sequence, so I'm not sure how this could cause
> > > an ABBA deadlock.
> >
> > For example:
> >
> > [    7.680041] Chain exists of:
> > [    7.680041]   icc_bw_lock --> regulator_ww_class_acquire --> fs_reclaim
> > [    7.680041]
> > [    7.687955]  Possible unsafe locking scenario:
> > [    7.687955]
> > [    7.699039]        CPU0                    CPU1
> > [    7.704752]        ----                    ----
> > [    7.709266]   lock(fs_reclaim);
> > [    7.713779]                                lock(regulator_ww_class_acquire);
> > [    7.716919]                                lock(fs_reclaim);
> > [    7.724204]   lock(icc_bw_lock);
> >
>
> Hm, I'm not entirely sure how to interpret this. Is there really a
> connection between OPP and ICC here? It looks more like ICC <->
> regulator and somehow related to memory allocations (the fs_reclaim).
>
> Was there more output around this?

[    7.362902] ======================================================
[    7.363447] WARNING: possible circular locking dependency detected
[    7.369434] 6.6.0-rc3-next-20230929-08870-g49503b4b9f55 #129 Not tainted
[    7.375604] ------------------------------------------------------
[    7.382453] swapper/0/1 is trying to acquire lock:
[    7.388437] c143445c (icc_bw_lock){+.+.}-{3:3}, at: icc_init+0x0/0x104
[    7.393225]
[    7.393225] but task is already holding lock:
[    7.399730] c1397444 (fs_reclaim){+.+.}-{0:0}, at: icc_init+0x18/0x104
[    7.405547]
[    7.405547] which lock already depends on the new lock.
[    7.405547]
[    7.412077]
[    7.412077] the existing dependency chain (in reverse order) is:
[    7.420310]
[    7.420310] -> #2 (fs_reclaim){+.+.}-{0:0}:
[    7.427767]        fs_reclaim_acquire+0x60/0x94
[    7.433492]        __kmem_cache_alloc_node+0x30/0x2b4
[    7.437742]        __kmalloc_node_track_caller+0x48/0x244
[    7.442954]        kstrdup+0x30/0x58
[    7.448325]        create_regulator+0x70/0x2b8
[    7.451981]        regulator_resolve_supply+0x3bc/0x7f4
[    7.456234]        regulator_register+0x9b0/0xb50
[    7.461352]        devm_regulator_register+0x50/0x8c
[    7.466216]        rpm_reg_probe+0xf4/0x1a0
[    7.471244]        platform_probe+0x5c/0xb0
[    7.475157]        really_probe+0xc8/0x2d8
[    7.479318]        __driver_probe_device+0x88/0x1a0
[    7.483488]        driver_probe_device+0x30/0x108
[    7.488262]        __driver_attach_async_helper+0x4c/0xa0
[    7.493133]        async_run_entry_fn+0x24/0xb0
[    7.498504]        process_one_work+0x208/0x5e4
[    7.502844]        worker_thread+0x1e0/0x4a4
[    7.507356]        kthread+0x100/0x120
[    7.511874]        ret_from_fork+0x14/0x28
[    7.515428]
[    7.515428] -> #1 (regulator_ww_class_acquire){+.+.}-{0:0}:
[    7.519528]        lock_release+0x164/0x340
[    7.526713]        __mutex_unlock_slowpath+0x3c/0x2fc
[    7.530626]        regulator_lock_dependent+0x1a4/0x298
[    7.535839]        regulator_set_voltage+0x30/0xfc
[    7.540866]        krait_l2_set_one_supply+0x28/0x84
[    7.545729]        krait_l2_config_regulators+0x90/0x1c4
[    7.550851]        _set_opp+0xf0/0x438
[    7.556144]        dev_pm_opp_set_rate+0x118/0x224
[    7.559703]        icc_node_add+0xe8/0x15c
[    7.564474]        icc_clk_register+0x150/0x208
[    7.568556]        krait_l2_probe+0x100/0x114
[    7.572988]        platform_probe+0x5c/0xb0
[    7.577495]        really_probe+0xc8/0x2d8
[    7.581487]        __driver_probe_device+0x88/0x1a0
[    7.585658]        driver_probe_device+0x30/0x108
[    7.590433]        __device_attach_driver+0x94/0x10c
[    7.595300]        bus_for_each_drv+0x84/0xd8
[    7.600326]        __device_attach+0xac/0x1a8
[    7.604580]        bus_probe_device+0x8c/0x90
[    7.608919]        device_add+0x5c8/0x7a4
[    7.613265]        of_platform_device_create_pdata+0x90/0xbc
[    7.617260]        qcom_cpufreq_init+0xa8/0x130
[    7.622984]        do_one_initcall+0x68/0x2d8
[    7.627235]        kernel_init_freeable+0x1ac/0x208
[    7.631752]        kernel_init+0x18/0x12c
[    7.636441]        ret_from_fork+0x14/0x28
[    7.640602]
[    7.640602] -> #0 (icc_bw_lock){+.+.}-{3:3}:
[    7.644607]        __lock_acquire+0x1530/0x28fc
[    7.650413]        lock_acquire+0x10c/0x33c
[    7.654757]        icc_init+0x40/0x104
[    7.658917]        do_one_initcall+0x68/0x2d8
[    7.662740]        kernel_init_freeable+0x1ac/0x208
[    7.667168]        kernel_init+0x18/0x12c
[    7.671855]        ret_from_fork+0x14/0x28
[    7.676018]
[    7.676018] other info that might help us debug this:
[    7.676018]
[    7.680041] Chain exists of:
[    7.680041]   icc_bw_lock --> regulator_ww_class_acquire --> fs_reclaim
[    7.680041]
[    7.687955]  Possible unsafe locking scenario:
[    7.687955]
[    7.699039]        CPU0                    CPU1
[    7.704752]        ----                    ----
[    7.709266]   lock(fs_reclaim);
[    7.713779]                                lock(regulator_ww_class_acquire);
[    7.716919]                                lock(fs_reclaim);
[    7.724204]   lock(icc_bw_lock);
[    7.729833]
[    7.729833]  *** DEADLOCK ***
[    7.729833]
[    7.733071] 1 lock held by swapper/0/1:
[    7.738691]  #0: c1397444 (fs_reclaim){+.+.}-{0:0}, at: icc_init+0x18/0x104
[    7.742528]
[    7.742528] stack backtrace:
[    7.749463] CPU: 3 PID: 1 Comm: swapper/0 Not tainted
6.6.0-rc3-next-20230929-08870-g49503b4b9f55 #129
[    7.754010] Hardware name: Generic DT based system
[    7.763183]  unwind_backtrace from show_stack+0x10/0x14
[    7.767957]  show_stack from dump_stack_lvl+0x60/0x90
[    7.773082]  dump_stack_lvl from check_noncircular+0x174/0x18c
[    7.778288]  check_noncircular from __lock_acquire+0x1530/0x28fc
[    7.784018]  __lock_acquire from lock_acquire+0x10c/0x33c
[    7.790178]  lock_acquire from icc_init+0x40/0x104
[    7.795475]  icc_init from do_one_initcall+0x68/0x2d8
[    7.800159]  do_one_initcall from kernel_init_freeable+0x1ac/0x208
[    7.805286]  kernel_init_freeable from kernel_init+0x18/0x12c
[    7.811361]  kernel_init from ret_from_fork+0x14/0x28
[    7.817177] Exception stack(0xf081dfb0 to 0xf081dff8)

> In general, I would expect that adjusting a regulator from an
> interconnect driver should be made possible somehow. Just because the
> RPM firmware or similar typically handles this internally on Qualcomm
> platforms doesn't mean no one else will ever need to do this. If you
> have a higher bandwidth requests, need to increase the clock, which
> again depends on a higher voltage, then you need to be able to do the
> regulator_set_voltage() from the ICC driver somehow.

This kind of dependency is handled by the consumer, not by the ICC
driver. Usually we explicitly put them to the opp tables, matching
rates and volage.

I think I'll still check the required-opps approach. It will require
manually aggregating the L2 rate requirements, but then we will be
safe from such kinds of interdependencies. And maybe then we can also
rewrite msm8996 to use required-opps too.


-- 
With best wishes
Dmitry
