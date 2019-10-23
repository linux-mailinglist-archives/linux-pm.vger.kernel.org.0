Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E70FE1AD4
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 14:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390366AbfJWMiI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 08:38:08 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:40571 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732361AbfJWMiH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2019 08:38:07 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mn1iT-1hhMMc3M5n-00k6vh; Wed, 23 Oct 2019 14:38:06 +0200
Received: by mail-qt1-f169.google.com with SMTP id c21so31952994qtj.12;
        Wed, 23 Oct 2019 05:38:05 -0700 (PDT)
X-Gm-Message-State: APjAAAXa28NtFAEFUW6SnidXpofqPNF4Vxq07h1T5G20hKnVJn9RCcnm
        VQ1U5HsgteSTYPDpSzvDm0zIgf5l5wQ1Don9OFU=
X-Google-Smtp-Source: APXvYqwrU0Hm/ARLCRvhVBlRdvPlDJSDNuHcJN6+Uj7yxLvAwd8RMgOaHRybpcUhDTeeF+G9vHKE5/Q8Jj1UKOdkvPU=
X-Received: by 2002:ac8:33d4:: with SMTP id d20mr8762581qtb.204.1571834284536;
 Wed, 23 Oct 2019 05:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20191010202802.1132272-1-arnd@arndb.de> <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-7-arnd@arndb.de> <20191023105443.GE10630@pi3>
In-Reply-To: <20191023105443.GE10630@pi3>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 23 Oct 2019 14:37:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3wxaUR4Nx9a6JBu3DjtJ90ZRH6+-V8-g=6mcEih34Qnw@mail.gmail.com>
Message-ID: <CAK8P3a3wxaUR4Nx9a6JBu3DjtJ90ZRH6+-V8-g=6mcEih34Qnw@mail.gmail.com>
Subject: Re: [PATCH 07/36] ARM: exynos: use private samsung_cpu_id copy
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ydxnAjczRmpEVHq9idE6IIO5Ej74MDqmZQw7G5DlncMTbmGMrcr
 JfyhtiMv30n8LnAoYiPIW7tRiMLy51xoMz+B90Fd14MwTGmkr4ilBeAimPgenfwk+IgswFK
 auecWimxODnbLHGGJ9YSxlSVT4DRPGws24B61Z2s+QRxlNT57V2k5jTddK8cIX0mfs4Df7D
 MGhg1A8uU+BXr/J/L+p8Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0jIMjzDYtd8=:mmWobkF0pZBTW9//Ghoukl
 8LHZtqSsbhdWzriGBFYIaKCOA7otOJU8eN/MfI5ePJV4ONU/NrF+Yy2k12ICenxo0TDIU1NU2
 On/9XpSncyWEJkgODJHbambCjSl/658WE68BWn9hIsQkxTkh+weetSUxZIzeR/EvU8TpoM/1T
 CD3PpfkZ4HnCAPxlKTJp9M4+wsLD1N+M5IOjO+kzIV6sa9ZXozgFGgJTdOhS3GAGm/hnxozt2
 YRSFQCk0AST4HIWV0Y6jjebA7wAH+zKiQTeoQ30s2wUNF41Zw8pS5WR+eUL+qfAR15DuX72XN
 pgH7hHDX2evyZyxUKz0CugH3cMXSlQgWQiTQKTP47T+CNCJIHhVUkfs1WyDBrEufebQbedk9/
 lk1GSbQMpQF7sV/wVEDVmWLg1zQdi+dN1qqa9fBzmIjJM7xXB7+oPjyfde+7/l7K0g61Hh0Un
 Wt1v4iJkYQs8uB8dNf5CEHtg3TZGsGwIaLWPDtLKI8XPTHbsscJmfmdipM0bNzW8NWiZEbVwC
 GrxatzcXG03VJH361SdxJVsIMdgQO6iqGCR4JPdcl2Rce5OBqedbpyyW3kw2gCrGERo58517+
 tfBdScGffh1JhwESgBE8X8q3NrMeOvd6wJVf39hEqYv851my4p8x03h/SJOkX3/2zdL+W552L
 HZjmSeXpLJGHCyyHXV9N/WEpE5hShkG8Hx/O9IXwhnIHpxSU4Q1FqbrRqGUzAuQYFQucIDVIb
 wZxAGprE9f5Z82IMgJgJ4DXYvp4jWJ5PaXOUzso2oEwmHYimpWn7id7xnM1zwyMM9uXMGtdKs
 8I2yJieNafyZZEq5uCWtNruV+ej0794JkDlqRSEySa5uupgdZuxeQ1r6OZ/aQv0ZJYLlUcvtk
 QeHyn9auaEx7Px/OIcKw==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 23, 2019 at 12:56 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Thu, Oct 10, 2019 at 10:29:51PM +0200, Arnd Bergmann wrote:
> > diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> > index 9aa483366ebc..da9300d655c6 100644
> > --- a/arch/arm/mach-exynos/exynos.c
> > +++ b/arch/arm/mach-exynos/exynos.c
> >
> > +#define S5P_VA_CHIPID        ((void __iomem __force *)0xF8000000)
>
> How about keeping the S3C_VA and S3C_ADDR_BASE macros/defines and using
> them?

Ok, done now.

> They still appear in arch/arm/include/debug/exynos.S so they could
> be integrated into one header, unless you plan to remove it in further
> patches.

I don't think it actually helps, but it doesn't hurt either:

arch/arm/include/debug/exynos.S cannot #include any mach/*.h header files,
so the definition has to remain duplicated, unless I'm missing something.

Also, the addresses should be completely independent, as long as the virtual
address for the uart does not overlap with the virtual address for the chipid.

One possible cleanup here would be to completely remove the S5P_VA_CHIPID
static map and use ioremap(), but doing that requires that the first call to
soc_is_exynosXXXX() happens after the ioremap.

> > diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
> > index fadcddbea064..02d7f991d5a3 100644
> > --- a/arch/arm/plat-samsung/include/plat/cpu.h
> > +++ b/arch/arm/plat-samsung/include/plat/cpu.h
> > @@ -111,8 +111,6 @@ extern void s3c24xx_init_io(struct map_desc *mach_desc, int size);
> >  extern void s3c64xx_init_cpu(void);
> >  extern void s5p_init_cpu(const void __iomem *cpuid_addr);
>
> You can remove it as well.

Ok, removed.

        Thanks,
