Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163A93B03A3
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 14:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhFVMHO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 08:07:14 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:18561 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhFVMHN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 08:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1624363491;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=tFlCvlkIHmrMp6fkyKDmE4jn+KF6IFD94B6cmiuttD0=;
    b=YDXDKeFRGDF+GVyGcDAOWPBbWNeVUIO7C+WOtz5EjsVF5ASgEmBFbLTTqlgvqmRgKR
    VwucomFs/3Rk9pjX06wzuIesGYCyglUruh/ilYD4vXSDogVUvW1bTZrqqbpzqiFQhFO1
    /1+TOmaRCBY1CnM5/cLF/jnAEv086qLLKy2QTZXHtsuS7iejdDwx3LYgiech9XLqNjI7
    YLdju+wEK+QmjOMKOFW8bC5vL5wj0rEG1ngPK7idjYmB0MwXkLUVjU/unaT60d9xmqkQ
    +NAmMyxCXk5jlwyGub+AEPsmhytnEPGC0huw0kawIOF5wC8/OqYYDsNUP2sHdJUkFJut
    QEdg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8f6Ic3FBg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.27.3 DYNA|AUTH)
    with ESMTPSA id 000885x5MC4oQ9L
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 22 Jun 2021 14:04:50 +0200 (CEST)
Date:   Tue, 22 Jun 2021 14:04:46 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com,
        jami.kettunen@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v6 1/5] cpuidle: qcom_spm: Detach state machine from main
 SPM handling
Message-ID: <YNHR3hvoKsQe5mq8@gerhold.net>
References: <20210621181016.365009-1-angelogioacchino.delregno@somainline.org>
 <20210621181016.365009-2-angelogioacchino.delregno@somainline.org>
 <YND/2qJhUB1Iwk1X@gerhold.net>
 <229488fe-00ef-ea7e-27d4-6f24fdea1383@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <229488fe-00ef-ea7e-27d4-6f24fdea1383@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 22, 2021 at 01:39:15PM +0200, AngeloGioacchino Del Regno wrote:
> Il 21/06/21 23:08, Stephan Gerhold ha scritto:
> > On Mon, Jun 21, 2021 at 08:10:12PM +0200, AngeloGioacchino Del Regno wrote:
> > > In commit a871be6b8eee ("cpuidle: Convert Qualcomm SPM driver to a generic
> > > CPUidle driver") the SPM driver has been converted to a
> > > generic CPUidle driver: that was mainly made to simplify the
> > > driver and that was a great accomplishment;
> > > Though, it was ignored that the SPM driver is not used only
> > > on the ARM architecture.
> > > 
> > 
> > I don't really understand why you insist on writing that I deliberately
> > "ignored" your use case when converting the driver. This is not true.
> > Perhaps that's not actually what you meant but that's how it sounds to
> > me.
> > 
> 
> So much noise for one single word. I will change it since it seems to be
> that much of a deal, and I'm sorry if that hurt you in any way.
> 
> For the records, though, I really don't see anything offensive in that,
> and anyway I didn't mean to be offensive in any way.
> 

I try to put a lot of thought into my patches to make sure I don't
accidentally break some other use cases. Having that sentence in the
commit log does indeed hurt me a bit since I would never deliberately
disregard other use cases without making it absolutely clear in the
patch.

By using the word "ignored" ("deliberately not listen or pay attention
to") [1] you say that I did, and that's why I would prefer if you
reword this slightly. :)

[1] https://en.wiktionary.org/wiki/ignore

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
> > >   drivers/cpuidle/cpuidle-qcom-spm.c | 324 +++++++----------------------
> > >   drivers/soc/qcom/Kconfig           |   9 +
> > >   drivers/soc/qcom/Makefile          |   1 +
> > >   drivers/soc/qcom/spm.c             | 198 ++++++++++++++++++
> > >   include/soc/qcom/spm.h             |  41 ++++
> > >   6 files changed, 325 insertions(+), 249 deletions(-)
> > >   create mode 100644 drivers/soc/qcom/spm.c
> > >   create mode 100644 include/soc/qcom/spm.h
> > > 
> > > diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
> > > index adf91a6e4d7d..091453135ea6 100644
> > > --- a/drivers/cpuidle/cpuidle-qcom-spm.c
> > > +++ b/drivers/cpuidle/cpuidle-qcom-spm.c
> > > [...]
> > > +static int spm_cpuidle_register(int cpu)
> > >   {
> > > +	struct platform_device *pdev = NULL;
> > > +	struct device_node *cpu_node, *saw_node;
> > > +	struct cpuidle_qcom_spm_data data = {
> > > +		.cpuidle_driver = {
> > > +			.name = "qcom_spm",
> > > +			.owner = THIS_MODULE,
> > > +			.cpumask = (struct cpumask *)cpumask_of(cpu),
> > > +			.states[0] = {
> > > +				.enter			= spm_enter_idle_state,
> > > +				.exit_latency		= 1,
> > > +				.target_residency	= 1,
> > > +				.power_usage		= UINT_MAX,
> > > +				.name			= "WFI",
> > > +				.desc			= "ARM WFI",
> > > +			}
> > > +		}
> > > +	};
> > 
> > The stack is gone after the function returns.
> > 
> 
> Argh, I wrongly assumed that cpuidle was actually copying this locally.
> Okay, let's see what else looking clean I can come up with.

I guess you could just use a devm_kzalloc() and then have code similar
to the previous one (data->cpuidle_driver = <template>). You could
alternatively use devm_kmalloc() without zero-initialization but the
advantages of that should be negligible.

Thanks!
Stephan
