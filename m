Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0D87140F2B
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 17:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgAQQm3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jan 2020 11:42:29 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:46822 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgAQQm3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jan 2020 11:42:29 -0500
Received: by mail-ua1-f67.google.com with SMTP id l6so9152409uap.13
        for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2020 08:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nKC6eUY5vTsOPMymTUquWAicdz+g94OsTEZKAbYXx0I=;
        b=V8WsHLjcgHloIV2lkLUy3cEIChnOKCPz3HD9YygB5nd2CHTKetcsKXB/asLhKmWXvJ
         8VJSO+lFg1nXbm9D2fjVX5UFMj11yOB/f35l3MiTVIaNMJ/CmIAszK6eHgAfEPtbTlak
         zIXQzQNH+aVnw64cYLkm2PcHB+sevjXq46lgdzpG4cGLXPdPCzP3T/D5oUU30Cx0aslm
         6M5V/+RxEEe7pyMj/ERqPjM6xiyMyIZzhrrvO8CiCK9d7l4rB7eDcT0UrScJrB9j/JO/
         99hGCnkz/jShZgSn0vlSQ+48BUPROxOaG5iOH8I5EmcpzdP/9ChfIp6NCHPjUI9/6KXM
         IJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nKC6eUY5vTsOPMymTUquWAicdz+g94OsTEZKAbYXx0I=;
        b=Z0YYzWTe4r4pE+vULi1K7aqIS5cSRFvilQoF/93OJ72JDCQL/v+uP0BLn/fHR8wtc6
         3Xvz7XqjE8ahkClTknhwv3pAMRV11WUClZlPjoef7MRYL7lJnEIRLj2MvUvF/6195F6I
         U16u9lod3oVfD6R1pmNK0OVi6tjdHg+2SYK099nOwLNQeherW57WfwniZ87oaM67mtOv
         b9smjECQq1DwFX+R61G+ywdU5z+IozEtfFsGil41DUhiYyXWJa1VGTAkk+4OlBRfF6hW
         36elZw9BmZKXfakSQ/zJKJ+795T0goQOW5BnBVTsku6cAEazR9FDAhvDOO5W02LfNCRy
         /0Lg==
X-Gm-Message-State: APjAAAXgWmtltDxUc3nl9nzQtnx6hodUrLQPirRSXyr56B9m6RgcvPsV
        Is8rT3BRXuiZbF13k623y1mzqm412hwecxX7F4gMjA==
X-Google-Smtp-Source: APXvYqwKrcfodg/4KBzUb0CthN1YcVOLdI/vp7cy9hnS7t23Hd3gfVTXSrxIzQ+aD90+I6xuKoqaz9RR8hf7AAR6lmA=
X-Received: by 2002:ab0:20a:: with SMTP id 10mr21375446uas.19.1579279347346;
 Fri, 17 Jan 2020 08:42:27 -0800 (PST)
MIME-Version: 1.0
References: <20191230144402.30195-1-ulf.hansson@linaro.org>
 <20191230144402.30195-3-ulf.hansson@linaro.org> <CAL_Jsq+cAKEGOMnBwwvLt03zx8Gcxh4ijziaBnnY5TPEG0Mekg@mail.gmail.com>
 <CAPDyKFr_7qmKjpWcFegVBsfKBJePtukuriwW-8KX6c2a24ojEA@mail.gmail.com> <CAL_JsqJN3UtM9T2D71j+2CORxWjL3s7cjkFX579p85WQuKgPNA@mail.gmail.com>
In-Reply-To: <CAL_JsqJN3UtM9T2D71j+2CORxWjL3s7cjkFX579p85WQuKgPNA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 17 Jan 2020 17:41:50 +0100
Message-ID: <CAPDyKFq=0Y=79pFzxmnqA=oFbOVVJ9T2UthOie8ok5JTp7ucRw@mail.gmail.com>
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

