Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6416D717FA5
	for <lists+linux-pm@lfdr.de>; Wed, 31 May 2023 14:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjEaMJU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 May 2023 08:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjEaMJT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 May 2023 08:09:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 544CDA0
        for <linux-pm@vger.kernel.org>; Wed, 31 May 2023 05:09:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 191161042;
        Wed, 31 May 2023 05:10:03 -0700 (PDT)
Received: from R5WKVNH4JW (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75A543F67D;
        Wed, 31 May 2023 05:09:15 -0700 (PDT)
Date:   Wed, 31 May 2023 14:09:08 +0200
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [CfP] Power Management and Thermal Control MC (LPC2023)
Message-ID: <ZHc4SqgVUe56P8lc@R5WKVNH4JW>
References: <CAJZ5v0juUuy2xKZHMXAKSRtfQxMyL6z12AFdU8_ZbdFRKKrR=Q@mail.gmail.com>
 <ZHcebApf6WCPMxPa@R5WKVNH4JW>
 <CAKfTPtAkCTE+Ef1yqc-CqftfmQnCzm85gpMrWWm5s=qK85Xk1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAkCTE+Ef1yqc-CqftfmQnCzm85gpMrWWm5s=qK85Xk1A@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Vincent,

On Wed, May 31, 2023 at 01:07:26PM +0200, Vincent Guittot wrote:
> Hi Morten,
> 
> On Wed, 31 May 2023 at 12:16, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> >
> > Hi Rafael,
> >
> > Thanks for organizing the micro-conference at LPC again this year.
> >
> > On Mon, May 22, 2023 at 07:12:39PM +0200, Rafael J. Wysocki wrote:
> > > Hi Folks,
> > >
> > > I'm going to submit a Power Management and Thermal Control
> > > micro-conference proposal for LPC2023 along the lines of what happened
> > > in the previous iterations of it.
> > >
> > > If you have topics that you'd like to be discussed there, please let
> > > me know by Friday, May 26.
> > >
> > > Please note that LPC MC topics are expected to cover work in progress
> > > or at the concept stage.  They are not supposed to be about work that
> > > has been done already.
> >
> > A late proposal, if the agenda isn't already full, is to discuss the
> > deeper implications of uclamp in CFS relating to fairness, latency, and
> > energy savings. uclamp is being adopted in the Android community for
> > controlling performance/energy savings but alignment with upstream is
> > lacking behind.
> 
> With Daniel, Juri and Steven, we have submitted a "Real-time and
> Scheduling MC" which is not yet accepted (so it's not yet publicly
> visible).  But this could be a better place to discuss CFS changes.

That could work too. It is closely related to PM though as uclamp is
essentially putting the power/performance policy directly in the
scheduler. With the right people around it doesn't matter where it is
discussed :-)

Morten
