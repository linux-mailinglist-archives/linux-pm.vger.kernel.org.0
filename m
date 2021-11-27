Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAFE445F7B8
	for <lists+linux-pm@lfdr.de>; Sat, 27 Nov 2021 01:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236288AbhK0BCC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Nov 2021 20:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236441AbhK0BAB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Nov 2021 20:00:01 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DABC061758
        for <linux-pm@vger.kernel.org>; Fri, 26 Nov 2021 16:54:59 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso16217058otj.1
        for <linux-pm@vger.kernel.org>; Fri, 26 Nov 2021 16:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vLaxgooHi9QLp5Ez0U6aCNHoJaipVjvQ2YI7OPA5KFU=;
        b=H9aLlRuzRtkoK+WjArGY/UwvwG/EGHEngk12lrcK7UqgVWKmOBZSd9PzTMpYEkWINH
         qJG/PHekCro6yUIQBPO7Eow8BJU7mwfpRBIukgJHoEsC7TJzV5kiRn/yuNXY0bZdF8K5
         s4ftZ6Ctlsgss7CUbIBNTgQsNZ1YOPLCDb3OgqzXh/c6o+niwj/eUUIOdFfIgOxEBBJK
         HCrspG9VqPvyX0TNwU/zKKwtP4XzLefm55S4Goc6rMRX+4yE6Lj5Qtg2L1T4uBT4OteT
         Qh3deK7KScCK9aQwHy+sRJ3Y1yhaRfkFY4OMOwZPgOmc8fdwHLN2Hm3l7V2IrmCHT0XU
         VYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vLaxgooHi9QLp5Ez0U6aCNHoJaipVjvQ2YI7OPA5KFU=;
        b=ul/w675WPElhH9tjBRfaxU9MiGtBVjwo3d4DAiMC0ZUV4QbzXaK7ecnRPmehoHJ+XO
         HyNzCNxWJXVhncrma6x8buqIHLruJvTFqYrfRt/niQnZ9PZWO8ZHLQpsOa3N6UkSG+r/
         eSrgypbYy4hfXVkrbjumX4bbVnC1eLwGBeZgKjzw0FFXVrS8gLQI7kEl10PpjQpUTMoJ
         tnHSpMR0kH4E5UEyY7SAptRaHodyfXe8PeoJpNhsj1bmas+jVkwdKQsxGjuMHWjLWg77
         U9j0ZKqzCEFJeuycSTW15gA6ngf0EZXGSnbulFMjcOElqso9Gg0m1Fg4gRqC2KQephV6
         fsYQ==
X-Gm-Message-State: AOAM5311FC9wSLrnx9jiMa1d9ohseXMijC6RRMMR2v1LEYzwRsJNq+yc
        CENFuRrhkc4NgqNoVCLaECfevKyxyv9Zl7i7A7ujGA==
X-Google-Smtp-Source: ABdhPJyl4CWjfUu5Dd5IBitp9ynLH4Yn5kT8f178Dhs4GP4HnEIYIqKv7X4kU/Y4PsRBVL7QEQUo6Ed+Zhzb1zMW2Fk=
X-Received: by 2002:a9d:ed6:: with SMTP id 80mr31220877otj.35.1637974499131;
 Fri, 26 Nov 2021 16:54:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
 <6123f62ac44e6513a498d15034a4b6b22abe5f5b.1637061794.git.matti.vaittinen@fi.rohmeurope.com>
 <CACRpkdbKeW+pJ8SZ0fPD+9kEtgHgi2A9U=f6XyKTHogKU-9F9g@mail.gmail.com>
 <7b34e88f-54f3-6d0a-293e-b2b411d1c5c2@fi.rohmeurope.com> <676253b9-ff69-7891-1f26-a8b5bb5a421b@fi.rohmeurope.com>
In-Reply-To: <676253b9-ff69-7891-1f26-a8b5bb5a421b@fi.rohmeurope.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 27 Nov 2021 01:54:46 +0100
Message-ID: <CACRpkdZXhw9+txdLv-k01nzH3+GvGivyAoCO1JCf2VyYK96CnQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/9] power: supply: Support DT originated
 temperature-capacity tables
To:     "Vaittinen, Matti" <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "rostokus@gmail.com" <rostokus@gmail.com>,
        "fan.chen@mediatek.com" <fan.chen@mediatek.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-power <linux-power@fi.rohmeurope.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Matti,

don't worry you are probably right. You are the domain expert working
on stuff like this inside a company that actually makes charger ICs.
I am just some guy on the street. So I certainly trust you on this.

