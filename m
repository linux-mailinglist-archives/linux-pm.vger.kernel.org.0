Return-Path: <linux-pm+bounces-28353-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A23CAD3348
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 12:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E218167084
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 10:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80356283C9F;
	Tue, 10 Jun 2025 10:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0swfFBF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0421428C021;
	Tue, 10 Jun 2025 10:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749550212; cv=none; b=PGrjmM70xNrwLWeMtdLSHEP7F1OJD/Zq5Z5iRzay4NjO1FcZgUexZ9tmwS/bIrg7Pb4RrLroLX+I0rSGtuaTRURNas8Kq7w4eGpivA7Fvok0FZTxZhTkvpSUPLiUf4bLAlpVzWoFzkFs3IJZeQhybElEjQophBGVejfmosXqFaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749550212; c=relaxed/simple;
	bh=0l96MakJkaCzuRTTJal9AqusNGnBegv/g0Akn4qaFyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OhrS/Yp3WiV5xJO8Z+gGPnDVlPaN0VlzmCfURKZWVeE4JuJh0OK7MHq34ZfCBR2G/R/b5IRsRV2rPRiqtJhgN0qC16O6kbnoBfBbJrSs1CH/Bt1dmAy3vIhxzy9QUxgfmYQBL2n3NCYTdcnr81EyXWSNkd1Tst2B2C7rX9nQJ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0swfFBF; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-313067339e9so766624a91.2;
        Tue, 10 Jun 2025 03:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749550210; x=1750155010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRl5cQXysfFPXL6AFBbaJUkmuUlj4Q8VKoGcUuUjP+k=;
        b=U0swfFBFGGqm9nJgPJeYZRpU/Q01fAseTiG4nlG75HMpBv6FiwH12dZfE1mgyXXdbO
         VHlpkLIMc3vh5/M8+ia7I6BMJQAkLbCKRDeeyCBb8zhzWrc5HJXfZQn1cWuEHLLrPGWB
         aQDoYaz/EXSQdzFyz5yGWUFEJ/94G5lkKcFqdnTTdIE+ggNZ3lJgO4haPPmxPkEhGk6q
         DVMue9Lc9wJZghEyKJRLs8l/qcoZAH/kNkduPij9HZzKzleH6LWPj3Kwg2fl3UG6PNAL
         4fam4sMFIjXQ/j3fzoRntFVQyxeeMoCzwPy73YrA5DNjTG2uYC58SHLAQSLj7ShYZIuT
         cLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749550210; x=1750155010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZRl5cQXysfFPXL6AFBbaJUkmuUlj4Q8VKoGcUuUjP+k=;
        b=dbZX3Eff9bnhQcv2P9ItA81YIJq7KNi9XOVMqAlYsitAnS106592qguUEer5dl7kyA
         xyn1kY8AyWiyHpb07IGCEjUSF/pOK1GW72aGcjRPmu4YLGpjH3yj9x5ns2R0hMPVQpD6
         j4t3SQjUSCiUt0XkLM7VRIXv6HR6S7tA5HXKVc+4rHq+47YOYSDFuLD3VMyOgSxY3mvi
         Ck3zalIdDAtLE1FoZ7aodpo5I1pAZuDafmoQFd1RR4DYFLm1nE1c6Y5jAciai0pYwgTv
         a2LAsy8WNGa1fmPLKZZs73V2O6spSmMTt7LPcYowCvvzh4ZZgqMCycXHqX//v9qgVC49
         buaA==
X-Forwarded-Encrypted: i=1; AJvYcCVflfgN51HNq+qFN2pOpS+ZbSZx9s15WJMFKq2Ywb9whYTTk8yADxUH383UkTenXg53E4loOCk4VH4=@vger.kernel.org, AJvYcCWpwX3onrApA4m3o042ttO2EQS4JZ0D4TWZf39t9x120uem0eC8spv0IZBuMXhxClHCQ2FcN8DlCBZJfnAcQ+Q=@vger.kernel.org, AJvYcCXQ2otnnIa+CRiZx3ZuiDKHDSXuIV2tWuEbhxg8XqfflxuFb9AyMjTxXQeea4qXa50kxAwt5TwispCi75s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHaOhscP0LIuy664ef3O/AmaTNAg5qzHk03YhLKYIX32rwpYut
	mHcEV51N0gAMkk5CLifNVEaNVlLrJ+WO4rjv0iH0oZogYpIyGIREd8CloGaJ23U/sRaQrAq1pwI
	IO0MoIrX1RIYLB3N+o2pNbYISCt67QW8=
X-Gm-Gg: ASbGnculYaGL9+g3W7DYhafJMK4AAjUIfvZsZXDJhqEoyJKULkLBMOSFKknlWHJu2Wu
	b0Giii+opesIHV3OsgSHD+GQz3BV3SaGQ7vHdwToliDu6XoFi/xdAYfdXgX1uK4uWjrHvmoDDuk
	JBfDwyLhOaG1atg/YvkPUEOwQenRoyWLkzn3zJFcT8l6E=
X-Google-Smtp-Source: AGHT+IEQw155gVvnxaNkH8ebHs4zS3ADdbJBWxomsZZRx1+0u1ykLUMJIIrhF3RC4Mie1dvmIeEaYGc3fpHk7OOd6YQ=
X-Received: by 2002:a17:90b:1dcb:b0:311:c1da:3858 with SMTP id
 98e67ed59e1d1-3134debe401mr8335583a91.0.1749550210201; Tue, 10 Jun 2025
 03:10:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609122200.179307-1-trintaeoitogc@gmail.com>
 <DAIQ9342ZFYD.3VQVI80A18HKX@kernel.org> <CANiq72kC1j-kprAQ5WU0QVV_zhyKfDPJ_M5E9xZ+8+fxt4R6qQ@mail.gmail.com>
In-Reply-To: <CANiq72kC1j-kprAQ5WU0QVV_zhyKfDPJ_M5E9xZ+8+fxt4R6qQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 10 Jun 2025 12:09:58 +0200
X-Gm-Features: AX0GCFsHP1AlO74yO415mgHq99AB0fqU564MM_NdfP0z3sz9Mc_AdfxhNQWL9po
Message-ID: <CANiq72mEfFK-iZ24aX2_UdnvPLXkBLNEFZ9r=y_Mhvu3qHXyuQ@mail.gmail.com>
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

On Tue, Jun 10, 2025 at 12:03=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> I even saw a URL...

i.e. as the sole thing, not as an addition to a company name:

    MODULE_AUTHOR("https://www.comedi.org");

Perhaps we could have a new key or similar for companies/entities, but
I am not sure if it is important, and we should probably do it in the
C side too in that case.

After all, we can get contact details from the Git log, `MAINTAINERS`, etc.

Cheers,
Miguel

