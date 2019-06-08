Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D02203A1F7
	for <lists+linux-pm@lfdr.de>; Sat,  8 Jun 2019 22:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfFHUep (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 8 Jun 2019 16:34:45 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43253 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfFHUeo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 8 Jun 2019 16:34:44 -0400
Received: by mail-ot1-f67.google.com with SMTP id i8so4972051oth.10
        for <linux-pm@vger.kernel.org>; Sat, 08 Jun 2019 13:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D8/qDqfPkVGZUn8vdM5itujzQRqrS5X8YxVMRBtMjDY=;
        b=eX3FjAk36rb3Ha7yiF+YMIa1zh8yBYZ3DylR0QrzhMU+S0bGi8URBjLCPVObVvLKCy
         /oSCxlcPb7V0Vj09P89IOzP9WmtQfFpu22+7mnvJQDOUlxBauU+hxjCwNcwS8js8rOm+
         Ju9ir/7dKcCSHhU76fmZgj3qVbP65PKZJI7WsbPUhDwyqa/EWWC+KiABHEFiFB9/NMXN
         5wT/nrodXriwuV3jGaH8IOiIf2lN3czNuCMPw7OY4+bL7qqAl4scNv+2Kj92jm8hKac5
         jHNSpVxr0jCwtOozqpZpTrYpYO7b2Co45n9mXTH8FCOmWfXt4c/KfHQgoaCpK0JLrWFd
         wWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D8/qDqfPkVGZUn8vdM5itujzQRqrS5X8YxVMRBtMjDY=;
        b=enYelBBJDxfOgbjAdkYDbGX5musRjNdikHQZlESwg4XVsu/3csIbXl1tDM5CFpfmMO
         MmaRjcC7FKdcCAGPTQqxY3VTAcW3g9K39jTv35F7qxGHSyTFU+6zxmdydgHFAs6pyzVf
         1cBXria2q0kJZyg8NhkfUq0X/4HL2Bb3kreeCGivQqyYdlzroTIz9Bu8ugd/EKAEWpdh
         /26iDOuJ6UpYRN5MjH0cKVlooVbmOfNxMDQ+phLjgE5pCODTr6a9fUO57ZsG8wZ7Mb7i
         OUi8iam6jHousG/I90a50ekwongHbJvlygJ88BX1/ts65wrKJfgDaSXMdv5OlMGBiwzT
         Jg4g==
X-Gm-Message-State: APjAAAVfNxjJatsBrDzs890HvB4je3TlXnqcQufEQn7vZyMEFhItx6R/
        46oPrzTKUqS/KmzkB/1CkMjbyDvSyhaJ3moU50FFeA==
X-Google-Smtp-Source: APXvYqwfvsinhAExHpbPdnWS2JDnivi1ixM3+e9hSCMMvM+doHSF+wc257eXlo/Fd99/V1/B62RHeloUa6/N4C9RJ1M=
X-Received: by 2002:a05:6830:12d6:: with SMTP id a22mr23714748otq.236.1560026083112;
 Sat, 08 Jun 2019 13:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190608044339.115026-1-saravanak@google.com> <20190608054711.GZ22737@tuxbook-pro>
In-Reply-To: <20190608054711.GZ22737@tuxbook-pro>
From:   Saravana Kannan <saravanak@google.com>
Date:   Sat, 8 Jun 2019 13:34:07 -0700
Message-ID: <CAGETcx_4hh0t+Wi4KLh3h6Me8U_6agYbwBZ_Ts8oASiU21Tiig@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] Introduce Bandwidth OPPs & interconnect devfreq driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        sibis@codeaurora.org,
        Android Kernel Team <kernel-team@android.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 7, 2019 at 10:46 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Fri 07 Jun 21:43 PDT 2019, Saravana Kannan wrote:
>
> > I replied[1] to this patch series[2] and described how I think interconnect
> > bandwidth voting should be captured in DT and how it should work.
> >
> > So sending out a patch series implementing that. This patch series does the
> > following:
> > - Adds Bandwidth OPP table support (this adds device freq to bandwidth
> >   mapping for free)
> > - Adds a devfreq library for interconnect paths
> >
>
> Please provide a driver that uses this devfreq library, without it this
> its impossible to gauge the usefulness of your approach.

Do you have a device/driver from SDM845 that I could add interconnect
support to other than CPUs? Because the CPU driver doesn't even have
an OPP table (because it gets that from hardware) and I don't want to
deal with that right now. Can you also give me the "interconnect"
values for those so that I can have something valid that you can try
out?

