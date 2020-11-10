Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03AE2AD022
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 07:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgKJG71 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 01:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgKJG71 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 01:59:27 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1A5C0613D3
        for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2020 22:59:27 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id b12so6009961plr.4
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2020 22:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MXqpL7kItByjfCSnMkzD7Azj3R3aec/Bbt2Um6yjyL8=;
        b=lunxwpImh4iSxSNdZAcaUqPfXhBiFtvV22uWD+IH/Yr3mD3NG9ZSavMNTEo+nxyrVh
         RCUjEnbZUYn41bGLljBXjl9ubbyAhvVWE2o8nb+MG46IBwmb499sdNkhl0Amrs792EUP
         XiRShQYGpZZ0D29Zxw8lZZbW6Yb3LypDptmRnfOHd7J3CfteekrmeuWuCrcimeQapAdf
         jzW6cj6/3yY2VRSuzjrLi+S4aPuY0UrbyHqWPLVzSzowy/frqmAVUJhEoxrMwbDGQ544
         JdYJOIwP7anomOyrkgXzxnBsJIDpF6L1vXufqGHjcLHOucV6gjoC+R2LktXt4UMJEVPd
         gd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MXqpL7kItByjfCSnMkzD7Azj3R3aec/Bbt2Um6yjyL8=;
        b=jkIz89+lWyMdScXOD4TKzg7eu+Y6Uei78Mo/SVgWF9KOfGodHQ91XlQJ9Vg0hArprS
         OsRqfMSSAS4ZeX3WkRrA9Go//yPlzbVlP8tylRHCw9fLsjGLc6VKEvFyBy7SvRK636Zf
         dvZuE9i797XFO0LDeY2aTJrsZD64XjlmeP7zj3XG7PE/sOogqjDi0+Pxv3D8Ok+UIeWm
         ymkf7HGDM9mQagDTFqFatNqtUMxq8eASre7Oxubj/9RkoVkTnlRViu00nMxHywdFrHRA
         HySyRJ+8Cu0UhZ6qGyX3FpO7cpeGKFkj8LLopEILD8omKDJLJA0HKTMUmE+iIsKvteTm
         bNgQ==
X-Gm-Message-State: AOAM531oqYgXQsDNYkRFtpk0T/Xf008Y5whpA3CYDTpMYNFGAMoBqFaX
        a8KYzRMWcl4EIyKbZXpB9UI90Q==
X-Google-Smtp-Source: ABdhPJyY6gTC9hdSkAu2frHpC+c3TkWW47Fyekm1R7C0WmrViI1qNIx1Aaltqo5Dufuvdq//24tECQ==
X-Received: by 2002:a17:902:70cb:b029:d7:e6da:9ad4 with SMTP id l11-20020a17090270cbb02900d7e6da9ad4mr6171070plt.48.1604991566783;
        Mon, 09 Nov 2020 22:59:26 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id q12sm13619474pfc.84.2020.11.09.22.59.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 22:59:26 -0800 (PST)
Date:   Tue, 10 Nov 2020 12:29:23 +0530
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
Message-ID: <20201110065923.lb53to2tjpubltkb@vireshk-i7>
References: <684ff01900180c0a40ec307dacc673b24eab593b.1604643714.git.viresh.kumar@linaro.org>
 <CGME20201109124218eucas1p1b8948a9bf2cf107b17b500b1603905e8@eucas1p1.samsung.com>
 <2924bddd-d237-aa57-abb1-a67723770e97@samsung.com>
 <20201110060011.7unghpidbzobqhq7@vireshk-i7>
 <525e0552-0faf-44c0-9f74-c651a70bebb6@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <525e0552-0faf-44c0-9f74-c651a70bebb6@samsung.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-11-20, 07:57, Marek Szyprowski wrote:
> Hi Viresh,
> 
> On 10.11.2020 07:00, Viresh Kumar wrote:
> > On 09-11-20, 13:42, Marek Szyprowski wrote:
> >> This patch landed in linux next-20201109 as commit e8f7703f8fe5
> >> ("cpufreq: dt: Don't (ab)use dev_pm_opp_get_opp_table() to create OPP
> >> table"). Sadly it causes regression on some Samsung Exynos based boards:
> >>
> >> 8<--- cut here ---
> >> Unable to handle kernel paging request at virtual address ffffff37
> >> pgd = (ptrval)
> >> [ffffff37] *pgd=4ffff841, *pte=00000000, *ppte=00000000
> >> Internal error: Oops: 27 [#1] PREEMPT SMP ARM
> >> Modules linked in:
> >> usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> >> CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.10.0-rc1-00007-ge8f7703f8fe5
> >> #1908
> >> Hardware name: Samsung Exynos (Flattened Device Tree)
> >> PC is at dev_pm_opp_put_regulators+0x8/0xf0
> >> LR is at dt_cpufreq_probe+0x19c/0x3fc
> > Does this fix it for you ?
> 
> Yes, thanks!
> 
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks. I have fixed the original patch itself and pushed for linux-next.

-- 
viresh
