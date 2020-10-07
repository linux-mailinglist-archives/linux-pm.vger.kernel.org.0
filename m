Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A277028561F
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 03:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgJGBRW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 21:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgJGBRV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 21:17:21 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90760C0613D3
        for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2020 18:17:21 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id z46so212043uac.13
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2020 18:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0yTeji9j9CJ8RmpTCa7gaMjTAdqxTBobL0tzN5/mK1k=;
        b=azsmjPD091LNc2UbH2401z0TMRKWug0UVY0ZxoU/33AhwYTmlS8RKUCXxDrGGYye8w
         LwW9iZXC9S8pAKH4F+/m3Ipa8qcea1bJ2Ha64dI+G2RBJCpAjb5Q/QzEKiiByexwaba/
         0Cnh0oAcRTF1vqMM8Jl+zCxCu4jU1vls8uyhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0yTeji9j9CJ8RmpTCa7gaMjTAdqxTBobL0tzN5/mK1k=;
        b=XBFT5liURxHnyQsMzQBxvAm8b+NYpy3AxabdEGcQrhw7Eez7hqp6mlnLCf+c1vgwZr
         kqFwV1TlTOQ8jleV732n5TOhjEe9FFyZ6QidJAD2PhTJJjdFrk2mg+79xfHYaTZ3gqXL
         WhYNtBrqi8kxqYED9nPUKoZaIxcHm+Huyzn9iEwp05axLEtxrezLAUr9fk+cmCOgzIXx
         hSJ1U7UUZ0wEM0AEIbvkbXi7qHjD+EJDYuVwK50EtB8dD+UCxABHhrXSRqjpoWBqLfDc
         LDDKbbe+XCebBZIJ+doXmPAJiKgDC5weFalMjXZPhXs47kdavJadfEJBhQj3drsAk272
         3+PA==
X-Gm-Message-State: AOAM531QjGOOTfCidJqkLvKdpXHhs8og1wj//snGooYdjuwFszAG0rQf
        anh0RMHRVJFKPDVoE8jdAloM28A1tV73Vg==
X-Google-Smtp-Source: ABdhPJz99biQ93nYeEH5uSwfyqZvwv1pt8JJKGzKL3Ym5t+Tgm8xoX5DVHr04OL6kpe+Cj4lIcYLAQ==
X-Received: by 2002:ab0:61d6:: with SMTP id m22mr346375uan.91.1602033440445;
        Tue, 06 Oct 2020 18:17:20 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id o145sm91642vkd.13.2020.10.06.18.17.17
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 18:17:19 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id z46so212010uac.13
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2020 18:17:17 -0700 (PDT)
X-Received: by 2002:ab0:6984:: with SMTP id t4mr361085uaq.0.1602033436993;
 Tue, 06 Oct 2020 18:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201002114426.31277-1-lukasz.luba@arm.com> <20201002114426.31277-4-lukasz.luba@arm.com>
 <CAD=FV=UbNP5-G1z95F37Fmv8=n0JPSSwnPQO_K==WpAc4vAHWQ@mail.gmail.com>
 <e9b6fc5a-45d3-168d-db38-6c068da26f6b@arm.com> <CAD=FV=Xkg1zpsMW5rERbibnjrgY6opZi8Z9DUFkWebb7NHtU5w@mail.gmail.com>
 <bc5d21c1-ea84-9132-2e52-ae84fbb0515a@arm.com> <CAD=FV=VfA8AB3BZk8Ykkhigv9eGijzu4zuA6KdXk0K5UG0yCCQ@mail.gmail.com>
 <CAL_JsqJ37TVk4=E1DyZuhfH1jZ7wyauGLucSH7XW9wkeT3PSgg@mail.gmail.com>
