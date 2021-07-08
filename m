Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D293BF67E
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jul 2021 09:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhGHH4j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jul 2021 03:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbhGHH4i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jul 2021 03:56:38 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674DDC061574
        for <linux-pm@vger.kernel.org>; Thu,  8 Jul 2021 00:53:56 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so5355677pjs.2
        for <linux-pm@vger.kernel.org>; Thu, 08 Jul 2021 00:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K3KoPC3LRTr3a33D+5oYfwCBSbOGKOZphYLnnWXbw5g=;
        b=df4U/QiIkn3tE/Ln289Z3dWN0WYK0K1ntOga5FPafBbBJvzSb8pWFfB0iEv7ul4TOH
         tRKxJTiplzLX180VrADBGIuGWpYePE5lf7FqxLRrQXJKNi3MblaDkv+LjG0ORsEIAHEz
         TslzUltxxizQHjtZvJXqnKYY5KnwBw/gpX/dCViEtkdhxaV2yVKqkmrMHxsBJRznbptZ
         IOzvjlcD1mTfmwYIwvMV5f8/HCyI61/QN821FUQaFAc3CNHmmWzh9X7a3H1tUlW3MQFb
         6euPdoXxbVOMBCti94k2gi8GraIktVmk7YQSbnm2OJvcUZrmZd0PIWMbKIw3JIgpe8L3
         oNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K3KoPC3LRTr3a33D+5oYfwCBSbOGKOZphYLnnWXbw5g=;
        b=jmrEY75DB9Ej3b+94Mc9IT1I8wBrCsO6by3Nd56g4yLmK9f81OvL1MTTw2jhuth6oy
         Vs7swHgW0kPIjaBUuP8LoKw1GWir8O+BNz3YtSMDLUiFoR26YyD3lh082zGH5XOVPmik
         85DEkYFegIQd+MvryGsVux2rQ9InW3bLQKpKob2z84L+ROxPHcpHUEMvPTnWe+PvXzjo
         CRHB512q3A2856OcORqc/5RzycCMJb844YONZE7xRdrZfFSXJnb2r33BSycmFKeV4Qlg
         6/NF1LJKtw9GRmBYDOENtc6HyXRP1figa9ZrdZ+jZz5tMNG9pf0o0dj4MU2qgkobWU8l
         qq2w==
X-Gm-Message-State: AOAM531gMQHH7j71prb8sj2dx6AZjXufRsWB0oICdNNB+VOeaXr6lL4Y
        7Yd/aiKQFojeTEzprlSGTNKJLQ==
X-Google-Smtp-Source: ABdhPJyRpJHFOZoPjnaiIzhsXptBvFz9jFQO4amWbE8xx7JUQwl+3pj/KjMO1jYPnBjAbx174s33ZQ==
X-Received: by 2002:a17:90a:c253:: with SMTP id d19mr3520815pjx.225.1625730835751;
        Thu, 08 Jul 2021 00:53:55 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id l189sm1982324pgl.41.2021.07.08.00.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 00:53:55 -0700 (PDT)
Date:   Thu, 8 Jul 2021 13:23:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Kevin Wangtao <kevin.wangtao@hisilicon.com>,
        Leo Yan <leo.yan@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Cc:     zhongkaihua@huawei.com, Dmitry Osipenko <digetx@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 03/13] opp: Keep track of currently programmed OPP
Message-ID: <20210708075353.ivsuc4y47i6bbhgz@vireshk-i7>
References: <cover.1611227342.git.viresh.kumar@linaro.org>
 <96b57316a2a307a5cc5ff7302b3cd0084123a2ed.1611227342.git.viresh.kumar@linaro.org>
 <20210707102410.GA4357@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707102410.GA4357@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-07-21, 11:24, Ionela Voinescu wrote:
> Now comes the interesting part: what seems to fix it is a call to
> clk_get_rate(opp_table->clk) in _set_opp(), which is what basically
> happened before this patch, as _find_current_opp() was always called.
> I do not need to do anything with the returned frequency.

Wow, thanks for narrowing it down this far :)

I had a quick look and this is what I think is the problem here.

This platform uses mailbox API to send its frequency change requests to another
processor.  And the way it is written currently, I don't see any guarantee
whatsoever which say

  "once clk_set_rate() returns, the frequency would have already changed".

And this may exactly be the thing you are able to hit, luckily because of this
patchset :)

As a quick way of checking if that is right or not, this may make it work:

diff --git a/drivers/mailbox/hi3660-mailbox.c b/drivers/mailbox/hi3660-mailbox.c
index 395ddc250828..9856c1c84dcf 100644
--- a/drivers/mailbox/hi3660-mailbox.c
+++ b/drivers/mailbox/hi3660-mailbox.c
@@ -201,6 +201,9 @@ static int hi3660_mbox_send_data(struct mbox_chan *chan, void *msg)

        /* Trigger data transferring */
        writel(BIT(mchan->ack_irq), base + MBOX_SEND_REG);
