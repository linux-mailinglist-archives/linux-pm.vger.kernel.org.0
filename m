Return-Path: <linux-pm+bounces-40944-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1837D28498
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 21:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AA9330109BD
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 20:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836A130DEBE;
	Thu, 15 Jan 2026 20:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hddfCIAe"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601922E8B8A
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 20:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768507467; cv=none; b=Ii6qrfBNF915SosX4aeuddqKlTEjnQy9EXw3B1IhVuUZUvRC1UX0/IGDJpY3JU88EMWeXOMzdOH44Sy9UjvKqZl0KU4I2v4V1B/MVQo1EXfAsN4F9TLeluqmfFUjG3dBTqDxWWWMw1cl5wkQb4jzH8gUxM+HpmraCCa2QInqKhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768507467; c=relaxed/simple;
	bh=J1emvreG1y06sptxq4HrUL9FOlFVOtMCyMti+beq/bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePUp9otncA3EjFwaUqoTbmwz1dIBJGVKZZfU0IrflZNrXe8c4PaVeQbh3b6SW/tefWfXuPISAdNnOuJh6b31Kua0Bp5QO6HlgCrEqiJ6D946Ir9se6exIqgF592oqrKu83ZHJgmtToNBX8i303L4qEOKDEuKYe4h8yDUO2FnVMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hddfCIAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07567C16AAE
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 20:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768507467;
	bh=J1emvreG1y06sptxq4HrUL9FOlFVOtMCyMti+beq/bs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hddfCIAe4frqohFlb3s2rpJ3suWNqZejxMvPDVfSOp4vEhsQZ2HPS+M/KTnEoW7d3
	 X6poqJVk70ZasfobvRS5kBJt5zCppOEW2hf1XEO5JMpspOlyIeUkIKdhXS2OhhgFR9
	 NCCLgAVXzaqVZzqvAU1y/JU74WlBLqG/NA2rYjQaPxrbMaYsdTYhYZ9wHgwort9FlE
	 uICCVTAR6mlVjhjOLb9E4+UnSpVDvohzKcKqMJIHCZmAa73Fpu0NHa6E66nlV/5YEh
	 Xm7tNWoQs/wsDaR2Kn35fJa+UOGdw5rLFHtvqZ0EMuD+sMjWeJHu1IeoSA7zskjshY
	 xe75o8QWvSiPw==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6610f045c1eso563841eaf.2
        for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 12:04:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWGfar/zgeqr/JEREfM4xzzrzy1YDSfeXXuuL9il61NX6T3YPKQPmVKI8Kso1gOUHGZPBdUA2GS2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiNyvz2yA6arsCjC5p8qnQyGEZFu3TY3U4U0A/4XBIGSXAeB0i
	t5mX0DhmaRQ+az2wgfQQRarzj4COE1CMo+BmHp86LUtQWxH4JHWHNd6HwEg9ACypX1jyjlzESvj
	CerWGA2HfFPzZ5jQjF/FZxM9/wfBqOiU=
X-Received: by 2002:a05:6820:2006:b0:659:9a49:9025 with SMTP id
 006d021491bc7-66117a16471mr365214eaf.82.1768507466052; Thu, 15 Jan 2026
 12:04:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110092851.9078-1-sumeet4linux@gmail.com>
In-Reply-To: <20260110092851.9078-1-sumeet4linux@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 15 Jan 2026 21:04:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i46-FXj_GYT5o255yGfE24PVEiSwHx_AtOyymBKx=wfQ@mail.gmail.com>
X-Gm-Features: AZwV_QilStzuDmGHsvlxQ2Gl1ZRJuTDq4Wwcgc3A6b5OwTpziRmeSid0e247G1U
Message-ID: <CAJZ5v0i46-FXj_GYT5o255yGfE24PVEiSwHx_AtOyymBKx=wfQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: Replace sprintf() with sysfs_emit() for sysfs
 show functions
