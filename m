Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20953E8BEA
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 10:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbhHKIi2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 04:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbhHKIi1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Aug 2021 04:38:27 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFF2C0613D3
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 01:38:04 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r7so1990858wrs.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 01:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8ctvExXHxoU7MDz0lLq/Tgi84JQatciTVAxD+Fn/jcQ=;
        b=rEq02tPeUoTDMJlCRt+ttFdA0Jr7daFhR+2ie5RBcOI3BzWNUuUWa9Gbkn4HGOW7WY
         4dGznTdp6VXTPNE9W13rtYzeqx7tx7wQ393pENejnQSXz9eLj1RNBFRM1k3jq7xv7egq
         HC0wLX7Gfq1JdtcjNVDY4wLVGIFgnDphxa8SKvMeE6pZoYh5aVDsC/sruC06SYWsY3uM
         J7cw2lg+GbQUi7uuzGE1t6Q0KYY1VP89pD3oxKNUKWXB+QlwgXjHIwdMYwDYJtjhm4GA
         VV1DzVJB/z5IitVlWxedaVu1jjrQLyAUK9KtmHXlZnADSSCcDIKhD2TqwcqLbaym+Na8
         XOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8ctvExXHxoU7MDz0lLq/Tgi84JQatciTVAxD+Fn/jcQ=;
        b=Cr2GDeLS8+cc0CHWsN7OyZZOekR1ng2bhG8MGAb6mhmLlY5MwCFbO9dRw2NQNazer1
         uIPC/YdZ7hZcCEZCLIu1wKyQaW+WYdjD1Pe5RQzzSbCpf3bojxME8Zt9fQeRhkAiOdDr
         ZOjYx7sReWw3Bnok7hsnStYBq1YQVUg0/Xcayl+yEaA1fyJXdW2R7T0xklB+vgwG1Ex+
         UjKuBBZnVog2zvW4tQoh5xLzFnGFSBaMN3sfUpltwQb7SXGpC/My+ecL5Boc15i5rxqD
         rCiT1U9m6xJihRlYxMH2QzJH/vQPqf5AQ2t3PWt+uuC7VloGE/pid6+dNH+s2qkLwvdJ
         hETw==
X-Gm-Message-State: AOAM532LJxvYhyGkBWP6XnTlmVWsK+cd/DDyZMHcLVvoWj7XrAMtrzH6
        pK2q8rQspA0zfsImF69H1qph7g==
X-Google-Smtp-Source: ABdhPJzU9YQR62yDNq9PrF7gkVKzwniyJFxIxg9cOJLgH9YZSN7yJXWq44plPsS4/Qn9sPmMW8M/QQ==
X-Received: by 2002:a5d:490b:: with SMTP id x11mr35305440wrq.322.1628671082736;
        Wed, 11 Aug 2021 01:38:02 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:43fd:e634:73d9:e10e])
        by smtp.gmail.com with ESMTPSA id e25sm13986334wra.90.2021.08.11.01.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 01:38:02 -0700 (PDT)
Date:   Wed, 11 Aug 2021 09:37:56 +0100
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
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
Message-ID: <YROMZFHCor3pbhMr@google.com>
References: <cover.1628579170.git.viresh.kumar@linaro.org>
 <YRJym+Vn4bbwQzzs@google.com>
 <20210811051859.ihjzhvrnuct2knvy@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811051859.ihjzhvrnuct2knvy@vireshk-i7>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday 11 Aug 2021 at 10:48:59 (+0530), Viresh Kumar wrote:
> On 10-08-21, 13:35, Quentin Perret wrote:
> > On Tuesday 10 Aug 2021 at 13:06:47 (+0530), Viresh Kumar wrote:
> > > Provide a cpufreq driver flag so drivers can ask the cpufreq core to register
> > > with the EM core on their behalf.
> > 
> > Hmm, that's not quite what this does. This asks the cpufreq core to
> > use *PM_OPP* to register an EM, which I think is kinda wrong to do from
> > there IMO. The decision to use PM_OPP or another mechanism to register
> > an EM belongs to platform specific code (drivers), so it is odd for the
> > PM_OPP registration to have its own cpufreq flag but not the other ways.
> > 
> > As mentioned in another thread, the very reason to have PM_EM is to not
> > depend on PM_OPP, so I'm worried about the direction of travel with this
> > series TBH.
> 
> I had to use the pm-opp version, since almost everyone was using that.
> 
> On the other hand, there isn't a lot of OPP specific stuff in
> dev_pm_opp_of_register_em(). It just uses dev_pm_opp_get_opp_count(),
> that's all. This ended up in the OPP core, nothing else. Maybe we can
> now move it back to the EM core and name it differently ?

Well it also uses dev_pm_opp_find_freq_ceil() and
dev_pm_opp_get_voltage(), so not sure how easy it will be to move, but
if it is possible no objection from me.

> > > This allows us to get rid of duplicated code
> > > in the drivers and fix the unregistration part as well, which none of the
> > > drivers have done until now.
> > 
> > This series adds more code than it removes,
> 
> Sadly yes :(
> 
> > and the unregistration is
> > not a fix as we don't ever remove the EM tables by design, so not sure
> > either of these points are valid arguments.
> 
> I think that design needs to be looked over again, it looks broken to
> me everytime I land onto this code. I wonder why we don't unregister
> stuff.
> 
> Lets say, I am working on the cpufreq driver and I want to test that
> on my ARM machine. Rebooting a simpler board to test stuff out is
> easy, but if I am working on an ARM server which is running lots of
> other userspace stuff as well, I won't want to reboot the machine just
> to test a different versions of the driver. I will rather want to
> build the driver as module and insert/remove it again and again.
> 
> If the frequency table changes in between versions, this just breaks
> as EM won't be updated again.
> 
> This breaks one of the most basic rules of Linux Kernel. Inserting a
> module should have exactly the same final behavior every single time.
> This model doesn't guarantee it. It simply looks broken.

Right but the EM is a description of the hardware, so it seemed fair
to assume this wouldn't change across the lifetime of the OS, similar
to the DT which we can't reload at run-time. Yes it can be a little odd
if you load/unload your driver module, but note that you generally can't
load two completely different drivers on a single system. You'll just
load the same one again and the hardware hasn't changed in the meantime,
so the previously loaded EM will still be correct. I hear your argument
about cpufreq driver development, but the locking involved to allow
'just' that is pretty involved, and nobody has complained about this
specific issue so far, so that didn't seem worth it. If we do have good
reasons to change the EM at runtime, then yes I think we should do it,
it just didn't seem like that was the case until now.
