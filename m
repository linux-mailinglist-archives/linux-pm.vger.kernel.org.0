Return-Path: <linux-pm+bounces-29252-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD76AE35BC
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 08:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8554416E12D
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 06:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557F7136348;
	Mon, 23 Jun 2025 06:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=7pot.org header.i=@7pot.org header.b="utSAW2vt"
X-Original-To: linux-pm@vger.kernel.org
Received: from lalande.gnome.eu.org (gnome.eu.org [95.216.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6763CBA33
	for <linux-pm@vger.kernel.org>; Mon, 23 Jun 2025 06:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=95.216.32.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750660349; cv=pass; b=Nl5og35SstsyA+c/PlAgRWzFnrtx+WR0589I+jakj5bibuv43Q5EhwKtSWd9ZhMHm7O+JNH+N/P7bITlLjEoHNSgBjLLOkWMCek9Zyo8sDpmpgleKx1hLM9mQgkdOA4qTwwYKViuMp5OnKzwFjj7UErv5gtQnkYnn4wSdU4vg0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750660349; c=relaxed/simple;
	bh=3i2Uv1Y3z2papHvCGhrL9ZVJnsIV+y1RWJFgcWMXDSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Za9PX/AsvVHnSUNQJDZQzDOpV3vq6IL9jReP6jFPjzaRVtTNUEr2mh9MxFDVQPQPG1sF5dcMh94xsGCNj4fuglhRq1chI9e/e9XAfeNQLV9Red1EuAx/p88iz2QICuLMGq2E3xLMHMrYPbWf9Of+auQU0u7/CKTgvph1xLKNh84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=7pot.org; spf=pass smtp.mailfrom=7pot.org; dkim=pass (2048-bit key) header.d=7pot.org header.i=@7pot.org header.b=utSAW2vt; arc=pass smtp.client-ip=95.216.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=7pot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=7pot.org
ARC-Seal: i=1; d=gnome.eu.org; s=myselector; a=rsa-sha256; cv=none;
	t=1750659937;
	b=laZklOtGP/l2nhKfW4eZG6Fc0fJGYsQEFKDWKHPAZep0wzBcbE07QaQ5b2xt7Gg6mfch
	 PqUap797j+KgzlCdz0q6MNhvMp+7vNF5HegvYXizCvG7OzbZtttdXda5OltHM18oq/d+O
	 D6bhSnsxzIKGz/gBuW+RKkfRjYbsu2IfG8=
ARC-Message-Signature: i=1; d=gnome.eu.org; s=myselector; a=rsa-sha256;
	c=relaxed/simple; t=1750659937;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=3i2Uv1Y3z2papHvCGhrL9ZVJnsIV+y1RWJFgcWMXDSA=;
	b=wIAo7W20GpTREiHQS0WZTW4qMamZf2zlkwhBDem9RVtxn3nMSrVEl2SnR56XwulwHEjN
	 y7PaoZn0Q5WntnazsvwHjFBqVtfK7vai/+iJETJwsquoV7sEarbgigYwBlzQ+ZOBl1m60
	 tknxlibJRnocxsIE/Ci0BEzYTs3EZd6n+E=
ARC-Authentication-Results: i=1; gnome.eu.org; arc=none smtp.remote-ip=82.65.226.101
Received: from leto.ms.local (val50.gnome.eu.org [82.65.226.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lalande.gnome.eu.org (Postfix) with ESMTPSA id 50D007B2565F;
	Mon, 23 Jun 2025 08:25:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=7pot.org; s=mail;
	t=1750659937; bh=amTgSERN3utDvqCGxTJd0cMQf/6LQr4T4DXQKPu/7OE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=utSAW2vtalgYTldcp+4+rJEGp3n0SaHJAHpZzIh6pHZZVvV4VKRl0C9XlL3aBq/ga
	 zv4uyJYMTlpfw1k4O76P/VfE3DHphMpHieOz0BeumQx3hsnvAtan3H/LSg/hPmB4w2
	 DTZzovfMYa06QuIK6t8V6WL1s8dXq7l6wwM4PQr2p3jhDNU6y4ohJV/U238dKF6lkO
	 cvTgydSRQudOOU+75KYM2ceKGVKbhskJj/Ww5HNaW5IPcDYJma3y9ElQjqfXbl/tfi
	 cI7IS+I5+LMRC46+CIJi6Jl4zmqjEhmetUp7mr1U4qATcobLK4nIIWQa5Z5EHF9bxa
	 myQRu+5ayU6rA==
Date: Mon, 23 Jun 2025 08:25:23 +0200
From: Lucian Langa <lucilanga@7pot.org>
To: Mario Limonciello <superm1@kernel.org>, mario.limonciello@amd.com, 
	rafael@kernel.org, len.brown@intel.com, pavel@kernel.org, 
	gregkh@linuxfoundation.org, dakr@kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	bhe@redhat.com
Cc: christian.koenig@amd.com, linux-pm@vger.kernel.org, 
	kexec@lists.infradead.org
Subject: Re: [PATCH] PM: Restrict swap use to later in the suspend sequence
Message-ID: <dn6yc4swdyek4gz3bv7g4y5e6xzmo6vm5gkqqhmhbdhomnglbt@nsepw42i6hwz>
References: <20250613214413.4127087-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613214413.4127087-1-superm1@kernel.org>

On 13.06.2025 16:43, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Currently swap is restricted before drivers have had a chance to do their
> prepare() PM callbacks. Restricting swap this early means that if a driver
> needs to evict some content from memory into sawp in it's prepare callback
> it won't be able to.
> 
> On AMD dGPUs this can lead to failed suspends under memory pressure
> situations as all VRAM must be evicted to system memory or swap.
> 
> Move the swap restriction to right after all devices have had a chance to
> do the prepare() callback.  If there is any problem with the sequence,
> restore swap in the appropriate dpm resume callbacks or error handling
> paths.
> 
> Closes: https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Tested this against 6.15.3 and 6.16-rc3.
Adding my tag.

Tested-by: Lucian Langa <lucilanga@7pot.org>


