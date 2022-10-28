Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5874F610BC8
	for <lists+linux-pm@lfdr.de>; Fri, 28 Oct 2022 10:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJ1IEd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Oct 2022 04:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJ1IEc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Oct 2022 04:04:32 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787DF65C7
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 01:04:30 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id 13so11196937ejn.3
        for <linux-pm@vger.kernel.org>; Fri, 28 Oct 2022 01:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yWOQN3h4ChRAKCuBRTq0s/uYYW3WppEyOmor3aj/gE=;
        b=Me2eVZC8oA4QP+w4O6drdHEHNZYcqSijsOjVkoSWO/cFOWHAax4l/lvi5v+AYsC4mR
         6yNfa5hZY28AkNdVrZNJk5wysBOcrjTqf3g0jz7aIfuxldwkoaF/b4Jz2YMpg0kuCl+E
         KE4tEjWUoVGj/v4qbdHZoU+bAMuVl+bjq1wFBHprkeLHbXFX22RYXEv7lQGrMMCnryOT
         FNwPX80x4/9O4Qya1E8pQb/YUfvV1Omlwaj1zTVVfMV9+Ym+Bf37E7ldQoL72hfcsiYd
         VEePl+s3Vk3rRLdk4WX5uyJ2HYdpIbHEs0BSDu6nXdZpqUew7cWLKJhGR0eNjRtmnl7j
         /MQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yWOQN3h4ChRAKCuBRTq0s/uYYW3WppEyOmor3aj/gE=;
        b=S1yjFEvWqOL5lFWsAnvodwht6nGXkWXwchNaMH9ARbLeugZH4bb/8pv3Mq/m3uH/+/
         HYaFqLGPstpzFdcO3+qbgnmS/sjsLAUr3Hp/GFOjLIyh9ONFKpXRfX9EXAkKMpwZBHh9
         Q3Ng4UqogCzIvNo3XxzazRdV9HtvC8YZGyNnBQJAhdXU/SSMgUt9Jkcvggrf6kTgHVcn
         XDrNXJwT52kAEqjkJYRrqjQKD7pgVD45n7HzsKhjFESnpC7ImYRgmUNXv1txMV2jMJFL
         SYeM9u0it7PFqJWeHaWkFChCW9Fytr8U3YkLrHNKfId+Y0y+jjQWXHliMctfZYXYD+y5
         lbOQ==
X-Gm-Message-State: ACrzQf1vv29o0N5HE9E5vkiJwaWXUVlrfVbs06htGioKNwkx8DP9f22I
        qC815DqfJcHELdQmrN/A+A+qdC9J/B+zChczktCn1/a3H/vtRw==
X-Google-Smtp-Source: AMsMyM73cqy5xBOfnUiUhVgtyQPThxpj8uwbL7Ce27b6toFyoDg4BOhg1MWGxkKV6pvnb1OgRua4f2ouj09N+looehQ=
X-Received: by 2002:a17:907:7606:b0:78e:61d:757e with SMTP id
 jx6-20020a170907760600b0078e061d757emr43360445ejc.690.1666944268958; Fri, 28
 Oct 2022 01:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <CACRpkdbB5hgkrPZVb-+9tuKErvwjTKNaBQ1LvH1==fR7bndjSQ@mail.gmail.com>
 <CAL_JsqKQM4oSxrbhA4_ST8O0ieek9sGQQ9p55AXjhqmVx=rUrw@mail.gmail.com>
 <CAJZ5v0i76X0TiaOhPa3a5440fRb7vA1z1mFKJibso8G6wYz7HQ@mail.gmail.com> <4817aeca-4fb1-cb99-8df5-7df22a77ea3f@linexp.org>
In-Reply-To: <4817aeca-4fb1-cb99-8df5-7df22a77ea3f@linexp.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Oct 2022 10:04:17 +0200
Message-ID: <CACRpkdb=WX5XO1YDB04uLzv=tNfpmr+ORN+LkAiZTE6gSris_g@mail.gmail.com>
Subject: Re: Regression after recent changes to drivers/thermal/thermal_of.c
To:     daniel.lezcano@linexp.org
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

On Wed, Oct 26, 2022 at 11:40 PM Daniel Lezcano
<daniel.lezcano@linexp.org> wrote:
> On 26/10/2022 19:06, Rafael J. Wysocki wrote:

> > This is Daniel's work, so I'm still hoping that he'll chime in
> > shortly,
>
> Yep, I'm in sick leave ATM, I broke my arm (without wordplay).

Yeah I heard, get well soon!

> I took sometime to read the code, so from my POV we should keep the
> required property patch because the DT was defined that as required
> property. The conversion to yaml obviously spotted the DT not conforming
> with the bindings.

So I guess you mean I should add some trip points to my device
trees then so they pass validation?

It's fine with me, I can just put some absolute maximum temperatures
around the batteries, I am more worrying if there are other users
out there that might get upset.

I have a problem to add a trip point like this:

                battery-crit-lo {
                    temperature =3D <-50000>;
                    hysteresis =3D <2000>;
                    type =3D "critical";
                };

Despite it is legal to the schema:

            properties:
              temperature:
                $ref: /schemas/types.yaml#/definitions/int32
                minimum: -273000
                maximum: 200000
                description:
                  An integer expressing the trip temperature in millicelsiu=
s.

I get this error:

  DTC     arch/arm/boot/dts/ste-ux500-samsung-golden.dtb
Error: ../arch/arm/boot/dts/ste-ux500-samsung-golden.dts:50.21-22 syntax er=
ror

Does anyone know how to put a negative number in a
property?

>  From an implementation POV, that was not spotted initially because of
> the old OF code design IMO (but I'm not sure).
>
> We can continue registering the thermal with no trip points but then
> still raise a message.
>
> However, a thermal zone without trip point does not really make sense
> IMO. If I'm correct, the ACPI at least defines the critical temperature
> as a non optional object.

I don't know about that, this is from one of my laptops, output
from "sensors" command:

acpitz-acpi-0
Adapter: ACPI interface
temp1:        +46.0=C2=B0C  (crit =3D +99.0=C2=B0C)
temp2:        +46.0=C2=B0C

This temp2 looks like a temperature zone without trip point...

I guess Rafael might know for sure what is out there?

But if the idea is that DT want to mimic what ACPI is doing
then it seems to me that ACPI has thermal zones without
trip points.

> Did you consider using hwmon instead of a thermal zone ?

The concept of "thermal zone" actually makes much more
sense for a battery since the thermistor is often not mounted
in the battery (at least not in this case) and is measuring
the proximity of the battery, not the battery per se.

> Below a patch (not tested): one hand writing is painful

This works!
I can sign off the patch and send it if you like.
I would probably alter the warning text "please add trip
points to your DTS..."

Yours,
Linus Walleij
