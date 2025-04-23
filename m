Return-Path: <linux-pm+bounces-26026-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6736FA98934
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 14:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00FD21723E9
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 12:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F19F207A25;
	Wed, 23 Apr 2025 12:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWx5hdN5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD68F208A9;
	Wed, 23 Apr 2025 12:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410146; cv=none; b=QuAGgSvRmdxMYJfx6+8sXRCz0IkStGDT//IyMg4+tR+uTb/olVxjuZiVcj9iotebrz8uDq2zgI5YiDUGd53GjvXxvy6+XLopU9l8gdp0rJV3xEb8ApScco9H97OPqAw89KksW2RGWt80ti0bUpoaHWZNipr0xjDHvnWxrwdOJ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410146; c=relaxed/simple;
	bh=rBiaqGBPCElmEzZ+5wfIrPrM3AKKyQXofjwr9Aov8cQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DUwajJ2PJebExIMM3Y+X7LMEu4qnDPYPaG90ZjLm3Z94Z2Yz2DjCuBG6owErW6V14c1nV8iHM6mZgbCLkZ0a6snfCc9tm9AKcV0YkduM/cyBtxTD4k3wY+iuzY+F1ZV4PAcnlVwyxkfKLyzbtE2bHZFkqMdMv1U8M0yB+z7T1DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWx5hdN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8291AC4CEE2;
	Wed, 23 Apr 2025 12:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745410146;
	bh=rBiaqGBPCElmEzZ+5wfIrPrM3AKKyQXofjwr9Aov8cQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AWx5hdN5dLBfwcSkYmh0RG9fgAXYNiMw+P/n4vyz7mXlRkuWq4jWkF1cMYPSnV4i9
	 hdaHsFktOi6wX19ZrUoAKn2ZzlInc2BoqFSDeDAh5ibBhfVHkhnBaqFGhZKwOoKuUx
	 wyfelp5qf7sd9yCta8VhrVQ0rSA30jHf9AIkbeAawLOSTOSfuPpJOhw+8yrMO05/HU
	 41LiIvb2aCfZPbQ4BZ6sMhZuG0ywJUNYXoG/J891RYs4YakfhRESNYsCgy4x2y4Cz0
	 BKg8UQd+EYCmYzGYmrXkXqTGXw6CQJNrUjTVNFjc7t/d4RXnsiQ8r7Y4N+if+iFnp9
	 fMx1MaKwPL6jw==
Message-ID: <6fc3e178-60f9-4b0f-9c56-6d983e4d1eed@kernel.org>
Date: Wed, 23 Apr 2025 14:08:59 +0200
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
 >
> +    /// Same as [`Registration::new`], but does not return a [`Registration`] instance.
> +    ///
> +    /// Instead the [`Registration`] is owned by [`Devres`] and will be revoked / dropped, once the
> +    /// device is detached.
> +    pub fn new_foreign_owned(dev: &Device) -> Result<()> {
> +        Devres::new_foreign_owned(dev, Self::new()?, GFP_KERNEL)
> +    }

Btw. if you take it for v6.16-rc1, expect a conflict with [1].

[1] 
https://web.git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git/commit/?h=driver-core-next&id=f720efda2db5e609b32100c25d9cf383f082d945

