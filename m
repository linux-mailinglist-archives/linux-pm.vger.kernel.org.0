Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0106428F349
	for <lists+linux-pm@lfdr.de>; Thu, 15 Oct 2020 15:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387534AbgJONdt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Oct 2020 09:33:49 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:36717 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbgJONds (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2020 09:33:48 -0400
Received: by mail-oo1-f66.google.com with SMTP id z1so716652ooj.3;
        Thu, 15 Oct 2020 06:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MtEg+rr20vQ/R5/UQ+HF4u9WrsNxMXTvc1d4Zer96zg=;
        b=mJFZaAXoEf6K8y/VxJoREPL7H9p39jNG2HGiTXNaKmJF9jArQqNPhhMWd2hokT5FqV
         qT1OZmSBMdhI7XyrCLNiZSDIHuAaW5dw+yY93MjMfqnR9PW7vND1omxoJbjrr1kK+jBs
         DydbgMd92O00z5iHMaISEnJ2hArCH8441r6IAyvGpbobsy9U81cNgdvBvoPKkXyXI/0a
         biebYZMLL+ACMkPCXIWCZo9vSXVLjxLtK5FwR2P0cJjpQWOC7VANHY1Nqc0VWwGnMn77
         hIL1voDdaPkytCPJh16PBJ88CshpqimQlbCNjPKE7UR7KmFQGPewkfsC5tQO/d6YQ3NW
         QqAw==
X-Gm-Message-State: AOAM531s/rLliPbvDPR2EBKbWhnY+oFOSXc9yKOonMcXHW6oEeyfHpzP
        il1xcE+yxNcG/WaTdVrH23jJvkwXy/nhoPlyf5/iIoOi
X-Google-Smtp-Source: ABdhPJzpNx2QL1b4ZSR273hypRohu/l5UAbBhBrqcBEnPIOylvphrc2qFbIBNoDowB6zCV30c5h46sxrsqqUw33cerk=
X-Received: by 2002:a4a:dc0d:: with SMTP id p13mr1373349oov.2.1602768827277;
 Thu, 15 Oct 2020 06:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201002114426.31277-1-lukasz.luba@arm.com> <d2960f6a-1805-1fb4-98ae-4a756d20370b@arm.com>
 <765e6603-b614-fb72-64ff-248b42474803@linaro.org> <b19c1f12-b7cf-fcae-4ebb-617019effe2e@arm.com>
 <55d3fb0f-f7d8-63c5-2bdb-53eaa62380e0@linaro.org> <f660731e-132b-2514-f526-d7123ed3522c@arm.com>
 <d04019bd-9e85-5f3e-2a1b-66780b8df3dc@linaro.org>
In-Reply-To: <d04019bd-9e85-5f3e-2a1b-66780b8df3dc@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 15 Oct 2020 15:33:36 +0200
Message-ID: <CAJZ5v0jmTYtMyujxxTBezmiO-j3iW_RjRKOkCpqU4gtRe+OJ2Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Clarify abstract scale usage for power values in
 Energy Model, EAS and IPA
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Quentin Perret <qperret@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Nayak, Rajendra" <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 14, 2020 at 7:10 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 14/10/2020 17:24, Lukasz Luba wrote:
>
> [ ... ]
>
> > We have to update the EM doc about allowed abstract scale, which
> > implies EAS, IPA doc update with some information to the community that
> > these components can handle it.
> >
> > The script will just make developers life easier, but the current
> > documentation does not say anything about abstract scale.
>
> ... yes, because there is no consistency across the source of power
> numbers and no tools to ensure DT power numbers consistency, yet.
>
> >> In any case, if the DT is specifying real numbers, and SCMI abstract
> >> numbers or the opposite, obviously there is a conflict if we are using
> >> both.
> >
> > True, DT only allows real numbers (I have Rob's opinion regarding
> > patch 3/3).
> >
> > It's not that there is only SCMI which might use abstract scale. Qcom
> > already has it and other vendors will follow (not exposing real
> > numbers). They would register bogoWatts to EM because they know that EAS
> > can deal with both.
>
> So vendors are using bogoWatts, despite the documentation.
>
> By updating the documentation saying it supports the abstract values,
> that means every new framework, device with power values, will have to
> comply with that. How is it possible to add a device with power numbers
> if the existing ones are obfuscated ?
>
> With two subsystems using the energy model, evolving independently we
> can see there are conflicts. With more subsystems, that may become a
> source of confusion, especially with different contributors.
>
> I think the energy model should stick to milliwatts and keep the
> documentation unchanged regarding this. And vendors should take the
> responsibility of not sticking to the documentation.
>
> >> I suggest to fix the conflict first and provide the features to make the
> >> numbers more easy to share (like the script described above and/or the
> >> firmware file).
> >>
> >> Then with the right tools, everything can be documented.
> >>
> >
> > We cannot block one way of registration to EM when the other was used.
> > They might have correct and consistent numbers.
>
> What is the rational of using two firmware power information ?
>
> > It's up to the platform developers to choose the path:
> > - go with bogoWatts - if they are not allowed to expose sensitive
> >   information, use em_dev_register_perf_domain() in drivers, not DT;
> >   make sure everything that is needed works; check the doc, which
> >   sub-systems can handle it or needs some tuning (patches 1/3 and 2/3
> >   try to help here);
> > - use milliWatts - easier; DT is allowed; help from the community in
> >   reviews, possible results comparisons; both EM registration ways
> >   might be used;
> >
> > We cannot force vendors/OEM engineers to store milliWatts in the
> > Energy Model if these values are protected by some NDA.
>
> If I am able to measure one real power value, (and I'm pretty sure it is
> quite possible), whatever which one, it is possible to deduce all the
> numbers with the linear scale. IMO that is a false debate. Anyway ...
>
> > Your proposed
> > way of providing data into EM from user-space firmware.bin IMHO also
> > falls into the same bucket. That information would be accessible in EM
> > debugfs and they would avoid it.
>
> I think you misunderstood my point.
>
> There is the SCMI and the DT. Because there are two sources where it is
> impossible to know if they are using the same units, we are stuck to
> ensure a consistency for the kernel.
>
> The platform should use:
>  - the SCMI only (scaled or real)
>  - the DT only (real)
>  [ - the firmware file only (scaled or real) ]
>
>
> As it is not possible to know if they are scaled or real, there is no
> choice except making them mutually exclusive.
>
> From my POV, it is not adequate to let SCMI power information co-exists
> with the DT power information if we know they can be with different units.
>
> I've just expressed my opinions:
>
>  - vendors take responsibility of putting different units for the EM
>
>  - Power numbers should come from the same source
>
>
> Up to Rafael to decide what to do with this documentation update.

Well, I was hoping that you both would reach some kind of agreement.

I don't feel like the decision is mine here to be honest.
