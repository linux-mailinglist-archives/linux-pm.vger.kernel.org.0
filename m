Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79A32ACA14
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 02:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731346AbgKJBJQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 20:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729968AbgKJBJP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 20:09:15 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2C1C0613D3;
        Mon,  9 Nov 2020 17:09:15 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id q22so2712087qkq.6;
        Mon, 09 Nov 2020 17:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2XKHZA23lqGXukkdu35/JyFEQPF6UYXMzYhhKw2rxGo=;
        b=r/JRUTiK+47+y4OahAiRa1G+rapmvoJnFlgICYHcCVQHBVlYOgRE4uKBJmo5zoKszn
         A5MlSiFBvleYXeWKkAqWUACMFq3LYbD6dvreXvgti4VOyZBnbxnqEdRGQFAPDGDgmDSb
         UO7qdzFY2tnWHHXV9fBxEhQukAs5Xj36hJrH0261XPve/zoi1Rp0szsEcjEgyMpDd07N
         UdGoxcQQiEhZzuBIdVt3M/SbhzU4xoI5wvUQGRKyBDZaVCZwgcWCGBMiOr81UWOL36zj
         mh+tH5FVBWwE36hWwe3r+2bVm+xeqhm27Ag4rdl1N87aDt3lwI9TpCIxE4kflW7SRluo
         obkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2XKHZA23lqGXukkdu35/JyFEQPF6UYXMzYhhKw2rxGo=;
        b=NPvCTXds/ZTsdLwbx5E6XCYpDswYogoO5UUda7fl52bz9P5f+KpqLf13rfbUEVMYL8
         5uOH2N/KW92fGSAjFZa1z/UZiUQaJkqgwiS8GUgi9u/wOcK07fPKEIQ+N923Lau+DIbX
         Y06lFY1aGdFG4Ddg2tnWrWfedSUxiqgxMKqWAFTkByGPUabwSVJJnGHyoKTi4/6Yd9aP
         B1zamVfhgC6ZN2PgKrcTO12U5Rd6Pw+UERIyQb82TqJoUGOPvA8cna2P7PBd5fR8fFEE
         Frv16WvbedKIVRypU4+qBKu0xFKy8f6v8oz7rJosy2iN0iogtOTrMcqb7xAQUdbZTKe9
         J2nw==
X-Gm-Message-State: AOAM5307cc8NKNSH5gaVID6np2Lka+YXg5fF58eu7Lrin7/3HyJXwn9s
        Ydc8grWfoOsVirCDX+MYKBo=
X-Google-Smtp-Source: ABdhPJx7BbgcFLja6xvTiyyLD87hIKw5BHbWuSbxRVX/hG9Sz+pjezxp3cx51Lk6uWZNJVTZplGn9w==
X-Received: by 2002:a37:a010:: with SMTP id j16mr10662108qke.347.1604970554741;
        Mon, 09 Nov 2020 17:09:14 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id m25sm1816324qka.107.2020.11.09.17.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 17:09:14 -0800 (PST)
Date:   Mon, 9 Nov 2020 18:09:12 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>, linux-next@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -next v2] clk: pm_clock: provide stubs for
 pm_clk_runtime_suspend/_resume
Message-ID: <20201110010912.GA2018177@ubuntu-m3-large-x86>
References: <20201109032115.10610-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201109032115.10610-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Nov 08, 2020 at 07:21:15PM -0800, Randy Dunlap wrote:
> Add stubs for pm_clk_runtime_suspend() and pm_clk_runtime_resume()
> to fix build errors when CONFIG_PM and CONFIG_PM_CLK are not enabled.
> 
> Fixes these build errors:
> 
> ../drivers/clk/qcom/camcc-sc7180.c: In function ‘cam_cc_sc7180_probe’:
> ../drivers/clk/qcom/camcc-sc7180.c:1672:8: error: implicit declaration of function ‘pm_clk_runtime_resume’; did you mean ‘pm_runtime_resume’? [-Werror=implicit-function-declaration]
>   ret = pm_clk_runtime_resume(&pdev->dev);
>         ^~~~~~~~~~~~~~~~~~~~~
> ../drivers/clk/qcom/camcc-sc7180.c:1681:3: error: implicit declaration of function ‘pm_clk_runtime_suspend’; did you mean ‘pm_runtime_suspend’? [-Werror=implicit-function-declaration]
>    pm_clk_runtime_suspend(&pdev->dev);
>    ^~~~~~~~~~~~~~~~~~~~~~
> 
> Fixes: 15d09e830bbc ("clk: qcom: camcc: Add camera clock controller driver for SC7180")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: linux-pm@vger.kernel.org
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: Taniya Das <tdas@codeaurora.org>
> Cc: linux-next@vger.kernel.org
> Cc: Nathan Chancellor <natechancellor@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Build-tested-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
> v2: move the function stubs to be inside the #else (for !CONFIG_PM)
>     as suggested by Nathan to fix another build error
> 
>  include/linux/pm_clock.h |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> --- linux-next-20201106.orig/include/linux/pm_clock.h
> +++ linux-next-20201106/include/linux/pm_clock.h
> @@ -27,6 +27,14 @@ extern int pm_clk_runtime_resume(struct
>  	.runtime_resume = pm_clk_runtime_resume,
>  #else
>  #define USE_PM_CLK_RUNTIME_OPS
> +static inline int pm_clk_runtime_suspend(struct device *dev)
> +{
> +	return 0;
> +}
> +static inline int pm_clk_runtime_resume(struct device *dev)
> +{
> +	return 0;
> +}
>  #endif
>  
>  #ifdef CONFIG_PM_CLK
