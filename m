Return-Path: <linux-pm+bounces-40457-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1AED03615
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 15:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74E543007D91
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 14:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC444C77C6;
	Thu,  8 Jan 2026 13:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ilfcfo9l"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6973E4C6F1E
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767880693; cv=pass; b=YIwmvjNWlt+hIcevwFWhFl5E5GmVpmXJHFZ4sDD+DkGCtwMY2FkdvP/EqeE2F+IEjBbjswXi/fSRTUyiRNmK+yfz2hIEkYZoJ2a0DWkEHSkWyVUu+7hC2iHFhgZiPbjWOvheG0UugFOLWdSA1Ps3bKPbKihopkOyasVM2+PiWFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767880693; c=relaxed/simple;
	bh=0jKmPkTdOWtk+ML1oyRZShyn9g+7S4FBzcZeJc6y38Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o4D7MXiKQnj5VF01T+CsMV+F4ZBoryTpTa1XVsOLbdhSxY+2OrDDKGfdNvGJ74Uu7jgu0fRnkIIQTFW2KU9Rp5/WHP2E9o2a2Nys5DdfPic4lUK0KvJ4ocMoOzbhLBHwsPco6EA4fkb8f6w7rnH+3XlLCVQylzXb2b5xEHUpiI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ilfcfo9l; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-11b7bd9e6e5so235889c88.2
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 05:58:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767880690; cv=none;
        d=google.com; s=arc-20240605;
        b=j6g8vJlgGXPr0beAAUDGhWacChmVMc2ZreFNi6mWQvAu0RKT158eTpO1osgE2F0TBc
         FKpU2i21tQMLfX3zqTGIioTFG7kd0TmDXlSXbJFlTjXbtIRl6s836UdvQn6cW+zDQRrL
         +KG5nM5/yM4/H5dNGQToyO8ZD9zMpzRRVrRSVoe3alIIhpjn3uKgAaCsAIQyG21V7EoY
         7gMexg1F5zPJT/g6UpVFPMHkmSOL1eTG1L+JgXT8jZ2pbzXQoZbB7yeTaBxahR03//k0
         sJMCav0Rf0fFxDG4z1sKvyfH+w5AVjPac4fJIgM8fM9zAH047SWJqTZf6AxTrR5wtMYr
         Qreg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0jKmPkTdOWtk+ML1oyRZShyn9g+7S4FBzcZeJc6y38Q=;
        fh=2oM/ys/xw9jSQ/88/81f0STKURhe5jW4+l0wwVtGwCE=;
        b=SzSsHyK5HHq4OlTn1Jk4jytRFsozxw20+Q71geKtTxmEcEWfpK+YiEgs5JxMcR4CNE
         SapuwtHKz1KA8RnNEpEkw0uT5haAriH5k5eiZXRf9TJTK4YuN660pR3xcYKbJ8E+fqC7
         MK+TPjNjcjgdRQtz8nQwUEDuMa9nQ+IYlzXgATEwOHY26mZ1rMYaJIoyg21erKgBYJff
         dcQ/nDdnj5wsF6VhY9WN7CkNMy9d2dIP6HGATZ6D8zqZC/8LKuyab/q5aD0ODc+kcnaO
         zXagb8grA2guAd/NC5xdLzZe6Wab8h7EVUaxfh/dFGmUZMPvXZjjE7yrz/p4OeR0zLec
         rEwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767880690; x=1768485490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jKmPkTdOWtk+ML1oyRZShyn9g+7S4FBzcZeJc6y38Q=;
        b=Ilfcfo9lhPbFoRwXYyeWTa35Ybnj14xI7aJp+J3RZeWzb1Y58ehXAKXbI2lCRWxjri
         9l1F8djK2AftPQ4aVHsRmcLERuPatxSLv0s7oGJrs4iVgh+Q3nBRw6By6yAt7TQoZun5
         3DOZnFeI1gL3oNBsmeZNRVGzoE+JoBHHr/hDfRJyQNVVuwSXuAHKy4BE5mzSQfcanEsE
         5Sd3iX50T/MSSzc+jdmaBFXlOVQgRzo3CCMFo5QBBWs6wM/lcBJpDS02fshclj7GWE5+
         mP7J+FTxRVOdCYbKDJyhFh3MSSuveyxcPSvMCTlpDu0Yw3hsQS5ezi1MiJrQ9lUieQ+t
         2RJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767880690; x=1768485490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0jKmPkTdOWtk+ML1oyRZShyn9g+7S4FBzcZeJc6y38Q=;
        b=Oqz2Q0D89771HB62nOP6cH9SQJfROIlBhcmx/Zq1E5SbtfqBMVwqHcG9OXjr+2PAuL
         N5gKDqSSG5RiArE+NEFK8JXGWvi6OLGKUsra2RDIPNG9MLpQVs3sydL024vc4zCPOqWE
         fHEs9ONV68Gs9RD9OoVFgTebPfCh+DfCst3T9AMnpFvNEl5z3vmOWZ5ORjBSJmVtLRFV
         hCcemFtURQ3IeTZfix5GqjxYbJGGWBGwT1XBpASQpuhIsPWBXpT2f1J/Bf3f+oY7akrJ
         AZPqtAKD+I2+G0Oxy6is2/OtPlDn5bgf2WJHNOW8X5HNrQhFQjJRw0avc02db9SNeTny
         sW4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWiBoOxpP1JwkT7FpnMFLqfbzfPD9DCwN4wIbe7cwFDuTX6wHxe56GvU0aU5Ob6ntc0GaFkO49vSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzniVFopJ+/HYMJNwOoi9dGUvJb7QdYk04XY/dFtWJ1yeZw6ka0
	NUZ5KkBmwAKojdAYzY+KdBteuUMs0DyGB3dUpA3wD1N3HhJfnraHd2DdCYiSJdFOAdgU+1x0p0U
	7diRCD43I0j160F812cVCwBcNAhOZZsc=
