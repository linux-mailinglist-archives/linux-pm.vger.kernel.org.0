Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45370403809
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 12:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346277AbhIHKmh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 06:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345821AbhIHKmg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Sep 2021 06:42:36 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE8AC06175F
        for <linux-pm@vger.kernel.org>; Wed,  8 Sep 2021 03:41:28 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id i28so2702082ljm.7
        for <linux-pm@vger.kernel.org>; Wed, 08 Sep 2021 03:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bWOaXa5VhJBxFtZSpMo9+BEgvHHzq+TzkYPYrSPoYiU=;
        b=Dj5UuFzBz9AV5EgJFcwlmz7F6PGeWkQ7K3EW1W93EB5U0Lt00OMbIEpmmV6fSXg2kr
         Z9s8swQosFKZYuldi/iEnrzCWCrGgRtqCme6mdM4uAS1JFTVuoSJIcImM4rtMfu6wUyZ
         ZBj9rWEHuQPzGmFVzkWzBtOt0SaMmAMFZDqob863uzaLKOARVocexAzv/pu1RT88L8va
         /Re+++pxg5HQh1h/UTyGgGPXHfjaf4q8Tmorx+focFTs2jDYi5decCsUBIf4789CPiMw
         2cVZTaThllBuBeF72KUUHiVVh8srJPYfQyGOFLFu/XXM4h4CQ86vKOx9yOMIvq4d71uK
         P1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bWOaXa5VhJBxFtZSpMo9+BEgvHHzq+TzkYPYrSPoYiU=;
        b=Pe9t2IPs1pE42qMWoaOHcuLKpUPfjqXkGCSp63VLxBWJXUKy39SJ+rcldOqjVSkOOk
         Zd+LcQO82WvQAhQ3q5T1mV8P7bt3AOCuZ+lkw2x69Ck58124oayLhcGfRuc9hYXcJHit
         k0qGNSRK7CS+52G3FyAGlKr1laflig6+PGlDsiJ4YUVbHJ/KU4b1MdTnTdgmzyrBNJ6H
         eQm9fRrsx/lyz//V+CmgxV7q5l/KvsfpQhXGhObfNA5dcADCUdhtPRIxnMYodfuQcfQ1
         MGZsroyaazEtVB9r0yNtjQtrR884m2ipuXxSEeiFDvbNAxogLrULFizH125a14XvWeFs
         GoRg==
X-Gm-Message-State: AOAM5325AlcXUQUrd4rvJMDGsfTR7RaKlVhqD6vCECWElPLQD29aC9hF
        t/XW2MWj0B5hZ9xPIvFwsKfEaidNK3abc3UvK54PIw==
X-Google-Smtp-Source: ABdhPJxPYbIYf6dACCVmjxa6qwFLQoPNNC/oQpPWSBJVgU/ywrhWi4sq+Zxvm4mQfPP4xv8qdEReczTl44w9X1ABPBI=
X-Received: by 2002:a2e:960c:: with SMTP id v12mr2420457ljh.300.1631097686869;
 Wed, 08 Sep 2021 03:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210831102141.624725-1-ulf.hansson@linaro.org>
 <CAGETcx8FKnmeCh3dD1b2TYXf3gwHnW-iWwfz0q-9UzeP2VZSDw@mail.gmail.com>
 <CAPDyKFq7aD_VXyY6=Kvp3t2Ph1_+CheZWDA6j2AoPK6ExX4h0g@mail.gmail.com>
 <CAGETcx_NRWYYWxp77d+0LmpVT1F7X1sh3qoS1DuissfRyDWp=w@mail.gmail.com>
 <CAPDyKFotC5FBPkaTXHEqV_S=9RSsqBuM9U2YgUaSUk4vB0Kc2w@mail.gmail.com> <CAGETcx86_f-exfLC+jF8SaRgV92wkOCjc-eBygOF5g39uN9G8Q@mail.gmail.com>
In-Reply-To: <CAGETcx86_f-exfLC+jF8SaRgV92wkOCjc-eBygOF5g39uN9G8Q@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 8 Sep 2021 12:40:50 +0200
Message-ID: <CAPDyKFq8tOCj6PVB_92wTs_6XN7FZPKSxQqkXYqpU0LWHSFJQw@mail.gmail.com>
Subject: Re: [PATCH 2/2] of: property: fw_devlink: Set 'optional_con_dev' for parse_power_domains
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh@kernel.org>, DTML <devicetree@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

[...]

