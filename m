Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E5A24CD11
	for <lists+linux-pm@lfdr.de>; Fri, 21 Aug 2020 07:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgHUFAd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Aug 2020 01:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgHUFAc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Aug 2020 01:00:32 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C7DC061386
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2020 22:00:32 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u20so494854pfn.0
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2020 22:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xhIog8jW0T1b90LynPtu3oGxYtUKBFIhObGpRX5PCN8=;
        b=i53SGtAbChIAK2QxoCA21twg+Ec5u7kv6uYWEAjbS8pv69lMdJHtlb0PlxFiwOkDyT
         znrs7ZUO0uqko2hofD5heDRr7HNPkukxzJzckNnqQqMphu8z+MGYfO5K8PzAzR7kdqmB
         E7I7fdNqHtHMVmtPFkhRjzehVu+jlWlLm3QU/qR7uqe4ZC/M1UZekl5X9T5/wQHrjOrT
         3pO00cdtj0GxbB0uC59yUpLCKlx8UzwIW7Acua3rZn8WnwdJoCxMg82nuqLcavpwOnYt
         bP1Y3mVi0vBNNBIVYOfi902BrDqGmAbGSWhxrVTj22p0AYw6UtGLU9R55h19vulAZaLi
         yW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xhIog8jW0T1b90LynPtu3oGxYtUKBFIhObGpRX5PCN8=;
        b=W+QzsrKiwSvIumB/DLI6pAAunC9YvN0eZ5eq3kP01XZusmTGjPf0m09ZTVJ1R3sQgG
         WxIyBSbFsAfAgHoNqKu0RqlvCFWGXDihvCg3+6KFJL4rHZ8LgIeyeFujmDUSNQaUDs6T
         GI+blN/Mr39ewtLuAKcFiYDMUgywA+pCPJRy297rXBnemskm3W6qev46VdLMX9b/PwDN
         hr70NlCufR6AySNe4/xeGFvq+T2K9VJ2fqkd0EcNGpb6i6L29HisBwDSMjeuJQyS6LiY
         WMBPTaBX+TTPve3tRqdpr3IKEA4DcJ4cbQ12wM+xuv1H6hLUtWTL7987KWkQOysmdQF/
         pvSw==
X-Gm-Message-State: AOAM533+aaYTxC/NzgzwWeuC5lOAUVI1lMf/t62aQ0+Y4RMV6ktfYCpc
        7Awoo0DLQRda/YAZQJ7rAMJIhQ==
X-Google-Smtp-Source: ABdhPJzI19u3500KBRbjT18haaazuqFxPjzl/XcNJecb2bFf1ETTZ6cRXONSqFLpE27msha9PjqsTA==
X-Received: by 2002:a63:30c:: with SMTP id 12mr1042830pgd.155.1597986031559;
        Thu, 20 Aug 2020 22:00:31 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id s64sm837184pfs.111.2020.08.20.22.00.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 22:00:30 -0700 (PDT)
Date:   Fri, 21 Aug 2020 10:30:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com,
        zhangwen@yulong.com
Subject: Re: [PATCH] thermal: sysfs: Fall back to vmalloc() for cooling
 device's statistics
Message-ID: <20200821050028.ojao3u5je7dfhsnc@vireshk-i7>
References: <20200821024406.10404-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821024406.10404-1-zbestahu@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-08-20, 10:44, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> We observed warning about kzalloc() when register thermal cooling device
> in backlight_device_register(). backlight display can be a cooling device
> since reducing screen brightness will can help reduce temperature.
> 
> However, ->get_max_state of backlight will assign max brightness of 1024
> to states. The memory size can be getting 1MB+ due to states * states.
> That is so large to trigger kmalloc() warning.
> 
> So, let's use kvzalloc() to avoid the issue, also change kfree -> kvfree.
> 
> Suggested-by: Amit Kucheria <amitk@kernel.org>
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  drivers/thermal/thermal_sysfs.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
