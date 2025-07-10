Return-Path: <linux-pm+bounces-30588-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A55B00331
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 15:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DDA81C44F07
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jul 2025 13:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3B62253A7;
	Thu, 10 Jul 2025 13:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SO1ZSiUe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1329217993
	for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 13:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752153657; cv=none; b=SdXElDcwI9d91mzRQeO5Kh3F73Qx+rYAnsO3+1xTs2w0TF86VtKmHg8gOFdiCwDP7X5vtEbOcNcio5IrCpiXoEiM9eCMLg0ch6qxXfLzGS3VOU2ZXHCZ2GoQn3cs0EP53/rCDu7EsdNi8MUArrjOo1ZNaSWdeJoYi6HQ3nNRl7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752153657; c=relaxed/simple;
	bh=bj9Gfo/3Jr9EZIY9fK3lkcHewhYwv0doXs2kKiWDFPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CIVDDXsCaOPXi6Q70coc67YAT7Hq7ka57iKPLyfA4jE1sj5GP42OG0bFq5ztF9gaqabold8J9T8wmxv4I8p1OHG3xZlqj/L0zRQY8reW0Txv9LDI0kDr6SzQ2Nv4zMdiooPfd4Ac5IYFJSsldorw891vo/NG7GS08iqgudbgZ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SO1ZSiUe; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-453608ed113so10164555e9.0
        for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2025 06:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752153654; x=1752758454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/d3JWJXTPbcoiacIjfsqcFG5gW+YCew8k+ctgwhFlQI=;
        b=SO1ZSiUeXMtF9VJrlr6TVVAJueG/bcEFu6R61NrM5yK5eY/lFQBr4Xle8DLkpN1nTh
         icZso3d8rcwHB2PNDwby+uf6RS8Vgq+BGSESjX8j6NE+UCWMgAEEeCVfZSaDaU6bEOPx
         vn4zmaMNIl0Yd+Ff+RTrnNGUgF41EQ3SU8W0d4unGA0sKrnFsTrxQG1sVRV6SoExRwLp
         ooYVzniDtlSroGx4Y9NRMFYigkhOdIazMGOHuPGZl7dF+0+ch9GuLA8Ybd/MzdTnTkau
         rLfaDLY+/7rvuCNc/sNf3KFjteMucuqglpyomVg0JOLHwGaR/2OTB63Jhgb6rvWiwRai
         MU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752153654; x=1752758454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/d3JWJXTPbcoiacIjfsqcFG5gW+YCew8k+ctgwhFlQI=;
        b=RsABvKC4W2/x3QGBjtbC4webiWDP4RbUkXYfnQ8TV8ELhPpgoxrSinMUXg/fBkK7Mk
         DNHpni1Axd2QV4vUhGQyLd05zzRnR7BZTXshyXvJPnGi36PDqfXRvvkINRjII+FFxs0T
         Q/eMslY4TaETkTR4TVSdGN3sIuMErViO0+dUD2fnmAW1Jna21mgH/4PjUSeAf/6+b2Rh
         7qK5IrIWRI5p8wxBQAow6pcqJgrz4/5HK3nAvPkrwLLJTZHno0CV23+xFsys4wWH5+uS
         pMRSk7GZ4mowfy0lyVAzEcZCPIGmOxSVBz74+9H35TFeeySs2bZn/trs3+n60xrkM2E9
         1crQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfacWNHiSIMZ1OhfaBOCYampTw76lHaw13PZoAUiZioHJJGDH9G2vh8PdTvKXZx+RnsrbSxQG25Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjGtX0G1rkhylwdD6GiAz/n3blvjo3FGFUpTbzbMZkfi8MiRBI
	BxyLnQ2+dn9/rkEhZkQFzi2doqHMtwGyHGjNLm9xqL9W+K2r966fs8tD8aMMohb3deIVtwIbhYz
	toef9w/46ipyKAzDc2Ud+/2i/58arf4gqKBg9LTOR
