Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9B5862BB
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 15:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732885AbfHHNPK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 09:15:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732643AbfHHNPJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Aug 2019 09:15:09 -0400
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2495321874;
        Thu,  8 Aug 2019 13:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565270108;
        bh=5yPzM5yGGSNATY9kmjyrKwemZkcgY7dISuXee3TjHbA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r8LLjQSFOD5ZA2mugoq5PfbhvrYb2QgV1WP0LufxAR2YpULVjpPB2DqsCJ99YgWf3
         ybC/lYyEiNBMdDlf4f24jeP2nXzUoU26pgn6E0S9/W+NjWNk0YpL1aSWS6bCRgtYxg
         3y+rWBmCPDgsAGJrTYBT8OmYFX4iQf7MlbbLmBFE=
Received: by mail-lj1-f172.google.com with SMTP id k18so88823676ljc.11;
        Thu, 08 Aug 2019 06:15:08 -0700 (PDT)
X-Gm-Message-State: APjAAAXyJLc6qlfutqhn+ZJYT6IaIrYWqBuqAKQj4Mj0D+7ewi3PZCkU
        ouoqj8YK1zC6kqLKgO0SPTwE9aGtXNkY6TV/ia8=
X-Google-Smtp-Source: APXvYqzWTwcs6TPkPrDTz+qUFZmx5IMdHV6tLMEdfb5Dbo2QpS6RlvnpGcLKMZOf3TR4vCBEsNVuYYrMDmmz/hVY2Qw=
X-Received: by 2002:a2e:3008:: with SMTP id w8mr8417296ljw.13.1565270106316;
 Thu, 08 Aug 2019 06:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190718143130eucas1p26f2058f47eb2f4020e1ddbf1619d1ac8@eucas1p2.samsung.com>
 <20190718143044.25066-1-s.nawrocki@samsung.com> <20190718143044.25066-4-s.nawrocki@samsung.com>
 <CAJKOXPeOfDHjqSotxVwVuy+6r9X3Q8ZXLit1_=gGd7bOwkHupA@mail.gmail.com>
 <a56fe2d8-1f26-b462-1564-f23902f7dbb5@samsung.com> <CAJKOXPc8iFo=2JAGEZSC46N3sZae4+JcZYBCjpKysb6PFPzyaQ@mail.gmail.com>
 <669c6b25-eb7e-ed3a-72a2-ee155a568363@arm.com>
In-Reply-To: <669c6b25-eb7e-ed3a-72a2-ee155a568363@arm.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 8 Aug 2019 15:14:54 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc01ViCcwpasJ4o+yxvz5r8v0D1h5F5dc4=s0R0Jn4uNw@mail.gmail.com>
Message-ID: <CAJKOXPc01ViCcwpasJ4o+yxvz5r8v0D1h5F5dc4=s0R0Jn4uNw@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] soc: samsung: Add Exynos Adaptive Supply Voltage driver
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        devicetree@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-pm@vger.kernel.org,
        pankaj.dubey@samsung.com,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        robh+dt@kernel.org, kgene@kernel.org, vireshk@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 8 Aug 2019 at 14:48, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 08/08/2019 13:31, Krzysztof Kozlowski wrote:
> > On Thu, 8 Aug 2019 at 14:07, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
> >>>> +static unsigned int exynos5422_asv_parse_table(struct exynos_asv *asv,
> >>>> +                                     unsigned int pkg_id)
> >>>> +{
> >>>> +       return (pkg_id >> EXYNOS5422_TABLE_OFFSET) & EXYNOS5422_TABLE_MASK;
> >>>> +}
> >>>> +
> >>>> +static bool exynos5422_asv_parse_bin2(struct exynos_asv *asv,
> >>>> +                                    unsigned int pkg_id)
> >>>> +{
> >>>> +       return (pkg_id >> EXYNOS5422_BIN2_OFFSET) & EXYNOS5422_BIN2_MASK;
> >>>
> >>> return !!() for converting to boolean.
> >>
> >> I'm not convinced it is needed, the return type of the function is bool
> >> and value of the expression will be implicitly converted to that type.
> >> Is there any compiler warning related to that?
> >
> > Yeah, but bool is int so there will be no implicit conversion... I
> > guess it is a convention. In theory !! is the proper conversion to
> > bool but if bool==int then it's essentially conversion to 1. I am not
> > sure what's the benefit, maybe for some wrong code which would do
> > comparisons on result like if (exynos5422_asv_parse_bin2() == TRUE)...
>
> Not so - since we use "-std=gnu89", we have C99-like _Bool, which our
> bool is a typedef of. Conversions, either implicit or explicit, are
> well-defined:
>
> "6.3.1.2 Boolean type
>
> When any scalar value is converted to _Bool, the result is 0 if the
> value compares equal
> to 0; otherwise, the result is 1."
>
> This is even called out in Documentation/process/coding-style.rst:
>
> "When using bool types the !! construction is not needed, which
> eliminates a class of bugs."

Good point, thanks!

Best regards,
Krzysztof
