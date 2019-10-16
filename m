Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8A86D8AEA
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 10:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391668AbfJPI1v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 04:27:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37325 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391658AbfJPI1v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 04:27:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id p1so13842683pgi.4
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 01:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZBU8KtWqaPlvm9aGAuLUyV54XDJ4T42xfnXwt2IbHm8=;
        b=jaTe+Z9SL0l41r3xbeeskPOYmc7zKJ2qW2CcVNLyMJ+gQLe4dCAo4PkjkWGbaL+c0m
         i+syX0nJ5qzIDEwxSgnMC4xZ5aGfqFF8XIEn3FFlFy4gbRwv0eFQ+3dSlAIVSMq7G4ZP
         rYHk54WTHVtVLS1SIdW65A58XjG7vn9VQ9JgP2ot90BjseIpHPsmduKA6Lnt4OLFuq3v
         TmYp9mUdp8GmOSLbVZ17GsE44I+w8D9qQM0PgsoGOBcNzurEN+0JdUM9fIfOXgRBc1Vi
         tRQicfje5MGgwtZ9e/Nflt0Bx8rP+pq/KtBkHECpDJEjmrBkGJgNQK8AKrW/jMw8xTa3
         nrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZBU8KtWqaPlvm9aGAuLUyV54XDJ4T42xfnXwt2IbHm8=;
        b=PCpxaY1rruyoDyVRygFgFmNb1HePqhLqgc0uEA2MTWEIRLLZOSmnhLoOryk9tzy+7l
         lvKKrPS5Mdr9IkCdHPbjnZ087bTOKUegAAYYEMA4JSMfBvUREVirSBAt1IjeJ56bkjO8
         np2Fs3x9sil9GpMpEd4C5y7nMndhMuCE9hMF9EDJ/g7LUosEHrqebaJXbtf7o1jcl7Ss
         Q/GP0ym2Oz3kPQrxMw4frwsqQjq+gFAVHHw2yKQ7pbv866hshiBFXQvOd2FQkQXq2TaT
         1jkLra8nUu5t+2Dz0WZY0dX70D+ecpGlMepswGktxJggs/0Ao263qT8jk2B8So5lBEh/
         BEvw==
X-Gm-Message-State: APjAAAVSiSevgNMWlpByk1T1tVed4kJx6CO4rsF0+eTxawEJBirRHuwy
        Lxa+njjqze4W5QEVZwQnX59K2A==
X-Google-Smtp-Source: APXvYqw2HuEJr6hFR0qslv2UzEWwBhoszStKl4ceu9NlZWQejXp2FiWt/eWTKHoyvc3xDCv3gvPwKA==
X-Received: by 2002:a17:90a:2425:: with SMTP id h34mr3519628pje.113.1571214469897;
        Wed, 16 Oct 2019 01:27:49 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id x11sm9580112pja.3.2019.10.16.01.27.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 01:27:49 -0700 (PDT)
Date:   Wed, 16 Oct 2019 13:57:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH V7 5/7] cpufreq: Register notifiers with the PM QoS
 framework
Message-ID: <20191016082742.nttzuofes6uds4pu@vireshk-i7>
References: <5ad2624194baa2f53acc1f1e627eb7684c577a19.1562210705.git.viresh.kumar@linaro.org>
 <2c7a751a58adb4ce6f345dab9714b924504009b6.1562583394.git.viresh.kumar@linaro.org>
 <a1c503a7-6136-a405-369c-596a680183f2@gmail.com>
 <20191015114637.pcdbs2ctxl4xoxdo@vireshk-i7>
 <CAJZ5v0g3kRfa2WXy=xz3Mj15Pwb5tm1xg=uPODoifnv70O1ORA@mail.gmail.com>
 <CAJZ5v0hxsy3ZKFvtWULHAVog4=3rYQfd3-61A9dNaKeUbiDtrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hxsy3ZKFvtWULHAVog4=3rYQfd3-61A9dNaKeUbiDtrg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-10-19, 23:50, Rafael J. Wysocki wrote:
> On Tue, Oct 15, 2019 at 5:53 PM Rafael J. Wysocki <rafael@kernel.org> wrote:

> > > - Update QoS framework with the knowledge of related CPUs, this has been pending
> > >   until now from my side. And this is the thing we really need to do. Eventually
> > >   we shall have only a single notifier list for all CPUs of a policy, at least
> > >   for MIN/MAX frequencies.
> >
> > - Move the PM QoS requests and notifiers to the new policy CPU on all
> > changes of that.  That is, when cpufreq_offline() nominates the new
> > "leader", all of the QoS stuff for the policy needs to go to this one.
> 
> Alas, that still will not work, because things like
> acpi_processor_ppc_init() only work accidentally for one-CPU policies.

I am not sure what problem you see here ? Can you please explain a bit more.

> Generally, adding such a PM QoS request to a non-policy CPU simply has
> no effect until it becomes a policy CPU which may be never.

I was thinking maybe we can read the constraints for all CPUs in the
policy->cpus mask in cpufreq_set_policy() and so this part of the problem will
just go away. The only part that would be left is to remove the QoS constraints
properly.

> It looks like using device PM QoS for cpufreq is a mistake in general
> and what is needed is a struct pm_qos_constraints member in struct
> cpufreq_policy and something like
> 
> struct freq_pm_qos_request {
>         enum freq_pm_qos_req_type type; /* min or max */
>         struct plist_node pnode;
>         struct cpufreq_policy *policy;
> };
> 
> Then, pm_qos_update_target() can be used for adding, updating and
> removing requests.

-- 
viresh
