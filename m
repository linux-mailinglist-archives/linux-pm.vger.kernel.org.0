Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE85E64409
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2019 11:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfGJJBI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 05:01:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727663AbfGJJBH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Jul 2019 05:01:07 -0400
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29592208C4;
        Wed, 10 Jul 2019 09:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562749266;
        bh=wJ4UybqhWF4GHysL0HzNpEbCXWrP9PdCHa4n5QXVa+k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iw+A8s5irXEma3Z1l7JBvR7lj9Z4gfTmGjpyXPgCDIRUztCLU1SSaxwjc7MFjyLDV
         pdcoYxskBQ0VQ1hd6Ttl0HP5tscMckWqQuwCSUfwE5YNKCV+tTCvP5Rr0lqPHSQnb7
         LAH9dCfPgkFRLpqC5Ja379xIVqunhX3veJB1GPvQ=
Received: by mail-lj1-f175.google.com with SMTP id k18so1262342ljc.11;
        Wed, 10 Jul 2019 02:01:06 -0700 (PDT)
X-Gm-Message-State: APjAAAWhTp/gfefqiYVGeV6LDljaYA9GjVOns7+DvZ94QEr4hFropKqQ
        Mwfb0hteC4qIIc1zMeSjcV4vZlJ3Zo/K/QM453w=
X-Google-Smtp-Source: APXvYqySTqN+a0Pd632KuRg+HHS06nuFlFkBnJ+6eD7MYISsnc9zgvNILpGXeTB3FUo87vj9BNr4HWlVIikw8EUIrzQ=
X-Received: by 2002:a2e:980a:: with SMTP id a10mr14216019ljj.40.1562749264412;
 Wed, 10 Jul 2019 02:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190708141158eucas1p17d4b50978dbe1e5c876ce6d8f433cc95@eucas1p1.samsung.com>
 <20190708141140.24379-1-k.konieczny@partner.samsung.com>
In-Reply-To: <20190708141140.24379-1-k.konieczny@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 10 Jul 2019 11:00:53 +0200
X-Gmail-Original-Message-ID: <CAJKOXPd+UZ2MdrTVfBv5UYzK5LgKNQHUFzRbRNeq271EaDSchg@mail.gmail.com>
Message-ID: <CAJKOXPd+UZ2MdrTVfBv5UYzK5LgKNQHUFzRbRNeq271EaDSchg@mail.gmail.com>
Subject: Re: [PATCH 0/3] add coupled regulators for Exynos5422/5800
To:     k.konieczny@partner.samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 8 Jul 2019 at 16:12, <k.konieczny@partner.samsung.com> wrote:
>
> From: Kamil Konieczny <k.konieczny@partner.samsung.com>
>
> Hi,
>
> The main purpose of this patch series is to add coupled regulators for
> Exynos5422/5800 to keep constrain on voltage difference between vdd_arm
> and vdd_int to be at most 300mV. In exynos-bus instead of using
> regulator_set_voltage_tol() with default voltage tolerance it should be
> used regulator_set_voltage_triplet() with volatege range, and this is
> already present in opp/core.c code, so it can be reused. While at this,
> move setting regulators into opp/core.
>
> This patchset was tested on Odroid XU3.
>
> The last patch depends on two previous.

So you break the ABI... I assume that patchset maintains
bisectability. However there is no explanation why ABI break is needed
so this does not look good...

Best regards,
Krzysztof

>
> Regards,
> Kamil
>
> Kamil Konieczny (2):
>   opp: core: add regulators enable and disable
>   devfreq: exynos-bus: convert to use dev_pm_opp_set_rate()
>
> Marek Szyprowski (1):
>   ARM: dts: exynos: add initial data for coupled regulators for
>     Exynos5422/5800
>
>  arch/arm/boot/dts/exynos5420.dtsi             |  34 ++--
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi |   4 +
>  arch/arm/boot/dts/exynos5800-peach-pi.dts     |   4 +
>  arch/arm/boot/dts/exynos5800.dtsi             |  32 ++--
>  drivers/devfreq/exynos-bus.c                  | 172 +++++++-----------
>  drivers/opp/core.c                            |  13 ++
>  6 files changed, 120 insertions(+), 139 deletions(-)
>
> --
> 2.22.0
>
