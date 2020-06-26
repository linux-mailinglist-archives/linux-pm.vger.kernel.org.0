Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BB320B3D2
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jun 2020 16:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgFZOmY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jun 2020 10:42:24 -0400
Received: from foss.arm.com ([217.140.110.172]:56198 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgFZOmY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Jun 2020 10:42:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C2FC1FB;
        Fri, 26 Jun 2020 07:42:24 -0700 (PDT)
Received: from bogus (unknown [10.37.12.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 292E63F6CF;
        Fri, 26 Jun 2020 07:42:20 -0700 (PDT)
Date:   Fri, 26 Jun 2020 15:42:18 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/5] cpuidle: psci: Fix error path via converting to a
 platform driver
Message-ID: <20200626144218.GD27140@bogus>
References: <20200615152054.6819-1-ulf.hansson@linaro.org>
 <20200615152054.6819-3-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615152054.6819-3-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 15, 2020 at 05:20:51PM +0200, Ulf Hansson wrote:
> The current error paths for the cpuidle-psci driver, may leak memory or
> possibly leave CPU devices attached to their PM domains. These are quite
> harmless issues, but still deserves to be taken care of.
>
> Although, rather than fixing them by keeping track of allocations that
> needs to be freed, which tends to become a bit messy, let's convert into a
> platform driver. In this way, it gets easier to fix the memory leaks as we
> can rely on the devm_* functions.
>
> Moreover, converting to a platform driver also enables support for deferred
> probe, which subsequent changes takes benefit from.
>

Though I don't have strong opinion, I don't like platform device for cpuidle.
But that's not main issue. I am more worried about the need for whole
deferred probe for cpuidle. Is this due to OSI and Qcom dependencies ?
Ideally, the firmware is already to accept suspend calls soon after they
are powered on in psci f/w.

--
Regards,
Sudeep
