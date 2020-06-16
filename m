Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C2E1FC08A
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jun 2020 23:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgFPU6M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jun 2020 16:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgFPU6M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jun 2020 16:58:12 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA5EC061573;
        Tue, 16 Jun 2020 13:58:11 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id a13so3341511ilh.3;
        Tue, 16 Jun 2020 13:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FYZcH9YCAV2D9xJRlKDws3xYJbeunSuHP5OJ4xopk5U=;
        b=sMF4Sz7iAfVFIns3sFM03xAVLeLz7qz67oG6nGIOlyZZ3O/RM8u2Pn9IjPPyKjEhkz
         rUVI5YzGAv9LDyXBpmtn6ltuOy+cEhjBA5e+dz5AjMAGLGNFZ9JpZk9Dc+RbOo9yGVkk
         YKpLnn0Tt7F0qK+LyZWtmDVYLtg6hqJ778mTjGl5/YueUBiU8X3OJSpI9T2LWsi/dm1R
         128cAkSgho2OWRjjKjr4ZwtJzNkxCliHWC4Rfr/6gThIGFsIevcMtr2vc1y2FJb4F9AT
         2IG3BhZaAI5FJox/mINW4hJenvrhvylvAz7q8DisookNHWadKuEZfYFp7A5M9zpAnbn8
         lI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FYZcH9YCAV2D9xJRlKDws3xYJbeunSuHP5OJ4xopk5U=;
        b=FdRdnmBkutc1uQaabq5NnCwesyheqbAyJQpJYHQTbwRjBct4oESiwh2DcKbm/ltTWw
         1lyWffeWdPpKpUR1xJRmXq1Pf7xGO2ENUz/MO6SVivPy8W7TOJczoSUci6nkTdMkC4MO
         MAqpKfk7VOogfgBWxgJlwGARZf4zG2pJ0A6BO5cPv3f0sMidoIAiv6E0pjPZ5stVrWFo
         uNGdWOW7lo4ff85/mBhs1ErlWadciymjHToqYzKrch9v/zoQBjrWGApr7b/VD7bET2qG
         8DGU5hq/JlUhvliOIair9LWJmWQcaeR2QaBW7FS2XHqXJd0dBMM6dYsa8NktQxgkM5x6
         SiOQ==
X-Gm-Message-State: AOAM530Z4F/NEaPoG8p7OLFjdKT2Nm0FqBof+KDLAptRaDuKUAPo68Yd
        qEYsm8He9sN4K1yojVpAHkTiew0sQNEvNiDk7UM=
X-Google-Smtp-Source: ABdhPJw7r9fTtiY0V63BhtDgkS/1VuVZSmoZam4NKdSyg6P5i4KlsKliKnLpusFiTessmcmOsEUwrNO8miMsJEyN4oY=
X-Received: by 2002:a92:de10:: with SMTP id x16mr5352212ilm.6.1592341091058;
 Tue, 16 Jun 2020 13:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200616081248eucas1p168faa343ce333a28c8fd3cf9a6a58b3c@eucas1p1.samsung.com>
 <20200616081230.31198-1-m.szyprowski@samsung.com>
In-Reply-To: <20200616081230.31198-1-m.szyprowski@samsung.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 17 Jun 2020 02:28:01 +0530
Message-ID: <CANAwSgStsYP5fBB7z7-Reo2BP4ZQPT6RN4s8QdLGVGhKCDA_Ng@mail.gmail.com>
Subject: Re: [PATCH 0/4] Restore big.LITTLE cpuidle driver for Exynos
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Marek,

On Tue, 16 Jun 2020 at 13:44, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> The ARM big.LITTLE cpuidle driver has been enabled and tested on Samsung
> Exynos 5420/5800 based Peach Pit/Pi Chromebooks and in fact it worked
> only on those boards.
>
> However, support for it was broken by the commit 833b5794e330 ("ARM:
> EXYNOS: reset Little cores when cpu is up") and then never enabled in the
> exynos_defconfig. This patchset provides the needed fix to the common
> code and restores support for it. Thanks to Lukasz Luba who motivated me
> to take a look into this issue.
>
Thanks for this updates.

But I feel some DTS changes are missing for example
d2e5c871ed8a drivers: cpuidle: initialize big.LITTLE driver through DT

But I feel that this feature is not working as desired since
still some missing code changes for cluster idle states are missing.
like clock  PWR_CTR and PWR_CTRL2.

-Anand

> Best regards
> Marek Szyprowski
> Samsung R&D Institute Poland
>
>
> Patch summary:
>
> Marek Szyprowski (4):
>   ARM: exynos: Apply little core workaround only under secure firmware
>   cpuidle: big.LITTLE: enable driver only on Peach-Pit/Pi Chromebooks
>   ARM: exynos_defconfig: Enable big.LITTLE cpuidle driver
>   ARM: multi_v7_defconfig: Enable big.LITTLE cpuidle driver
>
>  arch/arm/configs/exynos_defconfig    |  1 +
>  arch/arm/configs/multi_v7_defconfig  |  1 +
>  arch/arm/mach-exynos/mcpm-exynos.c   | 10 +++++++---
>  drivers/cpuidle/cpuidle-big_little.c |  3 +--
>  4 files changed, 10 insertions(+), 5 deletions(-)
>
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
