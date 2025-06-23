Return-Path: <linux-pm+bounces-29362-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC29AE48B4
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 17:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A8C4A0987
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 15:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A8F25C71A;
	Mon, 23 Jun 2025 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFN2jnyo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2978415B971;
	Mon, 23 Jun 2025 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750692656; cv=none; b=T6Hw5xMS2Vnt/oP/SYlfsWjdDMISCIq1i7HGFZnBVMLmjuopAkH+YsoQFpUo/P+YVD9iMXOE4nNV2upcj3pvH3Dto9MLc71ew06ubrW7ishv3Hco/wmsjEufxehWSfOBo1JNIrXtpVHaYGVzdvB+kQHkXDTP0J9iJd/DmC3esqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750692656; c=relaxed/simple;
	bh=w8Dnt4rNYB2Yfj0F9id0Q9CQfAhyf767XNDo1qH05a0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C76eI8xErhzh20LJ6lUmqxYP+Lzm2BZbTyFbNrkyDDKvBhd6uXlRqWRG4SpiDyeBMjgIEawsVVTqeoJ1SS3pkU22qw+G/tmmcpBqVN2gb4pE01usEwxyT+UuL3u8Hat6TcvFeyCm9OqEqV6VPsTYzUYRppJIF3EwLPmooNGEEYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFN2jnyo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A599FC4CEEF;
	Mon, 23 Jun 2025 15:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750692655;
	bh=w8Dnt4rNYB2Yfj0F9id0Q9CQfAhyf767XNDo1qH05a0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iFN2jnyo2iWV86J3mtgzb7la+zYVWuxoz4u0LahMnyxCBN4aqLVwemmnirLGvmMd6
	 EQK5OV7HJUgDnegVPEhUi8+XHL4tCPe7lYsbvlAwHm4MudlQmJRIKRIT7XenUTq1Qp
	 FXKmsYKjgseKixSCZpoTzaEzYSPxGhtQtPUwq1XtUaVkhWNqHf63y3iU4TkawFMS14
	 Zk88clTRoXsuO4nxH8KiWEgKy2R4XaobGEtXNmF0m/gkiDvbG3PmnnKBF2xbNhLIXh
	 BJkKL+0djYa5wzbzeKVvH6xzjU3NKqHIOj0lVfXTLUwGmLmHcvqXjrVIl7FNo+AoqV
	 WigeaZsvPCyVw==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-611827bd683so506390eaf.0;
        Mon, 23 Jun 2025 08:30:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4LH+bxOng9brOJ7ohTc7orfJr042yJ0y5qmcpfufpwfWqsg412Ko/KWzF1f5ztTocyEpnC5x/T4hLZpQ=@vger.kernel.org, AJvYcCVTlNadCAbumhdxPGUcqg30Tmk9iGfFrNPQ2rbZ09AjU3dL07LbagQmnlLbvd8UU5++Y6sK+bn6kcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YymU6MWt+oyLvExLv+uDElRjQoLkk+kaF9Q91ot9zlKFXcB6fVF
	iRqwpAVBrBgZ7y9yWE1H74/vq4p1j+f3l+/kNHn60JXXAl+oEgZjePaIO1X/JEy4n9clUz6gnTh
	rn28xH331OS8W9vthrWTgY960b8XnZcE=
X-Google-Smtp-Source: AGHT+IFEHjPNXmsLMf1CmtMBMZpf8gObthk5wQojfBRJKHMRuCLkNe+gFtJKljeN0HNEiPl860loD6+zYjcfY82g7oU=
X-Received: by 2002:a05:6820:f48:b0:611:5a3b:9ce9 with SMTP id
 006d021491bc7-6115bb0e72emr9008941eaf.7.1750692654990; Mon, 23 Jun 2025
 08:30:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623133402.3120230-1-zhenglifeng1@huawei.com> <20250623133402.3120230-4-zhenglifeng1@huawei.com>
In-Reply-To: <20250623133402.3120230-4-zhenglifeng1@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 23 Jun 2025 17:30:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jvdttYihgNcTF=VVnd2K5QsC+W9XJJanqy4F_PXw+u2g@mail.gmail.com>
X-Gm-Features: AX0GCFvbSFdejTwNWkx-8BFU2U2H8vGGfyobrhK6VbLomE2gnlzhGj2xV51V9Mg
Message-ID: <CAJZ5v0jvdttYihgNcTF=VVnd2K5QsC+W9XJJanqy4F_PXw+u2g@mail.gmail.com>
Subject: Re: [PATCH 3/7] cpufreq: Contain scaling_cur_freq.attr in cpufreq_attrs
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, ionela.voinescu@arm.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 3:34=E2=80=AFPM Lifeng Zheng <zhenglifeng1@huawei.c=
om> wrote:
>
> After commit c034b02e213d ("cpufreq: expose scaling_cur_freq sysfs file f=
or
> set_policy() drivers"), the file scaling_cur_freq is exposed to all
> drivers. No need to create this file separately. It's better to be
> contained in cpufreq_attrs.

Fair enough.

> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index efc1f4ac85cb..2303890de0ba 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -967,6 +967,7 @@ static struct attribute *cpufreq_attrs[] =3D {
>         &cpuinfo_min_freq.attr,
>         &cpuinfo_max_freq.attr,
>         &cpuinfo_transition_latency.attr,
> +       &scaling_cur_freq.attr,
>         &scaling_min_freq.attr,
>         &scaling_max_freq.attr,
>         &affected_cpus.attr,
> @@ -1095,10 +1096,6 @@ static int cpufreq_add_dev_interface(struct cpufre=
q_policy *policy)
>                         return ret;
>         }
>
> -       ret =3D sysfs_create_file(&policy->kobj, &scaling_cur_freq.attr);
> -       if (ret)
> -               return ret;
> -
>         if (cpufreq_driver->bios_limit) {
>                 ret =3D sysfs_create_file(&policy->kobj, &bios_limit.attr=
);
>                 if (ret)
> --
> 2.33.0
>

