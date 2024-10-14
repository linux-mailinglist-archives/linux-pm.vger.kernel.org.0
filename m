Return-Path: <linux-pm+bounces-15619-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7011499CA04
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 14:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0A9282F11
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 12:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558D51A0708;
	Mon, 14 Oct 2024 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPGGjAEB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2969519E7F7;
	Mon, 14 Oct 2024 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908780; cv=none; b=HzxExnZKcbnYR/r0AsHYqofpvOVj+p1FFVqjtjtkNz2U2A1kdg76rWT3GWRiVlBhzum/tDQ69FPKArP1DHMfHuRXb/AslxwbQ37nrr34esMKaHeuk3qaVu2Wnqr/HZdoKlIYnbWWVbQK7CMWlzrtFtY91XuBlZ4syiHRCDSyfvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908780; c=relaxed/simple;
	bh=kNN9QEB5w/1uw6XqVhnzbPL2hWecxKy9ZQ+KagE43Ro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQn4neayBMxe2Is/fGiUjFL+b0r0Qp0nZLNztCY7zR4P4InAPWKlIFwT8qhZGBGR60wENpt8COcuecrdMZxjM3bpXvsB6N88XalpSpQkFBabt0L6LOq7zSXsRHrr/8CL3dUbqhGCMAzhbiOvciAYY4g9gJ9lQAbg1KQep0CsXpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPGGjAEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E66C4CEC3;
	Mon, 14 Oct 2024 12:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728908780;
	bh=kNN9QEB5w/1uw6XqVhnzbPL2hWecxKy9ZQ+KagE43Ro=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uPGGjAEBn+43raR6eBeGYYpKAprOPTods0Xvok44EbhzxglxFqhDP10RHOzma57Yb
	 42tkmvZ4XN+um3pYMwpdZYBEmJThdFXXdXoxyBgTtBWw7No5UeOlwszTNFQoQ+7uGO
	 KKWDEpcF31C0CyNuV27bz+6/rpOWMDgZ4oyBSRX5HPlrNId2EgQbQ8SVcht5UDYNYt
	 yRqsoCUmgmOCLf1atbXiE8lOfoIfy2U6TaIYHlqZJvEJLx373mdQxVVjJQkDCHX8le
	 9BhSisJuVScHrC9pOyXTzNr6dS5/dwh9bh0a59dazMgjpHwEZlQ6CZ/oae1Q1V8vXy
	 lugx+xG8XT22A==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e5d3f039ccso759670b6e.0;
        Mon, 14 Oct 2024 05:26:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqfbDSBxD/g9+PQVk9wMyyY757sGaOK/gXqpnJ6cuuU8nD2u/94G8YnW0RkP5ClHP0yMYKjBlNlurw6LQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YweVUDI05LVhnM/K8M0gGknQHavJW8WAV3ZQtOwVFPi1uUOuZiK
	BBrnjRdqjy576NHlpyIoIxlYOc6DZTBzgP+M0rNb6ki2yDLVGjnqfiSRwBDJA7ZIdzF/m3CxSiw
	aRs2AA4lxZQBsZzTFPMToH2nKWmU=
X-Google-Smtp-Source: AGHT+IE0LkBdHXeuzWms1QKbJNBIR5kB6y9h4r7HZLamFihSQr35MFoogPsfYAvnt1CTS1C5ZuetCSpjuq+zn/KhJYg=
X-Received: by 2002:a05:6870:ac87:b0:288:666b:9c5e with SMTP id
 586e51a60fabf-2886dd70e90mr7438040fac.17.1728908779198; Mon, 14 Oct 2024
 05:26:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4985597.31r3eYUQgx@rjwysocki.net> <2655659.Lt9SDvczpP@rjwysocki.net>
