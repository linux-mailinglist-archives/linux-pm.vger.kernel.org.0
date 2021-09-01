Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4723FE515
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 23:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbhIAVuk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 17:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbhIAVuh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 17:50:37 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60FDC061575
        for <linux-pm@vger.kernel.org>; Wed,  1 Sep 2021 14:49:39 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id k65so1434351yba.13
        for <linux-pm@vger.kernel.org>; Wed, 01 Sep 2021 14:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=92JcOljfG9tp+5/f79WgwgblDGP26ce1bey6TcLE1Aw=;
        b=conzBVg4ndsHcFclJFFlwZQ1kEJ6nAR5gRcGtjulgvW/zqTtMi2GH+ksSNUum9FCGe
         dGJIDno1qiKcspl5MjB6zrH0agJfLUjdRkCZnvIqHBAroRBm4v+8UERbZHHYSdFL7xVy
         m3Znwc4MF8PyZBpaMqBKWUbOeamwq4gJyXuWfy7WkB5VsypzW/XFpU2n83uVrmFQlVD7
         bqgjrPuzYKwtE4FCWBdr3PhziTHExs9hZSejAyWtOvD0xJLHy9WKvi3zYytr4khHLZeh
         zqQBfma2FfEFfuLkOnniCpBPRQ1gdqB2BJES32f+OonJYoRevz2Lmzobl2nsKoc7lPTL
         o15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=92JcOljfG9tp+5/f79WgwgblDGP26ce1bey6TcLE1Aw=;
        b=QUEOEpIFt6fs59G4G+g8tWaMpKDbDwDfpbKG/A8Ms53foJfNcmXMbEi4K8MkM6Teza
         QPv8r3gVpxVkcTFpl4cZj2BYqZwsyOSsdvbgWzVIyuni9YNb2v8QFEbAlcOCk/IhQJ14
         H48RxyS9mTlJPoOklW1SgCtetr+Wunc3FonDXwzDNQyiEBnUOFbFlnjEcZaRofI8pubq
         rXv196RGfz0jWCn07fhQ+u/5WHEYhrNjtwAXLU+jpqYXOh5ozUdBgKITyVpVpWNwW8J2
         MzO3isokBJXfInzW03kgHUyc30cwVETZqv4Ygt8yvb3Hg5NmJFryUvESu4dfkiSNxa5r
         WKgg==
X-Gm-Message-State: AOAM533f9gBYGEOy72vNnYVAUXH8exm34PTy4GzSQYD7NodaBTxQMRcX
        7hRQh3teEYDpjCv1N+dxrSGUpk6GbCIiJbU2VZmb8w==
X-Google-Smtp-Source: ABdhPJwO+mdlyMCrYGnVuqhpI197erbMYuRHtQk26FgPb7/4palf+626mTc2JKtsnOsbqxEf/eFbtfYSv/X1xNRWing=
X-Received: by 2002:a25:9c01:: with SMTP id c1mr73330ybo.228.1630532978920;
 Wed, 01 Sep 2021 14:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210831102141.624725-1-ulf.hansson@linaro.org>
 <CAGETcx8FKnmeCh3dD1b2TYXf3gwHnW-iWwfz0q-9UzeP2VZSDw@mail.gmail.com> <CAPDyKFq7aD_VXyY6=Kvp3t2Ph1_+CheZWDA6j2AoPK6ExX4h0g@mail.gmail.com>
In-Reply-To: <CAPDyKFq7aD_VXyY6=Kvp3t2Ph1_+CheZWDA6j2AoPK6ExX4h0g@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 1 Sep 2021 14:49:03 -0700
Message-ID: <CAGETcx_NRWYYWxp77d+0LmpVT1F7X1sh3qoS1DuissfRyDWp=w@mail.gmail.com>
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

