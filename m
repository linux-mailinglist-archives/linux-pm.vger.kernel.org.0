Return-Path: <linux-pm+bounces-21471-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A5FA2A81D
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 13:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43C96166EEC
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2025 12:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9879F22CBED;
	Thu,  6 Feb 2025 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gT9F45P3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC7922B5AC
	for <linux-pm@vger.kernel.org>; Thu,  6 Feb 2025 12:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738843621; cv=none; b=OUN7pkx69lZjkeTUys1AcVhWCfxQmlcyOSt0RbH+GrnPR3t/gmJMCKOVIVrD4lNg9PChTtRgoSJeQIbK9K0XhMSKE1fRz9VVuyq9NI/a9r9UrzW6U1lxO764gbERouVq0gZrXg/j25Ql7HjXqsCbeTydje+IVckn63yYCYs5v9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738843621; c=relaxed/simple;
	bh=XR6UngKK7YAxtzb/EkX3tA43qlZhygKALi9P92gE+J4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AdLTKpY4tLBW2zpzhw36FoXse4vQtvWl7NdtE2IpQlAy78ozjNjLIaOgnyVvpZT8L7zDXBvfhQZgfWJQMLlUStmGV8w/K29YtGNs2dL7Z19dbb/eVMODn4YBOAJYNRyd80GrZAwINzYgWd7V8APKccWvmNXkQOrLD8n/nsxxpuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gT9F45P3; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-436249df846so5213135e9.3
        for <linux-pm@vger.kernel.org>; Thu, 06 Feb 2025 04:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738843618; x=1739448418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUfwePobke013UujtEBYM1EhfzYZv2QC6Lwba6Ypk4s=;
        b=gT9F45P3DqY5WYCpimpqa3dULx+SHUTsxZyiigNpBcoErCoaeBpUELiv5ZyFtu0YEq
         XAtBg+flO1DWhP1M9uba3vaGjqJU8cN9BegwIafp9yg6mH4eksRL4sFDlfjew7jU+nzF
         RzikmgJ2WB/KswQS90qFveHWPcnEXW7M00ThHaJ5r3iY27znxH3DG5KiAZp8qTq8BVRI
         gjcO5YTiUAeK/CmGLTsycSmRbHup/9Y/e/AuE1NvMD4zRqyCjvVNAE61GXGbmKAGUMd+
         0HGrhBcQR0w9y3QpXAmeoZmBf3BlVon61BzvlxMQKpPf07X6Y2/1Yu52UJlldsLKqR8b
         URzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738843618; x=1739448418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUfwePobke013UujtEBYM1EhfzYZv2QC6Lwba6Ypk4s=;
        b=FEmXbOidKAZl89MK2+w19F4hYrOGaDy6b3mvZVXHhFbUuTbVVRyHve7Ppd1Gu5zChj
         Iw0xl3ERxSvX+Me0Pk8+2VZEPZQUdcrdhrDM0PU60aArV6z0ooh5WnklRRvEKd1RL48I
         AZVDA9buCyE8Fty9rkGSx0ZOyGq8/3pUIjhFRcPVhr+PopVDnWhvQ0xCfxFgu1uWDsZ+
         41p+UeSQgtc2jWeP0+3yUew2Jwh+u/0BPGN4aOaZl8Ci+UC5S5VtSORgSGEZUoIp2clV
         d1lx6GE14a6MkHcHCk/MFtxsQOo9J75uDy9KrwWhgbsTrkgAKPJzDjL9PrSjb2EMgmnk
         K9Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWFGmNzyK4t1mPVouaALT1FnSGKsmDn8itcerxEIlYqZhEOzUf3qdX9ri5b1da2L4Lv+qTGcwo4OQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8YS+fMQCCeQIKiJpA/Ynq8QKX9ID1aZUVq1etyUAHv2lgL6tx
	sBjmTCJcVyBjSywPYS1NslYCa5BhtcCmlR/Zptocy7KJG2YxKQHI5uiQWfLbHVSoIxxZYQHKGRi
	C+/HAW3d9ibOVU1axV5b2Z2xB25gur6xyfx8D
X-Gm-Gg: ASbGncvpnTBTUR0iR1sQ69zoc1OJKOKO/4dJJvoDM7cgXUwgue8pBAQMFegfRvQLvOD
	iWuuEn12y0YV6XScouy/Ol2E4YqJWVyxwLhtDA+0Uec5wKrwSu7LpWdWyfdp1XXbmpbfSylYXQ/
	lm+G6lETS+HBIFHA8NnhfDkU3rb4I=
X-Google-Smtp-Source: AGHT+IGYHvyT3czOoUO0G+LKb5bPp/nIfHsUp1lMa2tjLnY6ZozcU57eS2CINXvL/ohHtWBhkCKsP+i3csCOJXv72+g=
X-Received: by 2002:a05:600c:1c91:b0:434:a902:97cd with SMTP id
 5b1f17b1804b1-4390d434b2bmr59528985e9.12.1738843618058; Thu, 06 Feb 2025
 04:06:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738832118.git.viresh.kumar@linaro.org> <5860ff88ff81d09838f7786507ec47a33cf16158.1738832119.git.viresh.kumar@linaro.org>
 <Z6SlRZouQ-nPH2EP@pollux>
In-Reply-To: <Z6SlRZouQ-nPH2EP@pollux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 6 Feb 2025 13:06:46 +0100
X-Gm-Features: AWEUYZlj97JPy69AI1ZLmuMZb4cJY94hCErCw5XdWtEAWRu59P8TAU3ECjbd_Bw
Message-ID: <CAH5fLgh3cosfVSJ-k_k2vjFT+PjPbmMqhmLSba=-VdU0vGmGCQ@mail.gmail.com>
Subject: Re: [PATCH V8 12/14] rust: Extend cpufreq bindings for driver registration
To: Danilo Krummrich <dakr@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Danilo Krummrich <dakr@redhat.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
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

On Thu, Feb 6, 2025 at 1:04=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> On Thu, Feb 06, 2025 at 02:58:33PM +0530, Viresh Kumar wrote:
> > +            unsafe { drop(KBox::from_raw(drv.attr)) };
>
> This could just be
>
> let _ =3D unsafe { KBox::from_raw(drv.attr) };
>
> At least drop() should not be within the unsafe block.

I think we usually write this as

drop(unsafe { KBox::from_raw(drv.attr) });

Alice

