Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A372A9BB6
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 19:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgKFSRQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 13:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgKFSRQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 13:17:16 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30411C0613CF;
        Fri,  6 Nov 2020 10:17:16 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id g13so871402qvu.1;
        Fri, 06 Nov 2020 10:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xpxktmvHGo+CaqevD+BoyqDDeQDal/1mY0CZMqQlRYQ=;
        b=IQAyatVaE/uhtZdFF21kT1+BmaaKOzsyQ+RInMQqxRz7Xmr4DURZTI7pvPKVcn44z4
         9IsQpUHzTSbORLNbOX7vmGYUtLzmhzvhTiInx771aeJk78orN39uVoqdurieqtPFeIwM
         0I9CUDd2l8QqVqvIhKpDB2xHoEkmV8mn7JlYBH4jxLm0ksPgssQqqPK7hU2tofg3gnP0
         euPRReHNbZejDZMhMirdxj4CTkVpQ5abGmV0mjFI9VW4/2K5wZ4SkrtG3M5TJXK8pQpT
         gBIEo3lwgcVLkAKTIiYNWpzdRGzV5+zctC1XcsKLtMliUmqjnRtF+ciH9tb67GQvpUYm
         USaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xpxktmvHGo+CaqevD+BoyqDDeQDal/1mY0CZMqQlRYQ=;
        b=X7hgTy4/b2dGgEZ+Nv9+7kYIsDIBYqFlnVviTtxErf5L9TMiljnxy6JbZwzwhGhKba
         a8S1sTP1yxDXRSgPHwIKczfJioD9tRMwSpSij6qmnbY7wMxEN3sqfH+PosjdOK2CUpE6
         nddv7pTrxBkGfx67LKp9Z8FGtK0sTgYHrvDs8gQim57B2Dtvw5UHX6k3JBy2GTmCu134
         r1wcSrDeqbwW0R9eES9g7LVmbTo+K4f1cUY+9tty/+ZRHt9v4QO25Bzq2pBQVSTxYnW7
         mCge4s3iBqKNG72ap2ybS4GO8cX8xl725P50wrtci+SE3kHsc3qx3tZITZh4hH1Zf7s7
         U2xw==
X-Gm-Message-State: AOAM531Cctl0sBaTUvkj2vDm8KPsZMX+RYPJxXT8xDL1n6n244TtKing
        NaFtM+wgfFZAMeeIM+QuT+8=
X-Google-Smtp-Source: ABdhPJzzLjrmp5elXPE46DAm1ZvY6K4jJYerNwXzLzaDa3Vf8oKjY7bMuaGnrAkmUW8kQc0Lose/Zw==
X-Received: by 2002:ad4:4a74:: with SMTP id cn20mr2672816qvb.61.1604686635391;
        Fri, 06 Nov 2020 10:17:15 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id k3sm985419qtj.84.2020.11.06.10.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 10:17:14 -0800 (PST)
Date:   Fri, 6 Nov 2020 11:17:13 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>, linux-next@vger.kernel.org
Subject: Re: [PATCH -next] clk: pm_clock: provide stubs for
 pm_clk_runtime_suspend/_resume
Message-ID: <20201106181713.GA3970874@ubuntu-m3-large-x86>
References: <20201106180544.5681-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201106180544.5681-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 06, 2020 at 10:05:44AM -0800, Randy Dunlap wrote:
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

This fixes the same build failure that I saw with s390 all{mod,yes}config.

Build-tested-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  include/linux/pm_clock.h |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> --- linux-next-20201106.orig/include/linux/pm_clock.h
> +++ linux-next-20201106/include/linux/pm_clock.h
> @@ -83,6 +83,15 @@ static inline void pm_clk_remove(struct
>  static inline void pm_clk_remove_clk(struct device *dev, struct clk *clk)
>  {
>  }
> +
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
>  #ifdef CONFIG_HAVE_CLK
