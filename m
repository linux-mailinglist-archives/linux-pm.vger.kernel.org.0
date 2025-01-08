Return-Path: <linux-pm+bounces-20076-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD4AA0560A
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 10:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFAF8163D61
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 09:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DE91F12E8;
	Wed,  8 Jan 2025 09:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GuPKEPH9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4BD1EE7DD
	for <linux-pm@vger.kernel.org>; Wed,  8 Jan 2025 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736326885; cv=none; b=L8IJh1OC7fbvczJ8b6XMNNKzXxa7/au3EA4W4JED+zPek2jUjCkCrnVSq2RTzP+tqV2yWKrggWGJ9CcxzhYb63rA/aNVD6hVNZtY4XBDWcSv7MKVxk10UOQdS7MqfTbmMOp08+lYo2bjlZLxlIl+nltnp6E+aGkYeQgz9ySZFRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736326885; c=relaxed/simple;
	bh=/vL7iOIP5CVRNTaQX1gActeOvlJFEqVZF7QA7AIFavQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdV7V4NlxPjMQnJ+dXZTAYQMXMhDPQ2xSqBxIYprNMFtR4VChbixusobbO7xYTTf/zJmbYNS9FTIhqMFvacS6GmtV9o6O3jDzJBNqIj/KjguRpCa0cxVpCWm/cbKe6kdHHNKxtGolpFWedhvyMGl4+D29gnV8Rtb3VlTKYoAPfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GuPKEPH9; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3862d161947so7799789f8f.3
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2025 01:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736326882; x=1736931682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvEe0i3PRcA98OMwb3r0yMpOXq6eH0O++nSvcEmzG1g=;
        b=GuPKEPH9Umv8qbYQg/MaWzvMnu5semZwEm4N2iTwXZ4oa8iEv3GIyr9KtgbQCrmzz/
         UoM4V6nPe9oKmrmBOM4jrRAd4KRYnE0EcADJtlRqr3W1AF1FKXKGGNktd3XMRfy0ZSUn
         PmLcqQBSwio/qAFSR0Y8GUqAxaygw5kO0FmLT+k8navaaYS35D3p9I2MGXCQjhw9vHkW
         RWgodNBHVLozQKW+LMGYXZHVoT8FD/81Vz7KAh4/4R0lackD3xqac9Zb0ECXUKh+ryhJ
         zQAgApPDdIoDAM3SEgv53bWEnbAElX/x9qKoNQZ0wcmN0YLPVxerLeyX/i1UsQSl+uMH
         x02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736326882; x=1736931682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvEe0i3PRcA98OMwb3r0yMpOXq6eH0O++nSvcEmzG1g=;
        b=CQCFa3WWJTupSEJAlFz4OSVxtD8QJjQN9RXzzHP4O7cLDEsCCwrp+i+eiAeeO34X3B
         ga3txR30ACjAs1bPcE7WWxHka6wZOGb00tBBci2pQs5fkxsqOIIcWA8ltqFkZ0rV4GyZ
         AubtkocIczFU9f0B8iqSWaQ2hQsqyRaCzp+7s27ICbVfD01heZVl/xiWVx0o92wpwzlp
         G11d5OFtLaXhZXVqm2BE2zpB9SZFrgoKz8a4zNEjpPWxSKW7VANDVNn9dH+8pZ3d64gn
         Y1RADzNFpDC3421dzHkVRr9lA2HBEymvUeWkUP26WgRfGEQfLDi19QZcWeF8lrSNPzPO
         M4sg==
X-Forwarded-Encrypted: i=1; AJvYcCVyvthEB5w71Si1IBPSGR3xSFOgb+PsazctuBJwaKJP2jEubHpSDQF15FwNmxG3awheMABu3hNsPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwelqPv6dtsastJOGVv9nG4wsBmmunNs+AyRbt9fcGV5vMF59tv
	MRq+FmHKpZPg8ERr7w9FYtxjcQUBFEh5kVNq1BpWRAokzos898+X2TuypFawdbavgOh8S1GKOXU
	A2OO2bJoni2anPgrmfDX6B4y6haSNQ3yod/gp
X-Gm-Gg: ASbGncta4CJ7QpqGcAiOGymc8cFVvi7YQ5MDnqEfs7EPt2wbPecHWQ/XLmln6pHROra
	+fvlzzBMSnI3bMLnSj1rCfmfEdZ3uS04O0BFFbXEB9oynN4MTXOYRVld4yMFrYHmTCR2d
X-Google-Smtp-Source: AGHT+IENrtagmcoy/1njfzjScQiOgdp91GxQ+wHST8c0TsKpF4yxylE3BE82ytftjDDVhz6hmk5OBpx0O8I0xMwHRqk=
X-Received: by 2002:a05:6000:4714:b0:374:c4e2:3ca7 with SMTP id
 ffacd0b85a97d-38a872f673cmr1320575f8f.5.1736326881826; Wed, 08 Jan 2025
 01:01:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1736248242.git.viresh.kumar@linaro.org> <9719ba8b3a921bd9f2cb7ebf902c54c708b5409d.1736248242.git.viresh.kumar@linaro.org>
 <2025010752-vagrantly-juiciness-cd81@gregkh> <37DAF91C-2A1B-4848-A66F-3B50285AFEBA@collabora.com>
 <20250108065347.k67aqosuefcjdiqi@vireshk-i7>
In-Reply-To: <20250108065347.k67aqosuefcjdiqi@vireshk-i7>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 8 Jan 2025 10:01:09 +0100
X-Gm-Features: AbW1kvax6GqKztlF03CCgBWB50yPqW6iEoa9XrkTHM6Vd4Q4f3ZISL60GlbBGxw
Message-ID: <CAH5fLghLxZU5e+7DOXPKordBL_TMXW-_4Bc2E8fkdt_5LSykAQ@mail.gmail.com>
Subject: Re: [PATCH V6 03/15] cpufreq: Rust implementation doesn't parse BIT() macro
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Greg KH <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, 
	Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org, 
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Erik Schilling <erik.schilling@linaro.org>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 7:53=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> On 07-01-25, 10:29, Daniel Almeida wrote:
> > Viresh, FYI, there=E2=80=99s already a patch for this floating around [=
0].
> >
> > I can send a new version today. From Alice=E2=80=99s last comments, it =
only
> > needs a minor fix anyways.
>
> Thanks for the pointer Daniel. I was expecting that I would be able to us=
e the
> definition from bindings generated with bindgen somehow.
>
> The C header contains:
>
> #define BIT(nr)                 (1 << (nr))
> #define CPUFREQ_NEED_UPDATE_LIMITS              BIT(0)
>
> Bindgen doesn't get me a definition to CPUFREQ_NEED_UPDATE_LIMITS now. Is=
 there
> a way to make that work with nested macros ? I wanted to avoid defining t=
hem
> again in the Rust side.

Change the #define to an enum instead. See commit 3634783be125
("binder: use enum for binder ioctls") for an example of this
strategy.

Alice

