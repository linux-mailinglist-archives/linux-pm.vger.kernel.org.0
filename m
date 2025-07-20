Return-Path: <linux-pm+bounces-31136-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EDFB0B924
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 01:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F94E1897922
	for <lists+linux-pm@lfdr.de>; Sun, 20 Jul 2025 23:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FD722B590;
	Sun, 20 Jul 2025 23:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcWBSNQl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388DF12CDA5;
	Sun, 20 Jul 2025 23:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753053476; cv=none; b=JJYI4K5/SIvLPynBl9TkUm8z+yCFfv3wnVSwl8jGfDq1RmbHDsc2rAGg5g9pYM6sMsiu8blltmi4/fxtv4OzcsHxj0E+IYLo7pfoyfP4qOG6paZl1Y92qrZs0Az2kzXlv5xhCHbVLypJLvkXiZSWVjbhT64hXlhNG3vy//bQE4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753053476; c=relaxed/simple;
	bh=pGT0xhBqBHbFWdDdZyKQSNOHcvRWrnAJlLeBlypIO4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Py66W2eVdtmU9E3GpXKIf9U3eAscquXpJ2c+p3NxVoCGR4uXrI7dtT8mxkvWLytfuOXxSfQCxD8YH66Ih7yDQVwN1jgmRMkH1v596qzU7KHv30tcICY9/941ghAiPFZN/kUd48hmpjvfACetpFs1sEdBEdoXpvaBuk4iieDFSjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcWBSNQl; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-313dc7be67aso445654a91.0;
        Sun, 20 Jul 2025 16:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753053474; x=1753658274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGT0xhBqBHbFWdDdZyKQSNOHcvRWrnAJlLeBlypIO4U=;
        b=YcWBSNQlR9TdbApMN9pMaQTM+twSMQuRt1F0Z5QCXPzJfw7XhCG61LLo7JbE10+WZc
         osctkkBVhThv+I3DMOHp+uECmzldd4NkHd9NyDwoGYugfym4ZV9vxiCygJTgp5Mep1Oj
         h9DktY8S6ZtyZLqYi1ub7yjEmPnPNBQb9lBdqTimST0F3Bu9oC4MbELsMT6Nho0IHaHw
         dGSbKMADNIyZYIaeqvn2JwBUZHABSLrfr/zb/NnkjF1y/CQJqTJwp9HtpYPzEtl7qU48
         Nhr2AiEzD6CrofRZ7qCRARBKja+p59n/EUD7Isze75hBXX2EaDA4w0eQvOJKaEz7zmhm
         h4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753053474; x=1753658274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGT0xhBqBHbFWdDdZyKQSNOHcvRWrnAJlLeBlypIO4U=;
        b=ru6nWfZR2e2zW9IKUd1EglgOZ77IFRDfN9Zip1A2I2LgIy2RvpuNI1MQ4OVd0JWgfc
         Nw7BOytReg8yd5KizFpA4/sysHZDN6ukWsfBH/frZbEQRBSVUbZxK7s/6DcxagYOaL2M
         kOybltVgqTn3c6h7xYkEX7vfjlaCKlGjzgYYZ8PL4gho0Pp9qjXSvnYNg0rBxjJklHCj
         4U+TRqv7hEeDQH34rY8brxJ5VaC91Q4vnudjr4BEKQ1mehfbvoumT7gH94S2dNJOLDBO
         4pvNqTqVWQ1Ma/0/6lEx18VR/21W7ErxcF+n9nYzpmvS78ZN0fQ4cLD9zyf5Hct5q+22
         Xaig==
X-Forwarded-Encrypted: i=1; AJvYcCVuOXp4zf9Q4gIIhdNI1aGhtzrL9fX5OYIyCZYF5EDwVut+B3OilKzKxHDQbYQk3YBpyBPuZwId5nNOJjQ=@vger.kernel.org, AJvYcCWeqxaSeKiD9MTpA+bryRsbmkXukRk+WYj+tIcqlEZltKzdLM4RsV8j5VWzsrkSJUC2ZJjWeGduYzLxARFbkYo=@vger.kernel.org, AJvYcCXUcxtteZi3QhPiTOpy4dn+eAoQz6pNE6lqLBG5xo5bTOE8fzoQ/4ywwLJBT4APnCxdJNIuW8e/tjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdkEGfwVbVKIXPd2XUSCAi/J8H/igKY0X4D1eo8m9k3nsbvFi/
	+GTg7OAaODLjr2SEXd+hiNboUTTmR4L+V6u3d0J10s/czjDo6DDWUWHVN1YkYbPJmfqZVGABYaJ
	WxE0Wml3sWtjyOGkW5GJeSsUws9MwWJk=
X-Gm-Gg: ASbGnctVL24F2+wZanyaVJDBqbE4t7dv9+NKQiOszVldqepp8KcHqzVoTvUXcb+1QcU
	WHoxBgRZ63PWzwhVh2cVNhgzxwd87j1f7GeipNEDEYgySF89qu9mpgEPByeHkWw6zx9dswj4aE1
	ct11aNWZA25UjUf1jAjAeBnzVyPYCK/E2/xLcFquARjzCCAqMTtj1LeGod4xSpinEd8RBMh21eZ
	RXaZGnA
X-Google-Smtp-Source: AGHT+IEbrcR8MgMgRAo5KnPtJx24JMikPAIly+rpRUggWdS/YqBt5ySVGDI/rtXvTVmG4G/B9031gk3IdnUlb0cu6aI=
X-Received: by 2002:a17:90b:5285:b0:313:2bfc:94c with SMTP id
 98e67ed59e1d1-31c9e7afd78mr10304315a91.8.1753053474405; Sun, 20 Jul 2025
 16:17:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com>
 <20250704-core-cstr-prepare-v1-1-a91524037783@gmail.com> <CAJ-ks9nBrT4C5xYk4eWUFX_nX5XXBYHEGo+fLtLWJE-D9Y5hKQ@mail.gmail.com>
In-Reply-To: <CAJ-ks9nBrT4C5xYk4eWUFX_nX5XXBYHEGo+fLtLWJE-D9Y5hKQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 21 Jul 2025 01:17:40 +0200
X-Gm-Features: Ac12FXzxtp1UNQgsWc3xcIVA0zM-1eUXS6ehJ4njC6usGr6NPOzcDPlluaIG_s4
Message-ID: <CANiq72=pS1iPePhi2Vs2AkLs3+tV=TASStPuSCnRNnHNHaawsw@mail.gmail.com>
Subject: Re: [PATCH 1/6] rust: kernel: remove `fmt!`, fix clippy::uninlined-format-args
To: Tamir Duberstein <tamird@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
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

On Mon, Jul 21, 2025 at 1:04=E2=80=AFAM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Just noticed a tiny typo here: it should say "can *be* taken".
>
> Miguel, if you can fix that on apply, please do - but if not, no worries.

Done! (We could also have removed that sentence too, since it sounds a
bit like something one would write after the `---` line).

Cheers,
Miguel

