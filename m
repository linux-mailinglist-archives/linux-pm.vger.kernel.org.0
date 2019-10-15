Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE552D7B08
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 18:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387838AbfJOQSF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 12:18:05 -0400
Received: from foss.arm.com ([217.140.110.172]:42276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387829AbfJOQSF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Oct 2019 12:18:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A97F337;
        Tue, 15 Oct 2019 09:18:05 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 984D73F68E;
        Tue, 15 Oct 2019 09:18:04 -0700 (PDT)
Date:   Tue, 15 Oct 2019 17:17:59 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: NULL pointer dereference in cpufreq_set_policy
Message-ID: <20191015161759.GA16693@bogus>
References: <20191015155735.GA29105@bogus>
 <CAJZ5v0g04KoF3pQk4=3cTyyPsKdgLV+ZrO63k44HvySss1xJ=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g04KoF3pQk4=3cTyyPsKdgLV+ZrO63k44HvySss1xJ=g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 15, 2019 at 06:08:14PM +0200, Rafael J. Wysocki wrote:
> On Tue, Oct 15, 2019 at 5:57 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > Hi Viresh,
> >
> > I was trying to unify Vexpress SPC driver and arm_big_little generic
> > driver as it's the only user of bL driver and switcher in the mainline.
> > I did this a while ago(v5.3) and encountered the kernel crash with NULL
> > pointer reference(crash log with some debug enabled below).
> >
> > Since dev_pm_qos_* was added in v5.3 with the Commit 18c49926c4bf
> > ("cpufreq: Add QoS requests for userspace constraints"), I just tried
> > reverting that and it fixed the crash. I haven't spent much time
> > debugging, since it has been for a while I wanted to report it.
> 
> This looks like another manifestation of the bug discussed here:
> https://lore.kernel.org/linux-pm/5ad2624194baa2f53acc1f1e627eb7684c577a19.1562210705.git.viresh.kumar@linaro.org/T/#md2d89e95906b8c91c15f582146173dce2e86e99f

Indeed, it reminded me to dig up the setup, try again and report this
bug before I forget again about the issue as this platform is in back
burner and not priority :)

--
Regards,
Sudeep
