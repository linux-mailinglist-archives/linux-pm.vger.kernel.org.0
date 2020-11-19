Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFBA2B9089
	for <lists+linux-pm@lfdr.de>; Thu, 19 Nov 2020 12:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgKSLAc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Nov 2020 06:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgKSLAc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Nov 2020 06:00:32 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F15C0613CF;
        Thu, 19 Nov 2020 03:00:32 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id v22so5350081edt.9;
        Thu, 19 Nov 2020 03:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Av5BBTuM7evlD9VDFh0arYTaJ+OsyfG556KZW1pXB0Y=;
        b=TiFxYI1bViNz37ZEsTLEkKJY3THx8Px85R0+qnM2hQGrayt7lfRBlVaQh7pKVY2ByR
         hec8Phqn/3AmEmZdZsDFZ15adLWjKVvWrV/WVfY9GxIPz0etf77yD7g6BhKwAzLFig/R
         krRauaKrbzszuL/ccEd1O/n4hX6QoHCpFHsgZFNr0wD8NmWVBM13vFYHWH7mbg4YEqJv
         zaTM2pC9NbLdU1WrBthq0XOgGxOlgLKQcD4Vcd2t6tPWPD6kqQR48wkCXr9gQSUXnl7b
         hoI2djvVEFF9IWhsUC3WTJTmuojU3qZcknGKqwyCmIFjMh3iQF8xbw3qmckLXLyYAnhL
         LVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Av5BBTuM7evlD9VDFh0arYTaJ+OsyfG556KZW1pXB0Y=;
        b=pz48BvyGg313ia6iNa9GXrkEYpb++jbc9wjnUaGj2+51ivrZrW4rbvMM90+3TSbHa3
         +ufN6OLzBNFOQ6tgLL9jzyOMAG1+Oi4uk4jmfClSititd2Aeo1binBgF0x7cNBiUA2Kk
         tYrYloUwz2wXBeqtp1bPxHd3KGlT3Il8ylkGr3BQxoD16HoUtidHLIhckcMfSK1SUFJD
         873G920I80AOeXs9pObVT+nUE2mMZW8OckOvO6WH9tRvj19B9KNoNBY1lim+FlxYcxbH
         ISSNjUrovfhpGZM6aTqazcpm4ykZCJbo1eq677N6Lo/XydcnovoOc6iStFp57xIcyoLa
         1TNg==
X-Gm-Message-State: AOAM532igl1GYo1RjspgSKUE5NonDX5pLb2b8BinW/3JUUgXn7rsw79R
        zzhbX3gXiw4kUYrURqbWKWyatjXzJ6WMRx1S/sU=
X-Google-Smtp-Source: ABdhPJwN/JLb7YSmhKyM+E3M5dXfAHScFA1CNYKfSOJmfUGoTa9bYF+YAHGrJLRmY2GEjm1y8Gj+sOwI3plcEp6Rb5U=
X-Received: by 2002:a05:6402:2365:: with SMTP id a5mr577181eda.268.1605783631085;
 Thu, 19 Nov 2020 03:00:31 -0800 (PST)
MIME-Version: 1.0
References: <20200927150956.34609-1-kwizart@gmail.com>
In-Reply-To: <20200927150956.34609-1-kwizart@gmail.com>
From:   Nicolas Chauvet <kwizart@gmail.com>
Date:   Thu, 19 Nov 2020 12:00:19 +0100
Message-ID: <CABr+WTnftetrMzC8bq+=RqOxqJ9EvYsU1LEZ5bVv-OptVksbjA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] thermal: tegra: soctherm bugfixes
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Le dim. 27 sept. 2020 =C3=A0 17:10, Nicolas Chauvet <kwizart@gmail.com> a =
=C3=A9crit :
>
> When using tegra_soctherm driver on jetson-tk1, the following messages
> can be seen:
> from kernel: tegra_soctherm 700e2000.thermal-sensor:
>  throttle-cfg: heavy: no throt prop or invalid prop
>  soctherm: trip temperature -2147483647 forced to -127000
>  thermtrip: will shut down when cpu reaches 101000 mC
>  soctherm: trip temperature -2147483647 forced to -127000
>  thermtrip: will shut down when gpu reaches 101000 mC
>  soctherm: trip temperature -2147483647 forced to -127000
>  thermtrip: will shut down when pll reaches 103000 mC
>  throttrip: pll: missing hot temperature
>  soctherm: trip temperature -2147483647 forced to -127000
>  thermtrip: will shut down when mem reaches 101000 mC
>  throttrip: mem: missing hot temperature
>  IRQ index 1 not found
>
> This serie fixes two errors and two warnings that are reported in dmesg
> It was compiled and tested at runtime on jetson-tk1 only.
>
>
> v2:
>  * Add missing tegra210 device-tree properties
>  * Add the appropriate prefix for tegra soctherm
>  * Use SoCs condition over of_compatible
>
>
> Nicolas Chauvet (6):
>   ARM: tegra: Add missing gpu-throt-level to tegra124 soctherm
>   ARM: tegra: Add missing hot temperatures to tegra124 thermal-zones
>   arm64: tegra: Add missing hot temperatures to tegra132 thermal-zones
>   arm64: tegra: Add missing gpu-throt-level to tegra210 soctherm
>   arm64: tegra: Add missing hot temperatures to tegra210 thermal-zones
>   thermal: tegra: Avoid setting edp_irq when not relevant
>
>  arch/arm/boot/dts/tegra124.dtsi           | 11 +++++++
>  arch/arm64/boot/dts/nvidia/tegra132.dtsi  | 10 ++++++
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi  | 13 ++++++++
>  drivers/thermal/tegra/soctherm.c          | 38 +++++++++++++----------
>  drivers/thermal/tegra/soctherm.h          |  1 +
>  drivers/thermal/tegra/tegra124-soctherm.c |  1 +
>  drivers/thermal/tegra/tegra132-soctherm.c |  1 +
>  drivers/thermal/tegra/tegra210-soctherm.c |  1 +
>  8 files changed, 60 insertions(+), 16 deletions(-)
>
> --
> 2.25.4

Hello,
This series is still pending review.

Thierry, do you expect some reviewers from the linux-pm (Zhang, Daniel ?)
To me it seems like tegra specific changes, so maybe a Nvidia reviewer
is awaited ?

Thanks.