X-Gm-Gg: AY/fxX6twwlpHAGbJ5g/E60TRgb3GwLT0pF2+pkSHt+4YHQIQsc7rTQhcfAiUZX1pPc
	+bgZ+W3S47htEEma8h4gqbh0dWabg+6+pcVrGBFkLktUdsNw/93O2qJSp6P54oPcZ8xHc7dJ7ve
	oO6wvWryDLfbcMd99VDA56HlrkhSXFAZ5T4DrrMqjKD0suM8XnvAqxGZlO+Lb/ASP1KfoXVEXmN
	UcNPDRU8qiTHmO3t/qkv7lYk+jyNZJ5Xhaa0ppLpyWnnRpC7u81L7CAu40XIMTfD3T9YZocjjbc
	ffVswgiy9+Nmyz6lDVC+lvHHsAe045LVLeFBXY8dU8eMprTNwvrlXH7pLDUL2qjYCNXdP0wctHL
	+CytIi+3ucDcot6e9ecCNk4Y=
X-Google-Smtp-Source: AGHT+IHlnNhSjE3fiGAFdHKCvng7Zuc8n9ttJNcOcaKfOXOHrvEYhA907pjuVU71kxGKClIXln7ajb5XI4DP4iSFO60=
X-Received: by 2002:a05:7301:10c4:b0:2b0:502d:c27c with SMTP id
 5a478bee46e88-2b17d2b80c6mr2509787eec.5.1767880690160; Thu, 08 Jan 2026
 05:58:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-clk-type-state-v3-0-77d3e3ee59c2@collabora.com>
 <20260107-clk-type-state-v3-1-77d3e3ee59c2@collabora.com> <20260108-delectable-fennec-of-sunshine-ffca19@houat>
In-Reply-To: <20260108-delectable-fennec-of-sunshine-ffca19@houat>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 8 Jan 2026 14:57:56 +0100
X-Gm-Features: AQt7F2rtmhmzWGc_DLT6cTXt2EVzqLjQhI34cDZ6wkg42nM_UD7cfFl6t1r9_zk
Message-ID: <CANiq72=38RO9PGAMDtnTK8wj-yRSmg9UOfq7D6af7AwAKwn=DA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
To: Maxime Ripard <mripard@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Drew Fustini <fustini@kernel.org>, 
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
	linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 9:07=E2=80=AFAM Maxime Ripard <mripard@kernel.org> w=
rote:
>
> AFAIU, encoding the state of the clock into the Clk type (and thus
> forcing the structure that holds it) prevents that mutation. If not, we
> should make it clearer (by expanding the doc maybe?) how such a pattern
> can be supported.

One possibility to consider in cases like this is whether supporting
both cases differently makes sense, i.e. one for that covers
easily/safely/... the usual "80%" of cases, and another "advanced" one
(possibly unsafe etc.) for the rest.

While it may be a bit more to maintain, it may pay itself off by
making it easier to review the easy ones if the majority only need
that etc.

Cheers,
Miguel

