Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB1B64B14
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2019 19:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfGJRBQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 13:01:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfGJRBQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Jul 2019 13:01:16 -0400
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 324EE214AF;
        Wed, 10 Jul 2019 17:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562778075;
        bh=TxbpTbFTB6tcLStSvP+aZxI9Q0R2lb9U8jlmNMNQU/k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U//DVdj8YeqqMqoEDtUVuLtXzsBFDbK43r7r+8WEjfC1VRimpCIv2wgciP4TBN/1i
         J5jJLff9enx6GJSi0qmcn2fHltBH8KhSQR0qMHQ+By8LbYiJ+S6vw1yXceuxXgquR4
         s/H+wScP71uIDBVJapDktsBgEARQrR4kG7GwHgdk=
Received: by mail-lf1-f51.google.com with SMTP id c9so2115694lfh.4;
        Wed, 10 Jul 2019 10:01:15 -0700 (PDT)
X-Gm-Message-State: APjAAAUbiZMC6q38omAa10AuY0h6+6LlHSdDc25ibITfGMHVEIgyfHwf
        Qs0EIr3P3aLcQH9UpO2e7cmh69r/Jvsdh33m1F0=
X-Google-Smtp-Source: APXvYqxUw6gRJ6UeOU32AlyJP63sp59JGRy6Bmn26fDc8R5P8j2rXUGuDLf2Ue/ajr7oZwhSM/V1T6YgEMGuHxdFzX0=
X-Received: by 2002:ac2:4d1c:: with SMTP id r28mr14953327lfi.159.1562778073455;
 Wed, 10 Jul 2019 10:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190708141158eucas1p17d4b50978dbe1e5c876ce6d8f433cc95@eucas1p1.samsung.com>
 <20190708141140.24379-1-k.konieczny@partner.samsung.com> <CAJKOXPd+UZ2MdrTVfBv5UYzK5LgKNQHUFzRbRNeq271EaDSchg@mail.gmail.com>
 <91f65527-3440-90fd-4096-5824fba1df78@partner.samsung.com>
 <CAJKOXPc1rOyFujyWk4HwmQb6YEXd=CEHKwN8AH_pKxk-6CA08w@mail.gmail.com> <631ffd68-7aab-2483-8799-2019bf3bb444@partner.samsung.com>
In-Reply-To: <631ffd68-7aab-2483-8799-2019bf3bb444@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 10 Jul 2019 19:01:02 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcX9vzoK-w16P4LiWjYMwXLUjSvNxdjp6nUXDjAK0rEcw@mail.gmail.com>
Message-ID: <CAJKOXPcX9vzoK-w16P4LiWjYMwXLUjSvNxdjp6nUXDjAK0rEcw@mail.gmail.com>
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

On Wed, 10 Jul 2019 at 15:51, Kamil Konieczny
<k.konieczny@partner.samsung.com> wrote:
>
> On 10.07.2019 12:14, Krzysztof Kozlowski wrote:
> > On Wed, 10 Jul 2019 at 12:03, Kamil Konieczny
> > <k.konieczny@partner.samsung.com> wrote:
> >>
> >> On 10.07.2019 11:00, Krzysztof Kozlowski wrote:
> >>> On Mon, 8 Jul 2019 at 16:12, <k.konieczny@partner.samsung.com> wrote:
> >>>>
> >>>> From: Kamil Konieczny <k.konieczny@partner.samsung.com>
> >>>>
> >>>> Hi,
> >>>>
> >>>> The main purpose of this patch series is to add coupled regulators for
> >>>> Exynos5422/5800 to keep constrain on voltage difference between vdd_arm
> >>>> and vdd_int to be at most 300mV. In exynos-bus instead of using
> >>>> regulator_set_voltage_tol() with default voltage tolerance it should be
> >>>> used regulator_set_voltage_triplet() with volatege range, and this is
> >>>> already present in opp/core.c code, so it can be reused. While at this,
> >>>> move setting regulators into opp/core.
> >>>>
> >>>> This patchset was tested on Odroid XU3.
> >>>>
> >>>> The last patch depends on two previous.
> >>>
> >>> So you break the ABI... I assume that patchset maintains
> >>> bisectability. However there is no explanation why ABI break is needed
> >>> so this does not look good...
> >>
> >> Patchset is bisectable, first one is simple and do not depends on others,
> >> second depends on first, last depends on first and second.
> >>
> >> What do you mean by breaking ABI ?
> >
> > I mean, that Linux kernel stops working with existing DTBs... or am I
> > mistaken and there is no problem? Maybe I confused the order...
>
> It is not ABI break, it should work with existing DTBs

Ah, thanks. My misunderstanding then. Looks good.

Best regards,
Krzysztof
