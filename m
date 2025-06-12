Return-Path: <linux-pm+bounces-28531-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73062AD6C66
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 11:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 028BC3AB276
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 09:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FF222A4F0;
	Thu, 12 Jun 2025 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biS6vLlK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA781F583D;
	Thu, 12 Jun 2025 09:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749721129; cv=none; b=tgR71rFuNmILN9kJ6P2XhN4f6nZV06JOt/Y+a/CIkgPrQmfA9yARHX97Y0IRJSvpxMX2//ShndQ9zIsMqhcjE8Ublwcke7F2oChTMTX1TQgjRVXjlzc82Bu+NKudyO+1OkRzRed0fuSIC+dGfGR0tO/8Go/F3O+1vGUdp7Qig8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749721129; c=relaxed/simple;
	bh=v5GhzUrFc5S72xIR0qU5dk158HTvhJG0PwF8YU0COuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/T/kPx5Ca751pXNQ9uvoZHakVO3TtVFAmga7WzKM4O7Xu8FXZWMgoSqOhqLW5Ucw0qEBAEiv/Cn0k2YJBJNL8VNtPMKjK4YMXzs+TU8Gr8ZEmpefO99HjHxfy8CCES7g1Qx/HehzFRPiC9qxKiXuYo0SpbYeXlOth75efXaSx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biS6vLlK; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-313290ea247so122221a91.3;
        Thu, 12 Jun 2025 02:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749721127; x=1750325927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aylNlwJp9K9D8QsyZ96uoB7rAafx9TnuyqXX6P4eY/4=;
        b=biS6vLlK0ZZ/XwiS4qE/1WAqrX3KyzUHDPoOcDJ+uw9BKUcloMmxHthFRGiAIfk5Az
         FIlizj/N2JcudVM45zQ5P2RoF6epT/uY78lQ+W1aLQQtfyqHOI6FBsIW4ln0oWijEIPs
         F2aOGCU08cHj54QEUB6qBpFJyjiFYE8T5GIMFBWVS4R+te8qPq6+d+SbpsVVoxFk1NPT
         vIrUrMBRSGEfvOrVD39pp6MOieCzHgxJIkqgUlx5Df5KR4b650MN4sxkuAgAr+1NeU/E
         MHIPatdWzm0qyeV6I+8Jx1XOgBwxEbSVJK8layhc5U/A4r0IjijjTpPymYsuXLDLiv8b
         tLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749721127; x=1750325927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aylNlwJp9K9D8QsyZ96uoB7rAafx9TnuyqXX6P4eY/4=;
        b=q1LJwy65J5uUG8SOUqcmsI6orqUrAhgTG61b5pmtx+RvgNVKl2dtDiZTUettoFoIc5
         xVa6X9NRPmn6evoSXgojO/734e/w64/ofoQZLblGWDXMoXvNa6tmn7IHMZ03kYk3n80j
         yWW8+UPEHU3rGJJ1e4+hdixyLlra7gOYsLF6KaVJ1HQTkDhPUeeI3Zc2FFhkWHQOvzpY
         +gnD7RpCKim5F4BlS+9O9dD1juNTaedZVlCyJJYj1svI/Xq9V0qisQj5aeLK7YH7bB6V
         1qCey02LCz6o3lFZAmsfsdRxFeooJGU4ThrCIDyh26IwPh8n3IK+14A4TvTcnu/Xaux3
         W+Ug==
X-Forwarded-Encrypted: i=1; AJvYcCX0zOYZbFDoYO5Xt1p+7+nfndiF8fd0ZNPAi+weJdSh/ArDeOx9Jj0KRFTqCDnSNzXpCZbkNecdfsK/zDwgEjU=@vger.kernel.org, AJvYcCXVw3wtmk0lPtKkwvNQZV3UdWs2n4cojgXFN2m/rfC+DdsIM5Zngd+VQCndtTwzO1m+28MIhBsPmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzE69hpNMwfs95X0UdKnuE6GrwoN1nbheK7VToVDGhutt3+ThSS
	UnL7nlvkdwO4U0seL5W9FxrK0y7BsJ+JhMIwwp9JN3p3rf80IOt//MTn6GvoIG0ZSDqJsExzcg9
	2s82U77DpgBLI80foI/k6FMTtJqIf3vk=
X-Gm-Gg: ASbGnctycvsQwNC1FAJmmMMfqE+R7QaRi7jqvQJWjWLDHjGf5Q9Dpd/6AdJBkpQwto5
	d5XyRGMCDxykBDa5q24GpPNKKrz5aTkavs+7fMpPs5+YVigEk1PbFMhhDQu+SXN/Cz/hBW4veSW
	jx7PaRd8tJwDCkDKoJRG7dzgN35io6t9Jf+As5RlGlI2WeuMpaYYHo+g==
X-Google-Smtp-Source: AGHT+IHuG9iIemNFMRj9U8eukNK/ONK2Cfzx+xw/jHFhuOn4aUO2/0NrajLbC8xtUqJsm5AtKPXgkyRHeP3XDWoS9Ak=
X-Received: by 2002:a17:90b:2f8b:b0:313:14b5:2521 with SMTP id
 98e67ed59e1d1-313af1e1bfdmr3979868a91.5.1749721127304; Thu, 12 Jun 2025
 02:38:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DAKDXCX8JJVP.2MG7OCAEY73MR@kernel.org> <20250612084623.7410-1-abhinav.ogl@gmail.com>
In-Reply-To: <20250612084623.7410-1-abhinav.ogl@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 12 Jun 2025 11:38:35 +0200
X-Gm-Features: AX0GCFsQNPJsCalsngra6w9qU5_SqzteMjcyp6WB3g7SsaQa3NV4NSNg-ZiloL0
Message-ID: <CANiq72m6F6ROBA7JP+UF-vL4ezVksJkOMUuG+vDBrfSnTZFw1g@mail.gmail.com>
Subject: Re: [PATCHv2 rust-for-linux] fix : Update the bios_limit_callback to use
To: Abhinav Ananthu <abhinav.ogl@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 10:47=E2=80=AFAM Abhinav Ananthu <abhinav.ogl@gmail=
.com> wrote:
>
> PATCH(v1)
> Update the bios_limit_callback function to use C FFI-compatible types
> (kernel::ffi::c_int and kernel::ffi::c_uint) for its parameters and retur=
n
> value. This ensures ABI compatibility with the corresponding C callback
> signature.
>
> PATCH(v2)
> updated the `bios_limit_callback` function to use `c_int` and `c_uint` di=
rectly
> via the prelude instead of the fully-qualified `kernel::ffi::*` paths.
>
> Reported-by: Miguel Ojeda <ojeda@kernel.org>
> Closes: https://lore.kernel.org/rust-for-linux/CANiq72=3DWpuGELzLbH-fxdOe=
Jy9fiDFwatz6ynERDh=3DHP2z2MBw@mail.gmail.com/.
> Signed-off-by: Abhinav Ananthu <abhinav.ogl@gmail.com>

Cc'ing Viresh/Rafael/cpufreq, since this is on their subsystem (please
see the entry in the `MAINTAINERS` file for `rust/kernel/cpufreq.rs`).

Also, please note that the changelog goes below the `---` line. The
commit message (above the `---` line) should explain the "what" and
the "why" of the current proposed changes, not other versions.

Finally, the title would normally have been something like:

    [PATCH v2] rust: cpufreq: ...

Thanks for the patch!

Cheers,
Miguel

