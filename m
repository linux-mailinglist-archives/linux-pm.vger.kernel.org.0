Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2385A1BDC3F
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 14:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgD2Mcm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 08:32:42 -0400
Received: from foss.arm.com ([217.140.110.172]:38280 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbgD2Mcl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Apr 2020 08:32:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E87BA1063;
        Wed, 29 Apr 2020 05:32:40 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5CF133F73D;
        Wed, 29 Apr 2020 05:32:39 -0700 (PDT)
Date:   Wed, 29 Apr 2020 13:32:37 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Todd E Brandt <todd.e.brandt@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] Revert "cpu/hotplug: Ignore pm_wakeup_pending() for
 disable_nonboot_cpus()"
Message-ID: <20200429123236.7iqeon4emnlriyc4@e107158-lin>
References: <20200409112742.3581-1-qais.yousef@arm.com>
 <26038947.HFycnDbHsR@kreacher>
 <20200427102910.b6iysyumiz5pj4sv@e107158-lin>
 <CAJZ5v0gesatUBMdt0c30tg34mTeFOon=7ntzQq88=tfJLy8CtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gesatUBMdt0c30tg34mTeFOon=7ntzQq88=tfJLy8CtA@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/29/20 12:40, Rafael J. Wysocki wrote:
> On Mon, Apr 27, 2020 at 12:29 PM Qais Yousef <qais.yousef@arm.com> wrote:
> >
> > On 04/26/20 17:24, Rafael J. Wysocki wrote:
> > > I would do this the other way around:
> > >
> > > 1. Make x86 call freeze_secondary_cpus() directly, rename
> > >    enable_nonboot_cpus() and drop disable_nonboot_cpus().
> >
> > All of this in a single patch?
> 
> Well, why not?

I don't mind, was just clarifying. Usually it's requested to split patches :)

> 
> Calling freeze_secondary_cpus() directly causes disable_nonboot_cpus()
> to be unused (and so it can be dropped in the same patch) and it also
> introduces a name mismatch between freeze_ and enable_, which IMO
> needs to be addressed right away (also in the same patch).
> 
> > > 2. Get rid of __freeze_secondary_cpus().
> >
> > I guess you're implying to drop the revert too and manually unroll it instead.
> 
> IMO the revert is just an extra step with no real value, so why do it?

Works for me. Will send v2 ASAP.

Thanks

--
Qais Yousef
