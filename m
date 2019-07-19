Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3E86E3A7
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jul 2019 11:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfGSJpu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jul 2019 05:45:50 -0400
Received: from foss.arm.com ([217.140.110.172]:40966 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfGSJpu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Jul 2019 05:45:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93A29337;
        Fri, 19 Jul 2019 02:45:49 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7DE33F59C;
        Fri, 19 Jul 2019 02:45:46 -0700 (PDT)
Date:   Fri, 19 Jul 2019 10:45:30 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souvik Chakravarty <souvik.chakravarty@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lina Iyer <lina.iyer@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 09/18] drivers: firmware: psci: Add support for PM
 domains using genpd
Message-ID: <20190719094530.GA15248@e107155-lin>
References: <20190513192300.653-1-ulf.hansson@linaro.org>
 <20190513192300.653-10-ulf.hansson@linaro.org>
 <20190716150533.GD7250@e107155-lin>
 <CAPDyKFqaE2L419siFY=LGDsotAnpBt+H_vpmG62AqQw8UQJZJA@mail.gmail.com>
 <20190718131913.GB28633@e107155-lin>
 <20190718175746.GE25567@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718175746.GE25567@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jul 18, 2019 at 11:57:46AM -0600, Lina Iyer wrote:
> On Thu, Jul 18 2019 at 07:19 -0600, Sudeep Holla wrote:
[...]

> >
> > Yes 2 different issues here:
> > 1. The direct assignment overwriting the value is problem which you agree.
> > 2. The OR logic on it's own is bit not so clear from the specification.
> >   Since firmware authors need to be aware of this to make all these
> >   work. So it's not implicit, either we set this requirement in form
> >   of binding. We were also thinking of stating composite state in the
> >   DT, still just a thought, need to come up with examples/illustrations.
> >
> It is generally very obvious to firmware authors to map hardware
> definitions to specific bits in the state param. If a cluster component
> has more than on/off state, more bits are assigned to the define the
> idle states of the component.

While I completely agree that generally the firmware authors tend to
assign a bit(s) to indicate a state, it not so evident from the PSCI
specification. My worry is someone shouldn't come up with sequential
numbering and expect this to work.

I am fine with OR, but we need to document it somewhere so that we
can point people so that the driver in the kernel is not expected
to work with any other schema of numbering StateID that violates
the assumption.

> Addition is also an option, but there are enough bits compared to the
> hardware components that we have in each state, that it hasn't been a
> problem.
>
Yes, but with extended format, the StateType move to bit 30, and if
we represent each individual state to indicate that bit correctly(I
except everyone to so that and it shouldn't cause issue if we OR the
parameters to get composite states), addition may cause issues.

--
Regards,
Sudeep

