Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8131612D80F
	for <lists+linux-pm@lfdr.de>; Tue, 31 Dec 2019 11:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfLaKnh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Dec 2019 05:43:37 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35525 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfLaKnh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Dec 2019 05:43:37 -0500
Received: by mail-ot1-f65.google.com with SMTP id k16so45297517otb.2;
        Tue, 31 Dec 2019 02:43:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f9RuIajEDlg1ejskjnNTp0LO3cBbcL76yHqkzb9nkhs=;
        b=nRFoh7hqUOEwFnF2V+u7nTOOFSg2pbrT/ID8Prw77vN2EWNKI/Xr+1jmCdFBaXmlip
         RpPQd9ngttkSjmf+sE5MC0bqivjNM23GTDAIpUZVD+cdQdM7wHvHcyHRR9ETj0/KKJmX
         ScTp+TyOf1u9Gz/+ChVMrsBdySmUOWvq24t8ZNWNNc36+EP0B70EM4RBpmE/T33ADpr2
         65KBs7nY65hqdoJJdy2XhsSM6uFuRGsPFFfvu4ZR2OSFIo4fYMARhhChNla7grKTPijS
         beBLXglEPwjWmPaiNoTtLogLOA0PtiFlq9fPBvAIDH5FEwsQPvQqA/3nKiEoh3ckDcex
         0Ckw==
X-Gm-Message-State: APjAAAU10zvBBDzo2ldncPKeEaaPP2t6eSqqppsWC/r/2LuQJoGfLRqJ
        FEBjqz4j90x9El50MtUYrm9q8TPcZa6bI1zLJ50=
X-Google-Smtp-Source: APXvYqxjCCDp3TQDPlyzZoTf6zVTaHAL3XMA7buUwxN3t7uiee8Hat/CkGqsTzvBTRieAzNmM4eMtQnJlz9XUMna43I=
X-Received: by 2002:a05:6830:1e67:: with SMTP id m7mr76473319otr.262.1577789016310;
 Tue, 31 Dec 2019 02:43:36 -0800 (PST)
MIME-Version: 1.0
References: <20191230144402.30195-1-ulf.hansson@linaro.org> <CAPDyKFrVQO-WFOfX_EKVTUYnesGj93GQMKxFNpbMt6s3xv_qBw@mail.gmail.com>
In-Reply-To: <CAPDyKFrVQO-WFOfX_EKVTUYnesGj93GQMKxFNpbMt6s3xv_qBw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 31 Dec 2019 11:43:25 +0100
Message-ID: <CAJZ5v0gSY_Zg+sbBEfTaeBCiOf_L6JP4_-4tdpeFU0iCGJu3Nw@mail.gmail.com>
Subject: Re: [PATCH v5 00/15] cpuidle: psci: Support hierarchical CPU arrangement
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 31, 2019 at 11:38 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Rafael,
>
> On Mon, 30 Dec 2019 at 15:44, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Changes in v5:
> >         - Remove PM domains in the error path, when failing to enable OSI.
> >         - Folded in a patch that adds a genpd OF helper to remove subdomains.
> >         - Added reviewed-by tags.
> >
> > Changes in v4:
> >         - Move the check for OSI support from psci_dt_attach_cpu() to the
> >         caller's side of it.
> >         - Add comment in the code about using the deepest idle state as the
> >         triggering point for the domain state selection.
> >         - Folded in a patch to enable support for CPU hotplug.
> >
> > Changes in v3:
> >         - Take one step further to completely avoid executing any OSI specific
> >         code from the ->enter() callback, while operating in the default PSCI
> >         Platform Coordinated mode.
> >         - Update example for the PSCI DT bindings to make it compile with
> >         "make dt_binding_check"
> >
> > Changes in v2:
> >         - Avoid to affect the non-OSI path with specific changes for OSI. This
> >         forced me to re-order the series and a caused more or less minor changes
> >         to most of the patches.
> >         - Updated the DT bindings for PSCI to clarify and to include the "psci"
> >         name of the PM domain to attach to.
> >         - Replaced patch1 with another patch from Sudeep, solving the same
> >         problem, but in a different way.
> >
> > This series enables initial support for hierarchical CPU arrangement, managed
> > by PSCI and its corresponding cpuidle driver. It's based on using the generic
> > PM domain (genpd), which nowadays also supports devices belonging to CPUs.
> >
> > The last DTS patch enables the hierarchical topology to be used for the Qcom
> > 410c Dragonboard, which supports the PSCI OS-initiated mode.
> >
> > More detailed background can be found from previous submissions [1].
> >
> > The series is also available at:
> > git.linaro.org/people/ulf.hansson/linux-pm.git next
> >
> > Kind regards
> > Ulf Hansson
> >
> > [1]
> > https://lwn.net/Articles/788306/
> >
> > Lina Iyer (1):
> >   cpuidle: dt: Support hierarchical CPU idle states
> >
> > Sudeep Holla (1):
> >   cpuidle: psci: Align psci_power_state count with idle state count
> >
> > Ulf Hansson (13):
> >   dt: psci: Update DT bindings to support hierarchical PSCI states
> >   firmware: psci: Export functions to manage the OSI mode
> >   of: base: Add of_get_cpu_state_node() to get idle states for a CPU
> >     node
> >   cpuidle: psci: Simplify OF parsing of CPU idle state nodes
> >   cpuidle: psci: Support hierarchical CPU idle states
> >   cpuidle: psci: Add a helper to attach a CPU to its PM domain
> >   cpuidle: psci: Attach CPU devices to their PM domains
> >   cpuidle: psci: Prepare to use OS initiated suspend mode via PM domains
> >   cpuidle: psci: Manage runtime PM in the idle path
> >   cpuidle: psci: Support CPU hotplug for the hierarchical model
> >   PM / Domains: Introduce a genpd OF helper that removes a subdomain
> >   cpuidle: psci: Add support for PM domains by using genpd
> >   arm64: dts: Convert to the hierarchical CPU topology layout for
> >     MSM8916
> >
> >  .../devicetree/bindings/arm/cpus.yaml         |  15 +
> >  .../devicetree/bindings/arm/psci.yaml         | 104 ++++++
> >  arch/arm64/boot/dts/qcom/msm8916.dtsi         |  57 +++-
> >  drivers/base/power/domain.c                   |  38 +++
> >  drivers/cpuidle/Makefile                      |   4 +-
> >  drivers/cpuidle/cpuidle-psci-domain.c         | 308 ++++++++++++++++++
> >  drivers/cpuidle/cpuidle-psci.c                | 161 +++++++--
> >  drivers/cpuidle/cpuidle-psci.h                |  17 +
> >  drivers/cpuidle/dt_idle_states.c              |   5 +-
> >  drivers/firmware/psci/psci.c                  |  18 +-
> >  drivers/of/base.c                             |  36 ++
> >  include/linux/cpuhotplug.h                    |   1 +
> >  include/linux/of.h                            |   8 +
> >  include/linux/pm_domain.h                     |   8 +
> >  include/linux/psci.h                          |   2 +
> >  15 files changed, 747 insertions(+), 35 deletions(-)
> >  create mode 100644 drivers/cpuidle/cpuidle-psci-domain.c
> >  create mode 100644 drivers/cpuidle/cpuidle-psci.h
> >
> > --
> > 2.17.1
> >
>
> This series is ready to go (unless you have some objections of
> course), would you mind queuing it up?
>
> Of course, patch15 can be left for arm-soc.
>
> If you prefer a pull-request, just tell me.

So I would prefer arm-soc to take the whole lot if that's not a problem.

Feel free to add ACKs from me to the patches for this purpose if that helps

Thanks!
