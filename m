Return-Path: <linux-pm+bounces-31210-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEADB0C493
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 14:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532EE5424B1
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 12:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998D52D6418;
	Mon, 21 Jul 2025 12:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjTTJYCm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304332D63F3;
	Mon, 21 Jul 2025 12:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102483; cv=none; b=NMRcY8G3y985wG36Ox8228emlqQv15riW0p3cQdXsYC3l6aM2gQcOtPXHNVWUPQj0u3ie/RmTas82V0zvqwBEUyEIQYqloagl6ZZU8GffHqvb2ACNHH1kgLgTT4CWmVE7Bs2VioFBe0IGNFqvjfDpT9c/4HOXYpGfmQc9/yYCh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102483; c=relaxed/simple;
	bh=Bq5VgfjTkqyHZmMsa4CuFn3fXsUBDjAcxmYxO2xVUQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6SKVCc1VJuQ8QStNszNLawe51ZC2jZhlkFwPiKdpW0DDlMNETS1xRzD2yKG9EugOGh8wKsQaLb17CwLAdo13B0COhWxmD90KRv5z7WK6ADBKrmXxLbvmyoQWTaL1z2COFCsGaSp1GFGIF9rACDiJDBr7T2CRZHKSo384GGjcUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjTTJYCm; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b34dde96cbfso242553a12.2;
        Mon, 21 Jul 2025 05:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753102481; x=1753707281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bq5VgfjTkqyHZmMsa4CuFn3fXsUBDjAcxmYxO2xVUQQ=;
        b=RjTTJYCmZ/NPbd2kt1bt168pUdPJ9FFWUggiAluPZaUwSno8aldNeim5NoYXnw7JLs
         +weY5AEIKikwhMpsYcCUUum8ZEyez1OFF3bykCAw8ZTcC87VDCXqZaTiWugoejrdIFx/
         tqjTcqdo6nRIQuqjIhDjBM8AsDaCzFbb4Iwz8zJXbN2ZsqOGe45AILWxmSUofKJPOeWZ
         u7e8IYfbrjrcoVB8ysxFpgS+fdqnwM5rRzNixGXX7FJMvv8NOz9wW190aGOxZfVA+MIC
         lofYLT9dJzGhxddq+bLGJpqGekjSt+oT3tFbSxEUVTPbv+0UcmIA5qQpipxEce49A8Fh
         eYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753102481; x=1753707281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bq5VgfjTkqyHZmMsa4CuFn3fXsUBDjAcxmYxO2xVUQQ=;
        b=JT2K6kQYGwrGD4NwutlrXribZ7Lgk9YzQvT0KdiupulbG4tJODtu4VdIA5/dR91gAC
         b4qFi3Q6Th60cUjBf6SCHGtDwcQAN+yWUjK6e7hz6rRzjYrNxdCYWLZ13A8rPEHMSU7H
         LTEo+NfjJhTemZ8gbvA1vjvZnbBXESnznyGz5WIPaGJqbZPzDu6M3dySl2elNfzPwtNe
         jDqO4CUaD0XjHGVpcZrFLedmU5nH5vppz8vkp+XZQQyUyRg4pjaRBA264dY5HMF1gPX3
         aU39r0FowLkNzWa7zPITxmTO47anZCVnRwdI4LAxfuXwnYkcF91V2sPY7RgpcKg0RrVi
         u6TA==
X-Forwarded-Encrypted: i=1; AJvYcCUMYpmBZ6tS19HodDEZnGseI3Hj++IBLnhOL0SCNaGeokAc+qeGGHxmC8fsztE8q4y+VfKw1m5QdU0TBvXn7pI=@vger.kernel.org, AJvYcCVzzjCI1jFSLdlIZUrIHYbAzWRY9CrxQFeGLgYPL6+gK2+dXqQ+Tb0z+yM1Ml/2yIL0YbZReIqwYahHPAo=@vger.kernel.org, AJvYcCX4z1i9mDeKgT/ECgKji/RH85W9DPHtXWic4Up3SGFqmzJ6tADOybwLMZNBsbl5zB0gw/a+b9wbe1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA3KnFRfq2qLB2GhP1qyuuHRt06DaSu1QW3gQMltXeb3MAys3F
	Pz4/vI2t1Xl0W48AOnErbCNfw/F9NfsHUTjyzVaFo/W846rDEA/ZP7p2rDeL5FMy7CqlJafVOUS
	nK3lnie4kmtHQyTFBlIPK48IxF1ko/fw=
X-Gm-Gg: ASbGncsUxJ+bS99blCsMhmOHfs0l1FTZfpixRybTeRXUsn1kh1jUHAue0qvkTKxVYzb
	Yxd2sT04emAye5I/saK959xinuaw37qghbwVQ/HDf9Qw3QbPA7iRprafNimTIw2v6xOmNatZlpx
	XZn9aVe5qONRY88dsa5tjOED3nGYomVC9D3FDFCS2q3uNqTLRiuJ55wF+Rqih+Yn0LUfkQQbUMO
	N9Nvb9MzRIC2B/BkZk=
X-Google-Smtp-Source: AGHT+IFI0uNUbtO1EL18MgqcISBuZun5VUryvqrsQhtAKtldt6P/mlWmjlPr/GgmBjbnB7SvG/K7ChJXEi849ooHmqA=
X-Received: by 2002:a17:90b:562c:b0:312:25dd:1c8a with SMTP id
 98e67ed59e1d1-31c9e6e8348mr11443694a91.2.1753102481364; Mon, 21 Jul 2025
 05:54:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com>
 <20250704-core-cstr-prepare-v1-1-a91524037783@gmail.com> <20250721073717.i6hr4iesfupzvtwf@vireshk-i7>
In-Reply-To: <20250721073717.i6hr4iesfupzvtwf@vireshk-i7>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 21 Jul 2025 14:54:29 +0200
X-Gm-Features: Ac12FXy9X7WoYLkMFLbQ__okKUv8h09D5Y5ZLeDybojK9NFQlmOXBw1vbHf4mSI
Message-ID: <CANiq72mZxcwDX2X3RfRpHzqkmU6GBVadKPLJYF03Hj14O2x4PA@mail.gmail.com>
Subject: Re: [PATCH 1/6] rust: kernel: remove `fmt!`, fix clippy::uninlined-format-args
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tamir Duberstein <tamird@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 9:37=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks Viresh -- I will add this one if I rebase, since Stephen
already solved a conflict with it (I should have pinged earlier I
guess, sorry; I thought you guys didn't Ack so far since it was
trivial, but thanks to you both for them).

Cheers,
Miguel

