Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E4534376E
	for <lists+linux-pm@lfdr.de>; Mon, 22 Mar 2021 04:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhCVDaM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Mar 2021 23:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhCVD3u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Mar 2021 23:29:50 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD976C061574
        for <linux-pm@vger.kernel.org>; Sun, 21 Mar 2021 20:29:49 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id f10so651171pgl.9
        for <linux-pm@vger.kernel.org>; Sun, 21 Mar 2021 20:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uq4SneBuWqy+lUF6T8xTTgMo/6XkxfbryoI8WB05pxU=;
        b=FTISIwRwvhVQUfTYcU63NBnyCIdv+bVG66b/CmuqIpl1A54ighNltvB7wSA2krSSZy
         UT17VLez2HeXHf1yzM5uae/SwOcKoaBI5rMbHXz2x34UnUIJwkl3yfZ4PgIuXBdaSfB/
         +sW2oPp6zjL2kV8XBZG/iQbXHVivWACdwfbfap89K53BY226ZtP7e9G+YAs1eWS/Op5I
         s5edDOLGrDb+lX0Ebtm5IUoiE2xAx9iNgDlizJw+4QyabbTDAiDFs/EgTNT63q3wdWmj
         Ip9cXcwJc9UdCdNvUTJhm3PBFhM8ui/bkPwiC5SY99tdWJpmyDaBDHIaXpHGgRglJJzE
         CIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uq4SneBuWqy+lUF6T8xTTgMo/6XkxfbryoI8WB05pxU=;
        b=c6gYdHznUgzcqxifFHSsrCa2QqSxqFOUU5ESaDWPwZk+Yxx4txPwSq13iIYv48vAPP
         ID9sMhYogR6U1jxMIYN1u7fWMEp4W1Y1w+3vZZvXCjYbw/Bw1U9uR+8s9hkn2aOYxzcX
         VgslcXldriYEvK7gUn/buUGdwRhqGhmdS/TN6KPl80VT2tJTJqkArAHGBy08hjGM1nol
         ewc1kvouy0DQFZuhMCSl6UaYGc1FVKo/VeMj2nWCWzh/q71TFMX73TMXkBm18QJ02A2R
         AIfJmUQxbf5HHqlM19CQtbQFzlWer6QSXVwLHRg93i6wZkn++1bPiYX4Qrpa2Bd1mNws
         pONA==
X-Gm-Message-State: AOAM5338yzJjNcxg2fuZw8TTSwfdkstGULO80LqwrNRQchrjTcdf/r5A
        ZgmX2q5FlC94TONF0Y2VBZxbHw==
X-Google-Smtp-Source: ABdhPJzGov0fSQVcZxAj7skIU7KOaxbwrDE+AEmgIWVLtlZBnaD7GYi8MP949x4MkEMRAX2UlPzx9Q==
X-Received: by 2002:a63:ea50:: with SMTP id l16mr20465857pgk.442.1616383789330;
        Sun, 21 Mar 2021 20:29:49 -0700 (PDT)
Received: from localhost ([122.172.6.13])
        by smtp.gmail.com with ESMTPSA id t10sm12041478pjf.30.2021.03.21.20.29.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Mar 2021 20:29:48 -0700 (PDT)
Date:   Mon, 22 Mar 2021 08:59:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thermal/drivers/cpuidle_cooling: Fix use after error
Message-ID: <20210322032946.jstyrnc6dctq4fzj@vireshk-i7>
References: <YFMpUDNGIiLOzr0/@mwanda>
 <20210319202522.891061-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319202522.891061-1-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-03-21, 21:25, Daniel Lezcano wrote:
> When the function successfully finishes it logs an information about
> the registration of the cooling device and use its name to build the
> message. Unfortunately it was freed right before:
> 
> drivers/thermal/cpuidle_cooling.c:218 __cpuidle_cooling_register()
> 	warn: 'name' was already freed.
> 
> Fix this by freeing after the message happened.
> 
> Fixes: 6fd1b186d900 ("thermal/drivers/cpuidle_cooling: Use device name instead of auto-numbering")

Why not merge this with the Fixes patch itself since it isn't there in Linus's
tree yet ?

Or is your branch strictly immutable ?

-- 
viresh
