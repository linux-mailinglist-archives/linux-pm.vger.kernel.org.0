Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F045329384A
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 11:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392067AbgJTJhz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Oct 2020 05:37:55 -0400
Received: from foss.arm.com ([217.140.110.172]:48670 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391944AbgJTJhy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Oct 2020 05:37:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59704101E;
        Tue, 20 Oct 2020 02:37:54 -0700 (PDT)
Received: from bogus (unknown [10.57.22.167])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 573183F66E;
        Tue, 20 Oct 2020 02:37:51 -0700 (PDT)
Date:   Tue, 20 Oct 2020 10:37:45 +0100
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
Message-ID: <20201020093745.GA10604@bogus>
References: <20201016060021.sotk72u4hioctg7o@bogus>
 <20201016111222.lvakbmjhlrocpogt@bogus>
 <20201019045827.kl6qnx6gidhzjkrs@vireshk-i7>
 <20201019091723.GA12087@bogus>
 <20201019092411.b3znjxebay3puq2j@vireshk-i7>
 <20201019101241.GB12908@bogus>
 <20201019103535.ksp5ackoihamam4g@vireshk-i7>
 <20201019141007.GA6358@bogus>
 <20201020050557.a3b2nk33eeyxnvl2@vireshk-i7>
 <20201020055431.ln7d57x76f7z6j5k@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020055431.ln7d57x76f7z6j5k@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 20, 2020 at 11:24:32AM +0530, Viresh Kumar wrote:
> On 20-10-20, 10:35, Viresh Kumar wrote:
> > On 19-10-20, 15:10, Sudeep Holla wrote:
> > > On Mon, Oct 19, 2020 at 04:05:35PM +0530, Viresh Kumar wrote:
> > > > On 19-10-20, 11:12, Sudeep Holla wrote:
> > > > > Yes it has clocks property but used by SCMI(for CPUFreq/DevFreq) and not
> > > > > by any clock provider driver. E.g. the issue you will see if "clocks"
> > > > > property is used instead of "qcom,freq-domain" on Qcom parts.
> > > > 
> > > > Okay, I understand. But what I still don't understand is why it fails
> > > > for you. You have a clocks property in DT for the CPU, the OPP core
> > > > tries to get it and will get deferred-probed, which will try probing
> > > > at a later point of time and it shall work then. Isn't it ?
> > > >
> > > 
> > > Nope unfortunately. We don't have clock provider, so clk_get will
> > > never succeed and always return -EPROBE_DEFER.
> > 
> > Now this is really bad, you have a fake clocks property, how is the
> > OPP core supposed to know it ? Damn.
> 
> What about instead of fixing the OPP core, which really is doing the
> right thing, we fix your driver (as you can't fix the DT) and add a
> dummy CPU clk to make it all work ?
>

I really would avoid that. I would rather change the binding as there is
no single official users of that binding in the upstream tree.

-- 
Regards,
Sudeep
