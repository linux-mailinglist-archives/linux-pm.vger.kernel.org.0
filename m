Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0260E3312C9
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 17:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhCHQDG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 11:03:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:38752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230078AbhCHQC4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Mar 2021 11:02:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F74D65228;
        Mon,  8 Mar 2021 16:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615219375;
        bh=81L55Ql71/PIDoeyenGJ6E24UkFDnhGsiFqB2FUgnnk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qu6ApKeYNNZJfwMnHd8RoTXahkePw8+QB0qK26OmfXR7IaZruke3YY5kMz6nVarf9
         bLQGEdu+k8QV3ujpY0Pa6G69E/rbJaz6y2+atBrAvrMttF/d3JrBNx+1zah0QLd3bN
         j4YxN1iKuEGudCWxmktHIDl/QkSrgnIAVs40LAA74aZGLPKl0mczlw7zQmbrwQ5Rk0
         ufEFBVBgUrUnwOxzsxdHvPuZM/pkxxS0vneF2ZSgA+ZaNGMdwpDKOPhXVKoS1FBeeT
         mz/NcyBQZDv+fJio+zHgK3TPxWQoWt4tbCwVlQVH3ugHXFSX/UUlmoMJkqDMBX91bL
         ozSLstqZDxNkQ==
Received: by mail-ot1-f41.google.com with SMTP id f33so9618200otf.11;
        Mon, 08 Mar 2021 08:02:55 -0800 (PST)
X-Gm-Message-State: AOAM532xGSTQcgmMk1vY8/lpRWB7yn0QyuNmQZ021Zcbr30QCG3kXQkp
        JNI9PIkvj1g2ZpksveCx8wmGEHEE8m9g1kviReU=
X-Google-Smtp-Source: ABdhPJyNkTy8tsZDz8aNPrEjO+pd0M6+WYJzuDmR8+KfsUmhCtClsTL+pKmKL13p3R1++4uqRZ66UycBA+zhOi31Fsk=
X-Received: by 2002:a05:6830:14c1:: with SMTP id t1mr831083otq.305.1615219375009;
 Mon, 08 Mar 2021 08:02:55 -0800 (PST)
MIME-Version: 1.0
References: <20210308152935.2263935-1-arnd@kernel.org> <12c5050f-feb3-e07f-45d2-5e89b678841a@kernel.org>
In-Reply-To: <12c5050f-feb3-e07f-45d2-5e89b678841a@kernel.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 8 Mar 2021 17:02:38 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3xEw9yiVY-dDmQEKTSPSXaZJEhXEQ2M=7ZoUA8_P5Qzg@mail.gmail.com>
Message-ID: <CAK8P3a3xEw9yiVY-dDmQEKTSPSXaZJEhXEQ2M=7ZoUA8_P5Qzg@mail.gmail.com>
Subject: Re: [PATCH] power: supply: max8997_charger: make EXTCON dependency unconditional
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Timon Baetz <timon.baetz@protonmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 8, 2021 at 4:33 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 08/03/2021 16:29, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Some of the extcon interfaces have a fallback implementation that can
> > be used when EXTCON is disabled, but some others do not, causing a
> > build failure:
> >
> > drivers/power/supply/max8997_charger.c:261:9: error: implicit declaration of function 'devm_extcon_register_notifier_all' [-Werror,-Wimplicit-function-declaration]
> >                 ret = devm_extcon_register_notifier_all(&pdev->dev, charger->edev,
> >                       ^
> > drivers/power/supply/max8997_charger.c:261:9: note: did you mean 'devm_extcon_register_notifier'?
> > include/linux/extcon.h:263:19: note: 'devm_extcon_register_notifier' declared here
> > static inline int devm_extcon_register_notifier(struct device *dev,
> >
> > I assume there is no reason to actually build this driver without extcon
> > support, so a hard dependency is the easiest fix. Alternatively the
> > header file could be extended to provide additional inline stubs.
>
> Hi Arnd,
>
> Thanks for the patch but I think I got it covered with:
> https://lore.kernel.org/lkml/20210215100610.19911-2-cw00.choi@samsung.com/
> (sent via extcon tree).
>
> Did you experience a new/different issue?

The patch should be fine and address the problem, I just didn't see it was
already fixed in linux-next as I'm still testing on mainline (rc2 at
the moment).

I assume the fix will make it into a future -rc then.

      Arnd
