Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4174E2819BC
	for <lists+linux-pm@lfdr.de>; Fri,  2 Oct 2020 19:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388511AbgJBRjk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Oct 2020 13:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388406AbgJBRjd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Oct 2020 13:39:33 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED9DC0613E4
        for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2020 10:39:33 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id a16so994463vsp.12
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2020 10:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4yhMH5PEf+rCZZkZGdh40aYy4T1Wm9iOOW+zJXjnuHk=;
        b=dfvoSI1Uq+qVVIYibol1p3/Reagu21mMHqIADjWFIOsoUGyn+8szMRTS8DnDgxQmLD
         NSw61VJCHeyy6Jud7s8ZIWx22pLBVFjDABiv74XtNri+Kb1auGwlI0D1j/YYY6QPRiKP
         cAkckBuqIFDhYMVi7qq9Fmnzs8h57IsYNEZyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4yhMH5PEf+rCZZkZGdh40aYy4T1Wm9iOOW+zJXjnuHk=;
        b=c3bz6VdcfZngdUk4lAaPW5mnvt0UxSbzkm6gB0mFV9hkxbpqEv72Thca6MoyvhbBLR
         5U/1aMm15dkzOIHBXTwJmz7mp0vQGoWwOOT09CGLdXk8Hl8fd+Cyg80Hw7LZYA+67h71
         35Cojtpy5kNlfu3v64gu1EQtqdXYnRHsgRoJ7czORb3Nv4OvXSofZxrWTTXzKFnJ1ouk
         rrz8ovMa8HPOGZ1MvnfHvKy9hxCHpoUtqcyX+8we6G20sosYp7fmamspkS/IzxkC2Hem
         qIanPrjaib3OSzZVWyRmq9yYG9H6EPaYoB5O3IAsmLUSs6MT36lAuyCF7Hv1EfHNO799
         J7Hg==
X-Gm-Message-State: AOAM531BUgyoO6/U12Jrb7B10vZ1JuduwnXo7pGPssXdSpVNBiOsyBWi
        FdP9y6DjMqi4f1OueS5AQrNwsh3yLXIY3A==
X-Google-Smtp-Source: ABdhPJzFXZfTzq6Pef/yd3ia1jJp/oIhUgdDplJL8QxjCwob/H98lKQlnFIIAmM1a63fgPV2oEs1RQ==
X-Received: by 2002:a67:cb02:: with SMTP id b2mr1945344vsl.41.1601660371628;
        Fri, 02 Oct 2020 10:39:31 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id b23sm336990vsh.9.2020.10.02.10.39.30
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 10:39:30 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id d18so606268uav.4
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2020 10:39:30 -0700 (PDT)
X-Received: by 2002:ab0:4542:: with SMTP id r60mr1965910uar.90.1601660369709;
 Fri, 02 Oct 2020 10:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201002114426.31277-1-lukasz.luba@arm.com> <20201002114426.31277-4-lukasz.luba@arm.com>
 <CAD=FV=UbNP5-G1z95F37Fmv8=n0JPSSwnPQO_K==WpAc4vAHWQ@mail.gmail.com>
 <e9b6fc5a-45d3-168d-db38-6c068da26f6b@arm.com> <CAD=FV=Xkg1zpsMW5rERbibnjrgY6opZi8Z9DUFkWebb7NHtU5w@mail.gmail.com>
 <bc5d21c1-ea84-9132-2e52-ae84fbb0515a@arm.com>
In-Reply-To: <bc5d21c1-ea84-9132-2e52-ae84fbb0515a@arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 2 Oct 2020 10:39:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VfA8AB3BZk8Ykkhigv9eGijzu4zuA6KdXk0K5UG0yCCQ@mail.gmail.com>
Message-ID: <CAD=FV=VfA8AB3BZk8Ykkhigv9eGijzu4zuA6KdXk0K5UG0yCCQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: thermal: update sustainable-power
 with abstract scale
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, linux-doc@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        amitk@kernel.org, Jonathan Corbet <corbet@lwn.net>,
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

