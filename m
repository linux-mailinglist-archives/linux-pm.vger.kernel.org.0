Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B7224CE00
	for <lists+linux-pm@lfdr.de>; Fri, 21 Aug 2020 08:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgHUGbm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Aug 2020 02:31:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbgHUGbm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Aug 2020 02:31:42 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D848B20732;
        Fri, 21 Aug 2020 06:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597991501;
        bh=nlYLizszK9f9v583kG2r3NUZircSq8a0b7ncAj+8nCE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=icHK5nj5ReIwEwsVtVm7zKaYGoNmULev+0nWZpsolGw0fskgZbyej0dJjTasvCJSl
         dyVIbbFqKdtRskezltcj/zCCcfZtT8K9Q6wL39HyrObOtZ2QmFy5ZvDRlDs24PSRB4
         OuHhul5XgUWTX5ZquBlRv7fRWehPVzRQGg81x9TI=
Received: by mail-ej1-f52.google.com with SMTP id bo3so1004135ejb.11;
        Thu, 20 Aug 2020 23:31:40 -0700 (PDT)
X-Gm-Message-State: AOAM530bQ0KMHn63PX+jdczb14N/tE4X2urd7fx6GNrBQoVI/+OVC7/a
        Ca0YB2LGtJYljHP/ouXDT1xUkn2NtPXijx/uRAI=
X-Google-Smtp-Source: ABdhPJzmsRwacUgF9wp7sh4Uo7RCl0p0/BWQy6sNA1lK7shnUeEfA2XLjnyNUqiOPykidWM5/kQR7817vJYiPMs1QXw=
X-Received: by 2002:a17:906:9989:: with SMTP id af9mr1305560ejc.385.1597991499427;
 Thu, 20 Aug 2020 23:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200708153420.29484-1-lukasz.luba@arm.com> <20200708153420.29484-3-lukasz.luba@arm.com>
 <20200817155021.GC15887@kozik-lap> <2099aea9-5a63-6e5b-d7f9-4e6476584461@arm.com>
In-Reply-To: <2099aea9-5a63-6e5b-d7f9-4e6476584461@arm.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 21 Aug 2020 08:31:28 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc063m_YcouAO2Q9piJ_GV1Fh9XeS3ZZ3KR=ZyMxPKZ5w@mail.gmail.com>
Message-ID: <CAJKOXPc063m_YcouAO2Q9piJ_GV1Fh9XeS3ZZ3KR=ZyMxPKZ5w@mail.gmail.com>
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

On Mon, 17 Aug 2020 at 19:17, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Krzysztof,
>
> On 8/17/20 4:50 PM, Krzysztof Kozlowski wrote:
> > On Wed, Jul 08, 2020 at 04:34:20PM +0100, Lukasz Luba wrote:
> >> The interrupts in Dynamic Memory Controller in Exynos5422 and Odroid
> >> XU3-family boards are no longer needed. They have been used in order
> >> to workaround some issues in scheduled work in devfreq. Now when the
> >> devfreq framework design is improved, remove the interrupt driven
> >> approach and rely on devfreq monitoring mechanism with fixed intervals.
> >>
> >> Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
> >> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> >> ---
> >>   arch/arm/boot/dts/exynos5420.dtsi | 3 ---
> >>   1 file changed, 3 deletions(-)
> >
> > I think the dependencies were merged so this can be safely applied
> > without bisectability problems?
>
> I have created v2 of that fix and it got merged
> via Chanwoo's tree, the commit 4fc9a0470d2dc37028
> https://lkml.org/lkml/2020/7/10/1048
>
> That commit switched the driver default mode from 'irq driven' to
> new devfreq monitoring mechanism. Furthermore, when the driver is
> built as a module, you can try to use the 'irq mode', but for this
> you would need the DT IRQs description (this $subject tries to remove).
>
> I would like to keep this IRQ mode for experimentation, as I
> described in answers to Bartek's questions:
> https://lkml.org/lkml/2020/7/14/315
>
> Unfortunately, I am quite busy and won't make any progress before the
> LPC.

None of these were the actual answer to my question, unless by "v2 of
that fix and it got merged" means the dependencies?

I'll drop it from the queue. Please resend if it is valid.

Best regards,
Krzysztof
