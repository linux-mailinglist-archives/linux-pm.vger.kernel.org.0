Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A1F3CFEF1
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jul 2021 18:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhGTPck (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Jul 2021 11:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbhGTP1j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jul 2021 11:27:39 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241F7C0613E7
        for <linux-pm@vger.kernel.org>; Tue, 20 Jul 2021 09:07:18 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id f8-20020a1c1f080000b029022d4c6cfc37so1790440wmf.5
        for <linux-pm@vger.kernel.org>; Tue, 20 Jul 2021 09:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Gj6/MjwS+J4keCNnFYk1TQ+l4VVmRSXxrXDi5n5Ny3A=;
        b=gRT05Pn+DjxRaYaQ3SNjK87ik5viYwcI+vEQBGYCJKXp+85XrKT1fQplwtyoDLjGg2
         6Qm1OYymAU0bFf7C3NOz5mLcuRMvVUreToOlOhkwBKzwWP5gor6/M/h5rfroSNCyLdFv
         PdyTRd9/r9cNphQ/KVfSF6jMtjyOt9/P2R+lpJqsSZz4BSdR4Hpl5xase7lCGIH5fmTD
         ZUkiTdNmOeyUmvJ8y+l6qXiIuj+wgfJC7MoxsFp8ZrF2vJL9bdWgREeDXCjzUD3KgT79
         DDXJU0Krj1Oz9JiTidP6+M5sFyX3FKllpYMs/4nxZEIK7f5i9q6u2eCFN1v3fEojfJXx
         Odcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Gj6/MjwS+J4keCNnFYk1TQ+l4VVmRSXxrXDi5n5Ny3A=;
        b=Z3+seCwom3hhD/PoPtVIqgcucNO38WgHiyOYpLNecezUkfUwrb4+suaHVzviKX7Lyz
         LB51N3cK4uB9fJ8jxAkkfL0mTQjt6F7BlcVR0frb+g+Kbsl1vq12XUys0Oxz6HCk8koG
         MKFA2aAp6UtVng1uKnPyCJNq670TB1ffSxCLLiSQeopUdNrojfuVheajOMVt8fzXCS50
         1v499ZMpS7v5SE/yw7281ODYuS7ksW/oRu8p9kznT4UxXeyliK+kj51tHvK7BifmMr07
         ZiCfipC83GwoEyOJmpJwbqoR1e75vAhCofzF2kkZ/St4jAiuXlDJUmUOsYpX2et75Nye
         inBQ==
X-Gm-Message-State: AOAM531zFWfjED3SioseNKZcuJOWYv3WOyWoQDu4carG0fS4PFnhI29W
        sNmK6qzNn/zeOX9lJVFzpJNdqw==
X-Google-Smtp-Source: ABdhPJwkPXNxyIOEI1iwTxTrl+7ksvGsjQ9ocmdf90SP7jwdElbWhOPHa6fxSUo60olZC1ffA0K8nw==
X-Received: by 2002:a05:600c:47c4:: with SMTP id l4mr3865020wmo.125.1626797236726;
        Tue, 20 Jul 2021 09:07:16 -0700 (PDT)
Received: from google.com ([31.124.24.141])
        by smtp.gmail.com with ESMTPSA id w18sm26022717wrg.68.2021.07.20.09.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 09:07:16 -0700 (PDT)
Date:   Tue, 20 Jul 2021 17:07:14 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] mfd: tps65086: Make interrupt line optional
Message-ID: <YPb0spKPvEvuuMWc@google.com>
References: <20210625224744.1020108-1-kernel@esmil.dk>
 <20210625224744.1020108-3-kernel@esmil.dk>
 <YPbmmqfOuE5w6EgW@google.com>
 <CANBLGcy_28q23vRJk9=UZR_Feeqod-ETET=v4Ub=35edySH7SA@mail.gmail.com>
 <YPbsodxMk+VvU/3D@google.com>
 <CANBLGcx08XajR8khJmKARBjy7bQ5ebbgO+RRqRu=bvyMx7LuKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANBLGcx08XajR8khJmKARBjy7bQ5ebbgO+RRqRu=bvyMx7LuKA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 20 Jul 2021, Emil Renner Berthing wrote:

> On Tue, 20 Jul 2021 at 17:32, Lee Jones <lee.jones@linaro.org> wrote:
> > On Tue, 20 Jul 2021, Emil Renner Berthing wrote:
> > > On Tue, 20 Jul 2021 at 17:07, Lee Jones <lee.jones@linaro.org> wrote:
> > > > On Sat, 26 Jun 2021, Emil Renner Berthing wrote:
> > > > > The BeagleV Starlight v0.9 board[1] doesn't have the IRQB line routed to
> > > > > the SoC, but it is still useful to be able to reach the PMIC over I2C
> > > > > for the other functionality it provides.
> > > > >
> > > > > [1] https://github.com/beagleboard/beaglev-starlight
> > > > >
> > > > > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > > > > ---
> > > > >  .../devicetree/bindings/mfd/ti,tps65086.yaml  |  3 ---
> > > >
> > > > This is not present in my current tree.
> > > >
> > > > Looks like it's still *.txt.
> > > >
> > > > Am I missing a patch?
> > >
> > > Yes, the first patch in the series converts that to yaml. I'm quite
> > > sure I had the same list of recipients on all 4 mails in the series,
> > > so don't know why that should be missing.
> >
> > Oh, it's not marked as 'important' because it has open review comments
> > on it.
> >
> > Just have this for now then:
> >
> > For my own reference (apply this as-is to your sign-off block):
> >
> >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> Thanks! Do you want to have a look at 3/3 or should I just send a v2
> to fix the yaml conversion now?

Patch 3 should be split.

I think it should also s/restart/reset/.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
