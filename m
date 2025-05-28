Return-Path: <linux-pm+bounces-27726-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF8DAC6875
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 13:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774751BC0768
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 11:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C72527AC50;
	Wed, 28 May 2025 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RB9joLEF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726541E8854;
	Wed, 28 May 2025 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748432147; cv=none; b=fFjYizhzrx2N8fwUwM2+gX/d6nfX7J5N62o+AHGdCuNs+yNyQu5v+04lbT80e3BQouutRBT6+MOb8GGywrsQglYI+QGAn2BW7Ts3xP1n/NVVDveONI3A9prAaeaUmID07lGnJMvNpnQphAWdpBWHihi2fcT7thyENa38XLhyvOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748432147; c=relaxed/simple;
	bh=2lEqCZdr8xy4W4NYNBUeucB3WeNNwu4LSJR94oM86fI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJd9gLpgJ6TLsmHkIbjSP7zhoOq+X2ynn7TYYYRob/HlMRu+eJt7Mlskp0FyIe8uv+HuHNCrBOaxsdbEucDXOk95RZzJHTeIB5hZatK2hehvenQhL0CAgDk3Yflq8Rcd20xbEWwSxb7a0PheyQtX/PJjHYCt1kiOFfBEJQyUz/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RB9joLEF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460C5C4CEEB;
	Wed, 28 May 2025 11:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748432147;
	bh=2lEqCZdr8xy4W4NYNBUeucB3WeNNwu4LSJR94oM86fI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RB9joLEF6tAut9ZjZ/5tYcTmGfbIOF3qTaQxB0/9c/DKfoMsbNnE8vYkiHsZA5CwN
	 yIE+W1PVuM1oWjZ7PPwNbC8bRtvNWlmlyK6xDD+Zp3odt/Lr0EN2K45Vg3po8yED6+
	 b6WIKC5il75RfhC1Oyd2tQS5NxXfjaq7RSu4EG7uxsEd0TfBqUA84T0+mL80bTXmb5
	 aB7h0/jPwtW4eTJTpclRiwSx3obtwXPjZk/6E+JMdt/WXERHUgxicNK0qKPki5M7l/
	 STTfuXEU4vHqZ3nS08e4SrSopZPBz+8K41q5etodpHyJlfCNE1QL9hBeCHA7rcWOhN
	 OtbXf8pO+ycXw==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3fe83c8cbdbso1065214b6e.3;
        Wed, 28 May 2025 04:35:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAg57HxRbV5Znq/tT94Y+6yRIbghjFaRCqgWtR3r7eQr+F+4TZ0xr9TbvsRB1q/RJbA9Y/sGmaIAkqAPtBJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3E4J8AfK+2gvqjYAtvLMe/JQQ7tBMYi7fVwSSLDohO4iSevuR
	vWvSTEgMBGx1wEBTXeNEosvY+0BZOwymXm4WfUbKOe3XKP5tBF76hZE7pmZETImR83hvLZY6U8+
	MnWGxW0Lx/4Obb+XVOdG+igWp1gUJHYI=
X-Google-Smtp-Source: AGHT+IHeGft4ZhLUsfjL4ahtb4bPFGOTC7gQgr0DUvsn209gFaDaPQAsnzz0Fu+4vaV4SSC3SSEgjz+nJQMEOLX63Nk=
X-Received: by 2002:a05:6808:1c09:b0:402:ebf9:b774 with SMTP id
 5614622812f47-4064674456dmr8945066b6e.0.1748432146468; Wed, 28 May 2025
 04:35:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520061944.pl3mqw2clo2roe3s@vireshk-i7> <CAJZ5v0gBRQ87bFk3-MCOudgvGWb29O_ihfz0Lo2kGcVpfSu=nQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gBRQ87bFk3-MCOudgvGWb29O_ihfz0Lo2kGcVpfSu=nQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 28 May 2025 13:35:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iNwBhpmkwuo7Z_dGmLE5KQGONNRrt5kykXXKRoORTShA@mail.gmail.com>
X-Gm-Features: AX0GCFvziRYcxmTycnZ5vfAnVYe_x0N7HfdeogcoNWQHL9PxOKij-gZakvyQTWc
Message-ID: <CAJZ5v0iNwBhpmkwuo7Z_dGmLE5KQGONNRrt5kykXXKRoORTShA@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 6.16
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

