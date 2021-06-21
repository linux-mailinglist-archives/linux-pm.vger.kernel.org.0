Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14EB93AF1F3
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 19:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhFUR3w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 13:29:52 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:24017 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhFUR3v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 13:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1624296453;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=hsoDzzu1giOUqa3P8ZG9xhIVsUbaKTxcoPkDydr9XUE=;
    b=GG0/r58gjUrXQfLQIh12mBCr+dpsIrAbC+/V2pwvptkCAvfby4flylTQQj15jaUYt/
    93NNO47vgyKw0PMhKQKhBqD0AenTUSpDWmtMAW1nOxvBHf9LR5IU+hSmvQIRgIoU+Mlk
    0s579J5DuCP64Esn1aR0FSjb7rYd1KgV2sN0JgQm/jmubIXjOLtra/+1XD3YLlPk9ApL
    v16iiviubTuATS1xaGW6lZH79B7y0s7sVi4TffpkP9qUybH8/CJO6Avps9iq4vRobj3A
    BwGMloy5ZkElP8NDpap7r1LVDEkSHbYN5rAXcoleYWuo8mdC5FEOLkqXXF/2vQAwBYR6
    6IwA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8f7Ic/Baoo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.27.3 DYNA|AUTH)
    with ESMTPSA id 000885x5LHRWLZF
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 21 Jun 2021 19:27:32 +0200 (CEST)
Date:   Mon, 21 Jun 2021 19:27:27 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com,
        jamipkettunen@somainline.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v5 1/3] cpuidle: qcom_spm: Detach state machine from main
 SPM handling
Message-ID: <YNDL/yLanerZ4hM9@gerhold.net>
References: <20210618225620.623359-1-angelogioacchino.delregno@somainline.org>
 <20210618225620.623359-2-angelogioacchino.delregno@somainline.org>
 <YNB92Dkx5MNg64m+@gerhold.net>
 <08c80c7d-638f-23e9-e580-bced3648a635@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08c80c7d-638f-23e9-e580-bced3648a635@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 21, 2021 at 06:12:06PM +0200, AngeloGioacchino Del Regno wrote:
