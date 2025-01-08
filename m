Return-Path: <linux-pm+bounces-20087-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D39A05AC4
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 12:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501901612CD
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 11:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8BD1FC10C;
	Wed,  8 Jan 2025 11:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F3i5FQ5P"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950931FC0E7
	for <linux-pm@vger.kernel.org>; Wed,  8 Jan 2025 11:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736337353; cv=none; b=ficntXwUE9QYSo9pKbkGMEdLYmMBbHxs20nuihwi0G3qmaSUYHDeZ62rsKD6rgfKmI2rUUNvNHk2BSQLgoun+kWDTfJtedddqD7K09UT6JiK9rA3dHnoqosfTtBYafw7lwEH7WRD59P5YU3a4UYS5KJzoYNQh8AecW9GIZQ0RDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736337353; c=relaxed/simple;
	bh=LU5+JZ8c0aMuXsiq2DbH/nw5wwIFJpTg6gDHtEUTtdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O92QIo+7AjktTswH9FNxuPe3ZbEZx+GTPl+qbjrP0x0EyZPZjiz65U0QMZUVHdKzwKxQlZe1gvh813ZxysFlVP0v0QqOyBhCn+YgN0Z/tDquTjMfBcZ+FWEi2uapzgXR7CZ2wTARasxMTnvFnp97fVpQ7o2H98O9LEpX1aXu7dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F3i5FQ5P; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3862d161947so7904061f8f.3
        for <linux-pm@vger.kernel.org>; Wed, 08 Jan 2025 03:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736337350; x=1736942150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysWqhzjGdaCIDt4W9FTlg6YymFeYs9kmMV3kG8nOLxk=;
        b=F3i5FQ5PGFihP3ipI1qJSgnS5iBnbe3DFU+7dKDwhKgI/93ceAYP92cYlDo3Oz6iVH
         2n8lfmdkmxHqPLMUp1FxoOFFlUEl5T8o5B3lCG/bcuklpo5t7M5ZmeJaYbjzsv6nrNjF
         8VM6qsutzmZzlZigwf9ghnRT9zLIzZ7U7d6Az5LAkeCSyHXHEGCjH54u+jSWQrqDrn00
         o9C4cqhAkMKlp+iqnCLgLg8J0buFk01ft9hIE0N9763lYnHVQuKD1bRBzDJhyfUQWcbJ
         zJcQJ9nIMVRwVZuw1pKY/t6+ZhckqwIAYCLsFQ/4NVeQj6uz3yXzVRjZKgYXPN59nEZ8
         qZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736337350; x=1736942150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysWqhzjGdaCIDt4W9FTlg6YymFeYs9kmMV3kG8nOLxk=;
        b=Vxpgw6XR3QLkrMFsVNCoVDZlF3J/ON/iEM0wNN53kEipMRAMhKQh5jn7qGeGDGfZ81
         +Mu+zRII5AocLsry0uj7AqjPST54+BudYns04+QlSZyRNSJIe8cQFbbBPcEUCnHWa67X
         NPirTWMNRkfLx2IjzVICegrmE5nOwxXutJ3vn5KL51/P4opODGRu7wNuq7qMLmmMTADi
         X9Js+Ici/78HFOQqpILvazi1RAXPlJc6YRaSD5in5U3BRjxoAxiSwNiJ2+ln1OBH9aUk
         v4UlOhH4Y8tY7VRUqpxO63atCgQyx3lGImJi179E+BdE5PpoObhBrnxweD6LBX4RMLGK
         Xq+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUh1xacF3do5d0V4XilGE7ROnv+Vci3fIyhaEB9JDdz6v4fb1dDlMgXLpXJgxtt1tYKJhO5eZw6Ow==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz83QMdChnx+FW8l5VFNskkAK9hLo24c56tokfkL7ryhC0qQqZo
	RV3hxV/mSmHgbKRKIg1UJ4QCGLLAlXxvZueqcL+OaiRBFkmuHlT9sWKYQRHsfJNVlKaQI6iYjTR
	vgNJUAechXbgTLs4n1ZzQJ3BYABMMAjhzRViZ
X-Gm-Gg: ASbGncujOrvhc57rQfTaXUMLIgUQWgqbehiqhLdefsu9+3byr792dz9R2BJjkXvIDjg
	4rTUJFa/jWqqnTEXQpoEqrPuIrg1JDp8pTTs58Wu6awHbmRzW8ZljIKW9l1RQaN3Nf0/3
X-Google-Smtp-Source: AGHT+IF2oFQwQLC2aHSgatD9Fzt59TAsCxdAF56BZp7hAJhm68tYyV8qzc8wgcoL1gJB/1oyGVfApI3k9DfpsBRwboI=
X-Received: by 2002:a05:6000:1f85:b0:385:e411:c894 with SMTP id
 ffacd0b85a97d-38a873377b2mr1823281f8f.43.1736337349818; Wed, 08 Jan 2025
 03:55:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1736248242.git.viresh.kumar@linaro.org> <429b7539f787ad360cd28fd1db6dc3d6c1fe289d.1736248242.git.viresh.kumar@linaro.org>
 <2025010734-march-cultivate-bd96@gregkh> <20250108110242.dwhdlwnyjloz6dwb@vireshk-i7>
 <2025010835-uncover-pamphlet-de5b@gregkh>
In-Reply-To: <2025010835-uncover-pamphlet-de5b@gregkh>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 8 Jan 2025 12:55:38 +0100
X-Gm-Features: AbW1kvbRBBGWZiziirBt6pPx-Q4lHLyYgwH2cnuwi8CwUQDQVuYJRGMbyw8G8wo
Message-ID: <CAH5fLgg+XQ2ALpW2x2Mwc4h-ZMo8ZpynH3VA9kxFWyg5SgvmXw@mail.gmail.com>
Subject: Re: [PATCH V6 04/15] rust: device: Add few helpers
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Danilo Krummrich <dakr@redhat.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, 
	Nishanth Menon <nm@ti.com>, rust-for-linux@vger.kernel.org, 
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Erik Schilling <erik.schilling@linaro.org>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 12:52=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> > +    /// Checks if property is present or not.
> > +    pub fn property_present(&self, name: &CString) -> bool {
> > +        // SAFETY: By the invariant of `CString`, `name` is null-termi=
nated.
> > +        unsafe { bindings::device_property_present(self.as_raw() as *c=
onst _, name.as_ptr() as *const _) }
>
> I hate to ask, but how was this compiling if the const wasn't there
> before?  There's no type-checking happening here?  If not, how are we
> ever going to notice when function parameters change?  If there is type
> checking, how did this ever build without the const?
>
> confused,

Rust auto-converts `*mut` pointers to `*const` when necessary.

Note that this should really be `self.as_raw().cast_const()` if you're
just casting mut to const without changing the pointee type.

Alice

