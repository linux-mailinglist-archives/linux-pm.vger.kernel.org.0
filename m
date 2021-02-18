Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5F131E475
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 04:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhBRDU0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Feb 2021 22:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhBRDUZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Feb 2021 22:20:25 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13CCC061756
        for <linux-pm@vger.kernel.org>; Wed, 17 Feb 2021 19:19:45 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id u143so334878pfc.7
        for <linux-pm@vger.kernel.org>; Wed, 17 Feb 2021 19:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lIwLTWpFfTb+ihzsW/9wLdIaJe4pMyN+ZO5MNliYpAE=;
        b=m3q7oHJu84c0Rk+ZlkrBNvC31lbLIomW0XayA0xyuyTuav2MtPj/jDcLP8BMexom2A
         yks06/8/Z6O3H+STY8VVLJ4aZgl9If3l/2faziNgf/0j7hENFSvHoQpASTSjMxa9fQjy
         ogsjm/FoZAOE7kAIQs2ZdLMyWkgtESjd4VxbCEZiLlHUdvnh654LiDxKZrY12EoOCwMl
         3BV1YnNvItE5CobWM6bJVgPMS8Ja9gonXSYCAKqDMY/rPTiVBhxT+UGcubm8pLh/Bm93
         RI9mgjKhTe94oRNvbuZ/DIjjYpGDJfxbg9fQNcEzkHP2kHijUwf9mkrOHOurKuf4nmZS
         kqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lIwLTWpFfTb+ihzsW/9wLdIaJe4pMyN+ZO5MNliYpAE=;
        b=B+owg4EwhZkBV2Gz3dOqjWaouuxwmZkQ4gOmA8LZeoHMBsKuGdie1OeD7sli5I29//
         u0iY1KLXwr2tN7nwvAD0scTqao+/7sz95RAGm2F0N3R9aVf/gzgoJvMOyOi7JJI9aQXC
         2J2aWrIoGAYZwQwYnA1PugfL487Rcc5sOh/xOA3sENDxEkAjHhMhOkQ0OhV3slpor6j+
         Fr36MTGzLO7vQS0QS0o2fb/dyXuqISR6bNKCVABfHG9TtQO8WyuPOoZmoUIrU8YLyx2N
         3djEvKxB5vK59fp8XUqfk/+Zhdx+iEjGP1VuwIxOXcRIvIDrWqzG8B0fWNSHKfyNDuh6
         YXog==
X-Gm-Message-State: AOAM533G4ltrW1FSlfrtG7aH7wG8bdmj3H1bquGcnQ5E7kpy4rsPjiuY
        NMTYId6ZDVnCs9D6SfxnmDNEQw==
X-Google-Smtp-Source: ABdhPJxMK20NHMbdmubKYukaXunAItm7pjSb+jla1VGcLZldEyDGwqsFQiC5pXQvJXOin6BPg6+BkQ==
X-Received: by 2002:aa7:8c59:0:b029:1db:48a9:be70 with SMTP id e25-20020aa78c590000b02901db48a9be70mr2386550pfd.68.1613618385159;
        Wed, 17 Feb 2021 19:19:45 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id f18sm3383827pjq.53.2021.02.17.19.19.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Feb 2021 19:19:44 -0800 (PST)
Date:   Thu, 18 Feb 2021 11:19:38 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Steev Klimaszewski <steev@kali.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: qcom-hw: drop devm_xxx() calls from
 init/exit hooks
Message-ID: <20210218031938.GA7127@dragon>
References: <20210119023925.22724-1-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119023925.22724-1-shawn.guo@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 19, 2021 at 10:39:25AM +0800, Shawn Guo wrote:
> Commit f17b3e44320b ("cpufreq: qcom-hw: Use
> devm_platform_ioremap_resource() to simplify code") introduces
> a regression on platforms using the driver, by failing to initialise
> a policy, when one is created post hotplug.
> 
> When all the CPUs of a policy are hoptplugged out, the call to .exit()
> and later to devm_iounmap() does not release the memory region that was
> requested during devm_platform_ioremap_resource().  Therefore,
> a subsequent call to .init() will result in the following error, which
> will prevent a new policy to be initialised:
> 
> [ 3395.915416] CPU4: shutdown
> [ 3395.938185] psci: CPU4 killed (polled 0 ms)
> [ 3399.071424] CPU5: shutdown
> [ 3399.094316] psci: CPU5 killed (polled 0 ms)
> [ 3402.139358] CPU6: shutdown
> [ 3402.161705] psci: CPU6 killed (polled 0 ms)
> [ 3404.742939] CPU7: shutdown
> [ 3404.765592] psci: CPU7 killed (polled 0 ms)
> [ 3411.492274] Detected VIPT I-cache on CPU4
> [ 3411.492337] GICv3: CPU4: found redistributor 400 region 0:0x0000000017ae0000
> [ 3411.492448] CPU4: Booted secondary processor 0x0000000400 [0x516f802d]
> [ 3411.503654] qcom-cpufreq-hw 17d43000.cpufreq: can't request region for resource [mem 0x17d45800-0x17d46bff]
> 
> With that being said, the original code was tricky and skipping memory
> region request intentionally to hide this issue.  The true cause is that
> those devm_xxx() device managed functions shouldn't be used for cpufreq
> init/exit hooks, because &pdev->dev is alive across the hooks and will
> not trigger auto resource free-up.  Let's drop the use of device managed
> functions and manually allocate/free resources, so that the issue can be
> fixed properly.
> 
> Fixes: f17b3e44320b ("cpufreq: qcom-hw: Use devm_platform_ioremap_resource() to simplify code")
> Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Hi Viresh,

What happened on this patch?  I thought we would have it in 5.11
release, but ...

Shawn
