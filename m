Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C32591B06
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2019 04:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfHSC0o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Aug 2019 22:26:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33869 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfHSC0o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Aug 2019 22:26:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id b24so239325pfp.1
        for <linux-pm@vger.kernel.org>; Sun, 18 Aug 2019 19:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D27NEAPjmVHRvIAbVgVA3ytPoAPu40jjQqNHrVZHT48=;
        b=AckAnRHGnL7XPKz8rixraSIpon7+sYMNLcrCyi2mP8ep27X6iBjFlqkFteTxNrvx2R
         L1g+1jS0UaztK5DrINseql9Pvqigl6zzV1shhl7xPHt46y+GkHYwhYCFUdtjBBDXOzJP
         uWyperagHVSi2zRXotnqK0yBJs58FVG+MJ6jbcrSvS34xFvjlSNvM+MtR8zumEuPBVxu
         pasKEt9mauuWa1fs6PrvGIDqAgL6baAGpUbMk8PQ4N2RMCbBdZTrZFl2Fpeu2xDP3A6O
         wcbkgTlNPRhcwezb5WAD7iRIHMnJ5D3wsk93KLfamegdmELQJp4Z9CuU7d5l7KRuHmfp
         l8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D27NEAPjmVHRvIAbVgVA3ytPoAPu40jjQqNHrVZHT48=;
        b=a4i2odDdTaT3joHwAxYLhqpOblqbZZn/rJxUxzJgEUrVaOS35Ew8QCoSVRHxw7ZSAI
         Cv98FeGdZjceQTYRE8p3ateYrFBx/GzEXPZEJ3RfPOybW0lhFZmtBVxozbMGlmImMbET
         A6MQ7R6BzCOOnUFHIqNQpG04CCfQkaoyp/Dkjn37RpBGBBQlo+EPY+Vl1htAZG8xsaBu
         /uF6RimfQ43xgLWqkHZp5ZA+qMqYwNlR4wwVfP2dQlSRUZmfmRDFVdiAQOS+r2CA0xG5
         JBaiLQ/I0KF0+imJrgVW0KBzF5vk34XMGakdAXeXl78OtKcgfYVbGRjnYLIgT0uNL6IX
         Tuyg==
X-Gm-Message-State: APjAAAWZYLXYj7qQcepxU1PYirOKZSZAz/HuoKoEQ+yjFyeD4GadvDYL
        qq965osf2lEbxXHf0l3tFckzcA==
X-Google-Smtp-Source: APXvYqzFkamjOjLS7iubUYiLHgSZJ2tU+Ta59qmQd8iUSUBlL4HURQlT702anrPYAArTzDSw43dvTw==
X-Received: by 2002:a17:90a:374a:: with SMTP id u68mr18446548pjb.4.1566181603617;
        Sun, 18 Aug 2019 19:26:43 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id a3sm14170158pfc.70.2019.08.18.19.26.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Aug 2019 19:26:42 -0700 (PDT)
Date:   Mon, 19 Aug 2019 07:56:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 04/10] cpufreq: powerpc_cbe: Switch to QoS requests
 instead of cpufreq notifier
Message-ID: <20190819022614.oy5qdozde2afibwu@vireshk-i7>
References: <cover.1563862014.git.viresh.kumar@linaro.org>
 <524de8ace0596e68a24b57b3b4043c707db32ca7.1563862014.git.viresh.kumar@linaro.org>
 <20190809023445.xn3mlv5qxjgz6bpp@vireshk-i7>
 <CAJZ5v0gQ2RCZGo03=7DoUAxw86wSEaXdnJ2KtknU3uUtXCqmvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gQ2RCZGo03=7DoUAxw86wSEaXdnJ2KtknU3uUtXCqmvQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-08-19, 11:01, Rafael J. Wysocki wrote:
> On Fri, Aug 9, 2019 at 4:34 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 23-07-19, 11:44, Viresh Kumar wrote:
> > > The cpufreq core now takes the min/max frequency constraints via QoS
> > > requests and the CPUFREQ_ADJUST notifier shall get removed later on.
> > >
> > > Switch over to using the QoS request for maximum frequency constraint
> > > for ppc_cbe_cpufreq driver.
> > >
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > >  drivers/cpufreq/ppc_cbe_cpufreq.c     | 19 +++++-
> > >  drivers/cpufreq/ppc_cbe_cpufreq.h     |  8 +++
> > >  drivers/cpufreq/ppc_cbe_cpufreq_pmi.c | 96 +++++++++++++++++----------
> > >  3 files changed, 86 insertions(+), 37 deletions(-)
> >
> > -------------------------8<-------------------------
> 
> If you do it this way, Patchwork will not pick up the patch.
> 
> Please send afresh with "[Update]" or bumped up version number in the
> subject (or both).

Okay, will take care of this in future. Was away on holidays and so
the late reply. Thanks.

-- 
viresh
