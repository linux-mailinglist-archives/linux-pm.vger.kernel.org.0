Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCAE3E8D83
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 11:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236726AbhHKJtL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 05:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236718AbhHKJtL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Aug 2021 05:49:11 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840F7C0613D5
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 02:48:47 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id o7-20020a05600c5107b0290257f956e02dso3965021wms.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 02:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p4WmlR24/y2/H/iFDZT8SMkW7O2fno0PSDl3vpvyQeE=;
        b=iaVC7Y7Zmp0QcX38aol/tjPqpn4a9rxsP+5sEfJ55JdRHQf78WhTS54TvYm1QuiZb9
         Tfv0V+kMCmuN3NlmWiy+TFbkP8Z36BybITbwzyiRLjWOhIIr9BHtWja4KxbVpcBPi/HI
         HuD68dSvDc/WEbgyaUM8PsEuId/nmfzZ9pPp60bwzZ1zayPm70ShfyqrudfelYC77Hsv
         lYfsQBRYWFNavWRipVgXXp3YGsoJzSPKV2/B/dz02TFMtktJ/TilyV8Jiu+vO4+FU2Ra
         CLbILl4Kx7dV2I8iGXshcBeO08NSv6p9CNlc4nncGiFlrwXLzL7ajuNEyVzb/lB2uvJY
         953w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p4WmlR24/y2/H/iFDZT8SMkW7O2fno0PSDl3vpvyQeE=;
        b=XDXdL0ItY9WVRl9RPsy1QSZAs8FU/2fMk5KeovT+GtYLLYwNOGSF+BdDtu7TxpgMpd
         2QY/u1dh2tTdSBs4ktvT9cSzBJ/JOjwNV+ViUycZSlqyciql7G6RtP9hzxXvVrUKqvzg
         gqcg1hknk5nzZRKw9UypiMSBrE54qAyYEZSaxjiLzfcfKUqjtcJprWQCI5Z/88Tj0iOI
         cGVblqGirkQBUog3chekB1Le+jzMD+iRdGdRxyA6Ljul+ecq0SL04pBvVmg0KqnrqiuV
         Y/HLq8yiWKNHKnBAza5BBMreEqN9iwu90sGOcHyCYbBAttCZNsPiKa+hep6+1BsKC7nC
         v4oQ==
X-Gm-Message-State: AOAM531BmbTdGcmuFc3kdteDFtG71Cz+kW230xJEVeNPgaeRvRrDSm8b
        J7R/wYdoKo2vyf5a4dqK4QnRLg==
X-Google-Smtp-Source: ABdhPJwGyl1imWlJBD9wXE9eHTwazSKJ1G8Ab8pkXMP8KjdfEz4VJdIoamsdZzeXoxBFY1zz1ZxyEw==
X-Received: by 2002:a7b:c350:: with SMTP id l16mr8974823wmj.151.1628675325873;
        Wed, 11 Aug 2021 02:48:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:43fd:e634:73d9:e10e])
        by smtp.gmail.com with ESMTPSA id p4sm14701093wrq.81.2021.08.11.02.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 02:48:45 -0700 (PDT)
Date:   Wed, 11 Aug 2021 10:48:39 +0100
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
Message-ID: <YROc95YKA1Y/TfYI@google.com>
References: <cover.1628579170.git.viresh.kumar@linaro.org>
 <YRJym+Vn4bbwQzzs@google.com>
 <20210811051859.ihjzhvrnuct2knvy@vireshk-i7>
 <20210811053406.jqwextgtnxhgsjd2@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811053406.jqwextgtnxhgsjd2@vireshk-i7>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday 11 Aug 2021 at 11:04:06 (+0530), Viresh Kumar wrote:
> On 11-08-21, 10:48, Viresh Kumar wrote:
> > On 10-08-21, 13:35, Quentin Perret wrote:
> > > This series adds more code than it removes,
> > 
> > Sadly yes :(
> > 
> > > and the unregistration is
> > > not a fix as we don't ever remove the EM tables by design, so not sure
> > > either of these points are valid arguments.
> > 
> > I think that design needs to be looked over again, it looks broken to
> > me everytime I land onto this code. I wonder why we don't unregister
> > stuff.
> 
> Coming back to this series. We have two options, based on what I
> proposed here:
> 
> https://lore.kernel.org/linux-pm/20210811050327.3yxrk4kqxjjwaztx@vireshk-i7/
> 
> 1. Let cpufreq core register with EM on behalf of cpufreq drivers.

If we're going that route, I think we should allow _all_ possible
EM registration methods (via PM_OPP or else) to be done that way.
Otherwise we're creating an inconsitency in how the EM is registered
(e.g. from the ->init() cpufreq callback for some, or from cpufreq core
for others) which is problematic as we risk building features that
assume loading is done at a certain time, which won't work for some
platforms.

> 2. Update drivers to use ->ready() callback to do this stuff.

I think this should work, but perhaps will be a bit tricky for cpufreq
driver developers as they need to have a pretty good understanding of
the stack to know that they should do the registration from here and not
->init() for instance. Suggested alternative: we introduce a ->register_em()
callback to cpufreq_driver, and turn dev_pm_opp_of_register_em() into a
valid handler for this callback. This should 'document' things a bit
better, avoid some of the problems your other series tried to achieve, and
allow us to call the EM registration in exactly the right place from
cpufreq core. On the plus side, we could easily make this work for e.g.
the SCMI driver which would only need to provide its own version of
->register_em().

Thoughts?
