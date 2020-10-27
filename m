Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9875029C722
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 19:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1827785AbgJ0S2A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 14:28:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752898AbgJ0N5e (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 27 Oct 2020 09:57:34 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF3772068D;
        Tue, 27 Oct 2020 13:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603807054;
        bh=bCkAADwVUiL1//dh/4IT1DCgiPsfsVYvbtyHkxNq9S0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pxWzSXit5q8lsKgYMlnrNgnW6iGOG32v0NaQ7f+8Bf+WGQtbx07toYiOMij5nIeJj
         p9MJaHbqV+lgOmJESQxz3rDWhgxwtXvybUEoXEgy/jQ4wA4pEufHdyCWQsRNQS5w/H
         eHa6qCYOk+uFgnqxM1GqVn7DDSQ+8ADvcZxkpev0=
Received: by mail-ej1-f52.google.com with SMTP id h24so2345201ejg.9;
        Tue, 27 Oct 2020 06:57:33 -0700 (PDT)
X-Gm-Message-State: AOAM5337E324Uox6zfr0G+6/ceS521dU3TesiRBualUkJJEirBOBS5K1
        Kq2wbfOOwzho4P31YInxCNfRhiGGKk9VLaJZ1ac=
X-Google-Smtp-Source: ABdhPJzFiiYLDa37bXKUhu/1u6y0EtOWP6Hkh6q/LH5bFBtQdm7kyDeqRmGFv8Eb7YKgCvDDv+svj2T/9n86VE978dM=
X-Received: by 2002:a17:906:1a11:: with SMTP id i17mr2432900ejf.381.1603807052521;
 Tue, 27 Oct 2020 06:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201025221735.3062-1-digetx@gmail.com> <20201025221735.3062-32-digetx@gmail.com>
 <20201027135051.GL1822510@ulmo>
In-Reply-To: <20201027135051.GL1822510@ulmo>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 27 Oct 2020 14:57:19 +0100
X-Gmail-Original-Message-ID: <CAJKOXPeEKuYAbUh-YfXfDWamW_o6ejynq18vYNHsJ2gezpFYhw@mail.gmail.com>
Message-ID: <CAJKOXPeEKuYAbUh-YfXfDWamW_o6ejynq18vYNHsJ2gezpFYhw@mail.gmail.com>
Subject: Re: [PATCH v6 31/52] memory: tegra20-emc: Use devm_platform_ioremap_resource()
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

On Tue, 27 Oct 2020 at 14:50, Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Mon, Oct 26, 2020 at 01:17:14AM +0300, Dmitry Osipenko wrote:
> > Use devm_platform_ioremap_resource() helper which makes code a bit
> > cleaner.
> >
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> >  drivers/memory/tegra/tegra20-emc.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
>
> I'm not a fan of this helper, to be honest, because I think all the
> churn that we've seen with the conversions isn't really worth the 1 or 2
> lines that it saves, but hey, looks like this is pretty broadly
> accepted, so if Krzysztof likes it:
>
> Acked-by: Thierry Reding <treding@nvidia.com>

Such changes indeed do not bring much but still less local variables
and -1 line. I am fine with them. They also save one error msg from
devm_ioremap_resource() in case of platform_get_resource() failure.

Best regards,
Krzysztof
