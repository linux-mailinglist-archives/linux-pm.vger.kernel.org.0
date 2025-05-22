Return-Path: <linux-pm+bounces-27504-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E232AC09A7
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 12:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF91B4A522E
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 10:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BAB2356CF;
	Thu, 22 May 2025 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IH29CO3N"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A312914;
	Thu, 22 May 2025 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747909228; cv=none; b=sdyikdBpeBwKhvbsHWsR+l0UWCfPfJeVtq/N7Kd5G96kl/AGqOBLE6p84j1SN99QUDunyxzefP5OexTrgIZmEmBZxLqVNHM36eIBwxxxPMOV9dOdDJsmkFFWihK8gzRSvK8ApLvbhTRpb4Q8B5txJxFM2lAvVoaGWwxP/9YRwsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747909228; c=relaxed/simple;
	bh=uP5XtD0V69EicAgIlot7wFwDfbvfb+5YbEYAYzUUyio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ahJUbK0qsOpWLHlfob780G1OY8EnXjghSoa7ciO6dGwjliqsCRDUp7xCGbokrXUtGz1EvQxfIg2b5Sv+6FSvB6D7tu/CbhfGMDskiD6jf6vllJYZ6YMjZ3dP5rkaKGkEI5i9v4jUyw0hAkFecFA0NcWeVgSfTW2cC8ueh3Ivt5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IH29CO3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C3BC4CEF0;
	Thu, 22 May 2025 10:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747909228;
	bh=uP5XtD0V69EicAgIlot7wFwDfbvfb+5YbEYAYzUUyio=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IH29CO3N3bWb1BteBNLRYPoyAKm+zYOuiNhpKJwQI5Ektln9do8VAeeV+Mwu4rRNr
	 Zl1H5MFNFLTGqhEr0+T3d0Q3X8eimiEhMzJjHRAfPVPkNZe0ga51kIDPQshkvTEI3g
	 /zsEnILuJmEQLwb79U0WzaGIqCpYlomiSwET0ovBuuCnVWGbgoGzRo+hfCRlRW4kaO
	 1fQBQISeyiMXPSYj5xV+DT52T+Gk3BxrV4e8Dbk7Vo9OpOGWH4AwEDJBRuStcH5Snz
	 WvxVA7DgofLqYQfOA7BgWBG3dKCiLANJ2fcGw5xzTz8XXvzzeEXw5TuZf2/sPRLvN1
	 eR6rte8pBLPhQ==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6062e41916dso4459346eaf.1;
        Thu, 22 May 2025 03:20:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWU0cuMwiMM8lAV15cz93jL+ax3KJx0eP0d1+IviZ2SPrZ6AShP1H3cbYv/jtKS6Eo/jujtZ2bEbZcBBsUccxA=@vger.kernel.org, AJvYcCWcuPa4t8WKG+15GV6NNMqP9+Wm1Ub2ol9CJa734oXYrwWoxqqtsD1xTMIIomQf5JWhFtjrYPeAYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ9EyPf3tQWhdjNf54NNZcC/eafWnNPYIu2nZUoNUjoC03lTy3
	FoMrKBJVIqpFdR5pwawROG7X/6qh+FGD/k1lx9q7ZoKPMdvxfvdAvnA8vuKFCAdoVlt6mJakdqQ
	M1AzpQJSDAUML/mluPdvERPNcvaePTkU=
X-Google-Smtp-Source: AGHT+IH8IyKNBrSnzUSi0Gaks/5GRDrQrgrMjKu+uDnHk/7gqxRd4WJHDI4b4K20v7qdr2KYUwnNKnpXCLWOyw8Og58=
X-Received: by 2002:a05:6820:a09:b0:60a:bee:497a with SMTP id
 006d021491bc7-60a0bee49fcmr9176330eaf.2.1747909227345; Thu, 22 May 2025
 03:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520061944.pl3mqw2clo2roe3s@vireshk-i7>
In-Reply-To: <20250520061944.pl3mqw2clo2roe3s@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 May 2025 12:20:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gBRQ87bFk3-MCOudgvGWb29O_ihfz0Lo2kGcVpfSu=nQ@mail.gmail.com>
X-Gm-Features: AX0GCFs-uf9AeqqcjLAqgSIPAHFTS4cdSJluRCEWb1yLf4kC-3qYNKIL2zSZR7Q
Message-ID: <CAJZ5v0gBRQ87bFk3-MCOudgvGWb29O_ihfz0Lo2kGcVpfSu=nQ@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 6.16
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

