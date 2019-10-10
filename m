Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF2AD2D37
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2019 17:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbfJJPBh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Oct 2019 11:01:37 -0400
Received: from mx3.freesources.org ([195.34.172.217]:33719 "EHLO
        mx3.freesources.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfJJPBh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2019 11:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freesources.org; s=20160526;
        h=Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:Subject:References:Cc:To:From; bh=Lw5K+7DQupWDZyj6dNVLzP1z7O1yFvkJRSZP9tCFM+E=;
        b=uOYVMm3+g8rvhwZpkH6CZgHpICkasnyDTEfhg4s8qo+TZa7VbCE2WlomPF4/8Q7tbo6zwwMJu0mgC+o2J3Scb14dvYgYAapqupR5ufZZI97T4nwRjwOsp2sAzJjZFuQepPyMSJ4yNYWzLIOjnm3QkHec81CeXgQgGb1emfUqrDA=;
Received: from [46.183.103.17] (helo=[172.18.248.8])
        by mx3.freesources.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <jonas@freesources.org>)
        id 1iIZwU-0001nv-TZ; Thu, 10 Oct 2019 15:01:29 +0000
From:   Jonas Meurer <jonas@freesources.org>
To:     linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Tim Dittler <tim.dittler@systemli.org>
References: <56b2db6a-2f76-a6d3-662a-819cfb18d424@freesources.org>
Openpgp: preference=signencrypt
Autocrypt: addr=jonas@freesources.org; prefer-encrypt=mutual; keydata=
 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
 2SCIHpzHfm/mpRL2
Subject: Re: [RFC PATCH] PM: Add a switch for disabling/enabling sync() before
 suspend
Message-ID: <03d053c7-dc25-9d26-0a6b-f47f13de69d5@freesources.org>
Date:   Thu, 10 Oct 2019 17:00:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <56b2db6a-2f76-a6d3-662a-819cfb18d424@freesources.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="AYdqKP0R5CKDiWpdLGhDYENJFeD0jrFfI"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AYdqKP0R5CKDiWpdLGhDYENJFeD0jrFfI
Content-Type: multipart/mixed; boundary="vq7qvsTKtZAjG6YVu0aumbMuMIzzWOuXL";
 protected-headers="v1"
From: Jonas Meurer <jonas@freesources.org>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>,
 Len Brown <len.brown@intel.com>, Tim Dittler <tim.dittler@systemli.org>
Message-ID: <03d053c7-dc25-9d26-0a6b-f47f13de69d5@freesources.org>
Subject: Re: [RFC PATCH] PM: Add a switch for disabling/enabling sync() before
 suspend
References: <56b2db6a-2f76-a6d3-662a-819cfb18d424@freesources.org>
In-Reply-To: <56b2db6a-2f76-a6d3-662a-819cfb18d424@freesources.org>

--vq7qvsTKtZAjG6YVu0aumbMuMIzzWOuXL
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Hello,

just a friendly nudge: can I expect feedback? In case I addressed the
wrong people/list, to you have a hint where else to send patch and
questions?

Thanks in advance :)

Cheers
 jonas

Jonas Meurer:
> [Sorry, resending with the correct mailinglist address as recipient]
>=20
> Hello,
>=20
> This patch adds a run-time switch at `/sys/power/suspend_sync`.
>=20
> The switch allows to enable or disable the final sync() from the suspen=
d.c
> Linux Kernel system suspend implementation. This is useful to avoid rac=
e
> conditions if block devices have been suspended before. Be aware that y=
ou
> have to take care of sync() yourself before suspending the system if yo=
u
> disable it here.
>=20
> Since this is my first patch against the Linux kernel and I don't
> consider it ready for inclusion yet, I decided to send it to pm-linux
> and the PM subsystem maintainers only first. Would be very glad if you
> could take a look and comment on it :)
>=20
> Some questions:
>=20
> * There already is a build-time config flag[2] for en- or disabling the=

>   sync() in suspend.c. Is it acceptable to have both a build-time *and*=