In-Reply-To: <2655659.Lt9SDvczpP@rjwysocki.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 14 Oct 2024 14:26:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h_tsCKpvZuHejCF4qnvJt7+=GqMGc7YgiM=Eu55bKBCg@mail.gmail.com>
Message-ID: <CAJZ5v0h_tsCKpvZuHejCF4qnvJt7+=GqMGc7YgiM=Eu55bKBCg@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] thermal: core: Add and use cooling device guard
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 12:22=E2=80=AFAM Rafael J. Wysocki <rjw@rjwysocki.n=
et> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Add and use a special guard for cooling devices.
>
> This allows quite a few error code paths to be simplified among
> other things and brings in code size reduction for a good measure.
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> This is a new iteration of
>
> https://lore.kernel.org/linux-pm/1890654.atdPhlSkOF@rjwysocki.net/
>
> v1 -> v2: Rearrange cur_state_store()
>
> ---
>  drivers/thermal/gov_power_allocator.c |   21 +++++++--------
>  drivers/thermal/gov_step_wise.c       |    6 ++--
>  drivers/thermal/thermal_core.c        |   17 +++---------
>  drivers/thermal/thermal_debugfs.c     |   25 +++++++++++-------
>  drivers/thermal/thermal_helpers.c     |   19 +++-----------
>  drivers/thermal/thermal_sysfs.c       |   45 ++++++++++++---------------=
-------
>  include/linux/thermal.h               |    3 ++
>  7 files changed, 57 insertions(+), 79 deletions(-)
>
> Index: linux-pm/drivers/thermal/thermal_core.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -756,12 +756,10 @@ static int thermal_instance_add(struct t
>
>         list_add_tail(&new_instance->trip_node, &td->thermal_instances);
>
> -       mutex_lock(&cdev->lock);
> +       guard(cooling_dev)(cdev);
>
>         list_add_tail(&new_instance->cdev_node, &cdev->thermal_instances)=
;
>
> -       mutex_unlock(&cdev->lock);
> -
>         return 0;
>  }
>
> @@ -870,11 +868,9 @@ static void thermal_instance_delete(stru
>  {
>         list_del(&instance->trip_node);
>
> -       mutex_lock(&instance->cdev->lock);
> +       guard(cooling_dev)(instance->cdev);
>
>         list_del(&instance->cdev_node);
> -
> -       mutex_unlock(&instance->cdev->lock);
>  }
>
>  /**
> @@ -1237,10 +1233,10 @@ void thermal_cooling_device_update(struc
>          * Update under the cdev lock to prevent the state from being set=
 beyond
>          * the new limit concurrently.
>          */
> -       mutex_lock(&cdev->lock);
> +       guard(cooling_dev)(cdev);
>
>         if (cdev->ops->get_max_state(cdev, &cdev->max_state))
> -               goto unlock;
> +               return;
>
>         thermal_cooling_device_stats_reinit(cdev);
>
> @@ -1267,12 +1263,9 @@ void thermal_cooling_device_update(struc
>         }
>
>         if (cdev->ops->get_cur_state(cdev, &state) || state > cdev->max_s=
tate)
> -               goto unlock;
> +               return;
>
>         thermal_cooling_device_stats_update(cdev, state);
> -
> -unlock:
> -       mutex_unlock(&cdev->lock);
>  }
>  EXPORT_SYMBOL_GPL(thermal_cooling_device_update);
>
> Index: linux-pm/include/linux/thermal.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/include/linux/thermal.h
> +++ linux-pm/include/linux/thermal.h
> @@ -137,6 +137,9 @@ struct thermal_cooling_device {
>  #endif
>  };
>
> +DEFINE_GUARD(cooling_dev, struct thermal_cooling_device *, mutex_lock(&_=
T->lock),
> +            mutex_unlock(&_T->lock))
> +
>  /* Structure to define Thermal Zone parameters */
>  struct thermal_zone_params {
>         const char *governor_name;
> Index: linux-pm/drivers/thermal/thermal_sysfs.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> +++ linux-pm/drivers/thermal/thermal_sysfs.c
> @@ -544,14 +544,15 @@ cur_state_store(struct device *dev, stru
>         if (state > cdev->max_state)
>                 return -EINVAL;
>
> -       mutex_lock(&cdev->lock);
> +       guard(cooling_dev)(cdev);
>
>         result =3D cdev->ops->set_cur_state(cdev, state);
> -       if (!result)
> -               thermal_cooling_device_stats_update(cdev, state);
> +       if (result)
> +               return result;
>
> -       mutex_unlock(&cdev->lock);
> -       return result ? result : count;
> +       thermal_cooling_device_stats_update(cdev, state);
> +
> +       return count;
>  }
>
>  static struct device_attribute
> @@ -625,21 +626,18 @@ static ssize_t total_trans_show(struct d
>  {
>         struct thermal_cooling_device *cdev =3D to_cooling_device(dev);
>         struct cooling_dev_stats *stats;
> -       int ret =3D 0;
> +       int ret;
>
> -       mutex_lock(&cdev->lock);
> +       guard(cooling_dev)(cdev);
>
>         stats =3D cdev->stats;
>         if (!stats)
> -               goto unlock;
> +               return 0;
>
>         spin_lock(&stats->lock);
>         ret =3D sprintf(buf, "%u\n", stats->total_trans);
>         spin_unlock(&stats->lock);
>
> -unlock:
> -       mutex_unlock(&cdev->lock);
> -
>         return ret;
>  }
>
> @@ -652,11 +650,11 @@ time_in_state_ms_show(struct device *dev
>         ssize_t len =3D 0;
>         int i;
>
> -       mutex_lock(&cdev->lock);
> +       guard(cooling_dev)(cdev);
>
>         stats =3D cdev->stats;
>         if (!stats)
> -               goto unlock;
> +               return 0;
>
>         spin_lock(&stats->lock);
>
> @@ -668,9 +666,6 @@ time_in_state_ms_show(struct device *dev
>         }
>         spin_unlock(&stats->lock);
>
> -unlock:
> -       mutex_unlock(&cdev->lock);
> -
>         return len;
>  }
>
> @@ -682,11 +677,11 @@ reset_store(struct device *dev, struct d
>         struct cooling_dev_stats *stats;
>         int i, states;
>
> -       mutex_lock(&cdev->lock);
> +       guard(cooling_dev)(cdev);
>
>         stats =3D cdev->stats;
>         if (!stats)
> -               goto unlock;
> +               return count;
>
>         states =3D cdev->max_state + 1;
>
> @@ -702,9 +697,6 @@ reset_store(struct device *dev, struct d
>
>         spin_unlock(&stats->lock);
>
> -unlock:
> -       mutex_unlock(&cdev->lock);
> -
>         return count;
>  }
>
> @@ -716,13 +708,11 @@ static ssize_t trans_table_show(struct d
>         ssize_t len =3D 0;
>         int i, j;
>
> -       mutex_lock(&cdev->lock);
> +       guard(cooling_dev)(cdev);
>
>         stats =3D cdev->stats;
> -       if (!stats) {
> -               len =3D -ENODATA;
> -               goto unlock;
> -       }
> +       if (!stats)
> +               return -ENODATA;
>
>         len +=3D snprintf(buf + len, PAGE_SIZE - len, " From  :    To\n")=
;
>         len +=3D snprintf(buf + len, PAGE_SIZE - len, "       : ");

There is one more "goto unlock" statement in this function that needs
to be replaced with "return".

I'll send an update of it shortly.

> @@ -760,9 +750,6 @@ static ssize_t trans_table_show(struct d
>                 len =3D -EFBIG;
>         }
>
> -unlock:
> -       mutex_unlock(&cdev->lock);
> -
>         return len;
>  }
>
> Index: linux-pm/drivers/thermal/thermal_helpers.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/thermal/thermal_helpers.c
> +++ linux-pm/drivers/thermal/thermal_helpers.c
> @@ -58,17 +58,10 @@ bool thermal_trip_is_bound_to_cdev(struc
>                                    const struct thermal_trip *trip,
>                                    struct thermal_cooling_device *cdev)
>  {
> -       bool ret;
> -
>         guard(thermal_zone)(tz);
> +       guard(cooling_dev)(cdev);
>
> -       mutex_lock(&cdev->lock);
> -
> -       ret =3D thermal_instance_present(tz, cdev, trip);
> -
> -       mutex_unlock(&cdev->lock);
> -
> -       return ret;
> +       return thermal_instance_present(tz, cdev, trip);
>  }
>  EXPORT_SYMBOL_GPL(thermal_trip_is_bound_to_cdev);
>
> @@ -197,12 +190,12 @@ void __thermal_cdev_update(struct therma
>   */
>  void thermal_cdev_update(struct thermal_cooling_device *cdev)
>  {
> -       mutex_lock(&cdev->lock);
> +       guard(cooling_dev)(cdev);
> +
>         if (!cdev->updated) {
>                 __thermal_cdev_update(cdev);
>                 cdev->updated =3D true;
>         }
> -       mutex_unlock(&cdev->lock);
>  }
>
>  /**
> @@ -211,11 +204,9 @@ void thermal_cdev_update(struct thermal_
>   */
>  void thermal_cdev_update_nocheck(struct thermal_cooling_device *cdev)
>  {
> -       mutex_lock(&cdev->lock);
> +       guard(cooling_dev)(cdev);
>
>         __thermal_cdev_update(cdev);
> -
> -       mutex_unlock(&cdev->lock);
>  }
>
>  /**
> Index: linux-pm/drivers/thermal/thermal_debugfs.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/thermal/thermal_debugfs.c
> +++ linux-pm/drivers/thermal/thermal_debugfs.c
> @@ -516,6 +516,19 @@ void thermal_debug_cdev_add(struct therm
>         cdev->debugfs =3D thermal_dbg;
>  }
>
> +static struct thermal_debugfs *thermal_debug_cdev_clear(struct thermal_c=
ooling_device *cdev)
> +{
> +       struct thermal_debugfs *thermal_dbg;
> +
> +       guard(cooling_dev)(cdev);
> +
> +       thermal_dbg =3D cdev->debugfs;
> +       if (thermal_dbg)
> +               cdev->debugfs =3D NULL;
> +
> +       return thermal_dbg;
> +}
> +
>  /**
>   * thermal_debug_cdev_remove - Remove a cooling device debugfs entry
>   *
> @@ -527,17 +540,9 @@ void thermal_debug_cdev_remove(struct th
>  {
>         struct thermal_debugfs *thermal_dbg;
>
> -       mutex_lock(&cdev->lock);
> -
> -       thermal_dbg =3D cdev->debugfs;
> -       if (!thermal_dbg) {
> -               mutex_unlock(&cdev->lock);
> +       thermal_dbg =3D thermal_debug_cdev_clear(cdev);
> +       if (!thermal_dbg)
>                 return;
> -       }
> -
> -       cdev->debugfs =3D NULL;
> -
> -       mutex_unlock(&cdev->lock);
>
>         mutex_lock(&thermal_dbg->lock);
>
> Index: linux-pm/drivers/thermal/gov_power_allocator.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/thermal/gov_power_allocator.c
> +++ linux-pm/drivers/thermal/gov_power_allocator.c
> @@ -549,18 +549,17 @@ static void allow_maximum_power(struct t
>                 cdev =3D instance->cdev;
>
>                 instance->target =3D 0;
> -               mutex_lock(&cdev->lock);
> -               /*
> -                * Call for updating the cooling devices local stats and =
avoid
> -                * periods of dozen of seconds when those have not been
> -                * maintained.
> -                */
> -               cdev->ops->get_requested_power(cdev, &req_power);
> +               scoped_guard(cooling_dev, cdev) {
> +                       /*
> +                        * Call for updating the cooling devices local st=
ats and
> +                        * avoid periods of dozen of seconds when those h=
ave not
> +                        * been maintained.
> +                        */
> +                       cdev->ops->get_requested_power(cdev, &req_power);
>
> -               if (params->update_cdevs)
> -                       __thermal_cdev_update(cdev);
> -
> -               mutex_unlock(&cdev->lock);
> +                       if (params->update_cdevs)
> +                               __thermal_cdev_update(cdev);
> +               }
>         }
>  }
>
> Index: linux-pm/drivers/thermal/gov_step_wise.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/thermal/gov_step_wise.c
> +++ linux-pm/drivers/thermal/gov_step_wise.c
> @@ -97,9 +97,9 @@ static void thermal_zone_trip_update(str
>
>                 instance->initialized =3D true;
>
> -               mutex_lock(&instance->cdev->lock);
> -               instance->cdev->updated =3D false; /* cdev needs update *=
/
> -               mutex_unlock(&instance->cdev->lock);
> +               scoped_guard(cooling_dev, instance->cdev) {
> +                       instance->cdev->updated =3D false; /* cdev needs =
update */
> +               }
>         }
>  }
>
>
>
>
>

