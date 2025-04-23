Return-Path: <linux-pm+bounces-26025-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FDEA98924
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 14:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F1A5189375B
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 12:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C7D202C58;
	Wed, 23 Apr 2025 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZSOgX2A"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E401FAC48;
	Wed, 23 Apr 2025 12:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745409937; cv=none; b=aGy/86B+oc/yoiM29Ufx1pqPfhdduON/+4re5ypkrCiiaGgEwYNeEqk43EIcFqp013ZQePh5h9hgELT79sE4FAMAXdmak7yEZFH6AX+Fk1i8cGdZbfE5qLE+zYR6yGp4EwMf3T/gsES1A15gOalivBYSNF/+IfRy2FboW7we9rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745409937; c=relaxed/simple;
	bh=/kvgqZE/r/9J65nWsx0jZLdM7cszgoACFIAVIubFz6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CG+BQG5CSwRFvoFcnXmpjubMucHYN+8b9l4pbb8pdMl9EQiTVA26czBYPYA496mfwSUEzEchCQutEWqtnaVe2CuHfmNwNBVDcJLSTdvFvmYOW9UWZTyOJ9oSCaHg2aS62i+TBtk3RoCQzmFecbCQzQh/mAt8ytpNkBZH/qSbclo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZSOgX2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0431FC4CEE2;
	Wed, 23 Apr 2025 12:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745409936;
	bh=/kvgqZE/r/9J65nWsx0jZLdM7cszgoACFIAVIubFz6g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gZSOgX2AeGB8+9oCfds03dU+/3CjtDIKs7ApO7jTqWn/6LE6PgbCvcBtze9v635ca
	 Gdm5wZ68NHC+wYc4odpYaviMxaEMNQB9ECYKjitrPKoMHLBYPasycWpQy5cv84D5zF
	 P6Iqex/KJSzVPEuR/OHa+m8nXhhO/geMQAvXYpG/ktAGTnHgvvJxCH92GmtAlMIPex
	 v8sC5CM5c+1NkQTaG7gSy9AlVGRVLi7d0i0BRdLcFhDCFGfFCXxwHOzZNKjc66caEg
	 771mj5tifrwmGsiuBK3hWjNS5Zz0Eb2HmyFLBBo3HbgTBMzGOcv7uRH0n8RtS08hXM
	 Ck2fEWXt/rhIA==
Message-ID: <975c8346-dddc-44ef-ab24-71cadfbce23a@kernel.org>
Date: Wed, 23 Apr 2025 14:05:29 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V11 13/15] rust: cpufreq: Extend abstractions for driver
 registration
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Danilo Krummrich <dakr@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, linux-pm@vger.kernel.org,
 Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd
 <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
 rust-for-linux@vger.kernel.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Joakim Bech <joakim.bech@linaro.org>, Rob Herring <robh@kernel.org>,
 Yury Norov <yury.norov@gmail.com>, Burak Emir <bqe@google.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
 Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org
References: <cover.1745218975.git.viresh.kumar@linaro.org>
 <a14f6927488b5c7d15930c37a3069f46a5c888a2.1745218976.git.viresh.kumar@linaro.org>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <a14f6927488b5c7d15930c37a3069f46a5c888a2.1745218976.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/21/25 9:22 AM, Viresh Kumar wrote:
> Extend the cpufreq abstractions to support driver registration from
> Rust.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   rust/kernel/cpufreq.rs | 490 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 488 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index 5e0bfd03fd30..8628f0bada02 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs

<snip>

> +    /// Registers a CPU frequency driver with the cpufreq core.
> +    pub fn new() -> Result<Self> {
> +        // We can't use `&Self::VTABLE` directly because the cpufreq core modifies some fields in
> +        // the C `struct cpufreq_driver`, which requires a mutable reference.
> +        let mut drv = KBox::new(UnsafeCell::new(Self::VTABLE), GFP_KERNEL)?;

Maybe add a comment that it would be desired to make a struct cpufreq_driver 
capable of being declared as static const in the future.

Either way,

	Reviewed-by: Danilo Krummrich <dakr@kernel.org>