> Il 21/06/21 13:54, Stephan Gerhold ha scritto:
> > On Sat, Jun 19, 2021 at 12:56:18AM +0200, AngeloGioacchino Del Regno wrote:
> > > In commit a871be6b8eee ("cpuidle: Convert Qualcomm SPM driver to a generic
> > > CPUidle driver") the SPM driver has been converted to a
> > > generic CPUidle driver: that was mainly made to simplify the
> > > driver and that was a great accomplishment;
> > > Though, it was ignored that the SPM driver is not used only
> > > on the ARM architecture.
> > > 
> > 
> > Can you please reword this sentence like I suggested in v4? The way you
> > write it at the moment it sounds like this fixes a regression, but
> > actually it extends the driver to cover more use cases.
> > 
> 
> I don't see any regression implied: I'm explaining the reason of this
> change just one line after that and .. besides that, I haven't put any
> "Fixes:" tag to this commit.
> When you fix regressions, bad behavior, or anything else relative to a
> patch, you add that tag to say that you're fixing something.
> 
> Moreover, I can't see anything wrong in the description for this change,
> nor anything to clarify about it and that as long as you read it in full
> 

I don't really want to get into a long discussion about a single
sentence here but the sentence just doesn't make any sense to me:

  1. You say that I "ignored" something in my commit, which isn't the case.
  2. The mainline "SPM driver" *is* only used on ARM*32* at the moment.
     (This is something you want to change in this patch series!)

To me that sentence suggests the "SPM driver" already had support for
ARM64/your use case and I *deliberately* ignored that while converting
the driver to a direct CPU Idle driver.

I'm merely suggesting making the situation a bit more clear by replacing

> > > Though, it was ignored that the SPM driver is not used only
> > > on the ARM architecture.

with something like:
"However, on newer ARM64 SoCs the SPM hardware is used for purposes
other than CPUIdle."

> > > In preparation for the enablement of SPM features on AArch64/ARM64,
> > > split the cpuidle-qcom-spm driver in two: the CPUIdle related
> > > state machine (currently used only on ARM SoCs) stays there, while
> > > the SPM communication handling lands back in soc/qcom/spm.c and
> > > also making sure to not discard the simplifications that were
> > > introduced in the aforementioned commit.
> > > 
> > > Since now the "two drivers" are split, the SCM dependency in the
> > > main SPM handling is gone and for this reason it was also possible
> > > to move the SPM initialization early: this will also make sure that
> > > whenever the SAW CPUIdle driver is getting initialized, the SPM
> > > driver will be ready to do the job.
> > > 
> > > Please note that the anticipation of the SPM initialization was
> > > also done to optimize the boot times on platforms that have their
> > > CPU/L2 idle states managed by other means (such as PSCI), while
> > > needing SAW initialization for other purposes, like AVS control.
> > > 
> > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> > > ---
> > >   drivers/cpuidle/Kconfig.arm        |   1 +
> > >   drivers/cpuidle/cpuidle-qcom-spm.c | 295 ++++++-----------------------
> > >   drivers/soc/qcom/Kconfig           |   9 +
> > >   drivers/soc/qcom/Makefile          |   1 +
> > >   drivers/soc/qcom/spm.c             | 198 +++++++++++++++++++
> > >   include/soc/qcom/spm.h             |  43 +++++
> > >   6 files changed, 311 insertions(+), 236 deletions(-)
> > >   create mode 100644 drivers/soc/qcom/spm.c
> > >   create mode 100644 include/soc/qcom/spm.h
> > > 
> > > [...]
> > > diff --git a/include/soc/qcom/spm.h b/include/soc/qcom/spm.h
> > > new file mode 100644
> > > index 000000000000..719c604a8402
> > > --- /dev/null
> > > +++ b/include/soc/qcom/spm.h
> > > @@ -0,0 +1,43 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/*
> > > + * Copyright (c) 2011-2014, The Linux Foundation. All rights reserved.
> > > + * Copyright (c) 2014,2015, Linaro Ltd.
> > > + * Copyright (C) 2021, AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> > > + */
> > > +
> > > +#ifndef __SPM_H__
> > > +#define __SPM_H__
> > > +
> > > +#include <linux/cpuidle.h>
> > > +
> > > +#define MAX_PMIC_DATA		2
> > > +#define MAX_SEQ_DATA		64
> > > +
> > > +enum pm_sleep_mode {
> > > +	PM_SLEEP_MODE_STBY,
> > > +	PM_SLEEP_MODE_RET,
> > > +	PM_SLEEP_MODE_SPC,
> > > +	PM_SLEEP_MODE_PC,
> > > +	PM_SLEEP_MODE_NR,
> > > +};
> > > +
> > > +struct spm_reg_data {
> > > +	const u8 *reg_offset;
> > > +	u32 spm_cfg;
> > > +	u32 spm_dly;
> > > +	u32 pmic_dly;
> > > +	u32 pmic_data[MAX_PMIC_DATA];
> > > +	u8 seq[MAX_SEQ_DATA];
> > > +	u8 start_index[PM_SLEEP_MODE_NR];
> > > +};
> > > +
> > > +struct spm_driver_data {
> > > +	struct cpuidle_driver cpuidle_driver;
> > 
> > Given that the SPM hardware seems to have several different uses,
> > not just CPUidle, wouldn't it be better to allocate the memory for the
> > cpuidle_driver from cpuidle-qcom-spm.c? Just devm_kzalloc() something
> > like:
> > 
> > struct spm_cpuidle_driver {
> > 	struct cpuidle_driver cpuidle_driver;
> > 	struct spm_driver_data *spm;
> > };
> > 
> > in cpuidle-qcom-spm.c.
> > 
> > And then there wouldn't be a need to have the implementation details of
> > the SPM driver in the spm.h header, all that cpuidle-qcom-spm needs is
> > 
> > struct spm_driver_data;
> > 
> > enum pm_sleep_mode {
> > 	PM_SLEEP_MODE_STBY,
> > 	PM_SLEEP_MODE_RET,
> > 	PM_SLEEP_MODE_SPC,
> > 	PM_SLEEP_MODE_PC,
> > 	PM_SLEEP_MODE_NR,
> > };
> > 
> > void spm_set_low_power_mode(struct spm_driver_data *drv,
> > 			    enum pm_sleep_mode mode);
> > 
> > Everything else can remain private to the spm.c driver,
> > like it was before.
> > 
> 
> I don't completely dislike the approach but I honestly think that this
> would put some cognitive strain: having a header included in two files
> using "things" defined in there gives people an easy path to follow
> when looking at one of the two files.
> 

OK, I guess this is personal preference. I don't really mind if you keep
the structs defined in the shared header...

> Regarding the addition of that one more structure... I am seriously
> undecided on the matter: wasting this kind of amount of memory on a
> ARM64 platform (usually having more than 1GB RAM) is completely
> unnoticeable but, on the other hand, it's still a waste of memory,
> even if it's minimal that much.
> 

In my opinion it also makes the two drivers better separated.
The SPM driver manages the SPM hardware and provides functionality to
configure it. The CPU idle driver makes use of that functionality
to implement the CPU idle use case. This does not require the SPM driver
to know how exactly the CPU idle driver looks.

Stephan