On Thu, May 22, 2025 at 12:20=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Tue, May 20, 2025 at 8:19=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro=
.org> wrote:
> >
> > Hi Rafael,
> >
> > This contains few patches from Danilo Krummrich as well, which will
> > get merged via driver-core separately. Please push this to Linus once
> > that is merged during rc1. Thanks.
> >
> > The following changes since commit a374f28700abd20e8a7d026f89aa26f75944=
5918:
> >
> >   cpufreq: fix compile-test defaults (2025-04-17 13:36:29 +0530)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpu=
freq-arm-updates-6.16
> >
> > for you to fetch changes up to 6c9bb86922728c7a4cceb99f131e00dd87514f20=
:
> >
> >   cpufreq: scmi: Skip SCMI devices that aren't used by the CPUs (2025-0=
5-20 11:24:18 +0530)
> >
> > ----------------------------------------------------------------
> > CPUFreq updates for 6.16
> >
> > - Rust abstractions for CPUFreq framework (Viresh Kumar).
> >
> > - Rust abstractions for OPP framework (Viresh Kumar).
> >
> > - Basic Rust abstractions for Clk and Cpumask frameworks (Viresh Kumar)=
.
> >
> > - Minor cleanup to the SCMI cpufreq driver (Mike Tipton).
> >
> > ----------------------------------------------------------------
> > Anisse Astier (1):
> >       rust: macros: enable use of hyphens in module names
> >
> > Danilo Krummrich (8):
> >       rust: device: implement impl_device_context_deref!
> >       rust: device: implement impl_device_context_into_aref!
> >       rust: device: implement device context for Device
> >       rust: platform: preserve device context in AsRef
> >       rust: pci: preserve device context in AsRef
> >       rust: device: implement Bound device context
> >       rust: pci: move iomap_region() to impl Device<Bound>
> >       rust: devres: require a bound device
> >
> > Mike Tipton (1):
> >       cpufreq: scmi: Skip SCMI devices that aren't used by the CPUs
> >
> > Viresh Kumar (16):
> >       Merge commit 'eaff6b62d343' of pm/linux-next into commit 'f720efd=
a2db5' of driver-core/driver-core-next
> >       rust: cpumask: Add few more helpers
> >       rust: cpumask: Add initial abstractions
> >       MAINTAINERS: Add entry for Rust cpumask API
> >       rust: clk: Add helpers for Rust code
> >       rust: clk: Add initial abstractions
> >       rust: cpu: Add from_cpu()
> >       rust: opp: Add initial abstractions for OPP framework
> >       rust: opp: Add abstractions for the OPP table
> >       rust: opp: Add abstractions for the configuration options
> >       rust: cpufreq: Add initial abstractions for cpufreq framework
> >       rust: cpufreq: Extend abstractions for policy and driver ops
> >       rust: cpufreq: Extend abstractions for driver registration
> >       rust: opp: Extend OPP abstractions with cpufreq support
> >       cpufreq: Add Rust-based cpufreq-dt driver
> >       Merge branch 'rust/cpufreq-dt' into cpufreq/arm/linux-next
> >
> >  MAINTAINERS                     |   11 ++
> >  drivers/cpufreq/Kconfig         |   12 ++
> >  drivers/cpufreq/Makefile        |    1 +
> >  drivers/cpufreq/amd-pstate.c    |    7 +-
> >  drivers/cpufreq/cpufreq.c       |  345 +++++++++++++++++--------------=
--------
> >  drivers/cpufreq/intel_pstate.c  |   47 +++---
> >  drivers/cpufreq/rcpufreq_dt.rs  |  226 ++++++++++++++++++++++++++
> >  drivers/cpufreq/scmi-cpufreq.c  |   36 ++++-
> >  include/linux/cpufreq.h         |   10 +-
> >  rust/bindings/bindings_helper.h |    4 +
> >  rust/helpers/clk.c              |   66 ++++++++
> >  rust/helpers/cpufreq.c          |   10 ++
> >  rust/helpers/cpumask.c          |   25 +++
> >  rust/helpers/helpers.c          |    2 +
> >  rust/kernel/clk.rs              |  334 +++++++++++++++++++++++++++++++=
+++++++
> >  rust/kernel/cpu.rs              |   30 ++++
> >  rust/kernel/cpufreq.rs          | 1321 +++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++
> >  rust/kernel/cpumask.rs          |  330 +++++++++++++++++++++++++++++++=
++++++
> >  rust/kernel/device.rs           |   90 ++++++++++-
> >  rust/kernel/devres.rs           |   17 +-
> >  rust/kernel/lib.rs              |    7 +
> >  rust/kernel/opp.rs              | 1145 +++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++
> >  rust/kernel/pci.rs              |   33 ++--
> >  rust/kernel/platform.rs         |   32 +---
> >  rust/macros/module.rs           |   20 ++-
> >  25 files changed, 3861 insertions(+), 300 deletions(-)
> >  create mode 100644 drivers/cpufreq/rcpufreq_dt.rs
> >  create mode 100644 rust/helpers/clk.c
> >  create mode 100644 rust/helpers/cpufreq.c
> >  create mode 100644 rust/kernel/clk.rs
> >  create mode 100644 rust/kernel/cpu.rs
> >  create mode 100644 rust/kernel/cpufreq.rs
> >  create mode 100644 rust/kernel/cpumask.rs
> >  create mode 100644 rust/kernel/opp.rs
> >
> > --
>
> Pulled and added to linux-pm.git/linux-next, thanks!

Two merge conflicts between this material and the mainline have
emerged since v6.15.

I've resolved them (they appear to be straightforward to me), but I
would appreciate double checking the most recent pm-cpufreq merge into
linux-next:

https://web.git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/com=
mit/?h=3Dlinux-next&id=3D25eb7dda15f182b7355488a5aca47078643633dc

and letting me know if it looks good.

Thanks!

