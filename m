Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8605528FDF0
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 08:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390495AbgJPGA1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 02:00:27 -0400
Received: from foss.arm.com ([217.140.110.172]:53494 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390427AbgJPGA1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 16 Oct 2020 02:00:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3420B30E;
        Thu, 15 Oct 2020 23:00:26 -0700 (PDT)
Received: from bogus (unknown [10.57.17.164])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F6DF3F66B;
        Thu, 15 Oct 2020 23:00:23 -0700 (PDT)
Date:   Fri, 16 Oct 2020 07:00:21 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ulf.hansson@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
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
Message-ID: <20201016060021.sotk72u4hioctg7o@bogus>
References: <24ff92dd1b0ee1b802b45698520f2937418f8094.1598260050.git.viresh.kumar@linaro.org>
 <20201015180555.gacdzkofpibkdn2e@bogus>
 <20201016042434.org6ibdqsqbzcdww@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016042434.org6ibdqsqbzcdww@vireshk-i7>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 16, 2020 at 09:54:34AM +0530, Viresh Kumar wrote:
> On 15-10-20, 19:05, Sudeep Holla wrote:
> > OK, this breaks with SCMI which doesn't provide clocks but manage OPPs
> > directly. Before this change clk_get(dev..) was allowed to fail and
> > --EPROBE_DEFER was not an error.
> 
> I think the change in itself is fine. We should be returning from
> there if we get EPROBE_DEFER. The question is rather why are you
> getting EPROBE_DEFER here ?
> 

Ah OK, I didn't spend too much time, saw -EPROBE_DEFER, just reverted
this patch and it worked. I need to check it in detail yet.

-- 
Regards,
Sudeep
