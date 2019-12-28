Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B93EE12BD93
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2019 13:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfL1Mrr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 28 Dec 2019 07:47:47 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43708 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfL1Mrr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 28 Dec 2019 07:47:47 -0500
Received: by mail-pf1-f195.google.com with SMTP id x6so14956662pfo.10
        for <linux-pm@vger.kernel.org>; Sat, 28 Dec 2019 04:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pI3bHdhVC4jD/lCQfsvWohXAM7HBD6rFo3cPOHaRtUA=;
        b=QVkGkqqEH87ZRVIkAEShKMvsKKVZNX3dS2U0uju+4fPWtxkNOzqcSBsgWgH/qH0xx7
         6ABx1O2t8a111JC8iprulan++JxYGdfgd8eAAEOe8SlCcgI4xzG+4HxLJTLkZzbYpgEu
         Q12NgaT8kiSSsge8TFG315XsnQEsCkX/ij05bS1KgMkPTXyOso8IUTyb8p6OyOOhc4DV
         EvvLkucc9tFKXhCfY53doHLlw/iFswMpc4pVCf3yJ8UHEOcghpjz6P093iO0G9H1Le+d
         RGbDr+BgnufQ9veq9n0dia+mxDpqqML2sQYx/N89OXntI2NhisxWaY304KxnrXqDUm0r
         DfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pI3bHdhVC4jD/lCQfsvWohXAM7HBD6rFo3cPOHaRtUA=;
        b=JzwEb+e++2VvQ0xRkFk4g3nEzj+VrYUyb7VIzzUAvSccJpiu59wNZNhsw61mtlY5sw
         rU0gxxE+wnTQ067/hjNwUDavyLUvCpvFT+alO4M8y4ozRURgbdrotBMpozmDc7JT9VFu
         837j+lo8r1sjHj2OYfscJpDuVXog7Yo4iMkBs7pupSggibw9n4ZL/oVxYCBu8H2aT/cg
         EKoLl0XGyoTQJfM62iim6oGMRanoeSG/UIB4Zr1LdlH2c+tcB4PmbUzIV1iAnvJJ9/Q9
         IN0TRJr9tPnZomAaURk6qpK5LUJ2vbs5Qtw9yXB8VP/wBM4fZEWFgIGrSPOe6w9uiBB8
         y8WA==
X-Gm-Message-State: APjAAAU5AL+kCoFYThwbnuaSzqqlZ81ixNAqj05nGvjs/l4og/3aEYxh
        UPJSjcSki5Mgqm/BxJ/ahuo=
X-Google-Smtp-Source: APXvYqy0MYnN0gshVmCs8u0rVFEs4Ra4zcPjqBFATbA/kqGev/XZffwqJFL5m+vwVEEOZ44bOiSHfg==
X-Received: by 2002:a63:1e47:: with SMTP id p7mr59163570pgm.339.1577537266826;
        Sat, 28 Dec 2019 04:47:46 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id e19sm17900399pjr.10.2019.12.28.04.47.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 28 Dec 2019 04:47:46 -0800 (PST)
Date:   Sat, 28 Dec 2019 20:47:44 +0800
From:   chenqiwu <qiwuchen55@gmail.com>
To:     mmayer@broadcom.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        f.fainelli@gmail.com
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] cpufreq: brcmstb-avs-cpufreq: avoid a stuck risk and UAF
 issue in brcm_avs_cpufreq_get()
Message-ID: <20191228124744.GA3491@cqw-OptiPlex-7050>
References: <1577513730-14254-1-git-send-email-qiwuchen55@gmail.com>
 <201912281807.gbP6xHJ1%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201912281807.gbP6xHJ1%lkp@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Dec 28, 2019 at 06:20:25PM +0800, kbuild test robot wrote:
