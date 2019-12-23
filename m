Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE2ED1296D2
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2019 15:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfLWOHu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Dec 2019 09:07:50 -0500
Received: from foss.arm.com ([217.140.110.172]:46152 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbfLWOHu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Dec 2019 09:07:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A57411FB;
        Mon, 23 Dec 2019 06:07:49 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B1FA3F534;
        Mon, 23 Dec 2019 06:07:47 -0800 (PST)
Date:   Mon, 23 Dec 2019 14:07:44 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     'Giovanni Gherdovich' <ggherdovich@suse.cz>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        'Mel Gorman' <mgorman@techsingularity.net>,
        'Matt Fleming' <matt@codeblueprint.co.uk>,
        'Viresh Kumar' <viresh.kumar@linaro.org>,
        'Juri Lelli' <juri.lelli@redhat.com>,
        'Paul Turner' <pjt@google.com>,
        'Peter Zijlstra' <peterz@infradead.org>,
        'Vincent Guittot' <vincent.guittot@linaro.org>,
        'Quentin Perret' <qperret@qperret.net>,
        'Dietmar Eggemann' <dietmar.eggemann@arm.com>,
        'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Ingo Molnar' <mingo@redhat.com>,
        'Borislav Petkov' <bp@suse.de>, 'Len Brown' <lenb@kernel.org>,
        "'Rafael J . Wysocki'" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 1/6] x86,sched: Add support for frequency invariance
Message-ID: <20191223140743.o2wfoqtf56g4yrk5@e107158-lin.cambridge.arm.com>
References: <20191113124654.18122-1-ggherdovich@suse.cz>
 <20191113124654.18122-2-ggherdovich@suse.cz>
 <000001d5a29b$c944fd70$5bcef850$@net>
 <1574697961.16378.5.camel@suse.cz>
 <000801d5a41e$a7fce2c0$f7f6a840$@net>
 <1574781600.7677.2.camel@suse.cz>
 <001d01d5a4f4$d96b21b0$8c416510$@net>
 <003d01d5a63d$f6ab3950$e401abf0$@net>
 <20191219104813.6fr34qavpaplecoz@e107158-lin>
 <000701d5b965$361b6c60$a2524520$@net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000701d5b965$361b6c60$a2524520$@net>
User-Agent: NeoMutt/20171215
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/22/19 23:47, Doug Smythies wrote:
> Hi Qais,
> 
> Thank you for your follow up.

Thanks for the detailed info!

> 
> On 2019.12.19 02:48 Qais Yousef wrote:
> > On 11/28/19 14:48, Doug Smythies wrote:
> >> Summary: There never was an issue here.
> >> 
> >> Sorry for the noise of this thread, and the resulting waste of time.
> >> 
> >> On 2019.11.26 23:33 Doug Smythies wrote:
> >>> On 2019.11.26 07:20 Giovanni Gherdovich wrote:
> >>>> On Mon, 2019-11-25 at 21:59 -0800, Doug Smythies wrote:
> >>>>> [...]
> >>>>> The issue with the schedutil governor not working properly in the 5.4 RC series
> >>>>> appears to be hardware dependant.
> >> 
> >> No it 's not.
> >> 
> >> Issues with my Sandy Bridge, i7-2600K, test computer and kernel 5.4
> >> seem to be because it is running an older Ubuntu server version,
> >> apparently somewhat dependant on cgroup V1 and their cgmanager package.
> >> I am unable to remove the package to test further because I do use VMs
> >> that seem to depend on it.
> >> 
> >> In the kernel configuration when CONFIG_UCLAMP_TASK_GROUP=y
> >> the computer behaves as though the new parameter "cpu.uclamp.min"
> >> is set to max rather than 0, but I can not prove it.
> >
> > I just noticed this. This option shouldn't cause any problem, if it does there
> > might be a bug that we need to fix.
> >
> > So cpu.uclamp.min reads 0 but you think it's not taking effect, correct?
> 
> Actually, on the i7-2600K older distro test computer, I couldn't find
> cpu.uclamp.min to read its setting. However, yes the behaviour of the governor
> was as though that value was set to maximum (read on).

Sorry, silly question. Did you verify both cgroup v1 and v2 mount points?

If the cpu controller is mounted in v1, it can't be seen in v2. And vice versa.

> 
> >
> > In the quotes above I see 5.4 RC, if you haven't tried this against the final
> > 5.4 release, do you mind trying to see if you can reproduce? Trying 5.5-rc2
> > would be helpful too if 5.4 fails.
> 
> My test setup and baseline distribution versions have changed since November,
> when I did those tests. However, I was able to rig up a bootable old ssd
> and was able to reproduce the issue with kernel 5.5-rc2. More importantly,
> I was to reproduce the issue with the current i7-2600K test computer
> (Ubuntu server 20.04 development, upgraded version) and kernel 5.5-rc2.
> Note that I have access to another i5-9600K based test computer (Ubuntu
> server 20.04 development, fresh install), that does not show this issue.
> 
> Detail:
> 
> If formatting gets messed up in this e-mail, then the content,
> and links to more details, is also here:
> http://www.smythies.com/~doug/linux/single-threaded/k54regression/qais.html

