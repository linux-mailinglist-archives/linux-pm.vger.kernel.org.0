Return-Path: <linux-pm+bounces-29151-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C229BAE1760
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 11:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF7161BC0FEB
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 09:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF68280336;
	Fri, 20 Jun 2025 09:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X7M/J3Um"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFE7280CCF
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750411234; cv=none; b=RHZ8Kqn03KG7PFA3rQOyecz1bynkoP0pusfk8FRwbq3PL+6euJwPa7LTZqmOzPosDAdSMsOBGbYaZjbAPHnzIN2uD1mev+7noshEUFcr62+M628c13vHwNYE9F2y/TxJCUQPNc2Qb8u1RGCaxmFGyJRIUN7gj8BYmc6lndxnfSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750411234; c=relaxed/simple;
	bh=mZ5vhEEnS31cSdEN8193qbJmhpsPbTggj6HeS32WJVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GlElDfk0+ui6xD80cwAuleaOJ17Sc9cnNNnkqs04jaDo9zsdRMSX5CYBE39DXICgTTPZE4o5mJPAOgbEUgsKYEfjEjFlIZKmWtDixdbmjbl0RQgeTccY20g5vaa8DAzFGxU8l+I/dRwW8rXHR0t/IaEUIGbbrt0wXXvXJ/5DDRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X7M/J3Um; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a582e09144so1057283f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 02:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750411221; x=1751016021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZ5vhEEnS31cSdEN8193qbJmhpsPbTggj6HeS32WJVU=;
        b=X7M/J3UmmjlvgncqVfIVgg/xzZ6W0Q8RvB+kCtrzmk9UEe3z9PSc9svd/7JTsMq3K1
         tDrc17g8bKSOw1WC1xHKOhGYSthMwAG+OcN1YN4Hq2BIm6simLJY8+8okc3joacD2p2X
         BOy0ilKtiPcxQHW73dNKdOQfIt1MJPEDcpsbiTEfJXm6F8t3f7WgrswFNiGpK9mWEPv2
         jMXlV54WBfqGV6yPV1/lszdm+QNOQ24AG2m9XHRfoZsTS7e8PlbG4PSRiqpn3iLcfCKk
         DYO2KvKNa9y3BGHBp9Zw20YsuRAb0FlvfKpHhNbY1kzKltc8dzR9LjTlPF9z7VjzSs0X
         OtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750411221; x=1751016021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZ5vhEEnS31cSdEN8193qbJmhpsPbTggj6HeS32WJVU=;
        b=OJS3O296ZOfKvileQXlAH94CB9JYRAqx3+ueuFVSi6a9z1AnXQKE7cCO9bVC4jeddd
         mIGo2qXsEWg+KF4xJ1XMi6XigQtzoJLuj3WNwVf27ul/U5g5g5r/WYBKprHJdluRLxSA
         JlDIIuP+MwDBLXHstPrnxk5qrzGQs5aFjB4ysi3pOTUK0DaxOhYA1fTW46Lx2RqA4dfp
         VtkDxFZMOB3NKkx4j/OzBrYIimF4NtBkXne8cHsE004UH1TFNQqDlJ95bIm4JpIknXM7
         sBSzoW6cJKoCguURsjEVaYVSFIjJV9a9vMDPzWttyvXCKZgE3c/bX72N7hKt75TqiXCl
         CUbA==
X-Forwarded-Encrypted: i=1; AJvYcCXfeZCVi9QNJcYYjeirWr9QG3mvlPwK0ipGutRyqoC8c+jyW4hrBPPFWBi/Mh7qvoILLeQ5Nefc7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz16xLBeqWquSucFbjLCoJhk0V9lps3RoB1BqQQfrSbg2gtoADG
	vZGQAyJQOOiUOQ6o+cOmUwdS20RjlEH8PoBg+UAJz1XqH8AISQmieormvtJvArb0pFp2ppu/Qiv
	LHfFNRYc2rPn1SZn3u6YA+BI1aKJqXudfXT4otRAl
X-Gm-Gg: ASbGncu3ApHUuLdSzPY7sIFwpEtYWd7tUUvgpJNtBGdYQefeEGQ5Dx9dEDt2VBrBphC
	fYq+66G1qBZvVG1PE0eP4ntM5Ua/tRU9UEGvyulNU7BypAKpkXcD8PCQESyu8GvoYxOYEujASOU
	KkIXXrZRx2folT03PIFETcQq/lwobMFUlD83Jj3KB64eXsQsem/7OvSAm18naogotTBUorEFrFQ
	w==
X-Google-Smtp-Source: AGHT+IGOxu/JyT8LKL4rOBc+Bsq5zNd0RaoYbcY7WBLcAPcbTS+9Tu0MnTso5BqDG5xDYUQ4UIo3GUoxMrDuhykIYPE=
X-Received: by 2002:a5d:5f8c:0:b0:3a4:eda1:6c39 with SMTP id
 ffacd0b85a97d-3a6d12db6dbmr1837913f8f.13.1750411221085; Fri, 20 Jun 2025
 02:20:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620085229.18250-1-abhinav.ogl@gmail.com>
In-Reply-To: <20250620085229.18250-1-abhinav.ogl@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 20 Jun 2025 11:20:08 +0200
X-Gm-Features: Ac12FXy-s6NWQAaZ_bmMiAF99B9M2tvOKWO1ll0w8OfTgwH-nexB-TDc0pyPKqU
Message-ID: <CAH5fLgi-QG2KRt6mAiU3P-tyVG_xevPzB6VK_W=is2B+7=63kQ@mail.gmail.com>
Subject: Re: [PATCH] rust: cpufreq: use c_ types from kernel prelude
To: Abhinav Ananthu <abhinav.ogl@gmail.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, dakr@kernel.org, linux-pm@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 10:55=E2=80=AFAM Abhinav Ananthu <abhinav.ogl@gmail=
.com> wrote:
>
> Update cpufreq FFI callback signatures to use `c_int` from the `kernel::p=
relude`,
> rather than accessing it explicitly through `kernel::ffi::c_int`.
>
> Although these types are defined in the `ffi` crate, they are re-exported
> via `kernel::prelude`. This aligns with the Rust-for-Linux coding
> guidelines and ensures proper C ABI compatibility across platforms.
>
> Signed-off-by: Abhinav Ananthu <abhinav.ogl@gmail.com>
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

