Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1A0142B63
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2020 13:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgATM5R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jan 2020 07:57:17 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:33739 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgATM5R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jan 2020 07:57:17 -0500
Received: by mail-vk1-f193.google.com with SMTP id i78so8508499vke.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2020 04:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Erqm0aFOSa6psKmkMM6lnX3PdtaHFG7CqC73/ShnOgE=;
        b=oIvn2DaFOmDBRMU/LWWYMrlPpxBIyNalp5DZiF+C3uwh9Ku1Amip7DyNmcGok5hS2w
         RZfAk8F38RPTFw6DbdF8a6iylQK47J2jnPW+SP8tzP3nF0dLQtLAJLwKA3kFolXRPxrL
         z5y385aq1bSYG0R7iWMQv5OfVsyoFmdxrxaBMBb9Ry0F9PyUBFiF5cAU3WYFBLBy5K4C
         krpPkU9xkgoM5cEHyXzlE0JNxz9qKKsgGZlsjodImwaQMUgRLx5w2UiXgLS641LrXYgT
         sOHOajLGsC9kGXgNFyFxhBPOXpiVSdcVAM0UH0OcUcWZ4UBJOIhRw28gjWUtQz5coi8J
         8Xhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Erqm0aFOSa6psKmkMM6lnX3PdtaHFG7CqC73/ShnOgE=;
        b=ZdTODGOo9ZhYLRFSWCeM5mOzY8/6YxjhHyI1qBPcIQEM0HBXzHFi9+IX46yL+z/Jvy
         nxxrq8yDli7/ZYiLyAL/8FkFtV0tdxGUqkegjqJlWUMziMLGWrGBXpqhi+dbDdZ5+hLe
         6PaEKHaFmexFpOxMZ/rE9JO2A97W9vyfVm6jqQeZKznZ7k9N96RQRzgtCyS+1Uasd737
         6uqfGqOt68BATSjdgsBRieo6a/SGl/sjbrStPsKfWf8pDJfPijJIT1SGxCy1aNkyCc2p
         i8Glw1YElZ8fp/EJuk+HI+ubRHEBsHUr81WD+y1/XOnKjlKlaqOPxacE74DpXyP3KE2r
         onug==
X-Gm-Message-State: APjAAAWdVH8fEBzPUSZHw0c4NNCeszVzIfF0o9bv1f97mZ8ld3uG1n+3
        2pPcGzM7i61K/OyX3BLxYlUyV5XsYIL+m8WwfVXsHw==
X-Google-Smtp-Source: APXvYqzl429VNKmi90BhlVMLUv70+Dvovd6UjSP+sNzyPodBHttqWUX8SVBodhNRSQgG/UGM/kw+amRqAPDxjqXy58g=
X-Received: by 2002:a1f:4541:: with SMTP id s62mr763808vka.59.1579525035558;
 Mon, 20 Jan 2020 04:57:15 -0800 (PST)
MIME-Version: 1.0
References: <20191230144402.30195-1-ulf.hansson@linaro.org>
 <20191230144402.30195-3-ulf.hansson@linaro.org> <CAL_Jsq+cAKEGOMnBwwvLt03zx8Gcxh4ijziaBnnY5TPEG0Mekg@mail.gmail.com>
 <CAPDyKFr_7qmKjpWcFegVBsfKBJePtukuriwW-8KX6c2a24ojEA@mail.gmail.com>
 <CAL_JsqJN3UtM9T2D71j+2CORxWjL3s7cjkFX579p85WQuKgPNA@mail.gmail.com>
 <CAPDyKFq=0Y=79pFzxmnqA=oFbOVVJ9T2UthOie8ok5JTp7ucRw@mail.gmail.com> <CAL_Jsq+NvVC0Jjb_g0SDACG0Q-wTR+w-VHEq+wzsMLyXhcjX8g@mail.gmail.com>
