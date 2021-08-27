Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27B23F9323
	for <lists+linux-pm@lfdr.de>; Fri, 27 Aug 2021 05:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244204AbhH0Dsi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Aug 2021 23:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244187AbhH0Dsi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Aug 2021 23:48:38 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28ADC0613D9;
        Thu, 26 Aug 2021 20:47:49 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id r9so11554314lfn.3;
        Thu, 26 Aug 2021 20:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mpXjxvIYcEy4ADpjK9vIF0S9kMaNDgdoFqVAd5bO7Iw=;
        b=KdyypB+6Am6qAs4qdz7vTwwx+AxBiuxq1fTbjyGNHaoepzKOzfk70NRetORXz6ztyc
         Dl5LL0qJpggX7OnUTsoiTTpZ4ePVM/0qCkIZeH9YDgyVvG5+gbj1ONa3kGjcdRaDI6dd
         F0UKADDuvJi3OnfIXACgmMDxohyySrzouTYpbVI107R29dhtxZVDsAcrgIVllCor0IyL
         aAbADGk4zd79mSlP0M/o8BYAwKYcjSLtPH04jWBWUIkcziih6rjYdP75DK8492T7H62e
         bHUP6IKp+J+qeAFmJ/tIuXBexDtSshyO9345zF4LyUrsb5g5gsyBbRQdLz6uZ02F46Xg
         hrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mpXjxvIYcEy4ADpjK9vIF0S9kMaNDgdoFqVAd5bO7Iw=;
        b=R6Z1vjtw3D/MnAiWHoOgIouHo3AZgF+IBHp+7qpXLa089DcuM+s+bDD3S4VW6107tO
         BIlDzdMbTwwq87ZsyQTJjFpDJe11cFCDPwUezawKw+qNrweYSW2H9e4gu8p0lqc3i9f1
         Ih7KIAbSC6ONAy0tHrFpNpzVHTyDStTzGrV0DvPx5trOlHaqyiunjdaHlOBKnHNNnqT+
         YKscsTc5+WqNSaPGycwXE8/LFYWFHQiTgmagH6E/jQXnYAFe5uq6oOMp3hSXUWb5YqWf
         ePw33Ts0qDuqaa1rfwVsHIkUOtcGYVVyHIQWDBg2yMg62UzY+K5QjOOp2sKG0bNFkP9j
         dTWA==
X-Gm-Message-State: AOAM530d5BBGSdG6QSZNTmg7q+qMEBEoMHoRGZZUQj6NRrWoRMYXafBX
        Huo7CZd2ZtIZbW2OTBXN+ecckFD5L6M=
X-Google-Smtp-Source: ABdhPJyoKv+cAyf/aUHZ+gX+pYFqcqjGRRU9oxUN8YOzld4f2K1SFdf2nUjKFG9GhaNRUxNoOqykEg==
X-Received: by 2002:a05:6512:118b:: with SMTP id g11mr5059468lfr.205.1630036067944;
        Thu, 26 Aug 2021 20:47:47 -0700 (PDT)
Received: from [192.168.2.145] (94-29-17-251.dynamic.spd-mgts.ru. [94.29.17.251])
        by smtp.googlemail.com with ESMTPSA id k17sm515304lfv.200.2021.08.26.20.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 20:47:47 -0700 (PDT)
Subject: Re: [PATCH v9 5/8] soc/tegra: pmc: Implement get_performance_state()
 callback
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210827013415.24027-1-digetx@gmail.com>
 <20210827013415.24027-6-digetx@gmail.com>
 <20210827030557.aymjkky7athjxpow@vireshk-i7>
 <9c2287ca-4c51-d782-a0a5-4b1227c2e9db@gmail.com>
Message-ID: <7aca6da3-89a7-a4a6-c720-8be4a105a696@gmail.com>
Date:   Fri, 27 Aug 2021 06:47:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9c2287ca-4c51-d782-a0a5-4b1227c2e9db@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.08.2021 06:28, Dmitry Osipenko пишет:
> 27.08.2021 06:05, Viresh Kumar пишет:
>> On 27-08-21, 04:34, Dmitry Osipenko wrote:
>>> +	clk_opp_table = dev_pm_opp_set_clkname(dev, NULL);
>>> +	if (IS_ERR(clk_opp_table)) {
>>> +		dev_err(dev, "failed to set OPP clk: %pe\n", clk_opp_table);
>>> +		ret = PTR_ERR(clk_opp_table);
>>> +		goto put_hw;
>>> +	}
>>
>> Why do you need to do it ? OPP core already does this automatically.
> 
> Indeed, thanks.
> 

Actually, it doesn't work.

The devm_tegra_core_dev_init_opp_table() needs to set clk to support older device-tree and now OPP table already has clk being set.

