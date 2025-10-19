Return-Path: <linux-pm+bounces-36441-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E75BEED43
	for <lists+linux-pm@lfdr.de>; Sun, 19 Oct 2025 23:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79E364E5904
	for <lists+linux-pm@lfdr.de>; Sun, 19 Oct 2025 21:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A5022576E;
	Sun, 19 Oct 2025 21:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFVKCsLj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2097C19D074
	for <linux-pm@vger.kernel.org>; Sun, 19 Oct 2025 21:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760909145; cv=none; b=dz+UG+Jwzt2ixiyvckepKBhGnEVcv1x8wbV0VpiMp9e9eQSPoIpqNrSEIPxN7+fcRZ1H9j5izM8r1y2I0eP6CVC2WdErEVeoyV2LpP18KFGWFPrjaTt1QOS0mI3FXD7pdoVFQIu42LaqKEL+u4QDzOWMuHMHjWIn/aKmFW+zaB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760909145; c=relaxed/simple;
	bh=uA5vTOIALbcdwmrJpSZvDL4908AXryA4bzuPW04xPwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwqxMoI1DHHI8feCna2p4evKmq+nKBiZQUBCSLw6IiASzntB2HClHWUK4d0j2ml/dBNRR7yKMQnnHyXuEdIXcBOPtwW13eWGwplOiDEzncIT5GTTSZOZMPoB3gBFS7xc9HkMHqY7YnZkaWYmFzhFkLwtDuAD8Y9Yz7Jii6pkzLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFVKCsLj; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-269640c2d4bso6569715ad.2
        for <linux-pm@vger.kernel.org>; Sun, 19 Oct 2025 14:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760909143; x=1761513943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uA5vTOIALbcdwmrJpSZvDL4908AXryA4bzuPW04xPwI=;
        b=iFVKCsLjZ9ItLLugnc3NOyWgR6LdhMQj/lhUoAGx54ScPjkNeKQ2UAHsHjOHAamQ2/
         xDrS4i3MmZ7dAf4jogvQ02XjPPAkf7FBRZUEFrnlDrNc1OceGpdauhfN3WWMOffyFOsn
         cW1K4sWbbT3wXOvP2fMOi73RSK4EW28qGP3jA4JYKg2Iaa3pJSk4L/CktLp3YJW7Gf5G
         fiorgLY3lsDB+31e2mVDFbj582klczwsIdfO0ZH7AD/vCsTqeOB2KpwBHq+RgR1GDo6z
         ya5WTV98cFuVNieBV2HztSxbHvIKViXB7T0g3CN1L9Hn9vf3NGmZUNBGqagWjha9IEZc
         UrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760909143; x=1761513943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uA5vTOIALbcdwmrJpSZvDL4908AXryA4bzuPW04xPwI=;
        b=gu2GAlfv0vNWRdjSVNkwq6pJbhQTeZt4ikIhRxDwVsLShtNs+KcxGtoPzV282QELIJ
         g6IKCe/MTls0BBEvOQ4xwPmt0rsqtLuDXY7tirjEUM2j3U6/5R6mwrBmCCMLeBvp2BKJ
         ZPRKsypXJXVAHIJZRfjmGATT4HGIyLj3IKt2vBhnRjIRZGoGt8EzbDebDnhJWQbl2yVX
         0Te2kyY+WzzLXZDodupRJvEPWuD7TUNEDmpFwzuSB0Z/W8p1NcmhJubkBjaxAPJ46wtE
         F16yXt1oNbrZeR24jHCTEYd8AMdHVDbV5KL9KzYsOe6ksS+1N8GBR2rFNvm4ZDUq/DoN
         HAcA==
X-Forwarded-Encrypted: i=1; AJvYcCXFj/XbXDDMsYNo8Yodf4oqLLfcbwwvzC9RO6qGZFHhmYW11KvN/6SX4IidM/w7P6TaY7u2PiIsJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEJ7+mpV32Vx9+l3EoOFYshm1LdClCv0TSy9eix3v6336+9DU4
	8aZiB78bipKhB4Q20/UwwmLGRuBE7Ut0cpP2NzNEp+fu25npIIJ3vNHZfLlTPCO/KPuAbR0yE61
	AffxyrFVoqeSht+yH4SU/fiBOtnLRdL0=
X-Gm-Gg: ASbGncscSPOD7JhAiD5qlk3jhQx3yxxWG6jIE8AEkB/9WfQiDLlmkn8E2cNdzhX533/
	Cck5Y5BFcLVktYw49ODyNlO+sfXOkzORJ6rvHj+6barv+8HjFH11neXuEWniIHom5iarKmDjzSF
	QLQ9EY6750KzHzOwZxksxdJs4h990d+ze3Q3Wl+OLiuj1AMAJEeOWs8JouRQbKmfR0TVkz+EXF3
	TQBEW2Mmn/DBseKQ4jFvfoBuwsreJ391HlnoaocKvUu8LrjgxUD3KZwgyU25I7GUfDthu/trrM9
	Dq9W13utqAzMgO7tUnGGFUxNGBQOGtoO0MZgp/wlX38KxxcFWsQaEPpTOtcG2NAS7SBYGl98OxD
	audePfDqudU5Lqg==
X-Google-Smtp-Source: AGHT+IG+Xq8GXKfGoMwbFFQSVjc1IKmL7pMM4P5v7DRrKR2eAYMxLjwbrDpo8D26g74EqZuNpH1jVIwhs5ozgrDthtg=
X-Received: by 2002:a17:903:3d0f:b0:274:944f:9d84 with SMTP id
 d9443c01a7336-290ccaccc47mr70983905ad.11.1760909143546; Sun, 19 Oct 2025
 14:25:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018-cstr-core-v18-0-9378a54385f8@gmail.com> <20251018-cstr-core-v18-12-9378a54385f8@gmail.com>
In-Reply-To: <20251018-cstr-core-v18-12-9378a54385f8@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 19 Oct 2025 23:25:28 +0200
X-Gm-Features: AS18NWD0bEVrj3eqcMBbtrKdDrdonGG9WGD9YJjG46fNVzfrXtIBr4GqiIVIqEs
Message-ID: <CANiq72=c3Zs+mecvDVJ=cyeinzezhGz7yqC9r6FG=Q4HAdb98Q@mail.gmail.com>
Subject: Re: [RESEND PATCH v18 12/16] rust: configfs: use `CStr::as_char_ptr`
To: Tamir Duberstein <tamird@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fsdevel@vger.kernel.org, llvm@lists.linux.dev, 
	Tamir Duberstein <tamird@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 9:17=E2=80=AFPM Tamir Duberstein <tamird@kernel.org=
> wrote:
>
> From: Tamir Duberstein <tamird@gmail.com>
>
> Replace the use of `as_ptr` which works through `<CStr as
> Deref<Target=3D&[u8]>::deref()` in preparation for replacing
> `kernel::str::CStr` with `core::ffi::CStr` as the latter does not
> implement `Deref<Target=3D&[u8]>`.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Andreas et al.: I will apply this since it would be nice to try to get
the flag day patch in this series finally done -- please shout if you
have a problem with this.

An Acked-by would be very appreciated, thanks!

Cheers,
Miguel

