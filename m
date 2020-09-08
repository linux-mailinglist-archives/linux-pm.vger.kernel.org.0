Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42712261659
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 19:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732056AbgIHRJu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 13:09:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731812AbgIHRJo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Sep 2020 13:09:44 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75B6421924;
        Tue,  8 Sep 2020 17:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599584983;
        bh=6NFe0ymOhoqmib9dZ3TJK/YVGzpwyBIPD6QNXwYX8UY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mEOZY60QPhE7P0G9fDleoicJlosE0kdMqazDE59cEpI3AaF6rOo+YSIy/7T94gwnn
         ivR9jr/Ak+vHTJ5zLH7ZzWDIrqU30dceu/CPIMczpsa19WzNYdlxNgFDhPIBZ9qp6n
         x2t59Sv1jfj1flMANuF+WxRHwsDvoi3XRzbx8fW4=
Received: by mail-ot1-f46.google.com with SMTP id a65so15477445otc.8;
        Tue, 08 Sep 2020 10:09:43 -0700 (PDT)
X-Gm-Message-State: AOAM530iJ/UlHgWO6be21zDy72njzyuihZGKsSti0OHrB1BGXmw0Ttkr
        CFDfkPSiTPfMkHIgM0JDy34OzLYvmN+eoKkVlw==
X-Google-Smtp-Source: ABdhPJwHvRobpy4sNP5E9Yg1dDeCFskCK1HpqEtpykR12ltq7YM6SYurKbQYjTYNf+T1ZSWapNAMuvoOnGPsoD0q7yw=
X-Received: by 2002:a9d:411:: with SMTP id 17mr45450otc.192.1599584982696;
 Tue, 08 Sep 2020 10:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200830185356.5365-1-digetx@gmail.com> <20200830185356.5365-2-digetx@gmail.com>
 <20200903161022.GA2707794@bogus> <790dbb23-7422-887a-3f11-5ae55bb916fa@gmail.com>
 <CAL_Jsq+Ue72jJ9gurcG0f_R+gGVC77dErhgbKpB_p40buUewLg@mail.gmail.com> <40e34696-5af8-a3da-35f2-483a0dacd835@gmail.com>
In-Reply-To: <40e34696-5af8-a3da-35f2-483a0dacd835@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 8 Sep 2020 11:09:31 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+mE5gv6srBQgoNFehMx2RdxTpxeE9+y2uhfNGZAT_yFw@mail.gmail.com>
Message-ID: <CAL_Jsq+mE5gv6srBQgoNFehMx2RdxTpxeE9+y2uhfNGZAT_yFw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: mfd: Add ENE KB930 Embedded
 Controller binding
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 4, 2020 at 9:54 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 04.09.2020 18:40, Rob Herring =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Fri, Sep 4, 2020 at 6:07 AM Dmitry Osipenko <digetx@gmail.com> wrote=
:
> >>
> >> 03.09.2020 19:10, Rob Herring =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> On Sun, 30 Aug 2020 21:53:51 +0300, Dmitry Osipenko wrote:
> >>>> Add binding document for the ENE KB930 Embedded Controller.
> >>>>
> >>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >>>> ---
> >>>>  .../devicetree/bindings/mfd/ene-kb930.yaml    | 66 ++++++++++++++++=
+++
> >>>>  1 file changed, 66 insertions(+)
> >>>>  create mode 100644 Documentation/devicetree/bindings/mfd/ene-kb930.=
yaml
> >>>>
> >>>
> >>>
> >>> My bot found errors running 'make dt_binding_check' on your patch:
> >>>
> >>> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/=
mfd/ene-kb930.example.dt.yaml: battery-cell: 'operating-range-celsius' does=
 not match any of the regexes: '^ocv-capacity-table-[0-9]+$', 'pinctrl-[0-9=
]+'
> >>>       From schema: /builds/robherring/linux-dt-review/Documentation/d=
evicetree/bindings/power/supply/battery.yaml
> >>>
> >>>
> >>> See https://patchwork.ozlabs.org/patch/1354004
> >>>
> >>> If you already ran 'make dt_binding_check' and didn't see the above
> >>> error(s), then make sure dt-schema is up to date:
> >>>
> >>> pip3 install git+https://github.com/devicetree-org/dt-schema.git@mast=
er --upgrade
> >>>
> >>> Please check and re-submit.
> >>>
> >>
> >> Apparently bot uses outdated kernel.
> >
> > It's on v5.9-rc2. The scripts don't know your base/dependencies and
> > neither did I because you didn't mention anything here. I do review
> > the errors before spamming people.
>
> The patches are based on the linux-next, hence nothing special here. My
> expectation is that the bot should use the linux-next as well in order
> to prevent such warnings. Is there any reason to why bot not using
> linux-next?

What the bot uses is not the issue. The issue is not stating what your
dependencies are. linux-next is not a stable base. No patches to be
applied should be based on linux-next because there's no maintainer
that can take them if you consider anything in linux-next could be a
dependency. Of course, you're probably just dependent on one
maintainer's tree usually, but whose tree? Am I supposed to figure
that out?

linux-next is frequently broken with respect to binding checks, so it
really doesn't work for the bot. I need a known good base.

Rob
