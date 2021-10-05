Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06828421D6A
	for <lists+linux-pm@lfdr.de>; Tue,  5 Oct 2021 06:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbhJEE1X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 00:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbhJEE1V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 00:27:21 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AB9C061745
        for <linux-pm@vger.kernel.org>; Mon,  4 Oct 2021 21:25:31 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id y5so1406409pll.3
        for <linux-pm@vger.kernel.org>; Mon, 04 Oct 2021 21:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cJ4r8bXgEb5jKjVNnDvod4XPSiNRHdxIF6FJQ8qHJbE=;
        b=ztI9W9MEhRnIlg53CngDGMzbJG+2l/nTMF+hjvCOAvw8aGY0Z7J86Epfnlc5aSqBNF
         ymQlgrtpZxIkNtjCP/RLIiI+Ff7IO+WTD1n7yCeTu21undHEPz7eZ/7zb0epqQ0mpj3d
         W8/NDiqqv16f+vP07vGXAgOgc+2T7ZiHMjNTayD23v/qTk1dI5Tgl1l+AP/gUPXqypk4
         zaixj0E9CFZQqSxOkfVQBfc9R6yxv+J+3syE2DCxBwq5K2I/eVZR1DOePbJToET/VYgx
         /6J4Rec+wAq3uKzsBBIk/XTAA8Jr+/HtcVjGbXrtP2ula1rvjzHR/qMqYug2T/XSkTv7
         cfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cJ4r8bXgEb5jKjVNnDvod4XPSiNRHdxIF6FJQ8qHJbE=;
        b=giUhInknvO4SLQRq3mfxNoGHVqSD0u3eYTDPLvEHYj+lSNfCtiG7cOD0HqL20wf17J
         YNXQFngggLqk4dWWDHStOO3e4+3mbHLSyCG/nKIsZqzocDw1QlkZrpH6ez66dsP490Vm
         vjJbPutCZkJSPIW5ljAv8+XenECULhom+OJU8K/qPfX1SqUy7ivdUEBM8j1KAm6+H7nM
         To3COE5HauRoUmq/zAzoAM5TYVq6NOhQs+YC8+5KVNfTFzlAYSUyYlwgYpAKLT0qRIGo
         rxZyXqeDuVJmoiUWDUhASbBvIQMu7DN8J5w415N3U8x0Z7+eFLTIdjeTghTvaJ3MBLuT
         oASw==
X-Gm-Message-State: AOAM53204JFvR8d7TJQO18cIlFtz4qTmweAUh9TfliarXYhZoJ8IKrXy
        CWTcuba2498310tk9/VamdjeDA==
X-Google-Smtp-Source: ABdhPJwU0v+nT2RDODXfs6zoCAuNaRXJikpcU8BiZ8Yw0UkMCT/BK0v/kgJClwGqtBNo90wdJ4/JVg==
X-Received: by 2002:a17:90a:d3cb:: with SMTP id d11mr1192295pjw.109.1633407930894;
        Mon, 04 Oct 2021 21:25:30 -0700 (PDT)
Received: from localhost ([122.171.247.18])
        by smtp.gmail.com with ESMTPSA id e6sm296214pfm.212.2021.10.04.21.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 21:25:30 -0700 (PDT)
Date:   Tue, 5 Oct 2021 09:55:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Make probe() of Tegra devfreq driver completely
 resource-managed
Message-ID: <20211005042526.mklgm4yzeiu6s7jv@vireshk-i7>
References: <20210920172249.28206-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920172249.28206-1-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-09-21, 20:22, Dmitry Osipenko wrote:
> This series adds new resource-managed helpers and makes Tegra devfreq
> driver to use them, improving the driver's error-handling code.
> 
> Changelog:
> 
> v2: - Added WARN_ON() to devm_devfreq_remove_governor() and moved
>       devm_devfreq_add_governor() as was requested by Chanwoo Choi.
> 
>     - Added ack from Chanwoo Choi to the "Check whether clk_round_rate()
>       returns zero rate" patch.
> 
> Dmitry Osipenko (4):
>   opp: Add more resource-managed variants of dev_pm_opp_of_add_table()
>   PM / devfreq: Add devm_devfreq_add_governor()
>   PM / devfreq: tegra30: Use resource-managed helpers
>   PM / devfreq: tegra30: Check whether clk_round_rate() returns zero
>     rate

Applied. Thanks.

-- 
viresh
