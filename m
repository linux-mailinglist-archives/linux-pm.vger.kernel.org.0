Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4747B3CFF74
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jul 2021 18:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229474AbhGTPtk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Jul 2021 11:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbhGTPsc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jul 2021 11:48:32 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878E1C0613E0
        for <linux-pm@vger.kernel.org>; Tue, 20 Jul 2021 09:29:09 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d2so26726299wrn.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Jul 2021 09:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vn2uIa7Zt9UomSnJ+gKoPcustWGjsNtQ+/zZFEcCcuY=;
        b=ZjWYI0lOGX1Cr21JssHiP5nKV/UA+47iP6VqFCeH1HP45mcYwQlbmNDXneNPtYbl9K
         X0qsfLdizgtTQV3JMUiLLN+xuSOSxr4pGw36TgZ6OQOW+bJkWHiVlMGvrcS6lHvDV7ZI
         qWMXoI+JgYCqJopT+mEVU2pgocralvBP2+kYDCXKYauMfDVMie+b2U7CPrAsbkunLedK
         DCEtoJuVOYQMQFDPxMN6QKBl38kb8QJ/3jynXERBpVWEB8CuPNzGulmEtJxN5/7L7VtX
         DIGgTaLYI6INti0mS1sA2kAYXbjssJolQ+3tAWAtqkB/EkdD2cIE0ntUm4z3FTe6gWtm
         Ln4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vn2uIa7Zt9UomSnJ+gKoPcustWGjsNtQ+/zZFEcCcuY=;
        b=hKEyCjnCajqwsfglRE2sXJ7BNlnkRWqouaiwmsZIg0M7LgGXURFpBFq/cU08UoPHev
         esjTSnoTbPQDvjOAVCOMzjIcD+RYnS4yFC1aZEnURpmWTE+9b1Fet8ZjzMTlk+qjOHtX
         JY2IIMA7ty+GmRKf9Jzu+i0To2qfXEmVSbGK2PBqfOrNSnMMl+OPPCiAgbT2M7MxCfRf
         f1nxxgWZFf4vZaRYaxyMoG7X2rhOAlI5X5M09rDaVzONT+77So8cRSA0raKFZh85mqVm
         mW2t47+kBaUG5pcaTGv7DtT3yFDA46P1USeaSeJ9fJPgNesB7Fvq+PbLWX+dzMwDSubB
         zdIg==
X-Gm-Message-State: AOAM532uqCLlcmzGJI2l793fdx59LSZm7w3wtzVUfvcJWK8+E8//ptvw
        iwBVxaYBMcMHJHgj82DGdTxqJg==
X-Google-Smtp-Source: ABdhPJwuloW7Uo7jNSoW7NXw/K3ixr1UiM6ErT6zSqbLTdOQIePWZ8kmheCXBp+bK75AmJ6Qk9Jwnw==
X-Received: by 2002:adf:f109:: with SMTP id r9mr18561723wro.370.1626798548154;
        Tue, 20 Jul 2021 09:29:08 -0700 (PDT)
Received: from google.com ([31.124.24.141])
        by smtp.gmail.com with ESMTPSA id 129sm20519093wmz.26.2021.07.20.09.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 09:29:07 -0700 (PDT)
Date:   Tue, 20 Jul 2021 17:29:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] mfd: tps65086: Make interrupt line optional
Message-ID: <YPb50VHKYrnmDkyK@google.com>
References: <20210625224744.1020108-1-kernel@esmil.dk>
 <20210625224744.1020108-3-kernel@esmil.dk>
 <YPbmmqfOuE5w6EgW@google.com>
 <CANBLGcy_28q23vRJk9=UZR_Feeqod-ETET=v4Ub=35edySH7SA@mail.gmail.com>
 <YPbsodxMk+VvU/3D@google.com>
 <CANBLGcx08XajR8khJmKARBjy7bQ5ebbgO+RRqRu=bvyMx7LuKA@mail.gmail.com>
 <YPb0spKPvEvuuMWc@google.com>
 <CANBLGcx2R4xuyoLHJUNbqiJeRrqTD1oL7X1K0RKzOPD_9xnMdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANBLGcx2R4xuyoLHJUNbqiJeRrqTD1oL7X1K0RKzOPD_9xnMdw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 20 Jul 2021, Emil Renner Berthing wrote:

> On Tue, 20 Jul 2021 at 18:07, Lee Jones <lee.jones@linaro.org> wrote:
> > On Tue, 20 Jul 2021, Emil Renner Berthing wrote:
> > > On Tue, 20 Jul 2021 at 17:32, Lee Jones <lee.jones@linaro.org> wrote:
> > > > On Tue, 20 Jul 2021, Emil Renner Berthing wrote:
> > > > > On Tue, 20 Jul 2021 at 17:07, Lee Jones <lee.jones@linaro.org> wrote:
> > > > > > On Sat, 26 Jun 2021, Emil Renner Berthing wrote:
> > > > > > > The BeagleV Starlight v0.9 board[1] doesn't have the IRQB line routed to
> > > > > > > the SoC, but it is still useful to be able to reach the PMIC over I2C
> > > > > > > for the other functionality it provides.
> > > > > > >
> > > > > > > [1] https://github.com/beagleboard/beaglev-starlight
> > > > > > >
> > > > > > > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > > > > > > ---
> > > > > > >  .../devicetree/bindings/mfd/ti,tps65086.yaml  |  3 ---
> > > > > >
> > > > > > This is not present in my current tree.
> > > > > >
> > > > > > Looks like it's still *.txt.
> > > > > >
> > > > > > Am I missing a patch?
> > > > >
> > > > > Yes, the first patch in the series converts that to yaml. I'm quite
> > > > > sure I had the same list of recipients on all 4 mails in the series,
> > > > > so don't know why that should be missing.
> > > >
> > > > Oh, it's not marked as 'important' because it has open review comments
> > > > on it.
> > > >
> > > > Just have this for now then:
> > > >
> > > > For my own reference (apply this as-is to your sign-off block):
> > > >
> > > >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > >
> > > Thanks! Do you want to have a look at 3/3 or should I just send a v2
> > > to fix the yaml conversion now?
> >
> > Patch 3 should be split.
> 
> Oh, how split? Split off the series or split into adding the "driver"
> and then add the cell to the parent?

I'm not overly concerned about the ordering.

Just split out the patch per-subsystem.

> > I think it should also s/restart/reset/.
> 
> Oh right yes. You mean the cell name needs to be .name =
> "tps65086-reset", right?

Right.

> I'll fix that anyway.

Ta.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