> > Interconnects and interconnect paths quantify they performance levels in
> > terms of bandwidth. So similar to how we have frequency based OPP tables
> > in DT and in the OPP framework, this patch series adds bandwidth OPP
> > table support in the OPP framework and in DT.
> >
> > To simplify voting for interconnects, this patch series adds helper
> > functions to create devfreq devices out of interconnect paths. This
> > allows drivers to add a single line of code to add interconnect voting
> > capability.
> >
> > To add devfreq device for the "gpu-mem" interconnect path:
> > icc_create_devfreq(dev, "gpu-mem");
> >
> > With the future addition of a "passive_bandwidth" devfreq governor,
> > device frequency to interconnect bandwidth mapping would come for free.
> >
> > If the feedback on this patch series is positive, I'll then add the
> > devfreq passive_bandwidth governor (or something similar) to v2 of this
> > patch series.
> >
> > So with the DT bindings added in this patch series, the DT for a GPU
> > that does bandwidth voting from GPU to Cache and GPU to DDR would look
> > something like this:
> >
> > gpu_cache_opp_table: gpu_cache_opp_table {
> >       compatible = "operating-points-v2";
> >
> >       gpu_cache_3000: opp-3000 {
> >               opp-peak-KBps = <3000>;
> >               opp-avg-KBps = <1000>;
> >       };
> >       gpu_cache_6000: opp-6000 {
> >               opp-peak-KBps = <6000>;
> >               opp-avg-KBps = <2000>;
> >       };
> >       gpu_cache_9000: opp-9000 {
> >               opp-peak-KBps = <9000>;
> >               opp-avg-KBps = <9000>;
> >       };
> > };
> >
> > gpu_ddr_opp_table: gpu_ddr_opp_table {
> >       compatible = "operating-points-v2";
> >
> >       gpu_ddr_1525: opp-1525 {
> >               opp-peak-KBps = <1525>;
> >               opp-avg-KBps = <452>;
> >       };
> >       gpu_ddr_3051: opp-3051 {
> >               opp-peak-KBps = <3051>;
> >               opp-avg-KBps = <915>;
> >       };
> >       gpu_ddr_7500: opp-7500 {
> >               opp-peak-KBps = <7500>;
> >               opp-avg-KBps = <3000>;
> >       };
> > };
> >
> > gpu_opp_table: gpu_opp_table {
> >       compatible = "operating-points-v2";
> >       opp-shared;
> >
> >       opp-200000000 {
> >               opp-hz = /bits/ 64 <200000000>;
> >               required-opps = <&gpu_cache_3000>, <&gpu_ddr_1525>;
>
> I still don't see the benefit of the indirection, over just spelling out
> the bandwidth values here.

All the things I mentioned in the other email? This explicitly
enumerates the actual BW OPPs in the interconnect paths as opposed to
getting a partial list of "performance points" obtained from the
mapping. Put another way, it's like how you don't try to enumerate the
voltages supported by a regualtor by looking at the mappings in the
OPP of a device using the regulator. You instead capture the regulator
properties separately and the consumer asks what it wants and then
that's bound within the scope of what the regulator can support.

Also, if more properties are added in the future to interconnects
(priority, active vs sleep or tagging, etc) the BW OPP tables is well
suited to capture them than adding them to the GPU/CPU/device's
mapping to what it wants from the interconnect.

This method also removes the ambiguity of which bandwidth mapping
belongs to which interconnect path (the question Rajendra was asking
in the other thread) and the peak vs avg bandwidth.

Also with the interconnect paths actually enumerating the OPPs, you
don't have to have a useless mapping just so that you bandwidth
counter based scheme can get a list of the available OPPs.

Also, it is not unusual for the device OPP count vs the interconnect
path OPP count to be different. So, if their counts aren't the same,
the method used in the other thread can't capture the OPP lists
fully/properly.

-Saravana

>
> Regards,
> Bjorn
>
> >       };
> >       opp-400000000 {
> >               opp-hz = /bits/ 64 <400000000>;
> >               required-opps = <&gpu_cache_6000>, <&gpu_ddr_3051>;
> >       };
> > };
> >
> > gpu@7864000 {
> >       ...
> >       operating-points-v2 = <&gpu_opp_table>, <&gpu_cache_opp_table>, <&gpu_ddr_opp_table>;
> >       interconnects = <&mmnoc MASTER_GPU_1 &bimc SLAVE_SYSTEL_CACHE>,
> >                       <&mmnoc MASTER_GPU_1 &bimc SLAVE_DDR>;
> >       interconnect-names = "gpu-cache", "gpu-mem";
> >       interconnect-opp-table = <&gpu_cache_opp_table>, <&gpu_ddr_opp_table>
> > };
> >
> > Cheers,
> > Saravana
> >
> > [1] - https://lore.kernel.org/lkml/20190601021228.210574-1-saravanak@google.com/
> > [2] - https://lore.kernel.org/lkml/20190423132823.7915-1-georgi.djakov@linaro.org/
> >
> > Saravana Kannan (9):
> >   dt-bindings: opp: Introduce opp-peak-KBps and opp-avg-KBps bindings
> >   OPP: Add support for bandwidth OPP tables
> >   OPP: Add helper function for bandwidth OPP tables
> >   OPP: Add API to find an OPP table from its DT node
> >   dt-bindings: interconnect: Add interconnect-opp-table property
> >   interconnect: Add OPP table support for interconnects
> >   OPP: Add function to look up required OPP's for a given OPP
> >   OPP: Allow copying OPPs tables between devices
> >   interconnect: Add devfreq support
> >
> >  .../bindings/interconnect/interconnect.txt    |   8 +
> >  Documentation/devicetree/bindings/opp/opp.txt |  15 +-
> >  drivers/interconnect/Makefile                 |   2 +-
> >  drivers/interconnect/core.c                   |  27 +++-
> >  drivers/interconnect/icc-devfreq.c            | 144 ++++++++++++++++++
> >  drivers/opp/core.c                            | 109 +++++++++++++
> >  drivers/opp/of.c                              |  75 +++++++--
> >  drivers/opp/opp.h                             |   4 +-
> >  include/linux/interconnect.h                  |  17 +++
> >  include/linux/pm_opp.h                        |  41 +++++
> >  10 files changed, 426 insertions(+), 16 deletions(-)
> >  create mode 100644 drivers/interconnect/icc-devfreq.c
> >
> > --
> > 2.22.0.rc2.383.gf4fbbf30c2-goog
> >