WARNING: CPU: 2 PID: 92 at drivers/opp/core.c:2146 dev_pm_opp_set_clkname+0x97/0xb8
Modules linked in:
CPU: 2 PID: 92 Comm: kworker/u8:1 Tainted: G        W         5.14.0-rc7-next-20210826-00181-g6389463cbb0a #9318
Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
Workqueue: events_unbound deferred_probe_work_func
[<c010cc91>] (unwind_backtrace) from [<c0108d35>] (show_stack+0x11/0x14)
[<c0108d35>] (show_stack) from [<c0a6c1bd>] (dump_stack_lvl+0x2b/0x34)
[<c0a6c1bd>] (dump_stack_lvl) from [<c011fc47>] (__warn+0xbb/0x100)
[<c011fc47>] (__warn) from [<c0a696e3>] (warn_slowpath_fmt+0x4b/0x80)
[<c0a696e3>] (warn_slowpath_fmt) from [<c07407b3>] (dev_pm_opp_set_clkname+0x97/0xb8)
[<c07407b3>] (dev_pm_opp_set_clkname) from [<c07407e3>] (devm_pm_opp_set_clkname+0xf/0x64)
[<c07407e3>] (devm_pm_opp_set_clkname) from [<c050735b>] (devm_tegra_core_dev_init_opp_table+0x23/0x144)
[<c050735b>] (devm_tegra_core_dev_init_opp_table) from [<c05aad09>] (gr3d_probe+0x111/0x348)
[<c05aad09>] (gr3d_probe) from [<c05ba69b>] (platform_probe+0x43/0x84)
[<c05ba69b>] (platform_probe) from [<c05b8c01>] (really_probe.part.0+0x69/0x200)
[<c05b8c01>] (really_probe.part.0) from [<c05b8e0b>] (__driver_probe_device+0x73/0xd4)
[<c05b8e0b>] (__driver_probe_device) from [<c05b8ea1>] (driver_probe_device+0x35/0xd0)
[<c05b8ea1>] (driver_probe_device) from [<c05b92a9>] (__device_attach_driver+0x75/0x98)
[<c05b92a9>] (__device_attach_driver) from [<c05b769d>] (bus_for_each_drv+0x51/0x7c)
[<c05b769d>] (bus_for_each_drv) from [<c05b908f>] (__device_attach+0x8b/0x104)
[<c05b908f>] (__device_attach) from [<c05b81b3>] (bus_probe_device+0x5b/0x60)
[<c05b81b3>] (bus_probe_device) from [<c05b5d9f>] (device_add+0x293/0x65c)
[<c05b5d9f>] (device_add) from [<c0777a4f>] (of_platform_device_create_pdata+0x63/0x88)
[<c0777a4f>] (of_platform_device_create_pdata) from [<c0777b7d>] (of_platform_bus_create+0xfd/0x26c)
[<c0777b7d>] (of_platform_bus_create) from [<c0777dc5>] (of_platform_populate+0x45/0x84)
[<c0777dc5>] (of_platform_populate) from [<c0777e5d>] (devm_of_platform_populate+0x41/0x6c)
[<c0777e5d>] (devm_of_platform_populate) from [<c05490f9>] (host1x_probe+0x1e9/0x2c8)
[<c05490f9>] (host1x_probe) from [<c05ba69b>] (platform_probe+0x43/0x84)
[<c05ba69b>] (platform_probe) from [<c05b8c01>] (really_probe.part.0+0x69/0x200)
[<c05b8c01>] (really_probe.part.0) from [<c05b8e0b>] (__driver_probe_device+0x73/0xd4)
[<c05b8e0b>] (__driver_probe_device) from [<c05b8ea1>] (driver_probe_device+0x35/0xd0)
[<c05b8ea1>] (driver_probe_device) from [<c05b92a9>] (__device_attach_driver+0x75/0x98)
[<c05b92a9>] (__device_attach_driver) from [<c05b769d>] (bus_for_each_drv+0x51/0x7c)
[<c05b769d>] (bus_for_each_drv) from [<c05b908f>] (__device_attach+0x8b/0x104)
[<c05b908f>] (__device_attach) from [<c05b81b3>] (bus_probe_device+0x5b/0x60)
[<c05b81b3>] (bus_probe_device) from [<c05b8493>] (deferred_probe_work_func+0x57/0x78)
[<c05b8493>] (deferred_probe_work_func) from [<c0136f73>] (process_one_work+0x147/0x3f8)
[<c0136f73>] (process_one_work) from [<c0137759>] (worker_thread+0x21d/0x3f4)
[<c0137759>] (worker_thread) from [<c013c10f>] (kthread+0x123/0x140)
[<c013c10f>] (kthread) from [<c0100135>] (ret_from_fork+0x11/0x1c)
---[ end trace f68728a0d3053b54 ]---
tegra-gr3d 54180000.gr3d: tegra-soc: failed to set OPP clk: -16
