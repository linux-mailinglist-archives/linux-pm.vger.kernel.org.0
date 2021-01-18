Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5E72F9D7D
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 12:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388110AbhARLFB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jan 2021 06:05:01 -0500
Received: from foss.arm.com ([217.140.110.172]:33254 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389479AbhARLE3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 18 Jan 2021 06:04:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 795DB1FB;
        Mon, 18 Jan 2021 03:03:43 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AE6C3F68F;
        Mon, 18 Jan 2021 03:03:43 -0800 (PST)
Date:   Mon, 18 Jan 2021 11:03:41 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Andy Gross <agross@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: qcom-hw: add missing devm_release_mem_region()
 call
Message-ID: <20210118110341.GA18935@arm.com>
References: <20210112095236.20515-1-shawn.guo@linaro.org>
 <X/210llTiuNt3haG@builder.lan>
 <20210113043143.y45mmnw3e2kjkxnl@vireshk-i7>
 <X/5+GbueKg66DoEE@builder.lan>
 <20210113050651.q2txref3d6bifrf3@vireshk-i7>
 <20210118064316.nuo6ivetefxt63n6@vireshk-i7>
 <CAAQ0ZWTBohYPL5xtcG=T=nz1L40qYtUaWrwsgiHZykyGi4xh3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAQ0ZWTBohYPL5xtcG=T=nz1L40qYtUaWrwsgiHZykyGi4xh3g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Monday 18 Jan 2021 at 14:54:11 (+0800), Shawn Guo wrote:
> On Mon, Jan 18, 2021 at 2:43 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 13-01-21, 10:36, Viresh Kumar wrote:
> > > On 12-01-21, 22:59, Bjorn Andersson wrote:
> > > > But that said, why are the ioremap done at init and not at probe time?
> > >
> > > These are some hardware registers per cpufreq policy I believe, and so
> > > they did it from policy init instead.
> > >
> > > And yes I agree that we shouldn't use devm_ from init() for the cases
> > > where we need to put the resources in exit() as well. But things like
> > > devm_kzalloc() are fine there.
> > >
> > > Ionela, since you were the first one to post a patch about this, can
> > > you send a fix for this by dropping the devm_ thing altogether for the
> > > ioremap thing ? Mark it suggested by Bjorn. Thanks.
> >
> > Ionela, I hope you are working on this so we can get it fixed quickly
> > ?
> 
> Let me take it over.  I will try to send a patch out today.
> 

I did not get any cycles for this until today. I'm happy for you Shawn to
take it over if you'd like, and I'm happy to review and test.

Thanks,
Ionela.

> Shawn
