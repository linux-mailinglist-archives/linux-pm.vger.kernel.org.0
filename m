Return-Path: <linux-pm+bounces-16680-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F229B52F1
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 20:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF75B1F23E92
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 19:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4667206E82;
	Tue, 29 Oct 2024 19:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="df0NzOxj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB30201278;
	Tue, 29 Oct 2024 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730231306; cv=none; b=IdycewDJpAETI8KlPP+jjeaFdvt3KKxNpOOTxorHReWdpA0fkDa2S0DdmBiO0cD5yy2u/ev2frugEPtrXGG7q68ci15rLM3qmrvwNvL+wMmdMxfM4gbtzDQJgNxvp7VB93FN5+E4vo9nLwYxG2iYutEJYO20iV9Fo4M2xK0pZv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730231306; c=relaxed/simple;
	bh=n4zubNauW7GQZGD9zvxgDqkR9SSfYZZnxpVh4hymT8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nr+gHP6JPWA/uH8Oi5ZmlrOEvfpkUrVrU05L6rFdrvTCO+Yli0/L+FJtGII3dy/pyH6VRr1Uyx/Xj/4XOYs7DoBlKcknx9+/eA84l/IjlcezonzsL9tRagEIA7xgaB3i3FTDWHkhu/K03W9tnbABYDvl0oLSyCIX2APWcjwhV9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=df0NzOxj; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 978B840E015E;
	Tue, 29 Oct 2024 19:48:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LFk4d1L4uNOe; Tue, 29 Oct 2024 19:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730231298; bh=3aZaCKYafuDAobx3wo1Re3zVP/rK19NLI1fHUmG8Wu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=df0NzOxjowmWTMy7vYkAlbV/1ealXAGedtg+vyf+dvIlRy05Oyw1UkCV78LBx25jz
	 YYxkFrEyxFcN6X8770xGEMo+BDPrwgf9GTzMTpbwWcKlP2J5bUJJzNVVc1YtKZKceM
	 KIosyZ2FbylwiLMGC8DpizlqdNy+Y7pNTqsnscBysspB7+/odvNLSyePJMvxxaI+8i
	 6pH7YvEk2n+/ajhZO79oFr2M8wqkxKMVTh/sB+UdSc9x7zK+R6cgVZg/nJRRSdV0j6
	 Me7Jsw8IcB4u2S2ohv0o23q5eraZdu+ScpHVjmvlTMu7Y2ehLS1hOLGIjC2Ztxyc9e
	 FK0MWZh05tVDhI/5sNxivSSEg/KnMIiGAIwqHbY3Bt4A7eUU/0VnQmMJBG8zWhOZyg
	 Ifqh6nmDfqj178KGzlWO0LLLDImBXC92hnR28UYZdYrHKVG7XbMM5wphGKLDyZyfwc
	 Q28sLnKnl+ZxZtdB83Pe2CIrY+73UmFzvy0WeqUUPNT3MId8UVieHnrFaHqd2adttD
	 EcybjxEBIDVqYEG9vpn4qvBtflf1UN+HDQ5y6YPHY8lk3zdkYYjacZJgSSh1NybiMr
	 cqGofStA9w1n/wGK6bbyqna188h2sDEiQm9t5qlY6xcg8cKTaaKcq5bPQT7DfeR7IR
	 mJUhOKESNq96W6FBuxu1Cxdc=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4612340E0191;
	Tue, 29 Oct 2024 19:48:07 +0000 (UTC)
Date: Tue, 29 Oct 2024 20:48:01 +0100
From: Borislav Petkov <bp@alien8.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v5 10/13] x86/process: Clear hardware feedback history
 for AMD processors
Message-ID: <20241029194801.GAZyE78b5j1skQ0Kf_@fat_crate.local>
References: <20241028020251.8085-1-mario.limonciello@amd.com>
 <20241028020251.8085-11-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241028020251.8085-11-mario.limonciello@amd.com>

On Sun, Oct 27, 2024 at 09:02:48PM -0500, Mario Limonciello wrote:
> +__always_inline void reset_hardware_history_hetero(void)
> +{
> +	if (static_branch_unlikely(&hardware_history_features))
> +		wrmsrl(AMD_WORKLOAD_HRST, 0x1);

Get rid of all of the other crap - the static key and that
reset_hardware_history_hetero() silly thing and do

	/* Reset hw history on AMD CPUs */
	if (cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS))
		wrmsrl(AMD_WORKLOAD_HRST, 0x1);

in __switch_to().

Nothing else.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

