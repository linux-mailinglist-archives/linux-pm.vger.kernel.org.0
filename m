Return-Path: <linux-pm+bounces-11775-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A33294379D
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 23:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9F91C2151A
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 21:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF4B16A949;
	Wed, 31 Jul 2024 21:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNPbnXQM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE48E29CE1;
	Wed, 31 Jul 2024 21:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722460478; cv=none; b=FVZxwN0ZQLZxny1e5nBAgkePBpZEojH4/X8yu8kutUazsBijgCqUYamcugHkQQKQyCUmuZdw/Rfcnn7DWKCO5uB5mt4FHHb3TtScBSw/U2uuraY9kNmM4OtQIQO2VfFudcJ49LtiBjMnuP7JbQTdeWUw2lepmekZPKuwlVCuowI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722460478; c=relaxed/simple;
	bh=drW2XwUE9tnOaLha3mA16TTE9bFBONbbGvjMXVAhun8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BtJ9k3/+Nex+ZdTbEIpfpidGm5iU6cWi0QAgqBMU2G5Yt/c+iGZiBHol2BJpI8y4MHWlNHYb/qPQX76sqk5rfXCwoG9XzY0UU1Xs+fq7m9PuYew8qVRTthy3C3Osngnaib0pdrdpROWUl8D+bY1AWk8w9tNGkHStn/vv1GlSe0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNPbnXQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FF4C4AF15;
	Wed, 31 Jul 2024 21:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722460478;
	bh=drW2XwUE9tnOaLha3mA16TTE9bFBONbbGvjMXVAhun8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kNPbnXQMuxy0DCw2lFfWhsqOkQaJk1yoc2IiRzlf4Hyd93QdTa07sXt+WZFim0Waa
	 Gt/HOIhcYd3Ylgh6PtnGybsEmJelKjojnb0LOI7L0j3WDcuHTMIprNyG4x1XGNBL9H
	 P/+EkopzVa75ZHGNULZS32bzXZPXyy/wDssLp2RwFnfxQeRuD6aIwNm2aAiAmFHxDo
	 u8Eay9IixOgqiaiOrCL3AeNLzNMpPNRfNSCJ7/NXQ4ftENbN/60ALmcJJJVhPMEI0z
	 cqIRp0797yCM5JikO8LE1d830CuaNlBs02do7k2qGnlG+Ulut7k8lYGy5IPoE9+ljx
	 CunMffAkI1s+g==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f03df8c8cdso15161151fa.1;
        Wed, 31 Jul 2024 14:14:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWTcre8irLrcCt9TkmwwANrgjoisicJm5azutSlTDpP/iP5DWjziIS3TYhE57xezAcmniRpfynIG71QytRzNTsjEd6w93N4J8SShrTxgFNcqTsgpDbOiQZkB2qk/M7CkkuvXIo/PHygHlTd/i71r14QttWRDOODg+nnkyR7gAuKGdfC/i3iMw==
X-Gm-Message-State: AOJu0YzzV16okDbe8QZHJOPlUm4S3KfI/2HRnGLqHGMmr9zYYUmc4ce+
	yBoEBGQp4l/wnerjAlYwC/OC5HxGPjoL+6SFmmbVpx/3sJXCmQEnhSVoS+kKD3k89wYtJ6LHwVe
	qpj4/zcwU+SxXybyyC8eSG196gg==
X-Google-Smtp-Source: AGHT+IFntK5fQOseLmw3lZrspK+PJ5SM4yHiGo7j9UlEHCg0G4UuRfMu5Sw47w8P5Ii2dknaI8L+kdJM3fLX279ubIE=
X-Received: by 2002:a2e:a163:0:b0:2ee:8b28:96e3 with SMTP id
 38308e7fff4ca-2f1541a9c74mr1012671fa.23.1722460475876; Wed, 31 Jul 2024
 14:14:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1722334569.git.viresh.kumar@linaro.org> <e0df2db1caa49f15628aa18779b94899dcf37880.1722334569.git.viresh.kumar@linaro.org>