> > >
> > > Device-A {
> > >         compatible="foo";
> > >
> > >         Device-B {
> > >                 compatible="flam";
> > >                 power-domains = <&Device-C>;
> > >         }
> > > }
> > >
> > > Device-C {
> > >         compatible="bar";
> > >
> > >         Device-D {
> > >                 compatible="baz";
> > >                 power-domains = <&Device-A>;
> > >         }
> > > }
> > >
> > > Legend:
> > > I'll use X -> Y to indicate links where X is the consumer and Y is the supplier.
> > > I'll call out the link types as fwnode or device links.
> > > If I don't explicitly state otherwise, when I say device links, I mean
> > > stateful/managed device link that is NOT sync-state-only device links.
> > >
> > > I think your first question is asking about fwnode link. So I'll answer that.
> > >
> > > fwnode links are created from the actual nodes that list the
> > > dependencies. So in this case from device-B -> device-C and device-D
> > > -> device-A. It needs to be done this way for a couple of reasons. But
> > > to answer your question on "why do this when Device-B doesn't have a
> > > compatible string?":
> > >
> > > 1. Not all devices have compatible strings (in an ideal world this
> > > won't be the case). So Device-A would create a struct device for
> > > Device-B, set the of_node/fwnode to point to Device-B DT node. Then
> > > device-B gets probed, etc. In those cases, we want the device links to
> > > be created between device-B -> device-C and NOT from device-A ->
> > > device-C. Because if we did follow that logic, we'll get device-A ->
> > > device-C and device-C -> device-A. This obviously can't work because
> > > it's a cyclic dependency and fw_devlink will have to give up on these.
> > >
> > > 2. When device-C is added (assuming device-A is added already), we
> > > need to create a sync-state-only device link from device-A to device-C
> > > as a proxy for the future device-B -> device-C device link that'll
> > > come up. This is to make sure device-C's sync_state() doesn't fire too
> > > early. So the way fw_devlink can tell apart device-A's real dependency
> > > (none in this case) vs device-B's dependency it's proxying for is by
> > > the fact the fwnode link is from device-B DT -> device-C DT.
> > >
> > > Hope that makes sense.
> >
> > Yes, it does and I understand that it may become complicated in some
> > cases. If you get the time to put together an LWN article about
> > fw_devlinks, I would certainly read it. :-)
> >
> > However, at least for power-domains, the DT example you describe above
> > is an invalid description of a HW. It doesn't make sense to try to
> > support if for fw_devlink, at least in my opinion. Let me elaborate.
> >
> > So, I assume you have left out the #power-domain-cells property (for
> > simplicity) for Device-A and Device-C, as those seem to be the
> > power-domain providers.
>
> Yes, but also because I don't want you to take these dependencies too
> literally. I should have just used "depends-on =" as a standing in
> fake property to make my point. And what "depends-on" maps to in each
> DT node could be any one of the properties that point to a supplier.
>
> The TLDR for this entire email is: You can't transfer the dependency
> requirement of a child to its parent just because the child doesn't
> have a "compatible" property (that's exactly what your patch was
> doing). The incorrect creation of a cyclic dependency is one example
> of why it's wrong.
>
> > *) If Device-B is a consumer of Device-C, it also means that Device-A
> > must be assigned as the child-power-domain to Device-C's power-domain.
>
> This statement doesn't make any sense. If Device-B is the actual
> consumer of device-C, why the heck should Device-A be assigned as the
> child-power domain of device-C. Device-B should be assigned as the
> child-power domain of device-C. Device-A could be on a completely
> different power domain and not depend on Device-C for anything.
>
> > **) If Device-D is the consumer of Device-A, it also means that
> > Device-C must be assigned as the child-power-domain to Device-A's
> > power-domain.
>
> Similar comment here about device-D being the child power domain to
> Device-A. Read further below about cycles.

Well, I assumed the usual way of how we treat child nodes for power-domains.

In any case, the description is wrong from the HW point of view -
power-domains can't be described like that.

>
> > This simply can't be right from the HW point of view - and we don't
> > support this in the Linux kernel anyway.
>
> That's my point. By doing what you wanted to do, you are making
> Device-A dependent on Device-C and Device-C dependent on Device-A.
> Which makes no sense.

Exactly.

If that configuration exists in DT, why should we bother to support it
with fw_devlinks, it's broken anyway.

>
> > A power-domain can not be
> > both parent and child to another power-domain. In other words, cyclic
> > dependencies can't exist for power-domains, as it would be a wrong
> > description of the HW.
>
> Real cyclic dependencies can't exist between any HW -- doesn't matter
> if it's a power domain or not. That'd just be wrong.
>
> > I wonder if the similar reasoning is applicable for other types of
> > resources, like clocks and regulators, for example.
>
> So the example I gave definitely happens between two PMIC in one of
> the MSM chips. Forgot which one. If you follow what you suggested,
> we'll end up with both the devices not probing because they are
> waiting on each other to probe.
>
> Also, to go back to my main point, don't focus too much on one
> framework/property. In my example above, Device-D could be dependent
> on Device-A for a clock and you'll hit the same problem.

Well, again, that would not be a correct description of the HW, but I
get your point.

[...]

> > > >
> > > > Would you mind elaborating for my understanding and perhaps point me
> > > > to an example where it will break?
> > >
> > > So if you did this, it'll break:
> > > (1) the probe of device-A/device-C due to cyclic dependencies. Really
> > > no, because fw_devlink will just stop enforcing ordering between
> > > device-A and device-C if it detects a cycle. But if there was a real
> > > dependency (can me multiple links deep) between device-A -> device-C,
> > > that would no longer get enforced.
> >
> > As I said above, cyclic dependencies don't exist for power-domains.
>
> As I said above, *real* cyclic dependencies don't exist for anything.
>
> > > (2) It'd break sync_state() correctness for device-B -> device-C dependency.
> >
> > I don't see that. Again, because power-domain providers can't be
> > described in a cyclic way in DT.
>
> I think I answered this above. Change one of the "power-domains"
> property to clocks (or one of the many properties fw_devlink supports)
> and you'll have the same issue I described.
>
> > >
> > > Hope that helps.
> > >
> >
> > Perhaps, renaming the flag to "non-cyclic" would be an option? As it
> > seems like that is what this boils done to, right?
>
> No property is truly wanting to create a cycle. So if you were to
> create such a flag, every property should set it. See my TLDR above.

Well, I assume there are some valid cases where cyclic dependencies
are okay, like the "remote-endpoint" DT property, for example? No?

My point is, we are assuming there may be cyclic dependencies for all
the DT properties we parse for fw_devlink, while in fact those should
exist only for a few cases, right?

Doesn't the additional parsing and creation of links, to deal with
cyclic dependencies come with an overhead? If so - an option could be
to let it hurt only those properties that really need it.

[...]

Kind regards
Uffe
