Return-Path: <linux-pm+bounces-20889-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51941A1AA6B
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 20:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5B43A2122
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 19:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288A8155A59;
	Thu, 23 Jan 2025 19:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLhOivco"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34D317741;
	Thu, 23 Jan 2025 19:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737661156; cv=none; b=CiapRdI1QM4NB2w6GlPqdk68IK7btLvv3vpXwY0ZocbQAPoJrXK1gY3f2xOKG7nJ3z6teWvq7214/U8wyDGr7a5u3+Zi1cmt1ofn3VNmv1BTw3vyfcgmoMGgRWVgcvoQ1M8mbHGiNIPkHUlqyRw8JUj298dteiTrIOq5+OM5Pqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737661156; c=relaxed/simple;
	bh=R9JkZIZ/TejEMDlVk9CsAhR5hX7leZLRBuMmG37Jb9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BO/6OyCgiTvQ5giGfbpNV84kGK9PYE7hFvd6rpv0Hpx7lTIokJf8La9JPhV321/uZE5YKx8Xpuj4UAIX+TERvV05GbrgQfFMIVa8UDFiHNUX9Oy3VYrIou81+AkemioLvSUeiprOoTF/lC/l+IeiYKiIbnZheLweZYGgyPqkGNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLhOivco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F13C4CED3;
	Thu, 23 Jan 2025 19:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737661154;
	bh=R9JkZIZ/TejEMDlVk9CsAhR5hX7leZLRBuMmG37Jb9E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QLhOivco8K8DgolEyD9vczoQj9aqCr3Aad/3tiqF12k4Ci4Sd1WgwqXIREwCacGIx
	 kCiEE6HQhggf2faJzcN+RpFA+eODJI7N42/xv3dw2XO1p8rRsXpgtGxE0swq3/LXOi
	 Ow0xt3M9L5ydo4g6euxRI8Ro/TkpRNUejuht/euTgPwhkv0f5Le7UTo73p4ls4gg88
	 gNtb12S/vv3yCnd6u/wYcRQVrbNSQxNzawmBh+Kx/hhuv+EYUk4cBr24bRlWnuiM1e
	 E9BnvHWgPCTRFAkgFuuby0mxSbKYFCOPKUA6Nmx2fcvaVPq7d8qd4GzVXMhDjG6lmc
	 BfcRVGFhdUp3Q==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3eb880e5ac2so834494b6e.2;
        Thu, 23 Jan 2025 11:39:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUvIex/j0eHD4X9CbyEmUJBp8ejR0sulb9zqYBMVwCNIQ2wYBNKp9h5ITa6Jx/6Fvrk2m5IwORNeFKAEv8=@vger.kernel.org, AJvYcCWoeWUIIptCwOH3SPNko/5+YzLRA59Ct5FEyw0Rgj67hz9yl3ZoIl6c/tZOu68NDzByFrbbDERjau8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaSUs7jIUtMz/NAvSSjWMAdgRcD+eTxO3+tXHsxVsx0VXxoYVF
	7siRMxOZ+Rh/3JBDabeat3GJxdD32H/38OMm6xETwuSk0zhU0EsP//nLwLKjrmZJamQC2XUzPM0
	pmP+/MuiNHq6PTkuquV3GenZWGbM=
X-Google-Smtp-Source: AGHT+IGE5ApcuciVrGEd8UcnhtFxxwFQvrlVTppqrenYVp2wR9TE1tipXaX+FI4A81aZH33rblGlAddqIrUkTzLt6DQ=
X-Received: by 2002:a05:6808:1b23:b0:3eb:a602:62b1 with SMTP id
 5614622812f47-3f19fca4cbcmr18013989b6e.17.1737661153750; Thu, 23 Jan 2025
 11:39:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1737631669.git.viresh.kumar@linaro.org> <22b68afa4ce5a0a2e77bb3a08e1cb7ac75f70f72.1737631669.git.viresh.kumar@linaro.org>
In-Reply-To: <22b68afa4ce5a0a2e77bb3a08e1cb7ac75f70f72.1737631669.git.viresh.kumar@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Jan 2025 20:39:02 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hnvgtqer8j82EmWNv7ATTS5LFC=_2nX5i-CEnbwGpALA@mail.gmail.com>
X-Gm-Features: AWEUYZkY0h7co10K3cgk6ExYRu-GQ-UcVwP-0jUcNLKO51vTEqvsqjInD0qhNgk
Message-ID: <CAJZ5v0hnvgtqer8j82EmWNv7ATTS5LFC=_2nX5i-CEnbwGpALA@mail.gmail.com>
Subject: Re: [PATCH 01/33] cpufreq: Always create freq-table related sysfs file
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 12:38=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> Currently it is left for the individual drivers to set the available and
> boost frequencies related attributes in the cpufreq_driver->attr field.
> Some drivers provide them, while others don't.
>
> A quick search revealed that only the drivers that set the
> policy->freq_table field, enable these attributes. Which makes sense as
> well, since the show_available_freqs() helper works only if the
> freq_table is present.
>
> In order to simplify drivers, create the relevant sysfs files forcefully
> from cpufreq core.
>
> For now, skip adding them twice. This can be removed once all the
> drivers are updated.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/cpufreq/cpufreq.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 1a4cae54a01b..973bd6e4bdd4 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1058,9 +1058,31 @@ static int cpufreq_add_dev_interface(struct cpufre=
q_policy *policy)
>         struct freq_attr **drv_attr;
>         int ret =3D 0;
>
> +       /* Attributes that need freq_table */
> +       if (policy->freq_table) {
> +               ret =3D sysfs_create_file(&policy->kobj,
> +                               &cpufreq_freq_attr_scaling_available_freq=
s.attr);
> +               if (ret)
> +                       return ret;
> +
> +               if (cpufreq_boost_supported()) {
> +                       ret =3D sysfs_create_file(&policy->kobj,
> +                               &cpufreq_freq_attr_scaling_boost_freqs.at=
tr);
> +                       if (ret)
> +                               return ret;
> +               }
> +       }
> +
>         /* set up files for this cpu device */
>         drv_attr =3D cpufreq_driver->attr;
>         while (drv_attr && *drv_attr) {
> +               /* These are already added, skip them */
> +               if (*drv_attr =3D=3D &cpufreq_freq_attr_scaling_available=
_freqs ||
> +                   *drv_attr =3D=3D &cpufreq_freq_attr_scaling_boost_fre=
qs) {
> +                       drv_attr++;
> +                       continue;
> +               }
> +
>                 ret =3D sysfs_create_file(&policy->kobj, &((*drv_attr)->a=
ttr));
>                 if (ret)
>                         return ret;
> --
> 2.31.1.272.g89b43f80a514
>

