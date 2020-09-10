Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1908264FAC
	for <lists+linux-pm@lfdr.de>; Thu, 10 Sep 2020 21:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgIJTtA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Sep 2020 15:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgIJTsw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2020 15:48:52 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE625C061757;
        Thu, 10 Sep 2020 12:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2c66nEBP3DnG4HoyZXJPOlNFvLsRVtjflHnzpM04Cds=; b=WVt7qUC3KvQkSyJfCLY4neNlzG
        5roByh4wUvdqv/vQ1V2RMcthBqRUdn+vthIURckBn8mMTPbtkU1y84Uxtzb+Kum2q/NTBRrJ4sPOu
        mAuqdWRs3XovrKECyu+zzODbwxAkJsqvkYslQ+rhNBQOrYsV3zeQSqRtAIX71GfJ2p2U=;
Received: from p200300ccff0e43001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0e:4300:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1kGSYb-0007Sl-NR; Thu, 10 Sep 2020 21:48:34 +0200
Date:   Thu, 10 Sep 2020 21:48:32 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Adam Ford <aford173@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, Adam Ford-BE <aford@beaconembedded.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        kernel test robot <lkp@intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 1/2] thermal: ti-soc-thermal: Enable addition power
 management
Message-ID: <20200910214832.0041b3aa@aktux>
In-Reply-To: <CAHCN7xLUrh7xr0pr5Bz0unWQXGkiKDK88hZKx7WXGyr2RBWTVg@mail.gmail.com>
References: <20200819125925.2119434-1-aford173@gmail.com>
        <20200910200152.72cc5d9f@aktux>
        <4770327e-84fb-0543-097c-6525d762a01f@linaro.org>
        <CAHCN7xLUrh7xr0pr5Bz0unWQXGkiKDK88hZKx7WXGyr2RBWTVg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 10 Sep 2020 14:33:13 -0500
Adam Ford <aford173@gmail.com> wrote:

> On Thu, Sep 10, 2020 at 2:14 PM Daniel Lezcano <daniel.lezcano@linaro.org>
> wrote:
> 
> > On 10/09/2020 20:01, Andreas Kemnade wrote:  
> > > On Wed, 19 Aug 2020 07:59:23 -0500
> > > Adam Ford <aford173@gmail.com> wrote:
> > >  
> > >> The bandgap sensor can be idled when the processor is too, but it
> > >> isn't currently being done, so the power consumption of OMAP3
> > >> boards can elevated if the bangap sensor is enabled.
> > >>
> > >> This patch attempts to use some additional power management
> > >> to idle the clock to the bandgap when not needed.
> > >>
> > >> Signed-off-by: Adam Ford <aford173@gmail.com>
> > >> Reported-by: kernel test robot <lkp@intel.com>
> > >> ---
> > >> V2: Fix issue where variable stating the suspend mode isn't being
> > >>     properly set and cleared.
> > >>  
> > > hmm, it is not in linux-next. Can we expect that for v5.10?  
> >
> > The reason I did not pick this patch is because lkp reported an error on
> > it.
> >
> > https://marc.info/?l=linux-pm&m=159788472017308&w=2
> >
> >
> >  
> That error message shows it's trying to be built with 'sh' cross compiler,
> but should be build with an ARM.
> 
> I can run a manual test of the patch against a different branch if
> necessary, but I had built and tested it, so I know it worked at one time.
> 
hmm, what about compile-testing without CONFIG_PM_SLEEP?

The function definition is guarded by that.
So it is not a sh-specific problem.

Regards,
Andreas
