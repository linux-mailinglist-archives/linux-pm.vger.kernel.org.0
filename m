Return-Path: <linux-pm+bounces-28483-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1AEAD5472
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 13:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CC3B17AA2E
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 11:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD502690EC;
	Wed, 11 Jun 2025 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZE12aPi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B651025BEF5;
	Wed, 11 Jun 2025 11:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749642416; cv=none; b=oZy2sk9nLGSgTVTUJzHtegiXO7JcDJqNIUNF3QzgXuvtp6Sz9fz/NfBnUIcCucqj+PbLkKeNP8eBHh2X7p9m/fpjtk/H9K80VBhvqAR4BTjrW5hgocdSahKafZju8sg6lEG/UKsTzwH5SesJ6zrCEkL6YIiZ7I+xk0SIsNHdWlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749642416; c=relaxed/simple;
	bh=1Vmq0G5G0jKDHDGJXI6e/ZacBmMDzC6HHXD4ZTz+mhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g6KViy6Xra+azBq8Hk/Sm33jRq2HybIxNg9/Yi2ZSQIve8YxzJjkN4xrTAsQYF1Nwg0HHc4rtqwr+3EpV5a+IL/3gM865zFFdGm1IyhnjHRgnrNdU1koMIP1zBTFGDk/kGTyj70w6WIVspbq76kjrNx3VOGVZWD3R6iR/rAcCA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZE12aPi; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-234a45e69c8so482135ad.2;
        Wed, 11 Jun 2025 04:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749642413; x=1750247213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjWqiBDm0nvwj9CkSqR8k0GoBN5tkJezIwfnIgfr1fE=;
        b=lZE12aPiurji4j4oPecweq2Wk3q/7W3cpMzxXUUsrGGnydAPpVyRrBA2JlxHTXLDKC
         jPdP+SPkmDqvwNGBMlpzNU8kvtrLkZB1A1/TUyBhKh5D3PBmMN2fQmvc2z+LSeJVlOhN
         vqTy3ox31b6Jr/LStjbGmKFGb0AO41qmxcvEhroLh506AeN590r6ExLoUcJy/BRAezVA
         YBfQceHHOI+piUEZpQJpkvop+YV6ZYYTmFyrob6T7/OzFXglFOMcT2xILPNHKkA/ILvD
         Eo8eEdRd2oWnU2L3E5cE0IfXdxXCkzXCUVcQKEsHWJ2+fzwG2W9XQrjYMLBpkbgEkSHd
         TdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749642413; x=1750247213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjWqiBDm0nvwj9CkSqR8k0GoBN5tkJezIwfnIgfr1fE=;
        b=U7sD8vdP600EcyBEqE9o6yhzN1phW4jRLBG5HC5dqh8TO1dK950/JQWG5HtXFkPsbY
         52g3/T+UVWPPBpQbTn6vSRg3sNjeA4GeLrZwXom14DtKXDbwemus4/rg7N5NOICip1ZJ
         xvJniem0TdO+WyFCU0qNnCraMJkfmkVuoDL0GwuCh3gDFVwatTlDY0DzUy4sN5fPgs0h
         q0P9+IFfm+lQrNZSqt1KvgShQLLa75/2UDhb4vJ4QyDpxz9nYXQw+deQkPyaw08ca02g
         O/680Y4VEiSdjGd05fDdO7WoygQz8nyHudtiDuQX/XpTUcwscJ8trINKPOcUlF2l1p0W
         cWew==
X-Forwarded-Encrypted: i=1; AJvYcCUNvH1dyzJA5yfgvgRws2OZTw4LprE7pfAgkz4vUYtp8LuWYHNKcS31wQnwd5kTINSb/H7nAsE8GSLhXEU=@vger.kernel.org, AJvYcCUff1ry4mqgnu3l0OaAC0PFgyuGJt1nW6hQu7YHGhFEwzECI6ixgmJ5F8ZhQ5uKCTrXH5AbYftzzz+3rkYL9EE=@vger.kernel.org, AJvYcCWIuX36vDwN/ndo0VmSwy1+s+kie2BwhgEpFtPZH7884fo3nRsy0R8KxDzAE1u4yMLcIsP5arnqmAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0BV0TYIVtPnz2S11V2UQFyiEZDghH7Fl/k1INtuvmM9cOmzbE
	Lnq8hlscdsJhy3gWlsZdFoku5nCsyJDDtSkruFkntdDw7Cg75vUZWE7jzQ33jW9jL0s2GscBHx/
	m8LijpmnKHEPWWIc46jWvNIsPsPwHx1E=
X-Gm-Gg: ASbGncsLYteOuawNw2PMJEyYbcrz882AEfhItAaH03LMEvAove9rmepf8sddQ2MxYxd
	Gm/nL4io9bHJBWbKA9i7oB3Ir5EK+pEdpQhgljrs91iWv30FqYvOombJ3qt1oYz1+zlAv2DxXKx
	04rWoTuxNAWjUoVhYCu+GGBnYzm1r33YKVjd/N5jTMTDI=
X-Google-Smtp-Source: AGHT+IEAkOiZNEkNpkBzHS7JLVKeGLFvXjY3JtxvmbIO55yJyWwHo+gCFBtPANQRLKT9IZ5Svvxp3Xsu3zCbP9CRHxo=
X-Received: by 2002:a17:903:1a6f:b0:234:bfe3:c4b8 with SMTP id
 d9443c01a7336-23641a8b1f2mr13819255ad.2.1749642412877; Wed, 11 Jun 2025
 04:46:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4823a58093c6dfa20df62b5c18da613621b9716e.1749554599.git.viresh.kumar@linaro.org>
In-Reply-To: <4823a58093c6dfa20df62b5c18da613621b9716e.1749554599.git.viresh.kumar@linaro.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 11 Jun 2025 13:46:40 +0200
X-Gm-Features: AX0GCFtUQb1VuES-5s_8BtAuzHpz1VaP_GiqWmmS9tyONSLXXcQH_X0BPBTkrdQ
Message-ID: <CANiq72mP7tGzZM_f2gRSVcBw5a5Y7vMM3eOSvuAOK=yJeEmFBg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Convert `/// SAFETY` lines to `# Safety` sections
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 1:23=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Replace `/// SAFETY` comments in doc comments with proper `# Safety`
> sections, as per rustdoc conventions.
>
> Also mark the C FFI callbacks as `unsafe` to correctly reflect their
> safety requirements.

+1 I guess the Clippy lint triggered when writing the section, right?

I think it would be nice to have a lint to catch this other case, i.e.
using `// SAFETY`, so opened:

    https://github.com/rust-lang/rust-clippy/issues/15033

I also found a possible false negative (or positive, depends) related
to this, so opened:

    https://github.com/rust-lang/rust-clippy/issues/15034

Cheers,
Miguel

