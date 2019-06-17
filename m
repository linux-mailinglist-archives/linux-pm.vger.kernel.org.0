Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 472174784B
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2019 05:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfFQDCc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 16 Jun 2019 23:02:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45609 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbfFQDCc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 16 Jun 2019 23:02:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id s21so4895548pga.12
        for <linux-pm@vger.kernel.org>; Sun, 16 Jun 2019 20:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NJlHRkmk25t9Rmubt04mipVO0Y/BwirGMlYSaXRKn8A=;
        b=ZwiILSmhp4ZKXd1QGSvoFZSKdMRto5tzNshW7w2aogz/UcOSPQ6A9GSUqxZdcmhHcc
         +Pt3ypetK77R7FT0dXILl4OMkJzvKW5L52Nq5EV8jue+IOScJK+/k/tykn+kp6BPV0ni
         ZLKY35vbZLLgrn9D2/lcbyOSVesOJnElx39uSpTUesSrtwcayVDcBVybznqqHPrf5HjW
         tgIHvNH3vZf6xYutsuaddpIKA4VsMPRsFV622bOxinRQoel0e+tdQtQ+Qqy63JiRafI5
         NtK6d8JldN2XfmhvpIpCaCj2SXUIAedy66/FKHWOb29vMEuFfg3Vup4Glrsiow5tX3yY
         Hyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NJlHRkmk25t9Rmubt04mipVO0Y/BwirGMlYSaXRKn8A=;
        b=Jt1fT0eHTE+cWGVEMTYdDiVajQI+MEe/LWb6yj1LlBQfARZ16DmvUbXsN3G9hyVYln
         Jw2LqO6rO0Mkxq1NQ39HGD0R0iUX2voNZbeRddWLrKnd6crxCETGafMXbrUZVoHwy6/8
         nFK+99OYq7p8s8dC4APK13fRSu7pqDUVrJCERKNxtg7ArlMdZiazl1I0dZh4wJvJ/+0O
         mGjNCMp0/eKfEHaKXLkotJzhFA/WKcNX5PBw2sTX/BVerjTsju2m4sjYMaoEuXDAe+1j
         2YMxsoTXwHQwKzDg91ulfY4KUipA0c3WaSyg/Gr7sqwRewym3I0cA8hk1nFPF3/XwHAE
         /+Nw==
X-Gm-Message-State: APjAAAWvkAEEc72iJcuzHlL8T8MDO4yVfQDd7Cn5hTLGlYw+5xkwhDKn
        re+lCAfHAbkcYu3ayEC1Ctbpfw==
X-Google-Smtp-Source: APXvYqwcK8fedw48K0Kbrw5+hGYiOfhk9ENA1stMFLlbezblIy3rMckPbpM7kGVR0aPhiTFr8/uErQ==
X-Received: by 2002:a62:ae01:: with SMTP id q1mr55635934pff.219.1560740551429;
        Sun, 16 Jun 2019 20:02:31 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id v29sm3652156pgn.31.2019.06.16.20.02.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 20:02:30 -0700 (PDT)
Date:   Mon, 17 Jun 2019 08:32:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 4/5] cpufreq: Register notifiers with the PM QoS
 framework
Message-ID: <20190617030228.3ubbmpgyl6nvesu2@vireshk-i7>
References: <cover.1560163748.git.viresh.kumar@linaro.org>
 <a275fdd9325f1b2cba046c79930ad59653674455.1560163748.git.viresh.kumar@linaro.org>
 <20190614164641.GP137143@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614164641.GP137143@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14-06-19, 09:46, Matthias Kaehlcke wrote:
> Hi Viresh,
> 
> On Mon, Jun 10, 2019 at 04:21:35PM +0530, Viresh Kumar wrote:
> > This registers the notifiers for min/max frequency constraints with the
> > PM QoS framework. The constraints are also taken into consideration in
> > cpufreq_set_policy().
> > 
> > This also relocates cpufreq_policy_put_kobj() as it is required to be
> > called from cpufreq_policy_alloc() now.
> > 
> > No constraints are added until now though.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/cpufreq.c | 139 +++++++++++++++++++++++++++++++-------
> >  include/linux/cpufreq.h   |   4 ++
> >  2 files changed, 120 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 85ff958e01f1..547d221b2ff2 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/kernel_stat.h>
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> > +#include <linux/pm_qos.h>
> >  #include <linux/slab.h>
> >  #include <linux/suspend.h>
> >  #include <linux/syscore_ops.h>
> > @@ -1126,11 +1127,77 @@ static void handle_update(struct work_struct *work)
> >  	cpufreq_update_policy(cpu);
> >  }
> >  
> > +static void cpufreq_update_freq_work(struct work_struct *work)
> > +{
> > +	struct cpufreq_policy *policy =
> > +		container_of(work, struct cpufreq_policy, req_work);
> > +	struct cpufreq_policy new_policy = *policy;
> > +
> > +	/* We should read constraint values from QoS layer */
> > +	new_policy.min = 0;
> > +	new_policy.max = UINT_MAX;
> > +
> > +	down_write(&policy->rwsem);
> > +
> > +	if (!policy_is_inactive(policy))
> > +		cpufreq_set_policy(policy, &new_policy);
> > +
> > +	up_write(&policy->rwsem);
> > +}
> > +
> > +static int cpufreq_update_freq(struct cpufreq_policy *policy)
> > +{
> > +	schedule_work(&policy->req_work);
> 
> I think you need to add a cancel_work_sync() in cpufreq_policy_free()
> to make sure the work doesn't run after the policy has been freed.

Right, added this to the commit.

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 547d221b2ff2..878add2cac3c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1289,6 +1289,8 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
                                   DEV_PM_QOS_MAX_FREQUENCY);
        dev_pm_qos_remove_notifier(dev, &policy->nb_min,
                                   DEV_PM_QOS_MIN_FREQUENCY);
+       cancel_work_sync(&policy->req_work);
+
        cpufreq_policy_put_kobj(policy);
        free_cpumask_var(policy->real_cpus);
        free_cpumask_var(policy->related_cpus);

-- 
viresh
