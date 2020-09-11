Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602992658EE
	for <lists+linux-pm@lfdr.de>; Fri, 11 Sep 2020 07:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbgIKFtM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Sep 2020 01:49:12 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:26323 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgIKFtJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Sep 2020 01:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1599803347;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=2cjHccP+BhkZidDT/tFu/1+hsoRQEXZ73Ms8nMnnENI=;
        b=M36wl3HV+xHqS62XmSBaMTCDuhGB40My8Ba+cwqbIGQoYaBuHhQ+IoG18NDtCYm+0u
        +x2CUGQStJPGT+Sy20zfyiTNXLuUQ1wzssoWb9N4HI6UAG3fPCwx/Oi5OC4BYmiSlJVW
        bxHo+pR0w56v5h8lA9ovNMqTAw2LaOfmLvG813rdW9F+lkhAzi3NAAkPzCK291/qsbfl
        xSZXVmIFXqqFQSWf7vvlmCbn4UuWsMsAlERAZB4YJ708YGaLk8sU1uT9NjQCETMBZQ5e
        kGcnhi1cEFfckk0cxrLJhF8ZRF1lfpaOgCX1ZQF2qx0sEz/65AeSRnSNOSTriTHHL2L8
        Ztkw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEIdhPgVC7iy9yGr7ESbX"
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id g0b6c1w8B5n6Ku0
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 11 Sep 2020 07:49:06 +0200 (CEST)
Date:   Fri, 11 Sep 2020 07:48:55 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: Qcom clock performance votes on mainline
Message-ID: <20200911054844.GA1193@gerhold.net>
References: <20200910162610.GA7008@gerhold.net>
 <159977328190.2295844.1029544710226353839@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159977328190.2295844.1029544710226353839@swboyd.mtv.corp.google.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Sep 10, 2020 at 02:28:01PM -0700, Stephen Boyd wrote:
> Quoting Stephan Gerhold (2020-09-10 09:26:10)
> > Hi Stephen, Hi Rajendra,
> > 
> > while working on some MSM8916 things I've been staring at the downstream
> > clock-gcc-8916.c [1] driver a bit. One thing that confuses me are the
> > voltage/performance state votes that are made for certain clocks within
> > the driver. Specifically lines like
> > 
> >     VDD_DIG_FMAX_MAP2(LOW, 32000000, NOMINAL, 64000000),
> > 
> > on certain clocks like UART, I2C or SPI. There does not seem to be
> > anything equivalent in the mainline clock driver at the moment.
> > 
> > As far as I understand from related discussions on mailing lists [2],
> > these performance votes are not supposed to be added to the clock
> > driver(s), but rather as required-opps within OPP tables of all the
> > consumers. Is that correct?
> 
> Yes.
> 
> > 
> > As a second question, I'm wondering about one particular case:
> > I've been trying to get CPR / all the CPU frequencies working on MSM8916.
> > For that, I already added performance state votes for VDDMX and CPR as
> > required-opps to the CPU OPP table.
> > 
> > After a recent discussion [3] with Viresh about where to enable power
> > domains managed by the OPP core, I've been looking at all the
> > performance state votes made in the downstream kernel again.
> > 
> > Actually, the A53 PLL used for the higher CPU frequencies also has such
> > voltage/performance state votes. The downstream driver declares the
> > clock like [4]:
> > 
> >                 .vdd_class = &vdd_sr2_pll,
> >                 .fmax = (unsigned long [VDD_SR2_PLL_NUM]) {
> >                         [VDD_SR2_PLL_SVS] = 1000000000,
> >                         [VDD_SR2_PLL_NOM] = 1900000000,
> >                 },
> >                 .num_fmax = VDD_SR2_PLL_NUM,
> > 
> > which ends up as votes for the VDDCX power domain.
> > 
> > Now I'm wondering: Where should I make these votes on mainline?
> > Should I add it as yet another required-opps to the CPU OPP table?
> 
> Sounds like the right approach.
> 

Thanks for the quick reply!

> > 
> > It would be a bit of a special case because these votes are only done
> > for the A53 PLL (which is only used for the higher CPU frequencies, not
> > the lower ones)...
> 
> Can that be put into the OPP table somehow for only the high
> frequencies? The OPP tables for CPUs sometimes cover the CPU PLL voltage
> requirements too so it doesn't seem like a totally bad idea.

I don't think it's possible at the moment, but actually Viresh mentioned
that use case (scaling a power domain only for some of the OPPs) when we
discussed where to enable the power domains listed in the OPP table [1].

Problem back then was that we didn't have a real example where this
would be needed. It seems like such an example exists now, so I will
discuss ways to implement that with Viresh.

I just wanted to be sure that adding the additional power domain to the
CPU OPP table is the right approach.

Thanks again!
Stephan

[1]: https://lore.kernel.org/linux-pm/20200828063511.y47ofywtu5qo57bq@vireshk-i7/
