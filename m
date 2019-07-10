Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D25664506
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2019 12:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfGJKPG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 06:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbfGJKPG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Jul 2019 06:15:06 -0400
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAADD20861;
        Wed, 10 Jul 2019 10:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562753705;
        bh=FKpiA/emhKXUOAPvuAJ5oh3C3NX2rCFMH+btriqrd4E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xWsc9WLv9uXi+kTm/sQBJC6Gcxs5SxUhmTBPZGMtgW6lJzrVfAdyorhbft7xaFAbL
         AgdDhUNdVXew3QRvl0mZO1y3DthJZ0L/AoSun2BGegLwZrrGgnFcZE4XKtjQvSZ5+r
         T6LfnYa6wKz0ZydjRFYLeFVNiPuGW48f18Uj8N0Q=
Received: by mail-lj1-f181.google.com with SMTP id h10so1520713ljg.0;
        Wed, 10 Jul 2019 03:15:04 -0700 (PDT)
X-Gm-Message-State: APjAAAVQxdRoZYVnURzSBtDbJZqcuArvSrrEXadiK6eckkQPUAKeF7YV
        3Ie/qN/2qe4CeMaty2bfG9Ybju3IP5N0zvxBeOE=
X-Google-Smtp-Source: APXvYqzFBP1tdwwgtZ/3RtfqPPV8drCmzRWKuK+JH6Dw5x+7dbZyN+IaqrSobdz3ZdFMyRjarSxqkEs4HDySwe+JxPc=
X-Received: by 2002:a2e:7818:: with SMTP id t24mr13443634ljc.210.1562753702877;
 Wed, 10 Jul 2019 03:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190708141158eucas1p17d4b50978dbe1e5c876ce6d8f433cc95@eucas1p1.samsung.com>
 <20190708141140.24379-1-k.konieczny@partner.samsung.com> <CAJKOXPd+UZ2MdrTVfBv5UYzK5LgKNQHUFzRbRNeq271EaDSchg@mail.gmail.com>
 <91f65527-3440-90fd-4096-5824fba1df78@partner.samsung.com>
In-Reply-To: <91f65527-3440-90fd-4096-5824fba1df78@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 10 Jul 2019 12:14:51 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc1rOyFujyWk4HwmQb6YEXd=CEHKwN8AH_pKxk-6CA08w@mail.gmail.com>
Message-ID: <CAJKOXPc1rOyFujyWk4HwmQb6YEXd=CEHKwN8AH_pKxk-6CA08w@mail.gmail.com>
Subject: Re: [PATCH 0/3] add coupled regulators for Exynos5422/5800
To:     Kamil Konieczny <k.konieczny@partner.samsung.com>
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

On Wed, 10 Jul 2019 at 12:03, Kamil Konieczny
<k.konieczny@partner.samsung.com> wrote:
>
> On 10.07.2019 11:00, Krzysztof Kozlowski wrote:
> > On Mon, 8 Jul 2019 at 16:12, <k.konieczny@partner.samsung.com> wrote:
> >>
> >> From: Kamil Konieczny <k.konieczny@partner.samsung.com>
> >>
> >> Hi,
> >>
> >> The main purpose of this patch series is to add coupled regulators for
> >> Exynos5422/5800 to keep constrain on voltage difference between vdd_arm
> >> and vdd_int to be at most 300mV. In exynos-bus instead of using
> >> regulator_set_voltage_tol() with default voltage tolerance it should be
> >> used regulator_set_voltage_triplet() with volatege range, and this is
> >> already present in opp/core.c code, so it can be reused. While at this,
> >> move setting regulators into opp/core.
> >>
> >> This patchset was tested on Odroid XU3.
> >>
> >> The last patch depends on two previous.
> >
> > So you break the ABI... I assume that patchset maintains
> > bisectability. However there is no explanation why ABI break is needed
> > so this does not look good...
>
> Patchset is bisectable, first one is simple and do not depends on others,
> second depends on first, last depends on first and second.
>
> What do you mean by breaking ABI ?

I mean, that Linux kernel stops working with existing DTBs... or am I
mistaken and there is no problem? Maybe I confused the order...

Best regards,
Krzysztof