>   a *run-time* switch? Or would a run-time switch have to replace the
>   build-time switch? If so, a direct question to Rafael, as you added
>   the build-time flag: Would that be ok for you?
> * I'm unsure about the naming: since the default is to have the sync
>   enabled, would `suspend_disable_sync` be a better name for the switch=
,
>   obviously defaulting to 0 then and skipping the sync at value 1?
>=20
> To give a bit more contect: In Debian, we're currently working[3] on
> support to suspend unlocked dm-crypt devices before system suspend.
> During that work, we realized that the final sync() from Linux Kernel
> system suspend implementation can lead to a dead lock.
>=20
> I wrote a simple reproducer[4] to cause the dead lock in a reliable way=
=2E
>=20
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/kernel/power/suspend.c?id=3D54ecb8f#n569
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D2fd77f
> [3] https://salsa.debian.org/mejo/cryptsetup-suspend
> [4] https://salsa.debian.org/mejo/cryptsetup-suspend/snippets/334
>=20
>=20
> Signed-off-by: Jonas Meurer <jonas@freesources.org>
> ---
>  Documentation/ABI/testing/sysfs-power |   16 ++++++++++++++-
>  include/linux/suspend.h               |    2 +
>  kernel/power/main.c                   |   35 +++++++++++++++++++++++++=
+++++++++
>  kernel/power/suspend.c                |    2 -
>  4 files changed, 53 insertions(+), 2 deletions(-)
>=20
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
>  static inline void suspend_set_ops(const struct platform_suspend_ops *=
ops) {}
>  static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; =
}
> +static inline bool suspend_sync_enabled(void) { return true; }
>  static inline bool idle_should_enter_s2idle(void) { return false; }
>  static inline void __init pm_states_init(void) {}
>  static inline void s2idle_set_ops(const struct platform_s2idle_ops *op=
s) {}
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
> + * show() returns whether ksys_sync_helper() is invoked before suspend=
=2E
> + * store() accepts 0 or 1.  0 disables ksys_sync_helper() and 1 enable=
s it.
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
>=20



--vq7qvsTKtZAjG6YVu0aumbMuMIzzWOuXL--

--AYdqKP0R5CKDiWpdLGhDYENJFeD0jrFfI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEELIzSg9Pv30M4kOeDUmLn/0kQSf4FAl2fR6EACgkQUmLn/0kQ
Sf5DJxAAszfHFFtUM36L2RpY6+8OJuDfNb8SWrzklx2BySbDDLZRTYk7ox/4LcNK
+mytZz71hpDsL/sJ7JT3afW2zzjIMvyShCSUHQY7OK1Py6oPQMtdC++4j1RJ1v1l
ePJJ38vkigTdvxbI8IAUrDkQwITqvUgok1Hav07fXFHu0qpdq8jws84MYOtYBeXg
mrnsGhNWj81u72KGE7WH1e3sWT6swbK+14NLNy5O1JlHWVM57d5x2RgkC0mCXTO2
DupyJdiYsjv0Fvw6QGS3VV2BoDMtHwUshk3bNkk8LEzLZn3IvRoXwZLbCxoJ0uWq
oJI2Uh0R4Gr3GAJE5NPm7eNAwHPyilRH+f7xClw3N7nyTdzMIKWcqvcwSN9J3k9e
3/03aUPJU3V0V6D9TqO0sHKEh3WLQHSiLSd6geVa+M0QW09RE9fcJ7inMoB/HAjJ
9ZXgtS9ttGQFM4GQmtJLnt9lZFxdpuU3vy8VvNqHIz9/qAYj47v7ZqkyGqZKvk1O
iUYZNGHwoDxLPRIPGlwJE4sio42MuUoTwq6wPMro7ZwHUmTB/r/6b70yHB9BVkUZ
9eWV4WnMAuKd9pH/XZnEQSy/egYzdb/U9EMGuWSDJ4owLv12wWitF0VUbAWZ09/R
NH134ePK5rpvRwPWNcjpGieC7FLvVFvDGXnOOCzr4ZjPLobj7K0=
=DTH1
-----END PGP SIGNATURE-----

--AYdqKP0R5CKDiWpdLGhDYENJFeD0jrFfI--