In-Reply-To: <CAL_JsqJ37TVk4=E1DyZuhfH1jZ7wyauGLucSH7XW9wkeT3PSgg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 6 Oct 2020 18:17:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vy641h5KNLKipC1n=tgjp7a3HGHw0odY9fNpwdqorrAg@mail.gmail.com>
Message-ID: <CAD=FV=Vy641h5KNLKipC1n=tgjp7a3HGHw0odY9fNpwdqorrAg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: thermal: update sustainable-power
 with abstract scale
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dietmar.Eggemann@arm.com, Quentin Perret <qperret@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Tue, Oct 6, 2020 at 3:24 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Fri, Oct 2, 2020 at 12:39 PM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Fri, Oct 2, 2020 at 9:40 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> > >
> > > On 10/2/20 4:47 PM, Doug Anderson wrote:
> > > > Hi,
> > > >
> > > > On Fri, Oct 2, 2020 at 8:13 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> > > >>
> > > >> Hi Doug,
> > > >>
> > > >> On 10/2/20 3:31 PM, Doug Anderson wrote:
> > > >>> Hi,
> > > >>>
> > > >>> On Fri, Oct 2, 2020 at 4:45 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> > > >>>>
> > > >>>> Update the documentation for the binding 'sustainable-power' and allow
> > > >>>> to provide values in an abstract scale. It is required when the cooling
> > > >>>> devices use an abstract scale for their power values.
> > > >>>>
> > > >>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> > > >>>> ---
> > > >>>>    .../devicetree/bindings/thermal/thermal-zones.yaml  | 13 +++++++++----
> > > >>>>    1 file changed, 9 insertions(+), 4 deletions(-)
> > > >>>>
> > > >>>> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> > > >>>> index 3ec9cc87ec50..4d8f2e37d1e6 100644
> > > >>>> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> > > >>>> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> > > >>>> @@ -99,10 +99,15 @@ patternProperties:
> > > >>>>          sustainable-power:
> > > >>>>            $ref: /schemas/types.yaml#/definitions/uint32
> > > >>>>            description:
> > > >>>> -          An estimate of the sustainable power (in mW) that this thermal zone
> > > >>>> -          can dissipate at the desired control temperature. For reference, the
> > > >>>> -          sustainable power of a 4-inch phone is typically 2000mW, while on a
> > > >>>> -          10-inch tablet is around 4500mW.
> > > >>>> +          An estimate of the sustainable power (in mW or in an abstract scale)
> > > >>>> +         that this thermal zone can dissipate at the desired control
> > > >>>> +         temperature. For reference, the sustainable power of a 4-inch phone
> > > >>>> +         is typically 2000mW, while on a 10-inch tablet is around 4500mW.
> > > >>>> +
> > > >>>> +         It is possible to express the sustainable power in an abstract
> > > >>>> +         scale. This is the case when the related cooling devices use also
> > > >>>> +         abstract scale to express their power usage. The scale must be
> > > >>>> +         consistent.
> > > >>>
> > > >>> Two thoughts:
> > > >>>
> > > >>> 1. If we're going to allow "sustainable-power" to be in abstract
> > > >>> scale, why not allow "dynamic-power-coefficient" to be in abstract
> > > >>> scale too?  I assume that the whole reason against that originally was
> > > >>> the idea of device tree purity, but if we're allowing the abstract
> > > >>> scale here then there seems no reason not to allow it for
> > > >>> "dynamic-power-coefficient".
> > > >>
> > > >> With this binding it's a bit more tricky.
> > > >> I also have to discuss a few things internally. This requirement of
> > > >> uW/MHz/V^2 makes the code easier also for potential drivers
> > > >> like GPU (which are going to register the devfreq cooling with EM).
> > > >>
> > > >> Let me think about it, but for now I would just update these bits.
> > > >> These are required to proper IPA operation, the dyn.-pow.-coef. is a
> > > >> nice to have and possible next step.
> > > >
> > > > I guess the problem is that Rajendra is currently planning to remove
> > > > all the "dynamic-power-coefficient" values from device tree right now
> > > > and move them to the source code because the numbers we currently have
> > > > in the device tree _are_ in abstract scale and thus violate the
> > > > bindings.  Moving this to source code won't help us get to more real
> > > > power numbers (since it'll still be abstract scale), it'll just be
> > > > pure churn.  If we're OK with the abstract scale in general then we
> > > > should allow it everywhere and not add churn for no reason.
> > >
> > > IIUC he is still going to use the Energy Model, but with different
> > > registration function. We have such a driver: scmi-cpufreq.c, which
> > > uses em_dev_register_perf_domain(). He can still use EM, EAS, IPA
> > > not violating anything.
> >
> > Right.  He's going to take the exact same "abstract scale" numbers
> > that he has today and take them out of device tree and put them in the
> > cpufreq driver.  Doing so magically makes it so that he's not
> > violating anything since "abstract scale" is not currently allowed in
> > device tree but is allowed in the cpufreq driver.  I'm not saying that
> > he's doing anything wrong, I'm just saying that it's pointless churn.
> > If we're OK with "abstract scale" in one place in the device tree we
> > should be OK with it everywhere in the device tree.  Then Rajendra
> > wouldn't need his patch at all and he could leave his numbers in the
> > device tree.
> >
> >
> > > The real problem that we want to address is with sustainable-power in
> > > IPA. It is used in power budget calculation and if the devices operate
> > > in abstract scale, then there is an issue.
> > > There are two options to get that value:
> > > 1. from DT, which can have optimized value, stored by OEM engineer
> > > 2. from IPA estimation code, which just calculates it as a sum of
> > > minimum OPP power for each cooling device.
> > >
> > > The 2nd option might not be the best for a platform, so vendor/OEM
> > > engineer might want to provide a better value in DT -> 1st option.
> > > This is currently against the binding description and I have to fix it.
> >
> > Right, things are already broken today because a SoC vendor could
> > (without violating any rules) provide their SoC core
> > "dynamic-power-coefficient" in "abstract scale" in code and there
> > would be no way to for a board to (without violating DT bindings)
> > specify a "sustainable-power".  ...so, in that sense, your patch does
> > provide a benefit even if we don't make any changes to the rules for
> > "sustainable-power".  All I'm saying is that if these new rules for
> > allowing an abstract scale for "sustainable-power" in the device tree
> > are OK that it should _also_ be OK to add new rules to allow an
> > abstract scale for "dynamic-power-coefficient".
>
> Didn't we beat this one to death with "dynamic-power-coefficient"?

We did?  Where / when?  I'm not sure I was involved, but right now
both "sustainable-power" and "dynamic-power-coefficient" are still
defined in the device tree to be in real units, not abstract scale.
Are you saying that we beat it to death and decided that it needed to
be in real units, or we beat it to death and decided that abstract
scale was OK and we just didn't put it in the bindings?


> That is the abstract scale because I don't think you can really ever
> measure it

That's debatable.  it's not very hard to get reasonable measurements.
Matthias provided a recipe earlier in the thread.  See commit
ac60c5e33df4 ("ARM: dts: rockchip: Add dynamic-power-coefficient for
rk3288").  In that case he used a machine that could easily measure
power on the CPU rail, but if you simply keep all other rails in the
system constant (and/or run a long enough test), you can easily
accomplish this by just querying the smart battery in systems.


> and because vendors don't want to advertise their absolute
> power.

That is certainly true, though after a device has shipped it's not
that hard to measure.


> > > >>> 2. Is it worth adding some type of indication of what type of units
> > > >>> "sustainable-power" is represented in?  Maybe even a made up unit so
> > > >>> that you could tell the difference between made up units in the same
> > > >>> system?  I'd envision something like:
> > > >>>
> > > >>> sustainable-power-units = "qualcomm,sc7180-bogoWatts"
> > > >>>
> > > >>> ...and on the dynamic-power-coefficient side, the same:
> > > >>>
> > > >>> dynamic-power-coefficient-units = "qualcomm,sc7180-bogoWatts"
> > > >>>
> > > >>> One could imagine someone even later (after devices are widely
> > > >>> distributed) figuring out translations between these bogoWatts numbers
> > > >>> and real Watts if someone could come up with a case where it matters.
> > > >>
> > > >> To figure this out we don't need a new binding.
> > > >> I think a simple comment in the DT would be enough for this, even e.g.:
> > > >>
> > > >> sustainable-power = <100> /* bogoWatts */
> > > >
> > > > There are some important differences:
> > > >
> > > > a) Your comment is gone when the device tree is compiled.  If we
> > > > actually add a string to the device tree then, in theory, we can add
> > > > conversions in code (without touching the device tree) down the road.
> > >
> > > We don't need code and binding with a bogoscale. It is up to the
> > > platform integrator to make sure the scale in consistent in all devices.
> > > Comment in DT is good enough.
> >
> > One other nice thing about having the units is that the device tree is
> > supposed to be more of a "pure" thing, less sullied about what's
> > convenient and more about a real description of a thing.  Presumably
> > that's why "abstract scale" wasn't allowed originally?  In any case,
> > giving quantifiable units to the number somehow makes it feel less
> > made up because it's possible to come up with a way to convert it back
> > to real units.
> >
> >
> > > > b) I believe there can be more than one abstract scale present in a
> > > > single device tree, at least in theory.  Adding a string allows you to
> > > > know if you're comparing apples to apples or apples to organges.
> > >
> > > IMHO DT is not the place for such abstractions, but Rob might correct me
> > > here.
> >
> > Yup, seems like we're blocked waiting for Rob to chime in unless
> > someone else has the authority to make the call about how to deal with
> > "abstract scale" numbers in the device tree.
>
> I don't really know nor completely follow the issues. I just get all
> these PM related bindings piece by piece with everyone solving their
> own single issue. It's death by 1000 cuts. So my default position is
> NAK. All the missing pieces and deficiencies can build up until
> there's a coherent picture (maybe?).

I'm totally confused.  NAK on what?  NAK on Lukasz's patch?  ...or
Lukasz's patch is totally fine but NAK on also allowing abstract scale
for 'dynamic-power-coefficient".  Or NAK on adding units?  NAK on
something else?

-Doug
