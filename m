Return-Path: <linux-pm+bounces-22104-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE34A36512
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 18:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B2DC7A2467
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 17:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889E8268C54;
	Fri, 14 Feb 2025 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hu+5U4+4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D8A2686B4;
	Fri, 14 Feb 2025 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555819; cv=none; b=obfKbqCOCysiTAHOT3ELSbLj/4LQLPHpwZ3TLS3x5JcDtL/VBOFr0+F46eYpdlWN7Bi3WHadsyomlgtohf3HD/wdjXXKLoY4SdhvwB9GQs/rA1ewVeHJpmLAxwN0aKvLrFfQy4jHxhgYaHTufHL9h3nlk6kMy/MVL+RHuusqpBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555819; c=relaxed/simple;
	bh=lwaL1ltJxHc2XidJ6vVm7TVgQUP/nPkLjPuqPuaKQn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EF8eZVqEnNYVEHBaIXCVWGdaVdogYPQBH+q4sIB8GryP5I9Yn8SV8JrNtYVCJD2fCav02DBRbkRBebKZey7XMnvx/xNdVpO7O8RQohFuPU9ldAIp/JpNNRql5yTHgQQvzJTbyWoRvSBpjdhq2TljCeD/lh5RKoxQwGtMdNIdZ8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hu+5U4+4; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fc0ab102e2so511237a91.1;
        Fri, 14 Feb 2025 09:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739555817; x=1740160617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uqTJJ2jGnxNF41o8Nl196eWFB49oMcWZ3x7tEMRsQs=;
        b=hu+5U4+4/+t72NXHCAiHruJZHhx+PpgAM5kGjCBXgH0c+G3BZ5XBuaZAHQ3dOX7FDM
         6WfNPnnBjVNnOtHRvJ9F5+PQGec7kyHYCFHnV1GEvP05MX4Y+Wl7gvXTOiKWKd24ppOz
         ljrDAyauPQF15/DVInnzGe/bPkdEu1LE4WPmQreA4SveFit9WCihx9BFLwwpLo/B4z5V
         70zkfdmu2Ib6dNMm7FeMW4/YQQnymG22GAbloNkUnZAhYgByOPT9bN08umzSpDPdOx3N
         /XfTWlh7l5askuAvlUW2jlr413UlDKC2GR3qwpXikt7IGUtmgyBBBPX1Ph1bkGfnO8SZ
         K32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739555817; x=1740160617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uqTJJ2jGnxNF41o8Nl196eWFB49oMcWZ3x7tEMRsQs=;
        b=eHrV2o5ckgeK2G6LJNpn9s+K3pAD5O4Ltw2vuQkVXoiRPtnCk/9g5AJeht9otrAmdt
         lK0TajpaDounngPvn3aVc8gvG1LTDWv0EInjY+cp+3O2LAu72qQNboRD5xj15mF0FsPd
         xT8k0GhP9SrtZRehTp4KfptXGX6lLUx2oConwt8IJkvIWZTxfPkYHIs7eveMUA3dtQn2
         U1KfC3EvCkBIFX04qSVZOKD1zsgXCtg8YzP/zLHWyu6v88ea+kNHqUGgufWPTnqIjfut
         4gRZqBknYQVaFd8dvLkbG7RWc3fPZs9A0De5daK7+2SSoblL6+PcP8LJokmTFwegsmU/
         KXhA==
X-Forwarded-Encrypted: i=1; AJvYcCUKgv/B/nJcAADIyxgCQBqslPmbncmGKW/7hDQ7lVQYyihevrVhRl4o3u1XAbcsbw+XhO8Rig9/Yzc=@vger.kernel.org, AJvYcCUbShi/rAJ/xdEX5ha2Ls3tTcU2vHrjmXfstNI8rNquuyPQctAxXqriAeeMoSc0ixpgMHN8ariU6L2gYKU=@vger.kernel.org, AJvYcCXPI2KGhmpnDNTBPOWJutMeVFyfGc39Q8Ld2BD/qDAGtLrfPh896UAI4OY96zMxdR+2xLKdF7eiwxlL8lCyvuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgcbktsoNTOwkx5DtnfY7Fsi6oKVGmIezFSjunw/Rx7CJlrjuW
	HvrG30gtx7u+brE8AJk764DkMV4rVjfhdwwM15GDJXW4Su5XBBVXDxigmPZX8Rb+OhdSM6kPWZ/
	I/520FDDF10aw3mD0XTC6DnMERns=
X-Gm-Gg: ASbGncvsLsF+26LoyAyJt/V2M5ORAt7GZBEoo/gAdXvPT2e7iNKO3tcph49QXd9cedo
	vUxC2hcLs4o++4i/GHett4WOC9PDugURVrIqCm0IPy0A+IVYD+vPZYJ1dLVecYpvc8JvnT1Gx
