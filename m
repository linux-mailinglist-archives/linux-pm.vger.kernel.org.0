Return-Path: <linux-pm+bounces-41121-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE77D3AEF6
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 16:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6196D3037532
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jan 2026 15:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A56238A9B3;
	Mon, 19 Jan 2026 15:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AitzS9lM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE17638A70C
	for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768836177; cv=pass; b=VjOEzlGQLtSKoTwYIebOxXQqhkWEUDCEhlBF6Kz1in96Or2iImiZW/SABBx8sXG0EaJQVUDvZF7no5TY9jJEKbdGeMlXc17E56H7AIvKu2WPiSMaQNAZLOG4GWzi3Q/giVF3Nnyht8pGK1vtXtQwys6giGbVFEaNLVCXZaoLV14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768836177; c=relaxed/simple;
	bh=tR0gCtypqd1iX1iRkqWIYioksTf/njgA2aZ4h6BcDxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3igIvzeVDCGp/S5aPR/QbkVkYcmDglSpBuOjbOX9hyi+xJ7AVz0w1kj2mZljUoIYjjmyTZQ+vDeELQBgszVxr7E98DGdyX/5aaaM0SDgB8C3j5fnzSZB0SdVZlCpqy2C74DuT4hMZ04kfXPp3nu/08EPzdoOWYXj7xGf8M5RoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AitzS9lM; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1232de2e2c6so149748c88.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 07:22:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768836175; cv=none;
        d=google.com; s=arc-20240605;
        b=ZbR4vKNR8g8/06jX0l4CSuwSkpsAeSuxdfXsngEDApO5BFXs6eI/fSrQTavkEN4zOi
         zmBkbXJyWAkml6RYCIkp/LXoa8u1TnvGJ6lnDJtxxcGUKSASyS19e6+XKFKMFAyoOvQG
         O4X0xIe8N95looTjWB5fo5K96RY9kwAK4l8OKGDmty3AYoVk8tb9i7/qJ/ElxrWSqj2l
         TAKMhDQkC5/IzA8o7Hj3bz23mJOy34INNJPNdlYID5gDo65d92fSX0lr6w4IXlZ8huAM
         6xyQKWlZiL2/ovEl/6Pt6hjN9sEGI6ddXNvc23ZM1rKVNIzlDIJsJ7i8Rb3KyjJwRAFR
         EYpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tR0gCtypqd1iX1iRkqWIYioksTf/njgA2aZ4h6BcDxM=;
        fh=KUtK18AMdx8yOrGqKkheWh8AC8Mj7Gjyx7KBIwY4xbQ=;
        b=H+zbAPPAKDcwkQUmClMD6pIPgHdN+FkY6gVnG4U/8aQuHBb9KvY80uJf6kp8SZ+NpV
         EHTHHWyimrOJqDUqyg28AxeKIYloYLVYiHSi1dDajy3OSLpSev8iBh4huCcr7GmWKJcC
         f3HSdNRBrdgcT3wonWm0/hEihNZBBSzBnMNhs7X4JU/TurWpf59ItYRfjMd5mi2WmeLv
         uzX5/O3TG8/+tUNLZiSMk4iImnbJfx1K7uw3Zr1ECu3+y3+tabFYtAWAx2NLFWMrzXRX
         nDZtoEAZSsZuFQv+MvT3OlPRDGSB/fed/N3LpunIxeqWcKUzOkU6ar/8RbkwfIilgK48
         FM5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768836175; x=1769440975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tR0gCtypqd1iX1iRkqWIYioksTf/njgA2aZ4h6BcDxM=;
        b=AitzS9lMQwv4+fdWYBLW4qMQFvS0PfAesTfFeFGvl6x4XWg1Y/WFr1kTmFIDODAIrT
         OsJ3v6RHnxP8T7v/xmPcJA9AvmSAxKKeK7k/YTdlf8rSOfSNqEiMrZUis1XRsW/5TFTU
         I42ndpD/s+RX+n1G75OsTnYR92yrNDKQa7Nlb3Iym2/QxjJu8vwbU+7Wp17DxDeU4wDd
         TmMjKSlZsub+p2JSB9288ug/ipPwFzsDd1Ni1l7h9CtWRRnodPCrXHzd07aUIb08+ovj
         iFcB29jKkC5RjVwPsgTsq5r8E/m5iWgLSgdd9oXoJmvy1qA7PSAHVTb1Hhxf4ctF4H9m
         Pvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768836175; x=1769440975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tR0gCtypqd1iX1iRkqWIYioksTf/njgA2aZ4h6BcDxM=;
        b=OcrOwLSDVtoY8uLDnH6IcSwVZuJKDJKpJEKavFkI0cU2iQNR/5pkqeKMaqcKZMuh7e
         fQVxbyCIZWwMY2MRZbcVl/jGCom9rXRLAxd2ymejeLSrt+CsSKLyFNhY+5RjW12djS/a
         KILF6e2UV09P3QoDofraL9JT6RbhcOgjGW8bkdWYlbui/ngd2WtiYIhMLmVIiVoirakP
         mke/56I5glHO9g7hXF1kyqEOAqHbCOxOGv0azBkq03g2gEaz94cJ/hfd7aohYN4Yjsi2
         Y52ZOASmelLTnquOXq+3vpEzJT2OsdZH1vFj9lvky1ZytV5NAdXxHLhW+HP3uDLlOiHx
         evwg==
