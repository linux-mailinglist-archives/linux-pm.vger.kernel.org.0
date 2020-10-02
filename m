Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF6E28170C
	for <lists+linux-pm@lfdr.de>; Fri,  2 Oct 2020 17:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388088AbgJBPsN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Oct 2020 11:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388039AbgJBPsM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Oct 2020 11:48:12 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A4AC0613E3
        for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2020 08:48:11 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id g16so517371uan.5
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2020 08:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T1VBeMl6lnk6uGVYC4UMbcUFzllZv34qpogDPSQOP7M=;
        b=NOBFHu51EDHrcub6xy7AvFiSRurn1fHm20p6heYCzLvQA4DiSWLmItq04o64PqKZJL
         ON7UOtMwm7wOsHDwKznnfPF3yO5akXtBqmhN2CLd4iY6ZkbJCnZj4n4pPLQQJutstBul
         NQGnGObIukRPoeNo1cN9Buh0HQPiZDPQomocE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T1VBeMl6lnk6uGVYC4UMbcUFzllZv34qpogDPSQOP7M=;
        b=aYPSXCA/4Obxh53MW2gjK4SW5AK4tU1R7haQkf8mpm39BBAZGG/TV0SuaLAyPzUcGu
         v/sxIidik7UKJeen/7bwxFXAEN20yFcSMTrDWRvALqbkSh9gy6T1w7o390uIx+SBRfkw
         yWpvaFooogtfUaORrWMnGEUv752He49TKz8fhZuy4gBwDIUjlTAXC1+We931j/w2Mrdv
         QedgqC/pFeQ3flQsSX2Ebsrk7OfGL935raipdjLSPIn9PFEcRv/c9yIp9jKhwJmJ1iv4
         volBIdiE4gSJTl2pNPHv9qHVgbQaFDs2+CaSQiX8si5voY5wbK76U+Vyp/thgVDvAytd
         MHGA==
X-Gm-Message-State: AOAM531u3gMqWfVAm/B7CMYtc+R/CmNBKTVEFxxXfi5BPTMbxo58Z8SA
        vrmC69cKBWBMoClB/Pv4NiYlRxB3xlFGiA==
X-Google-Smtp-Source: ABdhPJx2glyjrsom6kHmQw1YqNAgtPBmTAcMI8MT/RP5RQhSPjmwzDGs2Zc3F5scaySPQEl089F4gQ==
X-Received: by 2002:ab0:768:: with SMTP id h95mr1498257uah.23.1601653689674;
        Fri, 02 Oct 2020 08:48:09 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id o145sm299425vkd.13.2020.10.02.08.48.07
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 08:48:08 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id c63so383727vkb.7
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2020 08:48:07 -0700 (PDT)
X-Received: by 2002:a1f:a905:: with SMTP id s5mr1631052vke.9.1601653687217;
 Fri, 02 Oct 2020 08:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201002114426.31277-1-lukasz.luba@arm.com> <20201002114426.31277-4-lukasz.luba@arm.com>
 <CAD=FV=UbNP5-G1z95F37Fmv8=n0JPSSwnPQO_K==WpAc4vAHWQ@mail.gmail.com> <e9b6fc5a-45d3-168d-db38-6c068da26f6b@arm.com>
In-Reply-To: <e9b6fc5a-45d3-168d-db38-6c068da26f6b@arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 2 Oct 2020 08:47:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xkg1zpsMW5rERbibnjrgY6opZi8Z9DUFkWebb7NHtU5w@mail.gmail.com>
Message-ID: <CAD=FV=Xkg1zpsMW5rERbibnjrgY6opZi8Z9DUFkWebb7NHtU5w@mail.gmail.com>
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

