Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC02A3AC52E
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jun 2021 09:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhFRHsw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Jun 2021 03:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhFRHsv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jun 2021 03:48:51 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B1AC061574
        for <linux-pm@vger.kernel.org>; Fri, 18 Jun 2021 00:46:41 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g4so5280117pjk.0
        for <linux-pm@vger.kernel.org>; Fri, 18 Jun 2021 00:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g3POzcgh/avJIeba5rT64dVp/8mkGkb9nAQDKfOaZvc=;
        b=k5z0ZWdNtHkh8Y/xwVG3e95ujbaP4mNBt/D6YH496fcVHYKK2EHuzav6z7kmTw4o95
         NedMoRF6WiPZemlu6YcKcBcGZuDb7J/vjeSftSQuQPAQbWpVCJmiaMQ4/yLRHaJZ0PXH
         AQt70ImVTUjzb7eScjo1pOpRVze7hgWpVbnhFi7o3cS3ZpXJtf/oVB0Qn3ooooRdo9s6
         taToB1C1bcs9jiGaZCFZNUKEv/F160ykT7HCN+4EWwbvrHwamBLsRH9phO7z6dnYCdAw
         00ONmVW04VyGtpt+Ihn3IJMydkFzKBsMkZXMFwZ0LfvWj4dCGSMP2AsuMzRXSdvKO8/c
         YPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g3POzcgh/avJIeba5rT64dVp/8mkGkb9nAQDKfOaZvc=;
        b=ENBEV/S0OhzeAo1SwrWWf6kmAhGVwjC37276qrfVkgjWQoD1kqpLHb9SQXQR/vQzJH
         9M4D/+cvHRU4JYahW79wphkIjB3pypNIeYHqr7ngRP+0521ZuZ+k4ypFsgbaHyZ8AQeo
         wDmH+7hew+SQlm6mR8jdGiXxooDxvgpUo4M7J1P7BYVTC1APY3eqnGr9TwGYtpPFhWyx
         QN+2dvib9NNUJwLn1S5TyV4ZO5Lt/ZqbW37o/EctvK8XR6y9SOCx4rsObtJlltUf9Uzk
         Tcq1eewzGJkLMZHo3Fl0xVCyCES75aLA7I4IkeWYPbg034HIlRSUx0uwZ8uRQLpitRF0
         y8oA==
X-Gm-Message-State: AOAM530/M7MoViIK+QUQ/4apg8io43CS8MIRDTRruio0frFy3ajPVvhl
        6jj2MXr+BodHDjgLR3uAKSvyzw==
X-Google-Smtp-Source: ABdhPJxdjnz2h6Pj0rYsysgBeBuNIV0JVP6cBKh1/5dlYvpJCOQELq8pxvTgs4wjgZp9MdPveIp2Pw==
X-Received: by 2002:a17:90a:ce8b:: with SMTP id g11mr8849253pju.170.1624002401466;
        Fri, 18 Jun 2021 00:46:41 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id s13sm8033700pgi.36.2021.06.18.00.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 00:46:40 -0700 (PDT)
Date:   Fri, 18 Jun 2021 13:16:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 1/3] cpufreq: Add start_cpu() and stop_cpu() callbacks
Message-ID: <20210618074639.d72shvu46aejvbwd@vireshk-i7>
References: <cover.1623825725.git.viresh.kumar@linaro.org>
 <2ffbaf079a21c2810c402cb5bba4e9c14c4a0ff4.1623825725.git.viresh.kumar@linaro.org>
 <CAJZ5v0gBUMXs=oANZRuOO7uUVdSD-n1inwYsoLr5or=2gEa2Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gBUMXs=oANZRuOO7uUVdSD-n1inwYsoLr5or=2gEa2Mg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-06-21, 15:33, Rafael J. Wysocki wrote:
> On Wed, Jun 16, 2021 at 8:48 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > +       /* Do CPU specific de-initialization if required */
> > +       if (cpufreq_driver->stop_cpu)
> > +               cpufreq_driver->stop_cpu(policy, cpu);
> > +
> >         /* Start governor again for active policy */
> >         if (!policy_is_inactive(policy)) {
> >                 if (has_target()) {
> > @@ -1597,9 +1611,6 @@ static int cpufreq_offline(unsigned int cpu)
> >                 policy->cdev = NULL;
> >         }
> >
> > -       if (cpufreq_driver->stop_cpu)
> > -               cpufreq_driver->stop_cpu(policy);
> > -
> 
> This should be a separate patch IMO, after you've migrated everyone to
> ->offline/->exit.

Right, anyway this patch may not be required anymore. I will send a patch to
remove this.

> BTW, IMO it might be better to migrate ->stop_cpu to ->offline rather
> than to ->exit.

This is a bit tricky IMO.

First, offline() isn't implemented by everyone, out of the three implementations
which were using stop_cpu(), only intel-pstate had offline() as well.

Second, the primary purpose of online/offline callbacks was suspend/resume
oriented and for the same reason, we don't call online() when the policy first
comes up and so in case of errors during bring up, we end up calling exit()
directly and not offline().

IMO this is a very specific thing to drivers and they need to see what fits best
for them, exit() or offline() or both.

-- 
viresh