X-Google-Smtp-Source: AGHT+IFW42ywit++MdXGF7yi6jLYPNcwbU9mmKg5g0YI2M/HsrDTeMd6/RLGpgdHziQFFxCBnhFtsGX1VFM5A2UqEmk=
X-Received: by 2002:a17:90a:d2ce:b0:2ef:c419:6930 with SMTP id
 98e67ed59e1d1-2fc2d01d465mr2414651a91.6.1739555817064; Fri, 14 Feb 2025
 09:56:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738832118.git.viresh.kumar@linaro.org> <db0166341ce824c157d0c58c240b3efc6aec6f6e.1738832118.git.viresh.kumar@linaro.org>
 <Z6qTelPSqpFk439l@thinkpad> <20250211042908.nyftiw7gtxosfjwc@vireshk-i7>
 <Z6t51xodSV21ER4M@thinkpad> <CANiq72=3MR9F9ur-aQYP4P81RBreAr=UiGg5iaSuFjjd5Q4Y7Q@mail.gmail.com>
 <Z66oWuLwY4X9Ou9D@thinkpad>
In-Reply-To: <Z66oWuLwY4X9Ou9D@thinkpad>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 14 Feb 2025 18:56:43 +0100
X-Gm-Features: AWEUYZlCvnlYip6NxT-IbEXvDXbcPqbLJNWAR6_aNF7ALCefm0UGoYTQZWtxKqE
Message-ID: <CANiq72=Yy8e=pGA+bUHPZhn+D66TmU3kLSjAXCSQzgseSYnDxQ@mail.gmail.com>
Subject: Re: [PATCH V8 04/14] rust: Add cpumask helpers
To: Yury Norov <yury.norov@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, 
	Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org, 
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Erik Schilling <erik.schilling@linaro.org>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org, 
	Uros Bizjak <ubizjak@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 3:20=E2=80=AFAM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> I mean that Andrew's branch got broken because of it.

(This response is extra verbose to be extra clear, given the recent
discussions these last days -- I don't mean you said or implied any of
this, sorry)

To be clear: it was not a patch we introduced that broke it. It was a
patch series from someone else that got a Linaro build report and
that, nevertheless, was sent to Linus.

The build report reached our mailing list, but we were not Cc'd
directly about it (i.e. as individuals), we were not pinged about it
(i.e. we never had any further questions about that after that single
day), and we didn't realize the series was kept in a queue targeting
Linus.

Moreover, the build failure happened with a configuration that is
best-effort and is documented as very experimental (GCC mixed builds),
and that we didn't know Linus was building (we knew he built with
Clang+Rust, which is what we are focused on testing), so we didn't
spot that either on our side.

By the way, we have not been Cc'd in the new version, either... Nor
the mailing list.

To be clear, I am not blaming anyone for the breakage, and I already
apologized that we didn't notice that report. But it is not our fault
either.

We also never promised we would fix every single Rust issue spotted
across the entire kernel. We try to do our best to help, though.

    https://rust-for-linux.com/rust-kernel-policy#who-is-responsible-if-a-c=
-change-breaks-a-build-with-rust-enabled
    https://rust-for-linux.com/rust-kernel-policy#didnt-you-promise-rust-wo=
uldnt-be-extra-work-for-maintainers

> Yes, I see. Viresh didn't do that on purpose. Let's move forward. I'm
> more concerned about lack of testing on rust side that ended up with
> the patches withdrawal.

Please see above.

I regularly test different combinations (branches, configs, compiler
versions, and so on) to catch mainly toolchain issues and so on, and
keep things as clean as I can. Others use regularly the Rust support
for their different use cases, thus more testing happens on different
environments. In other words, things generally work just fine.

However, our testing is not meant to catch every issue everywhere.
Like for anything else in the kernel, whoever maintains a branch with
a particular Rust feature needs to set up proper testing for that
particular feature and relevant configs.

Regarding the GCC mixed builds: worst case, if we see there is no
bandwidth for it (be it ourselves or other maintainers testing their
own branches), we could limit the testing required (e.g. limiting GCC
versions when Rust is enabled), or we could request Linus to skip Rust
with GCC in his builds, so that at least PRs are not blocked on that.

> Yes, this should be done. 0-day is already testing everything in my
> https://github.com/norov/linux repo. If you know right people, please
> ask them to test bitmap-for-next branch with rust enabled. If there's
> enough resources, please cover all the repo.

Definitely! I will do that and Cc you.

I hope that helps.

> I'm the right person to look after rust bindings for bitops, inevitably.
> I will take over patch 4/14 and submit it separately together with a
> new maintenance entry.
>
> I will not maintain any rust code. For 5/14, after I'll send my series,
> Viresh, can you submit 5/14 separately and create a separate entry in
> MAINTAINERS. Please make me a reviewer there.
>
> I'll think about details over the weekend and will submit everything
> early next week.

Thanks a lot Yury, that sounds very reasonable.

Cheers,
Miguel

