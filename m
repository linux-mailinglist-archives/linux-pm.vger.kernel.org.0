Return-Path: <linux-pm+bounces-28192-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDB5AD0023
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 12:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F6763AE320
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 10:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE6B286887;
	Fri,  6 Jun 2025 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIKBcX83"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9034E81724;
	Fri,  6 Jun 2025 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749204651; cv=none; b=X/vmDbTVG4n++oWA9aJ0F5U18u2LPdhyVm+PJARuVp4J7ENO5c1AEtVeYQqd/dqaltedejArB4gutLg+11kA+60rYjBYneJHdoZvVHI//EhAxFnnZ434/JKApASJpBT078opJTcFwN/2vOT+aLRaeP8s5Eg1AMOOvXIVc0ROqtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749204651; c=relaxed/simple;
	bh=w3jvPKDcZ5KnZ8bgfQHEt/tnSSP/RaDEPYHKY4JFfQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K3cA1FMXLGvYCKSAOhuLwHkgvgdUS5WBib7/6962QGwLN9n05/zP54ppeNlVsp+1HaC3XkzqXpoDuhhNJx1j6gTu8+1aeqegHzLWTbAa9VZEjNn+x13ElXAWOkbl34IL8NerCbLwmMknq8JQxHMP9t3HUzeOQZz2K/2mCoqPyVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIKBcX83; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-234c26f8a25so3035745ad.1;
        Fri, 06 Jun 2025 03:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749204650; x=1749809450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEVsPcmujVG4TPPGthouiu2CSCG3XCwm4flJ5gXb89s=;
        b=bIKBcX83PfeyoiJ/l4HcDSJKMC5T4UcVCLLqaSM1ocYlPRD4oPfyyF5d/ff3/Qo5fs
         3KZFZroJVdbsvJH7zgDtZYcfpEy5NV50DjWEhFCa118DHCV70Guvmnn3wXx6t95ldwdd
         AoDqczoR2QqQPIYNcKA7pA+KQXTsgSlkEqltQF8XQa9yo22TCBgUSifwsJVwNbbnivZV
         cUUhWQLMHm4dlm7geSRxEq9StcAH0VqlbhBcBls+mMh5bSlCZrJrfNN1RI0hZqn0WK3p
         0YCp6Mim6eV1vEMvZXxVkVHAYqTFGtPtMIcanZxQ4c7c3vqLXTreIbiJ6sc+5thS24cu
         UJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749204650; x=1749809450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fEVsPcmujVG4TPPGthouiu2CSCG3XCwm4flJ5gXb89s=;
        b=H9kQdAxJkwUuFRNHcaG3yrwvqIQ1m1tLvya8K3ojmpHmi1+lxIQP6V2hJIEMSucMnI
         qA+DKzsSU8q7ZDKAC6nO1pUL4m8w+h4nAC51mvJpyei4v1MiqcXTyNRGUQjI+HQboFBH
         s1eZ7x6RK7wxMkL7LWXVedng0LscOSo3vnWUOjBEY+S2vpPxpap+1IeWVUCu0L6P7B82
         MmukQYeoECL/SRZgLNl9lRCBmQR2dX1baDlc/yQQWUiGUEnJ/j/y3Cq62LGI1b9KzLdb
         uafxk3aNvr6aoW82VYJSSZRHGE0prfHid4LHopeXUg0iGS/b3rIBOuqGaU/7zF/36xah
         k8ag==
X-Forwarded-Encrypted: i=1; AJvYcCU7jqOdoBK9KwrZkq0o0sttJhOOfQtqg2Qz6oekkiFqKy4C0BqxizZc02Fq/6AbQh60lXXej1/40PA=@vger.kernel.org, AJvYcCW+uU5orndG6orzfsSi2oItRzBhRzezCMAILrjsD22j0wYzB1PXNpL0SkNfreZEc2++F1ShY2lfyw4=@vger.kernel.org, AJvYcCW//BNwocnmehOV855x2XMoY3aLcH2mNFVVPlS1fMT4tBjWtoofVqHOgTaFAds6ERPyTXlfQv+OKmdcsoFA@vger.kernel.org, AJvYcCW0IhZR520dcPA449FAAEJ7L/DqvJgZbZO8CCyeKE8K8oOqDxPLT/hrtLQb3LSp6Fc2qmnyrL+f6b24BOQpLh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs4vHL6EJ4AX0WQdjTP3JauBpog0f518bPKAM1c+a3iLC/bUpF
	XRqLTZclrB9V/VakDhTTz0nJe/MzIrXzaE6fgZF6VOWUzMtqlOCxCos1hp50aqO6uXiTpzsVmYi
	q0wgnl14zXYkVIoZWfGFPLh43jLRL1rs=