+
+       hi3660_mbox_check_state(chan);
+
        return 0;
 }

-------------------------8<-------------------------

As a proper fix, something like this (not even compile tested) is required I
believe as I don't see the clients would know if the transfer is over. Cc'ing
mailbox guys to see what can be done.

diff --git a/drivers/clk/hisilicon/clk-hi3660-stub.c b/drivers/clk/hisilicon/clk-hi3660-stub.c
index 3a653d54bee0..c1e62ea4cf01 100644
--- a/drivers/clk/hisilicon/clk-hi3660-stub.c
+++ b/drivers/clk/hisilicon/clk-hi3660-stub.c
@@ -89,7 +89,6 @@ static int hi3660_stub_clk_set_rate(struct clk_hw *hw, unsigned long rate,
                stub_clk->msg[0], stub_clk->msg[1]);
 
        mbox_send_message(stub_clk_chan.mbox, stub_clk->msg);
-       mbox_client_txdone(stub_clk_chan.mbox, 0);
 
        stub_clk->rate = rate;
        return 0;
@@ -131,7 +130,7 @@ static int hi3660_stub_clk_probe(struct platform_device *pdev)
        /* Use mailbox client without blocking */
        stub_clk_chan.cl.dev = dev;
        stub_clk_chan.cl.tx_done = NULL;
-       stub_clk_chan.cl.tx_block = false;
+       stub_clk_chan.cl.tx_block = true;
        stub_clk_chan.cl.knows_txdone = false;
 
        /* Allocate mailbox channel */
diff --git a/drivers/mailbox/hi3660-mailbox.c b/drivers/mailbox/hi3660-mailbox.c
index 395ddc250828..8f6b787c0aba 100644
--- a/drivers/mailbox/hi3660-mailbox.c
+++ b/drivers/mailbox/hi3660-mailbox.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2017-2018 HiSilicon Limited.
+// Copyright (c) 2017-2018 Hisilicon Limited.
 // Copyright (c) 2017-2018 Linaro Limited.
 
 #include <linux/bitops.h>
@@ -83,7 +83,7 @@ static struct hi3660_mbox *to_hi3660_mbox(struct mbox_controller *mbox)
        return container_of(mbox, struct hi3660_mbox, controller);
 }
 
-static int hi3660_mbox_check_state(struct mbox_chan *chan)
+static bool hi3660_mbox_last_tx_done(struct mbox_chan *chan)
 {
        unsigned long ch = (unsigned long)chan->con_priv;
        struct hi3660_mbox *mbox = to_hi3660_mbox(chan->mbox);
@@ -94,20 +94,20 @@ static int hi3660_mbox_check_state(struct mbox_chan *chan)
 
        /* Mailbox is ready to use */
        if (readl(base + MBOX_MODE_REG) & MBOX_STATE_READY)
-               return 0;
+               return true;
 
        /* Wait for acknowledge from remote */
        ret = readx_poll_timeout_atomic(readl, base + MBOX_MODE_REG,
                        val, (val & MBOX_STATE_ACK), 1000, 300000);
        if (ret) {
                dev_err(mbox->dev, "%s: timeout for receiving ack\n", __func__);
-               return ret;
+               return false;
        }
 
        /* clear ack state, mailbox will get back to ready state */
        writel(BIT(mchan->ack_irq), base + MBOX_ICLR_REG);
 
-       return 0;
+       return true;
 }
 
 static int hi3660_mbox_unlock(struct mbox_chan *chan)
@@ -182,10 +182,6 @@ static int hi3660_mbox_send_data(struct mbox_chan *chan, void *msg)
        unsigned int i;
        int ret;
 
-       ret = hi3660_mbox_check_state(chan);
-       if (ret)
-               return ret;
-
        /* Clear mask for destination interrupt */
        writel_relaxed(~BIT(mchan->dst_irq), base + MBOX_IMASK_REG);
 
@@ -207,6 +203,7 @@ static int hi3660_mbox_send_data(struct mbox_chan *chan, void *msg)
 static const struct mbox_chan_ops hi3660_mbox_ops = {
        .startup        = hi3660_mbox_startup,
        .send_data      = hi3660_mbox_send_data,
+       .last_tx_done   = hi3660_mbox_last_tx_done,
 };
 
 static struct mbox_chan *hi3660_mbox_xlate(struct mbox_controller *controller,
@@ -259,6 +256,7 @@ static int hi3660_mbox_probe(struct platform_device *pdev)
        mbox->controller.num_chans = MBOX_CHAN_MAX;
        mbox->controller.ops = &hi3660_mbox_ops;
        mbox->controller.of_xlate = hi3660_mbox_xlate;
+       mbox->controller.txdone_poll = true;
 
        /* Initialize mailbox channel data */
        chan = mbox->chan;

-- 
viresh
