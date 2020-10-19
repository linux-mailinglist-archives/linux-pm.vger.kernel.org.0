Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1879D29247B
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 11:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbgJSJRy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 05:17:54 -0400
Received: from foss.arm.com ([217.140.110.172]:53092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729941AbgJSJRy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Oct 2020 05:17:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6174A30E;
        Mon, 19 Oct 2020 02:17:53 -0700 (PDT)
Received: from bogus (unknown [10.57.13.246])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EA003F66E;
        Mon, 19 Oct 2020 02:17:50 -0700 (PDT)
Date:   Mon, 19 Oct 2020 10:17:48 +0100
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
Message-ID: <20201019091723.GA12087@bogus>
References: <24ff92dd1b0ee1b802b45698520f2937418f8094.1598260050.git.viresh.kumar@linaro.org>
 <20201015180555.gacdzkofpibkdn2e@bogus>
 <20201016042434.org6ibdqsqbzcdww@vireshk-i7>
 <20201016060021.sotk72u4hioctg7o@bogus>
 <20201016111222.lvakbmjhlrocpogt@bogus>
 <20201019045827.kl6qnx6gidhzjkrs@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019045827.kl6qnx6gidhzjkrs@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 19, 2020 at 10:28:27AM +0530, Viresh Kumar wrote:
> On 16-10-20, 12:12, Sudeep Holla wrote:
> > On Fri, Oct 16, 2020 at 07:00:21AM +0100, Sudeep Holla wrote:
> > > On Fri, Oct 16, 2020 at 09:54:34AM +0530, Viresh Kumar wrote:
> > > > On 15-10-20, 19:05, Sudeep Holla wrote:
> > > > > OK, this breaks with SCMI which doesn't provide clocks but manage OPPs
> > > > > directly. Before this change clk_get(dev..) was allowed to fail and
> > > > > --EPROBE_DEFER was not an error.
> > > >
> > > > I think the change in itself is fine. We should be returning from
> > > > there if we get EPROBE_DEFER. The question is rather why are you
> > > > getting EPROBE_DEFER here ?
> > > >
> > >
> > > Ah OK, I didn't spend too much time, saw -EPROBE_DEFER, just reverted
> > > this patch and it worked. I need to check it in detail yet.
> > >
> > 
> > You confused me earlier. As I said there will be no clock provider
> > registered for SCMI CPU/Dev DVFS.
> > 	opp_table->clk = clk_get(dev, NULL);
> > will always return -EPROBE_DEFER as there is no clock provider for dev.
> > But this change now propagates that error to caller of dev_pm_opp_add
> > which means we can't add opp to a device if there are no clock providers.
> > This breaks for DVFS which don't operate separately with clocks and
> > regulators.
>
> The CPUs DT node shouldn't have a clock property in such a case and I
> would expect an error instead of EPROBE_DEFER then. Isn't it ?

Ideally yes, but for legacy reasons clocks property has been used for
providing OPP/DVFS handle too. While we can change and add new property
for that, it will still break old bindings.

--
Regards,
Sudeep
