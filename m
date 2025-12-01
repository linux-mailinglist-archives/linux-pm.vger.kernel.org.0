Return-Path: <linux-pm+bounces-39022-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2106EC9985D
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 00:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7C188344ADD
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 23:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E769288502;
	Mon,  1 Dec 2025 23:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVxc9xua"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3B41C84C0
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 23:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764630400; cv=none; b=B5AQgUp3+m2+PR+TI/nJWcZoDa+KRdKFE5xQ2Nap6XyY0GLTqg8HP4nxG+eQuVfZkThC2Jj+WizDmHzQ4/Ymz4EBUdWGOivNWDhVczITGUcXfp3rdO2izKSW2jr0GG2ytMqbO5RJ2u9QrN/9GowkauUy6w1OC9J8K5LQ5nBI/P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764630400; c=relaxed/simple;
	bh=OMF5l7S3MDON+Bo+C3n6j/BgcNtrlF0sgYuH5OVBzBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m2oxaPEE7QLHqnXDdWn2yTevcLBaBejnrMCmUjL2HTzY0L8Y7M3MKXKl99Qspz5iCmAKVCMYoXMxu+A2Ximt34Fja3jil5AxhqaiYHpJAw6KqMLeXAIstYHAiQbNuIOlVtcsaXpuKRaH9qxZ7Ovl4aHwYo2glOYC3E1ySgJfXkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVxc9xua; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-297cf964774so7621125ad.2
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2025 15:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764630398; x=1765235198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMF5l7S3MDON+Bo+C3n6j/BgcNtrlF0sgYuH5OVBzBE=;
        b=PVxc9xua+Z6nyumnCiBtym91KqEFHJgcocp+NxyLwe1kMcANlhU0KJe0Y1jckp2r5L
         cFPQh1uPX4GPW7DXQc3SCkq3YM2nzQ9IosxC723TdhPloLrZdesj1A0ZYj7lDTEaFA/t
         5/UsXvhB9tkvkPZhMxjgMZwEr+NLJ3/XpYVtp/zlt1h1Kxb1qGbi7y7PVNXLZZuWY6q8
         XmO5t3eNYFWTnOhGxul7LccXxN8lYkp04NJO3UGZum+hPgfS7KS2RYpUw2Yv4P1FiGrr
         YXUW8gH/TEnAXlZU2XbJ/AEhdy3GE0QbyI8/SpvWtKqC3GYfuQ9G/hhKSww1bMw8818/
         w8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764630398; x=1765235198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OMF5l7S3MDON+Bo+C3n6j/BgcNtrlF0sgYuH5OVBzBE=;
        b=UQNz5a+8pTqeHvi31PqGaZJOmjbx7BV6K/t2z/RBjc8cgbBwFzTqxY2gGSip1Zd+Ya
         3D/MnavtnwG1urdoxbAFVHwTzRLvfD/HAYh35eEtN6z9sbWih4CzgppWtQRJHoJwn8US
         k7heyKhGW/jJNxDD9E6yT2mQQufgKeIseBf7qXu5gd4NBGUQ7URVdMkLpxmbbDLAn3Lz
         pWmgysQJklwp4cWAX2yTZZZrn6EDwWxo1gCL2vPuStrZC1AR1LhIIQMPQBRbIqf3ZHCe
         DFVlUHQD4q6bAyMjn15+6Zj4uZv1p/dsasFUqL1IPwI3VNIWTJ0vokiT762oK/y/SlGP
         s+Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUaQBuGy/49dG5v1OFvrNoMuYHlvEiSmjEQSOV+GyhElYGl0v6Mm3y43ag+IXo3vEutjJ5lS2FAag==@vger.kernel.org
X-Gm-Message-State: AOJu0YyU365aQkl8kDayBtBuHLadXUaHPzbZPin3yTgh5dIa7mh225Gx
	EQi/CMx77H7EubFE9TAUZKDBk+bLf5vD6yS3Tmha8l93rXd6jvSLgjVy/iwOnewNm+eJp+1nnmJ
	BofygZGZZ9w24lMhZimTCt28tkU7K4U4=
