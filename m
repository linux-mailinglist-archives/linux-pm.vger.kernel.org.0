Return-Path: <linux-pm+bounces-34722-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BA8B59226
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 11:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC63B1BC5EC5
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 09:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF802BE029;
	Tue, 16 Sep 2025 09:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9GWTVhI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F49A2BD033
	for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 09:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014754; cv=none; b=f28Q/iKDShRoI93j2fD8DqrGueB6cM6t0yhRwO8K1oMb76GXQcg1inqMv132G/t2hvb5gk+3X9O6IJvbAfyXIvc8Z8H/zeXHholMOQSDpik0TgOK2/yzS3INxUHN0UVPNYyHKXMgp1KDuvyrzDbNTVyAbyetSh/AmnYxtjq8vdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014754; c=relaxed/simple;
	bh=prkrcgQgpwPbi8Cfds13n7nM9MiR8JPZLk8prSDLM2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qVTySKlpxJWCibiffXE9T+nwaWvvb97aFh6e1pVj29jedGXlqYgta1i+ezzfnpsASCK/gvfFB7oQ7URahIA9av4mA20EvHJHom7BtwXpjZxvse2+umR0xLhAmu8r3DCOiwnfcbSUmTAsAlLhYMIEZc9iahFgGXSHykiZCowR1y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9GWTVhI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-267dbd4e189so557485ad.1
        for <linux-pm@vger.kernel.org>; Tue, 16 Sep 2025 02:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758014752; x=1758619552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prkrcgQgpwPbi8Cfds13n7nM9MiR8JPZLk8prSDLM2M=;
        b=Y9GWTVhIJtRrGpeL0bZclzvTItu83iRH38oBrb2EcNhXc3csSEaIHLjxntN6vPRekG
         U+fX+zMMyWvq4fU1tXc9j2glULsCsD3HDQtSdJDyCms7FAzij16kiCbq4ZFH4GfX1o2O
         60bm9gvWo1/H68oAAxP9Bh2C3rYz1lxFDBZZr5Llaxr51bh/syGn3RGUDU4Wubvi7ara
         /L0GnCtskb8YvQYVF0Cb8mRK/F3O+YZqvZLAJowHKwv2kqeo8uPRcyKtqEPj2z3PGkaP
         rt4IM+0Zu60Px0mIEQ9DMA72XYDEi5sZQhNM4KrzJelebhotOVNfMemzPC3+X9ehK8+e
         a/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758014752; x=1758619552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prkrcgQgpwPbi8Cfds13n7nM9MiR8JPZLk8prSDLM2M=;
        b=xE27OywyXXCPbJigT0f5LJYM8Teyl5H3PFDtI02m3oHYyAjLRQ9NrL4htZnNBl/79W
         ALBAqDw0DwQNG0RXI02IZ3/3MAb/Dz/dY1bwY6aQfsB/DvkZ9ujhKTfZloxMaHBzJO3V
         Wb2B4oLNeeL528Z08envwy1qeTffbx1l872hpiuwcoRqCq/SBCjmeWBzot2ExhVkpM9P
         AHmV8vhefO0YB3ltq01FtAwCiR/mH3Vza5lxMXQRvulHEErXFwYymwvLjpRw9aQO5TMm
         kxCEqxCXwIrkYUYWq2mON+FpeWgDyxo1mAC9xnr/PMsOPwq97K5mtMcB9+408SMihtL7
         AATw==
X-Forwarded-Encrypted: i=1; AJvYcCXPlJmHV+WJUtMujS6ZcpR0C807fyAR9v6nUuNhEeSmBqmUyz+XB8R1QZozrl/8BIMsyuNZBeBxrw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxL2vTTOT7rldduNb7QpheS+Ocy9Fmq5HleMBdrleomAr844LNt
	EI2UcDrfxm0zQcIL+uGp24OYkR0Z/msOYnrFSHqvIRif5dAGdOqAFlhfNBVQwGeQsbbLR/+eDXp
	u0sKWTbkoDGJ3/kI3OpD9FMXzRTBLxWM=
X-Gm-Gg: ASbGncslRGEXaLOnddg8r8jsDMaYwIxq2Vbc5v1CQvdOcpjMY8WegFS0zja+0nnfZ/H
	7ttPquSE7jtpeA5NeY2Qx42ZuQtC1cPtITBg09wYkl254himA88G6O8s+57dLho7OY+9dyHR/mS
	+SkTPKPJ2/12WGJYQk65xwqfVSOWrfpbmMFUIu2q8UJ2loP1pKAMi0izxDwAs8+Ivf7z4/fS5n4
	W40OujtvgeAYXOiAeKU71y64iuZtqSLIRIhQXS8QebIkrI47y+w55pYUmhbuOQZHy+IDK+weBi6
	5gMPhYcVKAFL/kNv6QqtGk++qQ==
X-Google-Smtp-Source: AGHT+IFwc6Y1OseNifdIO5J0qDFbM+aOcV8Z7xSmon/0tVZxaKw/+AP4a1wI7bqiW8muI5j5MuELqcXm9FvbGpAicyA=
X-Received: by 2002:a17:902:e5c8:b0:264:9287:3fc3 with SMTP id
 d9443c01a7336-2649287431dmr60170295ad.2.1758014751666; Tue, 16 Sep 2025
 02:25:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-core-cstr-fanout-1-v3-0-545c14bc44ff@gmail.com>
In-Reply-To: <20250813-core-cstr-fanout-1-v3-0-545c14bc44ff@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 16 Sep 2025 11:25:39 +0200
X-Gm-Features: AS18NWCYvwyg0oQ7WKMGNn77retnSNUsfiN0nCmq9Ts2BvgM8ip_kHMckevDcv8
Message-ID: <CANiq72kq4RWNO1pJtJuG8jBpARq5ft6pcn8dHuUWJx=nosweyQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] rust: use `core::ffi::CStr` method names
To: Tamir Duberstein <tamird@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Breno Leitao <leitao@debian.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Jocelyn Falempe <jfalempe@redhat.com>, Javier Martinez Canillas <javierm@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Len Brown <lenb@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 5:42=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> This is series 2b/5 of the migration to `core::ffi::CStr`[0].
> 20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com.
>
> This series depends on the prior series[0] and is intended to go through
> the rust tree to reduce the number of release cycles required to
> complete the work.
>
> Subsystem maintainers: I would appreciate your `Acked-by`s so that this
> can be taken through Miguel's tree (where the other series must go).
>
> [0] https://lore.kernel.org/all/20250704-core-cstr-prepare-v1-0-a91524037=
783@gmail.com/
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Applied to `rust-next` -- thanks everyone!

If any maintainer has a problem with this, please shout.

Cheers,
Miguel

