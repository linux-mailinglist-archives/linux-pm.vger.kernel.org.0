Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB7A3FD333
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 07:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242002AbhIAFra (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 01:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbhIAFr3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 01:47:29 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34782C061575;
        Tue, 31 Aug 2021 22:46:33 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x27so4019043lfu.5;
        Tue, 31 Aug 2021 22:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7hRPX2dZswgsfHn1YLjeDaSIlOhVuOR93qiJSB96BN8=;
        b=uM7mCPdZWbjo9We9gk9bs3YDzJd/dn5hLXnWhFrMcvSeMphQBzz5E9SWhxzZ2sJkZZ
         xIXE/LY4sGKgw0rk/l+i0gIRSZlvF3n5STTEps54w3qnluO4Y8UiAS4pWV/UZ6picKtE
         9a4HAuNiheFiJLCXiUb9PBUR4p84pk4FtuWayMc+Gib0Z7aP3VGdrI/O96IJQEyZqxJ/
         1EdV2XBMVGgneOA2ARgl7OA5DSe+dFYpvhcDSBQ45qceTvaMoRsmdhQoIudLuKQo+t8f
         wagdE/1/KWnnw0wLryzVUpIAcKLHFWz4v3B6BZkJ50jKgy8lOpo+d5BC8kGF8ObESlQP
         TigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7hRPX2dZswgsfHn1YLjeDaSIlOhVuOR93qiJSB96BN8=;
        b=mnwxXeaRDzR6QeqRZtOIVNWIUva/3g0n06WUHz/geTtzT/zwzdMyHvqTwHb/Jk/Qo8
         piXjp+yjTOdOQfdrLFfNu5zfYYxJyiM33meTO8Xf8/dWOUNq9LlRu9LGP9FucGyYns16
         5YgIrTCB8lSCmRx0A6KJjXP+FVP2CsiFNerRyFsKi+cWqWUohS39zy1zwEMM5TrI1wtQ
         K1TZd7GxmRT2LuybmKDgw0h/T82DE++lS+vBjyUQ9ttiK7tatP99VtkKj/ITgSFbF8Lg
         yVBc/bEwg4oGouZZJH6CQruywu7RIIbacq/WH544SxGIRLEiBEHDy+1izSFTV9gHa72w
         wRvg==
X-Gm-Message-State: AOAM5327uJxvmq2JxbOITvbOgqaUhlkTPiwMcIqcRXl8dj0lZ4TgeG5Y
        DLRAfe1miDQljW5XRuFjwXFn1JkeNOA=
X-Google-Smtp-Source: ABdhPJzqfB1IavgEmOYEH0Pth4rYnyIB9Dlcg9NuqlXETLTG328MQjEVQe63D0kwcU/LUyaJpt1SRg==
X-Received: by 2002:ac2:4c41:: with SMTP id o1mr4082926lfk.52.1630475191480;
        Tue, 31 Aug 2021 22:46:31 -0700 (PDT)
Received: from [192.168.2.145] (46-138-26-37.dynamic.spd-mgts.ru. [46.138.26.37])
        by smtp.googlemail.com with ESMTPSA id g38sm2109328lfv.210.2021.08.31.22.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 22:46:31 -0700 (PDT)
Subject: Re: [PATCH v10 2/8] opp: Allow dev_pm_opp_set_clkname() to replace
 released clock
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
References: <20210831135450.26070-1-digetx@gmail.com>
 <20210831135450.26070-3-digetx@gmail.com>
 <20210901044235.2je35y3ajtctrall@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <6010b244-4260-8ae9-2b8a-7fd689781d36@gmail.com>
Date:   Wed, 1 Sep 2021 08:46:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210901044235.2je35y3ajtctrall@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

01.09.2021 07:42, Viresh Kumar пишет:
> On 31-08-21, 16:54, Dmitry Osipenko wrote:
>> The opp_table->clk is set to error once clock is released by
>> dev_pm_opp_put_clkname(). This doesn't allow to set clock again,
> 
> I am not sure why are you required to set the clk again here ? I mean,
> users aren't expected to put clkname in the middle of using it. The
> set-name API also checks that the OPP list should be empty in such a
> case.

I added explanatory comment to tegra_pmc_pd_dev_get_performance_state(),
isn't it enough?
