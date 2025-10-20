Return-Path: <linux-pm+bounces-36445-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D115CBEEE73
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 01:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 572BA3488C9
	for <lists+linux-pm@lfdr.de>; Sun, 19 Oct 2025 23:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE50262FDC;
	Sun, 19 Oct 2025 23:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fB6efVB/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D33D2580CF
	for <linux-pm@vger.kernel.org>; Sun, 19 Oct 2025 23:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760915060; cv=none; b=jGviDK/frK2ZLpuYcnrfPPRvSzvNUjs7Iq5oNzOHRIRbF9B27/X9DuuqTxWNoe0iWd1j2lG231GXEb7ekwOC+HYroPkuyire0vZ/KnS/peTWwTUbQ88tpRBgqsPnhDy4gyzRaTeI4N4wE+M7TRmIMdQWpS0feUeXYVmOrQBlahQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760915060; c=relaxed/simple;
	bh=AnqY+dCYnc8UF5OuQ+qs8apE1qzRi+JPuhlLZjOnIyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C6nv6eva36Inoyk0o+a+eHxkPevybfUM3a7jL/FKb83mJt4o40pZO87faXW0lD4c9fpeou4b3ItznE78ebQk0uLHsNGQYo/UVQ11wE5J7nVmQd9ZO3PRqe/QWT6IfAQiWlDBk4LAoz986oJSKn835UpADvZqndj1esN5yzzLn8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fB6efVB/; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-339a0b9ed6cso830291a91.3
        for <linux-pm@vger.kernel.org>; Sun, 19 Oct 2025 16:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760915058; x=1761519858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOEeh6O4RXrjCbdM/YQb/OmkajAlxiTKW4cEYv2MTfU=;
        b=fB6efVB/wMyoqtlHGiJA1Zoqf5c2xXR5EucDsSKcRvWwn3fOcOPtHd+2vcTfjHZuqH
         l21nJfMQ8BbDIRhG5GOgS+6Uh9hFcKzP103UOZTb8/i7g93CShsDLYBYALas67zYGQeR
         aF4O+RF95yyILPtpbP6fd0fjlbQOv7VEyEVB1KNYrGb60LAuvlFx1OF/RePoKrp/CFMg
         +fwpYyimAt56Ck2PP13t4pNKFaokYcFlrNPFfgW/9ZSffUNceWe6qVD/WlihyPlw1aip
         EDd/w3Twyez8kJqFJN1osB7vFoFlKrJZqrNm+uIdD2f/IfHogIdVPwt+1J7PwumjFyI1
         BNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760915058; x=1761519858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOEeh6O4RXrjCbdM/YQb/OmkajAlxiTKW4cEYv2MTfU=;
        b=UV231+sbjIz7XZGm2M6GLacKjhEb/NNqKsWz5bewEw3/4C2jn5exokKVL6LpzMgXZX
         2+cKoCJaWJt1F3rb7JZCB0ufE3i8/NdOGEZWK82TxGlCwINcTcBXj0arLz81lPxyoB8z
         83BDWokCzl5/Q+ko4mVJaKbjmvU+YUZepd2b62xdV5nRDGHdjQBv9Zh63xDT2Nv2c61j
         8nu3XDIgH1zx72xEkcorbDm6zKzpK7xvRLpekreUj+IWx1LBQc00bOlUQpi+MHlXtlim
         EVvP8vzBCQD4MYqN+9T24WGGZ7lB5OTtJXIqFVMjKtgGsiZXz9fncojcr3Ma4vmODsfB
         ENpQ==
X-Forwarded-Encrypted: i=1; AJvYcCULTRNIjxalJHPnk66Lm5WoCL7FXp9nORwXWd0MXyxeWqEMfVhQXFhYJ6g8yU1KWA0I+U0NnqWQbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlE/+ZuKWmu36FI1pYkxCfhgE8D5t1k8g7ZNphdI0cOAoMq/UY
	PDl6YbZT3FKqjCmnJ0G+RFiph7o4c9qrFAKQZkiPCFCFXgmKGgwRet4+YtBGhsVpRgyAwMtqiMy
	urAWUcL1/a8bZdEaYm1KDHiPV/zyraIg=
