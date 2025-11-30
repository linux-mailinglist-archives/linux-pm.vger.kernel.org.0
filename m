Return-Path: <linux-pm+bounces-38937-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6E0C95585
	for <lists+linux-pm@lfdr.de>; Sun, 30 Nov 2025 23:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0694F3A192C
	for <lists+linux-pm@lfdr.de>; Sun, 30 Nov 2025 22:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D66246788;
	Sun, 30 Nov 2025 22:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2Qdm3Uv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5CA23AB98
	for <linux-pm@vger.kernel.org>; Sun, 30 Nov 2025 22:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764542576; cv=none; b=syCjVOeVYiWOeOiAs4g3zxmD+2nSiWAIYQppjlvDDdtSV3Tm23jjUK+auJCsy1LpjNU8dfEtr7/iwbRSsiixgdIONVa6SQG5xXaGeqazX5oNvu9lsjbSygFj+wBgDQLenkU7/d0C/wSYNO0UJkvx7g0s1rqgh99oDR9WikmxPWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764542576; c=relaxed/simple;
	bh=HcZEsjG65+yGMetX0Zj+M1YtSmKxm1zYnDNrk90J+K4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KR3CmcRs8OEOu1SVVrNvHmTRhc1hl9GE8bAf06tDgrPdDiFVFNobvbfYQSMBkDQqIvHfy9TgTZ3uGJBBO88pwtvtQf5TktsUOJMWfxeVi0vpLbBUBVCCnU6iWUXHnSWHZu704rdzRM+sLLl//keBk1qNVQ1mVuICTogoEX/2EQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2Qdm3Uv; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29800ac4ef3so9562165ad.1
        for <linux-pm@vger.kernel.org>; Sun, 30 Nov 2025 14:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764542574; x=1765147374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcZEsjG65+yGMetX0Zj+M1YtSmKxm1zYnDNrk90J+K4=;
        b=J2Qdm3UvvWcNiXqpHemOcFqvipW62EEIAy2V5gFzHvAzJ4JWuyCmL9qnzz+lcsHWWI
         DMkvLm5n70PAoZm5HFk4xsT8JhUlrS0uz8SF9QUnNoP/8jomdEMZSVUnpIM8U/1lCZyy
         ZtOLvbCWgJz8KnfuDhVF8h7SGN+CcVegxj5fgcXDHZZAWu6Xu6c2+8COyJc3Ty+punbt
         srjzgc2QUGryFx39oD/aRrOH93mTIkvfdNHatFCe0L0Usm559Cw3qu2N/larcfhz5fWK
         Dj3Lea1icZpn4oLQ4aXlf+/bpEoylGbQE0PA1KnLRPaT+9xXgKVJDp2PP7oz5YzOHfTy
         GKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764542574; x=1765147374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HcZEsjG65+yGMetX0Zj+M1YtSmKxm1zYnDNrk90J+K4=;
        b=M96zaPDbjbeMhb78Fw5+BHKicubv2vigj2Y0TJEU68pGxSujxeX/si9/REZ7mI3SAM
         z4dy37sLxdWmE9yJDX9PZl3dB0bS894KnUOeqNReZCxtOZ5sE+9KoBUZj6YwAWpNEmwu
         5HCBMCtXWYYeX6XeMF4AFzLx4amH9YbsQc3FSdqvxwz08axUr7OsDOy+9ZT6kWZ5FbML
         DQ7Ym3DaWGo9sLBuigfaQzrNWsLW/AyV/eMATUNvbzxd57sx29NkwQ0EEroklZQT2zzk
         2MVzQUO7rF1Mxw3IF5BsoO18KcXlba3tcQSrIWoA1XN2wZClzr72C+S2Op1sAcFezdik
         tk5w==
X-Forwarded-Encrypted: i=1; AJvYcCX6DuYhLVRmStJwJLkKPMhKbLPMFRSh7/d8zJhTRwjjVtyurFGzOz8znmiU7YTlZEibwUSCGYx+wA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu80l974ZBqnoH9cMdoZ3XNR76T/Z1rm9CmpeJHbcOeLV8LB/x
	LjWAjDEhjU8mED+FqrWU+3Xso0/2oIf9jHdnSro58U5Kp8G6NZ2s1XECmq9AO73oHDmr11eV5Jq
	L29BAidByCXe8hRZzSQegZEEonj1f7VQ=
X-Gm-Gg: ASbGnct2A4NjXNokGGHf/K2T6EZgGyzitW3/Qt+yqE/WPk86EE5jpHXFsKyIxvAt5H4
	4uoW1Q1TGa1H4Bb3gAIuUkFh29U3wcO/rfD2KpDBWCvVG+3w7djwYHbP7QUbFjIXMHcOOgFGei4
	OjuDjac2ffQuc10H7gA2sNWSwPsF6oQY17bresYEiQDncylFBUyqq58Q7gbLDm4qJ65+GyBPiQj
	wR6DvuOR0e8/kOBSY2l/wj0zdhqTQf6F+Avk6BQiYIqfvqfqH0eVQ51u822k+91FIAceaHQXjAE
	h9ZlGTknchao/v1vxt31EMn2soloTxOBcqg82BFF5jI/Kx5IB/6Ruw1s7zBZvI/7J55QrGIXDpk
	sXvbYd1f8nel1oQ==
X-Google-Smtp-Source: AGHT+IHBGd+2vzlTZsau2QokhF/IkqB6hHbgHqn950T+l/SVi3sOaZJ6kcggPwucnCYRE2cxkq5mSzjCakwfION2s5Q=
X-Received: by 2002:a05:7301:e24:b0:2a4:3593:2c07 with SMTP id
 5a478bee46e88-2a7243ec7b9mr20206056eec.0.1764542574091; Sun, 30 Nov 2025
 14:42:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com>
 <20251128-io-build-assert-v2-1-a9ea9ce7d45d@nvidia.com> <db6a6b28-c0be-4bd8-a0b4-70431df7737a@nvidia.com>
 <CANiq72nGUuK9VTYJGob7pnXU5zuuCzqfw6fezAFpbqvte1sDFg@mail.gmail.com> <46b5eef7-2e8d-4801-93d0-6cea10f62dc9@nvidia.com>
In-Reply-To: <46b5eef7-2e8d-4801-93d0-6cea10f62dc9@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 30 Nov 2025 23:42:41 +0100
X-Gm-Features: AWmQ_bmQFx95A3T-2iwjutvbpyVPYU1hJ59utd8H9Qu-WWRt5GFpLBBIhJuMARY
Message-ID: <CANiq72mhXajwj7HjiW_HQq9nO4o-HwBFUya3wjT8pRkWx3xjZw@mail.gmail.com>
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

On Sun, Nov 30, 2025 at 11:01=E2=80=AFPM John Hubbard <jhubbard@nvidia.com>=
 wrote:
>
> It seems pretty clear that if one writes a *build* assertion about
> a function argument, then that is just conceptually wrong unless it
> is inlined. Because it can only really be a run-time assertion.
>
> This is what Alex pointed out, and looking at the code I agree.

No, the function here was already inline.

What Alexandre wrote, which is correct, is that the fix is about
asking for *more* inlining.

The build assertion itself is fine. What is "wrong" is that the
inlining wasn't enough.

Nevertheless, it is (or at least some of these are) definitely a "fix"
in the sense that it did fix cases we hit where the inlining wasn't
enough, like Clippy ones which may change codegen (which in turn is
why we say it cannot be used in "production" kernel builds:
https://github.com/rust-lang/rust-clippy/pull/8037 -- back then it
disabled MIR optimizations).

Cheers,
Miguel

