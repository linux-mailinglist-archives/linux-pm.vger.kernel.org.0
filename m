Return-Path: <linux-pm+bounces-32281-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA3FB249ED
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 14:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EB703AC884
	for <lists+linux-pm@lfdr.de>; Wed, 13 Aug 2025 12:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6B62DCF5F;
	Wed, 13 Aug 2025 12:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ir2uAtIo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AD12BD59E;
	Wed, 13 Aug 2025 12:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755089734; cv=none; b=BkJqqZCA0SCD626E/VTiZK3MHfDM2TfRsm6V8dASRA5K+WisvBRnq9r70zGFLeR68ZQtffqSXPWRyWwmNpOKvPavFkksuHtQ6B8sE5Vs0O/eK8j+wO6qNJ/TVBBHxrk86Lu0Hzmc5vQfzSnqm7mF+R59UmXaQDjTm05lG3zTXvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755089734; c=relaxed/simple;
	bh=JUPvu1QqNaGLsr9Bc/71i4YSzV1v5u9JepoTxOxcBdc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qzsrSM+T3ASbyjwLUnAtZ7A84mYpTCXvQpALT2CVGEXOE8zSB4dh1eUaB8hzNRf63YwJwYiDWPkrA6eT+Z9sWLTf+D2jvUtWTjyrFS8MGwAtmVF3WK95CgYSxTKH/HKwcC+KdfU6+H+rpo7aoq3mjBLIFgPai/E5/TgRpuErb88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ir2uAtIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14969C4CEEB;
	Wed, 13 Aug 2025 12:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755089733;
	bh=JUPvu1QqNaGLsr9Bc/71i4YSzV1v5u9JepoTxOxcBdc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ir2uAtIotgWKbJUSQjEsL5cVjXAgRHNFVB6vE3rX4MOZTvoUA988R3K/ZUcmECEOm
	 e/ifFSnN1AoKKmRjSOizt7hFU65Koybs4NnDuedk4tSnpUWh2y/ZQ6/JSLrnxQdyVj
	 as/V8H2HYa0+ukxXCmxyX1xVpeSePqk5QruIgPkwVd0QemjEoRsq+48Kjbdc0gShRw
	 BAghmAnbZeep/x2HS3I80MMkHNWUyjAz1OCvpm/YK5DE1pEvMXOvLvLC6aDFBh4vRb
	 +vsc9/YsNJY4Az6/vrL9Del3QP0ENejpVP2Hl0674IKYsaaAMUhcMSB0JpAP5MrBkk
	 qbinga75Upg2A==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Aug 2025 14:55:29 +0200
Message-Id: <DC1BDUUPAJ8H.3L77AGH012M7F@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 <linux-pm@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: cpumask: rename CpumaskVar::as[_mut]_ref to
 from_raw[_mut]
From: "Benno Lossin" <lossin@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>, "Viresh Kumar"
 <viresh.kumar@linaro.org>, "Yury Norov" <yury.norov@gmail.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250813-cpumask-asref-v1-1-1242aa8e0cfc@google.com>
In-Reply-To: <20250813-cpumask-asref-v1-1-1242aa8e0cfc@google.com>

On Wed Aug 13, 2025 at 9:54 AM CEST, Alice Ryhl wrote:
> The prefix as_* shouldn't be used for constructors. For further
> motivation, see commit 2f5606afa4c2 ("device: rust: rename
> Device::as_ref() to Device::from_raw()").
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

> ---
>  rust/kernel/cpufreq.rs | 2 +-
>  rust/kernel/cpumask.rs | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

