Return-Path: <linux-pm+bounces-39172-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F9CCA107D
	for <lists+linux-pm@lfdr.de>; Wed, 03 Dec 2025 19:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 92DA13001DC0
	for <lists+linux-pm@lfdr.de>; Wed,  3 Dec 2025 18:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A95328B55;
	Wed,  3 Dec 2025 18:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYkDp6k8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC9532862E
	for <linux-pm@vger.kernel.org>; Wed,  3 Dec 2025 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764787072; cv=none; b=K8K2G5PxIEc898CrLmwFleogoZM75qyO3XyWrFmhSlu2+NaJEphORNwoIy5Qu/F7pEDQrV+OwTyIzOThXkNCFAnpV0QWm2CqbSycu5iYRbJuX17IIF9Wot2+HhCsz7As5CneNtzM5kNG/yeATMqz3qdZwb/OVbqN1JLXZog7bIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764787072; c=relaxed/simple;
	bh=fa36E/WCGKRkcBNF5Z7eiZ+aSk0KDxuEtFldP/hqBs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZiWmlCzSthTYMx9X++caIjhMczjWe1JI2EbILZouH9ab29smqpQ1qDcixXxgyvvCXSvaTR+dFXQmZ9KbIt6RhXfvVqP8szWfMAoxKZ+UHrYZJMDu5FJGosIsSh06WiPo8rVdUo67gqz1iJkc24EJbey7WK0SLoNswg/fNrFdwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYkDp6k8; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-297f5278e5cso140015ad.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2025 10:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764787070; x=1765391870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fa36E/WCGKRkcBNF5Z7eiZ+aSk0KDxuEtFldP/hqBs0=;
        b=NYkDp6k8FFjPA0AqI4OhBGnP3Z6rFc17eF1j1BbHYEg8uJ78GMndtT8+aGh4OhHqr/
         kA3nsz/Ww10pywos9/nAuT9LBAgnajf+OC0vyfzvkReMyjDizgK7zicbuNSy2nVpv0+N
         pxTzFh60hM+AAd8Qk9L79yARD1vMzx4uGHwBbfDZ8NcspOxjUF7KZDncu1Mjf7uWoT8p
         e+9gV8eK/iqfc9A4GgZPsGPBCqbC8y4au44/7VN8Fhbzb4sFTmz8IGjp7Q3SVQpgoyDR
         3yK7Y7r7/YWOUAhFjANRdHsG69qDAiKJuaic3IXHz57fpm21DHd7Z2JRcW4mHZqAqJKK
         6M2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764787070; x=1765391870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fa36E/WCGKRkcBNF5Z7eiZ+aSk0KDxuEtFldP/hqBs0=;
        b=ZMBZqllSJ8q7uwB+ZhW69N3zdRDDSXDkED8IGze/VEVXfHvX4UMNobH2nLm/5VmEcg
         r8x/brCjdRcOmYZzfbl76T5jdyAc7oN54Zga9gXJz9cSDCxWjfQ9+5ag7kwAVBwdJa85
         U5BFRxCxO2X0MWaZ8L50Bh5wC1IN3S9qlVX0hlVE1FOQJSD7vUGY3wApEAAflwtwntbs
         KXvFVK9ZOW9DvmpTyZ6iEo6/J+rqnnjaXuYGvSr7BrclZhHHIXm0Dyb6GFqDOTdoZJ5G
         evnYB01ykYMYIRZJ133CGkQVon06gv4Mm8eJSncCDml5s6dD+wU2xwJ72VZNcFCrONJQ
         AsLA==
X-Forwarded-Encrypted: i=1; AJvYcCXnjlJWa83oE1c+OTYKFDgPAJsLaMdP71obQAId+DdMfDhY3vVIWGV6O53BpdgvSKXgHiY+0d3+Sg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6M3VbamudkYEJaqIhXfgPwxa9oiEiSxqSmLMQ0uKv24IBsgL2
	6Q/4c8mrz5lDwSOfzV1CMutCFakf1kUwx03KneLxONrtYo07Y0L02hh9hukIfW1SZMi1tQCipbJ
	RkQuFuDc6v4SP8H+TvlNO48gRCOEZ/Rk=
X-Gm-Gg: ASbGncu+rbesXQUlawWJQjYrqDkdqWbLpP2UOY31px8Zm/AKxx/3c2YWRR6824HKOkW
	wrFnQJ+u/K30W7oPPiA75nh67SH1AK5nVS6XcgdffWcC3jj5wsMAq6T/BGUDLo7zDS73Gfmon4j
	sFJxLYEo2nEHyjoR9669Yub9FgADJmL0tW87pVgrIup6SvzlFr6h34dTL6r70XVXdUNdalc4tb6
	a8JylyQxL0YnLUm68tvSj+sDk22dOzXNsdSgUHxek7bG7MfmfHixJ/a8g/qrMuGptlRZUsqFJUc
	FrnU1IbTI892apWdu0ftNqobvRfg7mKYlxg7BS1mAO3k4/emTOnBw4Z2YP2aWDWE4qVVlsb+nnp
	OJAk7BQ4qW4+Q8w==
X-Google-Smtp-Source: AGHT+IFFSgEazxFGR5mTp50UmKXrVs/s+GzaL05/S+E7xHp1Ktyf5i5yPdWD96z0x0JXRct0/B7WHB461OfjX7aMOSE=
X-Received: by 2002:a05:7301:1005:b0:2a4:3592:8623 with SMTP id
 5a478bee46e88-2ab97ad920bmr1759245eec.1.1764787069794; Wed, 03 Dec 2025
 10:37:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128-io-build-assert-v2-0-a9ea9ce7d45d@nvidia.com>
 <0A952509-8A00-48A0-B975-C23608A6048E@collabora.com> <CANiq72nSo4vuXc+XW6yynbNvpZi2vJEshXw2zA1RPgSUWwAZ_Q@mail.gmail.com>
 <DEO9A3YCUEBI.XTTH17KQLWP4@nvidia.com>
In-Reply-To: <DEO9A3YCUEBI.XTTH17KQLWP4@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 3 Dec 2025 19:37:37 +0100
X-Gm-Features: AWmQ_bkuruEMK9NRwTIYlXlsOWI1vjejqBYEecpyAI0gfxbIVzUGTOLZiE6SLGw
Message-ID: <CANiq72n678u_Q2Wi5kXuWBJ1ye2E9fwb_D4N1EzzGfn_w6L+mQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] rust: build_assert: document and fix use with
 function arguments
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Danilo Krummrich <dakr@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 4:19=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.c=
om> wrote:
>
> Shall I respin with some `Fixes:` tags where appropriate then?

If you can, then that would be great, yeah. Thanks!

Cheers,
Miguel

