Return-Path: <linux-pm+bounces-32450-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7C5B28541
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 19:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D26A47B96D6
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 17:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BE6317705;
	Fri, 15 Aug 2025 17:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIkb1UkP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A32A3176E0;
	Fri, 15 Aug 2025 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755279550; cv=none; b=jPt0vvkOUtvhCnMwTFGB4+OaUuV2cUcOhZM27G/0l05kW8q7Rs392RDvJViyf53t0U9LD99eQdl/Y2j9NN48cj3ldbz7Uor44uxKlmX3pfiE5iRES08ZA57sQpG4uFc428NHs+FFyUV1fyc+KgsOAL23Fy/Wb/IZGf6ax22BTz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755279550; c=relaxed/simple;
	bh=R51N8zUKg32JQLbS+KM21B8cVBHNR7q3s9zYeHBKcG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qL6V85gCnxBpUNF230dB9PYO1VAdcn7IpcIlXtDVqC1GY7ULA6UOkbSmuaXNNJGmBuE7fYAsF7MA6OX+ffjoYUi9fAW+p/fGz4RqzvTE8md8KFhQph6hxcAUluG/j5lUUSdb+FBLFep1C74oJ7e2C0gNxGBhZFlEKXWZdTFvOwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIkb1UkP; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-323266d2d9eso1814233a91.0;
        Fri, 15 Aug 2025 10:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755279548; x=1755884348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PN8XondeG8dcSjROGBlN7jlmi+uH5B8baziZKa1shBg=;
        b=SIkb1UkPqbTZfaLvnLVrazJav81SV8htTXDu6vLGYOWrf9QYDZGhPxF8BRemg7u3FB
         Qkq89QPXlPBXCbUoMgvE7NT95cGArMdI4Y0Zu2n5KLADl97ed8LwbNMPxPLMLZcY60Lz
         1cve2NxcxZXseX9KLnPP4SxF+t5i8tckKq4cxjUS+X60G7nyqhjLZTAjgjAqseicKnbl
         xomO6XQ75AfGi1gnEhBifDGt/TR4Dfto45tIbSfRMnUY0dWPaLQz2Ui3BRf1UJ+gLxlq
         6FqIOLDPkUPFOjHhButFA1vQhL5frv2iXWT1Qjgg/zQGJNi3LfbSAA//4Wceunx4PYJz
         5Irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755279548; x=1755884348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PN8XondeG8dcSjROGBlN7jlmi+uH5B8baziZKa1shBg=;
        b=wr81FCP/p9/vveXm/NrwbG6Bs9hHJBhaYkb0+bO/91dSkJlVk5SxEZWmctFy5CQkaO
         mUQEWVJkRcW47IIiqJdS62TOMnFIxcjIu4HrKJgokNv9iMBQjoWTvXa884LVTKCFziUH
         N5agQJgebTDl3IGSuquZluZ1hDu9Ly+KLqdiUTOMVtLdgHlQ0oKOfqv5sGRXHVIOEIHQ
         kjec/5JTdJQ5M1SY0QLOAu2ormpV7wN+/ivVfCxVZ+nCqMMoNuOmghjmRT+Nv7LToBoS
         Z/jNnVyXST2wmYcl5vIEzV83V9T8kJ1d1xgq+TWL96pWhCupmBLc/ZXIWZUHHbBNXHod
         b6MA==
X-Forwarded-Encrypted: i=1; AJvYcCUXN+zECy1FIxP0kTHhOZuE0y2NFw+cPypNMH14mqDzjdziRUpNsaC0E7yJDj92iRKuSOYk1PkDUEaENsQ=@vger.kernel.org, AJvYcCUa4khRlwZzaHXS10N2Isnx66sN252r8YPTJ27sdE8nEx8YGc8oMw2leBY2zucsooCyNadRuGAn2Fk=@vger.kernel.org, AJvYcCX2V0Z8kjey3Ddo2E+OnxEpXoWgtStziUkYtDqLecjNa7xeGBfJneNbrT5oKt4P8LzcvMFhCHClM6EYrkQja6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZTEZCzSXPjAzd9TX8kkkp81GbAmqxtm9guH0WSTOBFYW0wClU
	yxQb9RML1zCNYHfzEdI+dumcyDOxHaNPfPbUW1N+FasYEqyp+NfadWlL
X-Gm-Gg: ASbGncsJB2Si4sij2dmdHYygumOCVIalkiwKhB+POo3rcMDobCi5S7oZ15Mrnud6D94
	hUfEewys8CkhqZK8CZ4bS7V2pqfBseIIojiufXMELvcbfKDsxhpD9Z2AmmtWti9zKMcLFvp2iOm
	yw1x3MGl0+IbN8E/l4+R1F4RcABQTx3nP+8H6MxNEhClHYSWGhGJnK4ZmUGRWLOzyhZR334g5IV
	D/RE4mBaBdb25dm6ORtu9dRBz4JB7EoZ2zTxrgqakaFp609z0y0xWiV9GRygF4OuqLAOkIphO1/
	VMbOwiSR7c54ddMXyqO/k+0zSQABwEzi9Rr+yit3xXvhCAJUCjXALQgEKzhNL5ttMi66vtGpdbG
	ytscuvHx9asJixuIn4TYCm+6sfL282hOdI3P3
