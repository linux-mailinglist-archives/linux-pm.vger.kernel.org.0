Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4416DD41
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 09:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfD2H4y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 03:56:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46745 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbfD2H4y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 03:56:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id j11so4901314pff.13
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2019 00:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iDUyXCz0O3gZzXvhpaeHXxypPaGGAtfd/oSSAEOmf3Y=;
        b=A7Hz3bTyQi/xz7ZgDCwYXZLrZiHD4mVW7eIvtAY6yfrXAH4XaIuJg/m+9GuXgo7N+u
         hROxQxARjL1d9gw6Ri5mxxWCuQaIHeskHNFzp4L8gH4ETkC4sBIRd/VRAzWe/jyGC6MF
         zMQJ+AIvJf8HunGLn+dhquQ2AWBjDdcMHKvOXfJ8w5q23CmjXzcucy76c6Ytjrk8a7CQ
         2mxFwzpDtoPH66haEqviolJD462vUrf7JtUBXyO1zejfWMpf7wrTT26rZ+++YFBE30Lw
         BC5WJZElK1GCa0KQTcWJjsE8KVJVH/cSZoo7L3flvMK5Ct07CLWsKv7xMl2W4bl1NW7h
         gO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iDUyXCz0O3gZzXvhpaeHXxypPaGGAtfd/oSSAEOmf3Y=;
        b=OKaoNPxjatIxpacxQXRSkHletWnZXv47D1UhEJFKSptAuLW/NnoS509FVf+qeWXRrq
         PHNkqBxmLLXYCXw1nJ6kx6+DhwkboIWr9K4q/eVZpZEzW6uL21itRNicF9kdHGBZJQse
         i0OOmGIaoag3Q1oxINliuxvzka6VtpsOpDmpdhLA/TLLNVSL8JV4PjylxhoYbpU48vOR
         8DOZqkwrMe3yILukxRJPOHPSGqlqHCaEZEItSyHR6+iVDJ07zvN7KJeHR1QFoFIsTsp6
         DitLQX6UnI/Tw2gXm/Ji+aF9WZy9BUgNeSMTfcgJ1PeZkJYUAksA5zX+nwC6M6jd6KBf
         KKzQ==
X-Gm-Message-State: APjAAAUaRgjah9zxZ10grl7N6NvQCP4VlNPZwToykUsNRo3+8LgMAauU
        +rdmQDRt7trXIwmYk2/7PeE=
X-Google-Smtp-Source: APXvYqxJZUvKrJ454xdtJ2eT/PmPXRmJbFVgJQlRQk6RisbpuAl3PUv/aAL6DsNsDQnxHrNzoPZOxw==
X-Received: by 2002:a65:5106:: with SMTP id f6mr58074635pgq.253.1556524613708;
        Mon, 29 Apr 2019 00:56:53 -0700 (PDT)
Received: from localhost ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id s198sm21715557pfs.34.2019.04.29.00.56.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 00:56:53 -0700 (PDT)
Date:   Mon, 29 Apr 2019 15:56:40 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>, huyue2@yulong.com
Subject: Re: [PATCH v3] cpufreq: Don't find governor for setpolicy drivers
 in cpufreq_init_policy()
Message-ID: <20190429155640.00004adb.zbestahu@gmail.com>
In-Reply-To: <CAJZ5v0jLd9gnw_QuD-aK6fFpdDACbKXJOBugrCNtx1tfmBKi5w@mail.gmail.com>
References: <20190429072418.7860-1-zbestahu@gmail.com>
        <CAJZ5v0jLd9gnw_QuD-aK6fFpdDACbKXJOBugrCNtx1tfmBKi5w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 29 Apr 2019 09:37:27 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Mon, Apr 29, 2019 at 9:24 AM Yue Hu <zbestahu@gmail.com> wrote:
> >
> > From: Yue Hu <huyue2@yulong.com>
> >
> > In cpufreq_init_policy() we will check if there's last_governor for target
> > and setpolicy type. However last_governor is set only if has_target() is
> > true in cpufreq_offline(). That means find last_governor for setpolicy
> > type is pointless. Also new_policy.governor will not be used if ->setpolicy
> > callback is set in cpufreq_set_policy().
> >
> > Moreover, there's duplicate ->setpolicy check in using default policy path.
> > Let's add a new helper function to avoid it. Also update a little comment.
> >
> > Signed-off-by: Yue Hu <huyue2@yulong.com>  
> 
> Have you tested this with the intel_pstate driver (in the active mode)?

No, just tested for ARM. It should be common logic from code perspective. Has
any issue in this change?

