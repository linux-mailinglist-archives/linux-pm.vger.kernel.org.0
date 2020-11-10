Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711232AD6DF
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 13:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbgKJMxL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 07:53:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:60656 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgKJMxK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Nov 2020 07:53:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A4F4CABDE;
        Tue, 10 Nov 2020 12:53:09 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.de>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: stats: Switch to ktime and msec instead of jiffies and usertime
Date:   Tue, 10 Nov 2020 13:53:08 +0100
Message-ID: <1832747.5iOEhN7m9D@c100>
In-Reply-To: <0e0fb542b6f6b26944cb2cf356041348aeac95f6.1605006378.git.viresh.kumar@linaro.org>
References: <0e0fb542b6f6b26944cb2cf356041348aeac95f6.1605006378.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Dienstag, 10. November 2020, 12:07:37 CET schrieb Viresh Kumar:
> The cpufreq and thermal core, both provide sysfs statistics to help
> userspace learn about the behavior of frequencies and cooling states.
> 
> This is how they look:
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:1200000 399
 
> The results look like this after this commit:
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:1200000 3830

How would userspace know whether it's ms or 10ms?

whatabout a new file with the same convention as cooling devices (adding ms):
 
> /sys/class/thermal/cooling_device0/stats/time_in_state_ms:state0 3888
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state_ms:1200000 3830

Somewhat off-topic, some ideas:

I wonder how useful these stats still are.
CPU_FREQ_STAT is off on my system:

config CPU_FREQ_STAT
        bool "CPU frequency transition statistics"
        help
          Export CPU frequency statistics information through sysfs.

          If in doubt, say N.

Iirc this was a module at former times?

commit 1aefc75b2449eb68a6fc3ca932e2a4ee353b748d
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Tue May 31 22:14:44 2016 +0200

    cpufreq: stats: Make the stats code non-modular

outlined 2 problems with cpufreq_stats being non-modular, but
also seem to fix them up:
... and drop the notifiers from it
Make the stats sysfs attributes appear empty if fast frequency
switching is enabled...

   Thomas