X-Gm-Gg: ASbGnctu9ycIYa3de5U/8kfH0pshJ9BaxxyERVQOrq+1Ywq1lwSh7ni992vpsl8fVbd
	6M7jvsS/uPvliRm1CfomtwFFCO1OYt62opVCCn/vpiUB0nlRPr5kUbyFM4l1EdxNXqWvZlA7mpO
	+bVqhod2Qo4lvo2Y9XGT/GaNOMzNbNwc2v+S51n0AhIbE=
X-Google-Smtp-Source: AGHT+IHJK6lS0GjeOTRlGjUGlIzSEOQJan0nGM6pFx6roUYemWWUxEZ7RboJGS+1ELFs1nF2rCoKHpO5YCC2dkuhHuo=
X-Received: by 2002:a17:90b:3d04:b0:312:ec:411a with SMTP id
 98e67ed59e1d1-3134e3fa0e4mr1136329a91.3.1749204649600; Fri, 06 Jun 2025
 03:10:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <HVTDJypFNQFfSQJmmYDSPU4o-irFnjmDN22RW3S0z5Kwe_hVk9kquZWElv-C2k6d5kOIiewhj_Xo2kAoTHbHgg==@protonmail.internalid>
 <cover.1747634382.git.viresh.kumar@linaro.org> <87qzzy3ric.fsf@kernel.org>
In-Reply-To: <87qzzy3ric.fsf@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 6 Jun 2025 12:10:37 +0200
X-Gm-Features: AX0GCFulh-NApLJ_BZprdr-LgDGIG0IRhXBoIDMZxa1As4OIxQVem2hDI7xiYt0
Message-ID: <CANiq72=EE1Gqhjhyz46njFa5Wb6gbax3Abg83PyhQNX=X7pF1Q@mail.gmail.com>
Subject: Re: [PATCH V12 00/15] Rust abstractions for clk, cpumask, cpufreq, OPP
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@redhat.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Benno Lossin <benno.lossin@proton.me>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, 
	Michael Turquette <mturquette@baylibre.com>, Miguel Ojeda <ojeda@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Peter Zijlstra <peterz@infradead.org>, Stephen Boyd <sboyd@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Trevor Gross <tmgross@umich.edu>, 
	Viresh Kumar <vireshk@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, rust-for-linux@vger.kernel.org, 
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>, Burak Emir <bqe@google.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Russell King <linux@armlinux.org.uk>, 
	linux-clk@vger.kernel.org, Andrew Ballance <andrewjballance@gmail.com>, 
	Anisse Astier <anisse@astier.eu>, Daniel Almeida <daniel.almeida@collabora.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 9:42=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel.=
org> wrote:
>
> I was testing an unrelated patch and found this kunit failure in
> mainline today:
>
> [19:45:34] # rust_doctest_kernel_cpumask_rs_0.location: rust/kernel/cpuma=
sk.rs:180
> [19:45:34] # rust_doctest_kernel_cpumask_rs_0: ASSERTION FAILED at rust/k=
ernel/cpumask.rs:190
>
> This is for arm64 defconfig. The test seems to passes on x86_64.

Yeah, I reported this back in v11:

    https://lore.kernel.org/rust-for-linux/CANiq72k3ozKkLMinTLQwvkyg9K=3DBe=
Rxs1oYZSKhJHY-veEyZdg@mail.gmail.com/

No harm done, but let's please try to avoid merging new stuff into
mainline with open issues.

Thanks!

Cheers,
Miguel

