Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE272649CC
	for <lists+linux-pm@lfdr.de>; Thu, 10 Sep 2020 18:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgIJQbz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Sep 2020 12:31:55 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:28205 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgIJQ0Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2020 12:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1599755174;
        s=strato-dkim-0002; d=gerhold.net;
        h=Message-ID:Subject:Cc:To:From:Date:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=j4d59Y0kBRiNJToFL0y0NnSJVvNdlrKiKeGoVArTf0s=;
        b=HIA+ZBYA574Emlou3jF1jYGgRGfLuaARiCzmLG5hEsjNclTbbG+yL9/tpa9RzQticQ
        HHxlevd93LFFM+gOTsd09oke69aN22+OIk5SAGaircSe+vs8oORzzOc0azFLMXlBnRYr
        Bk8z6blmF1M5nOKcM6hayOtocGHneO6u4nw5jK+249lgeiMcLI79OR632fAKX2g9NH4a
        N4oPW04bV96nV66BFfMQ01TiOMwR0qHT0Lre3laEp7pKbDmHf3meEV2utV439zIxTQYy
        5t2DD2mm9fbWk56pen56iPZfqwe1VeO0/1ZiD6OEoSves6Ubyu2zaYaSMs8UR0s+hBwY
        NYDg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEIdhPgVC7iy9yGr7ESbX"
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id g0b6c1w8AGQDJN6
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 10 Sep 2020 18:26:13 +0200 (CEST)
Date:   Thu, 10 Sep 2020 18:26:10 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Stephen Boyd <swboyd@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Qcom clock performance votes on mainline
Message-ID: <20200910162610.GA7008@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Stephen, Hi Rajendra,

while working on some MSM8916 things I've been staring at the downstream
clock-gcc-8916.c [1] driver a bit. One thing that confuses me are the
voltage/performance state votes that are made for certain clocks within
the driver. Specifically lines like

    VDD_DIG_FMAX_MAP2(LOW, 32000000, NOMINAL, 64000000),

on certain clocks like UART, I2C or SPI. There does not seem to be
anything equivalent in the mainline clock driver at the moment.

As far as I understand from related discussions on mailing lists [2],
these performance votes are not supposed to be added to the clock
driver(s), but rather as required-opps within OPP tables of all the
consumers. Is that correct?

As a second question, I'm wondering about one particular case:
I've been trying to get CPR / all the CPU frequencies working on MSM8916.
For that, I already added performance state votes for VDDMX and CPR as
required-opps to the CPU OPP table.

After a recent discussion [3] with Viresh about where to enable power
domains managed by the OPP core, I've been looking at all the
performance state votes made in the downstream kernel again.

Actually, the A53 PLL used for the higher CPU frequencies also has such
voltage/performance state votes. The downstream driver declares the
clock like [4]:

		.vdd_class = &vdd_sr2_pll,
		.fmax = (unsigned long [VDD_SR2_PLL_NUM]) {
			[VDD_SR2_PLL_SVS] = 1000000000,
			[VDD_SR2_PLL_NOM] = 1900000000,
		},
		.num_fmax = VDD_SR2_PLL_NUM,

which ends up as votes for the VDDCX power domain.

Now I'm wondering: Where should I make these votes on mainline?
Should I add it as yet another required-opps to the CPU OPP table?

It would be a bit of a special case because these votes are only done
for the A53 PLL (which is only used for the higher CPU frequencies, not
the lower ones)...

Thanks in advance!
Stephan

[1]: https://source.codeaurora.org/quic/la/kernel/msm-3.10/tree/drivers/clk/qcom/clock-gcc-8916.c?h=LA.BR.1.2.9.1-02310-8x16.0
[2]: https://lore.kernel.org/linux-arm-msm/20190129015547.213276-1-swboyd@chromium.org/
[3]: https://lore.kernel.org/linux-pm/20200826093328.88268-1-stephan@gerhold.net/
[4]: https://source.codeaurora.org/quic/la/kernel/msm-3.10/tree/drivers/clk/qcom/clock-gcc-8916.c?h=LA.BR.1.2.9.1-02310-8x16.0#n354
