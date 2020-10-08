Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15FF8287948
	for <lists+linux-pm@lfdr.de>; Thu,  8 Oct 2020 17:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732022AbgJHP7C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 11:59:02 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36982 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbgJHP5f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2020 11:57:35 -0400
Received: by mail-oi1-f196.google.com with SMTP id t77so6799219oie.4;
        Thu, 08 Oct 2020 08:57:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cs72e3dlnRHmvUEPYXfZ7WjqNDCXAIfxdwnDl9ZQcog=;
        b=fB0/sG9gtXGc5meLs1KDrzFu4d6AINCCNEQs6RnmMuNm4u/Vn2RX6bhxBSD+LeER15
         WDsHarVZFm0+W/qAm2QRFhrVLlQ9XvURABi6kF7n1e9EYgwH8tZgDCLO5O07XumKNB0W
         XYQLNYrcvvInboqs3FAS+s8ke8Y29IYB1HKAJJtLb5asE2dMpzEvWhXMJFIEMKznv7Se
         lZWjC39vgtkSJ+8IG2XQMQCUpea75V3iIkLJlMxZw1T/zfQDgyaIcuChWt3Htqo16Zc+
         PsPRqpFs7hQxfwqm744tZ7GlTz4kwY87xmB/0BON2BovFAt5087QPkNp+9bRoU+KHu8l
         PuJw==
X-Gm-Message-State: AOAM5327M/8H/ipuatIwWZyJX7UIsqZtlYOSBXggGLGwAEpO46S67lP+
        cgXqWZz/oFrSUFfLFuDeS/JxwVEExS3AuWxcqug=
X-Google-Smtp-Source: ABdhPJzFgTj3Fzpnp8tCruViRVk1fpHwot1XZjW4+MCatykeeLJrcY0pppJwRcJmmTpA1sgfqKx8iZZ4AUnjOOEysOY=
X-Received: by 2002:aca:fd52:: with SMTP id b79mr5535928oii.69.1602172654522;
 Thu, 08 Oct 2020 08:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200924095347.32148-1-nicola.mazzucato@arm.com>
 <20200924095347.32148-3-nicola.mazzucato@arm.com> <20201006071909.3cgz7i5v35dgnuzn@vireshk-i7>
 <2417d7b5-bc58-fa30-192c-e5991ec22ce0@arm.com> <20201008110241.dcyxdtqqj7slwmnc@vireshk-i7>
 <20201008150317.GB20268@arm.com>
In-Reply-To: <20201008150317.GB20268@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Oct 2020 17:57:23 +0200
Message-ID: <CAJZ5v0j=g6y53yk_+cPNnUYb6usrQmghCNuiHYc1vbpsypFtCQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] [RFC] CPUFreq: Add support for cpu-perf-dependencies
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Nicola Mazzucato <nicola.mazzucato@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 8, 2020 at 5:03 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>
> Hi Viresh,
>
> On Thursday 08 Oct 2020 at 16:32:41 (+0530), Viresh Kumar wrote:
> > On 07-10-20, 13:58, Nicola Mazzucato wrote:
> > > Hi Viresh,
> > >
> > > performance controls is what is exposed by the firmware through a protocol that
> > > is not capable of describing hardware (say SCMI). For example, the firmware can
> > > tell that the platform has N controls, but it can't say to which hardware they
> > > are "wired" to. This is done in dt, where, for example, we map these controls
> > > to cpus, gpus, etc.
> > >
> > > Let's focus on cpus.
> > >
> > > Normally we would have N of performance controls (what comes from f/w)
> > > that that correspond to hardware clock/dvfs domains.
> > >
> > > However, some firmware implementations might benefit from having finer
> > > grained information about the performance requirements (e.g.
> > > per-CPU) and therefore choose to present M performance controls to the
> > > OS. DT would be adjusted accordingly to "wire" these controls to cpus
> > > or set of cpus.
> > > In this scenario, the f/w will make aggregation decisions based on the
> > > requests it receives on these M controls.
> > >
> > > Here we would have M cpufreq policies which do not necessarily reflect the
> > > underlying clock domains, thus some s/w components will underperform
> > > (EAS and thermal, for example).
> > >
> > > A real example would be a platform in which the firmware describes the system
> > > having M per-cpu control, and the cpufreq subsystem will have M policies while
> > > in fact these cpus are "performance-dependent" each other (e.g. are in the same
> > > clock domain).
> >
> > If the CPUs are in the same clock domain, they must be part of the
> > same cpufreq policy.
>
> But cpufreq does not currently support HW_ALL (I'm using the ACPI
> coordination type to describe the generic scenario of using hardware
> aggregation and coordination when establishing the clock rate of CPUs).
>
> Adding support for HW_ALL* will involve either bypassing some
> assumptions around cpufreq policies or making core cpufreq changes.
>
> In the way I see it, support for HW_ALL involves either:
>
>  - (a) Creating per-cpu policies in order to allow each of the CPUs to
>    send their own frequency request to the hardware which will do
>    aggregation and clock rate decision at the level of the clock
>    domain.

This has been done for years on many platforms.

>    The PSD domains (ACPI) and the new DT binding will tell
>    which CPUs are actually in the same clock domain for whomever is
>    interested, despite those CPUs not being in the same policy.

And this information hasn't been used so far in those cases.

>    This requires the extra mask that Nicola introduced.

What would you use it for, specifically?

>  - (b) Making deep changes to cpufreq (core/governors/drivers) to allow:

Not an option really.
