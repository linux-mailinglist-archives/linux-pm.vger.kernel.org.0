Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE75B45CD0F
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 20:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243231AbhKXTVL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 14:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243234AbhKXTVK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Nov 2021 14:21:10 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB85CC061574
        for <linux-pm@vger.kernel.org>; Wed, 24 Nov 2021 11:18:00 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id v15so7717896ljc.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Nov 2021 11:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zUqoK2ixD21E+D4hhBpBUrQmEqbpxmZoYHvCytX0cYY=;
        b=kZnmoNX3rRcJ4EMX/rtB0ZapeOvMiirq6qfNYFTgZ71QElfz/W+XGUpVGk7Ez6Yehi
         /3BZUPOsv4yscOJTu3fx/AtLqIIk6R0ulXCjMZdDH6VzA/5U7tPEug79+wQ+HShR1T6h
         2aBWdteIIVab8XEhCM0zKGeUc4kpbTXiA3NK46ErRfdUG2ggTsOqz6fGdWZI6LLhvVlB
         SOUwkl1xuIMzpkFbBnodoPpL0uIsFrJEIGurLRbSUZ+QyJAijsL4D0gSP6LgIUbTnR1/
         QiQmECdfdPBnmVpBMJfGPKKIxvVp8yCm3Mnmut2deYSE+vNiRleRvdMhOSudLTjohwFL
         RGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zUqoK2ixD21E+D4hhBpBUrQmEqbpxmZoYHvCytX0cYY=;
        b=nbrMdQpnGtZ557UMIu6AEGF5QFO7YvUdz0EcLbstcDDiht7pynaw8qcrtEB6W6JJvZ
         BgLYpR5G19LUQdHMjaNPXNNLmFSXh6mngl3M4BV2fwImRpClymT9nRD7Sc+odfVRzaJS
         KvaeY0k0IDve0IlCml1uy5akdzn1w20f90kvjzHlxuvDAQ2lYKqfTJFUpwY4IUHE+Fy5
         EKY+sNbjwoY5PplEknc3zw9PvCkSV0PIDQuqrPZUj92ch9DOk2qPHOfH03z7Cjxh6dmX
         /xR3UEWBpiTlP4a8thxi5PvYIob0AtYPPMkj65kzXdrAthHCjHLnuhtFF5CJUofVMHxQ
         DLXQ==
X-Gm-Message-State: AOAM531QMIPqxA5YRfLSnLdj4Mzm9WJquqv+E2a7cE2PTI4Y4RWQfRWs
        ZusiMyQqugj6o7GiI9KmWfl+PVCumPJ2oKF9Ih/iKA==
X-Google-Smtp-Source: ABdhPJy04wVilPDUWU7/CEEJbDm53QuY2yj3fXbaesD4ekIxse9qs8fdNe2qjREMrOII53Xxj6CkPWSksGBr0f4Duvo=
X-Received: by 2002:a05:651c:10b1:: with SMTP id k17mr18484863ljn.463.1637781478997;
 Wed, 24 Nov 2021 11:17:58 -0800 (PST)
MIME-Version: 1.0
References: <20211124125506.2971069-1-daniel.lezcano@linaro.org>
 <CAPDyKFpJHzAxGk=Y52VXcuVbAunwfMo2ErnwXMqnxzHPs6O30g@mail.gmail.com> <65873f24-46da-07f4-9661-e3f1001a4fa2@linaro.org>
In-Reply-To: <65873f24-46da-07f4-9661-e3f1001a4fa2@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 Nov 2021 20:17:22 +0100
Message-ID: <CAPDyKFpUG-gyt7_hF_jeuya6FWcKapKo=9MPXo0VzzBXnWOnNA@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: Powerzone new bindings
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     robh@kernel.org, arnd@linaro.org, heiko@sntech.de,
        rjw@rjwysocki.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 24 Nov 2021 at 17:26, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
>
> Hi Ulf,
>
> thanks for the review
>
> On 24/11/2021 15:54, Ulf Hansson wrote:
>
> [ ... ]
>
> >> +  This description is done via a hierarchy and the DT reflects it. It
> >> +  does not represent the physical location or a topology, eg. on a
> >> +  big.Little system, the little CPUs may not be represented as they do
> >> +  not contribute significantly to the heat, however the GPU can be
> >> +  tied with the big CPUs as they usually have a connection for
> >> +  multimedia or game workloads.
> >> +
> >> +properties:
> >> +  $nodename:
> >> +    const: powerzones
> >> +
> >
> > Do we really need a top-node like this? Can't that be left as a
> > platform/soc specific thing instead? Along the lines of how the last
> > example below looks like? Maybe we can have both options? I guess Rob
> > will tell us.
>
> Do you mean a compatible string?

