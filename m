Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3DF21B5DC
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 15:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgGJNHd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 09:07:33 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38762 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgGJNHd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 09:07:33 -0400
Received: by mail-ed1-f67.google.com with SMTP id n2so4607632edr.5;
        Fri, 10 Jul 2020 06:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IhjbyydRkafatOFYJUQWB8jqmQKoDEwVSOznMMqxhFo=;
        b=Nad8aXsjhnZkSxA7iE8zeoTezfltjopOXl8RE+9tGURXHPD4jSwClzBvCcBPDpa4UU
         dw+zlSGaTc+vt2foNOdBEftsjzbyTpDtglHNSaMk18yO8Y1WyEhJdTTsr+lbqvcHiadn
         78COdQOG/Tkw3c70Wh1XLmEHBZg1uyHGYqbJ/6viiJIPrhk6SpsDWS86I9ASteSDENh2
         JOvlUkkrpzPVAsMlLwS4mkaQD5js5tblkoVzWbItDUxB1We0oSWrlcP2eCU1iFCgzFVW
         ZxgGzLuWZmFlPdFML45oC0zgT4n29aPkGQHQ9hklDVdsgp6jyOv0QQRaQkHCqEmUcLW0
         zL1w==
X-Gm-Message-State: AOAM532EQ9cDIYGCaUHmZc7sz19h0MkWPwoQ0HHkzNfrcjkbFQSXbyyv
        4KZDtMnTVAF1MP2RgWJZa0c=
X-Google-Smtp-Source: ABdhPJy7GvB0YGcvjriG0PCDBYS91figVPtXSFiWz8TRbw35P+rdTnGn8EDvM7zDY0obC6Fi35h29w==
X-Received: by 2002:aa7:da8d:: with SMTP id q13mr73846957eds.339.1594386450284;
        Fri, 10 Jul 2020 06:07:30 -0700 (PDT)
Received: from pi3 ([194.230.155.195])
        by smtp.googlemail.com with ESMTPSA id lj18sm3602276ejb.43.2020.07.10.06.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 06:07:29 -0700 (PDT)
Date:   Fri, 10 Jul 2020 15:07:27 +0200
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
Message-ID: <20200710130727.GA22991@pi3>
References: <20200708153420.29484-1-lukasz.luba@arm.com>
 <CGME20200708153448epcas1p438fae2327ac69fcc1a78d9c73cfda501@epcas1p4.samsung.com>
 <20200708153420.29484-2-lukasz.luba@arm.com>
 <fa3f651a-3c2b-188b-e2dc-4fd05ce4a1b7@samsung.com>
 <a676fc18-6f1f-8502-e8d5-5ad1ccf0eec6@arm.com>
 <20200710124503.GB22897@pi3>
 <0bfb4332-9a2e-9ff9-1a86-d9875a8f34bb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0bfb4332-9a2e-9ff9-1a86-d9875a8f34bb@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 10, 2020 at 01:56:33PM +0100, Lukasz Luba wrote:
> 
> 
> On 7/10/20 1:45 PM, Krzysztof Kozlowski wrote:
> > On Fri, Jul 10, 2020 at 09:34:45AM +0100, Lukasz Luba wrote:
> > > Hi Chanwoo,
> > > 
> > > On 7/9/20 5:08 AM, Chanwoo Choi wrote:
> > > > Hi Lukasz,
> > > > 
> > > > On 7/9/20 12:34 AM, Lukasz Luba wrote:
> > > > > In order to react faster and make better decisions under some workloads,
> > > > > benchmarking the memory subsystem behavior, adjust the polling interval
> > > > > and upthreshold value used by the simple_ondemand governor.
> > > > > 
> > > > > Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
> > > > > Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> > > > > ---
> > > > >    drivers/memory/samsung/exynos5422-dmc.c | 4 ++--
> > > > >    1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
> > > > > index 93e9c2429c0d..e03ee35f0ab5 100644
> > > > > --- a/drivers/memory/samsung/exynos5422-dmc.c
> > > > > +++ b/drivers/memory/samsung/exynos5422-dmc.c
> > > > > @@ -1466,10 +1466,10 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
> > > > >    		 * Setup default thresholds for the devfreq governor.
> > > > >    		 * The values are chosen based on experiments.
> > > > >    		 */
> > > > > -		dmc->gov_data.upthreshold = 30;
> > > > > +		dmc->gov_data.upthreshold = 10;
> > > > >    		dmc->gov_data.downdifferential = 5;
> > > > > -		exynos5_dmc_df_profile.polling_ms = 500;
> > > > > +		exynos5_dmc_df_profile.polling_ms = 100;
> > > > >    	}
> > > > > 
> > > > 
> > > > Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> > > > 
> > > 
> > > Thank you for the review. Do you think this patch could go through
> > > your tree together with your patches?
> > > 
> > > I don't know Krzysztof's opinion about the patch 2/2, but
> > > I would expect, assuming the patch itself is correct, he would
> > > like to take it into his next/dt branch.
> > 
> > In the cover letter you mentioned that this is a follow up for the
> > Chanwoo's patchset. But are these patches really depending on it? Can
> > they be picked up independently?
> 
> 
> They are not heavily dependent on Chanwoo's patches.
> Yes, they can be picked up independently.
> I just wanted to mention that the patch 1/2 was produced on the
> code base which had already applied Chanwoo's patch for DMC.
> If you like to take both 1/2 and 2/2 into your tree, it's good.

Then let me take them. If there is more development ongoing, it would
create unnecessary merges between trees.

Best regards,
Krzysztof

