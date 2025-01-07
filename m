Return-Path: <linux-pm+bounces-20031-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B851A03E34
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 12:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC98316190D
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 11:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A0C1EB9F7;
	Tue,  7 Jan 2025 11:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FciL8czS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FD81E9B37;
	Tue,  7 Jan 2025 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736250480; cv=none; b=VgCjlQVm/6XXPfeOAZdXRj9RDcfgPREBXPB95zoTpz5Y2nrwnQrNAElaC6ygV8Tf/MCeGiLmE9JPBBjAH+HKCErmB8Zj8KJxA0eWIyt39VMCTZFh+cfpW+W26wRtN+gzrqWkndarpiE23ytzXj5c1RiROA7iEzvLlQDLI3S78l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736250480; c=relaxed/simple;
	bh=RpSc9H/LCGh/zgpse1dyvnbyIgHtTlgxPk2Ve4ypA4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1LqvYb0gNdIHWRySrs2wNue+2cqHI492ocVsLZU8y6mXdRlkCLssq67fau/UoWD4yAp3kJO+u9Z3dxzICkyvMfEUdj1qnBrYZDKPheLRIkRnm13UA/+SmEf2pyCZLq98AG5++/fg874IiULbjFU5p/v3lQgSGdLhzNtSm1BAio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FciL8czS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3214C4CED6;
	Tue,  7 Jan 2025 11:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736250479;
	bh=RpSc9H/LCGh/zgpse1dyvnbyIgHtTlgxPk2Ve4ypA4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FciL8czSVRkf/jdWSAG70NTUvasbva8g8YHAmUz2KOo8hmdi6kzEWqnypuN+az4Ef
	 u0v8rdqPupTX64khI7xM6wOZOuq+7MAfRI3jH7LWLSR9nZKVt4ETgYcwJfAcaho5sd
	 1uWasUaLFowvXMTCKsPfWnNcxPaZffmGP8ugySsmjPF4bJsPBI+Kut0F24ozOFE47q
	 //TZmXANIvypnh6+gA1ywmZQik4YF12OOf1pkovyp3UgKBy2nxMizdbBOgvNhdhiq6
	 WmFczNpYL2FBVrhKhRnZaHwRJHVF6HABwLXywBz5PSZqSheZbTIRDNvFPCIN8KFcV2
	 /HIb2RluTZ5Fw==
Date: Tue, 7 Jan 2025 12:47:51 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Benno Lossin <benno.lossin@proton.me>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, Trevor Gross <tmgross@umich.edu>,
	Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 00/15] Rust bindings for cpufreq and OPP core + sample
 driver
Message-ID: <Z30UZwgN2nGtiTsK@pollux>
References: <cover.1736248242.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1736248242.git.viresh.kumar@linaro.org>

Hi Viresh,

On Tue, Jan 07, 2025 at 04:51:33PM +0530, Viresh Kumar wrote:
> Miguel / Danilo,
> 
> I would like to get some of this (if not all) merged now into the rust/dev

You mean rust-dev or staging/dev?

> branch, since this stuff has been around for some time and many other
> dependencies are already merged new (like OF, platform, device/driver). Please
> suggest how can we move forward to get that done.

Now that the device / driver, PCI and platform code has been merged, rust-device
and rust-pci are obsolete. The only thing that's left that I keep merging into
staging/dev is the DRM abstractions from the drm-misc tree. So, maybe we may
just want to drop staging/dev?

- Danilo

