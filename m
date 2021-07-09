Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCF43C2115
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jul 2021 10:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhGII7u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jul 2021 04:59:50 -0400
Received: from foss.arm.com ([217.140.110.172]:47870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231494AbhGII7t (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Jul 2021 04:59:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 892EEED1;
        Fri,  9 Jul 2021 01:57:06 -0700 (PDT)
Received: from localhost (unknown [10.1.195.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FC0C3F5A1;
        Fri,  9 Jul 2021 01:57:05 -0700 (PDT)
Date:   Fri, 9 Jul 2021 09:57:04 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Kevin Wangtao <kevin.wangtao@hisilicon.com>,
        Leo Yan <leo.yan@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        zhongkaihua@huawei.com, Dmitry Osipenko <digetx@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 03/13] opp: Keep track of currently programmed OPP
Message-ID: <20210709085704.GA10180@arm.com>
References: <cover.1611227342.git.viresh.kumar@linaro.org>
 <96b57316a2a307a5cc5ff7302b3cd0084123a2ed.1611227342.git.viresh.kumar@linaro.org>
 <20210707102410.GA4357@arm.com>
 <20210708075353.ivsuc4y47i6bbhgz@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708075353.ivsuc4y47i6bbhgz@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Thursday 08 Jul 2021 at 13:23:53 (+0530), Viresh Kumar wrote:
> On 07-07-21, 11:24, Ionela Voinescu wrote:
> > Now comes the interesting part: what seems to fix it is a call to
> > clk_get_rate(opp_table->clk) in _set_opp(), which is what basically
> > happened before this patch, as _find_current_opp() was always called.
> > I do not need to do anything with the returned frequency.
> 
> Wow, thanks for narrowing it down this far :)
> 
> I had a quick look and this is what I think is the problem here.
> 
> This platform uses mailbox API to send its frequency change requests to another
> processor.  And the way it is written currently, I don't see any guarantee
> whatsoever which say
> 
>   "once clk_set_rate() returns, the frequency would have already changed".
> 

I think what was strange to me was that the frequency never seems to
change, there isn't just a delay in the new frequency taking effect, as
I would expect in these cases. Or if there is a delay, that's quite large
- at least a second.

> And this may exactly be the thing you are able to hit, luckily because of this
> patchset :)
> 
> As a quick way of checking if that is right or not, this may make it work:
> 
> diff --git a/drivers/mailbox/hi3660-mailbox.c b/drivers/mailbox/hi3660-mailbox.c
> index 395ddc250828..9856c1c84dcf 100644
> --- a/drivers/mailbox/hi3660-mailbox.c
> +++ b/drivers/mailbox/hi3660-mailbox.c
> @@ -201,6 +201,9 @@ static int hi3660_mbox_send_data(struct mbox_chan *chan, void *msg)
> 
>         /* Trigger data transferring */
>         writel(BIT(mchan->ack_irq), base + MBOX_SEND_REG);
> +
> +       hi3660_mbox_check_state(chan);
> +

I gave this a try an it does work for me.

>         return 0;
>  }
> 
> -------------------------8<-------------------------
> 
> As a proper fix, something like this (not even compile tested) is required I
> believe as I don't see the clients would know if the transfer is over. Cc'ing
> mailbox guys to see what can be done.
> 

I'll give this a try as well when there is consensus. I might even try to
review it, if the time allows.

Many thanks,
Ionela.

