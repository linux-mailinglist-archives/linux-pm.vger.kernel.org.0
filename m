Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F9721B8E6
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 16:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGJOrY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 10 Jul 2020 10:47:24 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33047 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgGJOrY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 10:47:24 -0400
Received: by mail-ed1-f68.google.com with SMTP id h28so4893056edz.0;
        Fri, 10 Jul 2020 07:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Xz5xImGDw4ThuClWOrrxh3Lk5Us8ehNrD7H3hvTN4Mc=;
        b=V1K6DvknJ0+jqMSlDob1U3mmiuzBuvNYZF/cFeSnW07GPydyGW9w/zJrSwEPvG+50F
         pISIuYdUtxkOiDKn9e3zFgh25WiOmWJvr4lmjx/cDhe9W2xynjIXZ1fmIElHrV53LZBO
         67Iqt+sftTdZyxqlgJ1od9YEC6nQpQMTN/mu3O/bg2vAahQX4ShrH/koDUXEp0fIppia
         TwZzVxBeSkbAZPsZlrtezBwOtT2dFVlceU+fSQ+69zUhVcltnWRjJdI/83UR/aic3x/V
         oGvNeNXTSBzWnauWIy32Wnf/3dpl4g5o9yTXVImgxGbp8kCWiRJomraE3/sbr+zSJkmu
         xkKw==
X-Gm-Message-State: AOAM53276/l/NwcIkZXvxuC4TJojf3dztYEqSSxmYtouC4AJJiZUfCl3
        Mj73aDzTKM8zkjwV+WyDV4Y=
X-Google-Smtp-Source: ABdhPJw7p9+SxTcezcmdGl6nEopI7Qd68XFhzE7ZNbnA9Su9N3KDM29Cw8sv/0oQBTtmJz16W0n8pw==
X-Received: by 2002:a50:d8c2:: with SMTP id y2mr69401617edj.114.1594392441019;
        Fri, 10 Jul 2020 07:47:21 -0700 (PDT)
Received: from pi3 ([194.230.155.195])
        by smtp.googlemail.com with ESMTPSA id j64sm4539997edd.61.2020.07.10.07.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 07:47:20 -0700 (PDT)
Date:   Fri, 10 Jul 2020 16:47:18 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, willy.mh.wolff.ml@gmail.com,
        k.konieczny@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        s.nawrocki@samsung.com, kgene@kernel.org
Subject: Re: [PATCH 1/2] memory: samsung: exynos5422-dmc: Adjust polling
 interval and uptreshold
Message-ID: <20200710144718.GA23140@pi3>
References: <20200708153420.29484-1-lukasz.luba@arm.com>
 <CGME20200708153448epcas1p438fae2327ac69fcc1a78d9c73cfda501@epcas1p4.samsung.com>
 <20200708153420.29484-2-lukasz.luba@arm.com>
 <fa3f651a-3c2b-188b-e2dc-4fd05ce4a1b7@samsung.com>
 <a676fc18-6f1f-8502-e8d5-5ad1ccf0eec6@arm.com>
 <20200710124503.GB22897@pi3>
 <0bfb4332-9a2e-9ff9-1a86-d9875a8f34bb@arm.com>
 <ef88644a-a75d-82c0-8b60-eb2810c68f58@samsung.com>
 <b0ecbdd9-f445-b2f7-755a-cbc10cb1e56c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <b0ecbdd9-f445-b2f7-755a-cbc10cb1e56c@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 10, 2020 at 03:00:37PM +0100, Lukasz Luba wrote:
> 
> 
> On 7/10/20 2:49 PM, Bartlomiej Zolnierkiewicz wrote:
> > 
> > On 7/10/20 2:56 PM, Lukasz Luba wrote:
> > > 
> > > 
> > > On 7/10/20 1:45 PM, Krzysztof Kozlowski wrote:
> > > > On Fri, Jul 10, 2020 at 09:34:45AM +0100, Lukasz Luba wrote:
> > > > > Hi Chanwoo,
> > > > > 
> > > > > On 7/9/20 5:08 AM, Chanwoo Choi wrote:
> > > > > > Hi Lukasz,
> > > > > > 
> > > > > > On 7/9/20 12:34 AM, Lukasz Luba wrote:
> > > > > > > In order to react faster and make better decisions under some workloads,
> > > > > > > benchmarking the memory subsystem behavior, adjust the polling interval
> > > > > > > and upthreshold value used by the simple_ondemand governor.
> > > > > > > 
> > > > > > > Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
> > > > > > > Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> > > > > > > ---
> > > > > > >     drivers/memory/samsung/exynos5422-dmc.c | 4 ++--
> > > > > > >     1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
> > > > > > > index 93e9c2429c0d..e03ee35f0ab5 100644
> > > > > > > --- a/drivers/memory/samsung/exynos5422-dmc.c
> > > > > > > +++ b/drivers/memory/samsung/exynos5422-dmc.c
> > > > > > > @@ -1466,10 +1466,10 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
> > > > > > >              * Setup default thresholds for the devfreq governor.
> > > > > > >              * The values are chosen based on experiments.
> > > > > > >              */
> > > > > > > -        dmc->gov_data.upthreshold = 30;
> > > > > > > +        dmc->gov_data.upthreshold = 10;
> > > > > > >             dmc->gov_data.downdifferential = 5;
> > > > > > > -        exynos5_dmc_df_profile.polling_ms = 500;
> > > > > > > +        exynos5_dmc_df_profile.polling_ms = 100;
> > > > > > >         }
> > > > > > > 
> > > > > > 
> > > > > > Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> > > > > > 
> > > > > 
> > > > > Thank you for the review. Do you think this patch could go through
> > > > > your tree together with your patches?
> > > > > 
> > > > > I don't know Krzysztof's opinion about the patch 2/2, but
> > > > > I would expect, assuming the patch itself is correct, he would
> > > > > like to take it into his next/dt branch.
> > > > 
> > > > In the cover letter you mentioned that this is a follow up for the
> > > > Chanwoo's patchset. But are these patches really depending on it? Can
> > > > they be picked up independently?
> > > 
> > > 
> > > They are not heavily dependent on Chanwoo's patches.
> > > Yes, they can be picked up independently.
> > 
> > Hmmm, are you sure?
> 
> In a sense: in two phases (first the Chanwoo's changes land into
> devfreq, then when Krzysztof prepares his topic branches for
> arm soc, I assumed Chanwoo's patches are mainline and will be there
> already).
> 
> > 
> > Sure, they will apply fine but without Chanwoo's patches won't they
> > cause the dmc driver to use using polling mode with deferred timer
> > (unintended/bad behavior) instead of IRQs (current behavior) or
> > polling mode with delayed timer (future behavior)?
> 
> I was assuming that it will take longer, when Krzysztof is going to pick
> patch 2/2, definitely after a while (and it could be also the case for
> patch 1/1 if Krzysztof was going to take it).
> 
> I think there is no rush and it can go in two phases.
> 
> Good point Bartek for clarifying this. I wasn't clear in the messages.
> Thank you for keeping eye on this.

... which means they are dependent on Chanwoo's patchset. They cannot go
in parallel, they cannot be picked up independently.

You know, when someone's patches are in mainline, it is never a
dependency anymore...

The patches then could wait for next cycle if there is no rush. Maybe
there will be some further revisions of this approach?

Best regards,
Krzysztof

