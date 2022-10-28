Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7802D610D7E
	for <lists+linux-pm@lfdr.de>; Fri, 28 Oct 2022 11:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJ1Jmw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Oct 2022 05:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiJ1Jmv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Oct 2022 05:42:51 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B079AD77F9
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 02:42:50 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a67so7030949edf.12
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 02:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tidkw59Dmh1Xx8XtSEY2gxWOi6gwoBpm4flukU9eic=;
        b=el2JpdyAEnMNcy2unuVRs18eTxpN0nmDS/GpRxfOmdShpwa+D7/mlekPCQexdnzeFT
         1whjhASh+IGHspJcSebajUERbrxvLWQNuGbUgpANIiBc+U0KLlLUtST98VFZb9gXngJv
         7KBMeCdoYOcv6/NXs/vEDWRoZMIb8fEMPMTBHUBNT/UEOLoX8K6S19luefi1wUCKZu2o
         Spqzgkf04oeMAWPZGV2pqpG08cFunAJ1ETvgEkftoN0Gzh08JawWvj7VGHptdmLaYtBi
         JIssDXyA88nRVyMLD+tEseYxQBwJctuy6YorizpwjsDnAN26b1bVwWwoT8W/OijwhFVr
         ahsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tidkw59Dmh1Xx8XtSEY2gxWOi6gwoBpm4flukU9eic=;
        b=yb4Xo6Mop3qyTPooUE0NX7ZNeqQillmVkTjroOKwCmyrrUdSv5gZyXxWJmIrB2qOyO
         3j3bZRvK0GiS/hRRc5m7NT7xtMbuasO3T4w79TfUCLYX12b8jEmlWDvuZZoW6QTFa1OV
         McBNV1DOlgc6ahRjuITh2NBC/rL1lkcMZC4ZMvmgsGjj2xIPLHdC3t+yub/NT3u5vaB2
         Mosopt3VbePlKgt0/TOWibEL3ODMNxk4kBZYfoh+JsqrPrEDNNZZPEvpoDUDhYANv8wq
         L8/CTeVB/zqHmxGkxY/N4+f05/wLuLmCmN03LX/Nm8rcNDG0Qtxtv5BoUKVI20r4bc1Q
         2Gag==
X-Gm-Message-State: ACrzQf33/D8S/LvQiyBNyXkHWuKwqf4LQ6/Hs3cNelU3m4fs3xiYHWKL
        z/Wi3ePn/2WLkF9+RfUDsdGe4f/qJOu0zqxnFMaRsw==
X-Google-Smtp-Source: AMsMyM5OetyffzJ8v0NnTb6WZBKOeHRqn3GgrNxWzVHQw2FMjm08/KEW1rijf9G4WOduhnNvdGcCyGEtB0tvj9m+M+g=
X-Received: by 2002:a05:6402:d0b:b0:458:a244:4e99 with SMTP id
 eb11-20020a0564020d0b00b00458a2444e99mr50114819edb.46.1666950169257; Fri, 28
 Oct 2022 02:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkdbB5hgkrPZVb-+9tuKErvwjTKNaBQ1LvH1==fR7bndjSQ@mail.gmail.com>
 <CAL_JsqKQM4oSxrbhA4_ST8O0ieek9sGQQ9p55AXjhqmVx=rUrw@mail.gmail.com>
 <CAJZ5v0i76X0TiaOhPa3a5440fRb7vA1z1mFKJibso8G6wYz7HQ@mail.gmail.com>
 <4817aeca-4fb1-cb99-8df5-7df22a77ea3f@linexp.org> <CACRpkdb=WX5XO1YDB04uLzv=tNfpmr+ORN+LkAiZTE6gSris_g@mail.gmail.com>
 <c98486ac-0a32-f650-0084-96cc5c255df9@linexp.org>
In-Reply-To: <c98486ac-0a32-f650-0084-96cc5c255df9@linexp.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Oct 2022 11:42:37 +0200
Message-ID: <CACRpkdZ4CW5=mEXx2hYpnB-d3AO8v6PSqbqGBbzpiNOS1wmpDg@mail.gmail.com>
Subject: Re: Regression after recent changes to drivers/thermal/thermal_of.c
To:     Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 28, 2022 at 11:31 AM Daniel Lezcano
<daniel.lezcano@linexp.org> wrote:

> > I have a problem to add a trip point like this:
> >
> >                  battery-crit-lo {
> >                      temperature =3D <-50000>;
> >                      hysteresis =3D <2000>;
> >                      type =3D "critical";
> >                  };
> >
> > Despite it is legal to the schema:
> >
> >              properties:
> >                temperature:
> >                  $ref: /schemas/types.yaml#/definitions/int32
> >                  minimum: -273000
> >                  maximum: 200000
> >                  description:
> >                    An integer expressing the trip temperature in millic=
elsius.
> >
> > I get this error:
> >
> >    DTC     arch/arm/boot/dts/ste-ux500-samsung-golden.dtb
> > Error: ../arch/arm/boot/dts/ste-ux500-samsung-golden.dts:50.21-22 synta=
x error
> >
> > Does anyone know how to put a negative number in a
> > property?
>
> I don't know but the thermal framework does not support the cold trip
> points (yet).

Aha! But does the DT bindings support it?

> That means here, the battery will be in temperature
> violation if the temperature is above -50=C2=B0C

Hm are the DT bindings written like such or do they also imply that
we only have "above this temperature" trips? The way I read it,
it is kind of an open question.

Maybe we should make it explicit
in the DT bindings that if there is a positive number in the temperature
of a trip point we trip above the point, and if there is a negative
number we trip below the point?

I can make a patch.

Then another day we can add "heating-maps" :D

These use cases might seem alien but I think they actually exist.

> > The concept of "thermal zone" actually makes much more
> > sense for a battery since the thermistor is often not mounted
> > in the battery (at least not in this case) and is measuring
> > the proximity of the battery, not the battery per se.
>
> IMO, you are reinventing the wheel in the battery code.
>
> Why not use the cooling device psy_register_cooler()? And let the
> thermal framework deal with the monitoring and the mitigation ?
>
> (cold trip point handling will have to stay in the current code)

OK I will look into this. It's not a big thing really, very little code.

Mainly the charging state machine likes to keep everything
under its own umbrella, so the state machine moves into a special
state when things get too hot or too cold, so the idea would be
to have the framework cooler trigger the state instead.

> >> Below a patch (not tested): one hand writing is painful
> >
> > This works!
> > I can sign off the patch and send it if you like.
>
> Sure, no problem. May be see if that could be done more elegantly?
>
> > I would probably alter the warning text "please add trip
> > points to your DTS..."
>
> Ok

I'll send something soon!

Yours,
Linus Walleij
