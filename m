Return-Path: <linux-pm+bounces-33298-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE59B3A287
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 16:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E990A4E17D3
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 14:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870BE3148D8;
	Thu, 28 Aug 2025 14:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rP00qeHW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCA4313537;
	Thu, 28 Aug 2025 14:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756392304; cv=none; b=RKjhEYI+iL4smJUlPHahzY4Ua1R57NdzyeOBGiTEnvMrZlV+pO8NmOeqEFO0YHUh8l0L8nXoFwxykbjruzl1syor5Zy9KsC36Kmht4Er13bmHl778/LHO8GaPe6617AruGbRtC7bky8LIQkcjmyc1naOEKOQZDLLlOLs9LQYcgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756392304; c=relaxed/simple;
	bh=murBVKwNkbj3OxhvxpjGbcrF1jvpcEi8l3hIDkiBkMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q/EDQFeBXzzOziRsFJoZNeXIeFL8rAQQax18KDjhfeeUnonmVd/MkWEEEr5GezDPdVcTGhLHrs9rI1B5Xwak6oV9GQyP3WnUAdK1q/2JZBKdS5L2tTkMAD6fqTuF+yK053o3sXnYMurtK7TMoQ+jXmHcxZvU+SkJORMHeJ3YLLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rP00qeHW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F59C4CEF5;
	Thu, 28 Aug 2025 14:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756392304;
	bh=murBVKwNkbj3OxhvxpjGbcrF1jvpcEi8l3hIDkiBkMo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rP00qeHWPaETLHua8B1CZp5EJIeprKF6/TNY33l9brBXvhMhp1vqBDRh4FqGtuhTr
	 mAW6yk0Q71fySzWHpEprY7EdeXvzzfVq3Xd0S7wiYBn554LzaLolEgVUZZcfmeuzjF
	 z4FtyAjXNPWibS70HufCjiYoEQSVuIDuHp67L8AYs7mMbsWJjHdalyAflrtiL/zjvt
	 A8FgO1kPwjLxqgaAeLHjPawOMUmEo7V4ZQWbzD1eIEacdaNJDRhoOinY7jAdGLeyxa
	 KQT/qdfbJoERsQMl/QN64E/YAYAdtri/vbyHOkxiAxYRjKZQq9z0qyRnyzr9TAFypf
	 1bFpgsPAACcmA==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-30cce872d9cso858341fac.1;
        Thu, 28 Aug 2025 07:45:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXE+TkwRP1KuXN2RQSdvBPvygwqv/QkpuBObFOVLHMNWvh2w7TXghk+Mo7GuUl8gkUZn2Ric5vSWHDUebQ=@vger.kernel.org, AJvYcCXJ9H6ujyK/v6kpohqEubWSK51QAhgC0UBzRkdL2IAWdYRlruk6kI/hswPAXivCM8bjvw2NAG7jQ9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyERz8N54hVf+K8mBJvJx4rVYxeeB/lg1C1C6gEEydu3PU1AQM
	EX2bCgrdrFTA3c2WIH80VkNXIRT+4XWvezhEGB6F2iJhTd4Fl5EVtWnA1eUOiI0cuiZSfff473Z
	RFQROqrdQ5E4VqPYm5386wEf9PGRLX5Q=
X-Google-Smtp-Source: AGHT+IFoSxsIkV9nsKLlGPnsgbWg0uETKzLMs80DDzgW59LqVvmqxhnBQnQycIj2b3bbE24V7xupMesaMKs9U3CUp1w=
X-Received: by 2002:a05:687c:4b:20b0:315:887d:b9c9 with SMTP id
 586e51a60fabf-315887dc333mr1926285fac.36.1756392303412; Thu, 28 Aug 2025
 07:45:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <724616a2-6374-4ba3-8ce3-ea9c45e2ae3b@arm.com>
In-Reply-To: <724616a2-6374-4ba3-8ce3-ea9c45e2ae3b@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 28 Aug 2025 16:44:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gGchbaQWRq39JbrX8chca7uefef763coJeup+vUOfyCw@mail.gmail.com>
X-Gm-Features: Ac12FXwfLLnKGwyU2KEFv6A3tBW982UPzLTeKS6gM-sDDA4-kHpW835CUsPeMEM
Message-ID: <CAJZ5v0gGchbaQWRq39JbrX8chca7uefef763coJeup+vUOfyCw@mail.gmail.com>
Subject: Re: [PATCH] Revert "intel_idle: Rescan "dead" SMT siblings during, initialization"
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 4:26=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> This reverts commit a430c11f401589a0f4f57fd398271a5d85142c7a.
>
> Calling arch_cpu_rescan_dead_smt_siblings() in intel_idle_init with
> boot parameter nosmt and maxcpus active hotplugged boot-offline CPUs
> in (and leave them online) which weren't supposed to be online.
>
> With the revert and nosmt and maxcpus=3D12 on a raptor lake:
> cpu     online  capacity
> cpu0    1       1009
> cpu1    0       -
> cpu2    1       1009
> cpu3    0       -
> cpu4    1       1009
> cpu5    0       -
> cpu6    1       1009
> cpu7    0       -
> cpu8    1       1024
> cpu9    0       -
> cpu10   1       1024
> cpu11   0       -
> cpu12   1       1009
> cpu13   0       -
> cpu14   1       1009
> cpu15   0       -
> cpu16   1       623
> cpu17   1       623
> cpu18   1       623
> cpu19   1       623
> cpu20   0       -
> cpu21   0       -
> cpu22   0       -
> cpu23   0       -
>
> Previously:
> cpu     online  capacity
> cpu0    1       1009
> cpu1    0       -
> cpu2    1       1009
> cpu3    0       -
> cpu4    1       1009
> cpu5    0       -
> cpu6    1       1009
> cpu7    0       -
> cpu8    1       1024
> cpu9    0       -
> cpu10   1       1024
> cpu11   0       -
> cpu12   1       1009
> cpu13   0       -
> cpu14   1       1009
> cpu15   0       -
> cpu16   1       623
> cpu17   1       623
> cpu18   1       623
> cpu19   1       623
> cpu20   1       623
> cpu21   1       623
> cpu22   1       623
> cpu23   1       623
>
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
> Rafael, I don't immediately see how to fix this properly so I won't
> try to, feel free to treat this as a bug report.

Sure, thanks for reporting this!

Well, I think that cpuhp_smt_enable() is missing a check.  It looks to
me like it should do the topology_is_primary_thread(cpu) check like
cpuhp_smt_disable().

I'll cut a test patch for this later.

>  drivers/idle/intel_idle.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 91a7b7e7c0c8..a9c58395a425 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -2507,8 +2507,6 @@ static int __init intel_idle_init(void)
>         pr_debug("Local APIC timer is reliable in %s\n",
>                  boot_cpu_has(X86_FEATURE_ARAT) ? "all C-states" : "C1");
>
> -       arch_cpu_rescan_dead_smt_siblings();
> -
>         return 0;
>
>  hp_setup_fail:
> --

