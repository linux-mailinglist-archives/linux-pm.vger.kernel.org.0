Return-Path: <linux-pm+bounces-26735-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD82AAC14E
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 12:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CACF63B4552
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 10:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E11727703B;
	Tue,  6 May 2025 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDA0NV/b"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2767275869;
	Tue,  6 May 2025 10:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746527120; cv=none; b=tcDY8M69WKE8AN06gYpAx59dbjKMwUh9E9WmlJAb+VesJy28bI5uV+zbLRzXBW4qTjKN7ZSswwDbow2FD8UgQxJgkqfHiDsyFiJoyYwGCFy5GHd86XSW8cXUtuKAq28LKlSg4uxgwsT8KlC65I1bPvgqUVon6CZG9QZ00aNQcLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746527120; c=relaxed/simple;
	bh=HNvpa2Eo7tSdFILDlxkSiMCU0KdDUbo+UdR+rUM8044=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YvwKVt9IeUvAEhdqwyhnlBYTSdSD9PH/ng7jNoU7YtwV1tsinVlXCf9sCS0LV6mt/t+9yGQPRrAb4ddslPaT9sTCDH0oVSljjuguZs5BidsDGQlPVftrO3wy/sdW2pKv9PtNbB7cf+7/bKDr2qnXlsHTRTFaoare7pRYZFO/AL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDA0NV/b; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22e163543ceso7085365ad.2;
        Tue, 06 May 2025 03:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746527116; x=1747131916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyLB1z+Ve3MGzRF3v4MVgA5J4WLWRyi2thiBODDNnGI=;
        b=iDA0NV/b4ro1k7hrotlHG5Mzj3DMdNUw/DLb49o2/ts/xgD8zwLin6YTA9Ma2clmfP
         kfWSKsz0PJZ5OHOsQGj7XnSweSP5f/iGqMNUanA3SHWtVYM5nenf9Bi9N/HHMIiVBmet
         hduErkTSWxMGFCEeVfRjYQgw9jEbwg59nHcul5HIgat+yP+5n8q1QQCM/z9nQu+TbZ7V
         WF2aCmJgvx8k5N17kQV4ERzD77gRmAQX+oVqdTYBO/iCgKvq0ix6PN+wOY4Iv6ORRERX
         YLmEk7ZsltuAvPY+wwS9iPLDR7kX5RtgOM+/Dq32Chj5GLRt3vdT3JNzrQkhkDHShBa6
         U2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746527116; x=1747131916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyLB1z+Ve3MGzRF3v4MVgA5J4WLWRyi2thiBODDNnGI=;
        b=O331przK0fDUnYdAuMiBroAED/HzNgdJ6PqD7YWAvuexYT4eJCt8SUlzjO7pKWQxw8
         Zo/kJjHVK3RvdA1X1nOO2P57GurZPFoUfB4B97R0ZiWoUaNWHAfYTEcCP5VvRIuFgh1i
         MnnzUhFV3LhY84D9Z7K3oMf0f9kVCkE584pcchPkD3soErzLadtuisvoj5n8eCmE4QnU
         MYF2zBK8p5RikbOA10JF9EPi+Z7dvPiC0Bd9gJJFNUvLYGzcicDXDJbp3cd/fC6A0y3H
         IX5iH0GDLK48C8a84iOmbM5tyEBaFNT2dp/yDlav05OAFZA29XyI88nBN2vs3IfvvwKY
         X1wA==
X-Forwarded-Encrypted: i=1; AJvYcCURt9/NEG5nN3vuivc3/LBG6i9FOAiMTz9z/BvaNfJpSY2rosS4AHgDkW/D/MeUmbdn1O6vKqGDMOo=@vger.kernel.org, AJvYcCUbVd0jORib3Y2LHcwEvNZnvgb3VIEcXuIjcEtWFdCvnkWCsSun2WcsIWke5oA1v215wrtAJS7A3H4=@vger.kernel.org, AJvYcCWhH6+D6JoAUUMj7f9jH0szL9DUIDUkGY0eouniujtLH/oZecgjsjWfG7/wuTqCH8OLEsSKC8HGubcXQrHk@vger.kernel.org, AJvYcCXHF/Yntajpi8Qfd5m3Th64+OVRqUfDXbE5yN01xd+BFWfD7vcsZIke8ic+C4iyZlxSK4BRLyxpuslVXdTATl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxWD0IxwcGNB06DWARReYtZNbw3uaTP128bDTHakNM9zqgoKlg
	fZF8c29Wmg6fbQ184MFEklXZUIpguVMMsYM5X+kSmUrn+grAD9meIfHxtVTbfRHoKD9OwnOJiDx
	AJD1HzJo6mhTtUnkWcNGV68F06cc=
