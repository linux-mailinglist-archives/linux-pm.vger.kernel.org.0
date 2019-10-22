Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7D9AE0196
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2019 12:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbfJVKHq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Oct 2019 06:07:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33056 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfJVKHp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Oct 2019 06:07:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id k11so218458pgt.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2019 03:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hcL7Y1mIHrv+zJufdm/7tWW0i/5Ngmwav5YR6aEz2Qo=;
        b=ivO5b5vurvQ9LA8qtn3cHbpPoRX2yjkgwkpDqqE16TH42wJwB/6rdZXhctRQpTwQx6
         czMO6XZbFR5LH5YX3sED3ZKy4lVOZ8gG+ofEZCZC6jYUG771VczXQdj7a0pHIU921xch
         SBCzpsI3iWnHkfjRuLfKoGDjcXy+gyp5qaifnvDGYwHlb1rPeFGrk5d0NpD5ZAW3u375
         yjcFyeEzpkEZWryMfTAJa3ESs4NpHE/ez/nJKblHqDc0Wpf6QBraSlP18+ciPX2IBcnH
         8Kj7RDbw4qttl+056hF9Z4oEHQBJ5SXmnLEito4He527Qfw/auwXy1JFfgdoaynnaPb7
         FgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hcL7Y1mIHrv+zJufdm/7tWW0i/5Ngmwav5YR6aEz2Qo=;
        b=SigRAo2HQEdN2OsIJ9GVLWMsgY85c0tfZc1g0cS+ZLwVfTOZ0BleDhYp97lxSixryk
         qs2XSbhxm3chUfmQCl6khkX9H1U5+7TJze+BzGl5hN35HH9mLmZdzstHKwNQ2PEhjye7
         X7PUY2l9Sr4Zja8Lzuh1pRdXu3ev0qggxolcfx+VH4g0HcF9XmJpvraMmiLetSX16oas
         CI8OiOfqZ3RQeRjD8QY9p6sB+HtUURF7NYd1t49cWz8cMYu7bRykWnDa7NDU9qIOUfx7
         ZF1/IAD4z6fXoDH+GfPJcLhIklJHvPnNBtJa9+k+JveVNi58sYT7mmKcucwpqWGTPc77
         h7Rg==
X-Gm-Message-State: APjAAAVbFEZNYDDLkIGtRh9uTwmknBtNLullAkOiM4X2jiMD89VtL1AW
        xJLMpxwgJtQ0Fb2SdZM3CRqKZA==
X-Google-Smtp-Source: APXvYqxRKGAwKo0zopfJjMo09GhkRf6idef1XrBcgk7k+D4HJD/XZ9UndPzm9f1Mpn9zihgU/3EKZg==
X-Received: by 2002:a63:1e1f:: with SMTP id e31mr2816686pge.303.1571738863006;
        Tue, 22 Oct 2019 03:07:43 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id h186sm22715430pfb.63.2019.10.22.03.07.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Oct 2019 03:07:39 -0700 (PDT)
Date:   Tue, 22 Oct 2019 15:37:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Move cancelling of policy update work just
 after removing notifiers
Message-ID: <20191022100736.sguepyp2t56peqfr@vireshk-i7>
References: <20191021132818.23787-1-sudeep.holla@arm.com>
 <20191022022508.g3ar735237haybxe@vireshk-i7>
 <CAJZ5v0gEbiyjpT4+RG5ytDHOgcyCHFqOgD59bK6h=Fhbqvv7Tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gEbiyjpT4+RG5ytDHOgcyCHFqOgD59bK6h=Fhbqvv7Tw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-10-19, 11:46, Rafael J. Wysocki wrote:
> On Tue, Oct 22, 2019 at 4:25 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 21-10-19, 14:28, Sudeep Holla wrote:
> > > Commit 099967699ad9 ("cpufreq: Cancel policy update work scheduled before freeing")
> > > added cancel_work_sync(policy->update) after the frequency QoS were
> > > removed. We can cancel the work just after taking the last CPU in the
> > > policy offline and unregistering the notifiers as policy->update cannot
> > > be scheduled from anywhere at this point.
> > >
> > > However, due to other bugs, doing so still triggered the race between
> > > freeing of policy and scheduled policy update work. Now that all those
> > > issues are resolved, we can move this cancelling of any scheduled policy
> > > update work just after removing min/max notifiers.
> > >
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > ---
> > >  drivers/cpufreq/cpufreq.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > Hi Rafael,
> > >
> > > Based on Viresh's suggestion, I am posting a patch to move this
> > > cancel_work_sync earlier though it's not a must have change.
> >
> > For me it is :)
> >
> > > I will leave it up to your preference.
> > >
> > > Regards,
> > > Sudeep
> > >
> > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > index 829a3764df1b..48a224a6b178 100644
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -1268,6 +1268,9 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
> > >       freq_qos_remove_notifier(&policy->constraints, FREQ_QOS_MIN,
> > >                                &policy->nb_min);
> > >
> > > +     /* Cancel any pending policy->update work before freeing the policy. */
> > > +     cancel_work_sync(&policy->update);
> > > +
> > >       if (policy->max_freq_req) {
> > >               /*
> > >                * CPUFREQ_CREATE_POLICY notification is sent only after
> > > @@ -1279,8 +1282,6 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
> > >       }
> > >
> > >       freq_qos_remove_request(policy->min_freq_req);
> > > -     /* Cancel any pending policy->update work before freeing the policy. */
> > > -     cancel_work_sync(&policy->update);
> > >       kfree(policy->min_freq_req);
> > >
> > >       cpufreq_policy_put_kobj(policy);
> >
> > Thanks for doing this.
> >
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Folded into the previous patch and applied.
> 
> Please double check the result in the current linux-next branch in my tree.

I would have kept the blank line after cancel_work_sync() which isn't
there anymore.

-- 
viresh
