Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CB124CE08
	for <lists+linux-pm@lfdr.de>; Fri, 21 Aug 2020 08:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgHUGc3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Aug 2020 02:32:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgHUGc2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Aug 2020 02:32:28 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57E19207DA;
        Fri, 21 Aug 2020 06:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597991547;
        bh=415OZuU8vzA50+rnOVabsjrgwD2vNtA0NKm0cqriH7Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DuUO7+ImHFtJQvWsmC/X9O7YR+C/54F+4qsahrFrMc6qY/L3qvv2O1nhHQnqCTvWp
         DBKfRpVW93mQ3Qc3YiU/OCrB9bhR34qnq4FvcaCHsVHaEl5d0oPK+3ll8CQ62mqJZy
         yWtpPLov+lbV3CgFmJr8wKJ3bba0yhiF7uDvT81s=
Received: by mail-ej1-f51.google.com with SMTP id u21so360590ejz.0;
        Thu, 20 Aug 2020 23:32:27 -0700 (PDT)
X-Gm-Message-State: AOAM531TL/cVnX3hDJHLEGfB3INtcPVrztq/0Ig/oN/E8kwzP+LJMxlI
        Bg695nUsnJKOSA0/kMNKbaC0uUR+pUYUba0ZoDk=
X-Google-Smtp-Source: ABdhPJzmNhcgBP4BHaa4+ob9gDnpioFjxsyx1iS1AVeOQjeO7mUt56aSdcZBGdYVXX8gX6athEENQYiVtJNm5lspNOA=
X-Received: by 2002:a17:906:4ec3:: with SMTP id i3mr1400283ejv.215.1597991545947;
 Thu, 20 Aug 2020 23:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200708153420.29484-1-lukasz.luba@arm.com> <20200708153420.29484-3-lukasz.luba@arm.com>
 <20200817155021.GC15887@kozik-lap> <2099aea9-5a63-6e5b-d7f9-4e6476584461@arm.com>
 <CAJKOXPc063m_YcouAO2Q9piJ_GV1Fh9XeS3ZZ3KR=ZyMxPKZ5w@mail.gmail.com>
In-Reply-To: <CAJKOXPc063m_YcouAO2Q9piJ_GV1Fh9XeS3ZZ3KR=ZyMxPKZ5w@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 21 Aug 2020 08:32:14 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcfo+1UY2wmy0WhyNRo_KqS7sGb9d8bDskDTOehFZoN5Q@mail.gmail.com>
Message-ID: <CAJKOXPcfo+1UY2wmy0WhyNRo_KqS7sGb9d8bDskDTOehFZoN5Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: exynos: Remove interrupts from DMC
 controller in Exynos5422
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, willy.mh.wolff.ml@gmail.com,
        k.konieczny@samsung.com, Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        s.nawrocki@samsung.com, kgene@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 21 Aug 2020 at 08:31, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Mon, 17 Aug 2020 at 19:17, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >
> > Hi Krzysztof,
> >
> > On 8/17/20 4:50 PM, Krzysztof Kozlowski wrote:
> > > On Wed, Jul 08, 2020 at 04:34:20PM +0100, Lukasz Luba wrote:
> > >> The interrupts in Dynamic Memory Controller in Exynos5422 and Odroid
> > >> XU3-family boards are no longer needed. They have been used in order
> > >> to workaround some issues in scheduled work in devfreq. Now when the
> > >> devfreq framework design is improved, remove the interrupt driven
> > >> approach and rely on devfreq monitoring mechanism with fixed intervals.
> > >>
> > >> Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
> > >> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> > >> ---
> > >>   arch/arm/boot/dts/exynos5420.dtsi | 3 ---
> > >>   1 file changed, 3 deletions(-)
> > >
> > > I think the dependencies were merged so this can be safely applied
> > > without bisectability problems?
> >
> > I have created v2 of that fix and it got merged
> > via Chanwoo's tree, the commit 4fc9a0470d2dc37028
> > https://lkml.org/lkml/2020/7/10/1048
> >
> > That commit switched the driver default mode from 'irq driven' to
> > new devfreq monitoring mechanism. Furthermore, when the driver is
> > built as a module, you can try to use the 'irq mode', but for this
> > you would need the DT IRQs description (this $subject tries to remove).
> >
> > I would like to keep this IRQ mode for experimentation, as I
> > described in answers to Bartek's questions:
> > https://lkml.org/lkml/2020/7/14/315
> >
> > Unfortunately, I am quite busy and won't make any progress before the
> > LPC.
>
> None of these were the actual answer to my question, unless by "v2 of
> that fix and it got merged" means the dependencies?
>
> I'll drop it from the queue. Please resend if it is valid.

Agh, not drop, I mean postpone for the next cycle (this is v5.11).

Best regards,
Krzysztof
