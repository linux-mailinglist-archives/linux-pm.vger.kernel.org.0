Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A9D323783
	for <lists+linux-pm@lfdr.de>; Wed, 24 Feb 2021 07:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbhBXGsM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Feb 2021 01:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbhBXGsK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Feb 2021 01:48:10 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F413C061786
        for <linux-pm@vger.kernel.org>; Tue, 23 Feb 2021 22:47:30 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id s16so604470plr.9
        for <linux-pm@vger.kernel.org>; Tue, 23 Feb 2021 22:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+PKX1tqPNykmedfrh7em0CF5LOPt6T508fmuoJN2TMc=;
        b=CzUNH0mcsK2VYUb6BlIDTpdruzzV9hgZ7pzA3qwzBw9VL/+cDMcKHb0so0C+WULTDX
         z7mF1MrfVG8yEaqFUe6Zc6s/SVjdQMXoZkxFKZ/F0hZX8ME2jylYxx2UwHlhXkyvdlzU
         GPWsX8RzPqO/R3dOD0+NnEXa4lKOuUY9KHB8ADOhFdeJtNSxHRFq05Ek3Q2jhmHUICzr
         O27elcMSCW6Zhu0FVHfD2mah1v+U7JRuaH9raMMIK0Kbow4xk91qD+XkGqS+brli1hZ3
         vIC2tfCfTeee3RKm7ocmz++EP5HHdzYepNVcdxtnYskiZDILRRLZzxX1NHWjv4Xz65uu
         TvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+PKX1tqPNykmedfrh7em0CF5LOPt6T508fmuoJN2TMc=;
        b=l2xU0DfnggnLsjycOIx9SNZI/EEq3KWce6BUO05qYa4W63gLx2ajaunBvQZG0I48g5
         kbbvbNo9oZ4VAHH+OcnMk/pQRvjqBvKZgHuKEi0RXugpsV7NYTAmmjYJwZR4hRA8V81Z
         Z+PwAdq/pr9oQAnAP7kOouqHrqY2PknvPWLxVo1HRuX2nYKznBYHDrT4geSdMJmJj5Do
         i9OJ0xS/aPvNd0BR2B4y70/0X1VGNReobkHMujyPs3IC0wqDcsGcxdEAbEkit5it97W0
         SN1Mc762Nli6QgMgOrcPJvVhzEsx69TtrYFS1rDn/QFO7gABssV9mq+nhzke2M4+wQyI
         pHGQ==
X-Gm-Message-State: AOAM533j1OnYbf1K/QLMg1hffncIpRsnffZE/CwZ92lzbWDG6EwE9urK
        LqbiTOeapqvgbft6qHOAUbzFdw==
X-Google-Smtp-Source: ABdhPJz6Dk3s1Gw6sa1nNnIeOrqnDYKbwsJL4/3Swc6qtxdROyA91KUJSwX1PNgDgkShE/q2MSpVYA==
X-Received: by 2002:a17:902:c702:b029:e3:cb6b:5e59 with SMTP id p2-20020a170902c702b02900e3cb6b5e59mr23521579plp.71.1614149249889;
        Tue, 23 Feb 2021 22:47:29 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id y202sm1455478pfb.153.2021.02.23.22.47.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2021 22:47:29 -0800 (PST)
Date:   Wed, 24 Feb 2021 12:17:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     rjw@rjwysocki.net, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH v2] cpufreq: schedutil: Call sugov_update_next_freq()
 before check to fast_switch_enabled
Message-ID: <20210224064727.w3w4b66jnsmcxdff@vireshk-i7>
References: <20210224063927.1298-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224063927.1298-1-zbestahu@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24-02-21, 14:39, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Note that sugov_update_next_freq() may return false, that means the
> caller sugov_fast_switch() will do nothing except fast switch check.
> 
> Similarly, sugov_deferred_update() also has unnecessary operations
> of raw_spin_{lock,unlock} in sugov_update_single_freq() for that case.
> 
> So, let's call sugov_update_next_freq() before the fast switch check
> to avoid unnecessary behaviors above. Accordingly, update interface
> definition to sugov_deferred_update() and remove sugov_fast_switch()
> since we will call cpufreq_driver_fast_switch() directly instead.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
> v2: remove sugov_fast_switch() and call cpufreq_driver_fast_switch()
>     directly instead, also update minor log message.
> 
>  kernel/sched/cpufreq_schedutil.c | 29 ++++++++++++-----------------
>  1 file changed, 12 insertions(+), 17 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
-- 
viresh
