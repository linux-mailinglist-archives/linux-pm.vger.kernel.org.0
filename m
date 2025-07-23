Return-Path: <linux-pm+bounces-31332-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9763B0F182
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 13:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED7B567DFD
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 11:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333832E427C;
	Wed, 23 Jul 2025 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kir4eAkv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C5624EF7F;
	Wed, 23 Jul 2025 11:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753270923; cv=none; b=MiNP+dK797+aasuv3RHe4pdk9P/8NlRrBUvXzja3fO4A07tED03fI9sNY3cKPNmoOYbhQMGxjNstzxXCgMBw+CgoeB7ydDNShh/RQuUBF25LnPs8sbSo9K+iKM948u3I7T0OtugAG+vftVR5GodKwCG5nSHVBMDzW6ZgDFZYYFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753270923; c=relaxed/simple;
	bh=b4+JpyWmJ4gyhjTi3PjLOkjV2EixBKPcCAGOS2daMAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/p3/QR7C+ux2UFmdXkLU9cWUQPLjhqWReVxDx6+7NCS8/t52bAluYT1Phz6Us+Unz4xnOkd+fx6qRPKSl1QNyZNXOOMOhqfA5y2z2MF1hSelvkqc83LdMt3RetQlo+Xf/+q047vKmF6RO2ZXBNrURsjvtpF5jqATcxz0d8/xwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kir4eAkv; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-234b122f2feso7199335ad.0;
        Wed, 23 Jul 2025 04:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753270921; x=1753875721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4+JpyWmJ4gyhjTi3PjLOkjV2EixBKPcCAGOS2daMAs=;
        b=kir4eAkvML5yRxA0InX//8nR3DYAvSfKoFM2fTbXSWWP4bSbCUoKon4fqHyKMohKDC
         Q8TgCE9qadBABpFBiri37HYmvHpOlYfldgFZgpXQhvMVv8c6XX5Srwij/oY4Fo+DpToD
         dg0xp46Dgp+7wMlFqAxRXsZbrYk1/yMQCNsGGG1PJPq7vVkj9XUmesmDlyAsY9FYzVUK
         IfyBGC9SVi1yKS0pRwezxIgWH09vqhSIHQged4R7UgyK/8DY5NYC05n4zSg5WZTKSG79
         j9CShnDH5ZS0UUkqmX3Ak80ppmE3him9dYz+csBYdwDUbC053ToLABzbaw34o5kOuY02
         vTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753270921; x=1753875721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4+JpyWmJ4gyhjTi3PjLOkjV2EixBKPcCAGOS2daMAs=;
        b=M993PeyX7jJqqX1cxqJe5f6ZfthxsL022NBDJ/VEXtxYMLnMPhynrJros5TEmuSzA4
         p+LdtRtjQVldYT+sLVlSfr6ea9S6oexAfFdYTTd9xe6kwwjB8Np2USirdP5uP4QXQFbe
         ndYFYQXnjV2hFntHYFu93324H89z/kFbX/gnEr8qiyv6WMPns0JQVmqEDp+YHLFw/jvd
         9QNU7Mz2UwK0aLHCaGF1uphIt0p95aOwE7TZM+s17U54PYyuQq5nNajApNciPr+RtlJx
         EVJk+P1Tp5taSY2uL8ve5mxXUrlvHVmod/op0bK13JrtjjUDIvVGKOqsa4fSl3Ts1CgS
         +Jsw==
X-Forwarded-Encrypted: i=1; AJvYcCVtAquwPZ2+AErMon3pm2OPLQE917QBAS7u6WTmK3+dE98IyMoKXi1mzdKiviYWaA/BBy+FyYGGRaoGEN8=@vger.kernel.org, AJvYcCVvTdr+j9KZ16wg03Ydd7MlRrevvdLpEU+Od1PgN6vAG0oujWShFGP36LUAjO4BRtIYHYHzCE1HLVc=@vger.kernel.org, AJvYcCWntuMfWDJHQjo7Sl7Jv3802OdZPvDZ9M/Pb88yUgKvnbzjZHCDGpnVJHX3SMgHM0AQ/m779mllex291NzmQm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOa/xhutOchNNa6EcaGD9cEPSgdoBueic3kSez1KM5wKxaXObq
	VUOPL2x2OFW9X3J6tHWbogOzADyadnRyN9efI80C4CkksEopTk0/21yQZWDP3VNDX/6EBZCkhRb
	dWDUQxW90BJzGjEZ2pNHbE3fTWLhDvdE=
