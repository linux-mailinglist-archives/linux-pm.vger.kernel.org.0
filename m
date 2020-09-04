Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB4A25DDF4
	for <lists+linux-pm@lfdr.de>; Fri,  4 Sep 2020 17:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgIDPkW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Sep 2020 11:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgIDPkV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 4 Sep 2020 11:40:21 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D35A32083B;
        Fri,  4 Sep 2020 15:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599234021;
        bh=UAR/0+WFmx8OVQKEUwR8M1ofPElVR/g3UzxICkFCKa4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XXSyBms+Ca+wqhd/Owwo8OB3AEqdJWufDnkclusdhZfyjyemCCzGb13/xxFFrb9TD
         Fe96Rax76Q56c9WfwykrKBT9XDVkIp+LJNE1A3HJW3e5Ve5rg1S7AFxQF0nnVf9tq6
         xFmAvBOpL4zY2mpE9zoyOI4e+QYjjAPUaNrXVOZ8=
Received: by mail-ot1-f49.google.com with SMTP id i4so6269733ota.2;
        Fri, 04 Sep 2020 08:40:20 -0700 (PDT)
X-Gm-Message-State: AOAM533cl7hIIW55Xh1k5dF2U3zMZ1cy/IJ7R5K1wT6K8ISZ/4HiIwbd
        TzCCfHALMjZ3x2qKG+d4sWQQOO9rqaoYadqqEw==
X-Google-Smtp-Source: ABdhPJw1oaweJSOxp/Hs5WNuevPNIBfXtJv/Gk75Q/8Ya70E8+SBi0EbnW3JC3c/w3BVO1X3ug9F5KaKGeMyOUtsdss=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr5930304otp.129.1599234019987;
 Fri, 04 Sep 2020 08:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200830185356.5365-1-digetx@gmail.com> <20200830185356.5365-2-digetx@gmail.com>
 <20200903161022.GA2707794@bogus> <790dbb23-7422-887a-3f11-5ae55bb916fa@gmail.com>
In-Reply-To: <790dbb23-7422-887a-3f11-5ae55bb916fa@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 4 Sep 2020 09:40:07 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+Ue72jJ9gurcG0f_R+gGVC77dErhgbKpB_p40buUewLg@mail.gmail.com>
Message-ID: <CAL_Jsq+Ue72jJ9gurcG0f_R+gGVC77dErhgbKpB_p40buUewLg@mail.gmail.com>
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

On Fri, Sep 4, 2020 at 6:07 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 03.09.2020 19:10, Rob Herring =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Sun, 30 Aug 2020 21:53:51 +0300, Dmitry Osipenko wrote:
> >> Add binding document for the ENE KB930 Embedded Controller.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  .../devicetree/bindings/mfd/ene-kb930.yaml    | 66 ++++++++++++++++++=
+
> >>  1 file changed, 66 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/mfd/ene-kb930.ya=
ml
> >>
> >
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
> >
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mf=
d/ene-kb930.example.dt.yaml: battery-cell: 'operating-range-celsius' does n=
ot match any of the regexes: '^ocv-capacity-table-[0-9]+$', 'pinctrl-[0-9]+=
'
> >       From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/power/supply/battery.yaml
> >
> >
> > See https://patchwork.ozlabs.org/patch/1354004
> >
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure dt-schema is up to date:
> >
> > pip3 install git+https://github.com/devicetree-org/dt-schema.git@master=
 --upgrade
> >
> > Please check and re-submit.
> >
>
> Apparently bot uses outdated kernel.

It's on v5.9-rc2. The scripts don't know your base/dependencies and
neither did I because you didn't mention anything here. I do review
the errors before spamming people.

Rob
