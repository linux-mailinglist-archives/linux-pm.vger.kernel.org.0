Return-Path: <linux-pm+bounces-35548-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 248C5BA8B04
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 11:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 08ACA4E1C68
	for <lists+linux-pm@lfdr.de>; Mon, 29 Sep 2025 09:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC352C2365;
	Mon, 29 Sep 2025 09:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V2Q2hkXv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB7B2C235E
	for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138734; cv=none; b=mG2dWX/LMzQ47EmR3ls8LH09tP/ZEBhiLHdalzNVpaUaFXlXXZBdAVHH5EswI+w6RRtYe0rmSO0NH/5ew6OcP8PntB5AGGJEW5cFKixF1D9FjKmto0sgstt/8hhDJ1aHkK8B8yLs9tI48DKyu8lpQl5P7sQNqmebCiTWyudWiBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138734; c=relaxed/simple;
	bh=5uH+LvoEI4iHG7AuV+rb+aBRzn1IhYD1uxOjR0lBqs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGig2qhmtb9XjFNJdws9VZQvyRLxakz3PxfFVjifq+Su7GSEvGK7l6tg/9bWxuuVaDGPnm8urW4q9PiEPJt/gRPPDJN/7yhZ5Q7XOXHEYX2aYAV9sHvGLweeYvLHk2wYrtYrsFobEB8nMJNQ8yQfs3AyHkhUB4PVpMwxQVEpJbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V2Q2hkXv; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ee15505cdeso3447255f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2025 02:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759138729; x=1759743529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmXRL3+AOO5eD+C5xVvr3oBjtZLeMgi3gjCsnw2jQz0=;
        b=V2Q2hkXvYyBllAwmRscSDMMjNk7F0Y5KM/y+CZ+4goC0JSnOKX06H/LhLmowhz3F0i
         kOK0L+6D+LDu+dLJgorPzvmeogQ1O8KxlPTPMcdd5SaoqkEc93vc6jwTGb9ukj4Rxdgw
         VxMeUjiHc3ev5F05XENESfFQv0TNbLnrMbgCxHvoVhmMRSeE1FiFTUDJ9/7hiMIQa09r
         xkNuEbVWKoIv51scyOnJnZOAo6lBjj9nALR1QY2qQ9yBJndicacY6KEhk7+PTZqjAD8F
         DCw1+LcPSge3ataFUxlszVka3VeobOPusCG5WOmZUr4x2qM9FLO+DLQgcEtzfTqrhc2r
         t47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759138729; x=1759743529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmXRL3+AOO5eD+C5xVvr3oBjtZLeMgi3gjCsnw2jQz0=;
        b=quW2GXw9Z+PsTjb68bxDVMDcFGxNvrBzRPYbaijRZlep3nWodrSpF5XbRqT6Hjkt5Y
         x2d3yI4c6Yge2FV7xbIqmuWcEvDsAuGcyWcbiCqbRhk+qEErm/47877uLV+6tuTmUIHq
         bcqsQbJwT4G7x09UcU4eYs5wVyohlRT9z+FjYW9hfYZKpS7KLsBCA9S8THH2quSYlS2o
         dEIEDvwe8VxOdewoFXuUeJchDLe2/TaIfNHy1tfbLopMdtUi7lowweOjiFFuRef8GbJ4
         IHvASG0kJj7+8eX2YkIszolwxY1lNGzfG1TkYAJ5EKO82H/ZkIRyNIFS3OUK6UVDxTcj
         HHiA==
X-Forwarded-Encrypted: i=1; AJvYcCXvrF+oiL3isOoKl3Hj2QtKW2yYnm4Lk4eYF9bfZvB0qc3kRzYGjGe5e6SGJyLG0qOHgpI3AuCHXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLM5FNCBKFEguv6043+O0nqZHKD7JdJkM6E6SiPt5JHH/p2sLf
	DuBI5RxGkS1VCV7RT76nODO4Be5ykH+eCWa1V29fTWs74TmM7ifMb3ZOBzvSAYC//K71ox0I+A9
	CNHI2u7J2UnVTb/ilwyb+mxaRnOQwasJJu/RhNcAz
X-Gm-Gg: ASbGnctFcdIB7Zdr2yqf6LQ2U/syh4E7efkQDXBEtPC2FMzwdD9sh1Vo+0cousKLJnn
	W9zdPYzRvR1MiuCNOgCwkWtv68TdxIqDcDV/i1VfvyZMwUGDHIzUKBDZfw1XJyU2AB9mIxQ7iTo
	OYap84WkmH9uxydLzmpPOB1ohyAtDygyAVDSEwCk8Thh7yLbutsphE5LmO6JWxZkZbBMzCNbwWi
	ZQmelW1JFLh0S4LwCvclJAIaZb6/e7XWLB1rMSgBpPFi1gXBD+b9PQ=
X-Google-Smtp-Source: AGHT+IF16DgZ+7ywtMeiLQa1MSZI2VtZgG+RmJTTzTn+yGI5kYhoC8WlQLJ4KboLi6SkD1Ym3CdKdkNwNyav2sERmuI=
X-Received: by 2002:a05:6000:40c8:b0:3ec:db88:bf1 with SMTP id
 ffacd0b85a97d-418005f50dfmr6649437f8f.12.1759138729294; Mon, 29 Sep 2025
 02:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915135954.2329723-2-thorsten.blum@linux.dev>
In-Reply-To: <20250915135954.2329723-2-thorsten.blum@linux.dev>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 29 Sep 2025 11:38:37 +0200
X-Gm-Features: AS18NWCtoSpHr44rzHyKkTO58WExQSeh2zI_DEs-0RDMqj1GhpnInyuLbAY2TzQ
Message-ID: <CAH5fLgg0_NBtfVMNBwXOe4BpyUKz_S=v0CiDxyKNYZcS9j7WHw@mail.gmail.com>
Subject: Re: [PATCH] rust: cpufreq: streamline find_supply_names
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 4:01=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> Remove local variables from find_supply_names() and use .and_then() with
> the more concise kernel::kvec![] macro, instead of KVec::with_capacity()
> followed by .push() and Some().
>
> No functional changes intended.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/cpufreq/rcpufreq_dt.rs | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt=
.rs
> index 7e1fbf9a091f..224d063c7cec 100644
> --- a/drivers/cpufreq/rcpufreq_dt.rs
> +++ b/drivers/cpufreq/rcpufreq_dt.rs
> @@ -28,15 +28,11 @@ fn find_supply_name_exact(dev: &Device, name: &str) -=
> Option<CString> {
>  /// Finds supply name for the CPU from DT.
>  fn find_supply_names(dev: &Device, cpu: cpu::CpuId) -> Option<KVec<CStri=
ng>> {
>      // Try "cpu0" for older DTs, fallback to "cpu".
> -    let name =3D (cpu.as_u32() =3D=3D 0)
> +    (cpu.as_u32() =3D=3D 0)
>          .then(|| find_supply_name_exact(dev, "cpu0"))
>          .flatten()
> -        .or_else(|| find_supply_name_exact(dev, "cpu"))?;
> -
> -    let mut list =3D KVec::with_capacity(1, GFP_KERNEL).ok()?;
> -    list.push(name, GFP_KERNEL).ok()?;
> -
> -    Some(list)
> +        .or_else(|| find_supply_name_exact(dev, "cpu"))
> +        .and_then(|name| kernel::kvec![name].ok())

This is a pre-existing issue, but ... this treats allocation failure
and non-existence the same way. That sounds wrong.

Alice