X-Gm-Gg: ASbGnctpnH9EZoTsYLF+BULxMVAgDmZoiQFZ2lu0icF2D2YO/fNwaPcH4P1ijzIrBek
	FnZ6fp0yseb/JDPbDe8fuksPa60IUiVM8cUkLVNol++BotMJfmNSxZ1uzEZJpqx4yOGy4wxXsWi
	/4Zp4OkQvVdhwJF4Sh1Np6pQjomv8s+ouokyEDrgMvENRmkjYPi71xO9N8yeZOoDPgxp62mA5Mi
	uiZqumc
X-Google-Smtp-Source: AGHT+IFAIU7z8S4SKEMGyp08QnGIL2qL+tO8L625xDKZYZ3pABXEZ3Y+KDTzzjOx7EH2bPNVzdnuWW7EgSkA2CPbEpU=
X-Received: by 2002:a17:902:d501:b0:234:c549:da0c with SMTP id
 d9443c01a7336-23f9807423fmr14898665ad.0.1753270920958; Wed, 23 Jul 2025
 04:42:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722-topic-icc_rs-v1-0-9da731c14603@oss.qualcomm.com>
 <20250722-topic-icc_rs-v1-1-9da731c14603@oss.qualcomm.com>
 <CANiq72nPLn+3V_DhN9_dmKnRrb5mfjzQ67Utz7HdtOY3McpweA@mail.gmail.com> <d80ebfbb-5fb5-4dde-a79b-adb22231a63e@oss.qualcomm.com>
In-Reply-To: <d80ebfbb-5fb5-4dde-a79b-adb22231a63e@oss.qualcomm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 23 Jul 2025 13:41:48 +0200
X-Gm-Features: Ac12FXwRgasah0PJ7l1KDqUvuz7UUzkAnjMt-dmXM1LLVfMFZAhk_I4S9uhbiUc
Message-ID: <CANiq72m8QZCAC4ouwTCvOE26gmoTSZ5fgc9uTw0pxkcNnX+4CA@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: Add initial interconnect framework abstractions
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Georgi Djakov <djakov@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 1:32=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> The C framework makes no effort to check for that, so panicking is at
> least something.. That said, what would you suggest to do here?

If you want to mimic the C side, then you will need to use one of the
non-panicking operations, such as e.g. `wrapping_mul()`.

Otherwise, you could make it a fallible method, i.e. return `Result`.

Otherwise, I think the panic should be documented in the docs of the
methods (because callers then really need to be careful).

Which option to takes depends a bit on the use case and what C
maintainers consider best for a particular operation.

For instance, sometimes people have used `build_assert!` because they
expect that the value is always known at compile-time (after
optimizations).

> I was debating that. icc_path represents the interconnect consumer part
> (i.e. used in device drivers that just need to toggle a bus endpoint),
> whereas the corresponding provider part (which manages said bus) is not
> yet abstracted.
>
> It would make logical sense to split these two.. with the latter going
> to icc_provider.rs, perhaps?

Ah, so I just meant that you could have the `icc_path` as a `mod
icc_path;`, and move it to its own file, rather than inline. Other
reorganizations makes sense, but I was only suggesting that :)

> No, it compiles fine here.. Strangely, I didn't get any warnings or
> errors with this patch. Maybe because the struct is pub and within the
> same file?

It likely happens if `CONFIG_INTERCONNECT` is not set, because then
the entire module above is gone.

> I almost wanna say `make rustfmt` produced slightly different results
> (one or two lines of difference) than make rust-analyzer + vscode
> extension.. hmm.. Perhaps PEBKAC..

In mainline we currently enforce that code is formatted with `make ...
rustfmt` (there is `make ... rustfmtcheck` to check, too), so if some
extension gives you different formatting, please double-check before
submitting the code.

Cheers,
Miguel