> diff --git a/drivers/clk/hisilicon/clk-hi3660-stub.c b/drivers/clk/hisilicon/clk-hi3660-stub.c
> index 3a653d54bee0..c1e62ea4cf01 100644
> --- a/drivers/clk/hisilicon/clk-hi3660-stub.c
> +++ b/drivers/clk/hisilicon/clk-hi3660-stub.c
> @@ -89,7 +89,6 @@ static int hi3660_stub_clk_set_rate(struct clk_hw *hw, unsigned long rate,
>                 stub_clk->msg[0], stub_clk->msg[1]);
>  
>         mbox_send_message(stub_clk_chan.mbox, stub_clk->msg);
> -       mbox_client_txdone(stub_clk_chan.mbox, 0);
>  
>         stub_clk->rate = rate;
>         return 0;
> @@ -131,7 +130,7 @@ static int hi3660_stub_clk_probe(struct platform_device *pdev)
>         /* Use mailbox client without blocking */
>         stub_clk_chan.cl.dev = dev;
>         stub_clk_chan.cl.tx_done = NULL;
> -       stub_clk_chan.cl.tx_block = false;
> +       stub_clk_chan.cl.tx_block = true;
>         stub_clk_chan.cl.knows_txdone = false;
>  
>         /* Allocate mailbox channel */
> diff --git a/drivers/mailbox/hi3660-mailbox.c b/drivers/mailbox/hi3660-mailbox.c
> index 395ddc250828..8f6b787c0aba 100644
> --- a/drivers/mailbox/hi3660-mailbox.c
> +++ b/drivers/mailbox/hi3660-mailbox.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -// Copyright (c) 2017-2018 HiSilicon Limited.
> +// Copyright (c) 2017-2018 Hisilicon Limited.
>  // Copyright (c) 2017-2018 Linaro Limited.
>  
>  #include <linux/bitops.h>
> @@ -83,7 +83,7 @@ static struct hi3660_mbox *to_hi3660_mbox(struct mbox_controller *mbox)
>         return container_of(mbox, struct hi3660_mbox, controller);
>  }
>  
> -static int hi3660_mbox_check_state(struct mbox_chan *chan)
> +static bool hi3660_mbox_last_tx_done(struct mbox_chan *chan)
>  {
>         unsigned long ch = (unsigned long)chan->con_priv;
>         struct hi3660_mbox *mbox = to_hi3660_mbox(chan->mbox);
> @@ -94,20 +94,20 @@ static int hi3660_mbox_check_state(struct mbox_chan *chan)
>  
>         /* Mailbox is ready to use */
>         if (readl(base + MBOX_MODE_REG) & MBOX_STATE_READY)
> -               return 0;
> +               return true;
>  
>         /* Wait for acknowledge from remote */
>         ret = readx_poll_timeout_atomic(readl, base + MBOX_MODE_REG,
>                         val, (val & MBOX_STATE_ACK), 1000, 300000);
>         if (ret) {
>                 dev_err(mbox->dev, "%s: timeout for receiving ack\n", __func__);
> -               return ret;
> +               return false;
>         }
>  
>         /* clear ack state, mailbox will get back to ready state */
>         writel(BIT(mchan->ack_irq), base + MBOX_ICLR_REG);
>  
> -       return 0;
> +       return true;
>  }
>  
>  static int hi3660_mbox_unlock(struct mbox_chan *chan)
> @@ -182,10 +182,6 @@ static int hi3660_mbox_send_data(struct mbox_chan *chan, void *msg)
>         unsigned int i;
>         int ret;
>  
> -       ret = hi3660_mbox_check_state(chan);
> -       if (ret)
> -               return ret;
> -
>         /* Clear mask for destination interrupt */
>         writel_relaxed(~BIT(mchan->dst_irq), base + MBOX_IMASK_REG);
>  
> @@ -207,6 +203,7 @@ static int hi3660_mbox_send_data(struct mbox_chan *chan, void *msg)
>  static const struct mbox_chan_ops hi3660_mbox_ops = {
>         .startup        = hi3660_mbox_startup,
>         .send_data      = hi3660_mbox_send_data,
> +       .last_tx_done   = hi3660_mbox_last_tx_done,
>  };
>  
>  static struct mbox_chan *hi3660_mbox_xlate(struct mbox_controller *controller,
> @@ -259,6 +256,7 @@ static int hi3660_mbox_probe(struct platform_device *pdev)
>         mbox->controller.num_chans = MBOX_CHAN_MAX;
>         mbox->controller.ops = &hi3660_mbox_ops;
>         mbox->controller.of_xlate = hi3660_mbox_xlate;
> +       mbox->controller.txdone_poll = true;
>  
>         /* Initialize mailbox channel data */
>         chan = mbox->chan;
> 
> -- 
> viresh
