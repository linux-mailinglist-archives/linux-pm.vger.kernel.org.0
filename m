Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF05CD8B90
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 10:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732775AbfJPInr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 04:43:47 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39617 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbfJPInr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 04:43:47 -0400
Received: by mail-oi1-f194.google.com with SMTP id w144so19339121oia.6;
        Wed, 16 Oct 2019 01:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dg2J0niQMCT6Z5y5BBQlerOQRn1zPEoYqtOLluuNJXg=;
        b=Gy8mLX8ITS941h6+6LYaW01+QLjGF4ymhRVbxASmzOE12aPu1ETz9JGTG2K7grp2ze
         3hHHjnr8oNmAn4zpyXhGj/PWG4nhNP+5Y1gDoo0koR4drRAiwzRnKBAt+dts3IBdRWfU
         mEgVYSf/VZMZyj89WA8TurVb0b5nAjWwDWFBaSoucjYP9s5YOxSr59x46DpN3h/so9gv
         UkfS83h5M5eBf0Wo8dGOZJe9I0c5hzkXLiZn0atQiHOafjrKcfJKSIvoBvtza79cLDr9
         nk9pRkh6rrCjF/2k/Nq8fdTaUjzy8ovSL0rEGOohAwG2qotHgUg+rMfqGJpRCEpUfdeF
         U7FA==
X-Gm-Message-State: APjAAAVF7rSTS8U/affJnSB0I0D2wDSKyPIZ8X6YrXI0kR5BfhiZL2j1
        eoH/oTazd40SM4PwniZhblrbM8Mi9EBWfWqRtrw=
X-Google-Smtp-Source: APXvYqwLDwsEcM2k51IhaToIeEdjXU0WpTfJyZtwPC7Vpz4JkXsAhfr8H4jtDscd/SKmdImFvmWvH9d8Mev4+N2mOYM=
X-Received: by 2002:a05:6808:917:: with SMTP id w23mr2359694oih.68.1571215424642;
 Wed, 16 Oct 2019 01:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <5ad2624194baa2f53acc1f1e627eb7684c577a19.1562210705.git.viresh.kumar@linaro.org>
 <2c7a751a58adb4ce6f345dab9714b924504009b6.1562583394.git.viresh.kumar@linaro.org>
 <a1c503a7-6136-a405-369c-596a680183f2@gmail.com> <20191015114637.pcdbs2ctxl4xoxdo@vireshk-i7>
 <CAJZ5v0g3kRfa2WXy=xz3Mj15Pwb5tm1xg=uPODoifnv70O1ORA@mail.gmail.com>
 <CAJZ5v0hxsy3ZKFvtWULHAVog4=3rYQfd3-61A9dNaKeUbiDtrg@mail.gmail.com> <20191016082742.nttzuofes6uds4pu@vireshk-i7>
In-Reply-To: <20191016082742.nttzuofes6uds4pu@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Oct 2019 10:43:33 +0200
Message-ID: <CAJZ5v0hwaF3kvBHj6yoSJ8AQPOA00jTxMt7fv=k7YYGkL2jdMg@mail.gmail.com>
Subject: Re: [PATCH V7 5/7] cpufreq: Register notifiers with the PM QoS framework
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 16, 2019 at 10:27 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 15-10-19, 23:50, Rafael J. Wysocki wrote:
> > On Tue, Oct 15, 2019 at 5:53 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> > > > - Update QoS framework with the knowledge of related CPUs, this has been pending
> > > >   until now from my side. And this is the thing we really need to do. Eventually
> > > >   we shall have only a single notifier list for all CPUs of a policy, at least
> > > >   for MIN/MAX frequencies.
> > >
> > > - Move the PM QoS requests and notifiers to the new policy CPU on all
> > > changes of that.  That is, when cpufreq_offline() nominates the new
> > > "leader", all of the QoS stuff for the policy needs to go to this one.
> >
> > Alas, that still will not work, because things like
> > acpi_processor_ppc_init() only work accidentally for one-CPU policies.
>
> I am not sure what problem you see here ? Can you please explain a bit more.

Never mind, sorry.  This is called for policy->cpu too.

> > Generally, adding such a PM QoS request to a non-policy CPU simply has
> > no effect until it becomes a policy CPU which may be never.
>
> I was thinking maybe we can read the constraints for all CPUs in the
> policy->cpus mask in cpufreq_set_policy() and so this part of the problem will
> just go away. The only part that would be left is to remove the QoS constraints
> properly.

That would be on the complicated side IMO.

> > It looks like using device PM QoS for cpufreq is a mistake in general
> > and what is needed is a struct pm_qos_constraints member in struct
> > cpufreq_policy and something like
> >
> > struct freq_pm_qos_request {
> >         enum freq_pm_qos_req_type type; /* min or max */
> >         struct plist_node pnode;
> >         struct cpufreq_policy *policy;
> > };
> >
> > Then, pm_qos_update_target() can be used for adding, updating and
> > removing requests.

I have patches implementing this idea, more or less, almost ready,
stay tuned. :-)
