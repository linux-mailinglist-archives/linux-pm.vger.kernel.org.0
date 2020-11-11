Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161A92AEAE0
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 09:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgKKIN2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Nov 2020 03:13:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:48932 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgKKIN2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Nov 2020 03:13:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 73CA3ACC5;
        Wed, 11 Nov 2020 08:13:26 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.de>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: stats: Switch to ktime and msec instead of jiffies and usertime
Date:   Wed, 11 Nov 2020 09:13:24 +0100
Message-ID: <2047155.4hzcE6bcFl@c100>
In-Reply-To: <20201111051350.qxevqcca5775h2xa@vireshk-i7>
References: <0e0fb542b6f6b26944cb2cf356041348aeac95f6.1605006378.git.viresh.kumar@linaro.org> <1832747.5iOEhN7m9D@c100> <20201111051350.qxevqcca5775h2xa@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Mittwoch, 11. November 2020, 06:13:50 CET schrieb Viresh Kumar:
> On 10-11-20, 13:53, Thomas Renninger wrote:
> > Am Dienstag, 10. November 2020, 12:07:37 CET schrieb Viresh Kumar:
> > > The cpufreq and thermal core, both provide sysfs statistics to help
> > > userspace learn about the behavior of frequencies and cooling states.
> > > 
> > > This is how they look:
> > > /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:1200000 399
> > > 
> > > The results look like this after this commit:
> > > /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:1200000 3830
> > 
> > How would userspace know whether it's ms or 10ms?

Again:
How would userspace know whether it's ms or 10ms?

> > whatabout a new file with the same convention as cooling devices (adding ms):
> Keeping two files for same stuff is not great, and renaming the file
> breaks userspace ABI.

No exactly the other way around:
- Renaming, breaks the userspace ABI.
- Two files would be the super correct way to go:
  - Deprecate the old file and keep the 10ms around for some years
    ./Documentation/ABI/obsolete
  - Add the new interface and document it in:
   ./Documentation/ABI/testing

As this is about a minor cpufreq_stat debug file, it is enough if
you rename to:
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state_ms
Ideally document it in ./Documentation/ABI/testing
But I guess for this one this is also not mandatory.

Then userspace can do:
MS_FILE="/sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state_ms"
10MS_FILE="/sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state"

if [ -r "$MS_FILE" ]; then
    POLICY0_MS=$(<"$MS_FILE")
    echo "Found ms stats file"
elif [ -r "$10MS_FILE" ]; then
    echo "Found 10ms stats file, converting..."
    POLICY0_MS=$(<"$10MS_FILE")
    POLICY0_MS=$(echo "$POLICY0_MS 10 /" |dc)
else
    echo "cpufreq stat not compiled in?"
fi

> I am not sure what's the right thing to do here.

Use a new *_ms name.
If you are unsure how many people this still might use, keep the old file and mark
it deprecated and remove it in some years.
You could also add:
pr_info("%s userspace process accessed deprecated sysfs file %s", task->comm, OLD_SYSFS_FILE_PATH);
To find other userspace apps making use of it.

...
 
> I already fixed this recently and stats don't appear empty for fast
> switch anymore.

Then cpufreq_stats could be a module again?

      Thomas


