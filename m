Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA5E1E4C7A
	for <lists+linux-pm@lfdr.de>; Wed, 27 May 2020 19:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388607AbgE0R5H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 May 2020 13:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387653AbgE0R5G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2020 13:57:06 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104C9C03E97D;
        Wed, 27 May 2020 10:57:06 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z13so20366038ljn.7;
        Wed, 27 May 2020 10:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l4NpTDexV8NESh3eG0B8gFwKIHqu0TSUXXYRfhGYw7Y=;
        b=b+B6T+tBvfzagYHPLXBQNz8SCjxiQkUWkDAaKG0p0w291UMQEAvZHxegetvnU3L7e+
         B05xBzx9hfsr/9mYjUBl3SCsr4UsO4gBKG9HiLRBHerPk7RI+0YVH1nIfhvgZwqSV0gn
         IWm0mzjFkedkZL8TjkmrIXq1Xow47cv6BtTlJlDhczotmg07MPPcXNKiA4vtl5H/gPeh
         D06dSyaRBKsTEcLilqgxHYGw+y0ivMTHkKu4MPXa7fJmYW/9IgcwJAtoCJyvl3bOQCHb
         vzXvrjLWQ6mx9XFAT4j45AkHTyVQLLZ3kP0wCCmydB9x1eO4pCU+ImVKjaebHXCvPjSu
         rMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l4NpTDexV8NESh3eG0B8gFwKIHqu0TSUXXYRfhGYw7Y=;
        b=CmblZwB2HwxXrK2vnf7/WVzeJiAF+JUOe0yh3x+KHaJN/7yq/bF0FHUNaApOdxa9Cf
         QbIM8qZhDj+F/EcOqWDRMcGNmkeAp3eIYqR9+/yaxuBasjsRoMTeDhOOSN4KGrV5mPCQ
         //+I9H5dH4sJDVNjUzhH/kYyeqqX5QXX8jBVUE01zgHbc9IBg2XS65XWqjPKQEmcEvZ5
         MurKrn3I1ITyGlth5pGniuZfQCa8o+lDqqOwG+tcSMkMclbDAkUseLzcDzVA2qQaZBt/
         zUPiCuS2twkOensfx76h7M6PsQ1yzbjUkY1aPKTYwB/IqoFBFGGN7xeGpLOLJsmLlNIK
         brdQ==
X-Gm-Message-State: AOAM531OgLOlt/1aH9tzzMXmIrivRIbFjNVrJpdQ2cJha32OKsLvCHjf
        /LRxH/ny58TJD684vJ51JwpxpsKg
X-Google-Smtp-Source: ABdhPJyqLNLcb7qoReLMeZMoVIOzAmQUlY1fXb7b0/Yec6i4WzKF+DVENYGIIo/mdHTuhx2vw5WHiA==
X-Received: by 2002:a2e:860f:: with SMTP id a15mr3322870lji.197.1590602224226;
        Wed, 27 May 2020 10:57:04 -0700 (PDT)
Received: from [192.168.2.145] (109-252-173-94.dynamic.spd-mgts.ru. [109.252.173.94])
        by smtp.googlemail.com with ESMTPSA id s9sm819212ljc.43.2020.05.27.10.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 10:57:03 -0700 (PDT)
Subject: Re: [PATCH v1 2/5] clk: Introduce clk_round_rate_unboundly()
To:     Stephen Boyd <sboyd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200330231617.17079-1-digetx@gmail.com>
 <20200330231617.17079-3-digetx@gmail.com>
 <159055894944.88029.2029223648098859689@swboyd.mtv.corp.google.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3fcac59c-7a37-d4af-9d12-710d7af05845@gmail.com>
Date:   Wed, 27 May 2020 20:57:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <159055894944.88029.2029223648098859689@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.05.2020 08:55, Stephen Boyd пишет:
> Quoting Dmitry Osipenko (2020-03-30 16:16:14)
>> In same cases it may be desired to round clock's rate without taking into
>> account current min/max requests made by the clock's users. One example is
>> building up OPP table based on a possible clock rates.
> 
> Shouldn't the OPP table come from firmware/DT? I don't quite understand
> why we're generating OPP tables on top of the rate rounding API.
> clk_round_rate() is supposed to tell us what rate we'll get if we call
> clk_set_rate() with the same arguments. An unboundly version of that
> doesn't make sense. 

The OPP should come from the DT, but unfortunately DT and Tegra's
devfreq driver wasn't designed like that from the start, so it will take
some extra effort to re-do it properly now. I wanted to postpone that
effort a tad and get at least the basics upstreamed for the starter.

> I wonder if perhaps the clk provider should be populating OPP tables in
> this case? Or basically anything besides adding another clk consumer API
> to solve this problem. Who is the caller? Something later in this
> series?

I'll try to add a proper OPP table with freqs and voltages, will see how
it goes. We will need to do it sooner or later anyways. So perhaps it's
fine to drop the current approach with the clk_round_rate_unboundly()
and re-focus on a proper OPP implementation.

Thank you for getting back and replying to this topic :)
