Return-Path: <linux-pm+bounces-39325-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B08CAE92E
	for <lists+linux-pm@lfdr.de>; Tue, 09 Dec 2025 02:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1828302CB89
	for <lists+linux-pm@lfdr.de>; Tue,  9 Dec 2025 01:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B2A23D7F7;
	Tue,  9 Dec 2025 01:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byAVSqdt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DF120ED
	for <linux-pm@vger.kernel.org>; Tue,  9 Dec 2025 01:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765242129; cv=none; b=kSv200NAz4zV1I+EyXa7QTm+NojG8+l+mODIxUXRnkJxx+dfpiaCgMDKBw6jiKGKah3YCPgAL1WGSn5HKvlot/FPwySB1U8NZcAqCiGhjAM0VY+Nybbdhw/38AnmuJfQY0+tf6dsteH/dK3WLsVFwbVdGqcNPMcXiXPxJoeRyWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765242129; c=relaxed/simple;
	bh=uGDKEPLMykAWOcUlNHu4PNNG58YAB3acR8KWNtoonC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=epv3RVh907BA1K5uRnIQDDboQKR8/V4Do04jqYMorRXDg1+XZ/mQuzFb0JRMJEjVG/iUGIcWBAjGVbvST3mg3w6Pt7q8yrT8rVCcQn1pfs/us6xu2yAs1i7OpOAWPzrGTKUrJFAtiq2lRwVTTl8rBNoWD5HYrq+9ix4AYlV8GLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byAVSqdt; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-297f5278e5cso8477635ad.3
        for <linux-pm@vger.kernel.org>; Mon, 08 Dec 2025 17:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765242127; x=1765846927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGDKEPLMykAWOcUlNHu4PNNG58YAB3acR8KWNtoonC0=;
        b=byAVSqdtMQ9nrVS6QpEwAX6eH3lpYalHkUTfEoAnSlr9bXFTEftqFp7E16N2zzQDnO
         GdwytJmuzM1lac2lRtc2n2oXlfcH1sfDhAenNzfGESrMmiJFnHmQqW5DapD59Yir+jPV
         Ov/gPhXap6KFW2sEyjRTM+Z8rABH3ppzwfx0ZRNh7/6361BuF3risKfUM9hmBniPcB+0
         9NIlt4BZ07aOQx3Mb+s9S3wZbXQJJXvbYDKCSxAItynaPEvcpl8B02cG2iAkqAKvhlLZ
         GoBBGORaEmxmtoAuoU/CcQiCuJQ93F2CJ8D1dp/9S/rx+YyzpqIZsiQHtD6DWnvrcxdg
         jWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765242127; x=1765846927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uGDKEPLMykAWOcUlNHu4PNNG58YAB3acR8KWNtoonC0=;
        b=Jifw7RFLAT+KHIx7vZzBuv0j5pzYQgx9gUW4c2UPn7ZnGOMP1vPmsMrwOyoMSu0HZz
         OFqtUreKYGmCygi8I0vrXv4eQk1j28QZguZ3mLxUkcbSWCwlmr6BHq/8m/e3WiEq0F7g
         jestiYfr7FIuAwnv/12EawWX3XKEaersnKFO4d6wRAF7wbfdd67NRLUp4jW/F6GxEUxd
         e7uN9uhIbituRXm4PqCDr6kn0hf54NJQOr7J0XLfUhy4I7VNjJymxQQ5QNop2tefov5x
         Qd2o4guV4upMen3DyZmlH3FVS6dovpDSpTcFL+wD9U/FObccKX0Sy6Y9lCiyb3GmBTwq
         K9Lw==
X-Forwarded-Encrypted: i=1; AJvYcCXBNrrTJuYTluWVXYms0TNghdxX/kygVOYf3NV8O2EC1pSDMu9h6hOTM9t9AIyeGT2Gu4/E/S5O0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNZIBC9h+JePk88wRJi+tPNeD3f5ZHTw8OTDL6VGd5a7941xKP
	CuLMzRL2yHkNfNDHIfQZQj8SGNSVvyqOzvoQ3LMYrj7kd0ew6JL0qb0LWgNhbm8FrtWxcZdxZpM
	RILhnaLlG9wLeOOOcL79Jky0MWSR7AN4=
X-Gm-Gg: ASbGncu2IHHWlkmESnlg0b0iyqihbpeVu7UOggtFx4YFS3ty5/QgjUM2pcACurOtcxB
	Ll/yl/EqxYB/4XCUSpBkMUhyp6ZGRopNXCNgYf0+n4HMNf3kwal3MSavSarxfGJlzdAv/seUOgb
	hgbJsPTijilKCNBfqCRkwxAa1IcEbwyk1ioNfVpdF0Ekd/zF88WsCfbJgZ0mLBOcxEG6e87TnBe
	+LFikvJBFdX8129URoJxze6lcG8RrAssgK3aLTT63OFlneKGOMSec44Ka7vIWdugD/FsgPeMix7
	yCOQQUspmz9BKdKmJCBL8ArCcacUlgJPFUumsVLViqIpcK/uH0R8yTc9mO8J541FyNulwdQf3VL
	Wu7beqltTC+uL
X-Google-Smtp-Source: AGHT+IFrO5rf8fm5a9jJFe7v3vjVPwVESbCkXsoFTsGXBEpHYY8KdvibjzeUj8jNBuYb3/OZTmby9/KV/YRy3eFlwR8=
X-Received: by 2002:a05:7300:b0aa:b0:2ab:ca55:89cb with SMTP id
 5a478bee46e88-2abca55980emr2194053eec.6.1765242127202; Mon, 08 Dec 2025
 17:02:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com>
 <20251208-io-build-assert-v3-3-98aded02c1ea@nvidia.com> <20251208135521.5d1dd7f6.gary@garyguo.net>
In-Reply-To: <20251208135521.5d1dd7f6.gary@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Dec 2025 02:01:53 +0100
X-Gm-Features: AQt7F2pcCQwCzQQDDMpHjtqZugmca2-gRsmgHNhTBVCuGzfGkmQoYCkGIWj-Dlc
Message-ID: <CANiq72ksg4Ad8vk1tjH-fVAhUQUcRpuzR2cogKnGHPTax-fc9Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] rust: cpufreq: always inline functions using
 build_assert with arguments
To: Gary Guo <gary@garyguo.net>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025 at 2:55=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> ? If so, I can send a patch that adds this feature.

Sounds like `consteval` in C++20, which is useful from time to time.

If we add it, then the attribute form may make a bit more "sense"
conceptually (and we already also added the `export` one).

Cheers,
Miguel

