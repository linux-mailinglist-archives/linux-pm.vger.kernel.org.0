Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6293731E8CB
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 11:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbhBRKpI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 05:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbhBRKJM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 05:09:12 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F9FC061574
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 01:43:22 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id c11so907443pfp.10
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 01:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qK5r3k93cfpS3zq+7gG4qbRSxrtne+0Sq28qmsU6N6k=;
        b=MWeKtv/p5jjqdgyiVmHdpmimfFs3bDIkuKq8nnW9drzx/Q9nVJsUYNVKD+QwHnbZsI
         tk4WLTf83gPpww0tC9IWQojHcBVNCymsUFqjFLlELFpk9ZRoxwXGmfZV69emfT8JxFgi
         OklaTb6oBpq2NwFzycABuKRM0gVheNkFJ64vDwbGC6U6UjuZEoGkTKYiTGdbnq7xmLeQ
         HB1q5yEvJVlQbpFfQf91KX60FcfLBveeWUm4KqWwcx+p9Gnce5fSP1YblmOlb+QjeRAt
         GgZ7O2Meg/GEIbcIbtogXkDlzeiT8RZW4PnNVothXxr+bH2YV/Cwnox528rV5F/2O4JB
         Ietg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qK5r3k93cfpS3zq+7gG4qbRSxrtne+0Sq28qmsU6N6k=;
        b=uGNGDzlOkNeXvj5tiBSlb3BsSxF14czB8gZeByOQs4l8oN2eDRbY2bpySBpd8Y4ZcI
         VaKhHrpok/Bjh0A/MlaHuAvQlm7cjNd985AQPBoRNooPuPJB8z0Kc+a72q1RWHU3xU8o
         biWHr1zDDGcppx160ANu19wvRwOWWo2VeTnDst1I108zYRtZXqOuE0xtKn2U4DOwpMGY
         m8JaFKZO4U+KKbfTZYsTo5uSo+QjuqyoJW2+fsF61fpNJ03mEyZ/Vov1UT1DnhYSULvI
         Kk0xE0JLy/37tYUjooN04+0ciWQiCEnFaA0pcIYEujqMmteTjvU7xEalV2QI4f4myOQ6
         BytA==
X-Gm-Message-State: AOAM531qCSaiMoBQNg7mY5zOQ0Mjwn0GJIFLIipGvpFvxvjDxbr+y7jf
        f/2l1yo2onuFzT5SNGVoW10=
X-Google-Smtp-Source: ABdhPJxCozSnsiB+qN74OSuPAa9gWzI3Jhm0cp2dsWioKXPneJ1q1yFR7Fli1S5P3DizxRcaMaz6Ug==
X-Received: by 2002:a65:6207:: with SMTP id d7mr3520083pgv.92.1613641402070;
        Thu, 18 Feb 2021 01:43:22 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id t18sm4869184pjs.57.2021.02.18.01.43.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Feb 2021 01:43:21 -0800 (PST)
Date:   Thu, 18 Feb 2021 17:43:15 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-pm@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] cpufreq: schedutil: Remove comment to update_lock of
 struct sugov_policy
Message-ID: <20210218174315.000046e4.zbestahu@gmail.com>
In-Reply-To: <20210218093924.ye5i4vvwqqubkdqw@vireshk-i7>
References: <20210218093753.1700-1-zbestahu@gmail.com>
        <20210218093924.ye5i4vvwqqubkdqw@vireshk-i7>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 18 Feb 2021 15:09:24 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:

> Always mention version number and version history in a patch. Don't
> resend it now anyway.

ok, got it.

Thank you.

> 
> On 18-02-21, 17:37, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > Currently, update_lock is also used in sugov_update_single_freq().
> > The comment is not helpful anymore.
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/cpufreq_schedutil.c
> > b/kernel/sched/cpufreq_schedutil.c index add8081..fd43d59 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -26,7 +26,7 @@ struct sugov_policy {
> >  	struct sugov_tunables	*tunables;
> >  	struct list_head	tunables_hook;
> >  
> > -	raw_spinlock_t		update_lock;	/* For
> > shared policies */
> > +	raw_spinlock_t		update_lock;
> >  	u64			last_freq_update_time;
> >  	s64			freq_update_delay_ns;
> >  	unsigned int		next_freq;  
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