X-Gm-Gg: ASbGncvhvBKFkkq3+9uehl1fGNiMZgHAocZuLT0ZtLqQN/mNxN1LVk1u6fh8a4/0sJN
	Hyi/3hpM8sBw9AMpcwcQNbpX7Nq0RrDf453cwktexITr1bh5MYjMrxdm+86zmalnbSSKOjI0ZRT
	LuzVHJOYIueocAjJ+Ld4V6X44iPoER9Vpx5a/V5aR2zApYJeQ9nwvDf+t5ARTnQnRLV37Ru13Lo
	fLKtbjJmFvo7wQAAjUSx9Yg4ti7wu388EkN5Dlroi/8XsKLejp8+POtwc1ksJL6NxlN5/37A2GY
	Vgejr0cdrNQvqAjfHqOIXBc365Yt3pJFPhIYOC+rik2QDZ06inuLzcAkEYk2LeQkxeuy+A/SjFD
	EetCbVyfwwlZOMQ==
X-Google-Smtp-Source: AGHT+IEHoe7IdB8Fn4blPj1kZr2k1PDvwkLeFqEjMadUT99xbKyU7kwS9dgklhgQJkFrx7iKJ+XmLkdzgYdk7hZ0y1w=
X-Received: by 2002:a17:903:b8b:b0:290:c5c5:57eb with SMTP id
 d9443c01a7336-290c9d2dd08mr74335675ad.3.1760915057866; Sun, 19 Oct 2025
 16:04:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018-cstr-core-v18-0-9378a54385f8@gmail.com>
In-Reply-To: <20251018-cstr-core-v18-0-9378a54385f8@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 20 Oct 2025 01:04:05 +0200
X-Gm-Features: AS18NWBk6jlJf0RifcBoOPS6BkMb0c8T8AQmrZIWVCq_Mep36ZL7bfRUqV3fx64
Message-ID: <CANiq72moW2VULd6EMQe9X4d1S+ftOG4Mcpp2_+V6zG7xVXj+qg@mail.gmail.com>
Subject: Re: [RESEND PATCH v18 00/16] rust: replace kernel::str::CStr w/ core::ffi::CStr
To: Tamir Duberstein <tamird@kernel.org>
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
	Tamir Duberstein <tamird@gmail.com>, Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 9:16=E2=80=AFPM Tamir Duberstein <tamird@kernel.org=
> wrote:
>
> This picks up from Michal Rostecki's work[0]. Per Michal's guidance I
> have omitted Co-authored tags, as the end result is quite different.
>
> This series is intended to be taken through rust-next. The final patch
> in the series requires some other subsystems' `Acked-by`s:
> - drivers/android/binder/stats.rs: rust_binder. Alice, could you take a
>   look?
> - rust/kernel/device.rs: driver-core. Already acked by gregkh.
> - rust/kernel/firmware.rs: driver-core. Danilo, could you take a look?
> - rust/kernel/seq_file.rs: vfs. Christian, could you take a look?
> - rust/kernel/sync/*: locking-core. Boqun, could you take a look?
>
> Link: https://lore.kernel.org/rust-for-linux/20240819153656.28807-2-vador=
ovsky@protonmail.com/t/#u [0]
> Closes: https://github.com/Rust-for-Linux/linux/issues/1075
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Tentatively applied to see how it goes in linux-next, but I will
rebase for -rc2, so tags are very welcome!

    [ Move safety comment below to support older Clippy. - Miguel ]

I included the additional patch I just sent. In addition, there is a
`>` typo on the `Deref` commits -- I didn't fix it to avoid adding a
note everywhere.

Thanks everyone!

Cheers,
Miguel

