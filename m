Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0F421B554
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 14:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgGJMpI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 08:45:08 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41146 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgGJMpI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 08:45:08 -0400
Received: by mail-ed1-f67.google.com with SMTP id e22so4543385edq.8;
        Fri, 10 Jul 2020 05:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ABCar9XaLCL6nQFaJkwQvjmy7wFbtvMLNqM9yovrz04=;
        b=oJv2kPqAhDjy/9Bqdy5ZYO6cynzW5Hf2+DLrhBkvMhgYhkPn4xbBidRn+gBmWJYkTi
         NkJ8kKFxkZMeSKdhzgrA2D1WOYTXfikL1EqejcGVBvWyd/Hxa0eJB5Yxfh1JzZnoFARu
         n4ZmIxDqu0oNMA2LUNCYd8iMDml2OcAyBx3HXI3wUufDaq00BC+MjEutBhZbRExEKqNz
         4tf0W4lCeTx4o44zJ/uVu+Y1NcTmOEg7pvN7n3YUHmZMkgREWDgs5yKQsU5SHNZjtku8
         FcAifWSGh1ckZQFur5VHJwmKmxE4ahKYaX99Ve1sKO2ZaG41BaHmeCcTsGv7aV/iRO0i
         girQ==
X-Gm-Message-State: AOAM533YrlgZkyJDPmfaZ5GSvpVoGpa0CJ7Fsz1dU3bm1y9gyt3iQBV/
        FcVPlCIAa1Tpz5hQfqT+900=
X-Google-Smtp-Source: ABdhPJwaB+c1mORjF8jaO+c/+QMJ0GE5nK3K8F4mfLhSS6Mvk1IPL6raXjJal+9PnCv8TJGdi0CJSA==
X-Received: by 2002:a05:6402:1c10:: with SMTP id ck16mr60633676edb.72.1594385106109;
        Fri, 10 Jul 2020 05:45:06 -0700 (PDT)
Received: from pi3 ([194.230.155.195])
        by smtp.googlemail.com with ESMTPSA id d12sm4379131edx.80.2020.07.10.05.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 05:45:05 -0700 (PDT)
Date:   Fri, 10 Jul 2020 14:45:03 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, willy.mh.wolff.ml@gmail.com,
        k.konieczny@samsung.com, b.zolnierkie@samsung.com,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, s.nawrocki@samsung.com, kgene@kernel.org
Subject: Re: [PATCH 1/2] memory: samsung: exynos5422-dmc: Adjust polling
 interval and uptreshold
Message-ID: <20200710124503.GB22897@pi3>
References: <20200708153420.29484-1-lukasz.luba@arm.com>
 <CGME20200708153448epcas1p438fae2327ac69fcc1a78d9c73cfda501@epcas1p4.samsung.com>
 <20200708153420.29484-2-lukasz.luba@arm.com>
 <fa3f651a-3c2b-188b-e2dc-4fd05ce4a1b7@samsung.com>
 <a676fc18-6f1f-8502-e8d5-5ad1ccf0eec6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a676fc18-6f1f-8502-e8d5-5ad1ccf0eec6@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 10, 2020 at 09:34:45AM +0100, Lukasz Luba wrote:
> Hi Chanwoo,
> 
> On 7/9/20 5:08 AM, Chanwoo Choi wrote:
> > Hi Lukasz,
> > 
> > On 7/9/20 12:34 AM, Lukasz Luba wrote:
> > > In order to react faster and make better decisions under some workloads,
> > > benchmarking the memory subsystem behavior, adjust the polling interval
> > > and upthreshold value used by the simple_ondemand governor.
> > > 
> > > Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
> > > Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> > > ---
> > >   drivers/memory/samsung/exynos5422-dmc.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
> > > index 93e9c2429c0d..e03ee35f0ab5 100644
> > > --- a/drivers/memory/samsung/exynos5422-dmc.c
> > > +++ b/drivers/memory/samsung/exynos5422-dmc.c
> > > @@ -1466,10 +1466,10 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
> > >   		 * Setup default thresholds for the devfreq governor.
> > >   		 * The values are chosen based on experiments.
> > >   		 */
> > > -		dmc->gov_data.upthreshold = 30;
> > > +		dmc->gov_data.upthreshold = 10;
> > >   		dmc->gov_data.downdifferential = 5;
> > > -		exynos5_dmc_df_profile.polling_ms = 500;
> > > +		exynos5_dmc_df_profile.polling_ms = 100;
> > >   	}
> > > 
> > 
> > Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> > 
> 
> Thank you for the review. Do you think this patch could go through
> your tree together with your patches?
> 
> I don't know Krzysztof's opinion about the patch 2/2, but
> I would expect, assuming the patch itself is correct, he would
> like to take it into his next/dt branch.

In the cover letter you mentioned that this is a follow up for the
Chanwoo's patchset. But are these patches really depending on it? Can
they be picked up independently?

The DTS patch must go through arm soc, so I will take it. If it really
depends on driver changes, then it has to wait for next release.

Best regards,
Krzysztof

