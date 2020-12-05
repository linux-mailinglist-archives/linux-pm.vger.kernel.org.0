Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631242CFCFE
	for <lists+linux-pm@lfdr.de>; Sat,  5 Dec 2020 19:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbgLEST1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Sat, 5 Dec 2020 13:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgLESSU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 5 Dec 2020 13:18:20 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C13FC0613D1;
        Sat,  5 Dec 2020 10:11:09 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id y19so106117lfa.13;
        Sat, 05 Dec 2020 10:11:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uKWCtmFWH2D6PgdPDqZ6SwqxYHLfJimrQ5ADIJZYjvM=;
        b=bXFp09I66lb1RWbMF8/53Taud/7q2BNevsH1z5RzuwlvxP10zIPE3Wyh6joGUrQ5Vu
         b9wKPDkfrzRe9iw6wtXxw4Bfms40wohZHEHfoDY3SeqnhlhPuperT/DrKyfJ05arZy0R
         FKQowNsx/wVBNXpUqjsHFssUyFPDZdSdYoPfI6xRFQLkqlJB/PkYsehdRg/D2DdzThR9
         I57DXzIOgkeBg+00dbb6jEWD17b5K0cNQGOmQacTylocJvMELGWvW86ZyZDv1IS9jg3l
         lPnpkG1HS49RcR5wRBGG279jsCr79/ceSGuOiphGjQuDJeLkNWfijgUp56BVDf0rmXd5
         OqtQ==
X-Gm-Message-State: AOAM530thbLaG2xTk5CGHdJHKeZ1rgNnr7UXUfo5eU0MF15R1pDLemKx
        Dv3i0eEAhR1qxoLuECp03gF3c6AGQIFZKA==
X-Google-Smtp-Source: ABdhPJxIyKieWZJ9VxW5tLvdRrottnwtiJyqsBd6MJRYZ1ZeKbA2NYxoVKNProO+IDV8ruhVa4XFdw==
X-Received: by 2002:a17:906:4a47:: with SMTP id a7mr11831799ejv.345.1607176366602;
        Sat, 05 Dec 2020 05:52:46 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id l19sm5584565edq.14.2020.12.05.05.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 05:52:44 -0800 (PST)
Date:   Sat, 5 Dec 2020 14:52:42 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v10 17/19] ARM: tegra: Add EMC OPP properties to Tegra20
 device-trees
Message-ID: <20201205135242.GA1978@kozik-lap>
References: <20201123002723.28463-1-digetx@gmail.com>
 <20201123002723.28463-18-digetx@gmail.com>
 <60657f5e-bd30-094e-f8df-6ba69e0d6a3e@nvidia.com>
 <1ed05baf-3a01-3a2b-cd79-98b356c846cf@gmail.com>
 <X8pbz2FsuJ5XGXCi@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <X8pbz2FsuJ5XGXCi@ulmo>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Dec 04, 2020 at 04:54:55PM +0100, Thierry Reding wrote:
