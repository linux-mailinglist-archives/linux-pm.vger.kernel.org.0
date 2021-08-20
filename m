Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4571A3F2D2D
	for <lists+linux-pm@lfdr.de>; Fri, 20 Aug 2021 15:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhHTNcf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Aug 2021 09:32:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231650AbhHTNcf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 20 Aug 2021 09:32:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5784B61130;
        Fri, 20 Aug 2021 13:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629466317;
        bh=flH25F+TTMbb26RM+9KRiRwMhiahdmc88FEXT4P9Da8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JixvCAUgFLad9puk0BvheLUgbsEhE+TYMyun4Axhm5O6rfTplqvauZVe0XuLvbjsK
         xiYjUZgukagWOTrH36McpNsFke9BgOhsSeYXFIlsxoPiB7db1PU6uqRabJpC0cTyzR
         doGskhBkubYujeiNHNOGc377WBVb/Qo+W4N9QoYDgHvbms2sXGm+ULbgCUgF6tiXLE
         Xvg4m67Ttmsi4+gbmY0uz//DRAJDO476rVBsEUKmTIPqA/DOgsU28klg3B2z+WVa1+
         QNKOuoeBTjvhdXJLHhp026jtgckqpRmMnEibOB1v3MY6YDnUiGBATk+NJRLLyE2icZ
         K8fo8vjaOQuPw==
Received: by mail-ej1-f45.google.com with SMTP id lo4so20243089ejb.7;
        Fri, 20 Aug 2021 06:31:57 -0700 (PDT)
X-Gm-Message-State: AOAM5324LJUfh/+6V14RnMGaqij6cWF3F/RSlUnLy1oN6DIhollbDvM/
        FEknp27k4EJSJGo86utk0YP2vDebBqY7vvYKHA==
X-Google-Smtp-Source: ABdhPJxcwX6J+xKLTdo24oHcgfnCsZhLEWql7EghchrvXYGlT46uPqvu2EfHTt8E3Cv8Nu6FOiWaifZePdaCS9kuu3E=
X-Received: by 2002:a17:907:393:: with SMTP id ss19mr22486666ejb.468.1629466316006;
 Fri, 20 Aug 2021 06:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210813125414.104467-1-krzysztof.kozlowski@canonical.com>
 <73eebe7b-46da-137b-1938-09a5b453320a@arm.com> <0ec05a0b-9499-3bf4-a231-ea53b1cf99ed@canonical.com>
 <CAL_JsqLOHY0P=Y8-Ss0cYr54SWgpV0zktEg8p-Cj_F+juDQNoA@mail.gmail.com> <aaa53a2a-c15b-8017-4e44-dd3f883b2378@canonical.com>
In-Reply-To: <aaa53a2a-c15b-8017-4e44-dd3f883b2378@canonical.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 20 Aug 2021 08:31:43 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+iG1t=yxsyp2whd_L4p=9udrSvZMiy-y75ppcLYK9acA@mail.gmail.com>
Message-ID: <CAL_Jsq+iG1t=yxsyp2whd_L4p=9udrSvZMiy-y75ppcLYK9acA@mail.gmail.com>
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

On Wed, Aug 18, 2021 at 9:43 AM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 18/08/2021 16:31, Rob Herring wrote:
> > On Mon, Aug 16, 2021 at 3:32 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@canonical.com> wrote:
> >>
> >> On 16/08/2021 09:53, Lukasz Luba wrote:
> >>> Hi Krzysztof,
> >>>
> >>> On 8/13/21 1:54 PM, Krzysztof Kozlowski wrote:
> >>>> Convert Samsung Exynos5422 SoC frequency and voltage scaling for
> >>>> Dynamic Memory Controller to DT schema format using json-schema.
> >>>>
> >>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> >>>> ---
> >>>>   .../memory-controllers/exynos5422-dmc.txt     |  84 -----------
> >>>>   .../samsung,exynos5422-dmc.yaml               | 137 ++++++++++++++++++
> >>>>   MAINTAINERS                                   |   2 +-
> >>>
> >>> I'm not an expert in this DT scripts and why it complains. Maybe it
> >>> complains because the "samsung,exynos-ppmu" is defined in the .txt
> >>> file... (?)
> >>> Although, in general looks OK.
> >>>
> >>> Acked-by: Lukasz Luba <lukasz.luba@arm.com>
> >>
> >> I think the warning (triggered by DT_CHECKER_FLAGS=-m) can be ignored
> >> because it complains about compatible in example which is not present in
> >> the bindings. Usually it means someone wrote example not matching the
> >> bindings (e.g. a typo in compatible) but here it is on purpose.
> >
> > Ultimately, it will mean the binding is undocumented (or a typo). But
> > right now, it means the binding is undocumented with a schema. It's
> > off by default because there's still about 80 warnings. It's turned on
> > for the bot so we don't add more. So please don't ignore it.
> >
>
> By "Ignore" I meant here that it is a false positive, so it can be
> ignored. The warning is about compatible "samsung,exynos-ppmu" used in
> the example. However this exynos-ppmu is not part of this bindings and
> is documented elsewhere:
> Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt

Yes, I understood all that. Let me be clear. I don't want examples
which don't have a schema. So drop the node or convert
exynos-ppmu.txt.

First, when we do add a schema, then we likely have to go fix the
examples. It happens a lot and is not caught with folks using
DT_SCHEMA_FILES. Second, I don't like reporting errors that users
should have gotten by default. We can't turn this check on by default
until the 80 or so cases we already have in the binding examples are
fixed.

Rob
