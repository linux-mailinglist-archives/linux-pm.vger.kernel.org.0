Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19151FE3FC
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 18:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfKORa7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 12:30:59 -0500
Received: from foss.arm.com ([217.140.110.172]:34252 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727543AbfKORa6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Nov 2019 12:30:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF2C531B;
        Fri, 15 Nov 2019 09:30:57 -0800 (PST)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1F7B3F6C4;
        Fri, 15 Nov 2019 09:30:55 -0800 (PST)
Date:   Fri, 15 Nov 2019 17:30:53 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Kevin Hilman <khilman@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v2 10/13] cpuidle: psci: Prepare to use OS initiated
 suspend mode via PM domains
Message-ID: <20191115173053.GE27170@bogus>
References: <20191029164438.17012-1-ulf.hansson@linaro.org>
 <20191029164438.17012-11-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029164438.17012-11-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 29, 2019 at 05:44:35PM +0100, Ulf Hansson wrote:
> The per CPU variable psci_power_state, contains an array of fixed values,
> which reflects the corresponding arm,psci-suspend-param parsed from DT, for
> each of the available CPU idle states.
>
> This isn't sufficient when using the hierarchical CPU topology in DT, in
> combination with having PSCI OS initiated (OSI) mode enabled. More
> precisely, in OSI mode, Linux is responsible of telling the PSCI FW what
> idle state the cluster (a group of CPUs) should enter, while in PSCI
> Platform Coordinated (PC) mode, each CPU independently votes for an idle
> state of the cluster.
>
> For this reason, introduce a per CPU variable called domain_state and
> implement two helper functions to read/write its value. Then let the
> domain_state take precedence over the regular selected state, when entering
> and idle state.
>
> Finally, let's also avoid sprinkling the existing non-OSI path with
> operations being specific for OSI.
>

Mostly looks good. I am still wondering if we can keep all OSI related
info in the newly created structure and have psci_states outside it as
before. And I was think psci_enter_idle_state_pc and psci_enter_idle_state_osi
instead of single psci_enter_idle_state and assign/initialise state->enter
based on the mode chosen. I had to closer look now and looks like enter
is initialised in generic dt_idle_states. That said, what you have in this
patch also looks OK to me, was just trying to avoid access to the new
structure all together and keep the PC mode patch almost same as before
when suspending. I will see what Lorenzo thinks about this.

--
Regards,
Sudeep
