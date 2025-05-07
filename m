Return-Path: <linux-pm+bounces-26842-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BBFAAEC95
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 22:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE67B504858
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 20:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC5A72639;
	Wed,  7 May 2025 20:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHTCXVdc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5505A4B1E50;
	Wed,  7 May 2025 20:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746648022; cv=none; b=FsEScA7caQeR2iaif7R2lI+/4vYotZfss/uMqqgm5R2dtvPqgxkUaDLXw31iZDgk8Knuy2Ihe2ZY2OVopHcLK97vLoYdNeEjBcpGHBGYhG4bPjS8yhSRsAMyjQI3tFXbxWhvB4/yM+nFntelMbYs4WhWq4egmDrAqmJjRxSQ+E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746648022; c=relaxed/simple;
	bh=tjav2Lry3CZ3llKxpBjEEIb2DCzNxNqCb8X2oXOpn2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LaOhJIkEC35Hclk53n1xv2b2Fco0VQEE5rWvSCmGwZhkR6+ELuGYvJNuGEbfokUx8RaTMxsiIL3ASvXIR+CFwSXarvc7sZU6Ni9DMnH06pghfuc1mRXzkUof84Uk0ZFgZiLaPg+0L5BAEuHeQz4xdrDaLDBGTgAT9tNq6ew1Nk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHTCXVdc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD381C4CEE7;
	Wed,  7 May 2025 20:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746648020;
	bh=tjav2Lry3CZ3llKxpBjEEIb2DCzNxNqCb8X2oXOpn2k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hHTCXVdcs7P4IJcz7KQygsNb2ijbcQWHLoTDMj02pcRaOxUGANPFyw04Fur0Ya+0e
	 XDjjWvmMQuPQuvqq5l5K3kDucp4F4kMJxVGuxMBFcwchoL6FT3MJ7DXf/s8p3ocA2V
	 d0zWSCSRRU7XqsIc8dZYtu1Hu8/6M4ZNhF3lX089uSFgYSGH34qNgm9lRl1MkNEqq+
	 v4xb3MAtbTAfngsrO5RQPPMJEArSkLj+s8yAf3YPYIKiVlrNYqGkLtJl7zSLIIlCfd
	 a0j0E/Qb39Lpj4weFkrZCnIDvyrLm2Mw2uX86xdUjItUElOfuQkIQcLiBmTftCrVt3
	 fOCZhIZZFyx3g==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2c76a1b574cso152870fac.2;
        Wed, 07 May 2025 13:00:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlr8IZ5EpbrKt+AEdMLE72g5p0LjquNnRWlKUmylPaKXGu+/EXJDYeWAq3QzHg0lT1XHWzeqYkwgU=@vger.kernel.org, AJvYcCVSe+Nuta9Ox9sQO7NeFJ9pWgztajI3ecuyK85xcD4fdImiLyDRMiKD5erq/+YA7JEpGffjWlyac9Q+zH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZJbx2TadsN7jHpzaPvtoMj5iJw0bflUIcuciUU6+EtSZSBXsD
	RWCYlCNIOsdc+WtsgB0Vt/2sdAmO1oNu/ty8SR0FEnsHyKvV0rag4szHzT5sZYvgPAAaRfynS8a
	40r2z/wkt1Vh0a0MY5yuyFegYShg=
X-Google-Smtp-Source: AGHT+IG5ntTjTMWQrdtV83l8Iscj3hSN3CVcasJJOW8huMIBAsneuAIyvv53WVJ7ELMSGRGA2f6HHg3dABvNve5Pbxg=
X-Received: by 2002:a05:6870:47a6:b0:29f:97af:a1a0 with SMTP id
 586e51a60fabf-2db5c07fc35mr2410065fac.24.1746648020011; Wed, 07 May 2025
 13:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250419025504.9760-1-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20250419025504.9760-1-ricardo.neri-calderon@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 May 2025 22:00:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jvtYyXoj71WF=0MLHZLt=zfMo5+C1v7xJ6CuCkowxNmg@mail.gmail.com>
X-Gm-Features: ATxdqUE_l-rxZ7CePiPNQL5CuDpYcHevrgJn0VzeGh0i7eLIf8QPqLTqcloG3PY
Message-ID: <CAJZ5v0jvtYyXoj71WF=0MLHZLt=zfMo5+C1v7xJ6CuCkowxNmg@mail.gmail.com>
Subject: Re: [PATCH 0/2] topology/sysfs, cpufreq/intel_pstate: Populate cpu_capacity
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 19, 2025 at 4:49=E2=80=AFAM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> Hi,
>
> Capacity-aware scheduling is now supported on Intel hybrid processors. It
> makes sense now to populate the interface /sys/devices/system/cpu/cpuN/
> cpu_capacity. User space entities can use this information to implement
> policy such as utilization clamps.
>
> This interface currently lives in arch_topology.c. Rather than implementi=
ng
> the interface again for x86, we can move it to a common location in
> topology.c from which other architectures can also benefit and populate
> using their own mechanisms.
>
> I tested this patchset on Intel Alder Lake and DragonBoard 845c. The
> interfaces are populated correctly.
>
> I'd appreciate any feedback!
>
> Thanks and BR,
> Ricardo
> Ricardo Neri (2):
>   arch_topology: Relocate cpu_scale to topology.[h|c]
>   cpufreq: intel_pstate: Populate the cpu_capacity sysfs entries
>
>  drivers/base/arch_topology.c   | 52 ----------------------------------
>  drivers/base/topology.c        | 52 ++++++++++++++++++++++++++++++++++
>  drivers/cpufreq/intel_pstate.c |  2 ++
>  include/linux/arch_topology.h  |  8 ------
>  include/linux/topology.h       |  9 ++++++
>  5 files changed, 63 insertions(+), 60 deletions(-)
>
> --

Both patches applied as 6.16 material, thanks!

