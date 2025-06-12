Return-Path: <linux-pm+bounces-28540-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E716AD6F80
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 13:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB1577AA641
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 11:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D681122333B;
	Thu, 12 Jun 2025 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4lWnG5u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB3A1442F4;
	Thu, 12 Jun 2025 11:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749729111; cv=none; b=EnibaDNu/IL3YTmHE4YDPpBeWH87naLe7XhoDMbAZAaMs4BLP/lvA4WkHQmvqIkIT1RRbTgzvdQC5qKSEXGc7I/Ks4Wz5IxCJAMVI0+z6qzh8eUiREI/4N4x3+V37lE7AECtOm/sVYSKNJOFtQJa5SFei+r8xJYJOi3K4GYMYIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749729111; c=relaxed/simple;
	bh=PdDzwXq5efcwhoojhVqsKxNYcVXXyqdpXYauJg8SHrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Szzdybs0vsksuC0dRtAhjKNktJcB4RX4sKkOx/xv30zgPKLUxWqmpEomsRHwfacerSEZVPUUqYp6QM5xZCxOUIv2NanUgV70xxXlVZZBuTGS4ABJb+6bLKYhRMJUHI5Paot4ICt6qwCWYuzK4kVzP7ZG5vL8/sE55i/NHrJd7oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4lWnG5u; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-313756c602fso131300a91.3;
        Thu, 12 Jun 2025 04:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749729109; x=1750333909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdDzwXq5efcwhoojhVqsKxNYcVXXyqdpXYauJg8SHrY=;
        b=Y4lWnG5uBtNIkztbKAfFPLgt48pJhuTTeWSItwuRC0UOM5QZ28isMsBUUihcOKoJ+g
         24/YMJruzU6xTA4tK19o4nuijOouQCsP7nfN/O5j2u5n9S4p4YcXNl8U18hccuMHjkeN
         gyGYlVd29CR6VQCGNmkje2UjcvwlyhEGYM/H8IjhWrbQBDKchkNwO4IKEI9hB6hB3NBK
         /UaAuI5VT4EWvHxb5/h9FnvckisUQGfZjyzg80WglRL6U3GPmV/nyQBLOw+zDK8PfkcO
         K96xyt4FRyLynerQGH22U9f74FmZHC+Sic4AFIZ/I7y+wrjAY99zT0PCqHlwI0sxungW
         gAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749729109; x=1750333909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdDzwXq5efcwhoojhVqsKxNYcVXXyqdpXYauJg8SHrY=;
        b=K7XUjl7qqTIaz/ahG7segNo9zMJ/2gBvPSaMa6zkWzgrAHimgeOyjXzwG1qDv/BAsT
         FeSfF/0P30/NLQ9L3CHu6VMMY0gaAU+216DE+9CtEXKlOplRu33y16zhFxL70kVsq/IV
         123lWzafA9Rmjs12zMdD1CzgzM+pH4GwwSRrr211UJqel1XEbYassaHuy8R0u26du890
         3PFKNkz28dzAFPXpDIWaJIXG6RYT6dTwDrWwwB1mfgFGyfPS78x137XzUsV+kC5SzIdx
         Q9MpdmuInceF4EVz1eu5Offm1P7fAXL28nf4Yg/P3YkRfNrnAln9VYB1o6Pxcdikwfrw
         vvng==
X-Forwarded-Encrypted: i=1; AJvYcCUFqFplsiuSMCgikXhbNv1Pw0PEKBbmM9dB8ibSfF/lFfNAE2/zmEfFj1JGQ3WkaI3VmsaTjzV94JBs1ek=@vger.kernel.org, AJvYcCUo8U0oGxfq0oJ7lcuzU/ItIeiAMaX82jKhAAiOzJN94KBIen14M12CiPb7WvVmiwlRx/CeIN7FDgVPa8Db6wQ=@vger.kernel.org, AJvYcCVFrgUHL3sWTYmjiPj4TEr4x35tSTZHX48I19bWmCrlC2hxrdKCgCZeOPZwh1063zeQgGxBgLlAA1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYfnfvANETjUoar1EmrczeNPQi4zaaJRIqaF3G1P/FDt++nBac
	qR8qnnZMNtKNgntOQWuwiO3bu/M29oXxZfalFPf/fIHBmay0Ki7eX8ZKXO1fPef2wHI4PNIXgDH
	QLmRGamWfSJnwwehTnp1QMzoNKVvg0HA=
X-Gm-Gg: ASbGncsbqytzDoClDt0tem3CT7osY/z5oG/7h5rZLtchFg8SLss9ihQkjY+plMOHQ1y
	21e/OiqMzF2yirhOXStry2OOZd0nYsQcmoI0ZG5eFIL75YV21JAmXapTSWl0X05LQXxa633o6BP
	u52Hyf/FJ2kge5CKUUgiLYVPSb2PkgxuzmIcdIVXc4cec=
X-Google-Smtp-Source: AGHT+IH7THszr02geeayihPmfwjMV6SGbVO16iehszdy4de7QDOCkC+RAYCpDksbfEQmD+yJ1XW+OU5DT6T8YKP/lfo=
X-Received: by 2002:a17:90b:3a86:b0:311:e8cc:4250 with SMTP id
 98e67ed59e1d1-313af235741mr3849605a91.3.1749729109591; Thu, 12 Jun 2025
 04:51:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612104253.10413-1-abhinav.ogl@gmail.com>
In-Reply-To: <20250612104253.10413-1-abhinav.ogl@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 12 Jun 2025 13:51:37 +0200
X-Gm-Features: AX0GCFuuEiFXuG9m5B4w8TQVGIVEkX8OwIZ3GxfOrh5kNvLiPuGk1EGTbyzD1mQ
Message-ID: <CANiq72kReki1=sbKhurkj-WVt47h4u=rz4Jn0RjmeB1wgPGtug@mail.gmail.com>
Subject: Re: [PATCH v2] rust : Update the bios_limit_callback to use the C FFI
 types #1170
To: Abhinav Ananthu <abhinav.ogl@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 12:43=E2=80=AFPM Abhinav Ananthu <abhinav.ogl@gmail=
.com> wrote:
>
> Update the `bios_limit_callback` function to use `c_int` and `c_uint` typ=
es,
> which match the C ABI for the corresponding callback function. These type=
s are
> imported from the prelude.
>
> This change ensures the Rust function signature exactly matches its expec=
ted
> C counterpart, avoiding potential issues with type mismatches in the FFI
> boundary.
>
> Reported-by: Miguel Ojeda <ojeda@kernel.org>
> Closes: https://lore.kernel.org/rust-for-linux/CANiq72=3DWpuGELzLbH-fxdOe=
Jy9fiDFwatz6ynERDh=3DHP2z2MBw@mail.gmail.com/.
> Signed-off-by: Abhinav Ananthu <abhinav.ogl@gmail.com>

This seems to be a duplicate email.

Cheers,
Miguel

