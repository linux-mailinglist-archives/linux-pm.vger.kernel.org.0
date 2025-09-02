Return-Path: <linux-pm+bounces-33652-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 339F3B40871
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 17:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFDF01B25161
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 15:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677BB2EDD6B;
	Tue,  2 Sep 2025 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3uHXcYN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F11E1DE8B5;
	Tue,  2 Sep 2025 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756825516; cv=none; b=X05spgBEEZ8FUE+BgtGlbwHlk/0Fqw8vemX8B8kxyRwOsa4s0TXUKgtull2JJMHW0eKQB+UgIp56IUvlSqGcLnl9ZUVxbhy+mntBvFWqlkLPQAuHF0trqCu9t5J9jCWm74mrg0IjY/9MBF+46WslTcWVzVP7y/wMegPRJBdXvG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756825516; c=relaxed/simple;
	bh=atSYqlmoLPlLNDf3epkVZd1rTzeBqjTverCNmfZLeGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QyCwtbLya0O7Jk+0fBGlhkytDzA9Zb96Y9fHeBYgEtV3d9g+/KdjkgWMd39JLdjNTAIPTruUpZoG7KWM9OiT/BTgoWcw54ug6MmzIC/WCLZF+UWQwMWLi3vyZ+v9AZngkZLUUEklm41JSyQklq49TzeBq3zD0n+8bVIgwcpHhcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3uHXcYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6D0C4CEF6;
	Tue,  2 Sep 2025 15:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756825515;
	bh=atSYqlmoLPlLNDf3epkVZd1rTzeBqjTverCNmfZLeGs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h3uHXcYNkujwHkkJTM59eY5kXN54YJHASW0uFjVi4QHs4vDCTA4kw/+4d7GaRHVmk
	 v2n4QElhJRhdWRSoQvlxbTp7X5fhdOg02aMYKR72ueG8I1XQ/axLUnLOHO/DY182qW
	 C/mtZ8H6LXxRgKkt0dMFJxp104coN5PfVuxDZsrN+uVJiGdRG1hwfGi2/Qsj+9EEe9
	 AL2KfInAoGEjIgEebNBUG4kOxLd3469jzWlK6smYd3bjfSqVkdYyac0q+yVDlYFaDS
	 mGnnBh8+iROgu+cOJ0+ciQ3koLo2wldpaByEXpqnAOv3cWVbH7PI7l5889Ypy+TegK
	 6+fuTaVI1rLNQ==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-61e567a9a36so705338eaf.1;
        Tue, 02 Sep 2025 08:05:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVp5cH9qSyQf1OiI6DvsQLT12ma/qBcGDHeh6o82sbH8d56NlSDQzri9lebYLFoUQDD/lMqCmbYeQGIB/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGoXxkNwpVMogrrevKln8SlmcGVMiy7WXvIafVdmgR9gLMTYeW
	SIVV0UQO8TidZYKzktgUmN+faABD2Or7/pV7TyEoJYDPfdAbsrF779hfUbV7VTYj96VHSEidVS3
	Ufxn8Lr7ZMCwWfNu/k+OKkiOA2Mn+uos=
X-Google-Smtp-Source: AGHT+IGtZPMbOaSX50TXcf/i+iizuNb0+v8UkBVUTB3loRQMTb6yN3QxBxBgM5TldjBDZRVZ44aMCsQyUtpozF+4IT0=
X-Received: by 2002:a05:6820:61e:b0:61e:2ffb:e820 with SMTP id
 006d021491bc7-61e33791abamr5309568eaf.4.1756825515173; Tue, 02 Sep 2025
 08:05:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12740505.O9o76ZdvQC@rafael.j.wysocki>
In-Reply-To: <12740505.O9o76ZdvQC@rafael.j.wysocki>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 2 Sep 2025 17:05:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ik7fRKwH3CnXysvBJkkdJbWP-6iL=zBF0o92rR+nHTKg@mail.gmail.com>
X-Gm-Features: Ac12FXzlCMyK4YQXZK3S7XIH4PNuqEnTDw345WkizX9kUHCkddbd9zhSxUI85ng
Message-ID: <CAJZ5v0ik7fRKwH3CnXysvBJkkdJbWP-6iL=zBF0o92rR+nHTKg@mail.gmail.com>
Subject: Re: [PATCH v1] cpu: Add missing check to cpuhp_smt_enable()
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Christian Loehle <christian.loehle@arm.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 10:01=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Christian has reported that commit a430c11f4015 ("intel_idle: Rescan
> "dead" SMT siblings during initialization") broke the use case in
> which both nosmt and maxcpus were added to the kernel command line
> because it caused CPUs that were not SMT siblings to be brought
> online during the intel_idle driver initialization in violation of the
> maxcpus limit.
>
> The underlying reason for this is a missing topology_is_primary_thread()
> check in cpuhp_smt_enable() which causes that function to put online
> more CPUs than just the SMT siblings that it is supposed to handle.
>
> Add the missing check to address the issue.
>
> Fixes: a430c11f4015 ("intel_idle: Rescan "dead" SMT siblings during initi=
alization")
> Fixes: f694481b1d31 ("ACPI: processor: Rescan "dead" SMT siblings during =
initialization")
> Closes: https://lore.kernel.org/linux-pm/724616a2-6374-4ba3-8ce3-ea9c45e2=
ae3b@arm.com/
> Reported-by: Christian Loehle <christian.loehle@arm.com>
> Tested-by: Christian Loehle <christian.loehle@arm.com>
> Cc: 6.16+ <stable@vger.kernel.org> # 6.16+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I'm wondering if there are any objections or concerns.

Since this is a regression in 6.16, it would be good to get it fixed in 6.1=
7-rc.

> ---
>  kernel/cpu.c |    6 ++++++
>  1 file changed, 6 insertions(+)
>
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2710,6 +2710,12 @@
>         cpu_maps_update_begin();
>         cpu_smt_control =3D CPU_SMT_ENABLED;
>         for_each_present_cpu(cpu) {
> +               /*
> +                * Avoid accidentally onlining primary thread CPUs that h=
ave
> +                * been taken offline.
> +                */
> +               if (topology_is_primary_thread(cpu))
> +                       continue;
>                 /* Skip online CPUs and CPUs on offline nodes */
>                 if (cpu_online(cpu) || !node_online(cpu_to_node(cpu)))
>                         continue;
>
>
>
>

