Return-Path: <linux-pm+bounces-39056-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 563D1C9B0C3
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 11:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E93EF3A4420
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 10:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5A130E0E7;
	Tue,  2 Dec 2025 10:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ic6jN//l"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C91530C619
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 10:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764670505; cv=none; b=tHeUUdkvw++3+tgrvAH+0i4zU/FQxBy6LS3cd1DaiVWguaXpIYQ8+hT2dobqGcK29jH7SOvLnLN8VbKjzNGhbEkvYIVrac+O3dkZ4a70GxLcWm7vMKqd/BewiSw/3c3ERhc/25UAKDExsdQa5+JO/kd04/x97+H5/2G3xe9kfeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764670505; c=relaxed/simple;
	bh=tluCUMdbZtzI70MpMNxT6XbTimg3FvfG4a7kkBpBftI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SoTzV8dYGgK+MeMSB9HOoVFhNLk0o+unTo/qzdXGlmOGe5XT8lta8JN8/J+02Vobw5jx6R2NbqWcq0Ezqg/sDWKv4kWnzVgEhrD+pCYzEtw5cGknK3DYziqzm6mKKM+djYEGyWrsKhEyz6getbvPKGptLv8YUV8OhBjvuRpML/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ic6jN//l; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso33661355e9.2
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 02:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764670502; x=1765275302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xj/gqbMEvC2U1EurKb6UYz7u2S6QJAk3SBUPxA7BZ0k=;
        b=Ic6jN//l6u8CV3nf+ShALrI0NZPtmGhd0SF3XhXrm/DTRp/WvCFHYh34Tno3H7KAx1
         XgA8LnPNy702J4zs5sVyBYfa8lu1nfLjnO1HZEYddbPvEueMLzH+XLTTUWmNSWjKGC0+
         82bYaK5fMvbS87p+Jv8W95K88InGGZxULVgWgJ+C+C/xDihbtGaUPE91swFviLk/LV1B
         18U7y9MaY9GYMwO6KbfyfHZQAaQsY0MOc03eo6ywxw3muSOln2Ac6KAwuAkbjgbJRVK3
         tEnbld4TVL5wfTDupW1vBMC04x4pcNq4Y7L8oxt+cSVyre7JZQVRF8MlQ8+6Wpe6VVey
         u9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764670502; x=1765275302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xj/gqbMEvC2U1EurKb6UYz7u2S6QJAk3SBUPxA7BZ0k=;
        b=EXWUJy/1FgZ32D5SYQguFXBd9dVZ5nzWVs/E895qTY6T7htyZAsdqbSTg3JHgWtnZG
         ESQsvgCk2PJIb+yPxTTOSgWRjImpFCIenFN4rntGyOqRSpe46rqZmN8rC7dx0xUPtGkf
         yPs16FJduRQovbmy+chIJM5scO9n0meeZOyEK1gyWJgsav0HO7yeba6zd0jJazwo6SlC
         0D7Jt3UkDaBnDwI5F3oGglaZEeLJYwdNRG3n6H8o/g5yTn72R4mu3RPDcPwpXpSKjOhK
         TqkyaQDnzDJnb/nDqDzqOhpePuutGKkEYUPk3WoJkJNAcV16/ujIh14ve02P3ZSsnX/P
         jWRw==
X-Forwarded-Encrypted: i=1; AJvYcCWexEvJ/heWaP1S+Zj4E25qi4YpJjryDXGwCBEADBE98gcEoct0CG3lI8t3qKKD3Ph8YDwBro7A1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YytiiBvZQ48P1H25JpVnXo2TbDupsDMm5c4EPeRA1dbQa0fp7Sr
	bXhd5uh+GST1GwzdZGYU4JP42+QZtM9rgV5CQTD9WB9LtwuvEoM5Bs4Hh7WotpFFlaUwnq8jxJs
	8ZPNbsrziFpDrQ3HrBlA14PQFr8WIczwQOl86zkRE
X-Gm-Gg: ASbGnct1Z7p/3gBoeEithgAGLi4KKYbOFYsk7h3Aduslrgt5ZP1uqZypsZVEoD/n57W
	PMXMmCbV5sNGe0WBf1hap/EA6kcnScrWiGlQfMlTWt+gxPYhPW5128H6eUowOC6tMWbKYI7yHSI
	dqaLE0Ql/dxgeRX+Tl1CJCEbfqfv6lkFc+KXZAHHH/lVEjupvgDa4Qo4CBXAM3bQrHvBQs5Uykt
	Nyjh2evx4voVO/d8bYhD8OqPIHr/a8aflGSm44t4qdzMzMTdx1JZa3E4OFPTshbw8ENxxKQTLXC
	YLvzMs2uKieASuNsF64GG9RfjjoObQVoyhBCteLIkOMYXRWE3EqLbuKPqQ==
X-Google-Smtp-Source: AGHT+IH41ppbKo2ntsTFFVkqDJyv15OsfwqRLDbKCfbp32OEMtJv+7r8A3+XIAbI1BpBDvsTQpoln+8HEetvbhddqzA=
X-Received: by 2002:a5d:64e6:0:b0:42b:36f4:cd20 with SMTP id
 ffacd0b85a97d-42cc1d2e292mr45860682f8f.27.1764670501670; Tue, 02 Dec 2025
 02:15:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com>
 <20251128-io-build-assert-v2-2-a9ea9ce7d45d@nvidia.com> <af76b544-a7ee-43da-878f-cadc1599d7f0@nvidia.com>
In-Reply-To: <af76b544-a7ee-43da-878f-cadc1599d7f0@nvidia.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 2 Dec 2025 11:14:47 +0100
X-Gm-Features: AWmQ_bncCycjJtLo57Ks_3lnLDfKrcsh2eIAuKqvMlje8DUUWqYWLDIlb5gTms8
Message-ID: <CAH5fLgjNXcWgCLp=GkOiycPtcR9dpSn-wZ0HK6YnQC9z+dWyTw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] rust: io: always inline functions using
 build_assert with arguments
To: Edwin Peer <epeer@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 9:07=E2=80=AFPM Edwin Peer <epeer@nvidia.com> wrote:
>
>
> On 11/27/25 18:11, Alexandre Courbot wrote:
> > diff --git a/rust/kernel/io/resource.rs b/rust/kernel/io/resource.rs
> > index bea3ee0ed87b..d9851923562c 100644
> > --- a/rust/kernel/io/resource.rs
> > +++ b/rust/kernel/io/resource.rs
> > @@ -223,6 +223,8 @@ impl Flags {
> >      /// Resource represents a memory region that must be ioremaped usi=
ng `ioremap_np`.
> >      pub const IORESOURCE_MEM_NONPOSTED: Flags =3D Flags::new(bindings:=
:IORESOURCE_MEM_NONPOSTED);
> >
> > +    // Always inline to optimize out error path of `build_assert`.
> > +    #[inline(always)]
> >      const fn new(value: u32) -> Self {
>
> Does the build_assert problem actually manifest for const functions?

Yes, the const marker only allows you to call it from const context.
It does not change behavior when it is called from non-const context.

Alice