X-Gm-Gg: ASbGncvfcHVWXF9KDkn2dequdDyJ6JYkciHs4SzRUIbdj81Ybf84cMk8DhGyApEtFJz
	w1yuUN8a2D725N8Yd9uY2rndSsvv3pcp9VY/h00DPRrI/O9REQfknKcPH+fYVnxbu/bF6Xo2YNo
	kP0NcOdMY0keD8aHRhSk/bemQoL7HB9x7isil7lhdwZw8/GLWu33j8tfJc8Amn/r5XcIon1/VqP
	zVjM66qxSvBC6mhdypfDGVuw72c8vYu6oYwbahpg8WfWzyygfygBXtDjgvDnVciUtl+VHY3m4H9
	tmvPd1TAawRqkkzkdGRzV3NLljpcSjSbp9n6ObHkQ1tJjM4elV/Jpo2je32laLwbUdbxQq82KFy
	0HlbUDrfTQeOXEw==
X-Google-Smtp-Source: AGHT+IHgZ5GEJsO9WoLP6Z6Fh3KBUDDTwrz2Af9JYVEXFj34J5+7RHjFB7QeNqVNkB2lqkY2QyE/zTIrIUKGp3O3AbY=
X-Received: by 2002:a05:7300:ec16:b0:2a4:5129:fe99 with SMTP id
 5a478bee46e88-2a724bc5450mr24399676eec.2.1764630397828; Mon, 01 Dec 2025
 15:06:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com>
 <20251128-io-build-assert-v2-1-a9ea9ce7d45d@nvidia.com> <db6a6b28-c0be-4bd8-a0b4-70431df7737a@nvidia.com>
 <CANiq72nGUuK9VTYJGob7pnXU5zuuCzqfw6fezAFpbqvte1sDFg@mail.gmail.com>
 <46b5eef7-2e8d-4801-93d0-6cea10f62dc9@nvidia.com> <CANiq72mhXajwj7HjiW_HQq9nO4o-HwBFUya3wjT8pRkWx3xjZw@mail.gmail.com>
 <7d157605-4c59-4e04-8c41-1f7a4c86b34c@nvidia.com> <CANiq72n0UkuAtW=2JZK9Y7TK4VO8rKsMSvpv52BsW5+C2z9Dew@mail.gmail.com>
 <ea455598-fc0e-4768-b540-5091f7ccd025@nvidia.com> <CANiq72kAnY2035vc2vvXDpUV-_vM=0W2_-mBts846jHo1ri3Yw@mail.gmail.com>
 <fccc4878-a205-45cf-b651-53c151e48d25@nvidia.com>
In-Reply-To: <fccc4878-a205-45cf-b651-53c151e48d25@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 2 Dec 2025 00:06:25 +0100
X-Gm-Features: AWmQ_bm5mGKq7jyTKTNAST9qtSVF9nh8zt7Z5_rO8g8aiXjiIq_TKthUyj9O_fE
Message-ID: <CANiq72kKsJz=SCjsTiPk=C=KWdJ_h2=A7AZsdEz_u0iemvuzJQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] rust: build_assert: add instructions for use with
 function arguments
To: John Hubbard <jhubbard@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 8:31=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> w=
rote:
>
> Mainly just: is there a way to automatically "derive" (generate) an
> always-inline directive for any function that attempts to call
> build_assert!() on any of its arguments? And in fact, *force* the
> always-inline, if it is not forced hard enough today.
>
> Something along those lines.

"Wide-scoped" macros can do passes like that, i.e. like some projects
do to add extra syntax everywhere. Not sure we want to get into that
world, though.

Instead, if we are just talking about checking, then I think we could
have an attribute macro to mark such functions, and then
`build_assert!` could fail "by default" unless inside one of those,
and it would get rewritten into the proper form by the macro, so any
call without it would fail. It is always nice to mark special
functions anyway, just like our `export` one.

Otherwise, for more than just checking, I guess a custom tool like
Klint could also do it for us (I am sure Gary has ideas here).

> I will bring this up (along with the KSYM_NAME_LEN hashed symbol project)
> to our internal Rust groups. Both of these seem like nice, self-contained
> projects that someone could really get into.

That is great -- thanks!

On related news, Antoni (Cc'd) told me yesterday that he noticed
`inline(always)` was needed when using the GCC backend too, so this
series will help him too.

Cheers,
Miguel

