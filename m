Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7002B5FF6
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2019 11:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfIRJRz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Sep 2019 05:17:55 -0400
Received: from foss.arm.com ([217.140.110.172]:37982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfIRJRz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Sep 2019 05:17:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA099337;
        Wed, 18 Sep 2019 02:17:54 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD1303F59C;
        Wed, 18 Sep 2019 02:17:52 -0700 (PDT)
Date:   Wed, 18 Sep 2019 10:17:47 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com, agross@kernel.org,
        tdas@codeaurora.org, swboyd@chromium.org, ilina@codeaurora.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 5/5] cpufreq: qcom-hw: Move driver initialisation earlier
Message-ID: <20190918091747.GA18121@bogus>
References: <cover.1568240476.git.amit.kucheria@linaro.org>
 <b731b713d8738239c26361ece7f5cadea035b353.1568240476.git.amit.kucheria@linaro.org>
 <20190917093412.GA24757@bogus>
 <20190918090938.b2fj5uk3h6t56t2p@vireshk-mac-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918090938.b2fj5uk3h6t56t2p@vireshk-mac-ubuntu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 18, 2019 at 02:39:38PM +0530, Viresh Kumar wrote:
> On 17-09-19, 10:34, Sudeep Holla wrote:
> > On Thu, Sep 12, 2019 at 04:02:34AM +0530, Amit Kucheria wrote:
> > > -device_initcall(qcom_cpufreq_hw_init);
> > > +postcore_initcall(qcom_cpufreq_hw_init);
> >
> > I am fine with core framework initcall pushed to earlier initcall levels
> > if required, but for individual/platform specific drivers I am not so
> > happy to see that.
> >
> > This goes against the grand plan of single common kernel strategy by
> > Android moving all drivers as modules.
>
> Its been long that I got the opportunity to work on drivers directly, but as far
> as I remember (which should be incorrect based on your reply) we can still build
> a driver as module even if it has some postcore_initcall() declarations. They
> will execute at module insertion. Is that incorrect ? If not, then how is it
> going to affect android effort ?
>

Ah no, I am not referring to building as module. As you mention, that may
work just fine. I was referring to timing dependency during boot. The idea
is minimize the number of such initcall dependency. They should all work
fine even as modules and should have least dependency on initcall sequence.

--
Regards,
Sudeep
