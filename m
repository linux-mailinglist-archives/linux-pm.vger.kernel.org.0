Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186CD28F81E
	for <lists+linux-pm@lfdr.de>; Thu, 15 Oct 2020 20:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgJOSGE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Oct 2020 14:06:04 -0400
Received: from foss.arm.com ([217.140.110.172]:54886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgJOSGE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Oct 2020 14:06:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7A0E13D5;
        Thu, 15 Oct 2020 11:06:03 -0700 (PDT)
Received: from bogus (unknown [10.57.17.164])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2879D3F71F;
        Thu, 15 Oct 2020 11:06:01 -0700 (PDT)
Date:   Thu, 15 Oct 2020 19:05:55 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ulf.hansson@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, nks@flawful.org,
        georgi.djakov@linaro.org, Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH V2 1/2] opp: Allow dev_pm_opp_get_opp_table() to return
 -EPROBE_DEFER
Message-ID: <20201015180555.gacdzkofpibkdn2e@bogus>
References: <24ff92dd1b0ee1b802b45698520f2937418f8094.1598260050.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24ff92dd1b0ee1b802b45698520f2937418f8094.1598260050.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 24, 2020 at 02:39:32PM +0530, Viresh Kumar wrote:
> From: Stephan Gerhold <stephan@gerhold.net>
> 
> The OPP core manages various resources, e.g. clocks or interconnect paths.
> These resources are looked up when the OPP table is allocated once
> dev_pm_opp_get_opp_table() is called the first time (either directly
> or indirectly through one of the many helper functions).
> 
> At this point, the resources may not be available yet, i.e. looking them
> up will result in -EPROBE_DEFER. Unfortunately, dev_pm_opp_get_opp_table()
> is currently unable to propagate this error code since it only returns
> the allocated OPP table or NULL.
>

OK, this breaks with SCMI which doesn't provide clocks but manage OPPs
directly. Before this change clk_get(dev..) was allowed to fail and
--EPROBE_DEFER was not an error. We use dev_pm_opp_add to add OPPs
read from the firmware and this change is preventing that.

Sorry for checking this so late, but noticed only when this hit mainline.

-- 
Regards,
Sudeep
