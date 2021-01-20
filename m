Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B9F2FCC8F
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 09:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbhATIQi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Jan 2021 03:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730465AbhATIHF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2021 03:07:05 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88146C061798
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2021 00:06:14 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 30so14685030pgr.6
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2021 00:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oNkS7BO+I4iYqbb8e23nWgzCyCIirVtUbZHdA/+LLQk=;
        b=H8ahtFkrl8XoAAXOdig+ykUsHL1WV8A6ooGgVzGod+L1cIXRgMBoBvdTwc/Bk1DSAw
         PlXgpR+6+XSKVseQkHvUwtknt1dIbynk1U0WfmpbYJx0KfQJ60w7GCa6j2ZecpEDDwEo
         nZZoGepdNQ9fPJxFhxL/+9UAerRGCpTZra+L94Rj4OQuHY79Ahi/XVBbvK9hMw9c+U7M
         8X1qo+PBEB4Y4p9FSHCVeEFTMnNiPSudwgYQ7iYxcN+1kwI6v1CiXCY2zvxc5qAJyP9k
         iZVJ8Ku2VjFoupFP/yuzfnbVR0/qVdTPP9WFLH6tYXQGiUp6x4P/9Ga2F5nvtoMXwt6r
         eR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oNkS7BO+I4iYqbb8e23nWgzCyCIirVtUbZHdA/+LLQk=;
        b=F+tbqwSNg5Zh9HfERR5ubtt/q/ZLkBJL0EFvJmstsAJ/8U4q+HDl4U1q58AY7MACf/
         l2UBVD2I8lBiGXHV9YYNI5OeblejNETxXCI91ZU+ixP2pXnMBA2gh2DYqN4onoSBUcyy
         H9UPqtauzGpDHvnhigeEzFiXYzJsYs1cwxGbmvJ7jHhVEjxxezOhU0WMb7fjHqN0+xnZ
         Hw3nRXuYUdEYDYQ9/XCR0ckzgFQjlJRwPaJNZqM1rXhVVFYoDs08NfLtNXgRVAgIaTnO
         emKRmHop+teyBVouE2gwGp4zyoap9x+yDiy2b6f+WdGPfmup8trjFgr9ysrRp4RIYRtj
         RywQ==
X-Gm-Message-State: AOAM530SI0LlI7KQo8Lqa5FhSiRVfUXdYrzOwecKcgPWNwSVPdWT2daY
        WeIknB0PQ/GkIm9l+zOs4K+xHg==
X-Google-Smtp-Source: ABdhPJxxnQpjU22yEmNNtaWWmWh2iwZ/WZIldmsDhPNptwyaFHrkBk9JWxSodC3SuvlwGpHnbs4W8g==
X-Received: by 2002:a63:ef14:: with SMTP id u20mr8314758pgh.93.1611129973985;
        Wed, 20 Jan 2021 00:06:13 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id p15sm1419910pgl.19.2021.01.20.00.06.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2021 00:06:12 -0800 (PST)
Date:   Wed, 20 Jan 2021 13:36:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [BUG] NULL pointer in dev_pm_opp_put_regulators
Message-ID: <20210120080611.uqmik3hc5kq6mpxw@vireshk-i7>
References: <20210120075902.lfz6cw4jgqg6e7c3@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120075902.lfz6cw4jgqg6e7c3@kozik-lap>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-01-21, 08:59, Krzysztof Kozlowski wrote:
> Hi,
> 
> Today's next fails to boot on Exynos5422 Odroid HC1 board:
> 
> [    6.409023] Unable to handle kernel NULL pointer dereference at virtual address 00000004
> [    6.417199] pgd = (ptrval)
> [    6.419748] [00000004] *pgd=00000000
> [    6.423499] Internal error: Oops: 805 [#1] PREEMPT SMP ARM
> [    6.428724] Modules linked in:
> [    6.431752] CPU: 5 PID: 1 Comm: swapper/0 Not tainted 5.11.0-rc4-next-20210120 #2
> [    6.439209] Hardware name: Samsung Exynos (Flattened Device Tree)
> [    6.445273] PC is at dev_pm_opp_put_regulators+0xb4/0x114
> ...
> [    6.680370] [<c086f51c>] (dev_pm_opp_put_regulators) from [<c08d5d48>] (exynos_bus_probe+0x45c/0x620)
> [    6.689556] [<c08d5d48>] (exynos_bus_probe) from [<c06b49a8>] (platform_probe+0x80/0xc0)
> [    6.697614] [<c06b49a8>] (platform_probe) from [<c06b1ab4>] (really_probe+0x1d4/0x500)
> [    6.705499] [<c06b1ab4>] (really_probe) from [<c06b1e58>] (driver_probe_device+0x78/0x1dc)
> [    6.713731] [<c06b1e58>] (driver_probe_device) from [<c06b236c>] (device_driver_attach+0x58/0x60)
> [    6.722571] [<c06b236c>] (device_driver_attach) from [<c06b2470>] (__driver_attach+0xfc/0x160)
> [    6.731149] [<c06b2470>] (__driver_attach) from [<c06af85c>] (bus_for_each_dev+0x68/0xb4)
> [    6.739294] [<c06af85c>] (bus_for_each_dev) from [<c06b0b5c>] (bus_add_driver+0x158/0x214)
> [    6.747526] [<c06b0b5c>] (bus_add_driver) from [<c06b3314>] (driver_register+0x78/0x110)
> [    6.755585] [<c06b3314>] (driver_register) from [<c0102464>] (do_one_initcall+0x8c/0x430)
> [    6.763731] [<c0102464>] (do_one_initcall) from [<c11010e4>] (kernel_init_freeable+0x190/0x1e0)
> [    6.772397] [<c11010e4>] (kernel_init_freeable) from [<c0b4fc50>] (kernel_init+0x8/0x120)
> [    6.780542] [<c0b4fc50>] (kernel_init) from [<c010011c>] (ret_from_fork+0x14/0x38)
> 
> https://krzk.eu/#/builders/21/builds/2862/steps/15/logs/serial0
> 
> I did not do a bisect but the last commit touching these parts was:
> 
> commit 302c014726dbd9fcde852985528c139d2214a1f2
> Author: Viresh Kumar <viresh.kumar@linaro.org>
> Date:   Tue Jan 19 11:58:58 2021 +0530
>     opp: Prepare for ->set_opp() helper to work without regulators
> 
> Maybe you have some idea of cause?

t a/drivers/opp/core.c b/drivers/opp/core.c
index 1ed673334565..7c0e0e76a57e 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2038,7 +2038,7 @@ void dev_pm_opp_put_regulators(struct opp_table *opp_table)
                regulator_put(opp_table->regulators[i]);
 
        mutex_lock(&opp_table->lock);
-       if (opp_table->sod_supplies) {
+       if (opp_table->set_opp_data) {
                opp_table->set_opp_data->old_opp.supplies = NULL;
                opp_table->set_opp_data->new_opp.supplies = NULL;
        }

This shall fix it, sorry about that. I have pushed my branch again. Thanks.

-- 
viresh