I see here:

	"kernel configuration differences between Ubuntu mainline PPA and
	local"

Does this mean you're using Ubuntu's mainline tree not Linus'?

> 
> CPU frequency scaling driver: intel_pstate, in passive (intel-cpufreq) mode.
> CPU frequency scaling governor: various.
> CPU Idle driver: intel_idle; Governor: teo.
> 
> kernels ("stock", "notset" and "nocgv1"):
> stock: CONFIG_UCLAMP_TASK_GROUP=y
> notset: # CONFIG_UCLAMP_TASK_GROUP is not set
> nocgv1: is "stock" booted with "cgroup_no_v1=all" on the grub kernel command line.

So I looked at the code and I can't see how to connect the dots.

By default, all CFS tasks has a uclamp_min value of 0, and uclamp_max value of
1024.

RT tasks by default are boosted to max only, from uclamp+schedutil perspective.

Similarly all child group should have cpu.uclamp.{min, max} = (0, 1024) by
default unless changed.

I'm wondering if forcing cgroup_v1 off is just has the side effect of allowing
you to mount and use the cpu controller in v2.

> 
> Linux s15 5.5.0-rc2-stock #768 SMP PREEMPT Fri Dec 20 16:19:44 PST 2019 x86_64 x86_64 x86_64 GNU/Linux
> Linux s18 5.5.0-rc2-notset #769 SMP PREEMPT Fri Dec 20 18:43:59 PST 2019 x86_64 x86_64 x86_64 GNU/Linux
> 
> kernel configuration differences:
> 
> doug@s15:~/temp-k-git/linux$ scripts/diffconfig /boot/config-5.5.0-rc2-stock /boot/config-5.5.0-rc2-notset
>  UCLAMP_TASK_GROUP y -> n
> doug@s15:~/temp-k-git/linux$
> 
> Test methods used herein are greatly sped up, by switching
> to just a couple of PID per seconds samples, instead of
> a great many. Also disk I/O is not used, eliminating any
> access time related non-repeatability, and saving thrashing
> my SSD. Note that several governors had CPU frequency variations
> with time, resulting in variability in the PIDs per second number.
> 
> There are two tests, the performance metric being
> the number of PIDs per second consumed:
> 

[...]

> i7-2600K computer booted with Ubuntu server 20.04 dev, test 2:
> 
> Governor	kernel
> 		stock			notset		nocgv1
> 		PID/S ratio		PID/S ratio	PID/S ratio
> schedutil	405 1.1 FAIL	177 2.4		405 1.1 FAIL
> ondemand	371 1.1		371 1.1		371 1.1
> performance	408 1.0		405 1.0		405 1.0
> conservative362 1.2		365 1.2		365 1.2
> powersave	177 2.4		177 2.4		177 2.4
> reference	423 1.0		423 1.0		423 1.0
> 
> The "nocgv1" (cgroup_no_v1=all) kernel is of particular interest because
> now uclamp variables are available:
> 
> root@s15:/sys/fs/cgroup/user.slice# echo "+cpu" > cgroup.subtree_control

This is v2 syntax. It's worth checking the mount point of the cpu controller in
cgroup v1.

> root@s15:/sys/fs/cgroup/user.slice# cat cgroup.subtree_control
> cpu memory pids
> root@s15:/sys/fs/cgroup/user.slice# grep . cpu\.uclamp*
> cpu.uclamp.max:max
> cpu.uclamp.min:0.00
> 
> This is repeatable:
> To make the schedutil governor respond as expected thereafter
> and until the next re-boot, do this:
> 
> # echo 0 > cpu.uclamp.min
> 
> Attempts to kick the schedutil governor response via
> /sys/devices/system/cpu/intel_pstate/max_perf_pct and
> /sys/devices/system/cpu/intel_pstate/min_perf_pct didn't.
> Other modifications of the cpu.uclamp.min and max variables also
> kick the schedutil governor out of whatever state it was in.
> 
> This test was done 5 times:
> 
> Re-boot to the nocgv1 (stock + cgroup_no_v1=all) kernel.
> set the schedutil governor.
> launch test 2 and related monitoring tools.
> verify performance governor like behavior.

So as stated above, by default uclamp_{min, max} = (0, 1024). So it wouldn't
act as performance governor by default unless you explicitly write 1024 to
uclamp.min.

Let me go find Ubuntu mainline tree to see if they applied anything extra in
there. If they modified the default behavior that could explain what you see.

Thanks!

--
Qais Yousef

> echo 0 > /sys/fs/cgroup/user.slice/cpu.uclamp.min 
> verify schedutil governor like behaviour.
> 
> ... Doug
> 
> 
