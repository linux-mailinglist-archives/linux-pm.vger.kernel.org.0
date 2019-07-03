Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 304115EF1B
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2019 00:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfGCWUY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 18:20:24 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:32768 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfGCWUY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jul 2019 18:20:24 -0400
Received: by mail-oi1-f196.google.com with SMTP id u15so3414990oiv.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2019 15:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O7/9B62uc/L5qzEpOlYgng1H+GtGyObr1QSwY1wY924=;
        b=LgzayCaK4/bJPs+LnptjE/uYgOn0AYy9YP8QsFOXetvhFp6PktTBIYpERPnEMccqw/
         F1fxlXEJal/rlaLngJpSEAH+OPk57egaRsUomkOujZB63fQgtbEVPjg1obnFPg5OmZkc
         koYNaezbHytFC004biKiJPO7tmp6xlo+d6yf/TV3yivkVwAyWokHrYL0sWtFJI0UV1ma
         2U2OXd7oY5NPFmqb2kDsGByO6gTTJuYdIKrYEFY1UuBLTppQ/7mpOvqrrP6KXyhaTJQS
         itfNBIRCPl7CrxuBzPdbi/g05aoK7NqGLVSnyd/doGaAa1Xylr3e008FKvnyFP7ZVrAH
         o7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O7/9B62uc/L5qzEpOlYgng1H+GtGyObr1QSwY1wY924=;
        b=QBY0StnXhxi2wo6w6J9SOgUKk1e5W23WuzMg7K/Q6ZI+T1DQRjipfrMTbXh19ifmn9
         D1bD4VccrvIuG5B3DArr13yvtO0/MjabxIs6vFnQeta4fVZ9jTD4VQy3I2+Kzw/9PSL2
         p1cIN24TdkSkwhQm2NfYvm+Hwy1ifS5E+/LP6TNnhlqhFWXU3LPbW0FH+tL8UTjZr09f
         48qnxqlxe4cWlfO4Hbx52n8wH28lQJ/2Fc4lih4bmF9XblObm/0BWxHrzoiSyeU9AVhn
         +U4Ht4yTxT5LbJ3HeokYXeVOoj+t38xFEyJoMB6v/0m+cq710My8VVrfIAf+RM/gsoAA
         NApA==
X-Gm-Message-State: APjAAAVZ+31c4LG3ptJiw81uGb4tXYyGAbfi6s0hRuKwuYcZQLpXomjB
        c6wCS42MwAIPi2Fp9rVDdui3Nq0d/J2ookIAA5gjYA==
X-Google-Smtp-Source: APXvYqwtqi+7I3cUQZdtfk+VvNqZfrr4viWaCwyTmLtX0L7p8OC6XQF6CN592Tn8e3dkroxZHwBppYTQgEEUreRy63g=
X-Received: by 2002:aca:6104:: with SMTP id v4mr499588oib.172.1562192423027;
 Wed, 03 Jul 2019 15:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561707104.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1561707104.git.leonard.crestez@nxp.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 3 Jul 2019 15:19:46 -0700
Message-ID: <CAGETcx_63KnP75qySbhX_P_=o4=ox9J8AsBqKsFHeQRjCpSeJA@mail.gmail.com>
Subject: Re: [RFCv2 0/8] Add imx8mm bus frequency switching
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de,
        linux-imx@nxp.com, Linux PM <linux-pm@vger.kernel.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Leonard,

On Fri, Jun 28, 2019 at 12:40 AM Leonard Crestez
<leonard.crestez@nxp.com> wrote:
>
> This series attempts to add upstream DVFS support for imx8mm, covering dynamic
> scaling of internal buses and dram. It uses the interconnect framework for
> proactive scaling (in response to explicit bandwidth requests from devices) and
> devfreq in order expose the buses and eventually implement reactive scaling (in
> response to measuredtraffic).

I'm assuming you took a glance at my patch series [1] adding BW OPP
tables and adding devfreq support for scaling interconnect paths.

Based on looking at your patch series, I think [1] would allow you to
use ICC framework for both proactive and reactive scaling. Proactive
scaling would use the ICC framework directly. Reactive scaling would
go through devfreq (so that you can use various governors/adjust
policy) before it goes to ICC framework.

> Actual scaling is performed through the clk framework: The NOC and main NICs
> are driven by composite clks and a new 'imx8m-dram' clk is included for
> scaling dram using firmware calls.

Seems reasonable. All hardware block in the end run using a clock.

> The interconnect and devfreq parts do not communicate explicitly: they both
> just call clk_set_min_rate and the clk core picks the minimum value that can
> satisfy both. They are thus completely independent.

Two different parts not talking to each other and just setting min
rate can cause problems for some concurrency use cases. ICC framework
is explicitly designed to handle cases like this and aggregate the
needs correctly. You might want to look into that more closely.

