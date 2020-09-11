Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61811265951
	for <lists+linux-pm@lfdr.de>; Fri, 11 Sep 2020 08:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbgIKG0Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Sep 2020 02:26:16 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:27883 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgIKG0L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Sep 2020 02:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1599805566;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=CF/ETIHu0AnzErbledea+ydMrjTVcALretUs6XsCpHk=;
        b=qw4fiFJnlUxSmQX6PGzgrK6OBukeKh2cfv8LdkDSXgypneKxRsScua4o7NxeReK75F
        eg//vObzdcN8UFmruC82YgxZxOPdf6mEEBKS8PumpwhlzL5YzW2RS7qPYDh6jL4/L5i4
        yJ0xl0nQsRacpqUCOOdbyLVKUtTn9DeW4a49g4PpTnM0KUIV+yJLKGn54Snz60Ehuqb4
        RKV8eRakDWOIQnHckaHoMUhmMGKGYl53130FW09BwvsHW2vvdaiCaPmcIHjmfasPndN+
        nRR07NlIbJYGaaXAcmEKjw4RVfwnXk/ljJnmL6UIVH8G9kvtcePIY2VXuArMBPjGQ9LT
        jmfA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEIdhPgVC7iy9yGr7ESbX"
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id g0b6c1w8B6Q6L29
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 11 Sep 2020 08:26:06 +0200 (CEST)
Date:   Fri, 11 Sep 2020 08:26:02 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: Qcom clock performance votes on mainline
Message-ID: <20200911062602.GA2827@gerhold.net>
References: <20200910162610.GA7008@gerhold.net>
 <159977328190.2295844.1029544710226353839@swboyd.mtv.corp.google.com>
 <20200911054844.GA1193@gerhold.net>
 <20200911060556.bntj3s74je75orel@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911060556.bntj3s74je75orel@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 11, 2020 at 11:35:56AM +0530, Viresh Kumar wrote:
> On 11-09-20, 07:48, Stephan Gerhold wrote:
> > On Thu, Sep 10, 2020 at 02:28:01PM -0700, Stephen Boyd wrote:
> > > Quoting Stephan Gerhold (2020-09-10 09:26:10)
> > > > Hi Stephen, Hi Rajendra,
> > > > 
> > > > while working on some MSM8916 things I've been staring at the downstream
> > > > clock-gcc-8916.c [1] driver a bit. One thing that confuses me are the
> > > > voltage/performance state votes that are made for certain clocks within
> > > > the driver. Specifically lines like
> > > > 
> > > >     VDD_DIG_FMAX_MAP2(LOW, 32000000, NOMINAL, 64000000),
> > > > 
> > > > on certain clocks like UART, I2C or SPI. There does not seem to be
> > > > anything equivalent in the mainline clock driver at the moment.
> > > > 
> > > > As far as I understand from related discussions on mailing lists [2],
> > > > these performance votes are not supposed to be added to the clock
> > > > driver(s), but rather as required-opps within OPP tables of all the
> > > > consumers. Is that correct?
> > > 
> > > Yes.
> > > 
> > > > 
> > > > As a second question, I'm wondering about one particular case:
> > > > I've been trying to get CPR / all the CPU frequencies working on MSM8916.
> > > > For that, I already added performance state votes for VDDMX and CPR as
> > > > required-opps to the CPU OPP table.
> > > > 
> > > > After a recent discussion [3] with Viresh about where to enable power
> > > > domains managed by the OPP core, I've been looking at all the
> > > > performance state votes made in the downstream kernel again.
> > > > 
> > > > Actually, the A53 PLL used for the higher CPU frequencies also has such
> > > > voltage/performance state votes. The downstream driver declares the
> > > > clock like [4]:
> > > > 
> > > >                 .vdd_class = &vdd_sr2_pll,
> > > >                 .fmax = (unsigned long [VDD_SR2_PLL_NUM]) {
> > > >                         [VDD_SR2_PLL_SVS] = 1000000000,
> > > >                         [VDD_SR2_PLL_NOM] = 1900000000,
> > > >                 },
> > > >                 .num_fmax = VDD_SR2_PLL_NUM,
> > > > 
> > > > which ends up as votes for the VDDCX power domain.
> > > > 
> > > > Now I'm wondering: Where should I make these votes on mainline?
> > > > Should I add it as yet another required-opps to the CPU OPP table?
> > > 
> > > Sounds like the right approach.
> > > 
> > 
> > Thanks for the quick reply!
> > 
> > > > 
> > > > It would be a bit of a special case because these votes are only done
> > > > for the A53 PLL (which is only used for the higher CPU frequencies, not
> > > > the lower ones)...
> > > 
> > > Can that be put into the OPP table somehow for only the high
> > > frequencies? The OPP tables for CPUs sometimes cover the CPU PLL voltage
> > > requirements too so it doesn't seem like a totally bad idea.
> 
> Maybe we can allow the vote value to be 0 somehow ?
> 

Yep, I tried using an extra opp-level = <0> OPP for that in [1].
It does not work at the moment but maybe we can (somehow) add support
for that. I have some more thoughts about where/how to enable the power
domains from the OPP core in this case. The discussion probably fits
better to the other mail thread so I will reply there later.

Thanks!
Stephan

[1]: https://lore.kernel.org/linux-pm/20200828095706.GA1865@gerhold.net/
