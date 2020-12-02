Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0127D2CB64E
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 09:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387823AbgLBIGH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 03:06:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:50558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387654AbgLBIGH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Dec 2020 03:06:07 -0500
X-Gm-Message-State: AOAM5328qEdy8rw/D8krFQNNJu8mho6Rf7n2zPd0YfeLv8hLuYgcXyC4
        2EHixjmvkH2fbODpz9sns8XHIWxa2fEktA8DvXs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606896326;
        bh=rL+esQjjNTyRSm1rUJ1txFv4qdbKTkN3iNIvyjkG1Bo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NwG9Ia6Uu7N1CQgvHKRexWMP4D5JUuBcoc8PZ/iRv9870Oh7ZBG90ezhyJlgj0p58
         yYcU7gBWKjlgcs2RXVODIOvQqMEK5qGFFsxl59ZQ067LTTP41TnZCTOThPjWqRYCjW
         Rugc+tuXq8SHCX4l+bGv5x4E2nVJ6PfLwfVwJ4Aw=
X-Google-Smtp-Source: ABdhPJxCxV0SUvy4WDeZm4iKsOl8mSYXVdeIBNdUccv/uVoeYyKaMEoCLhCihtlAx9O3QhiKVIn6yyzkpUGFGlt8mQ0=
X-Received: by 2002:a05:6402:31b6:: with SMTP id dj22mr1431309edb.348.1606896324697;
 Wed, 02 Dec 2020 00:05:24 -0800 (PST)
MIME-Version: 1.0
References: <20201201123932.12312-1-martin.kepplinger@puri.sm>
 <20201201123932.12312-8-martin.kepplinger@puri.sm> <cb498c2c-e052-390a-c64a-2be44d1d2b42@linaro.org>
 <a2c0fae4-13c5-9114-876f-bc324138e6cc@puri.sm> <20201202080321.GB6087@kozik-lap>
In-Reply-To: <20201202080321.GB6087@kozik-lap>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 2 Dec 2020 10:05:12 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcAbmugB9k-1Ldo=Q1J0CbOcxMtgC005w=DmWukThVcWA@mail.gmail.com>
Message-ID: <CAJKOXPcAbmugB9k-1Ldo=Q1J0CbOcxMtgC005w=DmWukThVcWA@mail.gmail.com>
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

On Wed, 2 Dec 2020 at 10:03, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Tue, Dec 01, 2020 at 02:15:04PM +0100, Martin Kepplinger wrote:
> > On 01.12.20 14:10, Georgi Djakov wrote:
> > > On 1.12.20 14:39, Martin Kepplinger wrote:
> > > > Enable INTERCONNECT_IMX8MQ in order to make interconnect more widely
> > > > available for testing.
> > >
> > > I hope that it's not just for testing, but using it.
> >
> > sure, I just think that most people will use their own config for production
> > but that's a different story. I can rephrase.
> >
> > >
> > > > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > > > ---
> > > >   arch/arm64/configs/defconfig | 3 ++-
> > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > > > index 1fed16950a7c..830c26a95b3d 100644
> > > > --- a/arch/arm64/configs/defconfig
> > > > +++ b/arch/arm64/configs/defconfig
> > > > @@ -1023,7 +1023,8 @@ CONFIG_OPTEE=y
> > > >   CONFIG_MUX_MMIO=y
> > > >   CONFIG_SLIM_QCOM_CTRL=m
> > > >   CONFIG_SLIM_QCOM_NGD_CTRL=m
> > > > -CONFIG_INTERCONNECT=y
> > >
> > > Why are you removing this line?
> >
> > savedefconfig removes it. INTERCONNECT_IMX below depends on it.
>
> It's save to remove it as other Interconnect options are directly
> dependant.

Ugh, my bad, it is not allowed to remove it. My review was too fast.
INTERCONNECT_IMX depends on it, so the INTERCONNECT must stay,

It is selected by TEGRA_MC which is independent here, so you should keep it.

Best regards,
Krzysztof
