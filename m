Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE1541F56C
	for <lists+linux-pm@lfdr.de>; Fri,  1 Oct 2021 21:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhJATGb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Oct 2021 15:06:31 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:35397 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhJATGb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Oct 2021 15:06:31 -0400
Received: by mail-oi1-f174.google.com with SMTP id n64so12670585oih.2;
        Fri, 01 Oct 2021 12:04:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6kWvsqS9wtvwiaERR1Va8UItEXxGSeZlzApY0N8G3rE=;
        b=q94lhcFZLqGuzJpezvCiw8fS3mZssVIacMfRks9iZu7EhlaV52myfGaJEJs8wenHms
         yAhIjtjL4GVWAyPQE67iMQXelm7eDT+C2urNhqWJ0Do+XzlU2C6hdvAkyH+62CbtBYDD
         XwEFKTGQCuAFk+NcL5X+cMqyOC4f4mLLtESgfwZB/g1J4rtCNz3eBdSw8B//aLiK//It
         ka5YWFMf7O3GJtT6n6T2GHyAkT9fxSi5KYGa72f3GKaxnemH+YUu6rV9rtfjxzgZ0frl
         /X2QJIX9Ttjj2c/U+yOBOLwcqvDzFBVoPc58rD4VKaUO2EQxlNoaYreowNnY4aJHA2PS
         XMBA==
X-Gm-Message-State: AOAM533zK3hZnCHlG35ggnsJFBTZ78cliHEkPZk4+18koq6eNvkSYBk4
        paf3r5MvsTdJzCq7+T2YfvdF0dZjbjkdJyPizC8=
X-Google-Smtp-Source: ABdhPJwkJ1z1pZjMxWjmM/JFqZfk81xzq1QVWsHMICaYKew+bU3RpBJyonPfV4yRXS3vbFfo9JHBvc+qP2NyUlBFBLk=
X-Received: by 2002:a05:6808:1816:: with SMTP id bh22mr4979269oib.69.1633115086415;
 Fri, 01 Oct 2021 12:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210928164217.950960-1-srinivas.pandruvada@linux.intel.com>
 <CAJZ5v0jzbm5xnFSceQNmZjDQ0eU=i_f_WnDcoa05rEQ083mDkg@mail.gmail.com> <5b5f8adcf441494c5e17b9fb47dc42f345c737f2.camel@linux.intel.com>
In-Reply-To: <5b5f8adcf441494c5e17b9fb47dc42f345c737f2.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 1 Oct 2021 21:04:35 +0200
Message-ID: <CAJZ5v0iVMfz2joKiWK05FLpDyQTQj4RFAoE9Mc_RHbaUA1qRvw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Process HWP Guaranteed change notification
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, pablomh@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 1, 2021 at 9:01 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Fri, 2021-10-01 at 20:52 +0200, Rafael J. Wysocki wrote:
> > On Tue, Sep 28, 2021 at 6:42 PM Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >
> > > It is possible that HWP guaranteed ratio is changed in response to
> > > change in power and thermal limits. For example when Intel Speed
> > > Select
> > > performance profile is changed or there is change in TDP, hardware
> > > can
> > > send notifications. It is possible that the guaranteed ratio is
> > > increased. This creates an issue when turbo is disabled, as the old
> > > limits set in MSR_HWP_REQUEST are still lower and hardware will
> > > clip
> > > to older limits.
> > >
> > > This change enables HWP interrupt and process HWP interrupts. When
> > > guaranteed is changed, calls cpufreq_update_policy() so that driver
> > > callbacks are called to update to new HWP limits. This callback
> > > is called from a delayed workqueue of 10ms to avoid frequent
> > > updates.
> > >
> > > Although the scope of IA32_HWP_INTERRUPT is per logical cpu, on
> > > some
> > > plaforms interrupt is generated on all CPUs. This is particularly a
> > > problem during initialization, when the driver didn't allocated
> > > data for other CPUs. So this change uses a cpumask of enabled CPUs
> > > and
> > > process interrupts on those CPUs only.
> > >
> > > When the cpufreq offline() or suspend()callback is called, HWP
> > > interrupt
> > > is disabled on those CPUs and also cancels any pending work item.
> > >
> > > Spin lock is used to protect data and processing shared with
> > > interrupt
> > > handler. Here READ_ONCE(), WRITE_ONCE() macros are used to
> > > designate
> > > shared data, even though spin lock act as an optmization barrier
> > > here.
> > >
> > > Signed-off-by: Srinivas Pandruvada <
> > > srinivas.pandruvada@linux.intel.com>
> > > ---
> > > This patch is a replacement from the patch submitted to 5.15 and
> > > later
> > > reverted.
> >
> > Applied as 5.16 material, thanks!
> I got email that pablo (pablomh@gmail.com) tested this. So he can added
> Tested-by also pointed out typo in "optmization".
> Shall I send a patch with this change?

No need, I will update the commit in the tree.
