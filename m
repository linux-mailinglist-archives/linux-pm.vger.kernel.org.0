Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908CD2ACF4F
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 07:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbgKJGAS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 01:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgKJGAS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 01:00:18 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D3FC0613CF
        for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2020 22:00:16 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id y7so10390890pfq.11
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2020 22:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KDx2B4hZpAG764hhcEv9LFAc6BWtFPcicOIsLFcauaw=;
        b=tsqahKrwfx/e/+y/DNCtY9VaNtexdXLJGXElmxQL5/5ZhXEUtwhp+6dkmhOrtnixcC
         m8MccBlOu+5RNBaLF0N0/F5AoUAUhhG5Cx3oEqk3F8iSp3kSu/zlubAnJZPRq+mF1ERn
         rnTek6wjkOfOVlscRwFXNOw4i+5M9rrA8TyaQfjJCeujdpMIASkxv2k4c+cXpzgHcyfD
         gNApjdUc7fk2Pifta84sPyeVu2fCna13BiUlXNuf0N9pIogVUZI7HFA27EA7AUUSOUkU
         FWtfDPKcTvRDm0ilpZyOTW1itArlBw/eBe7xW1nWRui7G2d8Tm1a9jodLS1F/D1W39BC
         bTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KDx2B4hZpAG764hhcEv9LFAc6BWtFPcicOIsLFcauaw=;
        b=uS84GqSNDcmzlKjHtArG9MpsfnzhkWV/XHT2ueqjtF0z33uVDWgK8oknwRFvyRQRFN
         dBOYBtrIpo5KtQIWBNiPmOpEsN/zasv1SIlKDszjNIHH8QclYXh0nicv+Lpzr90WF8bd
         OSfL8o8NZn1opdEgXXegDS5sLoZLoHLF7lWx119AlFncnvGyduGBCrftIUFURpW2qNB9
         9Pa6qWtiPe0udXE8bA+K78pjsPUegf1i9ZLK7lrNld2tYyTEuF+95NbYm3t1u6W4OPM8
         XTVlssDQ5lo4ysskJiuguOTJ1DUUU5fgMH8S0cQLqkbqmfBbIXAK4Z8XuxjPeX1LgPq/
         dytQ==
X-Gm-Message-State: AOAM531TFKmw+fpfvtaO5H7JlD5ZjcicqSSYhCR76A0/ChWy8vth961s
        oNp1Z1AHdRrXMWozi1YGAm7WOXqHn4Gj0w==
X-Google-Smtp-Source: ABdhPJxL3oUMXFxl0mQqs8XW33/I1S0fXpLP41GOu0VakQmg4kPBDMM+v2LXrhz96xGzGbjv9dpb1Q==
X-Received: by 2002:a17:90a:4a85:: with SMTP id f5mr3435168pjh.216.1604988015916;
        Mon, 09 Nov 2020 22:00:15 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id a3sm17890pfd.58.2020.11.09.22.00.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 22:00:14 -0800 (PST)
Date:   Tue, 10 Nov 2020 11:30:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        digetx@gmail.com, Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/2] cpufreq: dt: Don't (ab)use
 dev_pm_opp_get_opp_table() to create OPP table
Message-ID: <20201110060011.7unghpidbzobqhq7@vireshk-i7>
References: <684ff01900180c0a40ec307dacc673b24eab593b.1604643714.git.viresh.kumar@linaro.org>
 <CGME20201109124218eucas1p1b8948a9bf2cf107b17b500b1603905e8@eucas1p1.samsung.com>
 <2924bddd-d237-aa57-abb1-a67723770e97@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2924bddd-d237-aa57-abb1-a67723770e97@samsung.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-11-20, 13:42, Marek Szyprowski wrote:
> This patch landed in linux next-20201109 as commit e8f7703f8fe5 
> ("cpufreq: dt: Don't (ab)use dev_pm_opp_get_opp_table() to create OPP 
> table"). Sadly it causes regression on some Samsung Exynos based boards:
> 
> 8<--- cut here ---
> Unable to handle kernel paging request at virtual address ffffff37
> pgd = (ptrval)
> [ffffff37] *pgd=4ffff841, *pte=00000000, *ppte=00000000
> Internal error: Oops: 27 [#1] PREEMPT SMP ARM
> Modules linked in:
> usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.10.0-rc1-00007-ge8f7703f8fe5 
> #1908
> Hardware name: Samsung Exynos (Flattened Device Tree)
> PC is at dev_pm_opp_put_regulators+0x8/0xf0
> LR is at dt_cpufreq_probe+0x19c/0x3fc

Does this fix it for you ?

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 66b3db5efb53..5aa3d4e3140d 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -228,7 +228,7 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
                        if (ret != -EPROBE_DEFER)
                                dev_err(cpu_dev, "failed to set regulators: %d\n",
                                        ret);
-                       goto out;
+                       goto free_cpumask;
                }
        }
 
@@ -293,6 +293,7 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
                dev_pm_opp_of_cpumask_remove_table(priv->cpus);
        if (priv->opp_table)
                dev_pm_opp_put_regulators(priv->opp_table);
+free_cpumask:
        free_cpumask_var(priv->cpus);
        return ret;
 }


-- 
viresh
