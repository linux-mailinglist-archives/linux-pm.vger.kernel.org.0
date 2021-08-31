Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B027B3FC6EB
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 14:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbhHaMGu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 08:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240031AbhHaMGm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Aug 2021 08:06:42 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A752C0613A3
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 05:05:47 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id u11-20020a17090adb4b00b00181668a56d6so2215961pjx.5
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 05:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=81H8Khmuq0gm+N/QGoA0kVYpJHUjl5fbHhU1F9Dsi7A=;
        b=WHzIyqFPHHfsV3+fhcaDaDbpfrnnsCoB8CjcJK16FN/tDkVHHYqZgD8j+d/U4Ul9xG
         O91dGGYoZ2Rl/MSi+8H4bss1c/F5nvncUBCpXPJVP2HmHlZD6QdbD23Hp+PFsF/mQ9Td
         For7qkfdnAVqb9LS3M8qUwcbBkGLcAFGTl2CFDfR4q94Jckr8Q72oU4xbRA5CfGPWLIY
         jypWd42dQuu/u329tTiXu6LuBo7nwXo4xoODKI1zDCguLqf5VVj8FhNKJlyRHY8mTw8P
         T0s6AuNCMzU7BkPzwbRr8Xzk0LnsLS1g0UIlgCXcvk1obTYk8okjBuZGbD7i46GU7tve
         VQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=81H8Khmuq0gm+N/QGoA0kVYpJHUjl5fbHhU1F9Dsi7A=;
        b=o+t9pJLurxMMxnAGD/8IZrCLXi5AqMK+bRqY4gM87k6Ndx6gHIc4OzVVCca9JPqIg5
         gzMkZNBMF/UuwuF+t+0QV1hmuSEajsveBRqo4fxsHQ94zLm4caLfYx1AdsinMjOdVIU7
         0rNMjDXcwMffjsESgkgzHDUDhTapc+SjlhQ8sFK+lGTi7kY4Vy1Y96F1+zHC+ojfQd+r
         jWBrywY2AYij6EpIsYbKXYCu7EI9eyV5WywtBBn2kxpeQoJN4xTfgSuoVkZmpkwJ7jz2
         4WDBg3XN9XHJ8GEbPPyhZzOxmIpPAPVcWJoPgxh88wMdP0QCjey3eo8nQdVvHKQxCJxZ
         TGgg==
X-Gm-Message-State: AOAM531IfyZMiL9uon2b1IfFoExXFmQseHOcoflci2maRxonS3TxGzWg
        T/gC1121Zb9MHk4WA1z6dfssIw==
X-Google-Smtp-Source: ABdhPJzRAQ3+8KLiIf3YKqRM5JYk7c3Av6YFFYKKvuFVGY17IyclAKAGqPiWBfD3UcCzVsM2GjL8Ow==
X-Received: by 2002:a17:902:ff02:b0:138:b944:e0f0 with SMTP id f2-20020a170902ff0200b00138b944e0f0mr4461195plj.34.1630411546632;
        Tue, 31 Aug 2021 05:05:46 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id s192sm19353258pgc.23.2021.08.31.05.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 05:05:46 -0700 (PDT)
Date:   Tue, 31 Aug 2021 17:35:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Li Zhijian <lizhijian@cn.fujitsu.com>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        philip.li@intel.com, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/2] selftests/cpufreq: Rename DEBUG_PI_LIST to
 DEBUG_PLIST
Message-ID: <20210831120544.m4vngti4i3c6gwr3@vireshk-i7>
References: <20210831102316.280512-1-lizhijian@cn.fujitsu.com>
 <20210831102316.280512-3-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831102316.280512-3-lizhijian@cn.fujitsu.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 31-08-21, 18:23, Li Zhijian wrote:
> DEBUG_PI_LIST was renamed to DEBUG_PLIST since
> 8e18faeac3 ("lib/plist: rename DEBUG_PI_LIST to DEBUG_PLIST")
> 
> - It's not reasonable to keep the deprecated configs.
> - configs under kselftests are recommended by corresponding tests.
> So if some configs are missing, it will impact the testing results
> 
> CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> CC: Viresh Kumar <viresh.kumar@linaro.org>
> CC: linux-pm@vger.kernel.org
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> 
> ---
> v3: update commit logs # Shuah
> ---
>  tools/testing/selftests/cpufreq/config | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/cpufreq/config b/tools/testing/selftests/cpufreq/config
> index 27ff72ebd0f5..75e900793e8a 100644
> --- a/tools/testing/selftests/cpufreq/config
> +++ b/tools/testing/selftests/cpufreq/config
> @@ -6,7 +6,7 @@ CONFIG_CPU_FREQ_GOV_ONDEMAND=y
>  CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
>  CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
>  CONFIG_DEBUG_RT_MUTEXES=y
> -CONFIG_DEBUG_PI_LIST=y
> +CONFIG_DEBUG_PLIST=y
>  CONFIG_DEBUG_SPINLOCK=y
>  CONFIG_DEBUG_MUTEXES=y
>  CONFIG_DEBUG_LOCK_ALLOC=y

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
