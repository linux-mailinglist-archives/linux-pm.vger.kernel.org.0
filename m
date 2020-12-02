Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54BA2CBCF0
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 13:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgLBMYa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 07:24:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:52640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727178AbgLBMY3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Dec 2020 07:24:29 -0500
X-Gm-Message-State: AOAM5332nu8oqb9AUF/wU4smTGw+zRxL5LunjezBxuIe0+WhBpP2O1iu
        gCqISMUsTbCGJ7/35AQny9XiEJUNrJ+l2syF3SU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606911828;
        bh=oa7UfaUP3+xFmxloS25xR2K5dpFVJxrXIk+MwfRXBZY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kMYogxUxKcXGs8GpKM6ZF0u8wOqW40HJn37gmHCJ05psgxxLAWTqbWZG3VVd3lb5h
         BT6eP1XaVpPlfZtkGeith70uOCd+7pFPBR5AvF5ah9Br2QX/wqk+SYAsxXAuqWpet6
         ngzACC+1cd6PJF6hT572GomlYn5YFUWQ9rpzsbO4=
X-Google-Smtp-Source: ABdhPJyC/BitHigFIbOKUBueddX1xbZID1vUveQ/Aj0NJNpD8QfuK7AsqevTSakwULDKnR7Term8eac0hqFIyj83LOs=
X-Received: by 2002:a05:6402:31b6:: with SMTP id dj22mr2256983edb.348.1606911826521;
 Wed, 02 Dec 2020 04:23:46 -0800 (PST)
MIME-Version: 1.0
References: <20201201123932.12312-1-martin.kepplinger@puri.sm>
 <20201201123932.12312-8-martin.kepplinger@puri.sm> <cb498c2c-e052-390a-c64a-2be44d1d2b42@linaro.org>
 <a2c0fae4-13c5-9114-876f-bc324138e6cc@puri.sm> <20201202080321.GB6087@kozik-lap>
 <CAJKOXPcAbmugB9k-1Ldo=Q1J0CbOcxMtgC005w=DmWukThVcWA@mail.gmail.com> <226e76a8-011e-ece5-d8fa-b52dbc81787b@puri.sm>
In-Reply-To: <226e76a8-011e-ece5-d8fa-b52dbc81787b@puri.sm>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 2 Dec 2020 14:23:34 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc6BEw3A+pO9HOK4h59jZ2_TEfKcz79f7PbkPhJdPhE_w@mail.gmail.com>
Message-ID: <CAJKOXPc6BEw3A+pO9HOK4h59jZ2_TEfKcz79f7PbkPhJdPhE_w@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] arm64: defconfig: Enable interconnect for imx8mq
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>, robh@kernel.org,
        shawnguo@kernel.org, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, cdleonard@gmail.com, kernel@pengutronix.de,
        linux-imx@nxp.com, kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2 Dec 2020 at 13:30, Martin Kepplinger
<martin.kepplinger@puri.sm> wrote:
> >>>>> -CONFIG_INTERCONNECT=y
> >>>>
> >>>> Why are you removing this line?
> >>>
> >>> savedefconfig removes it. INTERCONNECT_IMX below depends on it.
> >>
> >> It's save to remove it as other Interconnect options are directly
> >> dependant.
> >
> > Ugh, my bad, it is not allowed to remove it. My review was too fast.
> > INTERCONNECT_IMX depends on it, so the INTERCONNECT must stay,
> >
> > It is selected by TEGRA_MC which is independent here, so you should keep it.
> >
>
> thanks for reviewing! Just to be clear: We're talking about defconfig,
> so if I keep INTERCONNECT that means that I do `make savedefconfig`
> which removes it (it's of course still enabled, just redundant in
> defconfig output), and then *manually* add INTERCONNECT. That would
> indicate that there's a Kconfig bug.

I don't get the point. You should not send the savedefconfig output as
is, without any adjustments and checks. You can run savedefconfig
because it nicely puts your entries in the proper place, but it's not
a bug  that it removes features which we *want to keep*. Where is a
bug in Kconfig?

Best regards,
Krzysztof
