Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3853E89A2
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 07:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbhHKFTv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 01:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbhHKFTZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Aug 2021 01:19:25 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC2BC0613D5
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 22:19:02 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id bo18so1665503pjb.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 22:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HZD0Vc3lp/XqIPTm8s+fyeFvAaL1Bw4mNZGMJyfHjck=;
        b=JsUzkrlDPAu8MK89pY4o2ZMqmceYFpkvBK5JN4Q3rcKt2yG6fIG7GyD/keZNyuPlO/
         pWDGRH0qVmkLvGILreUzHaQu2FqD7yCQInNs4MJfpOiBzeWCu1wVYqJHzzWd7jjg+1lK
         BPFkK9UOvNfF/dC32k369RJCDXvuGtx44NefqAQ8+PCbgjAa2GCfEu+hhsZOan5ymCE4
         Ckimj6yuQU672Pnu8Th/zBuzKM9OCrQ0Z4nuzcpM71M4Ou7EoR9Xl8bFAePomrmwMIFX
         SScfYhAV4fznqI7SG3+EA8jmNDowekCV9Zq4xhx491ewQCRU3dBLaVY249wQNytNEBdH
         cKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HZD0Vc3lp/XqIPTm8s+fyeFvAaL1Bw4mNZGMJyfHjck=;
        b=ttUHpxDoOqXx/JKzw1xhs3JFkfmCwMh6wUj7bY8Ari2Y7R4DwdNK5PpAELcMDUJDq4
         a9CmMfhmmg3UkGAg3j5gXz/m3qCF3BKNphZ5Hsacu2DoBMGznPIAkAAzVFY6OAndvCul
         gKBP2wYaumkqIdbRmg22Pkop0yyrWVeFLSOw8FB9sxVkwqzFv2mzxI8WWaJwMafupKiL
         nF8DZZ5MZk4l7j81ONDdl0V8FC3jLdMGNOGmB555+VCpylAQ0xzxUEqqIRjAkN7nMn02
         z5A8x8QV662dczY+Yn7HlxwKoXe5uaOfHmpsb2oSxK4mi8w3vvCW3HFMAHk4UBmW1OWa
         BDKQ==
X-Gm-Message-State: AOAM531RgAY/aZq4M8bzbL2aeW0OEn8nXaRlbdIlpWRnizg29spBaF6F
        yzG+/+aA1eN/6+qPWzKIJyYnWQ==
X-Google-Smtp-Source: ABdhPJzkff8ozUzWrLhACtgWHkaRe212yS2ydFbdEsIQCClF9gDAs7w5Kivh/WFFx4A/swTDLByBiw==
X-Received: by 2002:a17:90a:ce0a:: with SMTP id f10mr35357981pju.71.1628659141754;
        Tue, 10 Aug 2021 22:19:01 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id z13sm4816257pjd.44.2021.08.10.22.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 22:19:01 -0700 (PDT)
Date:   Wed, 11 Aug 2021 10:48:59 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        lukasz.luba@arm.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 0/8] cpufreq: Auto-register with energy model
Message-ID: <20210811051859.ihjzhvrnuct2knvy@vireshk-i7>
References: <cover.1628579170.git.viresh.kumar@linaro.org>
 <YRJym+Vn4bbwQzzs@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRJym+Vn4bbwQzzs@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-08-21, 13:35, Quentin Perret wrote:
> On Tuesday 10 Aug 2021 at 13:06:47 (+0530), Viresh Kumar wrote:
> > Provide a cpufreq driver flag so drivers can ask the cpufreq core to register
> > with the EM core on their behalf.
> 
> Hmm, that's not quite what this does. This asks the cpufreq core to
> use *PM_OPP* to register an EM, which I think is kinda wrong to do from
> there IMO. The decision to use PM_OPP or another mechanism to register
> an EM belongs to platform specific code (drivers), so it is odd for the
> PM_OPP registration to have its own cpufreq flag but not the other ways.
> 
> As mentioned in another thread, the very reason to have PM_EM is to not
> depend on PM_OPP, so I'm worried about the direction of travel with this
> series TBH.

I had to use the pm-opp version, since almost everyone was using that.

On the other hand, there isn't a lot of OPP specific stuff in
dev_pm_opp_of_register_em(). It just uses dev_pm_opp_get_opp_count(),
that's all. This ended up in the OPP core, nothing else. Maybe we can
now move it back to the EM core and name it differently ?

> > This allows us to get rid of duplicated code
> > in the drivers and fix the unregistration part as well, which none of the
> > drivers have done until now.
> 
> This series adds more code than it removes,

Sadly yes :(

> and the unregistration is
> not a fix as we don't ever remove the EM tables by design, so not sure
> either of these points are valid arguments.

I think that design needs to be looked over again, it looks broken to
me everytime I land onto this code. I wonder why we don't unregister
stuff.

Lets say, I am working on the cpufreq driver and I want to test that
on my ARM machine. Rebooting a simpler board to test stuff out is
easy, but if I am working on an ARM server which is running lots of
other userspace stuff as well, I won't want to reboot the machine just
to test a different versions of the driver. I will rather want to
build the driver as module and insert/remove it again and again.

If the frequency table changes in between versions, this just breaks
as EM won't be updated again.

This breaks one of the most basic rules of Linux Kernel. Inserting a
module should have exactly the same final behavior every single time.
This model doesn't guarantee it. It simply looks broken.

> > This would also make the registration with EM core to happen only after policy
> > is fully initialized, and the EM core can do other stuff from in there, like
> > marking frequencies as inefficient (WIP). Though this patchset is useful without
> > that work being done and should be merged nevertheless.
> > 
> > This doesn't update scmi cpufreq driver for now as it is a special case and need
> > to be handled differently. Though we can make it work with this if required.
> 
> Note that we'll have more 'special cases' if other architectures start
> using PM_EM, which is what we have been trying to allow since the
> beginning, so that's worth keeping in mind.

Yes, we need to take care of all such special cases as well.

-- 
viresh