On Tue, May 20, 2025 at 8:19=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Hi Rafael,
>
> This contains few patches from Danilo Krummrich as well, which will
> get merged via driver-core separately. Please push this to Linus once
> that is merged during rc1. Thanks.
>
> The following changes since commit a374f28700abd20e8a7d026f89aa26f7594459=
18:
>
>   cpufreq: fix compile-test defaults (2025-04-17 13:36:29 +0530)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufr=
eq-arm-updates-6.16
>
> for you to fetch changes up to 6c9bb86922728c7a4cceb99f131e00dd87514f20:
>
>   cpufreq: scmi: Skip SCMI devices that aren't used by the CPUs (2025-05-=
20 11:24:18 +0530)
>
> ----------------------------------------------------------------
> CPUFreq updates for 6.16
>
> - Rust abstractions for CPUFreq framework (Viresh Kumar).
>
> - Rust abstractions for OPP framework (Viresh Kumar).
>
> - Basic Rust abstractions for Clk and Cpumask frameworks (Viresh Kumar).
>
> - Minor cleanup to the SCMI cpufreq driver (Mike Tipton).
>
> ----------------------------------------------------------------
> Anisse Astier (1):
>       rust: macros: enable use of hyphens in module names
>
> Danilo Krummrich (8):
>       rust: device: implement impl_device_context_deref!
>       rust: device: implement impl_device_context_into_aref!
>       rust: device: implement device context for Device
>       rust: platform: preserve device context in AsRef
>       rust: pci: preserve device context in AsRef
>       rust: device: implement Bound device context
>       rust: pci: move iomap_region() to impl Device<Bound>
>       rust: devres: require a bound device
>
> Mike Tipton (1):
>       cpufreq: scmi: Skip SCMI devices that aren't used by the CPUs
>
> Viresh Kumar (16):
>       Merge commit 'eaff6b62d343' of pm/linux-next into commit 'f720efda2=
db5' of driver-core/driver-core-next
>       rust: cpumask: Add few more helpers
>       rust: cpumask: Add initial abstractions
>       MAINTAINERS: Add entry for Rust cpumask API
>       rust: clk: Add helpers for Rust code
>       rust: clk: Add initial abstractions
>       rust: cpu: Add from_cpu()
>       rust: opp: Add initial abstractions for OPP framework
>       rust: opp: Add abstractions for the OPP table
>       rust: opp: Add abstractions for the configuration options
>       rust: cpufreq: Add initial abstractions for cpufreq framework
>       rust: cpufreq: Extend abstractions for policy and driver ops
>       rust: cpufreq: Extend abstractions for driver registration
>       rust: opp: Extend OPP abstractions with cpufreq support
>       cpufreq: Add Rust-based cpufreq-dt driver
>       Merge branch 'rust/cpufreq-dt' into cpufreq/arm/linux-next
>
>  MAINTAINERS                     |   11 ++
>  drivers/cpufreq/Kconfig         |   12 ++
>  drivers/cpufreq/Makefile        |    1 +
>  drivers/cpufreq/amd-pstate.c    |    7 +-
>  drivers/cpufreq/cpufreq.c       |  345 +++++++++++++++++----------------=
------
>  drivers/cpufreq/intel_pstate.c  |   47 +++---
>  drivers/cpufreq/rcpufreq_dt.rs  |  226 ++++++++++++++++++++++++++
>  drivers/cpufreq/scmi-cpufreq.c  |   36 ++++-
>  include/linux/cpufreq.h         |   10 +-
>  rust/bindings/bindings_helper.h |    4 +
>  rust/helpers/clk.c              |   66 ++++++++
>  rust/helpers/cpufreq.c          |   10 ++
>  rust/helpers/cpumask.c          |   25 +++
>  rust/helpers/helpers.c          |    2 +
>  rust/kernel/clk.rs              |  334 +++++++++++++++++++++++++++++++++=
+++++
>  rust/kernel/cpu.rs              |   30 ++++
>  rust/kernel/cpufreq.rs          | 1321 +++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/cpumask.rs          |  330 +++++++++++++++++++++++++++++++++=
++++
>  rust/kernel/device.rs           |   90 ++++++++++-
>  rust/kernel/devres.rs           |   17 +-
>  rust/kernel/lib.rs              |    7 +
>  rust/kernel/opp.rs              | 1145 +++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++
>  rust/kernel/pci.rs              |   33 ++--
>  rust/kernel/platform.rs         |   32 +---
>  rust/macros/module.rs           |   20 ++-
>  25 files changed, 3861 insertions(+), 300 deletions(-)
>  create mode 100644 drivers/cpufreq/rcpufreq_dt.rs
>  create mode 100644 rust/helpers/clk.c
>  create mode 100644 rust/helpers/cpufreq.c
>  create mode 100644 rust/kernel/clk.rs
>  create mode 100644 rust/kernel/cpu.rs
>  create mode 100644 rust/kernel/cpufreq.rs
>  create mode 100644 rust/kernel/cpumask.rs
>  create mode 100644 rust/kernel/opp.rs
>
> --

Pulled and added to linux-pm.git/linux-next, thanks!