On Thu, 16 Jan 2020 at 19:19, Rob Herring <robh+dt@kernel.org> wrote:
>
> On Tue, Jan 14, 2020 at 11:55 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Mon, 13 Jan 2020 at 20:53, Rob Herring <robh+dt@kernel.org> wrote:
> > >
> > > On Mon, Dec 30, 2019 at 8:44 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > Update PSCI DT bindings to allow to represent idle states for CPUs and the
> > > > CPU topology, by using a hierarchical layout. Primarily this is done by
> > > > re-using the existing DT bindings for PM domains [1] and for PM domain idle
> > > > states [2].
> > > >
> > > > Let's also add an example into the document for the PSCI DT bindings, to
> > > > clearly show the new hierarchical based layout. The currently supported
> > > > flattened layout, is already described in the ARM idle states bindings [3],
> > > > so let's leave that as is.
> > > >
> > > > [1] Documentation/devicetree/bindings/power/power_domain.txt
> > > > [2] Documentation/devicetree/bindings/power/domain-idle-state.txt
> > > > [3] Documentation/devicetree/bindings/arm/idle-states.txt
> > > >
> > > > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > > > Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> > > > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > ---
> > > >
> > > > Changes in v5:
> > > >         - None.
> > >
> > > First I'm seeing this as the DT list was not copied. The example has
> > > problems when running 'make dt_binding_check':
> > >
> > > Documentation/devicetree/bindings/arm/psci.example.dt.yaml: cpu@0:
> > > compatible: Additional items are not allowed ('arm,armv8' was
> > > unexpected)
> > > Documentation/devicetree/bindings/arm/psci.example.dt.yaml: cpu@0:
> > > compatible: ['arm,cortex-a53', 'arm,armv8'] is too long
> > > Documentation/devicetree/bindings/arm/psci.example.dt.yaml: cpu@1:
> > > compatible: Additional items are not allowed ('arm,armv8' was
> > > unexpected)
> > > Documentation/devicetree/bindings/arm/psci.example.dt.yaml: cpu@1:
> > > compatible: ['arm,cortex-a57', 'arm,armv8'] is too long
> > >
> > > 'arm,armv8' is only valid for s/w models.
> >
> > Perhaps you have a different version of the tools than I have (I have
> > tried both on v.5.5-rc5 and todays linux-next), because I can't
> > reproduce these errors at my side when running "make
> > dt_binding_check".
> >
> > Can you please check again?
>
> Are you setting DT_SCHEMA_FILES? If so, then arm/cpus.yaml (or any
> other schema) isn't loaded and used for validation. That schema is the
> source of this error.

Yes. Aha, that's why then. Perhaps that needs to be clarified
somewhere in the documentation of tool.

Anyway, I used because it was kind of hard to process all the error
output one gets when building all yaml files at once.

>
> It is failing in my CI job:
> https://gitlab.com/robherring/linux-dt-bindings/-/jobs/405298185
>
> Is dt-schema up to date? Though I can't think of any recent changes
> that would impact this. This check has been there a while and I fixed
> all the dts files.
>
> Do you see psci.example.dt.yaml getting built?

Yes, but with using DT_SCHEMA_FILES.

Anyway, now I can re-produced the errors, so then I should be able to
fix them. :-)

