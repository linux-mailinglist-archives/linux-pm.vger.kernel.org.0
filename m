Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFB227EA6F
	for <lists+linux-pm@lfdr.de>; Wed, 30 Sep 2020 15:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbgI3N6J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Sep 2020 09:58:09 -0400
Received: from foss.arm.com ([217.140.110.172]:36834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729903AbgI3N6I (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 30 Sep 2020 09:58:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD1FB30E;
        Wed, 30 Sep 2020 06:58:07 -0700 (PDT)
Received: from bogus (unknown [10.57.47.250])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E0A73F6CF;
        Wed, 30 Sep 2020 06:58:04 -0700 (PDT)
Date:   Wed, 30 Sep 2020 14:57:33 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     ansuelsmth@gmail.com
Cc:     'Rob Herring' <robh+dt@kernel.org>,
        'Andy Gross' <agross@kernel.org>,
        'Bjorn Andersson' <bjorn.andersson@linaro.org>,
        'MyungJoo Ham' <myungjoo.ham@samsung.com>,
        'Kyungmin Park' <kyungmin.park@samsung.com>,
        'Chanwoo Choi' <cw00.choi@samsung.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] devfreq: qcom: Add L2 Krait Cache devfreq scaling
 driver
Message-ID: <20200930135733.GA7609@bogus>
References: <20200929162926.139-1-ansuelsmth@gmail.com>
 <20200930092954.GA7125@bogus>
 <006c01d69720$abd3f230$037bd690$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006c01d69720$abd3f230$037bd690$@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 30, 2020 at 01:56:01PM +0200, ansuelsmth@gmail.com wrote:
> > Subject: Re: [PATCH v2 1/2] devfreq: qcom: Add L2 Krait Cache devfreq
> > scaling driver
> >
> > On Tue, Sep 29, 2020 at 06:29:24PM +0200, Ansuel Smith wrote:
> > > Qcom L2 Krait CPUs use the generic cpufreq-dt driver and doesn't
> actually
> > > scale the Cache frequency when the CPU frequency is changed. This
> > > devfreq driver register with the cpu notifier and scale the Cache
> > > based on the max Freq across all core as the CPU cache is shared across
> > > all of them. If provided this also scale the voltage of the regulator
> > > attached to the CPU cache. The scaling logic is based on the CPU freq
> > > and the 3 scaling interval are set by the device dts.
> > >
> >
> > I have raised this concern before. I am worried this kind of independent
> > CPU and cache frequency controls make way for clkscrew kind of attacks.
> > Why can't the clocks be made parent/child or secondary and automatically
> > updated when CPU clocks are changed.
> >
>
> I don't think I understand this fully. Anyway about the clkscrew attack, the
> range are set on the dts so unless someone actually wants to have a
> vulnerable system, the range can't be changes at runtime. The devfreq
> governor is set to immutable and can't be changes AFAIK.
>

I don't think that matters, we are talking about Secure/Non-secure boundary
here. DT can be modified or simple a rogue devfreq module can do all the
bad things.

> About 'automatically updated when CPU changes', the cache is shared across 2
> core and they scale independently. We can be in situation where one cpu is
> at max and one at idle freq and the cache is set to idle. To fix this at
> every change the clk should find the max value and I think this would make
> all the clk scaling very slow.

This sounds like we are going back to coupled idle states kind of setup.
Sorry we don't want those anymore.

> If you have any suggestion on how I can implement this better, I'm
> more than happy to address them. For now, the lack of this kind of cache
> scale, make the system really slow since by default the init of the cpu and
> cache clks put them at the lowest frequency and nobody changes that.
> (we have cpufreq scaling support but the cache is never actually scaled)

As I mentioned, if this needs to be done in OSPM, then hide it in the clock
building right dependencies. Clk will even have refcount so that one idle
CPU won't bring the cache down to idle frequency.

--
Regards,
Sudeep
