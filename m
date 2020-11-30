Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFAB2C91C5
	for <lists+linux-pm@lfdr.de>; Tue,  1 Dec 2020 00:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgK3W6l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 17:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgK3W6l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2020 17:58:41 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75007C0617A6;
        Mon, 30 Nov 2020 14:57:47 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id l11so25188260lfg.0;
        Mon, 30 Nov 2020 14:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CF4VCvT4y1MxLEN3CJpvUBs6aS1caFV9qr8mvMQWWkQ=;
        b=d2cpPCDwNOjwJ6zcyEH2OArFryPnDeS1v1mqLxiZ+cT8m5CMXk396ihiK1Z+IbhVGH
         1tDI2bfUXmCLyz0+wmsNpiZ8XBXhA1tumhbrUIKZiRJlzSGihfizD+UFCJu63/yAb4+K
         rV3Zm1PIcTZyuCXFy1FHWMOmSyc7jFxs5KUvk5p4diMvitODg1SqQZUkVjyquBm3BdPC
         N8Q2rwDqqHMfQsUGPskU3kXBiQdkLyCsLBgyldzxov3xNZ+QZpIqAjdOyAGQbGL41qm9
         BL787np2iHPKbnFaf48ATS0ymrwLyBukH6pVmXsxfCrhm5VPqbwaZOEPhxRq3gN3bZqt
         Bogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CF4VCvT4y1MxLEN3CJpvUBs6aS1caFV9qr8mvMQWWkQ=;
        b=G02Xoof0jGFFeOb5nZ8yakOyyoq2XjbDrSGtljTUTSOYrilbPvvO16JMXhKFonOjOz
         gdF6ZT8hdRi0h2mligV8lxZEyLIPqYlP3uX6UHWjVrCHYRNvTYOhYf0UcafcCayYkJXM
         PV4s9Cyx5VgOFLFqhmL/IJTSJe56UAUlglCpcbY0D/z7BZHSQtAqnXml4PeOvuTIbPBT
         K50URO8BrpOg1YcL9Hv4tM+eIggEKoewwEMxZh+TNM+XE+R+Kxz2Dcm18+UBVL1SGws6
         9/Ilb7ZI0mW2Ffve3ZA2HQTIVP1urwR5EhjM5k5LVdQDFZqWc12r5xs9nwTETFY897I/
         6q/w==
X-Gm-Message-State: AOAM532FHrbBcckH9/IFc+lVkxSrLRRDkLFgR/PPqvPzm1XAh9Ry4Hls
        RurGTC+vyP4YYMliHtoEx/E=
X-Google-Smtp-Source: ABdhPJxPQ5c3K0b2ozPSWkF7iFJ7NCtYycGijm2HoLwZV/SOV1v33DiiclIeLz/+U3dd6zS5vKhPhQ==
X-Received: by 2002:ac2:4890:: with SMTP id x16mr10210588lfc.4.1606777066004;
        Mon, 30 Nov 2020 14:57:46 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id p16sm2616059lfe.255.2020.11.30.14.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 14:57:45 -0800 (PST)
Subject: Re: [PATCH v10 17/19] ARM: tegra: Add EMC OPP properties to Tegra20
 device-trees
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
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
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20201123002723.28463-1-digetx@gmail.com>
 <20201123002723.28463-18-digetx@gmail.com>
 <60657f5e-bd30-094e-f8df-6ba69e0d6a3e@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1ed05baf-3a01-3a2b-cd79-98b356c846cf@gmail.com>
