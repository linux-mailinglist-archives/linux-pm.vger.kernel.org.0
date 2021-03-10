Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884C8333B41
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 12:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhCJLVK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Mar 2021 06:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhCJLU6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Mar 2021 06:20:58 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E9AC06174A;
        Wed, 10 Mar 2021 03:20:58 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id n9so10251409pgi.7;
        Wed, 10 Mar 2021 03:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=226SqCfAh3qQ3UxQNI+mT8Jvh9PheA/4vqh6AF+hXfA=;
        b=jqoYXmR4S+q84qQfnmGWNpD46mtj3/M+Js9Rd1SBW2mcYRnZEgipEXETod6fV5GvJS
         OZO1ZZpU0Nje5BS2raek9dX0H/JVj7WZSgdPytszgVwW8ThTygEaZaose/lwPn7G7wnH
         r5hGsIgPw0EI4USvJGzIue506B5l+2yQXmqQnSvqJ1v1rOx2eUlt6RlmG4k3iYoZohvX
         wUIB9xQhLfT/jq7+SachAJMLQiqbVvkl2640NjlYCE/BowXSsxjzAIHS2OeB+OGE7P53
         C/xsvwYidND3BmhFZLU1M4LilnmbVmHFqs8ijIaLYiUfijcLHa3BVL58kFRdScDJzNnG
         vw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=226SqCfAh3qQ3UxQNI+mT8Jvh9PheA/4vqh6AF+hXfA=;
        b=Tpb2fMeXFyL3sEnsFboZ4LKO6X7THHTqfYwSGL1ndsX/L+iMqBXeN+qp+cdFUYX30e
         uBrsRpNjfJAX90xCCN2yFy3g9pZmZLy2o0WsiDW+C+w8bsM/BjiEmV6lF70FLF+Yod5U
         ya0slSKG6lKC0ayG04adc6SXfDN83XXTgh327CFSTXodUc6K6B9M/3I79oFUEdhYPtqr
         2+lQ5CB5fT37ByU3y1UzbMIWzCGIG1tyqSSYRFVPrsSnMmEptmcIHZGOsHv8p5cQ5cqU
         7i072+eZlLT3Y4dz54Qw2pBodBHuh+UFlZA0XSEJNjAvh2HqP8uNUAKENU2UOF3zPeh6
         ga3g==
X-Gm-Message-State: AOAM5324srT8DYkxQaaR7sj3ARmmCongJF3RwhHRETnuPaZv+I78QiL7
        re0ECbmG3/58LBOIZ4mZYFk=
X-Google-Smtp-Source: ABdhPJy5IufC3OBPEd6RVRZ7a1LMB0WM8rDn8GIUcFPid2pSmSzEOjGFDUOcSmOMmhNW3GIPftTBBg==
X-Received: by 2002:a65:41c6:: with SMTP id b6mr2364903pgq.7.1615375254862;
        Wed, 10 Mar 2021 03:20:54 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id z8sm6538195pjd.0.2021.03.10.03.20.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Mar 2021 03:20:54 -0800 (PST)
Date:   Wed, 10 Mar 2021 19:20:51 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     rafael@kernel.org
Cc:     rjw@rjwysocki.net, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com, viresh.kumar@linaro.org
Subject: Re: [PATCH v2] cpufreq: schedutil: Call sugov_update_next_freq()
 before check to fast_switch_enabled
Message-ID: <20210310192051.00006659.zbestahu@gmail.com>
In-Reply-To: <20210224064727.w3w4b66jnsmcxdff@vireshk-i7>
References: <20210224063927.1298-1-zbestahu@gmail.com>
        <20210224064727.w3w4b66jnsmcxdff@vireshk-i7>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

Please also review the patch.
I'm not sure if you have reviewed or not.

Thank you!

On Wed, 24 Feb 2021 12:17:27 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 24-02-21, 14:39, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > Note that sugov_update_next_freq() may return false, that means the
> > caller sugov_fast_switch() will do nothing except fast switch check.
> > 
> > Similarly, sugov_deferred_update() also has unnecessary operations
> > of raw_spin_{lock,unlock} in sugov_update_single_freq() for that case.
> > 
> > So, let's call sugov_update_next_freq() before the fast switch check
> > to avoid unnecessary behaviors above. Accordingly, update interface
> > definition to sugov_deferred_update() and remove sugov_fast_switch()
> > since we will call cpufreq_driver_fast_switch() directly instead.
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > ---
> > v2: remove sugov_fast_switch() and call cpufreq_driver_fast_switch()
> >     directly instead, also update minor log message.
> > 
> >  kernel/sched/cpufreq_schedutil.c | 29 ++++++++++++-----------------
> >  1 file changed, 12 insertions(+), 17 deletions(-)  
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