On Fri, Oct 2, 2020 at 8:13 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Doug,
>
> On 10/2/20 3:31 PM, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Oct 2, 2020 at 4:45 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >> Update the documentation for the binding 'sustainable-power' and allow
> >> to provide values in an abstract scale. It is required when the cooling
> >> devices use an abstract scale for their power values.
> >>
> >> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> >> ---
> >>   .../devicetree/bindings/thermal/thermal-zones.yaml  | 13 +++++++++----
> >>   1 file changed, 9 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> >> index 3ec9cc87ec50..4d8f2e37d1e6 100644
> >> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> >> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> >> @@ -99,10 +99,15 @@ patternProperties:
> >>         sustainable-power:
> >>           $ref: /schemas/types.yaml#/definitions/uint32
> >>           description:
> >> -          An estimate of the sustainable power (in mW) that this thermal zone
> >> -          can dissipate at the desired control temperature. For reference, the
> >> -          sustainable power of a 4-inch phone is typically 2000mW, while on a
> >> -          10-inch tablet is around 4500mW.
> >> +          An estimate of the sustainable power (in mW or in an abstract scale)
> >> +         that this thermal zone can dissipate at the desired control
> >> +         temperature. For reference, the sustainable power of a 4-inch phone
> >> +         is typically 2000mW, while on a 10-inch tablet is around 4500mW.
> >> +
> >> +         It is possible to express the sustainable power in an abstract
> >> +         scale. This is the case when the related cooling devices use also
> >> +         abstract scale to express their power usage. The scale must be
> >> +         consistent.
> >
> > Two thoughts:
> >
> > 1. If we're going to allow "sustainable-power" to be in abstract
> > scale, why not allow "dynamic-power-coefficient" to be in abstract
> > scale too?  I assume that the whole reason against that originally was
> > the idea of device tree purity, but if we're allowing the abstract
> > scale here then there seems no reason not to allow it for
> > "dynamic-power-coefficient".
>
> With this binding it's a bit more tricky.
> I also have to discuss a few things internally. This requirement of
> uW/MHz/V^2 makes the code easier also for potential drivers
> like GPU (which are going to register the devfreq cooling with EM).
>
> Let me think about it, but for now I would just update these bits.
> These are required to proper IPA operation, the dyn.-pow.-coef. is a
> nice to have and possible next step.

I guess the problem is that Rajendra is currently planning to remove
all the "dynamic-power-coefficient" values from device tree right now
and move them to the source code because the numbers we currently have
in the device tree _are_ in abstract scale and thus violate the
bindings.  Moving this to source code won't help us get to more real
power numbers (since it'll still be abstract scale), it'll just be
pure churn.  If we're OK with the abstract scale in general then we
should allow it everywhere and not add churn for no reason.


> > 2. Is it worth adding some type of indication of what type of units
> > "sustainable-power" is represented in?  Maybe even a made up unit so
> > that you could tell the difference between made up units in the same
> > system?  I'd envision something like:
> >
> > sustainable-power-units = "qualcomm,sc7180-bogoWatts"
> >
> > ...and on the dynamic-power-coefficient side, the same:
> >
> > dynamic-power-coefficient-units = "qualcomm,sc7180-bogoWatts"
> >
> > One could imagine someone even later (after devices are widely
> > distributed) figuring out translations between these bogoWatts numbers
> > and real Watts if someone could come up with a case where it matters.
>
> To figure this out we don't need a new binding.
> I think a simple comment in the DT would be enough for this, even e.g.:
>
> sustainable-power = <100> /* bogoWatts */

There are some important differences:

a) Your comment is gone when the device tree is compiled.  If we
actually add a string to the device tree then, in theory, we can add
conversions in code (without touching the device tree) down the road.

b) I believe there can be more than one abstract scale present in a
single device tree, at least in theory.  Adding a string allows you to
know if you're comparing apples to apples or apples to organges.


> Thank you for your comments.
> BTW, I haven't put your 'Reviewed-by' because I have added this
> sustainable-power new stuff in patch 1/3. I will grateful if you
> have a look on that.

I can if needed, but I'd kinda like to get the above resolved first
since it feels like it could have an effect on the other patches?


-Doug
