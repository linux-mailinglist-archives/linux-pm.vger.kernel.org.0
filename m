Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE181A1044
	for <lists+linux-pm@lfdr.de>; Tue,  7 Apr 2020 17:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgDGPfa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Apr 2020 11:35:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:55530 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729127AbgDGPfa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Apr 2020 11:35:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D84BAAC77;
        Tue,  7 Apr 2020 15:35:27 +0000 (UTC)
Message-ID: <1586273727.1721.20.camel@suse.cz>
Subject: Re: [PATCH 0/2] cpufreq: intel_pstate: Run in the passive mode by
 default on systems without HWP
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Doug Smythies <dsmythies@telus.net>
Date:   Tue, 07 Apr 2020 17:35:27 +0200
In-Reply-To: <2016232.ihCVsphvri@kreacher>
References: <2016232.ihCVsphvri@kreacher>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 2020-03-28 at 13:54 +0100, Rafael J. Wysocki wrote:
> Hi All,
> 
> These two patches modify the intel_pstate driver to run in the passive mode by
> default on systems without HWP (refer to the changelog of patch [2/2] for the
> motivation part).
> 
> Internal testing of the system performance in 5.6-rc indicates that the
> difference between the active mode with the powersave scaling algorithm and the
> passive mode with the schedutil governor should be negligible for the majority
> of users, so it should be safe to change the default behavior of the driver as
> per the above.
> 
> Patch [1/2] makes changes to select the schedutil governor and set it as the
> default one when intel_pstate is selected in Kconfig.
> 
> Patch [2/2] changes intel_pstate to start in the passive by default if HWP is
> not supported (or if it is disabled via the kernel command line).
> 
> Please refer to the patch changelogs for more information.
> 

Hello Rafael,

just to say that I'm very happy about this patch; I see it as a sensible
roll-out strategy for wide adoption of schedutil on x86, as it initially
applies to non-HWP only and not to the entire processor model range. As we get
more reports of its behavior on the field, we'll see when and how to move
forward from there.

I didn't reply last week as I was handling some bug reports for frequency
invariance on x86; one from LKML (Chris Wilson from Intel found that it
crashes when cpu0 is taken offline) and two more reported internally at
SUSE. Nothing major though, I am writing fixes for all those and will send
a bugfix series within the next few days.


Thanks!
Giovanni
