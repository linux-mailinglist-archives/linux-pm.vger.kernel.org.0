Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DBD2AA07D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 23:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgKFWlz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 17:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbgKFWly (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 17:41:54 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767E1C0613CF;
        Fri,  6 Nov 2020 14:41:54 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id i7so1963088qti.6;
        Fri, 06 Nov 2020 14:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=z7FzhduA30Tm2qYziVPMUtmZyLRgCN7aQ0VOcniLxfY=;
        b=HJ3eU3myQMPuA6VE8cHM6/10KXPZMnaphEJVB3Wrm4mr18vUuECaCd9fy/IUt8KUpJ
         KtL2QwgXfwA6p0zbrWnB/C6MtYYIS+OQNEQKQ6L0FKKzW+xV4IDXYbhWj/MA4h4HovI7
         pinQUoyzFWmASq/Jxxss6GfF04D4BPyT1JZp24xjltmN6ox7QsSZLKocE8Wrv7ykihJH
         jhQx5BADjQ1GzBvgG48C2ILsD5gOJxSC0pFo+ZAXkTeP+5Sac4ImPXajPvoFMnsuwa0v
         fOmTRQhHGyGBTL+P4fSRJ5SPKDFYNou7amgFNusX4F6TapLGI9439WgX/AhBVHAQD36O
         3aqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=z7FzhduA30Tm2qYziVPMUtmZyLRgCN7aQ0VOcniLxfY=;
        b=rfJURQHid0AmNWgyH6NZxaiVFD+MwVQP3PC7rSfuOuwq2F6nxSYm+yawBxl35k0GwZ
         GMrNOyz7ap1no5y3OKtkOnkn1brTNCOOV1Urem0VpuZJM7Qo+dbcrrl2KHpXBri9OZSt
         uLV2onTPXU/y8EwFqcbF7z2/y2mQtWa1xZK5nvzY80uXYKzaL3dyE7hl0Cm16AjVohIw
         CNhNXQDtxXj1lKsrJkQaiNm6IORY/qQYhzg+Zs2p5iv0rBcefiO3ZRJ90m+vilV3A130
         zJqxCBbxQFNtZdFKMUb3nn+Kxz4T+NTvvNBwTUjCMzjletOfoIRZbxgiJChl/zdTMjzk
         BW+Q==
X-Gm-Message-State: AOAM5301PBgASb97dOxokhF/ODGI8jesHze5K0iMzQYgfuRVBYfM6PF9
        tFE4lA7WdTZT7X+7LaK9Azc=
X-Google-Smtp-Source: ABdhPJxKeA2me0EkL+mP07TIDmSCUWPJiEsceqjGfsRkB8cJn8NR84Q7ocq9nUHwYWQI50UgZEZpSw==
X-Received: by 2002:ac8:5d53:: with SMTP id g19mr3762928qtx.306.1604702513581;
        Fri, 06 Nov 2020 14:41:53 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id w54sm1563018qtb.0.2020.11.06.14.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 14:41:52 -0800 (PST)
Date:   Fri, 6 Nov 2020 15:41:51 -0700
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
Message-ID: <20201106224151.GA3571170@ubuntu-m3-large-x86>
References: <20201106180544.5681-1-rdunlap@infradead.org>
 <20201106181713.GA3970874@ubuntu-m3-large-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201106181713.GA3970874@ubuntu-m3-large-x86>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 06, 2020 at 11:17:13AM -0700, Nathan Chancellor wrote:
> On Fri, Nov 06, 2020 at 10:05:44AM -0800, Randy Dunlap wrote:
> > Add stubs for pm_clk_runtime_suspend() and pm_clk_runtime_resume()
> > to fix build errors when CONFIG_PM and CONFIG_PM_CLK are not enabled.
> > 
> > Fixes these build errors:
> > 
> > ../drivers/clk/qcom/camcc-sc7180.c: In function ‘cam_cc_sc7180_probe’:
> > ../drivers/clk/qcom/camcc-sc7180.c:1672:8: error: implicit declaration of function ‘pm_clk_runtime_resume’; did you mean ‘pm_runtime_resume’? [-Werror=implicit-function-declaration]
> >   ret = pm_clk_runtime_resume(&pdev->dev);
> >         ^~~~~~~~~~~~~~~~~~~~~
> > ../drivers/clk/qcom/camcc-sc7180.c:1681:3: error: implicit declaration of function ‘pm_clk_runtime_suspend’; did you mean ‘pm_runtime_suspend’? [-Werror=implicit-function-declaration]
> >    pm_clk_runtime_suspend(&pdev->dev);
> >    ^~~~~~~~~~~~~~~~~~~~~~
> > 
> > Fixes: 15d09e830bbc ("clk: qcom: camcc: Add camera clock controller driver for SC7180")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: linux-pm@vger.kernel.org
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: linux-clk@vger.kernel.org
> > Cc: Taniya Das <tdas@codeaurora.org>
> > Cc: linux-next@vger.kernel.org
> 
> This fixes the same build failure that I saw with s390 all{mod,yes}config.
> 
> Build-tested-by: Nathan Chancellor <natechancellor@gmail.com>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

Actually, this breaks certain powerpc configs:

$ make -skj"$(nproc)" ARCH=powerpc CROSS_COMPILE=powerpc-linux- distclean ppc44x_defconfig drivers/base/power/common.o
In file included from drivers/base/power/common.c:11:
./include/linux/pm_clock.h:87:19: error: static declaration of 'pm_clk_runtime_suspend' follows non-static declaration
   87 | static inline int pm_clk_runtime_suspend(struct device *dev)
      |                   ^~~~~~~~~~~~~~~~~~~~~~
./include/linux/pm_clock.h:23:12: note: previous declaration of 'pm_clk_runtime_suspend' was here
   23 | extern int pm_clk_runtime_suspend(struct device *dev);
      |            ^~~~~~~~~~~~~~~~~~~~~~
./include/linux/pm_clock.h:91:19: error: static declaration of 'pm_clk_runtime_resume' follows non-static declaration
   91 | static inline int pm_clk_runtime_resume(struct device *dev)
      |                   ^~~~~~~~~~~~~~~~~~~~~
./include/linux/pm_clock.h:24:12: note: previous declaration of 'pm_clk_runtime_resume' was here
   24 | extern int pm_clk_runtime_resume(struct device *dev);
      |            ^~~~~~~~~~~~~~~~~~~~~
make[4]: *** [scripts/Makefile.build:283: drivers/base/power/common.o] Error 1
make[4]: Target '__build' not remade because of errors.
make[3]: *** [scripts/Makefile.build:500: drivers/base/power] Error 2
make[3]: Target '__build' not remade because of errors.
make[2]: *** [scripts/Makefile.build:500: drivers/base] Error 2
make[2]: Target '__build' not remade because of errors.
make[1]: *** [Makefile:1797: drivers] Error 2
make[1]: Target 'drivers/base/power/common.o' not remade because of errors.
make: *** [Makefile:335: __build_one_by_one] Error 2
make: Target 'distclean' not remade because of errors.
make: Target 'ppc44x_defconfig' not remade because of errors.
make: Target 'drivers/base/power/common.o' not remade because of errors.

I think this should be moved into the CONFIG_PM block at the top of the
file.

> > ---
> >  include/linux/pm_clock.h |    9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > --- linux-next-20201106.orig/include/linux/pm_clock.h
> > +++ linux-next-20201106/include/linux/pm_clock.h
> > @@ -83,6 +83,15 @@ static inline void pm_clk_remove(struct
> >  static inline void pm_clk_remove_clk(struct device *dev, struct clk *clk)
> >  {
> >  }
> > +
> > +static inline int pm_clk_runtime_suspend(struct device *dev)
> > +{
> > +	return 0;
> > +}
> > +static inline int pm_clk_runtime_resume(struct device *dev)
> > +{
> > +	return 0;
> > +}
> >  #endif
> >  
> >  #ifdef CONFIG_HAVE_CLK
