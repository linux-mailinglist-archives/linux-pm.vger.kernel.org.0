Return-Path: <linux-pm+bounces-28352-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75537AD331F
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 12:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6062A188D9B2
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 10:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAA928D8EE;
	Tue, 10 Jun 2025 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuYN9NRO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4166928D846;
	Tue, 10 Jun 2025 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749549829; cv=none; b=lIBSQ6b9drLQOOh+y9+kFJHSlHoW0Lrq95JJSQlSFAeOEgknw5EDZSbcujMaYDc8/QZKqkMIqmfLV7MMEpXOgqGaUATcnW+gQ/TpLcYRE0VlA7Xn55LBDYlGnO7BAe3y5b5yh+TUEvmkKQh+50TRhSinEBOqrRMB5h0apbEYTDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749549829; c=relaxed/simple;
	bh=tTJU7HrJ6ej1SJiEBa65fcjJmrmv7m2MmkFfBg64efA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fROtrsRhlQaewhO77SG5nTUqUWUtlyYUdt5FTAIXP83JUycTgrb+g5DeRXgXgs0uIMbsaiWW1Pyxd+xwtSefV7bsPGoDr3P2UyeOH3gQmPxvUOMiZ5NKoQMno8ySwAxi3vb672ktiD58Joged6gyn/FqrFzCJ0kLWop91Y0E3fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuYN9NRO; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-312efc384fcso859471a91.3;
        Tue, 10 Jun 2025 03:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749549827; x=1750154627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTJU7HrJ6ej1SJiEBa65fcjJmrmv7m2MmkFfBg64efA=;
        b=iuYN9NROnkrvqiukRaLZzmMGw3SG8EpoZx7/2xMajexsK081IAVyvpMONa4yDeRAuJ
         xuM16zcgAv2KKl36Mz56IHVJQKhf2/uDssK+8AKtRz+FSikjo87oK0KkNd6ByhGZoztA
         n7+egwwQcxnfNATmz0j/7ARZLI1PtJnguVAW8nzHhYONdfSRKNGoZTd31FfQjinljT9X
         BKCXRP3ZpjibX06JuFDh3yEQB2qS8IfmCw8oG0B9OdDzN+2n+9tkjhcLrRRtV79pkDC7
         d7PYOafd7BkaAEZhV/75xfMIMZVvLfns0Krbon0E0XvQ2wEnA5XCc06qIItS6/Yuu+j9
         kJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749549827; x=1750154627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTJU7HrJ6ej1SJiEBa65fcjJmrmv7m2MmkFfBg64efA=;
        b=wsBrPFOaZly8nsE3Gb6YmX24Au2W0QZ5Qs4pTCWk42ZXsyqUHYqaDPjU+mWGfsC2u1
         OjOWzVUAgKDhAt7jN6LfaC9tjy/QOulppVKpo600y52fgqtWdMGu19VcEyksyvdyQHyQ
         SpE6dUHpZypKAzpal2naGfP6baBvpRFoQ/LHqvylkld4HGpSH3KF0mg0PywRVZcFPq9x
         TDy6RBirz5hQthB7Aqww5JHMX8MdV4Iol3Z+2JPFeXwvTbF5YXkbNaaQ//ZQSKqzvvtU
         CuCoKlNBW+H9rvGG8/wl/C9iuydX0Lq/BQmAuGXO9Y0tUEeeMJADZJaRETfw7MVSFhwW
         6VlA==
X-Forwarded-Encrypted: i=1; AJvYcCUIrzDwIC45/IRIoCr907Yhi1um6ohyrbdJUOGKwfARlQ3/CQmDvLf2nG4oJtpJb9IV04mdutvVV2U=@vger.kernel.org, AJvYcCWaBgta+NXxfzytGGWnXHU1uFt8WXKic1qS+zOWHoC5LtxS0YJv7s1wcqGuCeQZ21R6t3mEtpzwJif5cBM=@vger.kernel.org, AJvYcCX0/Du+kBc1r55C0VqEXZ6altywtx5xCjpjhmWBoiGXlruPk01qOB6SrpV7qdRG9mDhAypFPUrweKysXBklWNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUKpwcs6jAUsDOFqgdvxqd0oYFbdiL5xZrBrMckMH44jJUEVgq
	Txcrnf0+UobyMmUsMWC9XWxX5ld6bB9mfkhJZbbqCUxXdHa4Vt0EgSpBp/OSH/VoQYAeSrlS0Pw
	HD7RH2C3uIUPGv/m8rbnFPv65rbI5FGI=
X-Gm-Gg: ASbGncs2NeKss3AjO7Nbut1Z74XUmpr3I1NKf7soEPEK0rQCYdR0oHGZ3YqniIDqmwR
	OyfBSDvbQ06DwgPR7r37ta7s6yPuzJ7IuFssuBtopuoSKE6DGfKplJr+Kvmbn4DimMVTjznMbR3
	WGV9IUipjoR4DRZG+DF2x6Xxjnmme5PAs+09+v/VLTeYM=
X-Google-Smtp-Source: AGHT+IFl3QRS1ASxD5Nom/WmbJxg88zSGy1MBXMnBBS0GH7xlD4TWPEw8AfHbd8l7rkvR87H+MsMI8FvbSOGlFGFsG8=
X-Received: by 2002:a17:90b:4f8f:b0:311:488:f506 with SMTP id
 98e67ed59e1d1-3134753c5d1mr8776699a91.6.1749549827474; Tue, 10 Jun 2025
 03:03:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609122200.179307-1-trintaeoitogc@gmail.com> <DAIQ9342ZFYD.3VQVI80A18HKX@kernel.org>
In-Reply-To: <DAIQ9342ZFYD.3VQVI80A18HKX@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 10 Jun 2025 12:03:35 +0200
X-Gm-Features: AX0GCFsqB3V8oX6wtHSUpzU2MNL8wo_FwhFMAyLhaEv4LKWmFGOaZ6ak2XtPuK0
Message-ID: <CANiq72kC1j-kprAQ5WU0QVV_zhyKfDPJ_M5E9xZ+8+fxt4R6qQ@mail.gmail.com>
Subject: Re: [PATCH] rust: module: remove deprecated author key
To: Benno Lossin <lossin@kernel.org>
Cc: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>, rafael@kernel.org, viresh.kumar@linaro.org, 
	dakr@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, mcgrof@kernel.org, 
	russ.weight@linux.dev, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	leitao@debian.org, gregkh@linuxfoundation.org, david.m.ertman@intel.com, 
	ira.weiny@intel.com, leon@kernel.org, fujita.tomonori@gmail.com, 
	tamird@gmail.com, igor.korotin.linux@gmail.com, walmeida@microsoft.com, 
	anisse@astier.eu, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 10:58=E2=80=AFAM Benno Lossin <lossin@kernel.org> w=
rote:
>
> Unrelated to this change, I think we should add email addresses to
> people in authors. Possibly enforce it by scanning each author element
> and checking if there is an email address.

Sounds good to me, but I am not sure if it is possible in all cases.

At least looking at C, there are company names too.

I even saw a URL...

Cheers,
Miguel

