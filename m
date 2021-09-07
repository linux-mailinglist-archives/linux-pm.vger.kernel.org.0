Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527FE402DDE
	for <lists+linux-pm@lfdr.de>; Tue,  7 Sep 2021 19:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344968AbhIGRpV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Sep 2021 13:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344276AbhIGRpP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Sep 2021 13:45:15 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1E1C06175F
        for <linux-pm@vger.kernel.org>; Tue,  7 Sep 2021 10:44:07 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id c6so50608ybm.10
        for <linux-pm@vger.kernel.org>; Tue, 07 Sep 2021 10:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ir6VRLXobMhWRUlL2Bdt82tvy9gD2v1c+Zfp5JAK2WQ=;
        b=IR+l13tkXwNciXVxtNN+bOtx3FZd3xtGf7LCwMPGc/Q+88q4VEBFdmJOviIwodh1Ml
         fB9XwZJWBnPx51RvGxKLghufutNGIKFk0QtV0dQsDO61hPtYUFslccSKtFzp3sXsU/s6
         avk9/ZCyhJg0hOp58+G0yu0EPYLyGaxBhxAp2/DPovkp1XPMJUH4HPx+gnsFYnhGuoSr
         2FkxkZQqbKVkwEH+JdvaCosabo61nFeYQsOxpy1Ul7FOERpaDQIxvBOoCSIBc45A9t0j
         zsOcLzrLYdhV4PE+ZVJ/6ex0xe8rdne5n8w+tzYH8d6soJBbJs6Z7rPGXRNLJBkznNB2
         2ZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ir6VRLXobMhWRUlL2Bdt82tvy9gD2v1c+Zfp5JAK2WQ=;
        b=cqPHySKw24sBmyhsLy3GrB97raNPmTS3eqHSWCN3EjswTbf2qtA6IZ6xDRPReYTx6a
         /TvdPkRWzEdDnJzWbxtNxbLkkKWoOD2insGy7tlBktAvPYj4n573OfJ/UIt8tewOlIWZ
         fuKcu3zwn1Rf/XX+fRp2TAmZDHGYysDS+FKu5mG89hFn77umI6v9WQPswA5wobrCmSwm
         s4Q8OMg2PtkLLG8VYdrsI38q4EzYQBorvZbIoEVjtMK1K2inoCke+frR15DhvW16G3Fc
         cRqQwRd0w6/J3jfqaxm30gC5ahtqp3bRKWr7J/jK7fiGWMZu8kNq09ssJunsFXoxAAHo
         XgWA==
X-Gm-Message-State: AOAM530HAzp/RhZpNXCxI4dGlWOWJqFxGDMJU/U1kLhxAAqitOkKERa2
        qvOAZC1pFCisMIfRH+ErQ8s9/nWbDIh2FSWhoT5o9g==
X-Google-Smtp-Source: ABdhPJx6U+ZjGf7uvqQRmNt2BdAtEpwyw/pFjG0dNiOC9SPuLgeIjBzuTzL53vHwoCU+2K93JOYctI3hAZunWOS0qrI=
X-Received: by 2002:a5b:783:: with SMTP id b3mr23617994ybq.328.1631036646500;
 Tue, 07 Sep 2021 10:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210831102141.624725-1-ulf.hansson@linaro.org>
 <CAGETcx8FKnmeCh3dD1b2TYXf3gwHnW-iWwfz0q-9UzeP2VZSDw@mail.gmail.com>
 <CAPDyKFq7aD_VXyY6=Kvp3t2Ph1_+CheZWDA6j2AoPK6ExX4h0g@mail.gmail.com>
 <CAGETcx_NRWYYWxp77d+0LmpVT1F7X1sh3qoS1DuissfRyDWp=w@mail.gmail.com> <CAPDyKFotC5FBPkaTXHEqV_S=9RSsqBuM9U2YgUaSUk4vB0Kc2w@mail.gmail.com>
In-Reply-To: <CAPDyKFotC5FBPkaTXHEqV_S=9RSsqBuM9U2YgUaSUk4vB0Kc2w@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 7 Sep 2021 10:43:30 -0700
Message-ID: <CAGETcx86_f-exfLC+jF8SaRgV92wkOCjc-eBygOF5g39uN9G8Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] of: property: fw_devlink: Set 'optional_con_dev' for parse_power_domains
To:     Ulf Hansson <ulf.hansson@linaro.org>
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

