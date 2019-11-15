Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEC25FE408
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 18:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfKORdE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Nov 2019 12:33:04 -0500
Received: from foss.arm.com ([217.140.110.172]:34300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727540AbfKORdE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Nov 2019 12:33:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FA2C31B;
        Fri, 15 Nov 2019 09:33:01 -0800 (PST)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 78B203F6C4;
        Fri, 15 Nov 2019 09:32:59 -0800 (PST)
Date:   Fri, 15 Nov 2019 17:32:57 +0000
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
        Kevin Hilman <khilman@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 11/13] cpuidle: psci: Manage runtime PM in the idle
 path
Message-ID: <20191115173257.GF27170@bogus>
References: <20191029164438.17012-1-ulf.hansson@linaro.org>
 <20191029164438.17012-12-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029164438.17012-12-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 29, 2019 at 05:44:36PM +0100, Ulf Hansson wrote:
> In case we have succeeded to attach a CPU to its PM domain, let's deploy
> runtime PM support for the corresponding attached device, to allow the CPU
> to be powered-managed accordingly.
>
> To set the triggering point for when runtime PM reference counting should
> be done, let's store the index of deepest idle state for the CPU in the per
> CPU struct. Then use this index to compare the selected idle state index
> when entering idle, as to understand whether runtime PM reference counting
> is needed or not.
>
> Note that, from the hierarchical point view, there may be good reasons to
> do runtime PM reference counting even on shallower idle states, but at this
> point this isn't supported, mainly due to limitations set by the generic PM
> domain.
>

Looks much better now with psci_enter_domain_state split as separate.

--
Regards,
Sudeep
