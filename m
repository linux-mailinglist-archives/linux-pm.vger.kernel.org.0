Return-Path: <linux-pm+bounces-40908-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3EAD22EEB
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 08:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC5C5308559C
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 07:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF9632D0D3;
	Thu, 15 Jan 2026 07:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKW+Q6pD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E951A32825B
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 07:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768463360; cv=pass; b=rJxMtZyUb+djDHQyWXktWMbXAd+VLSl4wDnSwUxl+5tD4Y+6rvH5VVfw/kLzyktnvgHRLvR2FhIrZu7uaeUcg6bHnQMrhrcgD8nT/mJhjGM7i5z0KrIR7Mz0H78TgAXE74S6p7DxqGdasYXIQfMKtIeBwRCeSLFruPMiQr/2v18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768463360; c=relaxed/simple;
	bh=nOQz0muhgLoELpd5FN9SYvUUu2wnEMl9sQ0vYgazaxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pQY+NJpHVmb0c6YyEBBMTTlXQeREhedyg99eckyyb8Z8eS2h+PZ+UA3GCKgd8YDaYBG7AKL0/JAiHPbS5at8qO1rQnqxpnqmQwPAagVPxQg1T1kGxQ+sVKpPbo1rvG0nPSByayovAfUhOCrqgZguTnvYFW2hnjapz1C+0Poeiy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKW+Q6pD; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ae60d8a05dso85544eec.2
        for <linux-pm@vger.kernel.org>; Wed, 14 Jan 2026 23:49:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768463358; cv=none;
        d=google.com; s=arc-20240605;
        b=JlFqxfg56oR9JB/xZT+31stIFHqhNwQIb0E385k10y24Ts5AzQivBPaizWzuf0b3Ft
         FOJLym71ND7WCVJYrUk2ABDz3HbqC+cBNNuSwCq4ndIy2dxFvsbljyeJZGOaBFzAb444
         wLp3Z3OT190ikBaXB1n6dFGzmT4L/3JoQoI3Vnd72M39+l4c4JLqT+EZwzdud0ykSR/O
         pbjigBIIO/KVMuQ9ZYnm071vYTrSypmLY8LHHq1sv7LueoTnrr8gmZEuE/vESl1Zmr+0
         tFN/jsKGSvYSZWegGjwECyhJp8hQ49ifjiws0TriP+4x0BJcBJ5M7jxrGMkxAIzOOmdx
         gPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nOQz0muhgLoELpd5FN9SYvUUu2wnEMl9sQ0vYgazaxk=;
        fh=/BGf8WCxAmCbpNXQRUFh2/cP4coAefCRyrGdFX26F+k=;
        b=J3aprkCDQwR49NVFSDMVhS6a2hqZ+NVjWIq/jJxyBCSlIqKzl9bscGIhPjiF2teGs1
         Gb+0sZtaSABCq+jcXkEWqdEHUYEKavG/8PvfPm6gbupItCZgrWqLq+rXcU94qJajYyA7
         o6yes45URPJT5AHcXXd9FVh3lZa/HWpepj++DHYn6DrEOpcQFRrebNybX7NWvDju1q+N
         fyvPQptuxVVzzN1ByXI5FspSuziExstgtQPtKPGPb3y1VLgiJCmIQgNVhqMHnbfSKXCV
         /cQ8YaGgi8TJ8I+hMcRQiLQOfuQeKPdqaicU+rZ5yvtxY8hMvtCpDsPqHajnjKwqcQJ2
         P+Ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768463358; x=1769068158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOQz0muhgLoELpd5FN9SYvUUu2wnEMl9sQ0vYgazaxk=;
        b=NKW+Q6pDTwy+lHxrW9/jbrOIO2fXs60xw4O5+ZA6cc1ofr7oQC0w2PymPmrXox+n2A
         mOOETmZ2Gy4by/WtC8f4JQvihVyboi3HVD10A4iwW0jZ1p83k1jbFzYl4BpFOjcZ+cIf
         11XP0Opfoax+3yI3nqfvI28QTT5bXbUC+PM4lkmTc2aBuMmYClYmlj4pVlJuoQ2qlPIB
         NBW7slOfbR7kgeDErZ8DM+usaM1ZgU2YGqvbDn6wtoj/JfEAxvNSyidZ4TkkqqqW86Sl
         nF2T2/EF+UD9zQZ7lhMgDse7xQ/fPe8YmtL59cANi2eNhzDyuzwv0irID7dzWJ88+D81
         83JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768463358; x=1769068158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nOQz0muhgLoELpd5FN9SYvUUu2wnEMl9sQ0vYgazaxk=;
        b=reH1Ulr2AI8RcHk1bKKwsQQLc4DwVNi77Yn0Dn/Yjz306RN4sQnPUvUf9F+7Okw6ao
         UiTZnYCDOu3wdmMbxGiU6W4oMy/2PqAYCx9OR8CZYXjIgWjWcMZyDY5I58b9OraylLRG
         VVQS2zJMOX7aDdyao7yF3LjerOr0mCDxtFI5BRnXJrOXSwYXg9tNfkKehDjpYEliCyhJ
         TOAdpdIsCycrvC92dFbG9AwGg1lK82P97ZDd3UEITGW+JJ309YBtvmmSjdp7Gbod8MGf
         lOjpP1IvZC0m6Dp2GsneQHfbwVm8OOAQiEtOOXR4+WzAqx6uhWtrmJO2ydquoNgdbeeG
         0sfg==
