Return-Path: <linux-pm+bounces-31121-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFAAB0B855
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 23:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF25E1779B0
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 21:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFEB223DE7;
	Sun, 20 Jul 2025 21:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lu3ENT/z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C8C1CFBC;
	Sun, 20 Jul 2025 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753046710; cv=none; b=rwktMeSXLncFQV87y5oD1FJvIRJNOFaDmT4XU4xrhHLleVGGBJ+iAX+NCQURMb14aTMghWeKWqmmSpt6CoN5fqyCfMsXsWFOWJvw0fDRrdOml9xM0U3be7bxGsOb8GZW3VU6/+dakBtRSzcBGXnGNHgUv1e1p0rwN4bQ4OFr3PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753046710; c=relaxed/simple;
	bh=kcLVWK5A7Ad1B963CRRuSvmVMkaDENWXxk94YxyzoyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vjhh6RDHCvcI/aXRv/oTsrSY+BrPDqsZIGkWDi7Jzt4fZn6EAwlRy+gJZXhsThhHmoaszu9ppAWXSVBmAxfTObqL9YroqSh3qCBWXws++6Nxr9Bv+RsSLEClHDjMHw5WjyVd7x2iKmTb13Yqn5zzRSORs1R0eKVedz1mpqckXDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lu3ENT/z; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23c71b21f72so6939095ad.2;
        Sun, 20 Jul 2025 14:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753046708; x=1753651508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOfGo0Jsenpn6hZiffPRs915jB+hKQfehNQr85qBjhw=;
        b=Lu3ENT/zp6JFLxXDnSqArRKU+p6usdy7pvYTuZBItPWTOSyQ6kcyZAgywChtte2hBn
         YAF4QKRRg42JRgrZHLWTT/94iP7E2izAeo+gpk8nEc2K1GdHYdra/83EZqfYT5UlZz+4
         fiFTGj1xciPtl5xjexU7x7MAdhQflqQvzZSZoIMVB3UHesBzUtzfnHBHq6Wo33PZeOtQ
         mRLYzBa0r7HzFbnzXN/0rwrU4+wfx2pJcD3A2jK+kMblIauV2zS4zzpOzIui7a+/hk5L
         3kjyudPHHQ0qZMlDu0BeiPw8OkaKJ0/WCiaNDeM1NEEWLgs5w5r3W/1MmWFewcn/T0DB
         qMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753046708; x=1753651508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOfGo0Jsenpn6hZiffPRs915jB+hKQfehNQr85qBjhw=;
        b=Gs5omvXAS2sxn1WZHJWelVITtrkHF3QWdH+PgdCqbb2AvKv94d8fUEp2O6bDo7OZIS
         +9mVZ6h4CcBK/w8KF515T8Q1ee6utfmKcJvxbRc1z8QdofpyydX5xkC/r2DYZFwrJVr+
         Cz5O1HsL/53GHd8yMtiSDCTPgPXB0YMQDV+6+h5bW0gs3tBC056wXPwEA1MysLPG8V8b
         yXzNJ3bE33cQM+2A4uy1MQH+YvMl3jOURLOQItKWLX9aP8xmjmXdGiH2POBsp9yuXkHX
         SoYuF/5EMFFI2x+BhvfZZrvkasQoDIz4oKHFYK6WiU27BqEbyJbaYDlHC2j4lpCtPAzT
         SvEA==
X-Forwarded-Encrypted: i=1; AJvYcCVGxeODngY5wUELFWCZxB+xCkqb05FVt2TkdsX2AFYrmObsucgNW8q543H/1TgUDW91CXiNwv5JmRz/CIg=@vger.kernel.org, AJvYcCVHrCsCPPY8N+zW6ASfiFgUpz8RGpHzbV6oRQG15C2tbqsfZ+C5mI99WbHuvM2z4OvMu85rQbcuuVU=@vger.kernel.org, AJvYcCVIJjVOYKy+zxJjJKRCoNaMIaCp2MWRf51nIqzcVt6YJohjVTe+X5eATzX7WxaIoBaDWZ5VBaCrkQwBYAvzQwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6KyN08Oc2B38WBueDy5mod7rol14b4eiYseg1sB5DU25k+KMw
	HgpArd0zpvQg/GUqvsE+0JQDavkW+4HQIalwzs70bEcRPz40QrlPVfL3J1Mjonr5TP3GszyAtoM
	10NmH9/1gh5+tQssR23MYBbMoMozy+i4IbKz9Rls=
X-Gm-Gg: ASbGncuAk7Po+tTEXn+srCBEwPwEMMF5ah7tphwL1fGhCHkJDB7NG+opp/WOmTkY7pu
	5CF6rEieHkQKh3QDc2jcW/VwwKJvZgQvXhwYvEu4FZGiRWOhn1zR7nzg05rmNgq57Cn7P9KezNE
	CB0P0o1QNbXVOJO76G9FQt2BttN/s+96Muzbf0QApEXuVExHjc7Z2fraHJOmo3eFwWvJbqxrccB
	o+j9jEZNzDdrgzWX+U=
X-Google-Smtp-Source: AGHT+IEkcEPFJWVoqDC95ubnHjSmK+HgnV7Pk/LSgyHRbODBMgxYD03I2CuqEZBVSHRbSPTpfzdWXJRqkBiOadC0OLg=
X-Received: by 2002:a17:903:18d:b0:235:f1e4:3381 with SMTP id
 d9443c01a7336-23e24f33804mr97588565ad.8.1753046707493; Sun, 20 Jul 2025
 14:25:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com> <20250704-core-cstr-prepare-v1-1-a91524037783@gmail.com>
In-Reply-To: <20250704-core-cstr-prepare-v1-1-a91524037783@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 20 Jul 2025 23:24:54 +0200
X-Gm-Features: Ac12FXxNjw8Q4g3oEBeaU3nmS0KVSD6HWujMXOZAqRuJ_29r1bVUJEDsypVG_d0
Message-ID: <CANiq72mjiBK+DE-NOx1p+wWuZpnK=aPtgnMUUEzig+4jHZzemA@mail.gmail.com>
Subject: Re: [PATCH 1/6] rust: kernel: remove `fmt!`, fix clippy::uninlined-format-args
To: Tamir Duberstein <tamird@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 10:16=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
>  drivers/cpufreq/rcpufreq_dt.rs    |  3 +--
>  drivers/gpu/nova-core/firmware.rs |  5 +++--
>  rust/kernel/opp.rs                |  2 +-

Danilo, Viresh: I assume you are OK with this, but let me know
otherwise, thanks!

Cheers,
Miguel

