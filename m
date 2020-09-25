Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B61D278573
	for <lists+linux-pm@lfdr.de>; Fri, 25 Sep 2020 12:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgIYK6j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Sep 2020 06:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgIYK6i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Sep 2020 06:58:38 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA61C0613CE
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2020 03:58:38 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id md22so1213168pjb.0
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2020 03:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oAJrRFkjqiZjslJYlYFWCtkiFMgZCCH4FGFRNUlNi2M=;
        b=vRrDqE9P0tnL8nDtFvM0Q367Z5ymCaxjktdq5fuZXjTDLvHEZSytN4AIovAUQ86Ngf
         MFSf1MZNGY8+MRU3tuxCFlaKS/qQwMoqCe6gWMZGJGFZ0mTg7IiCW4c+qydrR6yszK01
         syhjxFQO6NbzbcCNUzEsW9fCvD44j+0iqI40DW5HUf/C7LjVMGrPGiMWE38ds8ZCwb+h
         Nms/SLE2q8Hjdmcgy8Sw2eeACFuzinCv2Xcc0l6HXO3DX2OTg0Kjxv81J+2fBjMIks+N
         yzoaXKqzRt4Zy3uIVkkeTgb1Y+JbW0onSo8SpqtUyIsjIWpHR2z4iNnIU4UeReWlBgFu
         4L5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oAJrRFkjqiZjslJYlYFWCtkiFMgZCCH4FGFRNUlNi2M=;
        b=TMlU+hFpTJDK7CBPBwh3PogmTJaq6Ck4a5fdsxygVsxsMv7+L1Gnlhk0nbO7Ua38pf
         lzutf30hWR9u24h7yTBEAFvfd/7TgB0lew4vF+oid3Z7ryE/otWReAV/X+qe4dr3q2mo
         NZT9QKtkWW3Ldjk1oHUN29NXLkfkRdJ9FeSD+zomMpQq9zDo5nz6CaKB4gPy5Vprz/4c
         SYu4tOPfD8N/iMduWMTcgSipwopb5xr538zQkB3Mer7SlyqLukmyxhlNBFl8yQGAqZmZ
         4EhUSNo6u4ubTo0ftkN+dMn7nKsycgUVW19klTHuA6QOelOoIi4R3guKBnWvSm2HqPn9
         D4fg==
X-Gm-Message-State: AOAM531AsX02iyaoirF3t5CpSEa+iadVy3T/KX8vc6BS+bFnKXtdhugB
        r5EyTTqtjE8PkJO3QP5PEl1XCA==
X-Google-Smtp-Source: ABdhPJwZFpFShelf2IuBLECWnc8DtK9yg/mtTTI8N/aWHMtli1doBnI/KO23D/dvCAYIQu2DZz26Sw==
X-Received: by 2002:a17:90b:1649:: with SMTP id il9mr2115322pjb.50.1601031518092;
        Fri, 25 Sep 2020 03:58:38 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id w19sm2384717pfq.60.2020.09.25.03.58.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Sep 2020 03:58:37 -0700 (PDT)
Date:   Fri, 25 Sep 2020 16:28:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, cristian.marussi@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 1/4] cpufreq: stats: Defer stats update to
 cpufreq_stats_record_transition()
Message-ID: <20200925105830.xsmiwkjohlqb5joj@vireshk-i7>
References: <cover.1600238586.git.viresh.kumar@linaro.org>
 <31999d801bfb4d8063dc1ceec1234b6b80b4ae68.1600238586.git.viresh.kumar@linaro.org>
 <CAJZ5v0i0aW6jT=DD6ogyfr+bs5LZu7Gn+5A9O_bZxNsnHPojOQ@mail.gmail.com>
 <20200924131543.eury5vhqy3xt35v6@vireshk-i7>
 <CAJZ5v0g8Bmxt=GEKcNrKjY1cHnsURV5oe3+n1R2+U_2VJnwfRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g8Bmxt=GEKcNrKjY1cHnsURV5oe3+n1R2+U_2VJnwfRQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25-09-20, 12:04, Rafael J. Wysocki wrote:
> I'm actually wondering if reset_time is necessary at all.
> 
> If cpufreq_stats_record_transition() is the only updater of the stats,
> which will be the case after applying this series IIUC, it may as well
> simply set the new starting point and discard all of the data
> collected so far if reset_pending is set.
> 
> IOW, the time when the reset has been requested isn't particularly
> relevant IMV (and it is not exact anyway), because the user is
> basically asking for discarding "history" and that may very well be
> interpreted to include the current sample.

There are times when this would be visible to userspace and won't look nice.

Like, set governor to performance, reset the stats and after 10 seconds, read
the stats again, everything will be 0. Because cpufreq_stats_record_transition()
doesn't get called at all here, we would never clear them until the time
governor is changed and so we need to keep a track of reset-time.

-- 
viresh
