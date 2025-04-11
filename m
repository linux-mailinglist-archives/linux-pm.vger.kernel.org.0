Return-Path: <linux-pm+bounces-25282-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBFAA86339
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 18:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66A281BA5B65
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 16:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF18521C198;
	Fri, 11 Apr 2025 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9ovCvNh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2C521B9D5;
	Fri, 11 Apr 2025 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744389003; cv=none; b=eHy74sw6/v7oMZOS3Qk2tcmaKIvNh1xNNwU23ws8j03q/cN5nvGd//V5VBTK9NYlFFPnlNro0/DFQmvXXZGmq/ArzXKpwsYRyGqEJddx3xWqKaxw4ESznSRPp2OKurZg4N2iVqr0LV1b+83br0zVbwz6r2NuPba0VOM9SBOAZ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744389003; c=relaxed/simple;
	bh=e7ZwJA55c/npdtPDslO1iqSD1aHZ4rGTpX9tTTfC4YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDI9Cg4kZOS/TqcZCsG5F+3L0wxhDg3Q7VCy925b+gXYkqdyh190JVat6ysDNkpxSGc4eUwXueeAOS1+VDLO8UuqqSNXCiOipuokANnQ0zsXBGDclGf0tED9NyeS9l3HCONvgdWkhp5kfgt7VUJcp/9w/UCnByM77zGwpDYXhy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9ovCvNh; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223f4c06e9fso23013335ad.1;
        Fri, 11 Apr 2025 09:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744389001; x=1744993801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IMZKyOnvktAqQlS8qRlGyleKT7MiuM/55PSnX/QGDRA=;
        b=d9ovCvNhkmDJ0gPC8ORNfyXHqAbP42BZ7Uxc+BKc9lS0z9hap3fbVCjuqCr2JmO+mp
         FrfvlViA05wXbRkzXro/FH/S6SCRVKHAE6SvRRx7W7MSxKWL8sGrwrW2xvaLsMVDULs7
         K1QqkH5LVkLgUjPc+FMqRd4Vk34dU9OSOzXsPNEgR36QQNSd2u2VOXn0w7tmSnH528pR
         9Y+N4VvFwZ3oniaY7Y3koOXJZtUsS6kl5j0EiQKpIhfLfxW8KReStrWvNWy+8WpP6ae3
         nlOe7gaD39XoK9qM6QP0TcPV4H0nXdz1LW0Dw+lWy/No4Yw3xU114boYOSbgvncku7gH
         cgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744389001; x=1744993801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMZKyOnvktAqQlS8qRlGyleKT7MiuM/55PSnX/QGDRA=;
        b=iDyU9XbUmIfd6hZbRvaFKF0B54pUiUUJNRg+bv+Lywqq9sc/TPvTdBphGKRcbC0KRu
         Rvx1QyXcwZLRN0IUxhsoNt6QJE9lNrIIFZVASPaHSvb97f7zriQANgHUDE3dzTS4fBt+
         fJEY8WnIhcPEqJqRWI/3t6h5N0Xj+wzNNVA3zT1pUlhZh14ekEPzmb7M/8TOmGgX8FsD
         GQAGiifxIzk5F51a09g+EHubBfLDQCmaxFQ+aAUJTGO4BM/YIHiafM1bBVTPOHEhAaMD
         QMts7EDeLsCg+rNg6vLk4Tv4XCiNyb6UzhjHjdBPss1uSRVX+0lMBT3Dkq5rGKNpJmPa
         6FKQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/QxF8G2fUeMK69vvlC306bqtIwSWv8mz6xp5MkC4/HOw290l3mTBDXy/OKuFkoomJN3bHm2TnmH0=@vger.kernel.org, AJvYcCVK1rP1kTdkbGD+9//RkewKSDHH7lKAiVhlKDg7L8GpsbnBoWCGyveH0vETWVnUEn7bfLkJVoG+Jks=@vger.kernel.org, AJvYcCXJKMRFxL3io1Wgy5KLobKlNyD1fV91eTe0GHpywm2xgQLUwP0gkLGfEwYiLOMeA2XCTuTr6gAnB1/ZS60KRoM=@vger.kernel.org, AJvYcCXTAtKCbRY83bMMMGf9T9SA5Hithuq1U+8jn7aPSihSP4W2kzUhLWyQJ70KHypBfNjuccEPSVGMYs2iDaiQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzUkDEvH6K3hV+xUMmGBfkT2v+Jnn2n8O2Bfm8TLKFcRciY+gwT
	q66AU5c3q1JO7GVkFEWSlqhuiMOA2n4Yusmxg04BIlIW2L8c7WCY
X-Gm-Gg: ASbGncvb50a+g8n5Uje4xGsm+oGJt05EpFmwAgLVGLGLo43qyu+coFWRngWvSPv3PP9
	9sVFQ5zKjHUn6TSAhxKj9WhxfMS/Px0ynp7wYPvkfEHt1sklpZWyLipdcA8ZUopThAZkWSWfOZz
	cXCnngmwTg0lMIxulJouqb08Tmik19cJu/31JTMURv5DeGu9q6gMEGm9xcGuWHquCR6ImGM/aA8
	L0O6OnN4cCVrx4M3SZuZfX+jqR8OYbhFDUOtBQLZMnIz/56qatWH8nKUiDsM12bClDHy2vihc+r
	iupPGQv8oqd45MZnp5UeMyThoyYj5NLoTQ6nJRFr