On Tue, Sep 7, 2021 at 6:22 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 1 Sept 2021 at 23:49, Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Wed, Sep 1, 2021 at 1:13 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Tue, 31 Aug 2021 at 19:51, Saravana Kannan <saravanak@google.com> wrote:
> > > >
> > > > On Tue, Aug 31, 2021 at 3:21 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > >
> > > > > The power-domain DT bindings [1] doesn't enforce a compatible string for a
> > > > > provider node, even if this is common to use. In particular, when
> > > > > describing a hierarchy with parent/child power-domains, as the psci DT
> > > > > bindings [2] for example, it's sometimes not applicable to use a compatible
> > > > > string.
> > > >
> > > > Ok, and fw_devlink handles that -- provider not having a compatible
> > > > string is pretty common. In these cases, the parent node is the actual
> > > > device that gets probed and registers the provider. So fw_devlink will
> > > > create a link from the consumer to the parent device node.
> > >
> > > Yes, correct. That is working fine and isn't a problem.
> > >
> > > The first problem (I think) is that fw_devlink creates a fw_devlink
> > > from a child provider node (consumer without compatible string) to a
> > > parent node (supplier with a compatible string). I don't understand
> > > the reason why this is needed, perhaps you can elaborate on why?
> >
> > I really should get around to doing a LWN article on this and also
> > putting some of it into Documentation. Btw most of this info would be
> > in one of my earlier commit texts or in the code comments. But it's
> > still handy to have them all in one place I suppose.
> >
> > I'll try to answer all your questions with this example. Don't take
> > the actual properties too literally, they are just used to point out
> > dependencies.
> >
> > Device-A {
> >         compatible="foo";
> >
> >         Device-B {
> >                 compatible="flam";
> >                 power-domains = <&Device-C>;
> >         }
> > }
> >
> > Device-C {
> >         compatible="bar";
> >
> >         Device-D {
> >                 compatible="baz";
> >                 power-domains = <&Device-A>;
> >         }
> > }
> >
> > Legend:
> > I'll use X -> Y to indicate links where X is the consumer and Y is the supplier.
> > I'll call out the link types as fwnode or device links.
> > If I don't explicitly state otherwise, when I say device links, I mean
> > stateful/managed device link that is NOT sync-state-only device links.
> >
> > I think your first question is asking about fwnode link. So I'll answer that.
> >
> > fwnode links are created from the actual nodes that list the
> > dependencies. So in this case from device-B -> device-C and device-D
> > -> device-A. It needs to be done this way for a couple of reasons. But
> > to answer your question on "why do this when Device-B doesn't have a
> > compatible string?":
> >
> > 1. Not all devices have compatible strings (in an ideal world this
> > won't be the case). So Device-A would create a struct device for
> > Device-B, set the of_node/fwnode to point to Device-B DT node. Then
> > device-B gets probed, etc. In those cases, we want the device links to
> > be created between device-B -> device-C and NOT from device-A ->
> > device-C. Because if we did follow that logic, we'll get device-A ->
> > device-C and device-C -> device-A. This obviously can't work because
> > it's a cyclic dependency and fw_devlink will have to give up on these.
> >
> > 2. When device-C is added (assuming device-A is added already), we
> > need to create a sync-state-only device link from device-A to device-C
> > as a proxy for the future device-B -> device-C device link that'll
> > come up. This is to make sure device-C's sync_state() doesn't fire too
> > early. So the way fw_devlink can tell apart device-A's real dependency
> > (none in this case) vs device-B's dependency it's proxying for is by
> > the fact the fwnode link is from device-B DT -> device-C DT.
> >
> > Hope that makes sense.
>
> Yes, it does and I understand that it may become complicated in some
> cases. If you get the time to put together an LWN article about
> fw_devlinks, I would certainly read it. :-)
>
> However, at least for power-domains, the DT example you describe above
> is an invalid description of a HW. It doesn't make sense to try to
> support if for fw_devlink, at least in my opinion. Let me elaborate.
>
> So, I assume you have left out the #power-domain-cells property (for
> simplicity) for Device-A and Device-C, as those seem to be the
> power-domain providers.

Yes, but also because I don't want you to take these dependencies too
literally. I should have just used "depends-on =" as a standing in
fake property to make my point. And what "depends-on" maps to in each
DT node could be any one of the properties that point to a supplier.