X-Forwarded-Encrypted: i=1; AJvYcCVoaEIb1nNVw2ivXwypyezDKNxRr9+jroSql76wVdgC+aCZdK7zysMIbUZnAMjoxqonsUPMGeGO8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpXQIGyUrlzgSMciFoXr1vyMsRT1ZoG/uzy+UWV7VQ5Mf/ai3G
	6pxC6AH93crFlPLI+9r4NVkVcqImBODj3Mn6YVGoLxfjHe952usvjNXwGeEBEe6TDcZjbd0ibbr
	41puzt0dvCmf2BXCnFDTE7JuSSJB9sfc=
X-Gm-Gg: AZuq6aJL/asDBVa1OxxSNp5mJQIGs7CvWad1ngjFP1HYgyFjUn0d0kmRQVatKcvOUlx
	axuyrShXMgyN4NTizMVPTBmSwP4UGz1QeebXSMV1oFFg9pfK5kF5VwqDb4jQmPZnoHUXu3dNA4W
	8IU/2SfXuSt+ARLf0j6zKSxO2+drL9EkFrKe8dL4jgg4z/9O3gcz2b3VmYJK6+AGe+R6ZwuwR7U
	2chnTdAc1SIxD0IfQ9mjOx+vfkvFwe6ivuNVSDBXKc03kuFVfNUGXK1iHIbrg//LU5krgWP/jsf
	FxXkDICa+2OG2I5/EoweC2lvZYXosWSctBaYmcm4btg7291FLngDszhaOcpXci1PgxIdxA94tgs
	3aZNG+/usqZRQ
X-Received: by 2002:a05:7301:228e:b0:2b6:f613:74e6 with SMTP id
 5a478bee46e88-2b6f613797fmr27366eec.4.1768836173425; Mon, 19 Jan 2026
 07:22:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-clk-type-state-v3-0-77d3e3ee59c2@collabora.com>
 <20260107-clk-type-state-v3-1-77d3e3ee59c2@collabora.com> <DFSMRQFIYQPO.1A38Y84XZ1GZO@garyguo.net>
In-Reply-To: <DFSMRQFIYQPO.1A38Y84XZ1GZO@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 19 Jan 2026 16:22:40 +0100
X-Gm-Features: AZwV_QgNN_SRIlYoHUy-qlXXeVjMEAqzZugkTtOGHbXvqJ3qT7hNtgfXtF3Q8KU
Message-ID: <CANiq72kcRQShDgMJKZ+ekUEdP1T6Jr=4PDiMJCqnQjgCQEK_eA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
To: Gary Guo <gary@garyguo.net>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
	linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 3:20=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> I guess it's time for me to work on a `#[sealed]` macro...

...and perhaps pinging upstream for the language feature... :) I added
https://github.com/rust-lang/rust/issues/105077 to our usual list of
wishes at https://github.com/Rust-for-Linux/linux/issues/354.

Do you think using the linked crate in the commit message would make
sense? It seems to be a couple pages of code, using `syn` 2.0, which
should be fine now.

Another option is a "good first issue" of medium difficulty if you wish.

> I wonder if it makes sense to add a general `ErrorWith` type for errors t=
hat
> carries error code + data.

Sounds reasonable...

Cheers,
Miguel

