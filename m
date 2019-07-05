Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96F086051B
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2019 13:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfGELJX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jul 2019 07:09:23 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46095 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfGELJW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jul 2019 07:09:22 -0400
Received: by mail-io1-f65.google.com with SMTP id i10so18241731iol.13
        for <linux-pm@vger.kernel.org>; Fri, 05 Jul 2019 04:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GveihlYZs0J+F63zH48aj5g/7oHU0pJxNq9JZx6zqiE=;
        b=nQ4gNPxk3/R7IVfzsEbOSzY7Sn8pZD/5ZB/GTPJt5IAPqD5xUfxRzcw4AmsJ+OaowW
         DGsBzzqNMp4MBfvdOCS2PU8RQ61UvtYN5/Hirg6okDeKGQusapYtlZoB10NyGSIa+SiH
         U/cVsvuG//b1KUQ0VaIkxx2IxHQoRWt+SAelK0foNqWwdtXh7yRncOtZDFkL5Xq9Knyi
         LAVcp1wmpZqBXBLy0ZTCTVaRMQlEmxJhpHohxJV8QbMc+YKPo98pcsM9natWjQnZp9Cc
         CQJAoAwv+BywGt9gRE4McZT4SCbVTXiZMNoYS5dv2jdsJ8WniX5LLcsTpCdGrzJdMTy3
         UBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GveihlYZs0J+F63zH48aj5g/7oHU0pJxNq9JZx6zqiE=;
        b=KUz8nAoLnz3t6NmieGyWVEwevwKWTZlRbLZVWUx5n+bdeG8uswkDYW+hBuBZ/qK/Fa
         8MUI7Ig60TvQEoTBfk8Lp1nc/uS4+jlURWnq2xqvB2MbpHjAZF1zDg3jZo03v7JMM1kO
         bho3eE5Fo2ovzeNxM9uRnu65BnKqhGpVaCxnrYDHtBlOt5Ug6i1kXP5nmZTsAfLnLM+F
         0MlhGz0BJx4IDqlGjX+yUFF8/Gq0Cb2VHUGKAzndJ9hN3r/+CMAoCeE52iptQIGWGARm
         dkmeEvn7kyxCOeF1Fc+UN+1oDNrO+wqOLRHnbnK5BhWATY2BIHZNjBqSa1CEg8b7O6Bu
         fq1w==
X-Gm-Message-State: APjAAAXwdqR0XJ6fYWwDsoptj+mIoc/yFwMtTvFVqMV9GXOfflfdtLGa
        5sR5XS6MhLMFzsdUKDAFQAQM1X5HrjS5WKLHyJbeVw==
X-Google-Smtp-Source: APXvYqzieDKax8cSZMjUhPSJts36HOWhQYKiRDMAb+mh3A4BqOLHGhh0uiJJQDQlUoOJne5M+hvtW4l0ZUQUVoCzviE=
X-Received: by 2002:a5d:80d6:: with SMTP id h22mr3460690ior.231.1562324961640;
 Fri, 05 Jul 2019 04:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000005bf6c3058cde49a7@google.com> <8755905.1UUJr7qOyo@kreacher>
 <CACT4Y+awzZOSAseosiUDvs_zk7hFRuQrrr0LjRmVwesVbF_+aQ@mail.gmail.com>
 <20190705104152.wniaje2u5d77iaoa@vireshk-i7> <20190705105442.kpvvyxakpa6mrxlu@vireshk-i7>
In-Reply-To: <20190705105442.kpvvyxakpa6mrxlu@vireshk-i7>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 5 Jul 2019 13:09:08 +0200
Message-ID: <CACT4Y+Y-_F03jqYz1swzpsQRKB3Y-tGZWFOfjKfYY7h9G5psMA@mail.gmail.com>
Subject: Re: linux-next boot error: WARNING in corrupted
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        syzbot <syzbot+de771ae9390dffed7266@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 5, 2019 at 12:54 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 05-07-19, 16:11, Viresh Kumar wrote:
> > This fixes it for me (after faking the failure). @Rafael this needs to
> > be merged to the top commit:
> >
> > 0d4c2a013b32 cpufreq: Add QoS requests for userspace constraints
>
> @Rafael: I have sent V7 of this patch now after merging below diff
> (and improving it further). Thanks.

Please include:

Tested-by: syzbot+de771ae9390dffed7266@syzkaller.appspotmail.com

into the commit, or it will be messy to resolve this bug later.

> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 13c2f119cc0c..5eecd54195a9 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1228,12 +1228,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
> >                 goto err_min_qos_notifier;
> >         }
> >
> > -       policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
> > -                                      GFP_KERNEL);
> > -       if (!policy->min_freq_req)
> > -               goto err_max_qos_notifier;
> > -
> > -       policy->max_freq_req = policy->min_freq_req + 1;
> >         INIT_LIST_HEAD(&policy->policy_list);
> >         init_rwsem(&policy->rwsem);
> >         spin_lock_init(&policy->transition_lock);
> > @@ -1244,9 +1238,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
> >         policy->cpu = cpu;
> >         return policy;
> >
> > -err_max_qos_notifier:
> > -       dev_pm_qos_remove_notifier(dev, &policy->nb_max,
> > -                                  DEV_PM_QOS_MAX_FREQUENCY);
> >  err_min_qos_notifier:
> >         dev_pm_qos_remove_notifier(dev, &policy->nb_min,
> >                                    DEV_PM_QOS_MIN_FREQUENCY);
> > @@ -1370,6 +1361,13 @@ static int cpufreq_online(unsigned int cpu)
> >                         add_cpu_dev_symlink(policy, j);
> >                 }
> >
> > +               policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
> > +                                              GFP_KERNEL);
> > +               if (!policy->min_freq_req)
> > +                       goto out_destroy_policy;
> > +
> > +               policy->max_freq_req = policy->min_freq_req + 1;
> > +
> >                 ret = dev_pm_qos_add_request(dev, policy->min_freq_req,
> >                                              DEV_PM_QOS_MIN_FREQUENCY,
> >                                              policy->min);
>
> --
> viresh
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20190705105442.kpvvyxakpa6mrxlu%40vireshk-i7.
> For more options, visit https://groups.google.com/d/optout.
