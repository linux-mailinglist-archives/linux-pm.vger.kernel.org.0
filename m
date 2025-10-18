Return-Path: <linux-pm+bounces-36431-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A47BEDA3E
	for <lists+linux-pm@lfdr.de>; Sat, 18 Oct 2025 21:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2299919C30D3
	for <lists+linux-pm@lfdr.de>; Sat, 18 Oct 2025 19:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D69A2D837B;
	Sat, 18 Oct 2025 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWwYi6s3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130442C2345
	for <linux-pm@vger.kernel.org>; Sat, 18 Oct 2025 19:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760815509; cv=none; b=f1Q6B8OqNvrU9D+UOwi8POZdQoG7CISjtQJQPvBbirBn6dw30B5rwcA6pwvEaSsXGV5JpXFBYd2LAeRR32AgQixpY4L1iRQJ959WqizKpzXJe6SXf86kZq0kTso0dmXIjG5SJirIxtB8wzkgR6aKGP+XVXgbQgcKV1Zer6AbspQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760815509; c=relaxed/simple;
	bh=rnUc1sSIJcJcXtlU0rQc91rWE99Qu6t+C8m+svSvM9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JtN6c3xxr9aSeuxgIjz10gQ8R8Sl47vlcFjLYyhPL5xB4Td7A5QCfTFS3W6LgKolypG6DOnYtacrjxzlMdBYtw5z9/IlCqHcRdPwuoYVfVZAKOcocGbwTNhOESxSA6iNaWOVZc1vjnhPnz3mZLM6qye6AsiL1LJs3jlC4JR5S14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWwYi6s3; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-290aaff26c1so8252745ad.3
        for <linux-pm@vger.kernel.org>; Sat, 18 Oct 2025 12:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760815505; x=1761420305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXwxLtFHklVqMldstrW5nXmaQWoQkEu+q+HBHCmmMZA=;
        b=IWwYi6s3kuZG/HtWI4MzpdPGLv4d8Bfcn+qXg3YsCAJEr1QKzKvTGjiRQOdS/DQ6DP
         Y8fr4SVEQM6tnr35g77FE8TRgg5K2PYEEdg9HIONLygZlMDawxU3NigbPW3k+OP+wdAX
         p+RL+AdNcPN++TuGYbszNv8guqVo3p+IJHzSFOheikGp+wvxHC9YGodWGWMCuNiFQyF0
         lrFKjCEXeBB56WnBrAiqRo+TEE4IlNb0HSwwcDRdBld7LAccjJwp6Gt9TETzQOBw8cBJ
         mXKIEF0M0odkj1R/YCfAK98yUptWeiaPIRZWw7LLzFnaqdaEvwU0L50N+CZJqNyHJ4EX
         3h6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760815505; x=1761420305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXwxLtFHklVqMldstrW5nXmaQWoQkEu+q+HBHCmmMZA=;
        b=D+DyuzO8VHHL9rvgOeJAhO7Lj6YvHmpPwHftiKixCom2CVQNGIE8sXW/ZqPARqDvnp
         l7V4bp2eFJH1MykeRXPMjg0kqgPQVADtOWlb+ZFheLMXmFPAhgS5pP+VZDue96ErIcj9
         CjZ9bimga6fOay/tG3aGe/xLsvy2ZWPP+QmwfQHsQRI/gGn/Op7atM3faw3XecqAhvQ0
         jB8jv4DBips6F4F1YmOAJYjt5rKq/sJdtZSJZbll95jfZbcNDUxNMOa4LSf/HjtwthK7
         KhRgSKO5grDPugobBdiq21L0PZGak5sRCV4KoJZkTevKYj6YSiKZpioFdA8FSuY6+3FT
         ZMwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYa+STJJH//2viTs7J7W/sO4rpMinT/eDYqw36A6o1VItIN275690yAbVH3JmHcFYnltMNw9gJxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjRmXSd4wTQ/kGpVFRwpfCBrOailVfBN1XxSz0AtufVjiSv7/Y
	9tKIO9Nc2qxNkekvzEgGKSMLT5Do1pdY2iaMbzKgXO06p9SoAqiAjSYl5tods+Fsxte/9tKEo43
	uY2FN3xx6C8EC5gTEZj+4X2Vk/VX5nTk=
X-Gm-Gg: ASbGncsAIhzDPFfRkOoAgFMPRz4GYaQzG/Z7tyd6d3DEaI+ybAFvnSuI62qhKAYDenh
	RDNiAxoVVJ14r6zY/TWHZSYLRHUV8jct3N6JLJ3voVdZe/Hzu5SV2CK2k8CMAkZ+rFWy4zfkOkO
	zTZRK925QTHmnKBhFI4ZtXdRqlwGoWOiqIb8Q3cdsfymiTfJc1GVF/PGd8qne7UGkhoMbBVZN1Q
	9kbvHwKs9oUShrmlezDhlsXPvSpr+bllTcwpf1FV5hu3/f0X/mH7TApWjqwXiJqnidx4Zle2orx
	8XJHuLUpPS2p/inLUGzWhjXknVLx37IGVQqt/T6RYPp0rjpq78xBz1/mSuqogVTLfmzuvRSIqJZ
	qZbY=
X-Google-Smtp-Source: AGHT+IFynbxdq4PbDoeu2y7E7pruyAv8MSoOFKgcS5qR5uKUe2l/9/1aikoejnUdjk1VE9ieyNLSjxDynifGmomPS5w=
X-Received: by 2002:a17:902:f550:b0:274:506d:7fe5 with SMTP id
 d9443c01a7336-290c9cfec04mr58829965ad.4.1760815505098; Sat, 18 Oct 2025
 12:25:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018-cstr-core-v18-0-9378a54385f8@gmail.com>
In-Reply-To: <20251018-cstr-core-v18-0-9378a54385f8@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 18 Oct 2025 21:24:52 +0200
X-Gm-Features: AS18NWDWZ6CTzqAcsRkSpKjdzes4UGFhB9PPk5gEXsERGZ6zM8JBbanNnhdHiYY
Message-ID: <CANiq72n8m0JKjJMZ8Nk8B=GG5kcsSuc2YKp4=r2XJJgREoZZkw@mail.gmail.com>
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

Thanks for trying the kernel.org account -- it seems it worked!

No more throttling to deal with anymore :)

Cheers,
Miguel

