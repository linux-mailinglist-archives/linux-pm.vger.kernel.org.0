Return-Path: <linux-pm+bounces-38989-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6064BC986C5
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 18:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0169F4E24D8
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 17:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108833358A3;
	Mon,  1 Dec 2025 17:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HC15yTDF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1DD33469F
	for <linux-pm@vger.kernel.org>; Mon,  1 Dec 2025 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764608966; cv=none; b=h9B4AI14AGFE6pb4eDTQMyExabM0OrOlrBjfC9AXaYauBAJPmJBcPydrktuTVm0OQulCXvOa2PyvBYOvNgKmtwZd6fWsgAyEfud2PlYhlEwG3qIrEg1K2VQNV0aAFVBXO1WZCNRh/EMYNRHIuyjD4RTVWc0qtGw24G586NXnRQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764608966; c=relaxed/simple;
	bh=iBbiUzvYi/ln13SU4XKUqRn4bX9H63vGL1eyD6pfsfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oa6mg5et+CBZwywwSOPY9bMbRUXxJS4OS463M2nC7ODMhWB/bqDN91CV2n9L1cBZCo9hxwmfpcOMgUO8oILy2uMvCtS6BSGgFw4pHmf4OteD8+F9EUFrCZ9sY3fFb/KLZtY2gVE82+aBOEm3PWZjOThzoKnh9kWJb2fgwG00YIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HC15yTDF; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b90db89b09so426086b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2025 09:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764608963; x=1765213763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10oqy7XG0ziR1jN7iIJoYu4N7Sm/NTHUpb4SiggOXnk=;
        b=HC15yTDFMPAT0Lb1MqdcRSii4KackGdOk4+mnSLFKvQu0v3nYYM0yymTsluA866K0g
         4wPZylYTIdvo1CrxrAEL4ajRaxaaWzButBecL9BjilU3/dhFAtW+rojUu8vCC6Yl5zsX
         BLsenFBgxhaHLFtQuVHpJO+eFAvHVAHZKnAM6STfeELlh3+kopFlC9AJHQmfN9YvaXOK
         EYX5i08LaZ1RO10SUaY6TrqF+SiwDI4iUDzElt/WUX6WEqCTYSCqHWt2H58UcW3HLowI
         DTiRX73GhsiFHjfZHTHaRofvWJxqezdVthpcMV7iFihXwXRktd+rLkQb82BU8QLr12Jk
         /EMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764608963; x=1765213763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=10oqy7XG0ziR1jN7iIJoYu4N7Sm/NTHUpb4SiggOXnk=;
        b=eHGjBky85PPuFjawlngUtwRDHvwZhiMFrQezf8i9Q8qAKr5cHzMDYVSqFMuvNqGjXI
         M/qxTcrDs4zpmaQfjuewshqxx26wsVEwGIXV8cEqGhejDXyedNqvEsiSP1+uGzECafo0
         3iH4HVm0/uIBj1TahEUJYfYNvC0hI5M3gwoSc2SJHcZE0IyeaCP7KklpMqlZcbDwPMFv
         KcTxTEuard+B7e2AbOubiBW3IV6vX7wE8pOIWO/QcIzUlIvNRzXB66urgFJhhj5bL+w1
         SE9G6MuHI6pdFvLPaqBBotwBAujCn0S47qdepSNmvvSgyrzZy8xBwZBTE/D+OEsuM65Z
         EALQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHS81qayNij/YF9U+z7lhC3oG/0/ftv5d4e1JbDJIGhDLYY5J1U9sf7oW5aYYPgeUZ8E2U2pwVIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzau5g+CgRqzAjQgfl4MTIf8q5vr3ntOS+YuzIi3RvgG7+WhREr
	iOMQ8kS7KmB3rweQjuzV/CObBar8xl41l53F9lpBTVmP9S7QrUrLXlmT7R6BS5cPhMMQWLe26Q2
	nZg9iZMyq6GdwEFYXnglQSMvodECwYJQ=
X-Gm-Gg: ASbGnctWQtF0zSsu9FPVKxbNKmZMAKlVCmqGm2nPLtfFknH3PSJ4HSUmxOmDic0729x
	bGUAyZ9uOATimuYujIccizlFr3f8z2M9ltw5cOAdMxiY++q5OLc2Yggi2ADXsFiftY39hk5Tc6V
	q63MLQ2//SPUn1HI7nN92MhrsrGHwEhuozqPEST3mOKsSicY1lT6q12Y2Fwvl0UmgYHL0CodmM/
	QuRx5Y2wpytlzHkPtIJaYJf+RVX4GhmbrbR7kt8fBeACvAspMkwQ3a1Rzjkx0r3XiWa6QU3ufic
	lnUdb6acbFQ1IKMuqcy9jpBquppTd6DPRBKcQ00cnyWTKKl2NuCBFMQ7Y5ptThV+mfR/Z0/xJZC
	FcpRgPJ3jImLoDg==
X-Google-Smtp-Source: AGHT+IF1YPYGD/E+eDHxFkwlvTUf8jqG51M5LA+tdLWxMqHx4a8yCVti7p4nga92l9CsKYM8VN2f66dz5zEFbxtTTgc=
X-Received: by 2002:a05:7301:e24:b0:2a4:3593:2c07 with SMTP id
 5a478bee46e88-2a7243ec7b9mr21959223eec.0.1764608963077; Mon, 01 Dec 2025
 09:09:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117-unique-ref-v13-0-b5b243df1250@pm.me> <20251117-unique-ref-v13-4-b5b243df1250@pm.me>
 <A5A7C4C9-1504-439C-B4FF-C28482AF7444@collabora.com> <aS1slBD1t-Y_K-aC@mango>
In-Reply-To: <aS1slBD1t-Y_K-aC@mango>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 1 Dec 2025 18:09:10 +0100
X-Gm-Features: AWmQ_bnmy3Os7dUuxEXbA4TScnRqySjzLSX-NOnwmbpPdF9z2OcK2znpi-34sDw
Message-ID: <CANiq72=mZXc5+fMzsdTRupUsmsuLdsx=GZucn2MNoCTLAT1qkw@mail.gmail.com>
Subject: Re: [PATCH v13 4/4] rust: Add `OwnableRefCounted`
To: Oliver Mangold <oliver.mangold@pm.me>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	Asahi Lina <lina+kernel@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 11:23=E2=80=AFAM Oliver Mangold <oliver.mangold@pm.m=
e> wrote:
>
> Ah, yes, rustfmt must I done that, and I missed it. Will fix.

Strange -- if you noticed a case where `rustfmt` wasn't idempotent,
please let us (and upstream) know about it.

> Not sure what you mean by fictional function. Do you mean a non-existent
> function? We want to compile this code as a unit test.

Typically that means either using a (hidden on rendering) function
that wraps the code and returns a `Result` or directly a doctest that
returns one (better, when applicable). Please check other tests for
lines like

    /// # Ok::<(), Error>(())

I hope that helps!

Cheers,
Miguel