X-Google-Smtp-Source: AGHT+IHaBa4n45+MHAAyZGP1UZ9stWB2NhzExq+J1whhyj1txV3qmSSpR0wQKOLmPdA3oGagtFODRA==
X-Received: by 2002:a17:90b:3c51:b0:312:e9bd:5d37 with SMTP id 98e67ed59e1d1-3234db714a6mr1688a91.6.1755279547957;
        Fri, 15 Aug 2025 10:39:07 -0700 (PDT)
Received: from shankari-IdeaPad.. ([103.24.60.31])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-323311677e5sm4905882a91.26.2025.08.15.10.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 10:39:07 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: opp: update ARef and AlwaysRefCounted imports from sync::aref
Date: Fri, 15 Aug 2025 23:08:58 +0530
Message-Id: <20250815173858.1406967-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815173058.1398737-1-shankari.ak0208@gmail.com>
References: <20250815173058.1398737-1-shankari.ak0208@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Aug 15, 2025 at 11:00:58PM +0530, Shankari Anand wrote:
> Update call sites in drm to import ARef and
> AlwaysRefCounted from sync::aref instead of types.
> 
> This aligns with the ongoing effort to move ARef and
> AlwaysRefCounted to sync.
> 
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
> ---

I apologize for the mistake in the commit message, I'll fix and send a v2.

> It part of a subsystem-wise split series, as suggested in:
> https://lore.kernel.org/rust-for-linux/CANiq72=NSRMV_6UxXVgkebmWmbgN4i=sfRszr-G+x3W5A4DYOg@mail.gmail.com/T/#u
> This split series is intended to ease review and subsystem-level maintenance.
> 
> The original moving patch is here: (commit 07dad44aa9a93)
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=07dad44aa9a93b16af19e8609a10b241c352b440
> 
> Gradually the re-export from types.rs will be eliminated in the
> future cycle.
> ---
>  rust/kernel/opp.rs | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
> index 08126035d2c6..29be7d14025e 100644
> --- a/rust/kernel/opp.rs
> +++ b/rust/kernel/opp.rs
> @@ -16,7 +16,8 @@
>      ffi::c_ulong,
>      prelude::*,
>      str::CString,
> -    types::{ARef, AlwaysRefCounted, Opaque},
> +    sync::aref::{ARef, AlwaysRefCounted},
> +    types::Opaque,
>  };
>  
>  #[cfg(CONFIG_CPU_FREQ)]
> @@ -162,7 +163,7 @@ fn from(power: MicroWatt) -> Self {
>  /// use kernel::device::Device;
>  /// use kernel::error::Result;
>  /// use kernel::opp::{Data, MicroVolt, Token};
> -/// use kernel::types::ARef;
> +/// use kernel::sync::aref::ARef;
>  ///
>  /// fn create_opp(dev: &ARef<Device>, freq: Hertz, volt: MicroVolt, level: u32) -> Result<Token> {
>  ///     let data = Data::new(freq, volt, level, false);
> @@ -211,7 +212,7 @@ fn drop(&mut self) {
>  /// use kernel::device::Device;
>  /// use kernel::error::Result;
>  /// use kernel::opp::{Data, MicroVolt, Token};
> -/// use kernel::types::ARef;
> +/// use kernel::sync::aref::ARef;
>  ///
>  /// fn create_opp(dev: &ARef<Device>, freq: Hertz, volt: MicroVolt, level: u32) -> Result<Token> {
>  ///     let data = Data::new(freq, volt, level, false);
> @@ -262,7 +263,7 @@ fn freq(&self) -> Hertz {
>  /// use kernel::clk::Hertz;
>  /// use kernel::error::Result;
>  /// use kernel::opp::{OPP, SearchType, Table};
> -/// use kernel::types::ARef;
> +/// use kernel::sync::aref::ARef;
>  ///
>  /// fn find_opp(table: &Table, freq: Hertz) -> Result<ARef<OPP>> {
>  ///     let opp = table.opp_from_freq(freq, Some(true), None, SearchType::Exact)?;
> @@ -335,7 +336,7 @@ fn drop(&mut self) {
>  /// use kernel::error::Result;
>  /// use kernel::opp::{Config, ConfigOps, ConfigToken};
>  /// use kernel::str::CString;
> -/// use kernel::types::ARef;
> +/// use kernel::sync::aref::ARef;
>  /// use kernel::macros::vtable;
>  ///
>  /// #[derive(Default)]
> @@ -581,7 +582,7 @@ extern "C" fn config_regulators(
>  /// use kernel::device::Device;
>  /// use kernel::error::Result;
>  /// use kernel::opp::Table;
> -/// use kernel::types::ARef;
> +/// use kernel::sync::aref::ARef;
>  ///
>  /// fn get_table(dev: &ARef<Device>, mask: &mut Cpumask, freq: Hertz) -> Result<Table> {
>  ///     let mut opp_table = Table::from_of_cpumask(dev, mask)?;
> 
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585-- 
> 2.34.1
> 

