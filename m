Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4A52C5AF3
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 18:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404459AbgKZRqG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 12:46:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:40436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403877AbgKZRqF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Nov 2020 12:46:05 -0500
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A735321D81;
        Thu, 26 Nov 2020 17:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606412765;
        bh=fyJHGLRkPZJEpMLdSXJSRtm+BxF+vyx330eISFxAeu0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nAacdcqv3vuvKHUe5JctwDywjxu4UCDFQMjTws7kNRUOFnaCRcBPFwjKCggbFEEKu
         QsTkwKNORE9diKCKDKNVNyP4SnQrRnYaLOJBqBK5IfpYe0PJTaEd+Zf1EE5xnmR3Yj
         6/CG9NTx9VZJil7lnQbVWrS+e7pYWVyY3kx5FB6U=
Received: by mail-ej1-f43.google.com with SMTP id f9so1836543ejw.4;
        Thu, 26 Nov 2020 09:46:04 -0800 (PST)
X-Gm-Message-State: AOAM531t77Rm2KyAmq2WF01CT7N7m2MLCm31RoDfaGmydYWSXPQx6jpl
        sc4VIzWGhikih8GHNVCCIReraLb/fyVgZbZT5F0=
X-Google-Smtp-Source: ABdhPJySK2fWPNkkM5b6roHtaPGIS+dT06U+qMA2Q7ghOf7qik1PlIxU6ky2ZKUepWH1qNCM2fQckwm1YaXARvChzK4=
X-Received: by 2002:a17:906:c298:: with SMTP id r24mr3653647ejz.381.1606412763243;
 Thu, 26 Nov 2020 09:46:03 -0800 (PST)
MIME-Version: 1.0
References: <20201104164923.21238-1-digetx@gmail.com> <20201104164923.21238-18-digetx@gmail.com>
 <X7/lLaZJNp+Vfczk@ulmo> <20201126173922.GA7048@kozik-lap>
In-Reply-To: <20201126173922.GA7048@kozik-lap>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 26 Nov 2020 18:45:51 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfbmvUi3uWmX=qiiBxpCK_2oTWPY1JVxiVMuiv=RtwdKw@mail.gmail.com>
Message-ID: <CAJKOXPfbmvUi3uWmX=qiiBxpCK_2oTWPY1JVxiVMuiv=RtwdKw@mail.gmail.com>
Subject: Re: [PATCH v7 17/47] dt-bindings: memory: tegra20: Add memory client IDs
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 26 Nov 2020 at 18:39, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Thu, Nov 26, 2020 at 06:26:05PM +0100, Thierry Reding wrote:
> > On Wed, Nov 04, 2020 at 07:48:53PM +0300, Dmitry Osipenko wrote:
> > > Each memory client has unique hardware ID, add these IDs.
> > >
> > > Acked-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > > ---
> > >  include/dt-bindings/memory/tegra20-mc.h | 53 +++++++++++++++++++++++++
> > >  1 file changed, 53 insertions(+)
> >
> > Is there any chance you could drop these dt-bindings include patches
> > (17, 18 and 19) so that I can pick them up into the Tegra tree? The
> > device tree changes that I was going to pick up depend on this and
> > fail to build if applied as-is.
> >
> > I was looking at your linux-mem-ctrl tree and had initially thought I
> > could just pull in one of the branches to get these dependencies, but it
> > looks like the dt-bindings patches are on the for-v5.11/tegra-mc branch,
> > which the ARM SoC maintainers wouldn't like to see me pull in for a
> > dependency on device tree changes.
>
> Partially you answered here. :) Since you should not pull my branch into
> a DT branch, you also should not put these include/dt-bindings patches
> there.  SoC guys will complain about this as well.
>
> These patches are also needed for the driver, so if you take them, I
> would need them back in a pull request. SoC folks could spot it as well
> and point that such merge should not happen.

It seems I was wrong - these patches are not needed for the driver
code. Neither in applied parts nor in upcoming Dmitry's work. In such
case I could rework my branches and send a new pull request. The
patches would stay only in your tree.

Best regards,
Krzysztof