The TLDR for this entire email is: You can't transfer the dependency
requirement of a child to its parent just because the child doesn't
have a "compatible" property (that's exactly what your patch was
doing). The incorrect creation of a cyclic dependency is one example
of why it's wrong.

> *) If Device-B is a consumer of Device-C, it also means that Device-A
> must be assigned as the child-power-domain to Device-C's power-domain.

This statement doesn't make any sense. If Device-B is the actual
consumer of device-C, why the heck should Device-A be assigned as the
child-power domain of device-C. Device-B should be assigned as the
child-power domain of device-C. Device-A could be on a completely
different power domain and not depend on Device-C for anything.

> **) If Device-D is the consumer of Device-A, it also means that
> Device-C must be assigned as the child-power-domain to Device-A's
> power-domain.

Similar comment here about device-D being the child power domain to
Device-A. Read further below about cycles.

> This simply can't be right from the HW point of view - and we don't
> support this in the Linux kernel anyway.

That's my point. By doing what you wanted to do, you are making
Device-A dependent on Device-C and Device-C dependent on Device-A.
Which makes no sense.

> A power-domain can not be
> both parent and child to another power-domain. In other words, cyclic
> dependencies can't exist for power-domains, as it would be a wrong
> description of the HW.

Real cyclic dependencies can't exist between any HW -- doesn't matter
if it's a power domain or not. That'd just be wrong.

> I wonder if the similar reasoning is applicable for other types of
> resources, like clocks and regulators, for example.

So the example I gave definitely happens between two PMIC in one of
the MSM chips. Forgot which one. If you follow what you suggested,
we'll end up with both the devices not probing because they are
waiting on each other to probe.

Also, to go back to my main point, don't focus too much on one
framework/property. In my example above, Device-D could be dependent
on Device-A for a clock and you'll hit the same problem.