Yes, but there is no need to specify that part of the powerzone
bindings, I think.

Although, let's see what Rob thinks here.

>
> > Moreover, maybe we should put some constraints on the names of
> > subnodes (provider nodes) with a "patternProperties". Something along
> > the lines of below.
> >
> > patternProperties:
> >   "^(powerzone)([@-].*)?$":
> >     type: object
> >     description:
> >       Each node represents a powerzone.
>
> Sure
>
> >> +  "#powerzone-cells":
> >> +    description:
> >> +      Number of cells in powerzone specifier. Typically 0 for nodes
> >> +      representing but it can be any number in the future to describe
> >> +      parameters of the powerzone.
> >> +
> >> +  powerzone:
> >
> > Maybe "powerzones" instead of "powerzone". Unless we believe that we
> > never need to allow multiple parent-zones for a child-zone.
>
> May be that could be needed in the future. No objection to rename it to
> 'powerzones'.
>
> >> +    description:
> >> +      A phandle to a parent powerzone. If no powerzone attribute is set, the
> >> +      described powerzone is the topmost in the hierarchy.
> >> +
> >
> > We should probably state that the "#powerzone-cells"  are required. Like below:
> >
> > required:
> >   - "#powerzone-cells"
>
> Ok
>
> > Moreover, we probably need to allow additional properties? At least it
> > looks so from the last example below. Then:
> >
> > additionalProperties: true
>
> I was unsure about adding it. With the actual description what would be
> the benefit ?

A powerzone provider node is then allowed to have other properties
too. Like a compatible string, for example.

Assuming I also have understood the additionalProperties thingy correctly. Rob?

>
> >> +examples:
> >> +  - |
> >> +    powerzones {
> >> +
> >> +      SOC_PZ: soc {
> >> +      };
> >
> > This looks odd to me.
> >
> > Why do we need an empty node? If this is the topmost power-zone,
>
> Yes it is
>
> > it
> > should still have the #powerzone-cells specifier, I think.
>
> Ok, makes sense
>
> >> +
> >> +      PKG_PZ: pkg {
> >
> > As I stated above, I would prefer some kind of common pattern of the
> > subnode names. Maybe "pkg-powerzone"?
>
> Ok, may be 'powerzone-pkg' to be consistent with the power-domains pattern?

Sure, that seems reasonable.

>
> >> +        #powerzone-cells = <0>;
> >> +        powerzone = <&SOC_PZ>;
> >> +      };
> >> +
> >> +      BIG_PZ: big {
> >> +        #powerzone-cells = <0>;
> >> +        powerzone = <&PKG_PZ>;
> >> +      };
> >> +
> >> +      GPU_PZ: gpu {
> >> +        #powerzone-cells = <0>;
> >> +        powerzone = <&PKG_PZ>;
> >> +      };
> >> +
> >> +      MULTIMEDIA_PZ: multimedia {
> >> +        #powerzone-cells = <0>;
> >> +        powerzone = <&SOC_PZ>;
> >> +      };
> >> +    };
> >> +
> >> +  - |
> >> +    A57_0: big@0 {
> >> +      compatible = "arm,cortex-a57";
> >> +      reg = <0x0 0x0>;
> >> +      device_type = "cpu";
> >> +      #powerzone-cells = <0>;
> >> +      powerzone = <&BIG_PZ>;
> >
> > Just to make sure I understand correctly. The big@0 node is a
> > powerzone provider too? Or did you mean to specify it as a consumer?
>
> I'm not sure 'provider' or 'consumer' make sense in this context.
>
> big@0 is a powerzone we can act on and its parent is the BIG_PZ powerzone.

I see.

Then it seems like we shouldn't have the toplevel "powerzones" node,
as it looks like a powerzone provider may very well be part of an
existing node.

>
> However this description is correct but confusing.
>
> Given big@0 and big@1 belong to the big 'cluster' and when we act on the
> performance state of big@0, big@1 is also changed, the correct
> description would be:
>
>     A57_0: big@0 {
>       compatible = "arm,cortex-a57";
>       reg = <0x0 0x0>;
>       device_type = "cpu";
>       #powerzone-cells = <0>;
>       powerzone = <&PKG_PZ>;
>     };
>
>     A57_1: big@1 {
>       compatible = "arm,cortex-a57";
>       reg = <0x0 0x0>;
>       device_type = "cpu";
>       #powerzone-cells = <0>;
>       powerzone = <&PKG_PZ>;
>     };
>
> If in the future, there will be a performance domain per core, then the
> former description above would make sense.

Okay, I see. Thanks for clarifying!

Kind regards
Uffe
