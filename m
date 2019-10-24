Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6C0E36A9
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2019 17:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503228AbfJXP3G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Oct 2019 11:29:06 -0400
Received: from foss.arm.com ([217.140.110.172]:54428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503227AbfJXP3G (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 24 Oct 2019 11:29:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2ADD231F;
        Thu, 24 Oct 2019 08:28:51 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23A5C3F71F;
        Thu, 24 Oct 2019 08:28:49 -0700 (PDT)
Date:   Thu, 24 Oct 2019 16:28:47 +0100
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
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH 04/13] of: base: Add of_get_cpu_state_node() to get idle
 states for a CPU node
Message-ID: <20191024152847.GC11467@bogus>
References: <20191010113937.15962-1-ulf.hansson@linaro.org>
 <20191010113937.15962-5-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010113937.15962-5-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 10, 2019 at 01:39:28PM +0200, Ulf Hansson wrote:
> The CPU's idle state nodes are currently parsed at the common cpuidle DT
> library, but also when initializing data for specific CPU idle operations,
> as in the PSCI cpuidle driver case and qcom-spm cpuidle case.
> 
> To avoid open-coding, let's introduce of_get_cpu_state_node(), which takes
> the device node for the CPU and the index to the requested idle state node,
> as in-parameters. In case a corresponding idle state node is found, it
> returns the node with the refcount incremented for it, else it returns
> NULL.
> 
> Moreover, for PSCI there are two options to describe the CPU's idle states
> [1], either via a flattened description or a hierarchical layout. Hence,
> let's take both options into account.
> 
> [1] Documentation/devicetree/bindings/arm/psci.yaml
> 
> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
