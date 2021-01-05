Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE592EA882
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jan 2021 11:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbhAEKVp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jan 2021 05:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbhAEKVp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jan 2021 05:21:45 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61B5C061574
        for <linux-pm@vger.kernel.org>; Tue,  5 Jan 2021 02:21:04 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id b5so1435525pjk.2
        for <linux-pm@vger.kernel.org>; Tue, 05 Jan 2021 02:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xe2DWR863p/ehJmvzbGKL4NyY9ITEBhglpLpCkOqvTI=;
        b=dAnoDGk67+jXOymkiM/3lzfn+vIj19sRrKZQgJtB070QMCs6aHQnMkIBc2SlSK4yRn
         eoqV+5b4tj2MZ51CVT9bJT+HI3vHhPKD5/480tfJLjEJnWhIy/QWLK3ynrAFmTlE+Jw2
         glBj7/6hSwgo1adAfKlgtalBN0qwVckG4YecrCA+Dyg3AfpEkDsPtgIiaMAlA0BW2BcA
         thmAGHTyO4JdgCbOjqz97CuheLwg6JPKp9VOcgduN7i2UUldlg/EQq9Tb+fIKLywsiq/
         sHUk/cNI5k0R71zpG85NAs/83ceesQHqRusBqoaZx4UAuQE49aAT0jKZv2Aqj25H8GvF
         hbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xe2DWR863p/ehJmvzbGKL4NyY9ITEBhglpLpCkOqvTI=;
        b=B8U3q5bNnWF19LN7tz3nYvutczfCCA72OEXrasITKB87enm7Dbic+ruC03P6gMO9Rr
         amoQObr4POp++0dYeHoGreoCxTpzGMx2u0l7W+lq5l/Ng5GhjodGrU93kX/frpziOZMM
         fP3CEINDtzuuLn27l1Ft599AxoOjFbMCwU8lU/vekfIQVPO3QSnB5xndsJxtFTjET9eZ
         wr5znOv0VetB6me7BziekKiZHqXIp7ePAL1ECxRkJpVTJ98ui7MAvf9F2kP3QwrLYHL/
         eRC2Za8ktP0If3h7e70t9y64wTMF/qYX/5/uMg4AF7T0PkuYuJOnm4jdayhebAyANCZ/
         6Aag==
X-Gm-Message-State: AOAM533X8jOpEbV3wmugZSzL4VKTAsXXvQe1rfhc+bU2HnazogNUiByD
        aERczlfKOiZA0Kt/0PWCx1utEO6j1ihAow==
X-Google-Smtp-Source: ABdhPJyN+NE7fCLLM5l+9h0UEK4pikwYezv4FSBlWI57xzwoQk/6jMmP21onPESPO5+AWGZXovKpuw==
X-Received: by 2002:a17:90a:fa8e:: with SMTP id cu14mr3458820pjb.140.1609842064423;
        Tue, 05 Jan 2021 02:21:04 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id x28sm57891988pff.182.2021.01.05.02.21.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 02:21:03 -0800 (PST)
Date:   Tue, 5 Jan 2021 15:51:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Colin King <colin.king@canonical.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Stephen Warren <swarren@nvidia.com>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V3] cpufreq: powernow-k8: pass policy rather than use
 cpufreq_cpu_get
Message-ID: <20210105102101.y4jdqdmcru5ouec4@vireshk-i7>
References: <20210105101957.59072-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105101957.59072-1-colin.king@canonical.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-01-21, 10:19, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently there is an unlikely case where cpufreq_cpu_get returns a
> null policy and this will cause a null pointer dereference later on.
> Fix this by passing the policy to transition_frequency_fidvid from the
> caller and hence eliminating the need for the cpufreq_cpu_get and
> cpufreq_cpu_put.  Thanks to Viresh Kumar for suggesting the fix.
> 
> Addresses-Coverity: ("Dereference null return")
> Fixes: b43a7ffbf33b ("cpufreq: Notify all policy->cpus in cpufreq_notify_transition()")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> 
> V2: pass the policy to transition_frequency_fidvid rather than add
>     a null pointer check on the return from a cpufreq_cpu_get call.
> V3: update subject line to match the fix
> 
> ---
>  drivers/cpufreq/powernow-k8.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