> 
> -------------------------8<-------------------------
> 
> This patch series introduces initial Rust bindings for two subsystems: cpufreq
> and Operating Performance Points (OPP). The bindings cover most of the
> interfaces exposed by these subsystems.
> 
> Included in this series is a sample `cpufreq` driver, `rcpufreq-dt`, which is a
> duplicate of the existing `cpufreq-dt` driver. The `cpufreq-dt` driver is a
> generic, platform-agnostic, device-tree-based driver used on many ARM platforms.
> 
> Currently, the implementation has been tested using QEMU, verifying that
> frequency transitions, various configurations, and driver binding/unbinding
> functions as expected. However, performance measurements have not been
> conducted.
> 
> For those interested in trying these patches, along with a few dependencies,
> they can be found at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git rust/cpufreq-dt
> 
> The series includes all the patches to make it work:
> - few new APIs to cpufreq/OPP frameworks.
> - Avoiding using BIT() macro in cpufreq core (we need to make Rust work with
>   it).
> - Renaming of the cpufreq-dt platform device (this too needs to be fixed in
>   Rust).
> - Basic Rust bindings for clk and cpumask layers.
> 
> The work is based on `staging/dev` from the Rust tree, which is derived
> from v6.13-rc3.
> 
> V5->V6:
> - Rebase over latest rust/dev branch, which changed few interfaces that the
>   patches were using.
> - Included all other patches, which weren't included until now to focus only on
>   core APIs.
> - Other minor cleanups, additions.
> 
> V4->V5:
> - Rename Registration::register() as new().
> - Provide a new API: Registration::new_foreign_owned() and use it for
>   rcpufreq_dt driver.
> - Update MAINTAINERS file.
> 
> V3->V4:
> - Fix bugs with freeing of OPP structure. Dropped the Drop routine and fixed
>   reference counting.
> - Registration object of the cpufreq core is modified a bit to remove the
>   registered field, and few other cleanups.
> - Use Devres for instead of platform data.
> - Improve SAFETY comments.
> 
> V2->V3:
> - Rebased on latest rust-device changes, which removed `Data` and so few changes
>   were required to make it work.
> - use srctree links (Alice Ryhl).
> - Various changes the OPP creation APIs, new APIs: from_raw_opp() and
>   from_raw_opp_owned() (Alice Ryhl).
> - Inline as_raw() helpers (Alice Ryhl).
> - Add new interface (`OPP::Token`) for dynamically created OPPs.
> - Add Reviewed-by tag from Manos.
> - Modified/simplified cpufreq registration structure / method a bit.
> 
> V1->V2:
> - Create and use separate bindings for OF, clk, cpumask, etc (not included in
>   this patchset but pushed to the above branch). This helped removing direct
>   calls from the driver.
> - Fix wrong usage of Pinning + Vec.
> - Use Token for OPP Config.
> - Use Opaque, transparent and Aref for few structures.
> - Broken down into smaller patches to make it easy for reviewers.
> - Based over staging/rust-device.
> 
> Thanks.
> 
> Viresh Kumar (15):
>   PM / OPP: Expose refcounting helpers for the Rust implementation
>   cpufreq: Add cpufreq_table_len()
>   cpufreq: Rust implementation doesn't parse BIT() macro
>   rust: device: Add few helpers
>   rust: Add bindings for cpumask
>   rust: Add bare minimal bindings for clk framework
>   rust: Add initial bindings for OPP framework
>   rust: Extend OPP bindings for the OPP table
>   rust: Extend OPP bindings for the configuration options
>   rust: Add initial bindings for cpufreq framework
>   rust: Extend cpufreq bindings for policy and driver ops
>   rust: Extend cpufreq bindings for driver registration
>   rust: Extend OPP bindings with CPU frequency table
>   cpufreq: Add Rust based cpufreq-dt driver
>   DO-NOT_MERGE: cpufreq: Rename cpufreq-dt platdev
> 
>  MAINTAINERS                          |    2 +
>  drivers/cpufreq/Kconfig              |   12 +
>  drivers/cpufreq/Makefile             |    1 +
>  drivers/cpufreq/cpufreq-dt-platdev.c |    2 +-
>  drivers/cpufreq/rcpufreq_dt.rs       |  232 ++++++
>  drivers/opp/core.c                   |   17 +-
>  drivers/opp/opp.h                    |    1 -
>  include/linux/cpufreq.h              |   27 +-
>  include/linux/pm_opp.h               |    6 +
>  rust/bindings/bindings_helper.h      |    5 +
>  rust/helpers/cpufreq.c               |   16 +
>  rust/helpers/cpumask.c               |   35 +
>  rust/helpers/helpers.c               |    2 +
>  rust/kernel/clk.rs                   |   48 ++
>  rust/kernel/cpufreq.rs               | 1079 ++++++++++++++++++++++++++
>  rust/kernel/cpumask.rs               |   85 ++
>  rust/kernel/device.rs                |   21 +
>  rust/kernel/lib.rs                   |    6 +
>  rust/kernel/opp.rs                   |  886 +++++++++++++++++++++
>  19 files changed, 2468 insertions(+), 15 deletions(-)
>  create mode 100644 drivers/cpufreq/rcpufreq_dt.rs
>  create mode 100644 rust/helpers/cpufreq.c
>  create mode 100644 rust/helpers/cpumask.c
>  create mode 100644 rust/kernel/clk.rs
>  create mode 100644 rust/kernel/cpufreq.rs
>  create mode 100644 rust/kernel/cpumask.rs
>  create mode 100644 rust/kernel/opp.rs
> 
> -- 
> 2.31.1.272.g89b43f80a514
> 