On Wed, Sep 1, 2021 at 1:13 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 31 Aug 2021 at 19:51, Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Tue, Aug 31, 2021 at 3:21 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > The power-domain DT bindings [1] doesn't enforce a compatible string for a
> > > provider node, even if this is common to use. In particular, when
> > > describing a hierarchy with parent/child power-domains, as the psci DT
> > > bindings [2] for example, it's sometimes not applicable to use a compatible
> > > string.
> >
> > Ok, and fw_devlink handles that -- provider not having a compatible
> > string is pretty common. In these cases, the parent node is the actual
> > device that gets probed and registers the provider. So fw_devlink will
> > create a link from the consumer to the parent device node.
>
> Yes, correct. That is working fine and isn't a problem.
>
> The first problem (I think) is that fw_devlink creates a fw_devlink
> from a child provider node (consumer without compatible string) to a
> parent node (supplier with a compatible string). I don't understand
> the reason why this is needed, perhaps you can elaborate on why?

I really should get around to doing a LWN article on this and also
putting some of it into Documentation. Btw most of this info would be
in one of my earlier commit texts or in the code comments. But it's
still handy to have them all in one place I suppose.

I'll try to answer all your questions with this example. Don't take
the actual properties too literally, they are just used to point out
dependencies.

Device-A {
        compatible="foo";

        Device-B {
                compatible="flam";
                power-domains = <&Device-C>;
        }
}

Device-C {
        compatible="bar";

        Device-D {
                compatible="baz";
                power-domains = <&Device-A>;
        }
}

Legend:
I'll use X -> Y to indicate links where X is the consumer and Y is the supplier.
I'll call out the link types as fwnode or device links.
If I don't explicitly state otherwise, when I say device links, I mean
stateful/managed device link that is NOT sync-state-only device links.

I think your first question is asking about fwnode link. So I'll answer that.

fwnode links are created from the actual nodes that list the
dependencies. So in this case from device-B -> device-C and device-D
-> device-A. It needs to be done this way for a couple of reasons. But
to answer your question on "why do this when Device-B doesn't have a
compatible string?":

