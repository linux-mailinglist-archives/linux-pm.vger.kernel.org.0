Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3984F3F9360
	for <lists+linux-pm@lfdr.de>; Fri, 27 Aug 2021 06:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbhH0EDb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Aug 2021 00:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbhH0EDb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Aug 2021 00:03:31 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6577C0613CF
        for <linux-pm@vger.kernel.org>; Thu, 26 Aug 2021 21:02:42 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 17so4932404pgp.4
        for <linux-pm@vger.kernel.org>; Thu, 26 Aug 2021 21:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hLrtFA0n4d6s/6H9+lblwygH3Pl36UsMgSrW5jepzk8=;
        b=ELk12qRZJfSnGoPjx3E4eqsXlFaa8DfCcuSNNopE/v18D8zKZYXJSdg4+eW/IxUy5v
         qKJUMwKf8hN3JrrK0ZB3Wm1PWFRf7LePF0v2ZIg5YaCpWea7IHCxth0Nf4UmpaAnThxm
         re41ZAqsWW6a/EuNcrih+kJmFCCGtE4xesJng9QfWkGv65owPaCwoEu7rAYm9LIBAYjr
         +VUkkjdawbTbXoPbmOX6DfgpzueZTVeT1Ot+2xFdZZFCEgheO/Frpj1KhlFJUyfKbvEM
         Q91+7dFSQxFCZyrAh0CaSshcoatDdywvL7cPoI1wpoTw5NKzvA5+lZvhusqQLsyKE+7y
         HRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hLrtFA0n4d6s/6H9+lblwygH3Pl36UsMgSrW5jepzk8=;
        b=bkJk38buA23tdi58yeAFwBFLrnxH3jWcUxhgTJvVxO3OKYXUtctrvrIHvIkw7AdsMr
         zBiv7Mns8kqTxsXH6O7GklJaU8sE1PEOyiob5bmIBjXzY0y3uNr+JEM2i32pe0Bo1Jnl
         XyFVFFWizhDyJ0gbcWJDvw3f5WjS5mzQEEN2HbPU+0SGfOCSIhsSf2Oo+G9TfEA2Q6L7
         uyxsemPTqlDzHC4xMogIpPE1L+6eD02bG3HScbqBReRqsRrBvnE+ZZdGvFB046KZ33mu
         Qga2UzVRXCvcuXRI+hn4kXOeFTRdVq/WdthOqZJkvo9V5BuotDILyq47rAO3QC8ovPmr
         G6Pg==
X-Gm-Message-State: AOAM5322k1AIdUfr28ywSh6gutExqj+EXDqm6TVkbmGukQT6pn79QHTD
        6eOXN6cYB3JpqYMSqkUpClAQTQ==
X-Google-Smtp-Source: ABdhPJyl2DoV12OpHAr1SMImzJ31VQ0pw2+MjmrPdJKeTlAv2fMmEDksaP2mCchCf+ecrWh0y4dwog==
X-Received: by 2002:a65:6183:: with SMTP id c3mr6183876pgv.73.1630036962333;
        Thu, 26 Aug 2021 21:02:42 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id h127sm4362150pfe.191.2021.08.26.21.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 21:02:41 -0700 (PDT)
Date:   Fri, 27 Aug 2021 09:32:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v9 5/8] soc/tegra: pmc: Implement get_performance_state()
 callback
Message-ID: <20210827040239.roal5jpndamzotle@vireshk-i7>
References: <20210827013415.24027-1-digetx@gmail.com>
 <20210827013415.24027-6-digetx@gmail.com>
 <20210827030557.aymjkky7athjxpow@vireshk-i7>
 <9c2287ca-4c51-d782-a0a5-4b1227c2e9db@gmail.com>
 <7aca6da3-89a7-a4a6-c720-8be4a105a696@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7aca6da3-89a7-a4a6-c720-8be4a105a696@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-08-21, 06:47, Dmitry Osipenko wrote:
> Actually, it doesn't work.
> 
> The devm_tegra_core_dev_init_opp_table() needs to set clk to support older device-tree and now OPP table already has clk being set.
> 
> WARNING: CPU: 2 PID: 92 at drivers/opp/core.c:2146 dev_pm_opp_set_clkname+0x97/0xb8
> Modules linked in:
> CPU: 2 PID: 92 Comm: kworker/u8:1 Tainted: G        W         5.14.0-rc7-next-20210826-00181-g6389463cbb0a #9318
> Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
> Workqueue: events_unbound deferred_probe_work_func
> [<c010cc91>] (unwind_backtrace) from [<c0108d35>] (show_stack+0x11/0x14)
> [<c0108d35>] (show_stack) from [<c0a6c1bd>] (dump_stack_lvl+0x2b/0x34)
> [<c0a6c1bd>] (dump_stack_lvl) from [<c011fc47>] (__warn+0xbb/0x100)
> [<c011fc47>] (__warn) from [<c0a696e3>] (warn_slowpath_fmt+0x4b/0x80)
> [<c0a696e3>] (warn_slowpath_fmt) from [<c07407b3>] (dev_pm_opp_set_clkname+0x97/0xb8)
> [<c07407b3>] (dev_pm_opp_set_clkname) from [<c07407e3>] (devm_pm_opp_set_clkname+0xf/0x64)
> [<c07407e3>] (devm_pm_opp_set_clkname) from [<c050735b>] (devm_tegra_core_dev_init_opp_table+0x23/0x144)

Why are you calling this anymore ?

-- 
viresh
