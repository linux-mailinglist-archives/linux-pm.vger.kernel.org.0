Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44192E344D
	for <lists+linux-pm@lfdr.de>; Mon, 28 Dec 2020 06:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgL1F2S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Dec 2020 00:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgL1F2R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Dec 2020 00:28:17 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6FEC061795
        for <linux-pm@vger.kernel.org>; Sun, 27 Dec 2020 21:27:37 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id p18so6717072pgm.11
        for <linux-pm@vger.kernel.org>; Sun, 27 Dec 2020 21:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m6iGFAz/o22U6PmB3WkdjaUQwLdQTi18fE/pFAkMQkY=;
        b=ag7J8eZ563WdkpxC/oJWe2X6CKpfPEfNcj5tJENe/6miIBnVH0nJ0arfa9180VIZtR
         MzOcV1yijQRo+0uhzmnsihgXRAzxv27+x6tNE6dHGJ0A/ufNIQPvHn0nNX0mm8qKaeJu
         Joi/SdnpKJifhhrJ/k3swT6dhdxwYMKAAqcS48l3hoaDEmAMKD4j9XO7o31QixdKXBBN
         qnCbaltwN9JujCS8N8L0WkS0vz4NRxvaECe+8vYB8DQGz93IKj3lgatRPTtEKne/xnEQ
         XR6x36lCcSvQD2KHA3NZL7M4k8wdoUwaxxPMlVveDOrqjcBajOcIYGYk5+NzcLNej9Hv
         /imw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m6iGFAz/o22U6PmB3WkdjaUQwLdQTi18fE/pFAkMQkY=;
        b=j6+kKYR4fzZMEsnvEDewEXVYVa40Ybzv6uzOHgQ4LqvL9wfs8LIxXeZ69K1GK5OnU3
         csUzkEI55eLG+LE7qHseMlt23O1nYh8joFYW2bVtiFidiX1SV8e2aUDqLAET1rqJYU3A
         Q7/GQmnDai442Q5zADzbofwvOZfc6LszRDnDvNRQo1zKjuYeEthnDy+hPfk1XbiFcFLt
         iGdfgSvtBA0UH5DNsl3etpIZvrJH3eB7DYWQCp6C1nBNWxJDzS+HMYEH9uppVg3buW2W
         w3ELMGfceSzMIRu/LNrIHB4NzSD5CLYuuZ179iyGWkDkn0SJbwPsbPbqXdHbfFr/VR/m
         fffw==
X-Gm-Message-State: AOAM530jU0CVcryfkbQ0LBlKRoTdSrr2LgE6N8wuAVAjcHlWx9/viZTB
        v5WkpwZwWlyuFfrmgS6UXzV4uvLeaLV6eA==
X-Google-Smtp-Source: ABdhPJxHP1zQadptEw3kENTzYuSjxHYcBX5Q0UZwbXn0p3j/ap4yYCdzDqmUlgmDFFXt5WybE0P0oQ==
X-Received: by 2002:a63:794:: with SMTP id 142mr41874141pgh.187.1609133256843;
        Sun, 27 Dec 2020 21:27:36 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id k11sm37735624pgt.83.2020.12.27.21.27.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Dec 2020 21:27:35 -0800 (PST)
Date:   Mon, 28 Dec 2020 10:57:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     quanyang.wang@windriver.com
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: fix memory leak in _allocate_opp_table
Message-ID: <20201228052733.wbrckyooh6bp2mmo@vireshk-i7>
References: <20201224104927.722763-1-quanyang.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201224104927.722763-1-quanyang.wang@windriver.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-12-20, 18:49, quanyang.wang@windriver.com wrote:
> From: Quanyang Wang <quanyang.wang@windriver.com>
> 
> In function _allocate_opp_table, opp_dev is allocated and referenced
> by opp_table via _add_opp_dev. But in the case that the subsequent calls
> return -EPROBE_DEFER, it will jump to err label and opp_table will be
> freed. Then opp_dev becomes an unreferenced object to cause memory leak.
> So let's call _remove_opp_dev to do the cleanup.
> 
> This fixes the following kmemleak report:
> 
> unreferenced object 0xffff000801524a00 (size 128):
>   comm "swapper/0", pid 1, jiffies 4294892465 (age 84.616s)
>   hex dump (first 32 bytes):
>     40 00 56 01 08 00 ff ff 40 00 56 01 08 00 ff ff  @.V.....@.V.....
>     b8 52 77 7f 08 00 ff ff 00 3c 4c 00 08 00 ff ff  .Rw......<L.....
>   backtrace:
>     [<00000000b1289fb1>] kmemleak_alloc+0x30/0x40
>     [<0000000056da48f0>] kmem_cache_alloc+0x3d4/0x588
>     [<00000000a84b3b0e>] _add_opp_dev+0x2c/0x88
>     [<0000000062a380cd>] _add_opp_table_indexed+0x124/0x268
>     [<000000008b4c8f1f>] dev_pm_opp_of_add_table+0x20/0x1d8
>     [<00000000e5316798>] dev_pm_opp_of_cpumask_add_table+0x48/0xf0
>     [<00000000db0a8ec2>] dt_cpufreq_probe+0x20c/0x448
>     [<0000000030a3a26c>] platform_probe+0x68/0xd8
>     [<00000000c618e78d>] really_probe+0xd0/0x3a0
>     [<00000000642e856f>] driver_probe_device+0x58/0xb8
>     [<00000000f10f5307>] device_driver_attach+0x74/0x80
>     [<0000000004f254b8>] __driver_attach+0x58/0xe0
>     [<0000000009d5d19e>] bus_for_each_dev+0x70/0xc8
>     [<0000000000d22e1c>] driver_attach+0x24/0x30
>     [<0000000001d4e952>] bus_add_driver+0x14c/0x1f0
>     [<0000000089928aaa>] driver_register+0x64/0x120
> 
> Fixes: dd461cd9183f ("opp: Allow dev_pm_opp_get_opp_table() to return -EPROBE_DEFER")
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> ---
>  drivers/opp/core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied with an additional patch. Thanks.

Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Mon Dec 28 10:51:04 2020 +0530

    opp: Call the missing clk_put() on error
    
    Fix the clock reference counting by calling the missing clk_put() in the
    error path.
    
    Cc: v5.10 <stable@vger.kernel.org> # v5.10
    Fixes: dd461cd9183f ("opp: Allow dev_pm_opp_get_opp_table() to return -EPROBE_DEFER")
    Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index c9e50836b4c2..8c905aabacc0 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1101,7 +1101,7 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
        ret = dev_pm_opp_of_find_icc_paths(dev, opp_table);
        if (ret) {
                if (ret == -EPROBE_DEFER)
-                       goto remove_opp_dev;
+                       goto put_clk;
 
                dev_warn(dev, "%s: Error finding interconnect paths: %d\n",
                         __func__, ret);
@@ -1113,6 +1113,9 @@ static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 
        return opp_table;
 
+put_clk:
+       if (!IS_ERR(opp_table->clk))
+               clk_put(opp_table->clk);
 remove_opp_dev:
        _remove_opp_dev(opp_dev, opp_table);
 err:

-- 
viresh