>
> >
> > >
> > > I come to the second and follow up problem from this behaviour, see below.
> > >
> > > >
> > > > > Therefore, let's set the 'optional_con_dev' to true to avoid creating
> > > > > incorrect fw_devlinks for power-domains.
> > > >
> > > > This part doesn't make sense or is incomplete. What is being done incorrectly?
> > >
> > > See below.
> > >
> > > >
> > > > >
> > > > > [1] Documentation/devicetree/bindings/power/power-domain.yaml
> > > > > [2] Documentation/devicetree/bindings/arm/psci.yaml
> > > > >
> > > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > ---
> > > > >
> > > > > Some more details of what goes on here. I have added a debug print in
> > > > > of_link_to_phandle() to see the fw_devlinks that gets created.
> > > > >
> > > > > This is what happens on Dragonboard 410c when 'optional_con_dev' isn't set:
> > > > > ...
> > > > > [    0.041274] device: 'psci': device_add
> > > > > [    0.041366] OF: Linking power-domain-cpu0 (consumer) to psci (supplier)
> > > > > [    0.041395] OF: Linking power-domain-cpu1 (consumer) to psci (supplier)
> > > > > [    0.041423] OF: Linking power-domain-cpu2 (consumer) to psci (supplier)
> > > > > [    0.041451] OF: Linking power-domain-cpu3 (consumer) to psci (supplier)
> > > > > [    0.041494] device: 'platform:psci--platform:psci': device_add
> > > > > [    0.041556] platform psci: Linked as a sync state only consumer to psci
> > >
> > > Because we created a fw_devlink for the child provider nodes
> > > (consumer) that lacks compatible properties, we end up creating a sync
> > > state only devlink. I don't think it serves a purpose, but I may be
> > > wrong!?
> >
> > sync-state-only device links serve the purpose I explained in point 2 above.
> >
> > >
> > > Additionally, the actual devlink that is created, has the same
> > > supplier and consumer device, which indicates that this isn't the
> > > right thing to do.
> >
> > THIS is the part that's kinda wrong. But it doesn't really break
> > anything. It would also be very short lived as it would get deleted as
> > soon as the consumer (in this case the same as supplier) ends up
> > probing. But in your case the psci DT node doesn't use driver core for
> > probing because it could be an early boot dependency. In which case
> > you should really set the OF_POPULATED flag so a pointless struct
> > device isn't created for the DT node or at least set
> > FWNODE_FLAG_NOT_DEVICE so that fw_devlink knows not to wait on this
> > supplier. This is good practice for fw_devlink (not just to work
> > around the psci -> psci device link). Can you put up this patch
> > please?
> >
> > Also sync-state-only links are explicitly present to allow cyclic
> > dependencies (in the example above sync-state-only links will exist as
> > device-A -> device-C and device-C -> device-A), but it kinda pointless
> > to have a link where the supplier and the consumer are the same.
> >
> > With that said, if you want to avoid this short-lived pointless device
> > link, I'd say the fix should be in device_link_add() in the following
> > check:
> >
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -705,6 +705,7 @@ struct device_link *device_link_add(struct device *consumer,
> >          * because it only affects sync_state() callbacks.
> >          */
> >         if (!device_pm_initialized(supplier)
> > +           || consumer == supplier
> >             || (!(flags & DL_FLAG_SYNC_STATE_ONLY) &&
> >                   device_is_dependent(consumer, supplier))) {
> >                 link = NULL;
>
> This change seems like the right thing to do, no matter what. I will
> send a formal patch for it, thanks!

Thanks.

>
> >
> > >
> > > > > ...
> > > > >
> > > > > This is what happens on Dragonboard 410c when 'optional_con_dev' is set:
> > > > > ...
> > > > > [    0.041179] device: 'psci': device_add
> > > > > [    0.041265] OF: Not linking psci to psci - is descendant
> > > > > [    0.041293] OF: Not linking psci to psci - is descendant
> > > > > [    0.041319] OF: Not linking psci to psci - is descendant
> > > > > [    0.041346] OF: Not linking psci to psci - is descendant
> > > > > ...
> > > >
> > > > Can you please explain what exactly is going on that's wrong here? I
> > > > notice that psci is not probed as a device at all. And when you aren't
> > > > setting this flag the only difference I see is the creating of a sync
> > > > state only link -- which shouldn't matter here because you don't even
> > > > have a driver implemented.
> > >
> > > See above.
> > >
> > > >
> > > > > The relevant dtsi file:
> > > > > arch/arm64/boot/dts/qcom/msm8916.dtsi
> > > > >
> > > > > Kind regards
> > > > > Ulf Hansson
> > > > >
> > > > > ---
> > > > >  drivers/of/property.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > > > index 2babb1807228..4d607fdbea24 100644
> > > > > --- a/drivers/of/property.c
> > > > > +++ b/drivers/of/property.c
> > > > > @@ -1356,7 +1356,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
> > > > >         { .parse_prop = parse_io_channels, },
> > > > >         { .parse_prop = parse_interrupt_parent, },
> > > > >         { .parse_prop = parse_dmas, .optional = true, },
> > > > > -       { .parse_prop = parse_power_domains, },
> > > > > +       { .parse_prop = parse_power_domains, .optional_con_dev = true, },
> > > >
> > > > This change is just shooting in dark/completely unrelated to the
> > > > commit text. This is just saying the actual consumer is a level up
> > > > from where the property is listed (eg: remote-endpoint). It just
> > > > happens to fix your case for unrelated reasons.
> > >
> > > Again, see above.
> > >
> > > >
> > > > Definite Nak as this *will* break other cases.
> > >
> > > In what way will this break other cases?
> > >
> > > Would you mind elaborating for my understanding and perhaps point me
> > > to an example where it will break?
> >
> > So if you did this, it'll break:
> > (1) the probe of device-A/device-C due to cyclic dependencies. Really
> > no, because fw_devlink will just stop enforcing ordering between
> > device-A and device-C if it detects a cycle. But if there was a real
> > dependency (can me multiple links deep) between device-A -> device-C,
> > that would no longer get enforced.
>
> As I said above, cyclic dependencies don't exist for power-domains.

As I said above, *real* cyclic dependencies don't exist for anything.

> > (2) It'd break sync_state() correctness for device-B -> device-C dependency.
>
> I don't see that. Again, because power-domain providers can't be
> described in a cyclic way in DT.

I think I answered this above. Change one of the "power-domains"
property to clocks (or one of the many properties fw_devlink supports)
and you'll have the same issue I described.

> >
> > Hope that helps.
> >
>
> Perhaps, renaming the flag to "non-cyclic" would be an option? As it
> seems like that is what this boils done to, right?

No property is truly wanting to create a cycle. So if you were to
create such a flag, every property should set it. See my TLDR above.

>
> Thanks a lot for your reply and for taking the time to explain things!

My pleasure. The more people understand fw_devlink, the better.

-Saravana
