Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDE7CDB7C2
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 21:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfJQTmU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 15:42:20 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38132 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbfJQTmT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 15:42:19 -0400
Received: by mail-qt1-f196.google.com with SMTP id j31so5368547qta.5
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 12:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n0cRSBeI5QiEyBOk4yyCnBrOWirqw7hqnVbP7QBmeig=;
        b=auy/Umx49q7PLPDN0XFugnCa+/qbWVIPanKLjT4dmZHNNUk0RuNRmyuDtmbKsVS5G9
         Tfv3SJbewZEJvt+APi+7p9SqmKFg22P3pH0sKhxFsJxCF+ck6gl7OhNNkE3SS1kKFUQZ
         ZM4gvehmyNfn+xM+sDC4a4o4YQlchMj/1dmHgdpujaIsyKKGdoy++v+FeGPO0vmwXKwR
         mB4GwbNxn/f99jtc5IIs3WrtrxZZmQACBSmQ8h06Xg11P0jQIitWRpiTr1UhXjTfuOEz
         UjZ63PR4pTUOHr/hLLJhsFWkB6rCsdr7XKNOdwninmr5S6j4c3Qwb8jCxYttIMM5AXAc
         Ggfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n0cRSBeI5QiEyBOk4yyCnBrOWirqw7hqnVbP7QBmeig=;
        b=cPHyYbceUrOEpIfhBsLv9Ms+/ITTqnLuMMzz7TDaZPOHtOZUOusGUXNZZ9aIOffxjl
         y2w8N53zIYd5YhZuTlFS5IUYsIMfvbMTIk6HzjcJ9FyAiDvq4AwHOUK0LZQgMtfuXUMB
         FtLQo6EiJrUCLky5WseIYpAJyXkt2uhpc9B7lHOhkWny4edKmN0OfOekSHyz1V2CHDeV
         sspQJ4md3Bwpz8sLyjMoAZvO3P8SP4V0HKttJNS8Deel4Dll5shb2yMf313jz8nA9JDH
         lWVKyWZvyThOre0LOyCEO7pRcRk3nwo54ACEooajORoa6OQ3a0aSaztSRc/49hlqwywR
         xqcA==
X-Gm-Message-State: APjAAAX8qob9BfEsvRgyKuXO4tJtmaqIE3BQk9YbJ0+mUf81oy9dD+gw
        1dvazk7j2UQqYwRho5Dq0azX4cIQ0bvwxaYf/cMVjg==
X-Google-Smtp-Source: APXvYqzflMcI4I980dwsJblkSENtr+BcULK0/FnGCeDdiaa72OT/ajTWNOHYH720MMux8SQ6xxuTa0vtrLKUycuRHGc=
X-Received: by 2002:ac8:237b:: with SMTP id b56mr5994000qtb.264.1571341337992;
 Thu, 17 Oct 2019 12:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571314830.git.amit.kucheria@linaro.org>
 <f1d7214951e4b2caa394c722b4d8aaca9cc2c4c4.1571314830.git.amit.kucheria@linaro.org>
 <CAJZ5v0gAyaXHrWe5x6ctz_zawFvudgpTVFCuwieBM5s=FMXysQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gAyaXHrWe5x6ctz_zawFvudgpTVFCuwieBM5s=FMXysQ@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 18 Oct 2019 01:12:06 +0530
Message-ID: <CAP245DULxAXyFH8gZAdij5me6prxGyHZDiR_VC85y+PMco5WqA@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] cpufreq: Initialise the governors in core_initcall
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 18, 2019 at 12:41 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Oct 17, 2019 at 2:28 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
> >
> > Initialise the cpufreq governors earlier to allow for earlier
> > performance control during the boot process.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> You also want to do that for the schedutil governor I think.

Indeed. Thanks for the review. I'll respin.

>
> > ---
> >  drivers/cpufreq/cpufreq_conservative.c | 2 +-
> >  drivers/cpufreq/cpufreq_ondemand.c     | 2 +-
> >  drivers/cpufreq/cpufreq_performance.c  | 2 +-
> >  drivers/cpufreq/cpufreq_powersave.c    | 2 +-
> >  drivers/cpufreq/cpufreq_userspace.c    | 2 +-
> >  5 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> > index b66e81c06a57..737ff3b9c2c0 100644
> > --- a/drivers/cpufreq/cpufreq_conservative.c
> > +++ b/drivers/cpufreq/cpufreq_conservative.c
> > @@ -346,7 +346,7 @@ struct cpufreq_governor *cpufreq_default_governor(void)
> >         return CPU_FREQ_GOV_CONSERVATIVE;
> >  }
> >
> > -fs_initcall(cpufreq_gov_dbs_init);
> > +core_initcall(cpufreq_gov_dbs_init);
> >  #else
> >  module_init(cpufreq_gov_dbs_init);
> >  #endif
> > diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> > index dced033875bf..82a4d37ddecb 100644
> > --- a/drivers/cpufreq/cpufreq_ondemand.c
> > +++ b/drivers/cpufreq/cpufreq_ondemand.c
> > @@ -483,7 +483,7 @@ struct cpufreq_governor *cpufreq_default_governor(void)
> >         return CPU_FREQ_GOV_ONDEMAND;
> >  }
> >
> > -fs_initcall(cpufreq_gov_dbs_init);
> > +core_initcall(cpufreq_gov_dbs_init);
> >  #else
> >  module_init(cpufreq_gov_dbs_init);
> >  #endif
> > diff --git a/drivers/cpufreq/cpufreq_performance.c b/drivers/cpufreq/cpufreq_performance.c
> > index aaa04dfcacd9..def9afe0f5b8 100644
> > --- a/drivers/cpufreq/cpufreq_performance.c
> > +++ b/drivers/cpufreq/cpufreq_performance.c
> > @@ -50,5 +50,5 @@ MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
> >  MODULE_DESCRIPTION("CPUfreq policy governor 'performance'");
> >  MODULE_LICENSE("GPL");
> >
> > -fs_initcall(cpufreq_gov_performance_init);
> > +core_initcall(cpufreq_gov_performance_init);
> >  module_exit(cpufreq_gov_performance_exit);
> > diff --git a/drivers/cpufreq/cpufreq_powersave.c b/drivers/cpufreq/cpufreq_powersave.c
> > index c143dc237d87..1ae66019eb83 100644
> > --- a/drivers/cpufreq/cpufreq_powersave.c
> > +++ b/drivers/cpufreq/cpufreq_powersave.c
> > @@ -43,7 +43,7 @@ struct cpufreq_governor *cpufreq_default_governor(void)
> >         return &cpufreq_gov_powersave;
> >  }
> >
> > -fs_initcall(cpufreq_gov_powersave_init);
> > +core_initcall(cpufreq_gov_powersave_init);
> >  #else
> >  module_init(cpufreq_gov_powersave_init);
> >  #endif
> > diff --git a/drivers/cpufreq/cpufreq_userspace.c b/drivers/cpufreq/cpufreq_userspace.c
> > index cbd81c58cb8f..b43e7cd502c5 100644
> > --- a/drivers/cpufreq/cpufreq_userspace.c
> > +++ b/drivers/cpufreq/cpufreq_userspace.c
> > @@ -147,7 +147,7 @@ struct cpufreq_governor *cpufreq_default_governor(void)
> >         return &cpufreq_gov_userspace;
> >  }
> >
> > -fs_initcall(cpufreq_gov_userspace_init);
> > +core_initcall(cpufreq_gov_userspace_init);
> >  #else
> >  module_init(cpufreq_gov_userspace_init);
> >  #endif
> > --
> > 2.17.1
> >
