Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B9421B629
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 15:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgGJNT1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 10 Jul 2020 09:19:27 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:39596 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgGJNT0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 09:19:26 -0400
Received: by mail-ej1-f65.google.com with SMTP id w6so5998956ejq.6;
        Fri, 10 Jul 2020 06:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aiyaF2FytE8HZZpLNpK3zBFemn/CG6XpT/cnzXTCJwM=;
        b=qIvbPknn9kJz6NyTQzcE4XGs4Klbgd760knstF5NEfcadE/OgnMvvDWCHTHJqmZy9u
         NlU7oxxbEqkLXweC3pzNNZ2LEJBhvC6JigDhYOLjBrCpNqdUl1b0yZUa356EFLeaO6N1
         eFVR9UeySKpqaHCLh5PZJtkLXWBwnM8xdlEiIjPublXbEYnOj+Pp6SvTqwe1fbnWaTRQ
         09+I1wmYlFMNxZY1rs1KBfWpxvwhoppNmjbcuRgQFPtJck7b/dkAOgp5wSqafsmxbKDY
         KRZYesKRDaCWwkYpMOH0gvb5UCle9DxWiI3/tRY6bZagCI88R8hjQ3tWpYKtwXmpBtmh
         xJ6g==
X-Gm-Message-State: AOAM530yX5vSyg0LRUVubrMpZVDhpmAPtSt0e44uWb71x6JbYLIeagRx
        NSxic3fioxOtLBKeJv9z2Vk=
X-Google-Smtp-Source: ABdhPJyaUT+p8gosJzUaxrGPh/H7xAs294fLsRt3d6RK4D5/YPUDPN6b8icRktecgzIS+lDpaBenkw==
X-Received: by 2002:a17:906:4a17:: with SMTP id w23mr63943545eju.360.1594387164434;
        Fri, 10 Jul 2020 06:19:24 -0700 (PDT)
Received: from pi3 ([194.230.155.195])
        by smtp.googlemail.com with ESMTPSA id fi29sm3600252ejb.83.2020.07.10.06.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 06:19:23 -0700 (PDT)
Date:   Fri, 10 Jul 2020 15:19:21 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, willy.mh.wolff.ml@gmail.com,
        k.konieczny@samsung.com, b.zolnierkie@samsung.com,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, s.nawrocki@samsung.com, kgene@kernel.org
Subject: Re: [PATCH 1/2] memory: samsung: exynos5422-dmc: Adjust polling
 interval and uptreshold
Message-ID: <20200710131921.GA23039@pi3>
References: <20200708153420.29484-1-lukasz.luba@arm.com>
 <CGME20200708153448epcas1p438fae2327ac69fcc1a78d9c73cfda501@epcas1p4.samsung.com>
 <20200708153420.29484-2-lukasz.luba@arm.com>
 <fa3f651a-3c2b-188b-e2dc-4fd05ce4a1b7@samsung.com>
 <a676fc18-6f1f-8502-e8d5-5ad1ccf0eec6@arm.com>
 <c016e256-65a6-8075-d88d-c3fad4815b4d@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <c016e256-65a6-8075-d88d-c3fad4815b4d@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 10, 2020 at 03:13:18PM +0200, Marek Szyprowski wrote:
> Hi Lukasz,
> 
> On 10.07.2020 10:34, Lukasz Luba wrote:
> > Hi Chanwoo,
> >
> > On 7/9/20 5:08 AM, Chanwoo Choi wrote:
> >> Hi Lukasz,
> >>
> >> On 7/9/20 12:34 AM, Lukasz Luba wrote:
> >>> In order to react faster and make better decisions under some 
> >>> workloads,
> >>> benchmarking the memory subsystem behavior, adjust the polling interval
> >>> and upthreshold value used by the simple_ondemand governor.
> >>>
> >>> Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
> >>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> >>> ---
> >>>   drivers/memory/samsung/exynos5422-dmc.c | 4 ++--
> >>>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/memory/samsung/exynos5422-dmc.c 
> >>> b/drivers/memory/samsung/exynos5422-dmc.c
> >>> index 93e9c2429c0d..e03ee35f0ab5 100644
> >>> --- a/drivers/memory/samsung/exynos5422-dmc.c
> >>> +++ b/drivers/memory/samsung/exynos5422-dmc.c
> >>> @@ -1466,10 +1466,10 @@ static int exynos5_dmc_probe(struct 
> >>> platform_device *pdev)
> >>>            * Setup default thresholds for the devfreq governor.
> >>>            * The values are chosen based on experiments.
> >>>            */
> >>> -        dmc->gov_data.upthreshold = 30;
> >>> +        dmc->gov_data.upthreshold = 10;
> >>>           dmc->gov_data.downdifferential = 5;
> >>>   -        exynos5_dmc_df_profile.polling_ms = 500;
> >>> +        exynos5_dmc_df_profile.polling_ms = 100;
> >>>       }
> >>>
> >>
> >> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> >>
> >
> > Thank you for the review. Do you think this patch could go through
> > your tree together with your patches?
> >
> > I don't know Krzysztof's opinion about the patch 2/2, but
> > I would expect, assuming the patch itself is correct, he would
> > like to take it into his next/dt branch.
> 
> Is there really a need to remove the interrupts property? imho they are 
> correct hw description, it just a matter of the driver to use or not to 
> use them.

That's actually very good point. I would also prefer to leave them.
However I understood that driver chooses mode depending on the property.

In such case, maybe as you said, let's switch to polling mode
unconditionally?

Best regards,
Krzysztof