X-Google-Smtp-Source: AGHT+IHYqKEouQcXgj1T3/DfjRBjlCbDtZJH1LHU2hA3j2xglmTTnB83Kz84DDxSmeWOxKuK+9g3tg==
X-Received: by 2002:a17:902:e745:b0:21f:2e:4e4e with SMTP id d9443c01a7336-22bea0252a3mr50679375ad.5.1744389001229;
        Fri, 11 Apr 2025 09:30:01 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac75ce2f8sm51929705ad.0.2025.04.11.09.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 09:30:00 -0700 (PDT)
Date: Fri, 11 Apr 2025 12:29:58 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
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
Subject: Re: [PATCH V9 11/17] rust: opp: Add abstractions for the OPP table
Message-ID: <Z_lDhj220aqU44P4@yury>
References: <cover.1744366571.git.viresh.kumar@linaro.org>
 <1961fd9a4ef44dbda18a63eb832dc3a3176c2314.1744366571.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1961fd9a4ef44dbda18a63eb832dc3a3176c2314.1744366571.git.viresh.kumar@linaro.org>

On Fri, Apr 11, 2025 at 04:25:10PM +0530, Viresh Kumar wrote:
> Introduce Rust abstractions for `struct opp_table`, enabling access to
> OPP tables from Rust.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  rust/kernel/opp.rs | 495 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 494 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
> index e4780b41664f..e074009e4b7a 100644
> --- a/rust/kernel/opp.rs
> +++ b/rust/kernel/opp.rs
> @@ -11,8 +11,9 @@
>  use crate::{
>      bindings,
>      clk::Hertz,
> +    cpumask::{Cpumask, CpumaskVar},
>      device::Device,
> -    error::{code::*, to_result, Result},
> +    error::{code::*, from_err_ptr, to_result, Error, Result},
>      ffi::c_ulong,
>      types::{ARef, AlwaysRefCounted, Opaque},
>  };
> @@ -172,6 +173,477 @@ fn freq(&self) -> Hertz {
>      }
>  }
>  
> +/// [`OPP`] search options.
> +///
> +/// ## Examples
> +///
> +/// Defines how to search for an [`OPP`] in a [`Table`] relative to a frequency.
> +///
> +/// ```
> +/// use kernel::clk::Hertz;
> +/// use kernel::error::Result;
> +/// use kernel::opp::{OPP, SearchType, Table};
> +/// use kernel::types::ARef;
> +///
> +/// fn find_opp(table: &Table, freq: Hertz) -> Result<ARef<OPP>> {
> +///     let opp = table.opp_from_freq(freq, Some(true), None, SearchType::Exact)?;
> +///
> +///     pr_info!("OPP frequency is: {:?}\n", opp.freq(None));
> +///     pr_info!("OPP voltage is: {:?}\n", opp.voltage());
> +///     pr_info!("OPP level is: {}\n", opp.level());
> +///     pr_info!("OPP power is: {:?}\n", opp.power());
> +///
> +///     Ok(opp)
> +/// }
> +/// ```
> +#[derive(Copy, Clone, Debug, Eq, PartialEq)]
> +pub enum SearchType {
> +    /// Match the exact frequency.
> +    Exact,
> +    /// Find the highest frequency less than or equal to the given value.
> +    Floor,
> +    /// Find the lowest frequency greater than or equal to the given value.
> +    Ceil,
> +}
> +
> +/// A reference-counted OPP table.
> +///
> +/// Rust abstraction for the C `struct opp_table`.
> +///
> +/// # Invariants
> +///
> +/// The pointer stored in `Self` is non-null and valid for the lifetime of the [`Table`].
> +///
> +/// Instances of this type are reference-counted.
> +///
> +/// ## Examples
> +///
> +/// The following example demonstrates how to get OPP [`Table`] for a [`Cpumask`] and set its
> +/// frequency.
> +///
> +/// ```
> +/// use kernel::clk::Hertz;
> +/// use kernel::cpumask::Cpumask;
> +/// use kernel::device::Device;
> +/// use kernel::error::Result;
> +/// use kernel::opp::Table;
> +/// use kernel::types::ARef;
> +///
> +/// fn get_table(dev: &ARef<Device>, mask: &mut Cpumask, freq: Hertz) -> Result<Table> {
> +///     let mut opp_table = Table::from_of_cpumask(dev, mask)?;
> +///
> +///     if opp_table.opp_count()? == 0 {
> +///         return Err(EINVAL);
> +///     }
> +///
> +///     pr_info!("Max transition latency is: {} ns\n", opp_table.max_transition_latency_ns());
> +///     pr_info!("Suspend frequency is: {:?}\n", opp_table.suspend_freq());
> +///
> +///     opp_table.set_rate(freq)?;
> +///     Ok(opp_table)
> +/// }
> +/// ```
> +pub struct Table {
> +    ptr: *mut bindings::opp_table,
> +    dev: ARef<Device>,
> +    em: bool,
> +    of: bool,
> +    cpumask_box: Option<CpumaskVar>,

The other fields have short names. Maybe just 'cpus' instead of
cpumask_box? If you want to put the type of variable into the name, it
should be a cpumask_var.

> +}

