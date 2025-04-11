Return-Path: <linux-pm+bounces-25278-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB515A8630F
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 18:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B0818C8004
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 16:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52834216392;
	Fri, 11 Apr 2025 16:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8wjrxW9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EBB78F45;
	Fri, 11 Apr 2025 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744388312; cv=none; b=aQIwMUFn0r6EDpuLmaz9O7EJWOI36OXn7rbVghWZWIUIheODrzU6eXiHHqcaZx7Yx/dDRIePhRmtVzb8POiMax8nhRtI7uM/de3cpy27Gz9HXyY6uqNQsgeuqw6UqVZ4DzDrMY/6v1mWfhRPCMbJvVC1ROfBnf6kGxf2/Q1fYJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744388312; c=relaxed/simple;
	bh=SvaNemzQY2y4UIJFFeYr/Yr4xA1TUx3BaNQgdVWLbjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpI7OQ/ZVrCBCGN0p73qlrA8zR262T6BqwAksmGE/IQk1cciEGq/7O7Nnqm25wtEfevnin2MwJpknNpuCelc0F/DxYL3c083kvJfEj1GoQqobE3HCWYxsYGi2pu3Xb6NR0NhAmG9cGmsOXjv0+pjmvfn/IRc5V8kQy5NOv5u3Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8wjrxW9; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736bfa487c3so2054402b3a.1;
        Fri, 11 Apr 2025 09:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744388309; x=1744993109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vmSMTuOGeDwYliAbWoaRYQt4Fshr4TF8P/B1kWAdHYw=;
        b=j8wjrxW9Rlmv9IqOyYsT/jJh96x+VW775Zbmsz51pQb3D5+8U/X5lAcDHh+05yQgp+
         8qnXy2x+7spTsdQ1pVmfhU0R2eYV2PS/+YXRbP0+VYgbnhCCBO8r2Hn4gCcbb3q41PPu
         aobseWYrSxX0UuLPcoMUePYWcqTNRqSy33Iy2prw+EBL04iA0vUOrXeEwSUggQ/JFUnr
         YdCq+5tf3HtxdzSPQkCOZNttKYwxjr1kpfEofQuXglt6LEhPluZuHWyQHdnBUT0Rocq/
         QstycKqL6FolKhUCgZjo8sWnXpYJ2jn4+PbDcbRqxJUCouln66Z0muObSUFc0H3OEGhs
         ipkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744388309; x=1744993109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmSMTuOGeDwYliAbWoaRYQt4Fshr4TF8P/B1kWAdHYw=;
        b=rqzo+ekbKnB+DMTWPyzwhBGf5pKZ45jOp6TCOYpiySjO4ziM10rXo70f64ZhtZLsdx
         p8SpQ84p8sVzwLVlS3RJtEC9Sarn2qhMFjn4WxWearpI6149bopOH8bTNpSbt0S8Is/R
         pl5W7yXrlyd+yljaBm5j27NUt2UHyoK/vQDPPLpeGVjzFVQGB8ujX2cLpXlhKSBJWUzI
         anduSp3/mq3JoALghbtGHmYgMaL7Wx12Ggb8S3hfYSwmv44MUnkE7HElNOnyrZJfk+34
         hMKX/5xSFT+boAMvHHJf2fzK2UlPP49V2PYxodHeiBcAaUulK+kWbzGCR7EsuhlsAHKA
         Z/XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHEfArRqpuy9Vmq+oG5/VivOuat2RxqYCT0Et1k1CtZ85sHcKR0HBYexRMbNgO/OXD3ps8OCx1S4nx2OMBOLo=@vger.kernel.org, AJvYcCVUZ7rxG3VmEwf1vpIQJFg5ljTnbSAiHcwuGEgphJ2+BQ07WhfYMQ3fXLwSKyYTISdI/kVNaPstuBM=@vger.kernel.org, AJvYcCW0CNHZ52fftd6o0z0xS+OisgBUTvtfGfMaidsgbLBwXaMCZCGAD+OGsGhsS9wZlJM1s6fDc6Cxb1rO7GTV@vger.kernel.org, AJvYcCW8lf5Ww/LBRpbAAqlmabB3gDFQfAAWc8N6x68peucCU6pg9Yj3GcVk7jj7aKGYf7lVSpZo4FpRaZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh711SXNoAP11ovE00VSHRC11qVD5ZGT1SPZMOkW0O8kdDOAfE
	lmVISr3ie2t5RCa0ne2CZY96s8NukrMf05D73SqknoMTxAhSO1CP
X-Gm-Gg: ASbGncslJWLhJejBYfUWBsVJ/AspFxh4NYd6tPmjevOzhRYjyFwtFfEX+rsFAc05fsj
	jQgZZb6kjl1Zjx1ZVyBkdlDL8p2QtFO7nTpWkCGHf0HFAktLRh3df/3azRptEffgpWXXqHfI27m
	5cxKa/l+ihkz9Y0QdTzg2NTl7ObS+XrS0ra72fNxFAeeBIk5xZgoSZulx15z8wca8XVNPPeB761
	fZWFVKTX/RW9oo24xBnWR+6elbMiQYDzrjA91uzCXXlxDvGvNoUX5E8KpT+zkbn8x1vHv8OyymF
	TNWOC0CgeB7j0xOij3ThCkweIx5hLXHT+W/n3qhy