> 
> > ---
> > v2: fix ->setplicy typo.
> > v3:
> >   - let cpufreq_parse_governor() only handle !set_policy.
> >   - fix using {} in the if block.
> >   - change helper function name.
> >   - update comment, commit message.
> >
> >  drivers/cpufreq/cpufreq.c | 116 ++++++++++++++++++++++++++--------------------
> >  1 file changed, 65 insertions(+), 51 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 0322cce..ce8a01d 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -578,50 +578,52 @@ static struct cpufreq_governor *find_governor(const char *str_governor)
> >         return NULL;
> >  }
> >
> > +static int cpufreq_parse_policy(char *str_governor,
> > +                               struct cpufreq_policy *policy)
> > +{
> > +       if (!strncasecmp(str_governor, "performance", CPUFREQ_NAME_LEN)) {
> > +               policy->policy = CPUFREQ_POLICY_PERFORMANCE;
> > +               return 0;
> > +       }
> > +       if (!strncasecmp(str_governor, "powersave", CPUFREQ_NAME_LEN)) {
> > +               policy->policy = CPUFREQ_POLICY_POWERSAVE;
> > +               return 0;
> > +       }
> > +       return -EINVAL;
> > +}
> > +
> >  /**
> > - * cpufreq_parse_governor - parse a governor string
> > + * cpufreq_parse_governor - parse a governor string only for !setpolicy
> >   */
> >  static int cpufreq_parse_governor(char *str_governor,
> >                                   struct cpufreq_policy *policy)
> >  {
> > -       if (cpufreq_driver->setpolicy) {
> > -               if (!strncasecmp(str_governor, "performance", CPUFREQ_NAME_LEN)) {
> > -                       policy->policy = CPUFREQ_POLICY_PERFORMANCE;
> > -                       return 0;
> > -               }
> > -
> > -               if (!strncasecmp(str_governor, "powersave", CPUFREQ_NAME_LEN)) {
> > -                       policy->policy = CPUFREQ_POLICY_POWERSAVE;
> > -                       return 0;
> > -               }
> > -       } else {
> > -               struct cpufreq_governor *t;
> > +       struct cpufreq_governor *t;
> >
> > -               mutex_lock(&cpufreq_governor_mutex);
> > +       mutex_lock(&cpufreq_governor_mutex);
> >
> > -               t = find_governor(str_governor);
> > -               if (!t) {
> > -                       int ret;
> > +       t = find_governor(str_governor);
> > +       if (!t) {
> > +               int ret;
> >
> > -                       mutex_unlock(&cpufreq_governor_mutex);
> > +               mutex_unlock(&cpufreq_governor_mutex);
> >
> > -                       ret = request_module("cpufreq_%s", str_governor);
> > -                       if (ret)
> > -                               return -EINVAL;
> > +               ret = request_module("cpufreq_%s", str_governor);
> > +               if (ret)
> > +                       return -EINVAL;
> >
> > -                       mutex_lock(&cpufreq_governor_mutex);
> > +               mutex_lock(&cpufreq_governor_mutex);
> >
> > -                       t = find_governor(str_governor);
> > -               }
> > -               if (t && !try_module_get(t->owner))
> > -                       t = NULL;
> > +               t = find_governor(str_governor);
> > +       }
> > +       if (t && !try_module_get(t->owner))
> > +               t = NULL;
> >
> > -               mutex_unlock(&cpufreq_governor_mutex);
> > +       mutex_unlock(&cpufreq_governor_mutex);
> >
> > -               if (t) {
> > -                       policy->governor = t;
> > -                       return 0;
> > -               }
> > +       if (t) {
> > +               policy->governor = t;
> > +               return 0;
> >         }
> >
> >         return -EINVAL;
> > @@ -746,8 +748,13 @@ static ssize_t store_scaling_governor(struct cpufreq_policy *policy,
> >         if (ret != 1)
> >                 return -EINVAL;
> >
> > -       if (cpufreq_parse_governor(str_governor, &new_policy))
> > -               return -EINVAL;
> > +       if (cpufreq_driver->setpolicy) {
> > +               if (cpufreq_parse_policy(str_governor, &new_policy))
> > +                       return -EINVAL;
> > +       } else {
> > +               if (cpufreq_parse_governor(str_governor, &new_policy))
> > +                       return -EINVAL;
> > +       }
> >
> >         ret = cpufreq_set_policy(policy, &new_policy);
> >
> > @@ -1020,32 +1027,39 @@ __weak struct cpufreq_governor *cpufreq_default_governor(void)
> >
> >  static int cpufreq_init_policy(struct cpufreq_policy *policy)
> >  {
> > -       struct cpufreq_governor *gov = NULL;
> > +       struct cpufreq_governor *gov = NULL, *def_gov = NULL;
> >         struct cpufreq_policy new_policy;
> >
> >         memcpy(&new_policy, policy, sizeof(*policy));
> >
> > -       /* Update governor of new_policy to the governor used before hotplug */
> > -       gov = find_governor(policy->last_governor);
> > -       if (gov) {
> > -               pr_debug("Restoring governor %s for cpu %d\n",
> > +       def_gov = cpufreq_default_governor();
> > +
> > +       if (has_target()) {
> > +               /*
> > +                * Update governor of new_policy to the governor used before
> > +                * hotplug
> > +                */
> > +               gov = find_governor(policy->last_governor);
> > +               if (gov) {
> > +                       pr_debug("Restoring governor %s for cpu %d\n",
> >                                 policy->governor->name, policy->cpu);
> > +               } else {
> > +                       if (!def_gov)
> > +                               return -ENODATA;
> > +                       gov = def_gov;
> > +               }
> > +               new_policy.governor = gov;
> >         } else {
> > -               gov = cpufreq_default_governor();
> > -               if (!gov)
> > -                       return -ENODATA;
> > -       }
> > -
> > -       new_policy.governor = gov;
> > -
> > -       /* Use the default policy if there is no last_policy. */
> > -       if (cpufreq_driver->setpolicy) {
> > -               if (policy->last_policy)
> > +               /* Use the default policy if there is no last_policy. */
> > +               if (policy->last_policy) {
> >                         new_policy.policy = policy->last_policy;
> > -               else
> > -                       cpufreq_parse_governor(gov->name, &new_policy);
> > +               } else {
> > +                       if (!def_gov)
> > +                               return -ENODATA;
> > +                       cpufreq_parse_policy(def_gov->name, &new_policy);
> > +               }
> >         }
> > -       /* set default policy */
> > +
> >         return cpufreq_set_policy(policy, &new_policy);
> >  }
> >
> > --
> > 1.9.1
> >  

