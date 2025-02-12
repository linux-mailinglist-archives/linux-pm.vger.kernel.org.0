Return-Path: <linux-pm+bounces-21980-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C94A32FF3
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 20:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C98101684F7
	for <lists+linux-pm@lfdr.de>; Wed, 12 Feb 2025 19:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15B91FF619;
	Wed, 12 Feb 2025 19:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKpgnwsr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0C61FF613;
	Wed, 12 Feb 2025 19:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739389362; cv=none; b=RwcxbCbuv1IUh7amDaccVB267WFSYciKSXSnbq+zVRu3y3fq3xgBQ/6FOKuJKh4OoCrT0Ti/FqshHTew/HPLQcC609GUMro5JpZ3dOQ66bHlmazjukHcvf74D1vwgtKewnRTpLi5Gm2mM64oH2kZzpo6Cm7H8iv3Y4VaXBhNZ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739389362; c=relaxed/simple;
	bh=UNiOOPrEjQwV5x9sA57ogSJAt0Fp6NvoWGcX8B+zLPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eeumYO0zVbA59bwj4JVIW0HDAJhJ0k6sBBbGaHWH7STQO99w0x8mC1Ahp+8ytf+2Gx+h8sawlDAaVPhzosHdB/OLcJv4xofcmgSeyTdOqh1J8Menpvlmw2saurlCCL6UDI4dYEE1R49gnLxyIl9pAIUOFPrEJq0+dvmLsVmrY3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKpgnwsr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745C4C4CEE7;
	Wed, 12 Feb 2025 19:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739389362;
	bh=UNiOOPrEjQwV5x9sA57ogSJAt0Fp6NvoWGcX8B+zLPk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GKpgnwsrymNT98dp+hM+IOE10R5ms0/uA8GG458pD5IGU8EjFuuMAYVeh78wiewU6
	 JNkZ8YDTG9D58XG6a5OGokwgozY3wEv6im5vSEJfPv8fw+a7vHC84jG2SeADyQjjxV
	 czBxRw1KBWNAi4MCFRngbOpvpiuPPyzy/j9WWWiwCF6spsfKFeEG9ES1jqOFUBWOAq
	 u9OoyAMxJHQKQFQ6160xIkAh54K2Sh+7K0WSTE35k3cLHwMN+rGPNk/QTeE7W5+bTG
	 LJ0Fcu0Zs+lJuug74oLfe5i707jjUcr/WM+2co5NIrBfYR5GwQwjheEjEzxrCxelRl
	 ylh671Z8wrBFA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2b86794e3abso89342fac.0;
        Wed, 12 Feb 2025 11:42:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXJ4iuMH/ABpIHeB+40ZSFv0TwvstQIgunbwifByKj0EQQ+Pmyg5cnpxwuvXUr9VYuQ3wM5logHxoTxp34=@vger.kernel.org, AJvYcCXzKinJ6+5L7m00bVPedZOo1j71mlodocqG9HeHrpePaiZKEhVVqWp3KrZEPubCZ8sMIE9d8bx9U5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7QK/x35mGTqKjm4vhEkxmRSz/eJh/tTkEcR6+X/SEdwRKCxlZ
	YCOFfVQATaFUoHQJQeHO0GKQQ3B2/ItXfNYBqTV0F3cEU9jZa6wl18FbK09Nu0TIX02HH0Lb7c9
	nMNCtAnSF0q9fmIn8fpaXyzGAK1M=
X-Google-Smtp-Source: AGHT+IH7AFHO/bXjMEM1EJX4msW1Bx1X+CjCGiKZKuiYWOsmpeK8041fkILi62P9teI9wrlsU9E+EgZ/q60tA0XRsxw=
X-Received: by 2002:a05:6871:285:b0:29e:526a:eee5 with SMTP id
 586e51a60fabf-2b8d644db6fmr2893382fac.1.1739389361696; Wed, 12 Feb 2025
 11:42:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211124421.27169-1-quic_manafm@quicinc.com>
In-Reply-To: <20250211124421.27169-1-quic_manafm@quicinc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Feb 2025 20:42:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j8WY4LdM-3AYr9nUO+z09jq2vAVnaW0rFP=RKAe7jTUA@mail.gmail.com>
X-Gm-Features: AWEUYZk3cF5b7EtO8AvgZpvKsrD4vfZB9jA2c9n3rvzNpX2JeVhfT8GgAtP3M2c
Message-ID: <CAJZ5v0j8WY4LdM-3AYr9nUO+z09jq2vAVnaW0rFP=RKAe7jTUA@mail.gmail.com>
Subject: Re: [PATCH] thermal: core: Fix race between zone registration and
 userspace sysfs access
To: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000007ef13062df72584"

