Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577E32A45FB
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 14:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgKCNMB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 08:12:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:53724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728027AbgKCNMB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Nov 2020 08:12:01 -0500
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1C2521534;
        Tue,  3 Nov 2020 13:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604409120;
        bh=+7JbMhytyRsTirCANMnMd4YOm4X/s5w+5rkhangGOng=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=corduBPVOuWsxLDXFIz7KhE212/D2r07oOD7+xj0uXZdL5BcpE4S8S7rmW1B/Y0fk
         FEWN+XtfAmcC1ddNMyCHJlnzlQmw6vKPqYs7FkkCAOhrCKGLYL0N2tgw/L6t5rhIiU
         eg+yrQq9bJIQ7KX5qIR3/Z4zx6Yln1cJG19yjGN4=
Received: by mail-ed1-f54.google.com with SMTP id v4so18217810edi.0;
        Tue, 03 Nov 2020 05:11:59 -0800 (PST)
X-Gm-Message-State: AOAM532oG7e/ZxgRGsaMRiO0SheysOJELHHh7e8zD+P18oglo3/ws6RV
        yLCzoTHR9e3lCgUIXKbQgqcfD/KCq2oF942E0EE=
X-Google-Smtp-Source: ABdhPJwHKZSSgISev/UaBV8IU3ye6DvSnFWF3BfI0HEvigilb+i1KjnoOgFL5dDVnk7YhJPrLr+ubAF76ckyGXykGTM=
X-Received: by 2002:a05:6402:290:: with SMTP id l16mr20293009edv.104.1604409118468;
 Tue, 03 Nov 2020 05:11:58 -0800 (PST)
MIME-Version: 1.0
References: <20201030125149.8227-1-s.nawrocki@samsung.com> <CGME20201030125303eucas1p14a9de4111ffafc1870527abdea0994c9@eucas1p1.samsung.com>
 <20201030125149.8227-4-s.nawrocki@samsung.com> <522dd3d8-7c76-92c6-ab1e-7e04797b3e9f@samsung.com>
 <20bc744b-bbb1-8803-3844-97d59f708f43@samsung.com>
In-Reply-To: <20bc744b-bbb1-8803-3844-97d59f708f43@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 3 Nov 2020 14:11:45 +0100
X-Gmail-Original-Message-ID: <CAJKOXPf_WP0+S70kT+38asBsQFTPKqw=hpvkoWx1Ec2qADz4-A@mail.gmail.com>
Message-ID: <CAJKOXPf_WP0+S70kT+38asBsQFTPKqw=hpvkoWx1Ec2qADz4-A@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] PM / devfreq: exynos-bus: Add registration of
 interconnect child device
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>, georgi.djakov@linaro.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        a.swigon@samsung.com, myungjoo.ham@samsung.com,
        Inki Dae <inki.dae@samsung.com>,
        Seung Woo Kim <sw0312.kim@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 3 Nov 2020 at 13:32, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> Hi Chanwoo,
>
> On 03.11.2020 11:45, Chanwoo Choi wrote:
> > On 10/30/20 9:51 PM, Sylwester Nawrocki wrote:
> >> This patch adds registration of a child platform device for the exynos
> >> interconnect driver. It is assumed that the interconnect provider will
> >> only be needed when #interconnect-cells property is present in the bus
> >> DT node, hence the child device will be created only when such a property
> >> is present.
> >>
> >> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>
> >>  drivers/devfreq/exynos-bus.c | 17 +++++++++++++++++
>
> > We don't need to  add 'select INTERCONNECT_EXYNOS' in Kconfig?
>
> I think by doing so we could run into some dependency issues.
>
> > Do you want to remain it as optional according to user?
> Yes, I would prefer to keep it selectable through defconfig.
> Currently it's only needed by one 32-bit ARM board.

I am fine with it as it is really optional.

You could consider then "imply" but then you would need to check for
dependencies (the same as with select).

Best regards,
Krzysztof
