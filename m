Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C090E3C42BE
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jul 2021 06:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhGLERE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jul 2021 00:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbhGLERE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jul 2021 00:17:04 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2EBC0613DD
        for <linux-pm@vger.kernel.org>; Sun, 11 Jul 2021 21:14:16 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id a2so16935564pgi.6
        for <linux-pm@vger.kernel.org>; Sun, 11 Jul 2021 21:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3Q0y1C5hmnwnQuxDAoytzYjEDb+K9YOferT1UplBZDI=;
        b=mIMX1rWpwGJdN1eOOWJekhKvqJvi8fqfCurK24etfPBQ3MNdHzoGTzb8dLf537YaMf
         VYnRRelfS+FEYLLPanap81YpLvmegkqQILEuLWAusJt1DfXQp//aIGzIpG8eiXKVKq94
         N8Tapznrsw9dTw45i1ReNKBXTOb8SwTS3v9QyBMZlFEQMSiATM9jmv62CGsRbU2gdgDl
         DS8n1b1xc9LNDaG3hFAXD0u/QxNDThcbaPihffTEe/jfw4HOMfCJMXaG4Dfmarqp+To0
         l3olzEI3bCFUgDd0yFNwn6IUvksz4ROK5/dG1aC7U98QzKcqEPLAu5NKizbHdBKfDP/9
         tGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3Q0y1C5hmnwnQuxDAoytzYjEDb+K9YOferT1UplBZDI=;
        b=COd5io5/C4hFUGatd020hoBy7Y9a91mIVGlMr5H4V2GYerd3pW/zt2p86YFDyf8seb
         p7D596Fi/SkCY7JD2eTS2FyDoH1nqjaU3EGABZ/GoihJxSUtofo9lR8hVgtOg7zihej+
         xr9xkYgWIDpTNNe8n12f4fN7H+3lEgs/OfJyTw+aR6Nf1kZqcQVMcbLJJWjOpvJcfQ6/
         a9xgoPgiuADIGev9Mc3UUY/dv8qBw0ZA7wTjTjIoABENR4rWNG9sUuxlwMsjNd72TUJY
         RCkU5o6vhOb4ylnbWUnP12imkC3GTB6PwLzLDLv/FYM8pyCzNK2YX4KKY9lCiuWlAiih
         Wtew==
X-Gm-Message-State: AOAM533GrPwJFdJFsPks/OkXSQH2sJ03UwdrgNECGj2ekBDpbsa/9FCq
        lduUdAcsRim+Vz10Q8bMxzLaBQ==
X-Google-Smtp-Source: ABdhPJyhGDSTLIqfaiJ1pTy10h6u43OBRhm+KFRTRb2fTgsRTuCnLZO0JlcC2ljGmflX5/NyBp/vTg==
X-Received: by 2002:a62:fb13:0:b029:309:8d89:46b2 with SMTP id x19-20020a62fb130000b02903098d8946b2mr50395923pfm.67.1626063255619;
        Sun, 11 Jul 2021 21:14:15 -0700 (PDT)
Received: from localhost ([106.201.108.2])
        by smtp.gmail.com with ESMTPSA id 18sm18419305pje.22.2021.07.11.21.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 21:14:14 -0700 (PDT)
Date:   Mon, 12 Jul 2021 09:44:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
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
Message-ID: <20210712041408.5dgtwcp55pgt7twn@vireshk-i7>
References: <cover.1611227342.git.viresh.kumar@linaro.org>
 <96b57316a2a307a5cc5ff7302b3cd0084123a2ed.1611227342.git.viresh.kumar@linaro.org>
 <20210707102410.GA4357@arm.com>
 <20210708075353.ivsuc4y47i6bbhgz@vireshk-i7>
 <20210709085704.GA10180@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709085704.GA10180@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-07-21, 09:57, Ionela Voinescu wrote:
> On Thursday 08 Jul 2021 at 13:23:53 (+0530), Viresh Kumar wrote:
> > On 07-07-21, 11:24, Ionela Voinescu wrote:
> > > Now comes the interesting part: what seems to fix it is a call to
> > > clk_get_rate(opp_table->clk) in _set_opp(), which is what basically
> > > happened before this patch, as _find_current_opp() was always called.
> > > I do not need to do anything with the returned frequency.
> > 
> > Wow, thanks for narrowing it down this far :)
> > 
> > I had a quick look and this is what I think is the problem here.
> > 
> > This platform uses mailbox API to send its frequency change requests to another
> > processor.  And the way it is written currently, I don't see any guarantee
> > whatsoever which say
> > 
> >   "once clk_set_rate() returns, the frequency would have already changed".
> > 
> 
> I think what was strange to me was that the frequency never seems to
> change, there isn't just a delay in the new frequency taking effect, as
> I would expect in these cases. Or if there is a delay, that's quite large
> - at least a second.

No idea on what the firmware is doing behind the scene :)

> > And this may exactly be the thing you are able to hit, luckily because of this
> > patchset :)
> > 
> > As a quick way of checking if that is right or not, this may make it work:
> > 
> > diff --git a/drivers/mailbox/hi3660-mailbox.c b/drivers/mailbox/hi3660-mailbox.c
> > index 395ddc250828..9856c1c84dcf 100644
> > --- a/drivers/mailbox/hi3660-mailbox.c
> > +++ b/drivers/mailbox/hi3660-mailbox.c
> > @@ -201,6 +201,9 @@ static int hi3660_mbox_send_data(struct mbox_chan *chan, void *msg)
> > 
> >         /* Trigger data transferring */
> >         writel(BIT(mchan->ack_irq), base + MBOX_SEND_REG);
> > +
> > +       hi3660_mbox_check_state(chan);
> > +
> 
> I gave this a try an it does work for me.

Good, so that kind of proves what I was suspecting. The mailbox driver looks
buggy here.

> > -------------------------8<-------------------------
> > 
> > As a proper fix, something like this (not even compile tested) is required I
> > believe as I don't see the clients would know if the transfer is over. Cc'ing
> > mailbox guys to see what can be done.
> > 
> 
> I'll give this a try as well when there is consensus. I might even try to
> review it, if the time allows.

Sure, lets see what the platform guys think about this first.

Kevin, Kaihua ?

-- 
viresh