--00000000000007ef13062df72584
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 1:45=E2=80=AFPM Manaf Meethalavalappu Pallikunhi
<quic_manafm@quicinc.com> wrote:
>
> Currently, the thermal zone sysfs is created before setting the
> governor for that thermal zone during registration. If a thermal
> zone is being registered while a userspace module tries to access
> the same thermal zone policy sysfs node, it can lead to a potential
> NULL pointer dereference issue in the policy sysfs path.
>
> To avoid this race condition, set the thermal zone governor first
> before enabling the thermal zone sysfs during registration.
> This change fixes below issue,
>
> [ 20.964589]   Unable to handle kernel NULL pointer dereference at virtua=
l address 0000000000000000
> [ 21.049645]   pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYP=
E=3D--)
> [ 21.049647]   pc : policy_show+0x1c/0x3c
> [ 21.049652]   lr : dev_attr_show+0x38/0x7c
> [ 21.049655]   sp : ffffffc09a98bbf0
> [ 21.049657]   x29: ffffffc09a98bbf0 x28: ffffff885b940000 x27: 000000000=
0000000
> [ 21.049660]   x26: 0000000000000000 x25: 000000007ffff001 x24: 000000000=
0000001
> [ 21.049664]   x23: ffffffdca6334c78 x22: ffffff88a2b2fe00 x21: ffffff881=
cee8000
> [ 21.049667]   x20: ffffff8868318018 x19: ffffffdca7640d78 x18: ffffffdca=
74d94c0
> [ 21.049670]   x17: 00000000ae84bcd4 x16: 00000000ae84bcd4 x15: 000000002=
df29963
> [ 21.049673]   x14: 00000000cbef29c7 x13: 000000004e61db0a x12: ffffff885=
b940be0
> [ 21.049677]   x11: ffffff881cee8000 x10: 0000000000000000 x9 : ffffffdca=
59f00b8
> [ 21.049680]   x8 : 0000000000000000 x7 : 0000000000000000 x6 : 000000000=
000003f
> [ 21.049683]   x5 : 0000000000000040 x4 : 0000000000000000 x3 : 000000000=
0000004
> [ 21.049686]   x2 : ffffff881cee8000 x1 : ffffffdca66e5bfb x0 : ffffff881=
cee8000
> [ 21.049689]   Call trace:
> [ 21.049690]    policy_show+0x1c/0x3c
> [ 21.049692]    dev_attr_show+0x38/0x7c
> [ 21.049695]    sysfs_kf_seq_show+0xd8/0x160
> [ 21.049699]    kernfs_seq_show+0x44/0x54
> [ 21.049701]    seq_read_iter+0x16c/0x4ec
> [ 21.049705]    kernfs_fop_read_iter+0x64/0x1d8
> [ 21.049709]    vfs_read+0x2d8/0x33c
> [ 21.049711]    ksys_read+0x78/0xe8
> [ 21.049714]    __arm64_sys_read+0x1c/0x2c
> [ 21.049716]    invoke_syscall+0x58/0x10c
> [ 21.049719]    el0_svc_common+0xa8/0xdc
> [ 21.049722]    do_el0_svc+0x1c/0x28
> [ 21.049724]    el0_svc+0x40/0x90
> [ 21.049726]    el0t_64_sync_handler+0x70/0xbc
> [ 21.049728]    el0t_64_sync+0x1a8/0x1ac
> [ 21.049731]   Code: f9435008 aa0203e0 d00054e1 912fec21 (f9400108)
>
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
> ---
>  drivers/thermal/thermal_core.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 2328ac0d8561..c6e6b229cc6e 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1589,6 +1589,11 @@ thermal_zone_device_register_with_trips(const char=
 *type,
>
>         tz->state =3D TZ_STATE_FLAG_INIT;
>
> +       thermal_zone_device_init(tz);
> +       result =3D thermal_zone_init_governor(tz);
> +       if (result)
> +               goto unregister;
> +
>         /* sys I/F */
>         /* Add nodes that are always present via .groups */
>         result =3D thermal_zone_create_device_groups(tz);
> @@ -1600,19 +1605,14 @@ thermal_zone_device_register_with_trips(const cha=
r *type,
>                 thermal_zone_destroy_device_groups(tz);
>                 goto remove_id;
>         }
> -       thermal_zone_device_init(tz);
>         result =3D device_register(&tz->device);
>         if (result)
>                 goto release_device;
>
> -       result =3D thermal_zone_init_governor(tz);
> -       if (result)
> -               goto unregister;
> -
>         if (!tz->tzp || !tz->tzp->no_hwmon) {
>                 result =3D thermal_add_hwmon_sysfs(tz);
>                 if (result)
> -                       goto unregister;
> +                       goto release_device;
>         }
>
>         result =3D thermal_thresholds_init(tz);
> @@ -1629,12 +1629,12 @@ thermal_zone_device_register_with_trips(const cha=
r *type,
>
>  remove_hwmon:
>         thermal_remove_hwmon_sysfs(tz);
> -unregister:
> -       device_del(&tz->device);
>  release_device:
>         put_device(&tz->device);
>  remove_id:
>         ida_free(&thermal_tz_ida, id);
> +unregister:
> +       device_del(&tz->device);
>  free_tzp:
>         kfree(tz->tzp);
>  free_tz:
> --

The catch is good, but the patch isn't AFAICS.  The changes in the
error path don't look correct to me in particular.

I'd rather make the attached change, please let me know if it works for you=
.

--00000000000007ef13062df72584
Content-Type: text/x-patch; charset="US-ASCII"; name="thermal-core-gov-sysfs.patch"
Content-Disposition: attachment; filename="thermal-core-gov-sysfs.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m72bh8ou0>
X-Attachment-Id: f_m72bh8ou0

LS0tCiBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMgIHwgICAgMiArLQogZHJpdmVycy90
aGVybWFsL3RoZXJtYWxfY29yZS5oICB8ICAgIDEgKwogZHJpdmVycy90aGVybWFsL3RoZXJtYWxf
c3lzZnMuYyB8ICAgIDcgKysrKysrLQogMyBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCgotLS0gYS9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMKKysr
IGIvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jCkBAIC0zNTMsNyArMzUzLDcgQEAKIAkJ
dGhlcm1hbF96b25lX2RldmljZV9zZXRfcG9sbGluZyh0eiwgdHotPnBvbGxpbmdfZGVsYXlfamlm
Zmllcyk7CiB9CiAKLXN0YXRpYyBzdHJ1Y3QgdGhlcm1hbF9nb3Zlcm5vciAqdGhlcm1hbF9nZXRf
dHpfZ292ZXJub3Ioc3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2UgKnR6KQorc3RydWN0IHRoZXJt
YWxfZ292ZXJub3IgKnRoZXJtYWxfZ2V0X3R6X2dvdmVybm9yKHN0cnVjdCB0aGVybWFsX3pvbmVf
ZGV2aWNlICp0eikKIHsKIAlpZiAodHotPmdvdmVybm9yKQogCQlyZXR1cm4gdHotPmdvdmVybm9y
OwotLS0gYS9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmgKKysrIGIvZHJpdmVycy90aGVy
bWFsL3RoZXJtYWxfY29yZS5oCkBAIC0yNjIsNiArMjYyLDcgQEAKIHZvaWQgX190aGVybWFsX3pv
bmVfZGV2aWNlX3VwZGF0ZShzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqdHosCiAJCQkJICBl
bnVtIHRoZXJtYWxfbm90aWZ5X2V2ZW50IGV2ZW50KTsKIHZvaWQgdGhlcm1hbF96b25lX2Rldmlj
ZV9jcml0aWNhbF9yZWJvb3Qoc3RydWN0IHRoZXJtYWxfem9uZV9kZXZpY2UgKnR6KTsKK3N0cnVj
dCB0aGVybWFsX2dvdmVybm9yICp0aGVybWFsX2dldF90el9nb3Zlcm5vcihzdHJ1Y3QgdGhlcm1h
bF96b25lX2RldmljZSAqdHopOwogdm9pZCB0aGVybWFsX2dvdmVybm9yX3VwZGF0ZV90eihzdHJ1
Y3QgdGhlcm1hbF96b25lX2RldmljZSAqdHosCiAJCQkJZW51bSB0aGVybWFsX25vdGlmeV9ldmVu
dCByZWFzb24pOwogCi0tLSBhL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX3N5c2ZzLmMKKysrIGIv
ZHJpdmVycy90aGVybWFsL3RoZXJtYWxfc3lzZnMuYwpAQCAtMjA5LDggKzIwOSwxMyBAQAogcG9s
aWN5X3Nob3coc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqZGV2
YXR0ciwgY2hhciAqYnVmKQogewogCXN0cnVjdCB0aGVybWFsX3pvbmVfZGV2aWNlICp0eiA9IHRv
X3RoZXJtYWxfem9uZShkZXYpOworCXN0cnVjdCB0aGVybWFsX2dvdmVybm9yICpnb3Zlcm5vcjsK
IAotCXJldHVybiBzcHJpbnRmKGJ1ZiwgIiVzXG4iLCB0ei0+Z292ZXJub3ItPm5hbWUpOworCWd1
YXJkKHRoZXJtYWxfem9uZSkodHopOworCisJZ292ZXJub3IgPSB0aGVybWFsX2dldF90el9nb3Zl
cm5vcih0eik7CisKKwlyZXR1cm4gc3ByaW50ZihidWYsICIlc1xuIiwgZ292ZXJub3ItPm5hbWUp
OwogfQogCiBzdGF0aWMgc3NpemVfdAo=
--00000000000007ef13062df72584--

