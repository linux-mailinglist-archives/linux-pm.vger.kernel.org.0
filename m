Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D599FE085D
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2019 18:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfJVQLj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Oct 2019 12:11:39 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36930 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfJVQLj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Oct 2019 12:11:39 -0400
Received: by mail-ot1-f65.google.com with SMTP id 53so3067961otv.4;
        Tue, 22 Oct 2019 09:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qlFpjPqwrKm9MJZBKWrL3lYlnTOZRR36fjtod+pxjlg=;
        b=O+SlIIEXrfPtzBr2MXZifvBbDYjiea20aWCfdAVXjEhNDCF3IJw27ilT/w942x02fm
         z7KhWKEv5RNnjN5lHxNeLByEU47w8cZEk7mdf5khyegd3yQ3b/4YwqCTVo26dgZlUZd3
         urcytFmbjr5irvMT4bIrw3TWReGMyi/jNRBIN7vyU+xBv5iyekDTPwQ4/lBC35GRDIrZ
         94u+wl3Le8st4+O4UZSnD26pwO1M/MKfSqSrEdHA/KiGDHRkaRWN5S/lp6PnfzRBMTA9
         OWgRPJE2bdSXwpS5srG2TdtVCwnjhPxoXSsliyk8skDJcXMHX6HO2hdgYbji3TJilWn3
         DkuA==
X-Gm-Message-State: APjAAAU/VJB7D8jsirZIktpUQXdZBYB34tHxCTSYGWI6H03xPJLNBeBs
        3yBnL7OEIzp0wf13M7OT2oi1vXnxCmtc/cv0iTM=
X-Google-Smtp-Source: APXvYqx3r0pg5wNHcKf52wGFqqCCeQDWDahFYAHD22kHuprsjU3b/z6v6JTbTtf3YhD6d7CiotdExo3lW5b2H2fZNvc=
X-Received: by 2002:a9d:459b:: with SMTP id x27mr3235413ote.167.1571760698020;
 Tue, 22 Oct 2019 09:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <20191021132818.23787-1-sudeep.holla@arm.com> <20191022022508.g3ar735237haybxe@vireshk-i7>
 <CAJZ5v0gEbiyjpT4+RG5ytDHOgcyCHFqOgD59bK6h=Fhbqvv7Tw@mail.gmail.com> <20191022100736.sguepyp2t56peqfr@vireshk-i7>
In-Reply-To: <20191022100736.sguepyp2t56peqfr@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Oct 2019 18:11:26 +0200
Message-ID: <CAJZ5v0g0e7NAb74h565sxnfzeYdDJOzcEiS9NyuNEvtdpL3hUA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Move cancelling of policy update work just after
 removing notifiers
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 22, 2019 at 12:07 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 22-10-19, 11:46, Rafael J. Wysocki wrote:
> > On Tue, Oct 22, 2019 at 4:25 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 21-10-19, 14:28, Sudeep Holla wrote:
> > > > Commit 099967699ad9 ("cpufreq: Cancel policy update work scheduled before freeing")
> > > > added cancel_work_sync(policy->update) after the frequency QoS were
> > > > removed. We can cancel the work just after taking the last CPU in the
> > > > policy offline and unregistering the notifiers as policy->update cannot
> > > > be scheduled from anywhere at this point.
> > > >
> > > > However, due to other bugs, doing so still triggered the race between
> > > > freeing of policy and scheduled policy update work. Now that all those
> > > > issues are resolved, we can move this cancelling of any scheduled policy
> > > > update work just after removing min/max notifiers.
> > > >
> > > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > > ---
> > > >  drivers/cpufreq/cpufreq.c | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > >
> > > > Hi Rafael,
> > > >
> > > > Based on Viresh's suggestion, I am posting a patch to move this
> > > > cancel_work_sync earlier though it's not a must have change.
> > >
> > > For me it is :)
> > >
> > > > I will leave it up to your preference.
> > > >
> > > > Regards,
> > > > Sudeep
> > > >
> > > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > > index 829a3764df1b..48a224a6b178 100644
> > > > --- a/drivers/cpufreq/cpufreq.c
> > > > +++ b/drivers/cpufreq/cpufreq.c
> > > > @@ -1268,6 +1268,9 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
> > > >       freq_qos_remove_notifier(&policy->constraints, FREQ_QOS_MIN,
> > > >                                &policy->nb_min);
> > > >
> > > > +     /* Cancel any pending policy->update work before freeing the policy. */
> > > > +     cancel_work_sync(&policy->update);
> > > > +
> > > >       if (policy->max_freq_req) {
> > > >               /*
> > > >                * CPUFREQ_CREATE_POLICY notification is sent only after
> > > > @@ -1279,8 +1282,6 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
> > > >       }
> > > >
> > > >       freq_qos_remove_request(policy->min_freq_req);
> > > > -     /* Cancel any pending policy->update work before freeing the policy. */
> > > > -     cancel_work_sync(&policy->update);
> > > >       kfree(policy->min_freq_req);
> > > >
> > > >       cpufreq_policy_put_kobj(policy);
> > >
> > > Thanks for doing this.
> > >
> > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >
> > Folded into the previous patch and applied.
> >
> > Please double check the result in the current linux-next branch in my tree.
>
> I would have kept the blank line after cancel_work_sync() which isn't
> there anymore.

OK, it looks better with the extra blank line, so updated.  Thanks!
