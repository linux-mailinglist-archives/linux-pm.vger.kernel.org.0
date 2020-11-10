Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66062ADD38
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 18:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbgKJRnR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 10 Nov 2020 12:43:17 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43826 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbgKJRnQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 12:43:16 -0500
Received: by mail-ot1-f67.google.com with SMTP id y22so13346553oti.10;
        Tue, 10 Nov 2020 09:43:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qnu8/T5bkd8G/CkLl66BCso+ilsoRzzCeunrKwYoy0s=;
        b=OxxgmXKy3ao6hU2bPI2pP6F0MJWba3rvc9x31DgSVKcd3uol5QmgUFpGEvqmhcxw5A
         EzvgPuLt7edrSu8qCabcANW7Yi2NEMyofRFHy+8vBvSQ9fQ4FWoqhczT+pgoeVOcMlDs
         IdDlQicNlVIHXhtZHVn7iGW8VNPFw9vtv6sBKu+dWppAWYLIb5onT2UXBqjx6LdiX+G4
         o3N70odwh3h02FQCSyLu0Bw4jKTcazuReo7G/BAPA8Us19uvtJOtimPZ5J8K6O/dLdG0
         btbKnUDg4GGoV67Dt2/h58122vMx024UFIwpi1zLNLyYrP71lbD5ZXczk6ZzrYQgbCLZ
         aLCQ==
X-Gm-Message-State: AOAM530e1JtUM2Syo702RJiejnrtVFQtGMtDAVfVcLrBcZkj/p9Hmwka
        s3boH7LGjJNiv7vyqM4djXrvFNDuMkXpaQmCimA=
X-Google-Smtp-Source: ABdhPJzhrI7Y5KT3PFprtayKCcFjz+Fd5GTbsEZgmHb3dAz64E2uWYqzLe57EfTHryh28FKL9QkOfxa9w2O0JDT9sCk=
X-Received: by 2002:a9d:222f:: with SMTP id o44mr15180360ota.321.1605030195675;
 Tue, 10 Nov 2020 09:43:15 -0800 (PST)
MIME-Version: 1.0
References: <20201109032115.10610-1-rdunlap@infradead.org>
In-Reply-To: <20201109032115.10610-1-rdunlap@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Nov 2020 18:43:04 +0100
Message-ID: <CAJZ5v0jhJcL6uJw_Cm02SeUMff_s1L-mKzX3haAyejcCkKihNg@mail.gmail.com>
Subject: Re: [PATCH -next v2] clk: pm_clock: provide stubs for pm_clk_runtime_suspend/_resume
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 9, 2020 at 4:21 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
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
>         .runtime_resume = pm_clk_runtime_resume,
>  #else
>  #define USE_PM_CLK_RUNTIME_OPS
> +static inline int pm_clk_runtime_suspend(struct device *dev)
> +{
> +       return 0;
> +}
> +static inline int pm_clk_runtime_resume(struct device *dev)
> +{
> +       return 0;
> +}
>  #endif
>
>  #ifdef CONFIG_PM_CLK

Applied to the PM tree as 5.10-rc material, thanks!
