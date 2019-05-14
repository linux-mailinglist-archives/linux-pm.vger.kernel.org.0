Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 778E71C3B3
	for <lists+linux-pm@lfdr.de>; Tue, 14 May 2019 09:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfENHPT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 May 2019 03:15:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49368 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfENHPT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 May 2019 03:15:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6184374;
        Tue, 14 May 2019 00:15:18 -0700 (PDT)
Received: from queper01-ThinkPad-T460s (unknown [10.37.8.231])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23D5F3F71E;
        Tue, 14 May 2019 00:15:14 -0700 (PDT)
Date:   Tue, 14 May 2019 08:15:08 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        will.deacon@arm.com, catalin.marinas@arm.com,
        daniel.lezcano@linaro.org, dietmar.eggemann@arm.com,
        ionela.voinescu@arm.com, mka@chromium.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/3] thermal: cpu_cooling: Migrate to using the EM
 framework
Message-ID: <20190514071506.ykjg67elsydaehlz@queper01-ThinkPad-T460s>
References: <20190503094409.3499-1-quentin.perret@arm.com>
 <20190503094409.3499-4-quentin.perret@arm.com>
 <20190514034056.GA5621@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514034056.GA5621@localhost.localdomain>
User-Agent: NeoMutt/20171215
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Eduardo,

On Monday 13 May 2019 at 20:40:59 (-0700), Eduardo Valentin wrote:
> On Fri, May 03, 2019 at 10:44:09AM +0100, Quentin Perret wrote:
> > The newly introduced Energy Model framework manages power cost tables in
> > a generic way. Moreover, it supports a several types of models since the
> > tables can come from DT or firmware (through SCMI) for example. On the
> > other hand, the cpu_cooling subsystem manages its own power cost tables
> > using only DT data.
> > 
> > In order to avoid the duplication of data in the kernel, and in order to
> > enable IPA with EMs coming from more than just DT, remove the private
> > tables from cpu_cooling.c and migrate it to using the centralized EM
> > framework.
> > 
> > The case where the thermal subsystem is used without an Energy Model
> > (cpufreq_cooling_ops) is handled by looking directly at CPUFreq's
> > frequency table which is already a dependency for cpu_cooling.c anyway.
> > Since the thermal framework expects the cooling states in a particular
> > order, bail out whenever the CPUFreq table is unsorted, since that is
> > fairly uncommon in general, and there are currently no users of
> > cpu_cooling for this use-case.
> 
> Will this break DT in any way? After this change, are the existing DTs
> still compatible with this cpu cooling?

Yes, all existing DTs stay compatible with this CPU cooling. The EM can
still be built using the 'dynamic-power-coefficient' DT property thanks
to the recently introduced dev_pm_opp_of_register_em() helper, see
a4f342b9607d ("PM / OPP: Introduce a power estimation helper"). And all
relevant cpufreq drivers have already been updated to use that function.

So, this patch should cause no functional change for all existing users.
It's really just plumbing. I can probably explain that better in this
commit message rather than the cover letter if you feel it is necessary.

Thanks,
Quentin