X-Gm-Gg: ASbGncsYrJ0Jg15Y4kwqiqYGSdWBE+eQuc0VIQ2bO2qYj0idDjJdu4LgDcRxAmtHoUp
	ZRCKOwabfy3UCkxH+RV+tUgV//962b/K4XMVeKbDohpa6MpWzfj0BQT1OIW3MLGOHqPOVnwx1ym
	pTVOkTymqdjZ2XEMh1EJe7NZX8XKnnYDOqvgKZfkPKyBFx2aA8gknvczO9u+h6Jpqnl9cCgD2ZI
	Q==
X-Google-Smtp-Source: AGHT+IFujM42vH3V09euhJ0T7/vZlUGl5l2Mqd+XJHCpPSNb1kApqRjCh9Jtd3SgLVxJgkK09tgAyiBl1EsMOOSUJIA=
X-Received: by 2002:a05:6000:2806:b0:3b2:e07f:757 with SMTP id
 ffacd0b85a97d-3b5e788d3d0mr2685032f8f.1.1752153654256; Thu, 10 Jul 2025
 06:20:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com>
In-Reply-To: <20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 10 Jul 2025 15:20:41 +0200
X-Gm-Features: Ac12FXzitYxvRbQjbTDWexl7FT9vfcJPNeta0DSIvcawfTODepd7_rNw8p5wCA4
Message-ID: <CAH5fLggU_DsJ4-gj_xBeGgG8mS4CSrypNsmOqu6c677Lyyvqxw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Replace `kernel::str::CStr` with `core::ffi::CStr`
 (cycle 1)
To: Tamir Duberstein <tamird@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 10:16=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> This series makes preparations for the replacement of our custom `CStr`
> type with the analogous type available in `core`.
>
> As this is a large migration that touches many subsystems, it will take
> place in several cycles, each of which may see multiple series:
> 1. introduces facades in the kernel crate that downstream
>    code can reference. [this series]
> 2. migrate downstream code to kernel crate facades. (N series, divided
>    by subsystem).
> 3. replace kernel crate facades to allow `Display`ing foreign types
>    (such as `core::ffi::CStr`). Replace `CStr` with `core::ffi::CStr`.
> 4. migrate uses of `c_str!` to C-String literals. Replace references to
>    `kernel::str::CStr` with `kernel::ffi::CStr`. (N series, divided by
>    subsystem).
> 5. rename `c_str!` to discourage use. Remove `CStr` reexport from
>    `kernel/str.rs`.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> Tamir Duberstein (6):
>       rust: kernel: remove `fmt!`, fix clippy::uninlined-format-args
>       rust: kernel: add `fmt` module
>       rust: use `kernel::{fmt,prelude::fmt!}`
>       rust: str: remove unnecessary qualification
>       rust: add `CStr` methods matching `core::ffi::CStr`
>       rust: use `core::ffi::CStr` method names
>
>  drivers/cpufreq/rcpufreq_dt.rs    |  3 +-
>  drivers/gpu/nova-core/firmware.rs |  5 +-
>  rust/kernel/error.rs              |  8 ++--
>  rust/kernel/fmt.rs                |  7 +++
>  rust/kernel/lib.rs                |  1 +
>  rust/kernel/opp.rs                |  2 +-
>  rust/kernel/prelude.rs            |  2 +-
>  rust/kernel/print.rs              |  6 +--
>  rust/kernel/str.rs                | 97 ++++++++++++++++++++++++---------=
------
>  samples/rust/rust_print_main.rs   |  2 +-
>  10 files changed, 83 insertions(+), 50 deletions(-)
> ---
> base-commit: 769e324b66b0d92d04f315d0c45a0f72737c7494
> change-id: 20250704-core-cstr-prepare-9b9e6a7bd57e
>
> Best regards,
> --
> Tamir Duberstein <tamird@gmail.com>
>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