On Fri, Oct 2, 2020 at 9:40 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> On 10/2/20 4:47 PM, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Oct 2, 2020 at 8:13 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >> Hi Doug,
> >>
> >> On 10/2/20 3:31 PM, Doug Anderson wrote:
> >>> Hi,
> >>>
> >>> On Fri, Oct 2, 2020 at 4:45 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>>>
> >>>> Update the documentation for the binding 'sustainable-power' and allow
> >>>> to provide values in an abstract scale. It is required when the cooling
> >>>> devices use an abstract scale for their power values.
> >>>>
> >>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> >>>> ---
> >>>>    .../devicetree/bindings/thermal/thermal-zones.yaml  | 13 +++++++++----
> >>>>    1 file changed, 9 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> >>>> index 3ec9cc87ec50..4d8f2e37d1e6 100644
> >>>> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> >>>> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> >>>> @@ -99,10 +99,15 @@ patternProperties:
> >>>>          sustainable-power:
> >>>>            $ref: /schemas/types.yaml#/definitions/uint32
> >>>>            description:
> >>>> -          An estimate of the sustainable power (in mW) that this thermal zone
> >>>> -          can dissipate at the desired control temperature. For reference, the
> >>>> -          sustainable power of a 4-inch phone is typically 2000mW, while on a
> >>>> -          10-inch tablet is around 4500mW.
> >>>> +          An estimate of the sustainable power (in mW or in an abstract scale)
> >>>> +         that this thermal zone can dissipate at the desired control
> >>>> +         temperature. For reference, the sustainable power of a 4-inch phone
> >>>> +         is typically 2000mW, while on a 10-inch tablet is around 4500mW.
> >>>> +
> >>>> +         It is possible to express the sustainable power in an abstract
> >>>> +         scale. This is the case when the related cooling devices use also
> >>>> +         abstract scale to express their power usage. The scale must be
> >>>> +         consistent.
> >>>
> >>> Two thoughts:
> >>>
> >>> 1. If we're going to allow "sustainable-power" to be in abstract
> >>> scale, why not allow "dynamic-power-coefficient" to be in abstract
> >>> scale too?  I assume that the whole reason against that originally was
> >>> the idea of device tree purity, but if we're allowing the abstract
> >>> scale here then there seems no reason not to allow it for
> >>> "dynamic-power-coefficient".
> >>
> >> With this binding it's a bit more tricky.
> >> I also have to discuss a few things internally. This requirement of
> >> uW/MHz/V^2 makes the code easier also for potential drivers
> >> like GPU (which are going to register the devfreq cooling with EM).
> >>
> >> Let me think about it, but for now I would just update these bits.
> >> These are required to proper IPA operation, the dyn.-pow.-coef. is a
> >> nice to have and possible next step.
> >
> > I guess the problem is that Rajendra is currently planning to remove
> > all the "dynamic-power-coefficient" values from device tree right now
> > and move them to the source code because the numbers we currently have
> > in the device tree _are_ in abstract scale and thus violate the
> > bindings.  Moving this to source code won't help us get to more real
> > power numbers (since it'll still be abstract scale), it'll just be
> > pure churn.  If we're OK with the abstract scale in general then we
> > should allow it everywhere and not add churn for no reason.
>
> IIUC he is still going to use the Energy Model, but with different
> registration function. We have such a driver: scmi-cpufreq.c, which
> uses em_dev_register_perf_domain(). He can still use EM, EAS, IPA
> not violating anything.

Right.  He's going to take the exact same "abstract scale" numbers
that he has today and take them out of device tree and put them in the
cpufreq driver.  Doing so magically makes it so that he's not
violating anything since "abstract scale" is not currently allowed in
device tree but is allowed in the cpufreq driver.  I'm not saying that
he's doing anything wrong, I'm just saying that it's pointless churn.
If we're OK with "abstract scale" in one place in the device tree we
should be OK with it everywhere in the device tree.  Then Rajendra
wouldn't need his patch at all and he could leave his numbers in the
device tree.


> The real problem that we want to address is with sustainable-power in
> IPA. It is used in power budget calculation and if the devices operate
> in abstract scale, then there is an issue.
> There are two options to get that value:
> 1. from DT, which can have optimized value, stored by OEM engineer
> 2. from IPA estimation code, which just calculates it as a sum of
> minimum OPP power for each cooling device.
>
> The 2nd option might not be the best for a platform, so vendor/OEM
> engineer might want to provide a better value in DT -> 1st option.
> This is currently against the binding description and I have to fix it.

Right, things are already broken today because a SoC vendor could
(without violating any rules) provide their SoC core
"dynamic-power-coefficient" in "abstract scale" in code and there
would be no way to for a board to (without violating DT bindings)
specify a "sustainable-power".  ...so, in that sense, your patch does
provide a benefit even if we don't make any changes to the rules for
"sustainable-power".  All I'm saying is that if these new rules for
allowing an abstract scale for "sustainable-power" in the device tree
are OK that it should _also_ be OK to add new rules to allow an
abstract scale for "dynamic-power-coefficient".


> >>> 2. Is it worth adding some type of indication of what type of units
> >>> "sustainable-power" is represented in?  Maybe even a made up unit so
> >>> that you could tell the difference between made up units in the same
> >>> system?  I'd envision something like:
> >>>
> >>> sustainable-power-units = "qualcomm,sc7180-bogoWatts"
> >>>
> >>> ...and on the dynamic-power-coefficient side, the same:
> >>>
> >>> dynamic-power-coefficient-units = "qualcomm,sc7180-bogoWatts"
> >>>
> >>> One could imagine someone even later (after devices are widely
> >>> distributed) figuring out translations between these bogoWatts numbers
> >>> and real Watts if someone could come up with a case where it matters.
> >>
> >> To figure this out we don't need a new binding.
> >> I think a simple comment in the DT would be enough for this, even e.g.:
> >>
> >> sustainable-power = <100> /* bogoWatts */
> >
> > There are some important differences:
> >
> > a) Your comment is gone when the device tree is compiled.  If we
> > actually add a string to the device tree then, in theory, we can add
> > conversions in code (without touching the device tree) down the road.
>
> We don't need code and binding with a bogoscale. It is up to the
> platform integrator to make sure the scale in consistent in all devices.
> Comment in DT is good enough.

One other nice thing about having the units is that the device tree is
supposed to be more of a "pure" thing, less sullied about what's
convenient and more about a real description of a thing.  Presumably
that's why "abstract scale" wasn't allowed originally?  In any case,
giving quantifiable units to the number somehow makes it feel less
made up because it's possible to come up with a way to convert it back
to real units.


> > b) I believe there can be more than one abstract scale present in a
> > single device tree, at least in theory.  Adding a string allows you to
> > know if you're comparing apples to apples or apples to organges.
>
> IMHO DT is not the place for such abstractions, but Rob might correct me
> here.

Yup, seems like we're blocked waiting for Rob to chime in unless
someone else has the authority to make the call about how to deal with
"abstract scale" numbers in the device tree.

-Doug