In-Reply-To: <CAL_Jsq+NvVC0Jjb_g0SDACG0Q-wTR+w-VHEq+wzsMLyXhcjX8g@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 20 Jan 2020 13:56:39 +0100
Message-ID: <CAPDyKFp_rMvo==2NqV6L9V_Q0Dc8Qafc=1FNb=gGxsexM8MXwA@mail.gmail.com>
Subject: Re: [PATCH v5 02/15] dt: psci: Update DT bindings to support
 hierarchical PSCI states
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Lina Iyer <lina.iyer@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 17 Jan 2020 at 18:36, Rob Herring <robh+dt@kernel.org> wrote:
>
> On Fri, Jan 17, 2020 at 10:42 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Thu, 16 Jan 2020 at 19:19, Rob Herring <robh+dt@kernel.org> wrote:
> > >
> > > On Tue, Jan 14, 2020 at 11:55 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > On Mon, 13 Jan 2020 at 20:53, Rob Herring <robh+dt@kernel.org> wrote:
> > > > >
> > > > > On Mon, Dec 30, 2019 at 8:44 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > >
> > > > > > Update PSCI DT bindings to allow to represent idle states for CPUs and the
> > > > > > CPU topology, by using a hierarchical layout. Primarily this is done by
> > > > > > re-using the existing DT bindings for PM domains [1] and for PM domain idle
> > > > > > states [2].
> > > > > >
> > > > > > Let's also add an example into the document for the PSCI DT bindings, to
> > > > > > clearly show the new hierarchical based layout. The currently supported
> > > > > > flattened layout, is already described in the ARM idle states bindings [3],
> > > > > > so let's leave that as is.
> > > > > >
> > > > > > [1] Documentation/devicetree/bindings/power/power_domain.txt
> > > > > > [2] Documentation/devicetree/bindings/power/domain-idle-state.txt
> > > > > > [3] Documentation/devicetree/bindings/arm/idle-states.txt
> > > > > >
> > > > > > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > > > > > Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> > > > > > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > > > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > > ---
> > > > > >
> > > > > > Changes in v5:
> > > > > >         - None.
> > > > >
> > > > > First I'm seeing this as the DT list was not copied. The example has
> > > > > problems when running 'make dt_binding_check':
> > > > >
> > > > > Documentation/devicetree/bindings/arm/psci.example.dt.yaml: cpu@0:
> > > > > compatible: Additional items are not allowed ('arm,armv8' was
> > > > > unexpected)
> > > > > Documentation/devicetree/bindings/arm/psci.example.dt.yaml: cpu@0:
> > > > > compatible: ['arm,cortex-a53', 'arm,armv8'] is too long
> > > > > Documentation/devicetree/bindings/arm/psci.example.dt.yaml: cpu@1:
> > > > > compatible: Additional items are not allowed ('arm,armv8' was
> > > > > unexpected)
> > > > > Documentation/devicetree/bindings/arm/psci.example.dt.yaml: cpu@1:
> > > > > compatible: ['arm,cortex-a57', 'arm,armv8'] is too long
> > > > >
> > > > > 'arm,armv8' is only valid for s/w models.
> > > >
> > > > Perhaps you have a different version of the tools than I have (I have
> > > > tried both on v.5.5-rc5 and todays linux-next), because I can't
> > > > reproduce these errors at my side when running "make
> > > > dt_binding_check".
> > > >
> > > > Can you please check again?
> > >
> > > Are you setting DT_SCHEMA_FILES? If so, then arm/cpus.yaml (or any
> > > other schema) isn't loaded and used for validation. That schema is the
> > > source of this error.
> >
> > Yes. Aha, that's why then. Perhaps that needs to be clarified
> > somewhere in the documentation of tool.
>
> Patches welcome. :) I'm kind of tired of writing documentation that no
> one comments on and and seemingly only sometimes read. </rant> :(

I understand your concerns. A patch is on it's way.

>
> > Anyway, I used because it was kind of hard to process all the error
> > output one gets when building all yaml files at once.
>
> dtbs_check has a lot which is where setting DT_SCHEMA_FILES is
> primarily useful. dt_binding_check should be error/warning free, but
> yes linux-next and rc1/2 are frequently broken.
>
> > > It is failing in my CI job:
> > > https://gitlab.com/robherring/linux-dt-bindings/-/jobs/405298185
> > >
> > > Is dt-schema up to date? Though I can't think of any recent changes
> > > that would impact this. This check has been there a while and I fixed
> > > all the dts files.
> > >
> > > Do you see psci.example.dt.yaml getting built?
> >
> > Yes, but with using DT_SCHEMA_FILES.
> >
> > Anyway, now I can re-produced the errors, so then I should be able to
> > fix them. :-)
> >
> > >
> > > > > Documentation/devicetree/bindings/arm/psci.example.dt.yaml:
> > > > > idle-states: cluster-retention:compatible:0: 'arm,idle-state' was
> > > > > expected
> > > > > Documentation/devicetree/bindings/arm/psci.example.dt.yaml:
> > > > > idle-states: cluster-power-down:compatible:0: 'arm,idle-state' was
> > > > > expected
> > > > >
> > > > > The last 2 are due to my conversion of the idle-states binding which
> > > > > is in my tree now. Probably need to add 'domain-idle-state' as a
> > > > > compatible at a minimum. It looks like domain-idle-state.txt is pretty
> > > > > much the same as arm/idle-state.txt, so we should perhaps merge them.
> > > >
> > > > Ahh, so maybe *all* of the above problems are caused by conflicts in
> > > > the arm-soc tree with changes from your tree!?
> > >
> > > Shouldn't be. arm/cpus.yaml has been in place for a few cycles now.
> > >
> > > >
> > > > In regards to merging files, I am fine by that if that helps.
> > > >
> > > > >
> > > > > There's some bigger issues though.
> > > > >
> > > > > > ---
> > > > > >  .../devicetree/bindings/arm/cpus.yaml         |  15 +++
> > > > > >  .../devicetree/bindings/arm/psci.yaml         | 104 ++++++++++++++++++
> > > > > >  2 files changed, 119 insertions(+)
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
> > > > > > index c23c24ff7575..7a9c3ce2dbef 100644
> > > > > > --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> > > > > > @@ -242,6 +242,21 @@ properties:
> > > > > >
> > > > > >        where voltage is in V, frequency is in MHz.
> > > > > >
> > > > > > +  power-domains:
> > > > > > +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> > > > > > +    description:
> > > > > > +      List of phandles and PM domain specifiers, as defined by bindings of the
> > > > > > +      PM domain provider (see also ../power_domain.txt).
> > > > > > +
> > > > > > +  power-domain-names:
> > > > > > +    $ref: '/schemas/types.yaml#/definitions/string-array'
> > > > > > +    description:
> > > > > > +      A list of power domain name strings sorted in the same order as the
> > > > > > +      power-domains property.
> > > > > > +
> > > > > > +      For PSCI based platforms, the name corresponding to the index of the PSCI
> > > > > > +      PM domain provider, must be "psci".
> > > > > > +
> > > > > >    qcom,saw:
> > > > > >      $ref: '/schemas/types.yaml#/definitions/phandle'
> > > > > >      description: |
> > > > > > diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
> > > > > > index 7abdf58b335e..8ef85420b2ab 100644
> > > > > > --- a/Documentation/devicetree/bindings/arm/psci.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/arm/psci.yaml
> > > > > > @@ -102,6 +102,34 @@ properties:
> > > > > >        [1] Kernel documentation - ARM idle states bindings
> > > > > >          Documentation/devicetree/bindings/arm/idle-states.txt
> > > > > >
> > > > > > +  "#power-domain-cells":
> > > > >
> > > > > This is wrong because you are saying the /psci node should have these
> > > > > properties. You need to define the child nodes (at least a pattern you
> > > > > can match on) and put these properties there.
> > > >
> > > > Right, good point.
> > > >
> > > > I searched for some similar examples for how to encode this, but
> > > > couldn't really find something useful.
> > >
> > > You need something like:
> > >
> > > patternProperties:
> > >   '^(cluster|cpu)-pd[0-9a-f]+$':
> > >     type: object
> > >     properties:
> > >       ... and then the properties in the child nodes
> > >
> > > Note that its going to look weird for the 10th PD with 'cpu-pda'. So
> > > maybe add a '-'.
> > >
> >
> > Great, I try this! Thanks.
> >
> > > > One more thing, it seems like
> > > > this change is also needed for the common power-domain bindings, as
> > > > that also specifies parent/childs domains.
> > >
> > > Normally, we'd have a $ref to power-domain.yaml, but for that to work
> > > here, you'll have to expand the node names ($nodename).
> >
> > Not sure I get that, but interpret this as it's not a good idea to use
> > a $ref to power-domain.yaml. Right?
>
> It means either this binding is odd or power-domain.yaml needs some
> more work or both. Ideally, we only have 1 type definition of any
> property name.
>
> Probably the easiest thing to do is extend the node name pattern to
> something like this:
>
> pattern: "^(power-controller|power-domain)([@\-].*)?$"
>
> And then name your nodes like this:
>
> power-domain-cpu-0
> power-domain-cluster
>
> That's more consistent anyways.