>
> > > Documentation/devicetree/bindings/arm/psci.example.dt.yaml:
> > > idle-states: cluster-retention:compatible:0: 'arm,idle-state' was
> > > expected
> > > Documentation/devicetree/bindings/arm/psci.example.dt.yaml:
> > > idle-states: cluster-power-down:compatible:0: 'arm,idle-state' was
> > > expected
> > >
> > > The last 2 are due to my conversion of the idle-states binding which
> > > is in my tree now. Probably need to add 'domain-idle-state' as a
> > > compatible at a minimum. It looks like domain-idle-state.txt is pretty
> > > much the same as arm/idle-state.txt, so we should perhaps merge them.
> >
> > Ahh, so maybe *all* of the above problems are caused by conflicts in
> > the arm-soc tree with changes from your tree!?
>
> Shouldn't be. arm/cpus.yaml has been in place for a few cycles now.
>
> >
> > In regards to merging files, I am fine by that if that helps.
> >
> > >
> > > There's some bigger issues though.
> > >
> > > > ---
> > > >  .../devicetree/bindings/arm/cpus.yaml         |  15 +++
> > > >  .../devicetree/bindings/arm/psci.yaml         | 104 ++++++++++++++++++
> > > >  2 files changed, 119 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
> > > > index c23c24ff7575..7a9c3ce2dbef 100644
> > > > --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> > > > +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> > > > @@ -242,6 +242,21 @@ properties:
> > > >
> > > >        where voltage is in V, frequency is in MHz.
> > > >
> > > > +  power-domains:
> > > > +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> > > > +    description:
> > > > +      List of phandles and PM domain specifiers, as defined by bindings of the
> > > > +      PM domain provider (see also ../power_domain.txt).
> > > > +
> > > > +  power-domain-names:
> > > > +    $ref: '/schemas/types.yaml#/definitions/string-array'
> > > > +    description:
> > > > +      A list of power domain name strings sorted in the same order as the
> > > > +      power-domains property.
> > > > +
> > > > +      For PSCI based platforms, the name corresponding to the index of the PSCI
> > > > +      PM domain provider, must be "psci".
> > > > +
> > > >    qcom,saw:
> > > >      $ref: '/schemas/types.yaml#/definitions/phandle'
> > > >      description: |
> > > > diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
> > > > index 7abdf58b335e..8ef85420b2ab 100644
> > > > --- a/Documentation/devicetree/bindings/arm/psci.yaml
> > > > +++ b/Documentation/devicetree/bindings/arm/psci.yaml
> > > > @@ -102,6 +102,34 @@ properties:
> > > >        [1] Kernel documentation - ARM idle states bindings
> > > >          Documentation/devicetree/bindings/arm/idle-states.txt
> > > >
> > > > +  "#power-domain-cells":
> > >
> > > This is wrong because you are saying the /psci node should have these
> > > properties. You need to define the child nodes (at least a pattern you
> > > can match on) and put these properties there.
> >
> > Right, good point.
> >
> > I searched for some similar examples for how to encode this, but
> > couldn't really find something useful.
>
> You need something like:
>
> patternProperties:
>   '^(cluster|cpu)-pd[0-9a-f]+$':
>     type: object
>     properties:
>       ... and then the properties in the child nodes
>
> Note that its going to look weird for the 10th PD with 'cpu-pda'. So
> maybe add a '-'.
>

Great, I try this! Thanks.

> > One more thing, it seems like
> > this change is also needed for the common power-domain bindings, as
> > that also specifies parent/childs domains.
>
> Normally, we'd have a $ref to power-domain.yaml, but for that to work
> here, you'll have to expand the node names ($nodename).

Not sure I get that, but interpret this as it's not a good idea to use
a $ref to power-domain.yaml. Right?

>
> >
> > Anyway, I would really appreciate if you can suggest something more
> > detailed for you think this should be done!?
> >
> > >
> > > > +    description:
> > > > +      The number of cells in a PM domain specifier as per binding in [3].
> > > > +      Must be 0 as to represent a single PM domain.
> > > > +
> > > > +      ARM systems can have multiple cores, sometimes in an hierarchical
> > > > +      arrangement. This often, but not always, maps directly to the processor
> > > > +      power topology of the system. Individual nodes in a topology have their
> > > > +      own specific power states and can be better represented hierarchically.
> > > > +
> > > > +      For these cases, the definitions of the idle states for the CPUs and the
> > > > +      CPU topology, must conform to the binding in [3]. The idle states
> > > > +      themselves must conform to the binding in [4] and must specify the
> > > > +      arm,psci-suspend-param property.
> > > > +
> > > > +      It should also be noted that, in PSCI firmware v1.0 the OS-Initiated
> > > > +      (OSI) CPU suspend mode is introduced. Using a hierarchical representation
> > > > +      helps to implement support for OSI mode and OS implementations may choose
> > > > +      to mandate it.
> > > > +
> > > > +      [3] Documentation/devicetree/bindings/power/power_domain.txt
> > > > +      [4] Documentation/devicetree/bindings/power/domain-idle-state.txt
> > > > +
> > > > +  power-domains:
> > > > +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> > > > +    description:
> > > > +      List of phandles and PM domain specifiers, as defined by bindings of the
> > > > +      PM domain provider.
> > >
> > > A schema for 'domain-idle-states' property is missing.
> >
> > Right, let's figure out the best way for how to add that.
>
> If power-domain.yaml is referenced, then don't need anything else
> unless you can define the number of phandles (looks like you can't?).

The number phandles should be one. At least, I think we can start with
that and extend the binding if needed.

How would that look like then? Apologize for my ignorance (I really
need to spend some time learning this better)...

Kind regards
Uffe
