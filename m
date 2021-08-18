Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009633F06BA
	for <lists+linux-pm@lfdr.de>; Wed, 18 Aug 2021 16:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238637AbhHROcK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Aug 2021 10:32:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238113AbhHROcJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Aug 2021 10:32:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 322736102A;
        Wed, 18 Aug 2021 14:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629297094;
        bh=ncrRWgj2Bq2+OHlv1UfRsN4lntRiLI4pzjySr9pdJB0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W0DumQW01xpl6sTklDWzu7F3kNdp+4YVKO72a7WvbtYyrVxKe+xN2qoa/KSj5D3vy
         TJVwmxqHIe2myWWdXMCHt5PSpUvlYML3S0iNePczPFcunVDxKI1vgH7+vMbM/r1OLZ
         vcte50St9PgwKlLH7O3mIIMVaEZEMoPS2j8gGxfW3V4SaDKetiwB8LVK4KRCj01llg
         k7x1N21YHeArDL6SUDhhdk7PoylDWjpwTomlHLiJQ+KBupaxqIqSpC5cYsyEVcqe7Q
         m0A0GbE6fJrSh6YKFmP2SUUzVLK/pxEgCLUZRDYSfUZUOIBICHJVJgKXlFWiwu/7i7
         fmtOb5s3/LdJQ==
Received: by mail-ej1-f49.google.com with SMTP id bq25so5429814ejb.11;
        Wed, 18 Aug 2021 07:31:34 -0700 (PDT)
X-Gm-Message-State: AOAM5322JHaywkGUZJvpI81t9QwA/mzzkqD0y6YLXV0cnGxm5GTTsrq7
        xBHqQsOBoI4mldQ7KzNe9Us9MQ2PyOX8xAbk8w==
X-Google-Smtp-Source: ABdhPJyykdC+jiKpEM2YAMM63v5jb9SS1uxnZS8MhiM92coZtkLMMJguta0ERfWBr+mToxXid9kpz5kSsVLml9mESAU=
X-Received: by 2002:a17:907:393:: with SMTP id ss19mr10439349ejb.468.1629297092760;
 Wed, 18 Aug 2021 07:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210813125414.104467-1-krzysztof.kozlowski@canonical.com>
 <73eebe7b-46da-137b-1938-09a5b453320a@arm.com> <0ec05a0b-9499-3bf4-a231-ea53b1cf99ed@canonical.com>
In-Reply-To: <0ec05a0b-9499-3bf4-a231-ea53b1cf99ed@canonical.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 18 Aug 2021 09:31:21 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLOHY0P=Y8-Ss0cYr54SWgpV0zktEg8p-Cj_F+juDQNoA@mail.gmail.com>
Message-ID: <CAL_JsqLOHY0P=Y8-Ss0cYr54SWgpV0zktEg8p-Cj_F+juDQNoA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: memory: convert Samsung Exynos DMC to dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 16, 2021 at 3:32 AM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 16/08/2021 09:53, Lukasz Luba wrote:
> > Hi Krzysztof,
> >
> > On 8/13/21 1:54 PM, Krzysztof Kozlowski wrote:
> >> Convert Samsung Exynos5422 SoC frequency and voltage scaling for
> >> Dynamic Memory Controller to DT schema format using json-schema.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> >> ---
> >>   .../memory-controllers/exynos5422-dmc.txt     |  84 -----------
> >>   .../samsung,exynos5422-dmc.yaml               | 137 ++++++++++++++++++
> >>   MAINTAINERS                                   |   2 +-
> >
> > I'm not an expert in this DT scripts and why it complains. Maybe it
> > complains because the "samsung,exynos-ppmu" is defined in the .txt
> > file... (?)
> > Although, in general looks OK.
> >
> > Acked-by: Lukasz Luba <lukasz.luba@arm.com>
>
> I think the warning (triggered by DT_CHECKER_FLAGS=-m) can be ignored
> because it complains about compatible in example which is not present in
> the bindings. Usually it means someone wrote example not matching the
> bindings (e.g. a typo in compatible) but here it is on purpose.

Ultimately, it will mean the binding is undocumented (or a typo). But
right now, it means the binding is undocumented with a schema. It's
off by default because there's still about 80 warnings. It's turned on
for the bot so we don't add more. So please don't ignore it.

Rob
