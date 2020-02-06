Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72E50154465
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2020 13:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgBFM72 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Feb 2020 07:59:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:58726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbgBFM71 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Feb 2020 07:59:27 -0500
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79DDB2192A;
        Thu,  6 Feb 2020 12:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580993966;
        bh=6OY7DPI2yOZ1X/1zJRZnKqanPxQshh7/EXoL02sHfpY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QEFZkBJhSZNCXOTa8av2d4HzjHuE/BqXM9vnRkZ1T0w7nQ/lzWrl9bxK23i0c49nO
         L+OTfzCqYtSpvJhn8YUlKgo0JM4vJn4NpJCTpRbPqZXHOPrwQRmVlrlhyJwowP0yxM
         P7GM0LepDBfNTFrz//gR7J0dhEslbO/HNJT8ZGYE=
Received: by mail-lf1-f41.google.com with SMTP id 9so4016395lfq.10;
        Thu, 06 Feb 2020 04:59:26 -0800 (PST)
X-Gm-Message-State: APjAAAVW4/hyoKy9DiR+aAGGIkynoWOWrmHBj+cP+IvG0AnDZARtfdUL
        8zJw93feOl2w0cIp1TOd0isgkgXR3GHN55ogPtE=
X-Google-Smtp-Source: APXvYqxXmYq0CkBT0Cjv9peoxswFZXHCgyB59GVNonQ53ahGHtf1ogSPH5YE7w3/aQn7BCzLj014+bBH5621DMrKfcY=
X-Received: by 2002:ac2:485c:: with SMTP id 28mr1744468lfy.118.1580993964531;
 Thu, 06 Feb 2020 04:59:24 -0800 (PST)
MIME-Version: 1.0
References: <20200127215453.15144-1-lukasz.luba@arm.com> <20200127215453.15144-4-lukasz.luba@arm.com>
 <CAJKOXPeA=_3zPx6Aq3CAUi7JsXr9AigWGWCTNWo_jkm=oVWe_g@mail.gmail.com>
 <db3f2554-288d-81ab-2373-1447367ba673@arm.com> <20200131204118.GA27284@kozik-lap>
 <c54e252d-dc55-5fa3-f97f-643d7efbfdc1@arm.com>
In-Reply-To: <c54e252d-dc55-5fa3-f97f-643d7efbfdc1@arm.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 6 Feb 2020 13:59:13 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfTjdtNMx=+dPVcQ53RiXx0y-r=KXBRhzA4jS77SHxciQ@mail.gmail.com>
Message-ID: <CAJKOXPfTjdtNMx=+dPVcQ53RiXx0y-r=KXBRhzA4jS77SHxciQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: exynos_defconfig: Enable Energy Model framework
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     kgene@kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        Chanwoo Choi <cw00.choi@samsung.com>, robh+dt@kernel.org,
        mark.rutland@arm.com,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, dietmar.eggemann@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 5 Feb 2020 at 13:49, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >> As mentioned in response to patch 1/3. The fist patch would create MC
> >> domain, something different than Energy Model or EAS. The decisions in
> >> the scheduler would be different.
> >>
> >> I can merge 1/3 and 3/3 if you like, though.
> >
> > I understand now that their independent. Still, they are part of one
> > goal to tune the scheduler for Exynos platform. Splitting these looks
> > too much, like enabling multiple drivers one after another.
> >
> > However if you provide numbers for each of cases (before patches, multi
> > core scheduler, energy model with DTS), then I see benefit of splitting
> > it.  Each commit would have its own rationale.  I am not sure if it is
> > worth such investigation - that's just defconfig... distros might ignore
> > it anyway.
>
> Good point, and I agree that it would require more investigation, for
> which unfortunately I don't have currently spare cycles.
>
> Should I merge patch 1/3 and 3/3 and send the v2 with a cover letter
> which would have the test results?

Yes, let's do this way.

Thanks for working on this!

Best regards,
Krzysztof