> Hi,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on pm/linux-next]
> [also build test ERROR on v5.5-rc3 next-20191220]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/qiwuchen55-gmail-com/cpufreq-brcmstb-avs-cpufreq-avoid-a-stuck-risk-and-UAF-issue-in-brcm_avs_cpufreq_get/20191228-141943
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=arm 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/pm_qos.h:10:0,
>                     from include/linux/cpufreq.h:16,
>                     from drivers/cpufreq/brcmstb-avs-cpufreq.c:44:
>    drivers/cpufreq/brcmstb-avs-cpufreq.c: In function 'brcm_avs_cpufreq_get':
> >> drivers/cpufreq/brcmstb-avs-cpufreq.c:459:12: error: 'dev' undeclared (first use in this function); did you mean 'sev'?
>       dev_warn(dev, "cpu %d: CPUFreq policy not found\n", cpu);
>                ^
>    include/linux/device.h:1776:12: note: in definition of macro 'dev_warn'
>      _dev_warn(dev, dev_fmt(fmt), ##__VA_ARGS__)
>                ^~~
>    drivers/cpufreq/brcmstb-avs-cpufreq.c:459:12: note: each undeclared identifier is reported only once for each function it appears in
>       dev_warn(dev, "cpu %d: CPUFreq policy not found\n", cpu);
>                ^
>    include/linux/device.h:1776:12: note: in definition of macro 'dev_warn'
>      _dev_warn(dev, dev_fmt(fmt), ##__VA_ARGS__)
>                ^~~
>    In file included from include/uapi/linux/posix_types.h:5:0,
>                     from include/uapi/linux/types.h:14,
>                     from include/linux/compiler.h:180,
>                     from include/linux/err.h:5,
>                     from include/linux/clk.h:12,
>                     from include/linux/cpufreq.h:11,
>                     from drivers/cpufreq/brcmstb-avs-cpufreq.c:44:
> >> include/linux/stddef.h:8:14: warning: return makes integer from pointer without a cast [-Wint-conversion]
>     #define NULL ((void *)0)
>                  ^
> >> drivers/cpufreq/brcmstb-avs-cpufreq.c:460:10: note: in expansion of macro 'NULL'
>       return NULL;
>              ^~~~
> >> include/linux/stddef.h:8:14: warning: return makes integer from pointer without a cast [-Wint-conversion]
>     #define NULL ((void *)0)
>                  ^
>    drivers/cpufreq/brcmstb-avs-cpufreq.c:465:10: note: in expansion of macro 'NULL'
>       return NULL;
>              ^~~~
> --
>    In file included from include/linux/pm_qos.h:10:0,
>                     from include/linux/cpufreq.h:16,
>                     from drivers//cpufreq/brcmstb-avs-cpufreq.c:44:
>    drivers//cpufreq/brcmstb-avs-cpufreq.c: In function 'brcm_avs_cpufreq_get':
>    drivers//cpufreq/brcmstb-avs-cpufreq.c:459:12: error: 'dev' undeclared (first use in this function); did you mean 'sev'?
>       dev_warn(dev, "cpu %d: CPUFreq policy not found\n", cpu);
>                ^
>    include/linux/device.h:1776:12: note: in definition of macro 'dev_warn'
>      _dev_warn(dev, dev_fmt(fmt), ##__VA_ARGS__)
>                ^~~
>    drivers//cpufreq/brcmstb-avs-cpufreq.c:459:12: note: each undeclared identifier is reported only once for each function it appears in
>       dev_warn(dev, "cpu %d: CPUFreq policy not found\n", cpu);
>                ^
>    include/linux/device.h:1776:12: note: in definition of macro 'dev_warn'
>      _dev_warn(dev, dev_fmt(fmt), ##__VA_ARGS__)
>                ^~~
>    In file included from include/uapi/linux/posix_types.h:5:0,
>                     from include/uapi/linux/types.h:14,
>                     from include/linux/compiler.h:180,
>                     from include/linux/err.h:5,
>                     from include/linux/clk.h:12,
>                     from include/linux/cpufreq.h:11,
>                     from drivers//cpufreq/brcmstb-avs-cpufreq.c:44:
> >> include/linux/stddef.h:8:14: warning: return makes integer from pointer without a cast [-Wint-conversion]
>     #define NULL ((void *)0)
>                  ^
>    drivers//cpufreq/brcmstb-avs-cpufreq.c:460:10: note: in expansion of macro 'NULL'
>       return NULL;
>              ^~~~
> >> include/linux/stddef.h:8:14: warning: return makes integer from pointer without a cast [-Wint-conversion]
>     #define NULL ((void *)0)
>                  ^
>    drivers//cpufreq/brcmstb-avs-cpufreq.c:465:10: note: in expansion of macro 'NULL'
>       return NULL;
>              ^~~~
> 
> vim +459 drivers/cpufreq/brcmstb-avs-cpufreq.c
> 
>    452	
>    453	static unsigned int brcm_avs_cpufreq_get(unsigned int cpu)
>    454	{
>    455		struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
>    456		struct private_data *priv;
>    457	
>    458		if (!policy) {
>  > 459			dev_warn(dev, "cpu %d: CPUFreq policy not found\n", cpu);
>  > 460			return NULL;
>    461		}
>    462	
>    463		priv = policy->driver_data;
>    464		if (!priv || !priv->base)
>    465			return NULL;
>    466	
>    467		return brcm_avs_get_frequency(priv->base);
>    468	}
>    469	
> 
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

So sorry, I sent the wrong patch file, and resend correct patch which compile ok.

Thanks!
Qiwu
