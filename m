Return-Path: <linux-pm+bounces-31320-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CD5B0EFA8
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 12:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337AE3A49CA
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jul 2025 10:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F9D28B50B;
	Wed, 23 Jul 2025 10:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnUunGsB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF5F28A706;
	Wed, 23 Jul 2025 10:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753266176; cv=none; b=E8bbJ831xr2NaDGXWHMFkWPSZOtKPpQULl479nv2sQ4s+BoE5R1+5oglhOncwukUS5+G47GkQubNfI0Wi3D6puJaN4pyw0ibQy6Oriqn5Zl2GuKE4QNfGT4Ety/BKDiEgmDmpJ1FQwX67nqqHqHOdWLi5cFSu8Zv4PB5xQT1rBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753266176; c=relaxed/simple;
	bh=Bfx76TzIghN5u+qtfFanMhMreHrl+v998hIMT1LtYtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LnsuW76xrbLEeeyKarEeYd154tUoXNtzGsPnZWvASzWN5rK/Jq7mI65aWsD0jwWhqvdFAu05IjoWaUEYdu1QlimfWp9/zDEf5FPiwlXj/DGlIcqu3MOI6cebpAWAhh1ZreAa+3gPEh+cEZ+o966JHJ5zghkTQXWMQqMPHnSQHDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnUunGsB; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-312efc384fcso304148a91.3;
        Wed, 23 Jul 2025 03:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753266174; x=1753870974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bfx76TzIghN5u+qtfFanMhMreHrl+v998hIMT1LtYtY=;
        b=SnUunGsBSQ3xVZtDwOq7DhkgWnOcE2yEdNovOQsx5uDKQSNFBBPSzDn/aLyxV8qUwh
         Bjem6d2NA925+sD5FIzk49URh1iQynIcuvMOQvO0UivWYlO4VG3P6ljS3Mp369AWCKI9
         zRjxZCXKh9iXUuDJIszS7FaiMW8nRf5BxHSraf6BMXdC8wNUVmnriyzPgt0IMTA3KM2d
         OCuH0Vdj44UUK0Wt4ECLRiuZFW83i1JO/hA1mmmze9RHSSP0UsTqRuI0OcKf3TzZIzt8
         Tflp9E2OSPf3yPcoA93PHSHgtXYcILpGprMckPBZrXz0JM5gr9UYgzf3fLqOgu7nihRS
         5blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753266174; x=1753870974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bfx76TzIghN5u+qtfFanMhMreHrl+v998hIMT1LtYtY=;
        b=uEuRY1wFWujKuHtgAeoRfAOMdQHxAs/Och6q1vrRmPqyYi0Cu4GEEs4dyqbD3N//7i
         6INiLTGrzd/kL12RHsQCzhatb7luSNk238dALjDNAayp6xzY4LIaa08utyiL5+5t54Qg
         9nFmBwOez/uc+LXzJ2FFNsZqoFtQb4t0uzG9cV22oZugCwOrnoU3XuzT0tdL8czGYRHh
         ZLoej795qS5s44zHnZHbd0i7GWx+nVN0To5ToFhCpLjqAxJQKTkU+z//k8WgdUC4fVC2
         m8OApwD7IeqDbRYhv0yoEuKJDC43UUzMKBYNDgTufMgvEsTzmGG5D2kaXPSCYNhCGbCH
         gwZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOtcbqiqZzawW/zY6ShJ6rPSU/xN7apBKKTDIeTe431Br2RB04fiL8GdQKgSBVhZTb7KWM/4ftxqR3SL+GwLw=@vger.kernel.org, AJvYcCW61yiD6jKI/sfdad9tVlhMXbb76JyfFAw9MQPtmsc7DAxJ9GAmSz3SiDm2z+SGaXTRzN5IankPHDU=@vger.kernel.org, AJvYcCWAZinCLX0lahdFfTnfy/xyCXVSbOmaGGirYfzhrtAEnxawqqkRw+a6w+lML9mqySiwjfNac3yVjRMVxf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxztQb0yxctmPIQzPJW/Lm8Ss3exQQ1M2/TKrUNl87PIBDSbw48
	8bSoqc1z8SImfbN+BjPQ5zTHkXrPNr3mhMiPUgB6oBh8c+v3QSwsv9ZCgNzYH6LhPeQxxDEV9pO
	FNm1NrYHsefHNIIY8D0aWltDGoOvzrEo=
X-Gm-Gg: ASbGncsW5LNUWeBT2LkN/wSL1Cl/wCOUlsKTxfTfC5PSsZ1Kc9sok0IfBeifgNxHMyK
	m3jkzdVgtAEgPDwF8lsdAT2f7TIo2V+Dyk7jJIdF5RAQjmjWcyGLvWG8uGoFpd0blTiqlfGEELS
	NuW2/8kf5oJqhogJAGGe/FUZTkA2P0tbMM25hLSdTqtralGBE3d1inDbcSMXbXy9hKPD9dxsjUT
	DGXzaoH
X-Google-Smtp-Source: AGHT+IFi6YW4dYbxSTyxUF0XmLqEjSwekl8kW2Ctm7AWzZEoUFjLYSBfJlYB0wSz623jmdDt3hYkJgZn1duQNrEVjFw=
X-Received: by 2002:a17:90b:4d08:b0:310:cf92:7899 with SMTP id
 98e67ed59e1d1-31e50812d7cmr1562432a91.3.1753266173942; Wed, 23 Jul 2025
 03:22:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722-topic-icc_rs-v1-0-9da731c14603@oss.qualcomm.com>
In-Reply-To: <20250722-topic-icc_rs-v1-0-9da731c14603@oss.qualcomm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 23 Jul 2025 12:22:40 +0200
X-Gm-Features: Ac12FXwI7UlrHyralsnPXb4_3WAFplt92eODvFMDKQ-62apnp249DejCbkOTgLg
Message-ID: <CANiq72kxcEywL4L6HEqn7AZa-jOBsw08jr+Kvjdwrd+iTOO_uQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add initial interconnect (icc_path) Rust abstractions
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Georgi Djakov <djakov@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 11:14=E2=80=AFPM Konrad Dybcio <konradybcio@kernel.=
org> wrote:
>
> icc_path is in essence very similar to `struct clk`, so the newly
> propsed bindings are understandably based on the corresponding
> common_clk module.
> This is the interconnect consumer part, with the corresponding ICC
> provider changes coming in some near future.
>
> I attached a sample driver making use of these, to ease any testing
> or CI work (as the title says, please don't merge it though).

Thanks!

The usual two main questions for new abstractions are whether the
maintainers of the C side want to see this happen (and how will it be
maintained etc.) and what users of the abstractions are expected
upstream.

For the first part, some subsystems prefer to maintain it themselves,
others prefer to have someone else lead a separate sub-entry in
`MAINTAINERS` (e.g. "... [RUST]"), possibly with its own branch too.

Cheers,
Miguel

