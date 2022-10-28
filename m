Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78C561114C
	for <lists+linux-pm@lfdr.de>; Fri, 28 Oct 2022 14:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiJ1M0r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Oct 2022 08:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiJ1M0q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Oct 2022 08:26:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369DA1D3E81
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 05:26:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C246D62819
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 12:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324BEC43470
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 12:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666960004;
        bh=bnIMZ1ebFhqgwDOrCr6K3O7h5lcExzUd1tuyjsPdREY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vMu5sDf7/xKAS1Kt11U86vFooUyqTBRD5KsJ2Ury4OKPhiRw2L8TBzD5wpQQCfcy8
         c9hE1Yv4RSNjofSh/N+Pa1U9RpIEZW7Kee6yNuKVtUN7IYS8aaW+aU4VseU5rstAPI
         Po69mnYEsMzfn1YxC1uRtGfEhP24L4s2amQ/cOyn+Re6uDabsHYEjjGf5TNPlx5ctD
         X6inqHBYbby20h5BR9Ov9zUTYlIk/MnI8dRmEjI2y5xjE028Atns/5gOQuyh+rXtKG
         TN6YOeGEH8OY+hNjCsN3nlUOW/0IsoQUtl7eAvxRRjvVQd9BVJZeHCiqQjogesXN+I
         o7l50AW6M72KQ==
Received: by mail-lf1-f43.google.com with SMTP id j16so7985590lfe.12
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 05:26:44 -0700 (PDT)
X-Gm-Message-State: ACrzQf1coP1Xeu5YcHSRo002T1xVtLoNtzCPxueeG8VQtQcc8z/HJucJ
        gNBGxyTipUmGgfTINmLgfOrUa536sFOh+96eag==
X-Google-Smtp-Source: AMsMyM6ZmBsUBGEkTWwP/mJBILhgYFkIGDngz9imZli0WHFutFamJadjfODVM7TMictvul5Ro1Vs/hJYLqA4B2C5IJc=
X-Received: by 2002:a05:6512:3e10:b0:4a2:48c1:8794 with SMTP id
 i16-20020a0565123e1000b004a248c18794mr19382327lfv.17.1666960002138; Fri, 28
 Oct 2022 05:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkdbB5hgkrPZVb-+9tuKErvwjTKNaBQ1LvH1==fR7bndjSQ@mail.gmail.com>
 <CAL_JsqKQM4oSxrbhA4_ST8O0ieek9sGQQ9p55AXjhqmVx=rUrw@mail.gmail.com>
 <CAJZ5v0i76X0TiaOhPa3a5440fRb7vA1z1mFKJibso8G6wYz7HQ@mail.gmail.com>
 <4817aeca-4fb1-cb99-8df5-7df22a77ea3f@linexp.org> <CACRpkdb=WX5XO1YDB04uLzv=tNfpmr+ORN+LkAiZTE6gSris_g@mail.gmail.com>
In-Reply-To: <CACRpkdb=WX5XO1YDB04uLzv=tNfpmr+ORN+LkAiZTE6gSris_g@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 28 Oct 2022 07:26:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKECuRr5080roHXJKEP1QRN+ruG8KwYuLDtt__hA0p-6g@mail.gmail.com>
Message-ID: <CAL_JsqKECuRr5080roHXJKEP1QRN+ruG8KwYuLDtt__hA0p-6g@mail.gmail.com>
Subject: Re: Regression after recent changes to drivers/thermal/thermal_of.c
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     daniel.lezcano@linexp.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 28, 2022 at 3:04 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Oct 26, 2022 at 11:40 PM Daniel Lezcano
> <daniel.lezcano@linexp.org> wrote:
> > On 26/10/2022 19:06, Rafael J. Wysocki wrote:
>
> > > This is Daniel's work, so I'm still hoping that he'll chime in
> > > shortly,
> >
> > Yep, I'm in sick leave ATM, I broke my arm (without wordplay).
>
> Yeah I heard, get well soon!
>
> > I took sometime to read the code, so from my POV we should keep the
> > required property patch because the DT was defined that as required
> > property. The conversion to yaml obviously spotted the DT not conforming
> > with the bindings.
>
> So I guess you mean I should add some trip points to my device
> trees then so they pass validation?
>
> It's fine with me, I can just put some absolute maximum temperatures
> around the batteries, I am more worrying if there are other users
> out there that might get upset.
>
> I have a problem to add a trip point like this:
>
>                 battery-crit-lo {
>                     temperature = <-50000>;
>                     hysteresis = <2000>;
>                     type = "critical";
>                 };
>
> Despite it is legal to the schema:
>
>             properties:
>               temperature:
>                 $ref: /schemas/types.yaml#/definitions/int32
>                 minimum: -273000
>                 maximum: 200000
>                 description:
>                   An integer expressing the trip temperature in millicelsius.
>
> I get this error:
>
>   DTC     arch/arm/boot/dts/ste-ux500-samsung-golden.dtb
> Error: ../arch/arm/boot/dts/ste-ux500-samsung-golden.dts:50.21-22 syntax error
>
> Does anyone know how to put a negative number in a
> property?

Expressions have to be enclosed in parenthesis.

Rob
