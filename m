Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EED7D3D3C
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2019 12:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfJKKW1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Oct 2019 06:22:27 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41466 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfJKKW1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Oct 2019 06:22:27 -0400
Received: from 79.184.255.36.ipv4.supernova.orange.pl (79.184.255.36) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 7153c49c969fdc92; Fri, 11 Oct 2019 12:22:24 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Jonas Meurer <jonas@freesources.org>
Cc:     linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Tim Dittler <tim.dittler@systemli.org>
Subject: Re: [RFC PATCH] PM: Add a switch for disabling/enabling sync() before suspend
Date:   Fri, 11 Oct 2019 12:22:24 +0200
Message-ID: <2847488.TR0R5COpHM@kreacher>
In-Reply-To: <56b2db6a-2f76-a6d3-662a-819cfb18d424@freesources.org>
References: <56b2db6a-2f76-a6d3-662a-819cfb18d424@freesources.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, October 7, 2019 12:50:14 PM CEST Jonas Meurer wrote:
>  This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
> --htRCyOoJ9Xv4BLXLNYp8X0x6Nr6crRDII
> Content-Type: multipart/mixed; boundary="GRH6EAOR51QxsekMaGMKMlm8winrq3Izm";
>  protected-headers="v1"
> From: Jonas Meurer <jonas@freesources.org>
> To: linux-pm@vger.kernel.org
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>,
>  Len Brown <len.brown@intel.com>, Tim Dittler <tim.dittler@systemli.org>
> Message-ID: <56b2db6a-2f76-a6d3-662a-819cfb18d424@freesources.org>
> Subject: [RFC PATCH] PM: Add a switch for disabling/enabling sync() before
>  suspend
> 
> --GRH6EAOR51QxsekMaGMKMlm8winrq3Izm
> Content-Type: text/plain; charset=utf-8
> Content-Language: de-DE
> Content-Transfer-Encoding: quoted-printable
> 
> [Sorry, resending with the correct mailinglist address as recipient]
> 
> Hello,
> 
> This patch adds a run-time switch at `/sys/power/suspend_sync`.

I'd prefer "sync_on_suspend".

> The switch allows to enable or disable the final sync() from the suspend.=
> c
> Linux Kernel system suspend implementation. This is useful to avoid race
> conditions if block devices have been suspended before. Be aware that you=
> 
> have to take care of sync() yourself before suspending the system if you
> disable it here.
> 
> Since this is my first patch against the Linux kernel and I don't
> consider it ready for inclusion yet, I decided to send it to pm-linux
> and the PM subsystem maintainers only first. Would be very glad if you
> could take a look and comment on it :)
> 
> Some questions:
> 
> * There already is a build-time config flag[2] for en- or disabling the
>   sync() in suspend.c. Is it acceptable to have both a build-time *and*
>   a *run-time* switch? Or would a run-time switch have to replace the
>   build-time switch? If so, a direct question to Rafael, as you added
>   the build-time flag: Would that be ok for you?

If there is a run-time knob to disable the syncing, the only reason for
the config option to be there will be to set the default value of that.

> * I'm unsure about the naming: since the default is to have the sync
>   enabled, would `suspend_disable_sync` be a better name for the switch,
>   obviously defaulting to 0 then and skipping the sync at value 1?

The default is just the initial value of the new knob, the naming need not
be related to that.

> To give a bit more contect: In Debian, we're currently working[3] on
> support to suspend unlocked dm-crypt devices before system suspend.
> During that work, we realized that the final sync() from Linux Kernel
> system suspend implementation can lead to a dead lock.

That's also true for FUSE filesystems I think and please note that this isn't
going to work with hibernation (in which case filesystems are synced
regardless).