To: Sumeet Pawnikar <sumeet4linux@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 10:29=E2=80=AFAM Sumeet Pawnikar <sumeet4linux@gmai=
l.com> wrote:
>
> Replace all sprintf() calls with sysfs_emit() and sysfs_emit_at() in
> sysfs show functions. sysfs_emit() and sysfs_emit_at() are preferred
> over sprintf() for formatting sysfs output as they provide better
> bounds checking and prevent potential buffer overflows.
>
> Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
> ---
>  drivers/thermal/thermal_hwmon.c |  4 ++--
>  drivers/thermal/thermal_sysfs.c | 36 ++++++++++++++++-----------------
>  2 files changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hw=
mon.c
> index 64cc3ab949fe..faf1d0083890 100644
> --- a/drivers/thermal/thermal_hwmon.c
> +++ b/drivers/thermal/thermal_hwmon.c
> @@ -63,7 +63,7 @@ temp_input_show(struct device *dev, struct device_attri=
bute *attr, char *buf)
>         if (ret)
>                 return ret;
>
> -       return sprintf(buf, "%d\n", temperature);
> +       return sysfs_emit(buf, "%d\n", temperature);
>  }
>
>  static ssize_t
> @@ -84,7 +84,7 @@ temp_crit_show(struct device *dev, struct device_attrib=
ute *attr, char *buf)
>         if (ret)
>                 return ret;
>
> -       return sprintf(buf, "%d\n", temperature);
> +       return sysfs_emit(buf, "%d\n", temperature);
>  }
>
>
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sy=
sfs.c
> index d80612506a33..26b8b340fbe6 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -29,7 +29,7 @@ type_show(struct device *dev, struct device_attribute *=
attr, char *buf)
>  {
>         struct thermal_zone_device *tz =3D to_thermal_zone(dev);
>
> -       return sprintf(buf, "%s\n", tz->type);
> +       return sysfs_emit(buf, "%s\n", tz->type);
>  }
>
>  static ssize_t
> @@ -41,7 +41,7 @@ temp_show(struct device *dev, struct device_attribute *=
attr, char *buf)
>         ret =3D thermal_zone_get_temp(tz, &temperature);
>
>         if (!ret)
> -               return sprintf(buf, "%d\n", temperature);
> +               return sysfs_emit(buf, "%d\n", temperature);
>
>         if (ret =3D=3D -EAGAIN)
>                 return -ENODATA;
> @@ -57,9 +57,9 @@ mode_show(struct device *dev, struct device_attribute *=
attr, char *buf)
>         guard(thermal_zone)(tz);
>
>         if (tz->mode =3D=3D THERMAL_DEVICE_ENABLED)
> -               return sprintf(buf, "enabled\n");
> +               return sysfs_emit(buf, "enabled\n");
>
> -       return sprintf(buf, "disabled\n");
> +       return sysfs_emit(buf, "disabled\n");
>  }
>
>  static ssize_t
> @@ -97,7 +97,7 @@ trip_point_type_show(struct device *dev, struct device_=
attribute *attr,
>  {
>         struct thermal_trip *trip =3D thermal_trip_of_attr(attr, type);
>
> -       return sprintf(buf, "%s\n", thermal_trip_type_name(trip->type));
> +       return sysfs_emit(buf, "%s\n", thermal_trip_type_name(trip->type)=
);
>  }
>
>  static ssize_t
> @@ -142,7 +142,7 @@ trip_point_temp_show(struct device *dev, struct devic=
e_attribute *attr,
>  {
>         struct thermal_trip *trip =3D thermal_trip_of_attr(attr, temp);
>
> -       return sprintf(buf, "%d\n", READ_ONCE(trip->temperature));
> +       return sysfs_emit(buf, "%d\n", READ_ONCE(trip->temperature));
>  }
>
>  static ssize_t
> @@ -188,7 +188,7 @@ trip_point_hyst_show(struct device *dev, struct devic=
e_attribute *attr,
>  {
>         struct thermal_trip *trip =3D thermal_trip_of_attr(attr, hyst);
>
> -       return sprintf(buf, "%d\n", READ_ONCE(trip->hysteresis));
> +       return sysfs_emit(buf, "%d\n", READ_ONCE(trip->hysteresis));
>  }
>
>  static ssize_t
> @@ -213,7 +213,7 @@ policy_show(struct device *dev, struct device_attribu=
te *devattr, char *buf)
>  {
>         struct thermal_zone_device *tz =3D to_thermal_zone(dev);
>
> -       return sprintf(buf, "%s\n", tz->governor->name);
> +       return sysfs_emit(buf, "%s\n", tz->governor->name);
>  }
>
>  static ssize_t
> @@ -260,7 +260,7 @@ sustainable_power_show(struct device *dev, struct dev=
ice_attribute *devattr,
>         struct thermal_zone_device *tz =3D to_thermal_zone(dev);
>
>         if (tz->tzp)
> -               return sprintf(buf, "%u\n", tz->tzp->sustainable_power);
> +               return sysfs_emit(buf, "%u\n", tz->tzp->sustainable_power=
);
>         else
>                 return -EIO;
>  }
> @@ -291,7 +291,7 @@ sustainable_power_store(struct device *dev, struct de=
vice_attribute *devattr,
>         struct thermal_zone_device *tz =3D to_thermal_zone(dev);         =
 \
>                                                                         \
>         if (tz->tzp)                                                    \
> -               return sprintf(buf, "%d\n", tz->tzp->name);             \
> +               return sysfs_emit(buf, "%d\n", tz->tzp->name);          \
>         else                                                            \
>                 return -EIO;                                            \
>         }                                                               \
> @@ -505,7 +505,7 @@ cdev_type_show(struct device *dev, struct device_attr=
ibute *attr, char *buf)
>  {
>         struct thermal_cooling_device *cdev =3D to_cooling_device(dev);
>
> -       return sprintf(buf, "%s\n", cdev->type);
> +       return sysfs_emit(buf, "%s\n", cdev->type);
>  }
>
>  static ssize_t max_state_show(struct device *dev, struct device_attribut=
e *attr,
> @@ -513,7 +513,7 @@ static ssize_t max_state_show(struct device *dev, str=
uct device_attribute *attr,
>  {
>         struct thermal_cooling_device *cdev =3D to_cooling_device(dev);
>
> -       return sprintf(buf, "%ld\n", cdev->max_state);
> +       return sysfs_emit(buf, "%ld\n", cdev->max_state);
>  }
>
>  static ssize_t cur_state_show(struct device *dev, struct device_attribut=
e *attr,
> @@ -526,7 +526,7 @@ static ssize_t cur_state_show(struct device *dev, str=
uct device_attribute *attr,
>         ret =3D cdev->ops->get_cur_state(cdev, &state);
>         if (ret)
>                 return ret;
> -       return sprintf(buf, "%ld\n", state);
> +       return sysfs_emit(buf, "%ld\n", state);
>  }
>
>  static ssize_t
> @@ -638,7 +638,7 @@ static ssize_t total_trans_show(struct device *dev,
>                 return 0;
>
>         spin_lock(&stats->lock);
> -       ret =3D sprintf(buf, "%u\n", stats->total_trans);
> +       ret =3D sysfs_emit(buf, "%u\n", stats->total_trans);
>         spin_unlock(&stats->lock);
>
>         return ret;
> @@ -664,8 +664,8 @@ time_in_state_ms_show(struct device *dev, struct devi=
ce_attribute *attr,
>         update_time_in_state(stats);
>
>         for (i =3D 0; i <=3D cdev->max_state; i++) {
> -               len +=3D sprintf(buf + len, "state%u\t%llu\n", i,
> -                              ktime_to_ms(stats->time_in_state[i]));
> +               len +=3D sysfs_emit_at(buf, len, "state%u\t%llu\n", i,
> +                                    ktime_to_ms(stats->time_in_state[i])=
);
>         }
>         spin_unlock(&stats->lock);
>
> @@ -846,7 +846,7 @@ trip_point_show(struct device *dev, struct device_att=
ribute *attr, char *buf)
>
>         instance =3D container_of(attr, struct thermal_instance, attr);
>
> -       return sprintf(buf, "%d\n", thermal_zone_trip_id(tz, instance->tr=
ip));
> +       return sysfs_emit(buf, "%d\n", thermal_zone_trip_id(tz, instance-=
>trip));
>  }
>
>  ssize_t
> @@ -856,7 +856,7 @@ weight_show(struct device *dev, struct device_attribu=
te *attr, char *buf)
>
>         instance =3D container_of(attr, struct thermal_instance, weight_a=
ttr);
>
> -       return sprintf(buf, "%d\n", instance->weight);
> +       return sysfs_emit(buf, "%d\n", instance->weight);
>  }
>
>  ssize_t weight_store(struct device *dev, struct device_attribute *attr,
> --

Applied as 6.20 material, thanks!