Date:   Tue, 1 Dec 2020 01:57:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <60657f5e-bd30-094e-f8df-6ba69e0d6a3e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.12.2020 00:17, Jon Hunter пишет:
> Hi Dmitry,
> 
> On 23/11/2020 00:27, Dmitry Osipenko wrote:
>> Add EMC OPP DVFS tables and update board device-trees by removing
>> unsupported OPPs.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> This change is generating the following warning on Tegra20 Ventana
> and prevents the EMC from probing ...
> 
> [    2.485711] tegra20-emc 7000f400.memory-controller: device-tree doesn't have memory timings
> [    2.499386] tegra20-emc 7000f400.memory-controller: 32bit DRAM bus
> [    2.505810] ------------[ cut here ]------------
> [    2.510511] WARNING: CPU: 0 PID: 1 at /local/workdir/tegra/mlt-linux_next/kernel/drivers/opp/of.c:875 _of_add_opp_table_v2+0x598/0x61c
> [    2.529746] Modules linked in:
> [    2.540140] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.0-rc5-next-20201130 #1
> [    2.554606] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
> [    2.560892] [<c011136c>] (unwind_backtrace) from [<c010bb60>] (show_stack+0x10/0x14)
> [    2.568640] [<c010bb60>] (show_stack) from [<c0bcee54>] (dump_stack+0xc8/0xdc)
> [    2.575866] [<c0bcee54>] (dump_stack) from [<c01235dc>] (__warn+0x104/0x108)
> [    2.582912] [<c01235dc>] (__warn) from [<c0123690>] (warn_slowpath_fmt+0xb0/0xb8)
> [    2.590397] [<c0123690>] (warn_slowpath_fmt) from [<c0825ad0>] (_of_add_opp_table_v2+0x598/0x61c)
> [    2.599269] [<c0825ad0>] (_of_add_opp_table_v2) from [<c0825b90>] (dev_pm_opp_of_add_table+0x3c/0x1a0)
> [    2.608582] [<c0825b90>] (dev_pm_opp_of_add_table) from [<c087b774>] (tegra_emc_probe+0x478/0x940)
> [    2.617548] [<c087b774>] (tegra_emc_probe) from [<c0654398>] (platform_drv_probe+0x48/0x98)
> [    2.625899] [<c0654398>] (platform_drv_probe) from [<c0652238>] (really_probe+0x218/0x3b8)
> [    2.634162] [<c0652238>] (really_probe) from [<c0652540>] (driver_probe_device+0x5c/0xb4)
> [    2.642338] [<c0652540>] (driver_probe_device) from [<c0652740>] (device_driver_attach+0x58/0x60)
> [    2.651208] [<c0652740>] (device_driver_attach) from [<c06527c8>] (__driver_attach+0x80/0xbc)
> [    2.659730] [<c06527c8>] (__driver_attach) from [<c0650610>] (bus_for_each_dev+0x74/0xb4)
> [    2.667905] [<c0650610>] (bus_for_each_dev) from [<c06515f8>] (bus_add_driver+0x164/0x1e8)
> [    2.676168] [<c06515f8>] (bus_add_driver) from [<c06532a8>] (driver_register+0x7c/0x114)
> [    2.684259] [<c06532a8>] (driver_register) from [<c0102208>] (do_one_initcall+0x54/0x2b0)
> [    2.692441] [<c0102208>] (do_one_initcall) from [<c10010cc>] (kernel_init_freeable+0x1a4/0x1f4)
> [    2.701145] [<c10010cc>] (kernel_init_freeable) from [<c0bd4510>] (kernel_init+0x8/0x118)
> [    2.709321] [<c0bd4510>] (kernel_init) from [<c01001b0>] (ret_from_fork+0x14/0x24)
> [    2.716885] Exception stack(0xc1501fb0 to 0xc1501ff8)
> [    2.721933] 1fa0:                                     00000000 00000000 00000000 00000000
> [    2.730106] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    2.738278] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    2.751940] ---[ end trace 61e3b76deca27ef3 ]---
> 
> 
> Cheers
> Jon
> 

Hello Jon,

That is harmless and expected to happen because the patch "memory:
tegra20: Support hardware versioning and clean up OPP table
initialization" isn't applied yet, while Thierry already applied the DT
patches from this v10.