> On Tue, Dec 01, 2020 at 01:57:44AM +0300, Dmitry Osipenko wrote:
> > 01.12.2020 00:17, Jon Hunter пишет:
> > > Hi Dmitry,
> > > 
> > > On 23/11/2020 00:27, Dmitry Osipenko wrote:
> > >> Add EMC OPP DVFS tables and update board device-trees by removing
> > >> unsupported OPPs.
> > >>
> > >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > > This change is generating the following warning on Tegra20 Ventana
> > > and prevents the EMC from probing ...
> > > 
> > > [    2.485711] tegra20-emc 7000f400.memory-controller: device-tree doesn't have memory timings
> > > [    2.499386] tegra20-emc 7000f400.memory-controller: 32bit DRAM bus
> > > [    2.505810] ------------[ cut here ]------------
> > > [    2.510511] WARNING: CPU: 0 PID: 1 at /local/workdir/tegra/mlt-linux_next/kernel/drivers/opp/of.c:875 _of_add_opp_table_v2+0x598/0x61c
> > > [    2.529746] Modules linked in:
> > > [    2.540140] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.0-rc5-next-20201130 #1
> > > [    2.554606] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
> > > [    2.560892] [<c011136c>] (unwind_backtrace) from [<c010bb60>] (show_stack+0x10/0x14)
> > > [    2.568640] [<c010bb60>] (show_stack) from [<c0bcee54>] (dump_stack+0xc8/0xdc)
> > > [    2.575866] [<c0bcee54>] (dump_stack) from [<c01235dc>] (__warn+0x104/0x108)
> > > [    2.582912] [<c01235dc>] (__warn) from [<c0123690>] (warn_slowpath_fmt+0xb0/0xb8)
> > > [    2.590397] [<c0123690>] (warn_slowpath_fmt) from [<c0825ad0>] (_of_add_opp_table_v2+0x598/0x61c)
> > > [    2.599269] [<c0825ad0>] (_of_add_opp_table_v2) from [<c0825b90>] (dev_pm_opp_of_add_table+0x3c/0x1a0)
> > > [    2.608582] [<c0825b90>] (dev_pm_opp_of_add_table) from [<c087b774>] (tegra_emc_probe+0x478/0x940)
> > > [    2.617548] [<c087b774>] (tegra_emc_probe) from [<c0654398>] (platform_drv_probe+0x48/0x98)
> > > [    2.625899] [<c0654398>] (platform_drv_probe) from [<c0652238>] (really_probe+0x218/0x3b8)
> > > [    2.634162] [<c0652238>] (really_probe) from [<c0652540>] (driver_probe_device+0x5c/0xb4)
> > > [    2.642338] [<c0652540>] (driver_probe_device) from [<c0652740>] (device_driver_attach+0x58/0x60)
> > > [    2.651208] [<c0652740>] (device_driver_attach) from [<c06527c8>] (__driver_attach+0x80/0xbc)
> > > [    2.659730] [<c06527c8>] (__driver_attach) from [<c0650610>] (bus_for_each_dev+0x74/0xb4)
> > > [    2.667905] [<c0650610>] (bus_for_each_dev) from [<c06515f8>] (bus_add_driver+0x164/0x1e8)
> > > [    2.676168] [<c06515f8>] (bus_add_driver) from [<c06532a8>] (driver_register+0x7c/0x114)
> > > [    2.684259] [<c06532a8>] (driver_register) from [<c0102208>] (do_one_initcall+0x54/0x2b0)
> > > [    2.692441] [<c0102208>] (do_one_initcall) from [<c10010cc>] (kernel_init_freeable+0x1a4/0x1f4)
> > > [    2.701145] [<c10010cc>] (kernel_init_freeable) from [<c0bd4510>] (kernel_init+0x8/0x118)
> > > [    2.709321] [<c0bd4510>] (kernel_init) from [<c01001b0>] (ret_from_fork+0x14/0x24)
> > > [    2.716885] Exception stack(0xc1501fb0 to 0xc1501ff8)
> > > [    2.721933] 1fa0:                                     00000000 00000000 00000000 00000000
> > > [    2.730106] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > > [    2.738278] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> > > [    2.751940] ---[ end trace 61e3b76deca27ef3 ]---
> > > 
> > > 
> > > Cheers
> > > Jon
> > > 
> > 
> > Hello Jon,
> > 
> > That is harmless and expected to happen because the patch "memory:
> > tegra20: Support hardware versioning and clean up OPP table
> > initialization" isn't applied yet, while Thierry already applied the DT
> > patches from this v10.
> 
> Hmm... that's new. Since when are device tree additions expected to
> cause these kinds of splats?

It looks rather as inaccurate message, but except the message itself,
no functionality was lost.

> Anyway, I did apply these because I had seen at least some of the memory
> controller driver patches appear in linux-next and hence had assumed
> that the whole series had gone in, not realizing there was anything left
> to do.
> 
> Krzysztof, what's your schedule for the memory controller tree? My
> recollection is that this will feed into ARM SoC, so if the -rc6 dead-
> line applies like it does for platforms, then I may need to revert the
> DT patch that causes this so that we don't have to drag this along
> through all of the release cycle. If there's still time for you to send
> that PR, perhaps we can get the remainder of the Tegra interconnect
> series merged for v5.11 as well?

I was waiting for last acks from Rob and you and actually planned to
merge everything this week (weekend at the latest). Indeed it slightly
slipped away... the v11 was reposted late.

It could still make till v5.11, if I send the PR now (still around 3
weeks before merge window).

However I saw now your comments for the patch 4/10 from v11. I'll take
patches 1-3 for now.

Best regards,
Krzysztof

