Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 896211EACD
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2019 11:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbfEOJRF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 May 2019 05:17:05 -0400
Received: from foss.arm.com ([217.140.101.70]:38820 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfEOJRF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 May 2019 05:17:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B06D341;
        Wed, 15 May 2019 02:17:05 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA3A53F703;
        Wed, 15 May 2019 02:17:02 -0700 (PDT)
Date:   Wed, 15 May 2019 10:17:01 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        will.deacon@arm.com, catalin.marinas@arm.com,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/3] PM / EM: Expose perf domain struct
Message-ID: <20190515091658.sbpg6qiovhtblqyr@queper01-lin>
References: <20190515082318.7993-1-quentin.perret@arm.com>
 <20190515082318.7993-3-quentin.perret@arm.com>
 <0ced18eb-e424-fe6b-b11e-165a3c108170@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ced18eb-e424-fe6b-b11e-165a3c108170@linaro.org>
User-Agent: NeoMutt/20171215
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On Wednesday 15 May 2019 at 11:06:18 (+0200), Daniel Lezcano wrote:
> On 15/05/2019 10:23, Quentin Perret wrote:
> > In the current state, the perf_domain struct is fully defined only when
> > CONFIG_ENERGY_MODEL=y. Since we need to write code that compiles both
> > with or without that option in the thermal framework, make sure to
> > actually define the struct regardless of the config option. That allows
> > to avoid using stubbed accessor functions all the time in code paths
> > that use the EM.
> > 
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> 
> This patch implies the cpu cooling device can be set without the energy
> model.
> 
> Isn't it possible to make a strong dependency for the cpu cooling device
> on the energy model option, add the energy model as default on arm arch
> and drop this patch?

Right, that should work too.

> After all, the cpu cooling is using the em framework.

The reason I did it that way is simply to keep things flexible. If you
don't compile in THERMAL_GOV_POWER_ALLOCATOR, you will never use the EM
for CPU thermal. So I thought it would be good to not mandate compiling
in ENERGY_MODEL in this case -- that should save a bit of space.

But TBH I don't have a strong opinion on this one, so if everybody
agrees it's fine to just make CPU_THERMAL depend on ENERGY_MODEL, I'm
happy to drop this patch and fix patch 3/3. That would indeed simplify
things a bit.

Thanks,
Quentin
