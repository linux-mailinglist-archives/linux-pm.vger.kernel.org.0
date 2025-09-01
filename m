Return-Path: <linux-pm+bounces-33577-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB699B3ECCA
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 18:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A90A2067C9
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 16:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5972DF150;
	Mon,  1 Sep 2025 16:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQm+20zW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC28E1ACEAF;
	Mon,  1 Sep 2025 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756745924; cv=none; b=p67VUj61wsSXqWzRwwugN2hzoNmInOmgi5qFqbyhXT5EFNidYlVSj7zVNC3e7IYH5Nnlqf1xR8y6mMcfltTAOYHlLNrmlZbgybNJCUNhrJCE8/YJdgALbNI/8Sb2GxRLCoxHwrEfXwDzdIvlsVhEQ+pkm6Bt+AXRxBwQBHEYURs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756745924; c=relaxed/simple;
	bh=JJvd2FZ5jfxr+1x2GaboYFAVICfun63sxKf9be92ynk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MfB51pzd9Lv1BP6F09gX83XsFHMumolrwnEg8THVDg8O4gOveX3HynZakVyD52Ib912D2sCXiwTNYLUuEYBx06v46cJEqYZvYKmI+4a0NBqD2jZVjUs2SWWWRRdy8BoNbWiG2wCtug5Xqj/Di9ijgylKfbGUFZ3dibpGfZS98lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQm+20zW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECF0C4CEF0;
	Mon,  1 Sep 2025 16:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756745923;
	bh=JJvd2FZ5jfxr+1x2GaboYFAVICfun63sxKf9be92ynk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AQm+20zWPVLFqm85Zdt5g5WyHklXt3BbfhkciJI+L3MNqpsUgJL6v7L02ZKkhVGLu
	 WSXblGPvU65aEDNYAM93V66vqLKIFlFDhE2omv4Hn7qay/AX5GrKb7RVPKLOKaUufi
	 5haEBjjhLGCUGZHyq61KgdKrsyigx7huHb6NaVINmtpP7TIV2v57McZEpg9iNpfuC8
	 HR0pfKMv+UB+LWwR5d25YKmJnkkLHRx96MLO6XGfAkSHH9HdSM4Sp+t1v+lpi5L6m6
	 1+0LQirG7l490KZ++KEXKa/4KYWFDm8aBm77EmK/hSFm+rQe62KeTrfuQwckaiXyBQ
	 1HopyEt3pJ/ZQ==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-61e482e1857so216434eaf.2;
        Mon, 01 Sep 2025 09:58:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU00r1Wz9FqoFrszR6AMoKWLaJPTWLMPdMaz3DK6PnYxvjP0PL3wL2D2kDiEu4/Ktse/KWviqU/8q8=@vger.kernel.org, AJvYcCWyXydDNw2DZGRrpg+Awp9Ud+TBe/77UosTbVLQqjTB7aVYorRgpHFHEryFtk/P1CFGkCb07/Vz@vger.kernel.org, AJvYcCXI4zq53CYhxNST/YaCtQiU9WrDf5zqCV2YuZpueHKirrZdRztIt3eIbr5D2HkXBqegVhBAwsVYB6wuXgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhds7ZMpONg3DfU69fNJFBXkmvQ/PUNLPx1Jadjx35XUw4/i09
	CguE/WjIRAMsuGPWWleqi4VAVU4SfnpriAE8YaSlM/iEcQeUQkQx7ETZRBWavz3rGYXBqwgOmDu
	TI53GU2AtCTenKC5x6QYZS2vM1HPb3Oc=
X-Google-Smtp-Source: AGHT+IEixMpzb+Nb/dROtrEfDYwQ2wKmvujX/nV7y7ACumEGFL5GSsy383+a2XBnxIb44R2GHLaoWcdr1hTDGbHLF9w=
X-Received: by 2002:a05:6820:1622:b0:61e:1ad6:1336 with SMTP id
 006d021491bc7-61e3370eff9mr4598474eaf.3.1756745922698; Mon, 01 Sep 2025
 09:58:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831214357.2020076-1-christian.loehle@arm.com>
In-Reply-To: <20250831214357.2020076-1-christian.loehle@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Sep 2025 18:58:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0idnFDYviDBusv8hvFD+yH71kL=Q_ARpn5cUBbAg838RQ@mail.gmail.com>
X-Gm-Features: Ac12FXyJX72zIBt8UBeC0anG1jcEXnb7NOGH6iOvZjeorqPjtLQaLpI9W9mZ-bM
Message-ID: <CAJZ5v0idnFDYviDBusv8hvFD+yH71kL=Q_ARpn5cUBbAg838RQ@mail.gmail.com>
Subject: Re: [PATCH] PM: EM: Fix late boot with holes in CPU topology
To: Christian Loehle <christian.loehle@arm.com>
Cc: rafael@kernel.org, lukasz.luba@arm.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com, 
	kenneth.crudup@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 31, 2025 at 11:44=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> commit e3f1164fc9ee ("PM: EM: Support late CPUs booting and capacity
> adjustment") added a mechanism to handle CPUs that come up late by
> retrying when any of the `cpufreq_cpu_get()` call fails.
>
> However, if there are holes in the CPU topology (offline CPUs, e.g.
> nosmt), the first missing CPU causes the loop to break, preventing
> subsequent online CPUs from being updated.
> Instead of aborting on the first missing CPU policy, loop through all
> and retry if any were missing.
>
> Fixes: e3f1164fc9ee ("PM: EM: Support late CPUs booting and capacity adju=
stment")
> Suggested-by: Kenneth Crudup <kenneth.crudup@gmail.com>
> Reported-by: Kenneth Crudup <kenneth.crudup@gmail.com>
> Closes: https://lore.kernel.org/linux-pm/40212796-734c-4140-8a85-854f72b8=
144d@panix.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  kernel/power/energy_model.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index ea7995a25780..b63c2afc1379 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -778,7 +778,7 @@ void em_adjust_cpu_capacity(unsigned int cpu)
>  static void em_check_capacity_update(void)
>  {
>         cpumask_var_t cpu_done_mask;
> -       int cpu;
> +       int cpu, failed_cpus =3D 0;
>
>         if (!zalloc_cpumask_var(&cpu_done_mask, GFP_KERNEL)) {
>                 pr_warn("no free memory\n");
> @@ -796,10 +796,8 @@ static void em_check_capacity_update(void)
>
>                 policy =3D cpufreq_cpu_get(cpu);
>                 if (!policy) {
> -                       pr_debug("Accessing cpu%d policy failed\n", cpu);

I'm still quite unsure why you want to stop printing this message.  It
is kind of useful to know which policies have had to be retried, while
printing the number of them really isn't particularly useful.  And
this is pr_debug(), so user selectable anyway.

So I'm inclined to retain the line above and drop the new pr_debug() below.

Please let me know if this is a problem.

> -                       schedule_delayed_work(&em_update_work,
> -                                             msecs_to_jiffies(1000));
> -                       break;
> +                       failed_cpus++;
> +                       continue;
>                 }
>                 cpufreq_cpu_put(policy);
>
> @@ -814,6 +812,11 @@ static void em_check_capacity_update(void)
>                 em_adjust_new_capacity(cpu, dev, pd);
>         }
>
> +       if (failed_cpus) {
> +               pr_debug("Accessing %d policies failed, retrying\n", fail=
ed_cpus);
> +               schedule_delayed_work(&em_update_work, msecs_to_jiffies(1=
000));
> +       }
> +
>         free_cpumask_var(cpu_done_mask);
>  }
>
> --

