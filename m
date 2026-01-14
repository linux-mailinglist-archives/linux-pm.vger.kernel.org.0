Return-Path: <linux-pm+bounces-40878-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64158D210D3
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 20:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6684D301D627
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 19:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA76432B9A7;
	Wed, 14 Jan 2026 19:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/pPVVnx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A0A2FBDF0;
	Wed, 14 Jan 2026 19:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768419446; cv=none; b=AMK6RhaBb2PZVPz7SE/tykvMpSHBQReC4kxepbbop5PlxhfHlQHUDZ2p29mJ0qvvN/wYTRHHzVg92Mzcp41QdT6hojSzfwrqkI1Ykg3EIg0njG8LWVQ1wgpzEs8dT5UJEfEJRZW0ScwOdsn9uqllp32XMKGBcI0M0O8MCME1PFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768419446; c=relaxed/simple;
	bh=gpjWR6mV8zEfx/lFoa1psD5J8e/g5WdQMimKlhrES2c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=tLqaPpu8NAcfwcyqY4GL6r8R3/1YObkOlRSt86RUwO85GkJ56uHsSF792qgd+62ro8bHbmFq74PHgJ4tGGgX0M6LpAdnKS4Us6wBEkxFmGG1c5IyJri9BCLzvcJrdpXHNt1jFzXstpYACapTUruSzO80Qbv+hE9QwWoJGuWKhuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/pPVVnx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E27C4CEF7;
	Wed, 14 Jan 2026 19:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768419446;
	bh=gpjWR6mV8zEfx/lFoa1psD5J8e/g5WdQMimKlhrES2c=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=N/pPVVnxxhiavK9yo7XCGYVKuSRIbmnu2mc94frq4KMY0S6bXoI/BO54jW9KQCAPb
	 ffBNzlyKuZTYTwzw8DWZsbCd62Oo7oXPMNxSaK4DETDSkTH1vkCrp7OPBNMKcKMzmu
	 +rnqXDMmYs6QjT1wUKAZPmuStvFLCmZ4vx1/5D3c/oKFtxEZlvnzTpIc/UHW+2wz42
	 B6v1YC8VKf3GgJvq8TvD/HUhKvFaK+OMnp0o/CeDSF1txB/DFSS0090IdkUto+lls3
	 u0wuxXntUk4NsoWVcbB0z6U/4a9NsjFLVi0M/cKHM/EZm5MqYaupCZNfl07pAPpa5p
	 3cGG2QjOEKT6g==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Jan 2026 20:37:20 +0100
Message-Id: <DFOKDFM2UW4X.YA1TI202V73F@kernel.org>
Subject: Re: [PATCH v3 0/7] rust: build_assert: document and fix use with
 function arguments
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Viresh Kumar"
 <viresh.kumar@linaro.org>, "Will Deacon" <will@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, "Mark Rutland" <mark.rutland@arm.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <stable@vger.kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com>
In-Reply-To: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com>

On Mon Dec 8, 2025 at 3:46 AM CET, Alexandre Courbot wrote:
>       rust: io: always inline functions using build_assert with arguments
>       rust: irq: always inline functions using build_assert with argument=
s

Applied to driver-core-linus, thanks!