> I wrote a simple reproducer[4] to cause the dead lock in a reliable way.
> 
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
> ee/kernel/power/suspend.c?id=3D54ecb8f#n569
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
> mmit/?id=3D2fd77f
> [3] https://salsa.debian.org/mejo/cryptsetup-suspend
> [4] https://salsa.debian.org/mejo/cryptsetup-suspend/snippets/334
> 
> 
> Signed-off-by: Jonas Meurer <jonas@freesources.org>
> ---
>  Documentation/ABI/testing/sysfs-power |   16 ++++++++++++++-
>  include/linux/suspend.h               |    2 +
>  kernel/power/main.c                   |   35 +++++++++++++++++++++++++++=
> +++++++
>  kernel/power/suspend.c                |    2 -
>  4 files changed, 53 insertions(+), 2 deletions(-)
> 
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -575,7 +575,7 @@ static int enter_state(suspend_state_t s
>  	if (state =3D=3D PM_SUSPEND_TO_IDLE)
>  		s2idle_begin();
> =20
> -	if (!IS_ENABLED(CONFIG_SUSPEND_SKIP_SYNC)) {
> +	if (!IS_ENABLED(CONFIG_SUSPEND_SKIP_SYNC) && suspend_sync_enabled) {
>  		trace_suspend_resume(TPS("sync_filesystems"), 0, true);
>  		ksys_sync_helper();
>  		trace_suspend_resume(TPS("sync_filesystems"), 0, false);
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -328,6 +328,7 @@ extern void arch_suspend_disable_irqs(vo
>  extern void arch_suspend_enable_irqs(void);
> =20
>  extern int pm_suspend(suspend_state_t state);
> +extern bool suspend_sync_enabled;
>  #else /* !CONFIG_SUSPEND */
>  #define suspend_valid_only_mem	NULL
> =20
> @@ -340,6 +341,7 @@ static inline bool pm_suspend_via_s2idle
> =20
>  static inline void suspend_set_ops(const struct platform_suspend_ops *op=
> s) {}
>  static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
> +static inline bool suspend_sync_enabled(void) { return true; }
>  static inline bool idle_should_enter_s2idle(void) { return false; }
>  static inline void __init pm_states_init(void) {}
>  static inline void s2idle_set_ops(const struct platform_s2idle_ops *ops)=
>  {}
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -191,6 +191,40 @@ static ssize_t mem_sleep_store(struct ko
>  power_attr(mem_sleep);
>  #endif /* CONFIG_SUSPEND */
> =20
> +#ifdef CONFIG_SUSPEND
> +/*
> + * suspend_sync: invoke ksys_sync_helper() before suspend.
> + *
> + * show() returns whether ksys_sync_helper() is invoked before suspend.
> + * store() accepts 0 or 1.  0 disables ksys_sync_helper() and 1 enables =
> it.
> + */
> +bool suspend_sync_enabled =3D true;
> +
> +static ssize_t suspend_sync_show(struct kobject *kobj,
> +				   struct kobj_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%d\n", suspend_sync_enabled);
> +}
> +
> +static ssize_t suspend_sync_store(struct kobject *kobj,
> +				    struct kobj_attribute *attr,
> +				    const char *buf, size_t n)
> +{
> +	unsigned long val;
> +
> +	if (kstrtoul(buf, 10, &val))
> +		return -EINVAL;
> +
> +	if (val > 1)
> +		return -EINVAL;
> +
> +	suspend_sync_enabled =3D !!val;
> +	return n;
> +}
> +
> +power_attr(suspend_sync);
> +#endif /* CONFIG_SUSPEND */
> +
>  #ifdef CONFIG_PM_SLEEP_DEBUG
>  int pm_test_level =3D TEST_NONE;
> =20
> @@ -769,6 +803,7 @@ static struct attribute * g[] =3D {
>  	&wakeup_count_attr.attr,
>  #ifdef CONFIG_SUSPEND
>  	&mem_sleep_attr.attr,
> +	&suspend_sync_attr.attr,
>  #endif
>  #ifdef CONFIG_PM_AUTOSLEEP
>  	&autosleep_attr.attr,
> --- a/Documentation/ABI/testing/sysfs-power
> +++ b/Documentation/ABI/testing/sysfs-power
> @@ -300,4 +300,18 @@ Description:
>  		attempt.
> =20
>  		Using this sysfs file will override any values that were
> -		set using the kernel command line for disk offset.
> \ No newline at end of file
> +		set using the kernel command line for disk offset.
> +
> +What:		/sys/power/suspend_sync
> +Date:		October 2019
> +Contact:	Jonas Meurer <jonas@freesources.org>
> +Description:
> +		This file controls the switch to enable or disable the final
> +		sync() before system suspend. This is useful to avoid race
> +		conditions if block devices have been suspended before. Be
> +		aware that you have to take care of sync() yourself before
> +		suspending the system if you disable it here.
> +
> +		Writing a "1" (default) to this file enables the sync() and
> +		writing a "0" disables it. Reads from the file return the
> +		current value.
> --=20

The changes look reasonable to me.

Thanks,
Rafael