On Fri, Nov 26, 2021 at 12:56 PM Vaittinen, Matti
<Matti.Vaittinen@fi.rohmeurope.com> wrote:

> I don't see providing OCV tables at different temperature gives the
> degradation of battery capacity. Whoah. A big thought for Friday.

I think we are getting close to academic definitions of the problem,
so we'd need input from people who actually work on charging and
knows how this works? Or we need to read up on it :/

> We get the OCV => SOC correspondance at different temperatures.

I read
OCV = Open Circuit Voltage (which we can't measure but must calculate)
and
SOC = State of Charge (a percentage of the capacity)

And we agree what the bindings and code gives today is
(temp, OCV) -> SoC (%)

And this assumption is:

A) wrong as in the earth is flat or it makes the same sens to
   take a random number and use as capacity

B) wrong as in not good enough and a bit rough around the
   edges and you have an idea how to improve it

I assume (B) and what we are seeing on the battery indicator on
most of the worlds mobile phones etc is sometimes a bit so-so
because they have only used the above. (I think some people can
attest to experiencing this problem.)

And now we want something better, think medical equipment.

> I
> however don't see how this gives the OCV => energy relation. As far as I
> know both the OCV and the 'amount of uAhs battery is able to store' are
> impacted by temperature change. This means, seeing the OCV => SOC at
> different temperatures does not tell us what is the impact of
> temperature to the OCV, and what is the impact to SOC.

It is definitely true that both the OCV and SOC changes according to
temperature.

But it is also true that these tables for a certain temperature are written
with an OCV measured at this temperature, so the OCV used in the
table is already compensated for the temperature, right?

> For cases like the ROHM Chargers, we are interested on how much has the
> 'ability to store uAhs' changed due to the temperature. When we know the
> amount of uAhs we can store, we can use the coulomb counter value to
> estimate what we still have left in the battery.
>
> In addition to this we do use the OCV information for the "nearly
> depleted battery" - to improve the estimation by zero-correction
> algorithm. I must admit Friday afternoon is not the time I can quite
> recap this part. I think it was something like:
>
> 1. Measure VBat with system load (VBAT)
> 2. Find OCV corresponding the current SOC estimate (SOC based on coulomb
> counter value) - OCV_NOW
> 3. Compute VDROP caused by the load (OCV_NOW - VBAT)
> 4. Assume VDROP stays constant (or use ROHM VDR parameters if provided)
> 5. Using VDROP compute the OCV_MIN which matches the minimum battery
> voltage where system is still operational
> 6. Use the OCV_MIN and "OCV at SOC0 from calibration data" difference to
> adjust the battery capacity.

That's a neat trick!
If you look at drivers/power/supply/ab8500_fg.c function
ab8500_fg_load_comp_volt_to_capacity() you find how
someone else chose to do this with a bit of averaging etc.

> >> I'd just calculate a few tables per temperature and be done with
> >> it.
> >>
> >> At least documentation needs to be updated to reflect that the two
> >> methods
> >> are exclusive and you can only use one of them.
>
> I don't see these exclusive (at Friday afternoon at least). I think they
> can complement each-others. The temp_degradation table gives us the
> temperature impact on <energy storing ability>, eg, how much the battery
> capacity has changed from designed one due to the temperature.
>
> OCV-SOC tables at various temperatures tell us how OCV looks like when
> we have X% of battery left at different temperatures. Estimation of how
> much the X% is in absolute uAhs can be done by taking into account the
> designed_cap, aging degradation and the temperature degradation (and the
> position of moon, amount of muons created by cosmic rays hitting
> athmosphere at knee energy region and so on...)
>
> Or am I just getting something terribly wrong (again)? :)
> (I still for example like internal functions named as __foo() )

OK so yeah I think you are at something here. Which is generic.

The battery indicator in my Tesla in Swedish winter times looks
like this:

+-------------------+---+
|       25%         | * |
+-------------------+---+

So the star * indicates some extra capacity that is taken away
because of the low temperature.

This must be because the system is aware about the impact on
the battery available uAh of the temperature. As you use the
battery it will get warmer and the capacity will increase and the
little star goes away.

Current random mobile phones are not this great and do not
estimate the capacity fall because of the temperature, just shows
a percentage of the full capacity at the temperature right now
whatever that capacity may be, so it is a relative scale and we
can never show anything as nice as what the Tesla does with
this.

Then the question is: is the method used by Rohm universal and
well-known and something many chargers will do exactly this
way, so it should be in the core, or is it a particularity that should
be in your driver?

Yours,
Linus Walleij
