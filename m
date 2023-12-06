Return-Path: <linux-pm+bounces-767-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615088079A1
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 21:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A27328227B
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 20:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E7DD286;
	Wed,  6 Dec 2023 20:41:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964B3135;
	Wed,  6 Dec 2023 12:41:17 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1fb00ea5e5fso36422fac.1;
        Wed, 06 Dec 2023 12:41:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701895277; x=1702500077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlhVPOODXTOWxGwKg9e3DDYoZLed8F9HR5wooT/tC2c=;
        b=QLC4wXqyj/T8ERSCaT7olfK+3lA8UwpoXB7yz0AAwp9s41jtJEIZ0nGNDNqkf9IKaX
         pO3DYMFWoN/hEYFHyxxsxn70XMsvBAewB85IPXIkiGG6HsDQBxyouDKpANkE8mG/e01z
         F9UZoa186LfyntFwwBseS4ZLUyI4Tgl2H8sYOXmY/Icn/dXAtxPfcx6Vpar6/snBLd/9
         EXghDuJcMZUaMRdow4CBWUDhevVBzJ5L7RXdTn/xd0sFhZwxq+PqerIUYOi7RVDcDj6Q
         YBu5M469OzMmEuVSMVjo6G0BTlPOKjKhYNPWPPVP24aB3yhSAYVbkGZDozU53PFSIUar
         qCtA==
X-Gm-Message-State: AOJu0YyC/X50n+EwCgqqu/iNslLDPh4wo3dUVPTCzL8KXtxzKldPFF2Z
	gzcURKA5Dz9s8ldd9QO4yGjlnJ5z/MfxR/SJ5gs=
X-Google-Smtp-Source: AGHT+IH29a0cqz8yIEZIWDtTFVH9l0IVy1IzNJ+5GfLNckU6RPGEogazu+hpKFXH3CqXxC153jfnqv5q+7dvgNmnksA=
X-Received: by 2002:a05:6870:b4a0:b0:1fb:5e42:5096 with SMTP id
 y32-20020a056870b4a000b001fb5e425096mr2586685oap.5.1701895276869; Wed, 06 Dec
 2023 12:41:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127160838.1403404-1-beata.michalska@arm.com> <20231127160838.1403404-3-beata.michalska@arm.com>
In-Reply-To: <20231127160838.1403404-3-beata.michalska@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Dec 2023 21:41:05 +0100
Message-ID: <CAJZ5v0jh3mG3hyFS6war=0bk3PvsVtTwZ1_YwwWov36Bmz7q0w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: Wire-up arch-flavored freq info into cpufreq_verify_current_freq
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, sumitg@nvidia.com, sudeep.holla@arm.covm, 
	will@kernel.org, catalin.marinas@arm.com, viresh.kumar@linaro.org, 
	rafael@kernel.org, ionela.voinescu@arm.com, yang@os.amperecomputing.com, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 5:09=E2=80=AFPM Beata Michalska <beata.michalska@ar=
m.com> wrote:
>
> From: Sumit Gupta <sumitg@nvidia.com>
>
> When available, use arch_freq_get_on_cpu to obtain current frequency
> (usually an average reported over given period of time)
> to better align the cpufreq's view on the current state of affairs.

And why is this a good idea?

Any problem statement?

> This also automatically pulls in the update for cpuinfo_cur_freq sysfs
> attribute, aligning it with the scaling_cur_freq one, and thus providing
> consistent view on relevant platforms.

I have no idea what the above is supposed to mean, sorry.

> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> [BM: Subject & commit msg]
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 8c4f9c2f9c44..109559438f45 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1756,7 +1756,8 @@ static unsigned int cpufreq_verify_current_freq(str=
uct cpufreq_policy *policy, b
>  {
>         unsigned int new_freq;
>
> -       new_freq =3D cpufreq_driver->get(policy->cpu);
> +       new_freq =3D arch_freq_get_on_cpu(policy->cpu);
> +       new_freq =3D new_freq ?: cpufreq_driver->get(policy->cpu);

Please don't use ?: in general and it is not even useful here AFAICS.

What would be wrong with

new_freq =3D arch_freq_get_on_cpu(policy->cpu);
if (!new_freq)
        new_freq =3D cpufreq_driver->get(policy->cpu);

?

>         if (!new_freq)
>                 return 0;
>
> --

