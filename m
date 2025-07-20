Return-Path: <linux-pm+bounces-31132-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D30B0B901
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 00:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9952B7AABAB
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 22:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557D921D3FB;
	Sun, 20 Jul 2025 22:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1pYXFQG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EFC22EF5;
	Sun, 20 Jul 2025 22:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753052287; cv=none; b=fHpDwJ7wIGwKTduMuNNlgNiUMIUuFXRm+Hjm29FH6xpRE+HQ8j6DelH1rok4aHq2U9DON0CJbD8DhUdtdvh3mj4n5BQrRIUFRM0VvO5AxIByBQtWiug7I5+PzK8tet2vFLBYHws1EO13OxPYP4joQ9B4hmrACQBMCemAiatY6BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753052287; c=relaxed/simple;
	bh=mKKU8++HW9VPMWOURJATnNdwIL2iZ4RG/zxehRvkol0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RK9CPmmU9aA7CWnySZARmRC2BsXIwFVWIXO0EcjMbUNOcsixsQfOd8F0AQimJnaZQgjj4m+Ghb1zkI3pcjhRaELzFezzXApMG9v/n0zyWU6MY/ASTWFYTdtfD8owahdavx1HOS/lnDlxlxs+T8p7FA9TymPDIUbiJzrq22wdcMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1pYXFQG; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-313756c602fso809026a91.3;
        Sun, 20 Jul 2025 15:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753052285; x=1753657085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=daKnTV4fSp02pGETIV5FEMpqyBsp4GEPOMMbZuGBz/g=;
        b=g1pYXFQGN89Famim9A1h3l+YZ+Ql/leJQe0iHKPkZZcVPjTJjvwe8EW9LrwaC88c2z
         e+GxSM/q7DsizfKF+8MMcd8gGIHH1Qv/Np7fULtmpZzpDIxF1SzZvvJnR8nOorIyQqIw
         evTIq/tZtMCtr2l4TBlcmq/xcsV6XsOeObtFnZpNcKwZl8pW6jn2HD766KCtCSN1ZNcn
         GnS/FEucm7sEVR7Xm4vCtJk9VN0G45bqls6jn7F2lCdk4C7UOJ0FkZxCZPx32h97TT9B
         JZ5V1JJC1kyHxPB/9km2dzNTOA5cw3XNB8ZcX3yTu8T0UcGYMwI/I5oiRIypWYK9Qpp6
         v+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753052285; x=1753657085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=daKnTV4fSp02pGETIV5FEMpqyBsp4GEPOMMbZuGBz/g=;
        b=E5EQc3XcI3HoLYnumlwkfq3px/j2DSDSH6QMSlyNCkcYfZdOFTX+1Yh+i23K+pEGed
         wIBJ0xub1jvoLHqbegWpMGo3iEp8vxT5a/BUcc5QJbrdLKYksWjTZH+XYEjR8Ayrr5VS
         JFB0KU6J5WKgiqJ8HtHoUxLX+YybRccicikKK2zar/m/al3kRQMbgPAZ8Ug1mQXHbLad
         EKIfLxWLwTUmgJeYb3tin7l4dtVZX2NXH6A0SxhhDDG4EpkW+br5GJk6P66Op1B3GaEi
         jydr1JpZGKegQcI3IqA/VPvOzBsUct3VqvkNb0d63BdPEqpN67cjDFvB1DuLzZiiBMqu
         CxtQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7hUlM714nyj1RnMS0fiuiwSSpQj20fpovUKe3rO+nw8utw6wEx0mrnPCsPlNYD89mUvNGclPdSjsaTs0=@vger.kernel.org, AJvYcCUCfPfk+tpn593cuosPUxGxstcN4xhiVEXbeFe6IigUDGEnr631DAV9vSK3H2dv9Gd9pxH5WbYgxHwh5rFaYAU=@vger.kernel.org, AJvYcCWfLDIW25NFTtLXWPHlFoM2mf27uC/YMH38Q1fAgX5TOm7lFCFLPCWP4iZkRPuXg/xEh6RbJdDbNno=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyyS1gutk6amztUHo62JKcUiRntB0sThw5x7JuDUaFFwL6XoXw
	cp9NrmywCatq8qvajoD45FszDylHT7y98arGBTxf1CkaYfqw2q5Y/52hTsRw+Rg0+Dp5JwMifvx
	7jkuQ+dR4QAgpzas0WqscG3vwOrUzy5A=
X-Gm-Gg: ASbGncvOVHshHq9vPgIa+6uiXr3rfUTvvxXKLcf5CjfwWbTvy4cJJ+ZWkpjIyh7p9lD
	llpwn+uUmv0I/smbIbobaKSrW6Y+8uC8Tc567F06l6PvLA6ciwq4yavPUWLZsdxCuC39KA9kgHb
	fQhbRVcOGpMKevds5KR81VPkfS1eehXWNm/fctWYqTJJ9f8KC8tIi/FjBtn1q5WiS6RlknQOh9I
	fGOcqJc
X-Google-Smtp-Source: AGHT+IFzjmvc0kMfKRG7U+xZ8wdQiM8shuAqXzIYwkhDrfmjAGRQWO9y1Uiy4Ste1/hFhJYypkZPHvTw/dT2WozP73o=
X-Received: by 2002:a17:90b:5307:b0:311:b0d3:851 with SMTP id
 98e67ed59e1d1-31c9e75ef14mr12278425a91.4.1753052285238; Sun, 20 Jul 2025
 15:58:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com>
In-Reply-To: <20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 21 Jul 2025 00:57:51 +0200
X-Gm-Features: Ac12FXxrHoi9ILUmBTRKm1OiT5BshvaFgsQVGJOA5I6_EA8yoKmhyCiVsD11rgg
Message-ID: <CANiq72mF8v7Gzr-dgfd68OPjJXDp=q+-asMiqcet0R0viqMbkw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Replace `kernel::str::CStr` with `core::ffi::CStr`
 (cycle 1)
To: Tamir Duberstein <tamird@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 10:16=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> As this is a large migration that touches many subsystems, it will take
> place in several cycles, each of which may see multiple series:

Let's start the long road, then...

Applied to `rust-next` -- thanks everyone!

    [ Reworded title. - Miguel ]

    [ Reworded title. - Miguel ]

Cheers,
Miguel