X-Forwarded-Encrypted: i=1; AJvYcCWfKKHaVyAB7MBm1xdr/5kpaIkSNjVMBz4NPtbHiw1n4lUEUBuyjTWuZ6b6Rg8KSLKnStGKgAtBhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJmxgGuqU3VMpPU/jMvidPXuMs/60JhgOthcYKszlStbiE4bS3
	0MsmQc1n1TLlIQBOP1A1jwXwfVcPR5AGNnJX5BkQM6LA9vSLBt6f5dpb3s0yWa3EdRPVZvYIzV2
	azfaIKJVFNHZbFX7+v1X1p+HBA+kMA9Y=
X-Gm-Gg: AY/fxX4gDx/E/nbK0I2W0vVWu0B2l6fHBTReQeIfqbJdRKS2CcljRI9odGZr8ZeVfS1
	AnlXDSJp1/MdAVOgPlRWxJIlK9GgIvr3erPd90f1KB6jK0RcWDzJhJtrUC66BIQ6kb4DXkvY9tE
	izhbUzKXy+MsiiBj6WeTX5xmq0UYMI/hV2awhMuJ70VY2Kz+bDGQRXqzpfG0Dj7tcprTOVoe+9E
	WDzm07O0e7UmlV2MyrACOSwUxi3e40+ST5h0hDbdzX84RKxw5YOoeB9BBrl58VKTdZ/hN5FzZuu
	lY/TjDaVgVX0mDz4eV9MG5iyea2dM6wNO280UCMEQlFXVog8+QqGIltajBGjj03k3nOi45rH70q
	6O7trkiCwD7mZ
X-Received: by 2002:a05:7300:3b1a:b0:2b0:4f9a:724b with SMTP id
 5a478bee46e88-2b4871e9771mr3815587eec.6.1768463357956; Wed, 14 Jan 2026
 23:49:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com> <20251208-io-build-assert-v3-5-98aded02c1ea@nvidia.com>
In-Reply-To: <20251208-io-build-assert-v3-5-98aded02c1ea@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 15 Jan 2026 08:49:05 +0100
X-Gm-Features: AZwV_Qh28YVcYO6VVyfidVd7hc-EBw_qgwEmENRAhtkTb9yLXtecSM5NN0ft-tA
Message-ID: <CANiq72=U93ceCxLH_HYesCvCywpCsou98kM2Z53x=cx=iVXm0Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] rust: sync: refcount: always inline functions
 using build_assert with arguments
To: Alexandre Courbot <acourbot@nvidia.com>, Boqun Feng <boqun.feng@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025 at 3:47=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.c=
om> wrote:
>
> `build_assert` relies on the compiler to optimize out its error path.
> Functions using it with its arguments must thus always be inlined,
> otherwise the error path of `build_assert` might not be optimized out,
> triggering a build error.
>
> Cc: stable@vger.kernel.org
> Fixes: bb38f35b35f9 ("rust: implement `kernel::sync::Refcount`")
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Boqun et al.: do you want to pick this one or should I take it with
your Acked-by?

Thanks!

Cheers,
Miguel