Looks like a good idea! I try that.

>
> > > > Anyway, I would really appreciate if you can suggest something more
> > > > detailed for you think this should be done!?
> > > >
> > > > >
> > > > > > +    description:
> > > > > > +      The number of cells in a PM domain specifier as per binding in [3].
> > > > > > +      Must be 0 as to represent a single PM domain.
> > > > > > +
> > > > > > +      ARM systems can have multiple cores, sometimes in an hierarchical
> > > > > > +      arrangement. This often, but not always, maps directly to the processor
> > > > > > +      power topology of the system. Individual nodes in a topology have their
> > > > > > +      own specific power states and can be better represented hierarchically.
> > > > > > +
> > > > > > +      For these cases, the definitions of the idle states for the CPUs and the
> > > > > > +      CPU topology, must conform to the binding in [3]. The idle states
> > > > > > +      themselves must conform to the binding in [4] and must specify the
> > > > > > +      arm,psci-suspend-param property.
> > > > > > +
> > > > > > +      It should also be noted that, in PSCI firmware v1.0 the OS-Initiated
> > > > > > +      (OSI) CPU suspend mode is introduced. Using a hierarchical representation
> > > > > > +      helps to implement support for OSI mode and OS implementations may choose
> > > > > > +      to mandate it.
> > > > > > +
> > > > > > +      [3] Documentation/devicetree/bindings/power/power_domain.txt
> > > > > > +      [4] Documentation/devicetree/bindings/power/domain-idle-state.txt
> > > > > > +
> > > > > > +  power-domains:
> > > > > > +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> > > > > > +    description:
> > > > > > +      List of phandles and PM domain specifiers, as defined by bindings of the
> > > > > > +      PM domain provider.
> > > > >
> > > > > A schema for 'domain-idle-states' property is missing.
> > > >
> > > > Right, let's figure out the best way for how to add that.
> > >
> > > If power-domain.yaml is referenced, then don't need anything else
> > > unless you can define the number of phandles (looks like you can't?).
> >
> > The number phandles should be one. At least, I think we can start with
> > that and extend the binding if needed.
>
> But there's 2 for the cluster in the example.

What example do you refer to?

For each power controller node for psci, only one phandle needs to be
specified in "power-domains", as that should be sufficient to describe
the topology.

When it comes to the CPU node, multiple phandles may need to specified
in "power-domains".

>
> > How would that look like then? Apologize for my ignorance (I really
> > need to spend some time learning this better)...
>
> Basically, anything common that can be an multiple entries is defined as:
>
> power-domains:
>   maxItems: 1
>
> if only 1 entry or for multiple you need to define each entry:
>
> power-domains:
>   items:
>     - description: what the first power domain is
>     - description: what the 2nd power domain is

Okay.

This should be fine for the PSCI power controller node, but for the
generic binding in cpus.yaml I am not sure how to describe this as
that would be SoC specific.

The number of phandles in power-domains could differ between SoCs at
CPU node. However, at most, one would be a phandle for PSCI. If
additional those would be for something different.

Kind regards
Uffe
