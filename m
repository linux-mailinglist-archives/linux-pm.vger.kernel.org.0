Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83F33CFD25
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jul 2021 17:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238626AbhGTOcR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Jul 2021 10:32:17 -0400
Received: from mail-yb1-f174.google.com ([209.85.219.174]:38450 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240275AbhGTO3Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jul 2021 10:29:25 -0400
Received: by mail-yb1-f174.google.com with SMTP id r132so33206224yba.5;
        Tue, 20 Jul 2021 08:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F4Yeu0BArNNmD3Jf8Ld29nRwYC/U4SpxJ/oKLG/jkbs=;
        b=PCXe9IfYSzBOxiy2pbPIP6wB1hPqnTqsblh3MxDlbm96hi/a/MuuvJFEf3aqtPe+sE
         3g4EOPUTLq3xJ3/vbg5LI4YVqO110PQfDML2xPGngd8TwGTpTM2CyMwVCVR12O3M+CNk
         2izYnrywmdEC6grgtif6J9ZZtr1rMUDlSnv0f/WQ2F+4CqntZgU8gndQAllT61oOe/4R
         tJIeJd68qCOTXleXkfMOiGwS4I+/XLWlZkaOEhOxH/BuJmU2YXaSDdamDnGF6SSmyCZz
         rbETMZk8vUqRkICQD5WUwr8lbNsMk/ps2pdVfZ2YqTJd7AEjBZiBtQJzezc8p+nv+e/p
         Q8xQ==
X-Gm-Message-State: AOAM5327cV0dHbQtRy8I7M/bxq9yKPN3PyQHsxSR5515weSRnGPzJnze
        P2irOWZAk67TzmhFJfWIr1ahgpi7I9s5ZDk5rLw=
X-Google-Smtp-Source: ABdhPJxAZJlUAuU6mIaYried0uqpTKXPad4ZCpz6OPKmAHTY46WishJ7V4Dgn/h1DPpANrd0F1koxPxvT3Wjv62dwtk=
X-Received: by 2002:a25:b093:: with SMTP id f19mr39674642ybj.90.1626793802012;
 Tue, 20 Jul 2021 08:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210625224744.1020108-1-kernel@esmil.dk> <20210625224744.1020108-3-kernel@esmil.dk>
 <YPbmmqfOuE5w6EgW@google.com>
In-Reply-To: <YPbmmqfOuE5w6EgW@google.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Tue, 20 Jul 2021 17:09:51 +0200
Message-ID: <CANBLGcy_28q23vRJk9=UZR_Feeqod-ETET=v4Ub=35edySH7SA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] mfd: tps65086: Make interrupt line optional
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 20 Jul 2021 at 17:07, Lee Jones <lee.jones@linaro.org> wrote:
> On Sat, 26 Jun 2021, Emil Renner Berthing wrote:
> > The BeagleV Starlight v0.9 board[1] doesn't have the IRQB line routed to
> > the SoC, but it is still useful to be able to reach the PMIC over I2C
> > for the other functionality it provides.
> >
> > [1] https://github.com/beagleboard/beaglev-starlight
> >
> > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > ---
> >  .../devicetree/bindings/mfd/ti,tps65086.yaml  |  3 ---
>
> This is not present in my current tree.
>
> Looks like it's still *.txt.
>
> Am I missing a patch?

Yes, the first patch in the series converts that to yaml. I'm quite
sure I had the same list of recipients on all 4 mails in the series,
so don't know why that should be missing.
