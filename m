Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71ADBF943D
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2019 16:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfKLP2J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 10:28:09 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37862 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfKLP2J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Nov 2019 10:28:09 -0500
Received: by mail-wm1-f66.google.com with SMTP id b17so3412692wmj.2
        for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2019 07:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kWHH1ATKaqJdtcy0BTeaU86pQL78xcoIefbCjsSxoJA=;
        b=iT6Y7wSYIuVXaRmjL5IwXNVRgWSUhL5wpgeaOlg5RhWi7JmuQlmYry/n47GTx1wItC
         IF+gMWIsTe51wuSZvfEjqNG5a9AJzIWd6PaqXqFMEMWsuiVd1N3owujTwI/ZWjYWHc+O
         FUyiKEc3OpVtuquCLpbYydSeahqnB7RhIRkVSKLtczm7ZzFKWnKooDZmLBlNAuJwojvU
         VAPYj/ttU4RBgTn6+CZuqqdR7RCd8s9foygMVnuL1a/t3+X8fEYIhGDbeXx6Iw+wxn/F
         AB9OVERVlomrGk1kICQC9xt2tTSvfp1AJUuZeFPyVoG2mrif1ZDNhL4/Skq/tNge9Puk
         VG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kWHH1ATKaqJdtcy0BTeaU86pQL78xcoIefbCjsSxoJA=;
        b=F3ZQItATtZjMRjXtSlyNZ+7tr/hEuMl4T1QHysXwq9pBsMCyOtLf87n48il5ajr1LA
         zebLgg4t1Ei9/yAhzTBWTspeV+U3sRvZBw1wGpNmRnMFf/CObfbJvMOQST8QPIGmqByA
         TCLev9Z1jAIpKxrbRkVH55uZ1FPqpmUPKZ2MZ0fhdGO+xybjwYpTQ/jgM7/XjyWn4U06
         WEBRQZvzfQ4mLoa8OOJu9eiTVZcVCquxnA1cF/6hPeQaW7nZHvlEukd6cxPdIX54JDyB
         M/0U9xb+tG9Awlbsv9m5Ukqk/XDqCGjphX6QUWl1X6dl/KEWdQ8PHBVC71Sid9sjHVMd
         UcaA==
X-Gm-Message-State: APjAAAUjosz4+qi+zAL7c7wMJwqs/MVJUn4G+DCWyrzrAOoNJQ4/tW0k
        VaWKcyq1TUr/oXf/nMpTjKY3xQ==
X-Google-Smtp-Source: APXvYqxjzSSb4HpnRWfSmjQzxIYa1X+5LAuugQUSIfwgHKzkVvYQkG0bo+YYk+t660yUdAvQlBXN6g==
X-Received: by 2002:a7b:c088:: with SMTP id r8mr4041138wmh.24.1573572486693;
        Tue, 12 Nov 2019 07:28:06 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id m1sm5906659wrv.37.2019.11.12.07.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 07:28:04 -0800 (PST)
Date:   Tue, 12 Nov 2019 15:28:01 +0000
From:   Quentin Perret <qperret@google.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] thermal: power_allocator: Fix Kconfig warning
Message-ID: <20191112152801.GA247051@google.com>
References: <20191112145114.36580-1-yuehaibing@huawei.com>
 <20191112151319.GA239065@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112151319.GA239065@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday 12 Nov 2019 at 15:13:19 (+0000), Quentin Perret wrote:
> On Tuesday 12 Nov 2019 at 22:51:14 (+0800), YueHaibing wrote:
> > When do randbuiding, we got this:
> > 
> > WARNING: unmet direct dependencies detected for THERMAL_GOV_POWER_ALLOCATOR
> >   Depends on [n]: THERMAL [=y] && ENERGY_MODEL [=n]
> >   Selected by [y]:
> >   - THERMAL_DEFAULT_GOV_POWER_ALLOCATOR [=y] && <choice>
> 
> This will not cause run-time problems, but I guess the warning is
> annoying so ...
> 
> > Make THERMAL_DEFAULT_GOV_POWER_ALLOCATOR also depends on ENERGY_MODEL.
> >  
> > Fixes: a4e893e802e6 ("thermal: cpu_cooling: Migrate to using the EM framework")
> 
> Daniel: can we rely on this sha1 ? Or is this branch force-pushed ?
> 
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  drivers/thermal/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index 59b79fc..5e9e038 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -108,6 +108,7 @@ config THERMAL_DEFAULT_GOV_USER_SPACE
> >  
> >  config THERMAL_DEFAULT_GOV_POWER_ALLOCATOR
> >  	bool "power_allocator"
> > +	depends on ENERGY_MODEL
> >  	select THERMAL_GOV_POWER_ALLOCATOR

And actually, instead of doing this, we probably should change this
'select THERMAL_GOV_POWER_ALLOCATOR' by a 'depends on'.

> >  	help
> >  	  Select this if you want to control temperature based on
> > -- 
> > 2.7.4
> 
> Thanks,
> Quentin
