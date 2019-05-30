Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5DE02FAE2
	for <lists+linux-pm@lfdr.de>; Thu, 30 May 2019 13:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfE3L1y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 May 2019 07:27:54 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34640 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbfE3L1y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 May 2019 07:27:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD97E374;
        Thu, 30 May 2019 04:27:53 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C3FE3F5AF;
        Thu, 30 May 2019 04:27:51 -0700 (PDT)
Date:   Thu, 30 May 2019 12:27:49 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        will.deacon@arm.com, catalin.marinas@arm.com,
        daniel.lezcano@linaro.org, dietmar.eggemann@arm.com,
        ionela.voinescu@arm.com, mka@chromium.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 3/3] thermal: cpu_cooling: Migrate to using the EM
 framework
Message-ID: <20190530112747.nlfyctzjkz5lak7o@queper01-lin>
References: <20190530092038.12020-1-quentin.perret@arm.com>
 <20190530092038.12020-4-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530092038.12020-4-quentin.perret@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday 30 May 2019 at 10:20:38 (+0100), Quentin Perret wrote:
> The newly introduced Energy Model framework manages power cost tables in
> a generic way. Moreover, it supports several types of models since the
> tables can come from DT or firmware (through SCMI) for example. On the
> other hand, the cpu_cooling subsystem manages its own power cost tables
> using only DT data.
> 
> In order to avoid the duplication of data in the kernel, and in order to
> enable IPA with EMs coming from more than just DT, remove the private
> tables from cpu_cooling.c and migrate it to using the centralized EM
> framework. Doing so should have no visible functional impact for
> existing users of IPA since:
> 
>  - recent extenstions to the the PM_OPP infrastructure enable the
>    registration of EMs in PM_EM using the DT property used by IPA;
> 
>  - the existing upstream cpufreq drivers marked with the
>    'CPUFREQ_IS_COOLING_DEV' flag all use the aforementioned PM_OPP
>    infrastructure, which means they all support PM_EM. The only two
>    exceptions are qoriq-cpufreq which doesn't in fact use an EM and
>    scmi-cpufreq which doesn't use DT for power costs.
> 
> For existing users of cpu_cooling, PM_EM tables will contain the exact
> same power values that IPA used to compute on its own until now. The
> only new dependency for them is to compile in CONFIG_ENERGY_MODEL.
> 
> The case where the thermal subsystem is used without an Energy Model
> (cpufreq_cooling_ops) is handled by looking directly at CPUFreq's
> frequency table which is already a dependency for cpu_cooling.c anyway.
> Since the thermal framework expects the cooling states in a particular
> order, bail out whenever the CPUFreq table is unsorted, since that is
> fairly uncommon in general, and there are currently no users of
> cpu_cooling for this use-case.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Viresh: the patch hasn't changed much so I kept this, but please shout
if you're not happy with the new version :-)

Thanks,
Quentin
