Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437953CFE70
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jul 2021 17:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239539AbhGTPRS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Jul 2021 11:17:18 -0400
Received: from mail-yb1-f179.google.com ([209.85.219.179]:38495 "EHLO
        mail-yb1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241907AbhGTO5p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jul 2021 10:57:45 -0400
Received: by mail-yb1-f179.google.com with SMTP id r132so33328201yba.5;
        Tue, 20 Jul 2021 08:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=COwTYiLL/Nx8F1AI3lOoGhFRrrZD91NxoeSpMZuBXrg=;
        b=H4zOicbvFkM2rohDBievmQVZqI3o/59XxluP6b3yusjynFolL31q/804lplY5WVd8+
         qWFuent0xENHgm7IlB3359BBg8hAcczkLPStR8sTSJfDiXjEF7Tmczma8MRRV0tA/VHA
         cUml5qZ5h9Al8XqbMv/mCZFt7D5xVF4VU0/qvlM2ouL5hjz1qSju5p9SGdLxK0f9VsEf
         XupE4YzxP21mMtYyYganpZKDvJ42kOZRZEtLUFMuesMrq6K7OqCiEUsjhYjb7vr9GXyI
         BYUrgxgVT7mirrMTeV/X7FIWIZcYEaIvMkCeiNZF+hmgT3nUHDX7Wz39yos80cSx0z7T
         97Nw==
X-Gm-Message-State: AOAM533CeHX1U9hxc3RJjjUEpRJCbzIlsuKJD4DopXLU4od5i/KdvUjS
        4gE8+MHHcuk9o7yVOpbGuAupyK92HYV0Q+yZmwMWhhe60Rc=
X-Google-Smtp-Source: ABdhPJzfMm/Kodpa+wHLDsU7yc57tAwz4pYAxpiQFqzsIDZ96UoGllNps1Womhv+mPkwJSw9LuuGB3QjEZQfHgpwsLI=
X-Received: by 2002:a25:b093:: with SMTP id f19mr39835829ybj.90.1626795414077;
 Tue, 20 Jul 2021 08:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210625224744.1020108-1-kernel@esmil.dk> <20210625224744.1020108-3-kernel@esmil.dk>
 <YPbmmqfOuE5w6EgW@google.com> <CANBLGcy_28q23vRJk9=UZR_Feeqod-ETET=v4Ub=35edySH7SA@mail.gmail.com>
 <YPbsodxMk+VvU/3D@google.com>
In-Reply-To: <YPbsodxMk+VvU/3D@google.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Tue, 20 Jul 2021 17:36:43 +0200
Message-ID: <CANBLGcx08XajR8khJmKARBjy7bQ5ebbgO+RRqRu=bvyMx7LuKA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] mfd: tps65086: Make interrupt line optional
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 20 Jul 2021 at 17:32, Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 20 Jul 2021, Emil Renner Berthing wrote:
> > On Tue, 20 Jul 2021 at 17:07, Lee Jones <lee.jones@linaro.org> wrote:
> > > On Sat, 26 Jun 2021, Emil Renner Berthing wrote:
> > > > The BeagleV Starlight v0.9 board[1] doesn't have the IRQB line routed to
> > > > the SoC, but it is still useful to be able to reach the PMIC over I2C
> > > > for the other functionality it provides.
> > > >
> > > > [1] https://github.com/beagleboard/beaglev-starlight
> > > >
> > > > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > > > ---
> > > >  .../devicetree/bindings/mfd/ti,tps65086.yaml  |  3 ---
> > >
> > > This is not present in my current tree.
> > >
> > > Looks like it's still *.txt.
> > >
> > > Am I missing a patch?
> >
> > Yes, the first patch in the series converts that to yaml. I'm quite
> > sure I had the same list of recipients on all 4 mails in the series,
> > so don't know why that should be missing.
>
> Oh, it's not marked as 'important' because it has open review comments
> on it.
>
> Just have this for now then:
>
> For my own reference (apply this as-is to your sign-off block):
>
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

Thanks! Do you want to have a look at 3/3 or should I just send a v2
to fix the yaml conversion now?

/Emil
