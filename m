Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFF098D423
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2019 15:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfHNNDX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Aug 2019 09:03:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:41774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726865AbfHNNDX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Aug 2019 09:03:23 -0400
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70CFC206C2;
        Wed, 14 Aug 2019 13:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565787801;
        bh=3OUlSHJn0lTrnJ5fKTpkrRdkhD4r845rbCuZ5nFCWHQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EDCnd1iWrMYY5eTCyl2C4OcbbG7hwyR/yBNNl1DEgM7rxl2JhllcRp+qc1n1e3wQn
         5m9Cif0BRl33bPWPSpZjlT1ETGRv6XhqJe/99+FqhpGmSNPd3P9/Fkl2Pv/6NY/aJ+
         36HbweNwXt3W5499mCcC2xN0FGArisPikhNobVWE=
Received: by mail-lf1-f44.google.com with SMTP id b29so72023750lfq.1;
        Wed, 14 Aug 2019 06:03:21 -0700 (PDT)
X-Gm-Message-State: APjAAAU84prkwE67YXO9KMSNCfUEUL5OEuW2YWcNB+6G54CcRK09v+pN
        5hZNHDBJJADedFmKc4qS1fbNOJ54BovJan1OSkc=
X-Google-Smtp-Source: APXvYqz10vuC20rP+LQQhwdjZM0MrWzEZ/evwZm1M1ZsrA4lt+zFV303rcMeni4yzkxrQ0voupVR/up/rPG64KZGaEE=
X-Received: by 2002:a19:f512:: with SMTP id j18mr21053059lfb.159.1565787799622;
 Wed, 14 Aug 2019 06:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190813150842eucas1p2c248537d9cd593073e12abeac2cacab5@eucas1p2.samsung.com>
 <20190813150827.31972-1-s.nawrocki@samsung.com>
In-Reply-To: <20190813150827.31972-1-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 14 Aug 2019 15:03:08 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdm2qj_GDR4NQriuOjPFyAxf_CdH_hXEsQNDp4qGHaUZA@mail.gmail.com>
Message-ID: <CAJKOXPdm2qj_GDR4NQriuOjPFyAxf_CdH_hXEsQNDp4qGHaUZA@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Exynos Adaptive Supply Voltage support
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     robh+dt@kernel.org, vireshk@kernel.org, devicetree@vger.kernel.org,
        kgene@kernel.org, pankaj.dubey@samsung.com,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 13 Aug 2019 at 17:08, Sylwester Nawrocki <s.nawrocki@samsung.com> w=
rote:
>
> This is third iteration of my patch series adding ASV (Adaptive Supply
> Voltage) support for Exynos SoCs. The previous one can be found at:
> https://lore.kernel.org/lkml/20190718143044.25066-1-s.nawrocki@samsung.co=
m
>
> There is no major changes in this series comparing to v2, only minor
> corrections addressing review comments.
>
> I was not sure it was a good idea to try to extend the OPP binding
> so as to include the ASV data tables in DT, so the tables are left
> in the driver.
>
> This patch set includes Exynos CHIPID driver posted by Pankaj Dubey and
> futher improved by Bart=C5=82omiej =C5=BBo=C5=82nierkiewicz [1].
>
> Tested on Odroid XU3, XU3 Lite, XU4.
>
> One of the things on TODO list is support for the Adaptive Body Bias.
> This will require modifications on the cpufreq driver side in order to
> support multiple voltage regulators and changes in the OPP framework
> to support adding OPPs with multiple voltages.
>
> [1] https://lkml.org/lkml/2018/11/15/908
>
> Pankaj Dubey (3):
>   soc: samsung: Add exynos chipid driver support
>   ARM: EXYNOS: enable exynos_chipid for ARCH_EXYNOS
>   ARM64: EXYNOS: enable exynos_chipid for ARCH_EXYNOS
>
> Sylwester Nawrocki (6):
>   soc: samsung: Convert exynos-chipid driver to use the regmap API
>   soc: samsung: Add Exynos Adaptive Supply Voltage driver
>   ARM: EXYNOS: Enable exynos-asv driver for ARCH_EXYNOS
>   soc: samsung: Update the CHIP ID DT binding documentation
>   ARM: dts: Add "syscon" compatible string to chipid node
>   ARM: dts: Add samsung,asv-bin property for odroidxu3-lite

All look good to me but I need acks for bindings before applying.

Best regards,
Krzysztof
