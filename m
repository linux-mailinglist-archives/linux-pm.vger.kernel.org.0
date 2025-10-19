Return-Path: <linux-pm+bounces-36439-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7E2BEED2E
	for <lists+linux-pm@lfdr.de>; Sun, 19 Oct 2025 23:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17EE63B9505
	for <lists+linux-pm@lfdr.de>; Sun, 19 Oct 2025 21:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC7222B5AD;
	Sun, 19 Oct 2025 21:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFVHgf1e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7513715278E
	for <linux-pm@vger.kernel.org>; Sun, 19 Oct 2025 21:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760909133; cv=none; b=iNQa3vxOgmDSQ06Nz11kwSKQVuBwQV/N933Qr+6GBH5pT3Fql2RSw/tiY6MrghqCGEFIkiQ9wsN288/NU8qArJWpp7nyVpT3tl0r/7vqnLyA38NWn9DwDqpWjCXF/C5Eskbyl0axUgNMC+p4nUXx2LM9GMaIqcdBvQjV3h6sPpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760909133; c=relaxed/simple;
	bh=VMzOcGlzTmgP7Sx2K6Mr5nIuxpWb7Ycpm/3lBUKh9gU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTNI10i2hPJntbMYY3WaBBe44cJ6nNlA82xmKIuVNQUrHxRwpRlVMQTG0pSzQQDWkN40SFzxWENAUunq/FOTA/gmBlcoH2nfpH50h+Gj+AkVa9h++CUZZAiMVOU4tIukZ6Kpgu+3FGYbOP1fW7QRt2wfGYrFQKoqCSSkzrAVHBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFVHgf1e; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27eca7297a7so4667965ad.1
        for <linux-pm@vger.kernel.org>; Sun, 19 Oct 2025 14:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760909129; x=1761513929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMzOcGlzTmgP7Sx2K6Mr5nIuxpWb7Ycpm/3lBUKh9gU=;
        b=BFVHgf1eBxrRlVa4HQwtg+9JdGx+ckCck1jX46JQ5chJaRBSqsc6IKXoNvNltJhS5z
         SrqUVnX4pqzWiqNACvkDi1zVvk0GidVr9CkWudBq60rIZd3EAb5DXaA+0AHy7UMlu2IG
         fOjsqzm45BHLYsgMbYQvLre1c4z0LdXIonBIBz/gncQQg8glng0WpBLHu/TfVJFWVi2R
         N6nphsFpZ+PNw+cXdn0SfRcjuXCDssB1hHtfya3a4thXk9G7paDwq4vzO7Ul3foqBdju
         mPnqrYMM8J9oyfVNXdQhhChz/diK6X8qnWUsWRiaNkBcK76mIzKAYNBEDTup+TwJgR3A
         HOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760909129; x=1761513929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMzOcGlzTmgP7Sx2K6Mr5nIuxpWb7Ycpm/3lBUKh9gU=;
        b=ccC/OKuxu4aB6Q4ONPp4wP+3yjkC+sxlYMR/PVgo6VqIALPTQCDWyPrhSe+fUiOIeR
         o7TBlc6H+nSALDGzHcaqVWW67ulKhZHKvOcOSbg2D3bWTs/4E8dHzYA/bg9GQRwXPvel
         1eES8SmN4vBf1LC2ixIULflcB3vyNM9gtzz69zN0w4Y4ymlOymMnUBtps1Ii8Q+KlH9H
         4/+uB8qNV7MO63gbTuiAubeF34ydqsTQeI3gBQ0qVJSvUpJF7qrGE5d3xrfC/eHanjZp
         vL52oY9QAaJ+XVIS8Aijk7wHE8QLT/HWvloNzHJ0Jwm732WaHu2PKFVXq8alf+DiKCdV
         tNDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhU2j/3ZqRxOOJTM3IzgJ3xDX4ecaQix6LocoNswSG0vlpsWohSeGGwfh1XCYS7ZHrTOFoa+wbWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTqlkBTvNE4JtTHQZskMC8mmvNa3mPnmdOKtL87I+7HY/81M+r
	ogFhTr5MmEs6X+RWNcAfwpeo2yFvOc5zo3wxTa2Q60SAIfLv4PASKwF18WH9IVkXioMSrsWxYWy
	9DUUalIBCTxDCfKOuHLEjGFEZU27Gjuk=
X-Gm-Gg: ASbGncu0JfgT6oDPkHjBSYxtCv5XQifryuUZ4vNDjSVqr7/HVB3Mf9tHzVdksXMNLA1
	MoeuRHMGZuQsHFa2LLuGAI0bchA7/BSoX1rnSQ/15mY1AAJsT9bqF1pjINK2VQzfa1/8ltnStRp
	ZsgbUinU8QUdKvcNy9Y1g9FRk7ZrNtoq4AhY2SXapgp5uMcag+t35A1Hg6aiVuf0C8P+TknZQ85
	uYkqCbAexCSlYm0AP28wZrqam45jyjsV8Y3Tjr7qhLJtqMXs48gZkkrg89p1GcjtzevvgB54aRC
	DipZbNUho70hL/U6IpyrMXqprBYVjr7POCZXmmsukd2ijmjWFyVgoOuPr1n6Y0cYV9NspvZxZvC
	tA3zBMt1EgOzaww==
X-Google-Smtp-Source: AGHT+IFkXmb/qgb/KgY8CoxXBFCqji+DioDep8k1ccK80l52uLY2VJCsOrEx4mXqL5zBbM0jkYzLAt9Oa8qgqgiQULk=
X-Received: by 2002:a17:903:1a0b:b0:27e:eb9b:b80f with SMTP id
 d9443c01a7336-290c9c9a8a7mr71999045ad.2.1760909129461; Sun, 19 Oct 2025
 14:25:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018-cstr-core-v18-0-9378a54385f8@gmail.com> <20251018-cstr-core-v18-13-9378a54385f8@gmail.com>
In-Reply-To: <20251018-cstr-core-v18-13-9378a54385f8@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 19 Oct 2025 23:25:16 +0200
X-Gm-Features: AS18NWDXrZ8O-3KwwwBOxfZWPwAGhp3HE5GT4mOk-9o3K1qGCus24KCpGnZzuZA
Message-ID: <CANiq72mpmO2fyfHmkipYZmirRg-x90Hi3Ly+2mriuGX96bOuew@mail.gmail.com>
Subject: Re: [RESEND PATCH v18 13/16] rust: regulator: use `CStr::as_char_ptr`
To: Tamir Duberstein <tamird@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Michael Turquette <mturquette@baylibre.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
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

Liam, Mark: I will apply this since it would be nice to try to get the
flag day patch in this series finally done -- please shout if you have
a problem with this.

An Acked-by would be very appreciated, thanks!

Cheers,
Miguel

