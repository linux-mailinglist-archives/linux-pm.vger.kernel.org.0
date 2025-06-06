Return-Path: <linux-pm+bounces-28193-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3B5AD0031
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 12:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 091A23B00A0
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 10:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90B22868A4;
	Fri,  6 Jun 2025 10:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6b9EnwN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582832356B9;
	Fri,  6 Jun 2025 10:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749204730; cv=none; b=WlKgn63kPtXbp8CgiMmU9Rk6CeAC6iWwUMmwZY7FZWVycmlfqWJDhctcMmmsgY9kyW5uokvziqJyTgVobku4EQZbL0vZiyioQeZQM0GbOEbYHMi9Se4y0BuNWL/LmDGnD9u3KpfnyJ0u/JZmhVsgfL6spSGDuERUAAiBy/Ys9dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749204730; c=relaxed/simple;
	bh=na3Pb0D7zXPPHmt6QnpL0+q1JshApJET/mF8iH1Bbkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCgw4aJYKhOdnOAz1e+KruuhJh3hNjQyDab4M9iWVF4MNKMelQIsS5142F3nECl3DShF3yHJZkNbGLdQQAE60JkwWeQiRf9as2XDbb7ZzHjxsTFCL7hJthu9NYhE2+w8JRjUIgctcCUwbwjNoG9sMbt8jvMw9t/AM0V9yEYJE0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6b9EnwN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-234ae2bf851so2677325ad.1;
        Fri, 06 Jun 2025 03:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749204728; x=1749809528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28Bl/PeHLavR9/zeEbDpLv4eVLtWJGzEYSYvLscWvio=;
        b=Y6b9EnwNHwwcqpRUz1DDiP6NBlDeIBgNR1VueVoq52JR8ahzAjtlLBHddCs03RLcna
         ywl8Y+jysr0u6fK1AAnmOD3e1woWnWid6SRNZ4CSfnNLyucZGHlUtd6GScyzWJwWcTIP
         ZBjSd4MK+EF/K+pVhJwcFNQxEJKT8SlZVgVWJEkJbuO0+O+MSLT9bhLC+dVZI8Z7S/fj
         roR7/ZMKgYf9p73eAR/bBfwyUfiDvH3Vyiib+UbDdhGsiPza8Jii6KsW/dxxLDtUisbW
         7dAnuNF1d8XqRklQU3n+H7HHq+6wC/fmnRnSNIlewtKQT4NBMquLL1RTMVdokes82iNm
         TnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749204728; x=1749809528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28Bl/PeHLavR9/zeEbDpLv4eVLtWJGzEYSYvLscWvio=;
        b=rWPvGzcBtBehIXefR4hHUftr6a/8caLSJY3XNeh2eyQLbMh1L5FoTr5CyGHoPeaQTP
         ZyXei24rRqn6+nvyUepmBZyWPiXlVG5DH84onfvkgCLKr/72nP8f9Wg6H8h2Wmv01IdJ
         rMoI5qNkpR3e/3Qkkz3ewv73ZSLaCMf1Tqvg8J7bGirLQhwBpcxtNwFj60KMO1IMO58P
         SCnz0Md0PX9g3WtwtACO/8wdGBoSPLlUfzMdhXJU5kJmmNti2s1F10P/xbnrO4hnsZUr
         ijU6qMq2TCiK3oHZ4WvkC5BfoWI/+QhOwU2f3GnSuEDVpUDIszxjcZyFPChVnm2SAoVk
         i2xQ==
X-Forwarded-Encrypted: i=1; AJvYcCV794qW1K8j4SEa/K+GFmhQHRxd8fi7OWQRRJtlQ/LDs3CcIhbYgJUX0pkwUCvNwgSENy/dUIVp7qXgd8YKyTE=@vger.kernel.org, AJvYcCVB77cpz9P8wcmxlucNrAPu6WeSipHcncrF7uT+Z8LMtiJWYqiiq41lhW2OGaozxUOYn/BMBb3KgJY=@vger.kernel.org, AJvYcCVBB6sZ68bgFEOVLPtp/DqhmES8Xlz+7RKL3+T2tNiv49tHaLYrv/BY1FUHqlBJ/ZHxZ+o8Gu08WNMsUpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYYeFmUxT2BTN7ETzlaN5wWREaH5ujuCVfaBgeDUKKjG3MXJmm
	uPem2THLLCb5ppjcafox+WQ4WvNMv6UpaR0JIzsS+lEWMTiiS61ngd+H1Dv++icAhDV63XuZgHs
	GEgE3Khr91nT9F1Z7wKe2cU6BdYS59LY=
X-Gm-Gg: ASbGnctFVk3XGSZmKY+ilO9SC65FwnJVLOHpZWOpDYJjL/ScY6ziKLd9gDv3DwNDKjQ
	pEDfW//XX6YuEP0IJqMd0VM45QOqkxObVHtYERJ/sZLIvepDZ+dAzx2rxPu4Ns/PuDVa2mjgv5F
	Ex+eEIqGsyQIJnjECtBuITYXOuyBQiCAO1hTTf5vJO/OY=
X-Google-Smtp-Source: AGHT+IGDyYS4phFiiRoWWoNoUg7v6sFeimAODFhUFphROTs9ZwAMTwMLYmFrMagrQi7dUStuyt9v5HYVGNf4skLUAYk=
X-Received: by 2002:a17:902:f683:b0:234:d7b2:2abe with SMTP id
 d9443c01a7336-236040bb86bmr8720125ad.7.1749204728458; Fri, 06 Jun 2025
 03:12:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8b5fc7889a7aacbd9f1f7412c99f02c736bde190.1749183428.git.viresh.kumar@linaro.org>
In-Reply-To: <8b5fc7889a7aacbd9f1f7412c99f02c736bde190.1749183428.git.viresh.kumar@linaro.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 6 Jun 2025 12:11:56 +0200
X-Gm-Features: AX0GCFvHZQ2r_W4WbjaPUXUdMkm3Lfj-HkvnbZrQYwwtbAB-RIXtkAjEDDUZN3M
Message-ID: <CANiq72nxs4BTFQQcJLgrbgHDzQLbhAA3=qsycdKu=oxc2V=yqw@mail.gmail.com>
Subject: Re: [PATCH] rust: cpumask: Validate CPU number in set() and clear()
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Yury Norov <yury.norov@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 6:17=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> Reported-by: Miguel Ojeda <ojeda@kernel.org>
> Closes: https://lore.kernel.org/all/87qzzy3ric.fsf@kernel.org/

The URL is wrong, please point to the original report:

    https://lore.kernel.org/rust-for-linux/CANiq72k3ozKkLMinTLQwvkyg9K=3DBe=
Rxs1oYZSKhJHY-veEyZdg@mail.gmail.com/

I would also suggest adding Inspired-by or Debugged-by or Suggested-by
or similar for Boqun, since he figured out the root issue.

Thanks!

Cheers,
Miguel