X-Google-Smtp-Source: AGHT+IGw2fiNYM9934HOe7la8L3lAkwItX1sAP6xzLO1pfZrJGFJPsi7DJGl2RdlLlv1bN92Vx7M1A==
X-Received: by 2002:a05:6a00:179d:b0:736:51ab:7aed with SMTP id d2e1a72fcca58-73bd129b2aemr4602848b3a.16.1744388309457;
        Fri, 11 Apr 2025 09:18:29 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd22f10a8sm1787772b3a.101.2025.04.11.09.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 09:18:28 -0700 (PDT)
Date: Fri, 11 Apr 2025 12:18:26 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
	Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V9 09/17] rust: cpu: Add from_cpu()
Message-ID: <Z_lAyGy1o80MPVOC@yury>
References: <cover.1744366571.git.viresh.kumar@linaro.org>
 <475bc73d8d11290446a4135af76aea123c6d80ee.1744366571.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <475bc73d8d11290446a4135af76aea123c6d80ee.1744366571.git.viresh.kumar@linaro.org>

On Fri, Apr 11, 2025 at 04:25:08PM +0530, Viresh Kumar wrote:
> This implements cpu::from_cpu(), which returns a reference to
> Device for a CPU. The C struct is created at initialization time for
> CPUs and is never freed and so ARef isn't returned from this function.
> 
> The new helper will be used by Rust based cpufreq drivers.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  MAINTAINERS                     |  1 +
>  rust/bindings/bindings_helper.h |  1 +
>  rust/kernel/cpu.rs              | 31 +++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs              |  1 +
>  4 files changed, 34 insertions(+)
>  create mode 100644 rust/kernel/cpu.rs
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 12cde55579a0..475abf72869c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6155,6 +6155,7 @@ F:	include/linux/cpuhotplug.h
>  F:	include/linux/smpboot.h
>  F:	kernel/cpu.c
>  F:	kernel/smpboot.*
> +F:	rust/kernel/cpu.rs
>  
>  CPU IDLE TIME MANAGEMENT FRAMEWORK
>  M:	"Rafael J. Wysocki" <rafael@kernel.org>
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index f53d6e1a21f2..ac92c67d2c38 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -11,6 +11,7 @@
>  #include <linux/blk_types.h>
>  #include <linux/blkdev.h>
>  #include <linux/clk.h>
> +#include <linux/cpu.h>
>  #include <linux/cpumask.h>
>  #include <linux/cred.h>
>  #include <linux/device/faux.h>
> diff --git a/rust/kernel/cpu.rs b/rust/kernel/cpu.rs
> new file mode 100644
> index 000000000000..3054165d3818
> --- /dev/null
> +++ b/rust/kernel/cpu.rs
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Generic CPU definitions.
> +//!
> +//! C header: [`include/linux/cpu.h`](srctree/include/linux/cpu.h)
> +
> +use crate::{bindings, device::Device, error::Result, prelude::ENODEV};
> +
> +/// Creates a new instance of CPU's device.
> +///
> +/// # Safety
> +///
> +/// Reference counting is not implemented for the CPU device in the C code. When a CPU is
> +/// hot-unplugged, the corresponding CPU device is unregistered, but its associated memory
> +/// is not freed.
> +///
> +/// Callers must ensure that the CPU device is not used after it has been unregistered.
> +/// This can be achieved, for example, by registering a CPU hotplug notifier and removing
> +/// any references to the CPU device within the notifier's callback.
> +pub unsafe fn from_cpu(cpu: u32) -> Result<&'static Device> {
> +    // SAFETY: The pointer returned by `get_cpu_device()`, if not `NULL`, is a valid pointer to
> +    // a `struct device` and is never freed by the C code.
> +    let ptr = unsafe { bindings::get_cpu_device(cpu) };
> +    if ptr.is_null() {
> +        return Err(ENODEV);
> +    }
> +
> +    // SAFETY: The pointer returned by `get_cpu_device()`, if not `NULL`, is a valid pointer to
> +    // a `struct device` and is never freed by the C code.

If you think that writing the same thing twice would help in SAFETY
department, I'd recommend you to write it for a couple more times.

> +    Ok(unsafe { Device::as_ref(ptr) })
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index f4dcfefe94be..db372f806875 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -44,6 +44,7 @@
>  pub mod build_assert;
>  #[cfg(CONFIG_COMMON_CLK)]
>  pub mod clk;
> +pub mod cpu;
>  pub mod cpumask;
>  pub mod cred;
>  pub mod device;
> -- 
> 2.31.1.272.g89b43f80a514