> This is easily extensible to more members of the imx8m family, some of which
> expose more detailed controls over interconnect fabric frequencies.
>
> TODO:
> * Clarify DT bindings
> * Clarify interconnect OPP picking logic
> * Implement devfreq_event for imx8m ddrc
> * Expose more dram frequencies
>
> The clk_set_min_rate approach does not mesh very well with the OPP framework.
> Some of interconnect nodes on imx8m can run at different voltages: OPP can
> handle this well but not in response to a clk_set_min_rate from an unrelated
> subsystem. Maybe set voltage on a clk notifier?

I think if you design it something like below, it might make your life
a whole lot easier.
Hopefully the formatting looks okay on your end. The arrow going up is
just connecting devfreq to ICC.

                        Proactive -> ICC -> clk/OPP API to set freq/volt
                                      ^
                                      |
HW measure -> governor -> devfreq ----+

That way, all voltage/frequency requirements are managed cleanly by
clk/OPP frameworks. The ICC deals with aggregating all the
requirements and devfreq lets you handle reactive scaling and policy.

And in the beginning, while you get a governor going, you can use
"performance" governor for the "reactive scaling" users. That way,
your reactive paths will continue to have good performance while the
rest of the "proactive" clients change to use ICC APIs.

> Vendor tree does not support voltage switching, independent freqs for
> different parts of the fabric or any reactive scaling. I think it's important
> to pick an upstreaming approach which can support as much as possible.
>
> Feedback welcome.

If all of this makes sense, please take a look at [2] and provide your
thoughts. I've dropped a few patches from [1] to avoid confusion (too
much going on at once). I think BW OPP tables and having OPP tables
for interconnect paths will be something you'll need (if not now,
eventually) and something you can build on top of nicely.

Thanks,
Saravana

[1] - https://lore.kernel.org/lkml/20190614041733.120807-1-saravanak@google.com/
[2] - https://lore.kernel.org/lkml/20190703011020.151615-1-saravanak@google.com/



> Some objections were apparently raised to doing DRAM switch inside CLK:
> perhaps ICC should make min_freq requests to devfreq instead?
>
> Link to v1 (multiple chunks):
>  * https://patchwork.kernel.org/patch/10976897/
>  * https://patchwork.kernel.org/patch/10968303/
>  * https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=91251
>
> Also as a github branch (with few other changes):
>     https://github.com/cdleonard/linux/tree/next_imx8mm_busfreq
>
> Alexandre Bailon (2):
>   interconnect: Add generic driver for imx
>   interconnect: imx: Add platform driver for imx8mm
>
> Leonard Crestez (6):
>   clk: imx8mm: Add dram freq switch support
>   clk: imx8m-composite: Switch to determine_rate
>   arm64: dts: imx8mm: Add dram dvfs irqs to ccm node
>   devfreq: Add imx-devfreq driver
>   arm64: dts: imx8mm: Add interconnect node
>   arm64: dts: imx8mm: Add devfreq-imx nodes
>
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi |  73 +++
>  drivers/clk/imx/Makefile                  |   1 +
>  drivers/clk/imx/clk-composite-8m.c        |  34 +-
>  drivers/clk/imx/clk-imx8m-dram.c          | 357 ++++++++++++
>  drivers/clk/imx/clk-imx8mm.c              |  12 +
>  drivers/clk/imx/clk.h                     |  13 +
>  drivers/devfreq/Kconfig                   |  10 +
>  drivers/devfreq/Makefile                  |   1 +
>  drivers/devfreq/imx-devfreq.c             | 142 +++++
>  drivers/interconnect/Kconfig              |   1 +
>  drivers/interconnect/Makefile             |   1 +
>  drivers/interconnect/imx/Kconfig          |  17 +
>  drivers/interconnect/imx/Makefile         |   2 +
>  drivers/interconnect/imx/busfreq-imx8mm.c | 151 ++++++
>  drivers/interconnect/imx/busfreq.c        | 628 ++++++++++++++++++++++
>  drivers/interconnect/imx/busfreq.h        | 123 +++++
>  include/dt-bindings/clock/imx8mm-clock.h  |   4 +-
>  include/dt-bindings/interconnect/imx8mm.h |  49 ++
>  18 files changed, 1606 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/clk/imx/clk-imx8m-dram.c
>  create mode 100644 drivers/devfreq/imx-devfreq.c
>  create mode 100644 drivers/interconnect/imx/Kconfig
>  create mode 100644 drivers/interconnect/imx/Makefile
>  create mode 100644 drivers/interconnect/imx/busfreq-imx8mm.c
>  create mode 100644 drivers/interconnect/imx/busfreq.c
>  create mode 100644 drivers/interconnect/imx/busfreq.h
>  create mode 100644 include/dt-bindings/interconnect/imx8mm.h
>
> --
> 2.17.1
>
