Return-Path: <linux-pm+bounces-38935-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2DFC95509
	for <lists+linux-pm@lfdr.de>; Sun, 30 Nov 2025 22:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D30B4E0295
	for <lists+linux-pm@lfdr.de>; Sun, 30 Nov 2025 21:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C343B228CBC;
	Sun, 30 Nov 2025 21:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtevTFMt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549C4224AF7
	for <linux-pm@vger.kernel.org>; Sun, 30 Nov 2025 21:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764539792; cv=none; b=fQFK24y4t1uZ9CCR46iLczkTiVJkKezXQbJtLN5FMZTOwWXgt44ihbytVOMQKlwRAzZJmSZNT7hhKYupVDe69NWMiJGX4ok6DWvYQ4uXMd0/ldeqJvybgjOaehqSRZuWOlqXmN4oKp4mh37UngD18owaQImece63LC5j9zsDvPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764539792; c=relaxed/simple;
	bh=0AWMXTpdiaSDrpsOWQGoRWOIiHW/4SDcY2AtwQW5w6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=soYWKfxiTyOV5FPgbgczTeTJFxQYAQdfHdOtoPwOqzf4a0inwuEaYWc+9FX69qx+zE9ptFE0Ue7mgWbSuHhGjY0YxMN/B3bz9btGoVM4YM0ye5Kk1IQ/NVt7Q/4o5b7u4LG2hPrk/OvCorEeQSeUYCb6G7PPtXbHRQlDcQg71Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtevTFMt; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2960771ec71so7209535ad.0
        for <linux-pm@vger.kernel.org>; Sun, 30 Nov 2025 13:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764539791; x=1765144591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AWMXTpdiaSDrpsOWQGoRWOIiHW/4SDcY2AtwQW5w6s=;
        b=AtevTFMtAx1yjDgOd1/s199JDzLSO0KFXXIZSbOgnGc4pwYSkYcqqoppZxVV2Z7pg/
         iEq/3rpct22omOF1rXKvpCQN7oGnZbaBri1vnwKaOtzXqUvmbdvKYZPKOqwcQZahz2n0
         aIwTkGHqJGT2Tl5JAChvXAcrE8ESO5zlHDbZu3jjVBuxqPCG+bn+vjanilb2HyF1EK0y
         fO/5SBikW3B15bTiI51m2BwEM0cD7G2mIiUEwVAZ35VERUdLWVhCJ9lbse1tb/2G01ZB
         IQK7+yOHRliAnBXczuXVMwld39tuJHyov3Mjed0DgLamyQL6EjSz3J1bw5BLaV32kM+g
         k/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764539791; x=1765144591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0AWMXTpdiaSDrpsOWQGoRWOIiHW/4SDcY2AtwQW5w6s=;
        b=R0pVRWLegjyLbgl4fd3VaibKUC+0HxOQY4b8/U1qZx/8JIBy91LRGax2z1rQzCTazn
         sx1GrD3yI6ZP6xQsjXF+2J4XM8bCwYYN9z3z21J0LiyJVCcZDt+OFg0aE8pL7LAF+Erz
         MN6jHhDg+pNIcRb1ZVap3bEmiHyUQZhatEaa5cW2OvpG//8VHeqjIMGbJpB+jZC58Vwx
         YXLAaNMyaQTdfw2+PgO2leOqgPvRAq7VLg0U/Leycg8n06HTDGaKC1NhCkWBoxgMsY6W
         aLI/uP4yMpONMuXuoCNZ3vjvC1cjDzbR4pAuYbfU4Eo6YWxcpX0905gPDuY6LeYWNx7i
         aOrw==
X-Forwarded-Encrypted: i=1; AJvYcCWMQOrWK+qviZdrjzb/qLzwLrkaRlZIHCdPBelzW9y4Re8zlPW81pA30VLTelwzlk2rbeh13CMNFA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/wzO8Arbi/yuPMUkiV3663CpAwMy3IYnL/KaZZK8bh6VLQM9O
	WBOkHua9PoqM0Asn16ilesk/NlNu7ORn5nUnfM60jcXv6Om+VKhv9N5gw4DCAu3TrNrfE6AZLVM
	Fa5djmv4QVC+wzEcHK7cG81y6d6HWOsg=
X-Gm-Gg: ASbGnctzcdsvMtyE/PEyjiHscDOEYKYzJPFubspWBl8VJZYuNuIHiu2fDtH7hIoKtS8
	jGwEyEdxBkJ6eYdB2Dp5xkKyDBM8sr/QWQbsMpDPAICTIfj/9zQIP+h62uQ/NHJQgZrw9/Dw89u
	6wr75aYyWCqUbV7FGmMwLZWJd0zfpoL8JHd6zop33FnCCQQFI6sOCNC1k9EMQ4BrIlFcwCdU7ce
	h7xg1WpBuI7DeEhPLqMVNQLFFDHoVIZekkkdUiBh3HOgTKa+5GLG186BtaY5Diw9GhAKIsJ8Aik
	G58gRTuoTETpKR/OMR3McKSP3is4rJ7LsdqyajfVnFvAje1vUwnSUDkoj08Q1CDoW9GgDPjmHkO
	V2xZ7Ha2NPiwEsw==
X-Google-Smtp-Source: AGHT+IGxucqav7c0MkOoajiVWJV5pKABSTpRoQBW266I8BhqcOtWX0rHhW0PlmjPXgebUcKAK12BDaPgbDzz/dhUp4g=
X-Received: by 2002:a05:7300:ac82:b0:2a4:3593:2c0a with SMTP id
 5a478bee46e88-2a724c02369mr23764577eec.3.1764539790561; Sun, 30 Nov 2025
 13:56:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com>
 <20251128-io-build-assert-v2-1-a9ea9ce7d45d@nvidia.com> <db6a6b28-c0be-4bd8-a0b4-70431df7737a@nvidia.com>
In-Reply-To: <db6a6b28-c0be-4bd8-a0b4-70431df7737a@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 30 Nov 2025 22:56:18 +0100
X-Gm-Features: AWmQ_blGLwgs9jikCVQO65zGxLK14KMJ4M2hbsw_hQDynbiaD7OZLB0t04yjXSA
Message-ID: <CANiq72nGUuK9VTYJGob7pnXU5zuuCzqfw6fezAFpbqvte1sDFg@mail.gmail.com>
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

On Sun, Nov 30, 2025 at 10:44=E2=80=AFPM John Hubbard <jhubbard@nvidia.com>=
 wrote:
>
> Very interesting. So by adding a partially faulty build_assert!() call,
> these functions were actually wrong when they created! Maybe a Fixes:
> tag is warranted.

To clarify: it is the lack of optimization in certain configs (-Os,
CLIPPY=3D1...) as well as possibly certain code patterns that may
trigger it, not that the calls were faulty (note that `always` doesn't
guarantee it either anyway).

Daniel suggested Fixes in #0 -- if any of these trigger a build error
(like the `Bounded` one), then yeah. Cc: stable@ too.

Thanks!

Cheers,
Miguel

