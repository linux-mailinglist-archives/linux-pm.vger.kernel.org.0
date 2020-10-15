Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995EE28F379
	for <lists+linux-pm@lfdr.de>; Thu, 15 Oct 2020 15:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbgJONk3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Oct 2020 09:40:29 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40593 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729837AbgJONk3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2020 09:40:29 -0400
Received: by mail-oi1-f193.google.com with SMTP id m128so3126273oig.7;
        Thu, 15 Oct 2020 06:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EOqcpAW3QJidtNkzeDWtmKSshgjwO1Lbx6qQkgeNQdo=;
        b=Uga8vmOL7MQNdgsyjkcUgaZNRIkUfK8IHojXm1/j7e+77bJJa/2tumwc8hUmhfLacu
         yF6AhG07L1RQxlWyANQk0vqQJZOrWM8q43q5jdUqyCW7i3XcbuPZaChd9OwhEDKm4NE7
         rE6JoynEqjc4vNpnEWJryIVlXH6ieoKgm1LNDX6cWk1CX2Y7CrTUSOqk0kvnBx3/rnFp
         GmeF5aKKIR3Gx5DNdq88pn4zJyXTwnY0q6MenDsL6PhC2P1EOvKGMWRsd5+Q2HAJEc8X
         Ukk+snIl+p3elq4lF1aJeATt3LsE3kb9qXY776vuPh+mkGVTZPGdFv+G1wc/KRbe2ZHc
         ROlA==
X-Gm-Message-State: AOAM532lOSQJNClSzl1qbx5UkvwxyyHTUV/p5Ti5o4CYaDiTEzAlIZvM
        iFeKsfLoI55vHc+dcJ5mNDqpm1cMJjER4V4g0Wm6IK5L
X-Google-Smtp-Source: ABdhPJw9Zr5JPQTUmWofZa2CwNMCls3dZWBOXE34dhtBiHfQoGf5kljzQNOu/ZUFgYkdU0wYWGiXd6IymaFqmZLhMlc=
X-Received: by 2002:aca:724a:: with SMTP id p71mr2189525oic.157.1602769228038;
 Thu, 15 Oct 2020 06:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201002114426.31277-1-lukasz.luba@arm.com> <d2960f6a-1805-1fb4-98ae-4a756d20370b@arm.com>
 <765e6603-b614-fb72-64ff-248b42474803@linaro.org> <b19c1f12-b7cf-fcae-4ebb-617019effe2e@arm.com>
 <55d3fb0f-f7d8-63c5-2bdb-53eaa62380e0@linaro.org> <f660731e-132b-2514-f526-d7123ed3522c@arm.com>
 <d04019bd-9e85-5f3e-2a1b-66780b8df3dc@linaro.org> <3e3dd42c-48ac-7267-45c5-ca88205611bd@arm.com>
 <00ceec64-3273-bb4a-6f38-22de8d877ab5@linaro.org>
In-Reply-To: <00ceec64-3273-bb4a-6f38-22de8d877ab5@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 15 Oct 2020 15:40:16 +0200
Message-ID: <CAJZ5v0hV8fwRnADdjiiF=zapO3AE6=_W_PeOQ_WhUirCcFkgdA@mail.gmail.com>
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

On Thu, Oct 15, 2020 at 12:22 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 15/10/2020 11:00, Lukasz Luba wrote:
>
> [ ... ]
>
> >> There is the SCMI and the DT. Because there are two sources where it is
> >> impossible to know if they are using the same units, we are stuck to
> >> ensure a consistency for the kernel.
> >>
> >> The platform should use:
> >>   - the SCMI only (scaled or real)
> >>   - the DT only (real)
> >>   [ - the firmware file only (scaled or real) ]
> >>
> >
> > Do you mean by SCMI - registration using em_dev_register_perf_domain() ?
>
> It was high level description, but yes, I guess it is the case.
>
> >> As it is not possible to know if they are scaled or real, there is no
> >> choice except making them mutually exclusive.
> >
> > So you propose a bit more restriction in registration EM, to not get
> > lost in the future. I also have these doubts. Let's consider it and
> > maybe agree.
> >
> > I've recommended Qcom to use em_dev_register_perf_domain() when they
> > have this obfuscated power values. Then any developer in the future
> > who wants to add EM for a new device on that platform, should use the
> > em_dev_register_perf_domain().
> >
> > In this case the flag in EM that you have proposed makes sense.
> > We probably need an argument 'bool abstract_scale' in the
> > em_dev_register_perf_domain(..., bool abstract_scale)
> > as a source of information.
>
> I was suggesting to add a flag to the em_perf_domain structure giving
> the source of the power numbers.
>
> So if the IPA is having the 'sustainable-power' set in DT but the
> em_perf_domain is flagged with power number coming from SCMI, then they
> will be incompatible, the thermal zone will fail to register.
>
>
> > We would allow to co-exist em_dev_register_perf_domain(..., false)
> > with dev_pm_opp_of_register_em() EM devices.
> >
> > Is it make sense?
>
> Well, it does not change my opinion. We should assume the energy model
> is always milliwatts. If the SoC vendors find a way to get around with
> bogoWatts, then good to them and up to them to deal with in the future.

That sounds fair enough, but it also means that any kernel patches
using power units different from milliwatts for the EM should be
rejected in the future, doesn't it?

And the existing code using different power units for the EM (if any)
should be updated/fixed accordingly, shouldn't it?

Otherwise I don't see now this can be regarded as a hard rule.
