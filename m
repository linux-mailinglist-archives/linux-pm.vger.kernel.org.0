Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE9BDA97D
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 11:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439608AbfJQJ6w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 05:58:52 -0400
Received: from [217.140.110.172] ([217.140.110.172]:37676 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2393881AbfJQJ6v (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 17 Oct 2019 05:58:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 237D51AED;
        Thu, 17 Oct 2019 02:58:29 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 561803F718;
        Thu, 17 Oct 2019 02:58:28 -0700 (PDT)
Date:   Thu, 17 Oct 2019 10:58:26 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/3] cpufreq: merge arm_big_little and vexpress-spc
Message-ID: <20191017095826.GE8978@bogus>
References: <20191016110344.15259-1-sudeep.holla@arm.com>
 <20191016110344.15259-3-sudeep.holla@arm.com>
 <20191017023936.vgkdfnyaz3r4k74z@vireshk-i7>
 <20191017092628.GD8978@bogus>
 <20191017093022.du76n64kwzqibqhs@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017093022.du76n64kwzqibqhs@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 17, 2019 at 03:00:22PM +0530, Viresh Kumar wrote:
> On 17-10-19, 10:26, Sudeep Holla wrote:
> > On Thu, Oct 17, 2019 at 08:09:36AM +0530, Viresh Kumar wrote:
> > > On 16-10-19, 12:03, Sudeep Holla wrote:
> > > > arm_big_little cpufreq driver was designed as a generic big little
> > > > driver that could be used by any platform and make use of bL switcher.
> > > > Over years alternate solutions have be designed and merged to deal with
> > > > bL/HMP systems like EAS.
> > > >
> > > > Also since no other driver made use of generic arm_big_little cpufreq
> > > > driver except Vexpress SPC, we can merge them together as vexpress-spc
> > > > driver used only on Vexpress TC2(CA15_CA7) platform.
> > > >
> > > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > > ---
> > > >  MAINTAINERS                            |   5 +-
> > > >  drivers/cpufreq/Kconfig.arm            |  12 +-
> > > >  drivers/cpufreq/Makefile               |   2 -
> > > >  drivers/cpufreq/arm_big_little.c       | 658 ------------------------
> > > >  drivers/cpufreq/arm_big_little.h       |  43 --
> > > >  drivers/cpufreq/vexpress-spc-cpufreq.c | 661 ++++++++++++++++++++++++-
> > > >  6 files changed, 652 insertions(+), 729 deletions(-)
> > > >  delete mode 100644 drivers/cpufreq/arm_big_little.c
> > > >  delete mode 100644 drivers/cpufreq/arm_big_little.h
> > >
> > > The delta produced here is enormous probably because you copy/pasted things. I
> > > am wondering if using git mv to rename arm_big_little.c and then move spc bits
> > > into it will make this delta smaller to review ?
> > >
> >
> > Yes, I did a quick try but slightly different order. As I need the final
> > driver to be vexpress-spc-cpufreq.c, I am thinking of first merging
> > vexpress-spc-cpufreq.c into arm_big_little.c and then renaming it back
> > later. Does that sound good ?
>
> Maybe git can produce short diff even if you do this in a single patch. But two
> would be fine if that makes me review lesss stuff :)
>

You are right, I was so sure that -M is the option and got convinced
that it's not working for this change, but what I needed was -B for
format-patch. Thanks for reminding again and making me look harder ;)

--
Regards,
Sudeep