X-Gm-Gg: ASbGncvfZseA5d5opOOpGks3BBvAIKMZyBBMN4dZMWGybs6OF7nu1k1Ngj66XrWFOD2
	TLkTp1deAV1wiCyW7ywLTk9gJ8ioXT6/O0dR+JrLpTGlJInm7PMkNt162s/1SXHML33a/gUE1bJ
	UskxfEj63ZY3rKA0yTPnf/GA==
X-Google-Smtp-Source: AGHT+IH3m7O/vizvz4Yjf3dvbJP0kjxJWIh7mJkDG9BEGHYUFYbe+8VcCoCLLDrkr4DxhpzlPe0JKXuS7u5vwajwLBg=
X-Received: by 2002:a17:902:d4c4:b0:224:e0e:e08b with SMTP id
 d9443c01a7336-22e1022be16mr98720805ad.0.1746527116173; Tue, 06 May 2025
 03:25:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502070109.inpes2ou3rxx2fxp@vireshk-i7> <20250506101311.142475-1-andrewjballance@gmail.com>
In-Reply-To: <20250506101311.142475-1-andrewjballance@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 6 May 2025 12:25:03 +0200
X-Gm-Features: ATxdqUFhj6qDR92HHk-3C4iXl6O_UDQOpyfYBJ4TQjYOBDXAz_1ZQp_UBtw0_e0
Message-ID: <CANiq72k3ozKkLMinTLQwvkyg9K=BeRxs1oYZSKhJHY-veEyZdg@mail.gmail.com>
Subject: Re: [PATCH V11 00/15] Rust abstractions for clk, cpumask, cpufreq, OPP
To: Andrew Ballance <andrewjballance@gmail.com>
Cc: viresh.kumar@linaro.org, a.hindborg@kernel.org, alex.bennee@linaro.org, 
	alex.gaynor@gmail.com, aliceryhl@google.com, anisse@astier.eu, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	bqe@google.com, dakr@kernel.org, dakr@redhat.com, 
	daniel.almeida@collabora.com, gary@garyguo.net, joakim.bech@linaro.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux@armlinux.org.uk, linux@rasmusvillemoes.dk, 
	manos.pitsidianakis@linaro.org, mturquette@baylibre.com, nm@ti.com, 
	ojeda@kernel.org, peterz@infradead.org, rafael@kernel.org, robh@kernel.org, 
	rust-for-linux@vger.kernel.org, sboyd@kernel.org, tglx@linutronix.de, 
	tmgross@umich.edu, vincent.guittot@linaro.org, vireshk@kernel.org, 
	yury.norov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 12:15=E2=80=AFPM Andrew Ballance
<andrewjballance@gmail.com> wrote:
>
> I have tried building the latest linux-next and I think that this
> patch series causes a build error with the defconfig for x86_64.

Yeah, I also see it in the latest `linux-next` runs.

And in arm64, it builds, but I see a doctest failure too:

[    1.014106]     # rust_doctest_kernel_cpumask_rs_0.location:
rust/kernel/cpumask.rs:180
[    1.015226]     # rust_doctest_kernel_cpumask_rs_0: ASSERTION
FAILED at rust/kernel/cpumask.rs:190
[    1.015226]     Expected mask.weight() =3D=3D 2 to be true, but is false
[    1.017326]     not ok 40 rust_doctest_kernel_cpumask_rs_0

Viresh: could you please make sure `defconfig`s (and `allmodconfig`s)
are clean? (including with debug assertions and doctests enabled) We
will very soon be putting more things into next for the merge window.
Thanks!

Cheers,
Miguel