In-Reply-To: <e0df2db1caa49f15628aa18779b94899dcf37880.1722334569.git.viresh.kumar@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 31 Jul 2024 15:14:23 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+SxdPyb3qQyce7u8Ur=WCd1p+pQxJ+yJrTyS2xk3BF0w@mail.gmail.com>
Message-ID: <CAL_Jsq+SxdPyb3qQyce7u8Ur=WCd1p+pQxJ+yJrTyS2xk3BF0w@mail.gmail.com>
Subject: Re: [PATCH V5 8/8] cpufreq: Add Rust based cpufreq-dt driver
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, 
	Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org, 
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Erik Schilling <erik.schilling@linaro.org>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Joakim Bech <joakim.bech@linaro.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 4:27=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> This commit adds a Rust based cpufreq-dt driver, which covers most of
> the functionality of the existing C based driver. Only a handful of
> things are left, like fetching platform data from cpufreq-dt-platdev.c.
>
> This is tested with the help of QEMU for now and switching of
> frequencies work as expected.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/Kconfig        |  12 ++
>  drivers/cpufreq/Makefile       |   1 +
>  drivers/cpufreq/rcpufreq_dt.rs | 221 +++++++++++++++++++++++++++++++++
>  3 files changed, 234 insertions(+)
>  create mode 100644 drivers/cpufreq/rcpufreq_dt.rs
>
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 94e55c40970a..eb9359bd3c5c 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -217,6 +217,18 @@ config CPUFREQ_DT
>
>           If in doubt, say N.
>
> +config CPUFREQ_DT_RUST
> +       tristate "Rust based Generic DT based cpufreq driver"
> +       depends on HAVE_CLK && OF && RUST
> +       select CPUFREQ_DT_PLATDEV
> +       select PM_OPP
> +       help
> +         This adds a Rust based generic DT based cpufreq driver for freq=
uency
> +         management.  It supports both uniprocessor (UP) and symmetric
> +         multiprocessor (SMP) systems.
> +
> +         If in doubt, say N.
> +
>  config CPUFREQ_DT_PLATDEV
>         tristate "Generic DT based cpufreq platdev driver"
>         depends on OF
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 8d141c71b016..4981d908b803 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_CPU_FREQ_GOV_COMMON)             +=3D cpuf=
req_governor.o
>  obj-$(CONFIG_CPU_FREQ_GOV_ATTR_SET)    +=3D cpufreq_governor_attr_set.o
>
>  obj-$(CONFIG_CPUFREQ_DT)               +=3D cpufreq-dt.o
> +obj-$(CONFIG_CPUFREQ_DT_RUST)          +=3D rcpufreq_dt.o
>  obj-$(CONFIG_CPUFREQ_DT_PLATDEV)       +=3D cpufreq-dt-platdev.o
>
>  # Traces
> diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt=
.rs
> new file mode 100644
> index 000000000000..9204d92d3eec
> --- /dev/null
> +++ b/drivers/cpufreq/rcpufreq_dt.rs
> @@ -0,0 +1,221 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Rust based implementation of the cpufreq-dt driver.
> +
> +use core::format_args;
> +
> +use kernel::{
> +    b_str, c_str, clk, cpufreq, cpumask::Cpumask, define_of_id_table, de=
vice::Device,
> +    error::code::*, fmt, macros::vtable, module_platform_driver, of, opp=
, platform, prelude::*,
> +    str::CString, sync::Arc,
> +};
> +
> +// Finds exact supply name from the OF node.
> +fn find_supply_name_exact(np: &of::DeviceNode, name: &str) -> Option<CSt=
ring> {
> +    let name_cstr =3D CString::try_from_fmt(fmt!("{}-supply", name)).ok(=
)?;
> +
> +    np.find_property(&name_cstr).ok()?;

We don't want anything in Rust based on of_find_property() which this
is. That function assumes a device node and its properties are never
freed which is no longer a valid assumption (since OF_DYNAMIC and then
overlays). There's some work starting to address that, and my plan is
using of_find_property() on dynamic nodes will start warning. The
of_property_* API mostly avoids that issue (string types are an issue)
.

Also, it's probably the device property API we want to build Rust
bindings on top of rather than DT and ACPI. OTOH, the device property
API may be missing some features needed with OPP bindings.

Rob