1. Not all devices have compatible strings (in an ideal world this
won't be the case). So Device-A would create a struct device for
Device-B, set the of_node/fwnode to point to Device-B DT node. Then
device-B gets probed, etc. In those cases, we want the device links to
be created between device-B -> device-C and NOT from device-A ->
device-C. Because if we did follow that logic, we'll get device-A ->
device-C and device-C -> device-A. This obviously can't work because
it's a cyclic dependency and fw_devlink will have to give up on these.

2. When device-C is added (assuming device-A is added already), we
need to create a sync-state-only device link from device-A to device-C
as a proxy for the future device-B -> device-C device link that'll
come up. This is to make sure device-C's sync_state() doesn't fire too
early. So the way fw_devlink can tell apart device-A's real dependency
(none in this case) vs device-B's dependency it's proxying for is by
the fact the fwnode link is from device-B DT -> device-C DT.

Hope that makes sense.

>
> I come to the second and follow up problem from this behaviour, see below.
>
> >
> > > Therefore, let's set the 'optional_con_dev' to true to avoid creating
> > > incorrect fw_devlinks for power-domains.
> >
> > This part doesn't make sense or is incomplete. What is being done incorrectly?
>
> See below.
>
> >
> > >
> > > [1] Documentation/devicetree/bindings/power/power-domain.yaml
> > > [2] Documentation/devicetree/bindings/arm/psci.yaml
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >
> > > Some more details of what goes on here. I have added a debug print in
> > > of_link_to_phandle() to see the fw_devlinks that gets created.
> > >
> > > This is what happens on Dragonboard 410c when 'optional_con_dev' isn't set:
> > > ...
> > > [    0.041274] device: 'psci': device_add
> > > [    0.041366] OF: Linking power-domain-cpu0 (consumer) to psci (supplier)
> > > [    0.041395] OF: Linking power-domain-cpu1 (consumer) to psci (supplier)
> > > [    0.041423] OF: Linking power-domain-cpu2 (consumer) to psci (supplier)
> > > [    0.041451] OF: Linking power-domain-cpu3 (consumer) to psci (supplier)
> > > [    0.041494] device: 'platform:psci--platform:psci': device_add
> > > [    0.041556] platform psci: Linked as a sync state only consumer to psci
>
> Because we created a fw_devlink for the child provider nodes
> (consumer) that lacks compatible properties, we end up creating a sync
> state only devlink. I don't think it serves a purpose, but I may be
> wrong!?

sync-state-only device links serve the purpose I explained in point 2 above.

>
> Additionally, the actual devlink that is created, has the same
> supplier and consumer device, which indicates that this isn't the
> right thing to do.

THIS is the part that's kinda wrong. But it doesn't really break
anything. It would also be very short lived as it would get deleted as
soon as the consumer (in this case the same as supplier) ends up
probing. But in your case the psci DT node doesn't use driver core for
probing because it could be an early boot dependency. In which case
you should really set the OF_POPULATED flag so a pointless struct
device isn't created for the DT node or at least set
FWNODE_FLAG_NOT_DEVICE so that fw_devlink knows not to wait on this
supplier. This is good practice for fw_devlink (not just to work
around the psci -> psci device link). Can you put up this patch
please?

Also sync-state-only links are explicitly present to allow cyclic
dependencies (in the example above sync-state-only links will exist as
device-A -> device-C and device-C -> device-A), but it kinda pointless
to have a link where the supplier and the consumer are the same.

With that said, if you want to avoid this short-lived pointless device
link, I'd say the fix should be in device_link_add() in the following
check:

--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -705,6 +705,7 @@ struct device_link *device_link_add(struct device *consumer,
         * because it only affects sync_state() callbacks.
         */
        if (!device_pm_initialized(supplier)
+           || consumer == supplier
            || (!(flags & DL_FLAG_SYNC_STATE_ONLY) &&
                  device_is_dependent(consumer, supplier))) {
                link = NULL;

>
> > > ...
> > >
> > > This is what happens on Dragonboard 410c when 'optional_con_dev' is set:
> > > ...
> > > [    0.041179] device: 'psci': device_add
> > > [    0.041265] OF: Not linking psci to psci - is descendant
> > > [    0.041293] OF: Not linking psci to psci - is descendant
> > > [    0.041319] OF: Not linking psci to psci - is descendant
> > > [    0.041346] OF: Not linking psci to psci - is descendant
> > > ...
> >
> > Can you please explain what exactly is going on that's wrong here? I
> > notice that psci is not probed as a device at all. And when you aren't
> > setting this flag the only difference I see is the creating of a sync
> > state only link -- which shouldn't matter here because you don't even
> > have a driver implemented.
>
> See above.
>
> >
> > > The relevant dtsi file:
> > > arch/arm64/boot/dts/qcom/msm8916.dtsi
> > >
> > > Kind regards
> > > Ulf Hansson
> > >
> > > ---
> > >  drivers/of/property.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > index 2babb1807228..4d607fdbea24 100644
> > > --- a/drivers/of/property.c
> > > +++ b/drivers/of/property.c
> > > @@ -1356,7 +1356,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
> > >         { .parse_prop = parse_io_channels, },
> > >         { .parse_prop = parse_interrupt_parent, },
> > >         { .parse_prop = parse_dmas, .optional = true, },
> > > -       { .parse_prop = parse_power_domains, },
> > > +       { .parse_prop = parse_power_domains, .optional_con_dev = true, },
> >
> > This change is just shooting in dark/completely unrelated to the
> > commit text. This is just saying the actual consumer is a level up
> > from where the property is listed (eg: remote-endpoint). It just
> > happens to fix your case for unrelated reasons.
>
> Again, see above.
>
> >
> > Definite Nak as this *will* break other cases.
>
> In what way will this break other cases?
>
> Would you mind elaborating for my understanding and perhaps point me
> to an example where it will break?

So if you did this, it'll break:
(1) the probe of device-A/device-C due to cyclic dependencies. Really
no, because fw_devlink will just stop enforcing ordering between
device-A and device-C if it detects a cycle. But if there was a real
dependency (can me multiple links deep) between device-A -> device-C,
that would no longer get enforced.
(2) It'd break sync_state() correctness for device-B -> device-C dependency.

Hope that helps.

-Saravana
