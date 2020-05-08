Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066AE1CB234
	for <lists+linux-pm@lfdr.de>; Fri,  8 May 2020 16:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgEHOqQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 May 2020 10:46:16 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42456 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgEHOqP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2020 10:46:15 -0400
Received: by mail-ed1-f68.google.com with SMTP id s10so1407053edy.9;
        Fri, 08 May 2020 07:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XarHM7quPtL8Iwp9fTwswhgZUavH/ZpsvuGgVu5XAdQ=;
        b=s/ZHhlAj71VgJ8NnezjZBWro4BmGv+kztSHzy9OaFeyxmgcg4yrKfs91ak7WS/rjF0
         xq6ErTJk3IsxZP480DStFO9tOyhR38TvWShYjzdduYmpnf9kRbOjCNW6ehXLn6IdLex+
         lBtONwzWDLu0Bw18ILlbuDoKvcL4t9BnN3mjLGvv6PADRb3IP8c+jNQaP8inW3HaQfTt
         uSn7kGk0K37Tz9PW0jd82VNFOLI01l3hAt7R6jPZElr/PQqp1hqW8EIJBJDTa7a6+N4b
         0ey3uHJFOh7tW3LO4Vr+mzwybi3GDTg1/k7RCEIoWQbAYCpwI8udTTyZgyUMc901yWP9
         MK6w==
X-Gm-Message-State: AGi0PuYEgz24/EQPsqpy32zYDKrXkaecLzIA9HmXl1iM+Lk4afrMFdGG
        4esZFW1O41NnuZHbqtBLIkY=
X-Google-Smtp-Source: APiQypJjIQQnYzAO+FSyQEz9WwVtWHbUUhLRrRKlBcmzLwDdJK0dXJ06g9EggDcxrDp7mWZKsB0M9g==
X-Received: by 2002:a05:6402:1515:: with SMTP id f21mr2448831edw.370.1588949173380;
        Fri, 08 May 2020 07:46:13 -0700 (PDT)
Received: from kozik-lap ([194.230.155.237])
        by smtp.googlemail.com with ESMTPSA id a5sm289736edn.14.2020.05.08.07.46.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 May 2020 07:46:12 -0700 (PDT)
Date:   Fri, 8 May 2020 16:46:10 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Bernard Zhao <bernard@vivo.com>, Kukjin Kim <kgene@kernel.org>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH] memory/samsung: Maybe wrong triming parameter
Message-ID: <20200508144610.GA5983@kozik-lap>
References: <20200507114514.11589-1-bernard@vivo.com>
 <2eeb33f7-1acc-66bb-704a-b724fa0be0a8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2eeb33f7-1acc-66bb-704a-b724fa0be0a8@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 07, 2020 at 04:42:46PM +0100, Lukasz Luba wrote:
> Hi Bernard,
> 
> 
> On 5/7/20 12:45 PM, Bernard Zhao wrote:
> > In function create_timings_aligned, all the max is to use
> > dmc->min_tck->xxx, aligned with val dmc->timings->xxx.
> > But the dmc->timings->tFAW use dmc->min_tck->tXP?
> > Maybe this point is wrong parameter useing.
> > 
> > Signed-off-by: Bernard Zhao <bernard@vivo.com>
> > ---
> >   drivers/memory/samsung/exynos5422-dmc.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
> > index 81a1b1d01683..22a43d662833 100644
> > --- a/drivers/memory/samsung/exynos5422-dmc.c
> > +++ b/drivers/memory/samsung/exynos5422-dmc.c
> > @@ -1091,7 +1091,7 @@ static int create_timings_aligned(struct exynos5_dmc *dmc, u32 *reg_timing_row,
> >   	/* power related timings */
> >   	val = dmc->timings->tFAW / clk_period_ps;
> >   	val += dmc->timings->tFAW % clk_period_ps ? 1 : 0;
> > -	val = max(val, dmc->min_tck->tXP);
> > +	val = max(val, dmc->min_tck->tFAW);
> >   	reg = &timing_power[0];
> >   	*reg_timing_power |= TIMING_VAL2REG(reg, val);
> > 
> 
> Good catch! Indeed this should be a dmc->min_tck->tFAW used for
> clamping.
> 
> It didn't show up in testing because the frequency values based on
> which the 'clk_period_ps' are calculated are sane.
> Check the dump below:
> 
> [    5.458227] DMC: mem tFAW=25000, clk_period_ps=6060
> [    5.461743] DMC: tFAW=5, tXP=2 val=5
> [    5.465273] DMC: mem tFAW=25000, clk_period_ps=4854
> [    5.470101] DMC: tFAW=5, tXP=2 val=6
> [    5.473668] DMC: mem tFAW=25000, clk_period_ps=3636
> [    5.478507] DMC: tFAW=5, tXP=2 val=7
> [    5.482072] DMC: mem tFAW=25000, clk_period_ps=2421
> [    5.486951] DMC: tFAW=5, tXP=2 val=11
> [    5.490531] DMC: mem tFAW=25000, clk_period_ps=1841
> [    5.495439] DMC: tFAW=5, tXP=2 val=14
> [    5.499113] DMC: mem tFAW=25000, clk_period_ps=1579
> [    5.503877] DMC: tFAW=5, tXP=2 val=16
> [    5.507476] DMC: mem tFAW=25000, clk_period_ps=1373
> [    5.512368] DMC: tFAW=5, tXP=2 val=19
> [    5.515968] DMC: mem tFAW=25000, clk_period_ps=1212
> [    5.520826] DMC: tFAW=5, tXP=2 val=21
> 
> That's why in the existing configuration it does not harm
> (the calculated 'val' is always >= 5) the board.
> 
> But I think this patch should be applied (after small changes in the
> commit message).
> 
> @Krzysztof could you have a look on the commit message or take the
> patch with small adjustment in the description, please?
> 
> I conditionally give (because of this description):
> 
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Thanks for review.

I applied patch with CC-stable and adjusred commit msg.

Best regards,
Krzysztof

