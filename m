Return-Path: <linux-pm+bounces-15391-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E839968B7
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 13:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7DA6281A6D
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 11:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C441917E7;
	Wed,  9 Oct 2024 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZSUDezJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FF3191489;
	Wed,  9 Oct 2024 11:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728473104; cv=none; b=RNDzG5ZA94ssV+PgZ0tTBfp42HPv7uPeDlmfgu3I1QpsjxvADnrIVp0oLRP8HFORu+QeTe5csmPqDZEUuDnKjwCwDSOnj9QoSCD137XkvidWOjbqh2m+ogcOEVwaH/woesPYFy3JaQERhOB2qQAdKfeYvy15caVOEwCPXjj7W0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728473104; c=relaxed/simple;
	bh=wdVK+v3QsEtuvtnCGTz3cveAy5vFTYupGy1jeTMyays=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JmEKga+J54OQYhwXW0sv3RHVFoerUSMW8HI2FxhWEATjjqw/Z38NL2XXwmQrj1C0iNt5fRLIyKEo7BCQ/AlulGdvIgk2UstSWBi4yn/uWnv4qdenh8comgetp0Gu9Ugra8OZOKCGc9tNHNqKp4x2kadESYw1+X4QKTU2YBBT4ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZSUDezJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FF0C4CED6;
	Wed,  9 Oct 2024 11:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728473103;
	bh=wdVK+v3QsEtuvtnCGTz3cveAy5vFTYupGy1jeTMyays=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NZSUDezJr2FNFo/5h9MKHZHW9EpDC5PTRl5QmmhfEUlHboopx1SfK8ijFoEim4CyS
	 ZSNzs+XUL506O/vthSP4UelQF23X80UeMY1C+aT/MoIw5Jn5Zm02elXH0/zxheFGIT
	 oMiTCz04oSw+ki+urg7LVIlejCcdOmosxEcNEXOQ6sLJbSnjJ2Tu/ojpHlBl6qCkrO
	 +MD1hOOT1LulLnpKgCbshuHySZez+AA7RtxZJ69bNhrojP1MDPKhhoKPMYt/DI5IvP
	 4rgRgPg0psnAbv/6cFWcJGm5fRd53IKc1qtPQbOQJiGNA8296n10/KKsaURa+Zk0dM
	 KFXsNM5m9BVyA==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5e7ffcd95c1so808207eaf.2;
        Wed, 09 Oct 2024 04:25:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6ynlh+XN+/p47Jb4fso9TdKk7NsKf/16iMeAR7yPFh0+bzdrFu3mWN1jYMqsfipVKvBsDheiqtf0=@vger.kernel.org, AJvYcCVuzWEB9P5Hu5+0uSYqNsHvbRlB8XhAUHTokvmtO47+zoHwxdA6LfZ4GJ8BExLos7DJCcqUKQzU@vger.kernel.org, AJvYcCWhw9HE2DjGBZmn1VC7rddPGMdC3yGe+iRcgf3At6Bb8LOobfQ9DtuKxZ/7gozYwC9YKIRM8ZfI48oq1iU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOL+dxND07bXc0ZalNi8gbzNYvW4f20SAeUjURSFR32NEQ/1Fy
	FxFeyzIEQfWNnD9r9i/9IbKVvUKrZd6gDqMkXxYNmzV90/s0kTKnxISz/rO9t+PcfJvOHp8uBUi
	rq+/2xevusdXcyyQeBJQmCf88n6M=
X-Google-Smtp-Source: AGHT+IH0r0T4Yr7HCO5EeAhxWkHvjmc/vhMxtPCtEhpbLjDxfuVyQYl4TBosMbKKV5BA0/S5YXTDNHg7rcUm2F11z9U=
X-Received: by 2002:a05:6820:1b8c:b0:5e5:76ac:11f with SMTP id
 006d021491bc7-5e987c062a6mr1195870eaf.5.1728473102707; Wed, 09 Oct 2024
 04:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009072001.509508-1-rui.zhang@intel.com>
In-Reply-To: <20241009072001.509508-1-rui.zhang@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Oct 2024 13:24:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hVhYhKbiNc_DAqbZqRNe=MAmS9QCiL4uAw-m-U19M=2A@mail.gmail.com>
Message-ID: <CAJZ5v0hVhYhKbiNc_DAqbZqRNe=MAmS9QCiL4uAw-m-U19M=2A@mail.gmail.com>
Subject: Re: [PATCH V2] x86/apic: Stop the TSC Deadline timer during lapic
 timer shutdown
To: Zhang Rui <rui.zhang@intel.com>, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, rafael.j.wysocki@intel.com, 
	linux-pm@vger.kernel.org, hpa@zytor.com, peterz@infradead.org, 
	thorsten.blum@toblux.com, yuntao.wang@linux.dev, tony.luck@intel.com, 
	len.brown@intel.com, srinivas.pandruvada@intel.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 9:20=E2=80=AFAM Zhang Rui <rui.zhang@intel.com> wrot=
e:
>
> This 12-year-old bug prevents some modern processors from achieving
> maximum power savings during suspend. For example, Lunar Lake systems
> gets 0% package C-states during suspend to idle and this causes energy
> star compliance tests to fail.
>
> According to Intel SDM, for the local APIC timer,
> 1. "The initial-count register is a read-write register. A write of 0 to
>    the initial-count register effectively stops the local APIC timer, in
>    both one-shot and periodic mode."
> 2. "In TSC deadline mode, writes to the initial-count register are
>    ignored; and current-count register always reads 0. Instead, timer
>    behavior is controlled using the IA32_TSC_DEADLINE MSR."
>    "In TSC-deadline mode, writing 0 to the IA32_TSC_DEADLINE MSR disarms
>    the local-APIC timer."
>
> Stop the TSC Deadline timer in lapic_timer_shutdown() by writing 0 to
> MSR_IA32_TSC_DEADLINE.
>
> Cc: stable@vger.kernel.org
> Fixes: 279f1461432c ("x86: apic: Use tsc deadline for oneshot when availa=
ble")
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

x86 folks, this is quite nasty, so please make it high-prio.

Alternatively, I can take it through the PM tree.

> ---
> Changes since V1
> - improve changelog
> ---
>  arch/x86/kernel/apic/apic.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index 6513c53c9459..d1006531729a 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -441,6 +441,10 @@ static int lapic_timer_shutdown(struct clock_event_d=
evice *evt)
>         v |=3D (APIC_LVT_MASKED | LOCAL_TIMER_VECTOR);
>         apic_write(APIC_LVTT, v);
>         apic_write(APIC_TMICT, 0);
> +
> +       if (boot_cpu_has(X86_FEATURE_TSC_DEADLINE_TIMER))
> +               wrmsrl(MSR_IA32_TSC_DEADLINE, 0);
> +
>         return 0;
>  }
>
> --
> 2.34.1
>
>

