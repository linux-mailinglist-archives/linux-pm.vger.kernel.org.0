Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18B4E95AD8
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2019 11:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfHTJVR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 05:21:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41572 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbfHTJVR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2019 05:21:17 -0400
Received: by mail-pf1-f193.google.com with SMTP id 196so3009652pfz.8
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2019 02:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fNqn8jt+Eu/y3WAdZBc6pAlsOtl2wpEF2Ezb9uPuzFs=;
        b=bm7qZSrIUp7yfrt8m+6HQ+L0yN+04ev62t82CQ5xfoJbY9ugfFikx3iuSAvbmhTpFg
         1rxCbeHAR9Yu74VEgkJ/NCLgBT+vvo46ilJ0GSi92qPvxRlB4whvjXoc0KTkpOWQQgth
         qHRZAzKAHBUuasKjsfEeXe8lbZldF4DJ8J4+fVY3UScx6BERp1etA4IXQR7Ty7i4yvGe
         GG5Y8GAYJjCuT2VFdOToY7CULRMaHMOvOwvCYmaP3dd0e6/JUxXu0My+AxDtBeAUHgA4
         HIeSRSxc5fq+Q31UyD5zpQ+J3dGEIHWJy22zqGq1wz+N5seTYf3befQt64QvzxF46OLw
         Va/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fNqn8jt+Eu/y3WAdZBc6pAlsOtl2wpEF2Ezb9uPuzFs=;
        b=sx04QIY4DNV3AsoOsBwFF+W4hb5VfjEHsVWzT3IIZxcLUk/qMM7pWDcn4e7OiFu15Y
         BiVp0B0P+IziXjDMHKW+OLRRlXvFZ+fGNt0nKkra2OGCZeVsF6cGn675a/rl85AJPtfA
         EDLOnzd0hyQNwIDspBLa+r5QPfqUyieKwH76mU2ZNKY8aM77ZRbdTmxpk9whsLUypx2d
         OqhC8TDGDO4VVZOMmDIbG/ZxD/93ySJFuF0k1avCW5aA2FNin8Wl2nl4RRlV2lTE3YRz
         /QXMsqE0pwMeMdI9vJ+P/clt2t8p1R9PFuQhXi74FzVRiyZBrQ+fRVN9tBAwCOtOoAMr
         1Aag==
X-Gm-Message-State: APjAAAVKwH0pgc3dozPbA2S7hHIJ6U6bJn0Zz9ZAEwayOWhCkxRJoIWb
        eqryNtmA6TwT9Fni56yhI+BlXAg5E2Y=
X-Google-Smtp-Source: APXvYqx3NGkLs8NsqtiC35VhZLducwJHY2iFYVWb66LyAIkzov9xYbt/7XwPAuKAdHf72ZcfwGfM/g==
X-Received: by 2002:aa7:991a:: with SMTP id z26mr24899786pff.43.1566292876575;
        Tue, 20 Aug 2019 02:21:16 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id 5sm17229250pgh.93.2019.08.20.02.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 02:21:15 -0700 (PDT)
Date:   Tue, 20 Aug 2019 14:51:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>, krzk@kernel.org,
        robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.zolnierkie@samsung.com
Subject: Re: [PATCH v2 0/9] Exynos Adaptive Supply Voltage support
Message-ID: <20190820092113.gojhe3romdnvm7eu@vireshk-i7>
References: <20190723020450.z2pqwetkn2tfhacq@vireshk-i7>
 <5ef302a4-5bbf-483d-dfdf-cf76f6f69cee@samsung.com>
 <20190725022343.p7lqalrh5svxvtu2@vireshk-i7>
 <562dd2e7-2b24-8492-d1c1-2dc4973f07be@samsung.com>
 <20190819090928.pke6cov52n4exlbp@vireshk-i7>
 <b831d7c5-c830-fd65-20cf-02e209889c28@samsung.com>
 <20190819112533.bvfyinw7fsebkufr@vireshk-i7>
 <b7093aaf-ea56-c390-781f-6f9d0780bd8e@samsung.com>
 <20190820030114.6flnn2omeys3lih3@vireshk-i7>
 <06ccff05-2152-4bcc-7537-8f24da75f163@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06ccff05-2152-4bcc-7537-8f24da75f163@samsung.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-08-19, 11:03, Sylwester Nawrocki wrote:
> On 8/20/19 05:01, Viresh Kumar wrote:
> > Sorry but I am unable to understand the difficulty you are facing now. So what I
> > suggest is something like this.
> 
> The difficulty was about representing data from tables asv_{arm,kfc}_table[][]
> added in patch 3/9 of the series in devicetree.  If you have no objections
> about keeping those tables in the driver then I can't see any difficulties. 

The problem with keeping such tables in kernel is that they contain too much
magic values which very few people understand. And after some amount of time,
even they don't remember any of it.

What I was expecting was to remove as much of these tables as possible and do
the calculations to get them at runtime with some logical code which people can
understand later on.

> > - Use DT to get a frequency and voltage for each frequency.
> 
> Yes, this is what happens now, we have common OPPs in DT that work for each SoC
> revision. 
> 
> > - At runtime, based on SoC, registers, efuses, etc, update the voltage of the
> >   OPPs.
> > - This algo can be different for each SoC, no one is stopping you from doing
> >   that.
> > 
> > Am I missing something ?
> 
> Not really, this is basically what happens in the $subject patch series. 
> 
> Then IIUC what I would need to change is to modify exynos_asv_update_cpu_opps() 
> function in patch 3/9 to use dev_pm_opp_adjust_voltage() rather than 
> dev_pm_opp_remove(), dev_pm_opp_add().

That and somehow add code to get those tables if possible.

-- 
viresh
