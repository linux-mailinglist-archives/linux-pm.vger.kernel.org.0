Return-Path: <linux-pm+bounces-10086-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F78919DA4
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 05:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 416D9284DE8
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 03:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F28BE4F;
	Thu, 27 Jun 2024 03:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RxHB2CqF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCE26FC6;
	Thu, 27 Jun 2024 03:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719457257; cv=none; b=Jm5I7ICMG7qfaOzyR/l7+ZA5fPO11tuRkLPFLBfzArhhUq6/OVmoAueaAK1uy7U54ud52nP3ooEVzLnhGLoWBWspo7I+ybKc2KH/Zth1j4Cek47cwLLnF4C1PLbxbpW0sVmo1G7JedOqwQcCZR17nXQSZAQ9PnI3JbeRLxTFZ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719457257; c=relaxed/simple;
	bh=WqZGsjNQqac+8MnivgotfefTlGfUXJbcBN+NkTQKZQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bk+9834dCqYsdSOKiCjkbjlblhecniVYraNKbJ5pX/a9eJhgtYYijFOA62+smv7RzkDWSmBj18mSd3wkLdVFXW4aru8742Qq9eCnaZjEykrKv4i6PU0VUf48pGxtRy80XODvrVLB2PKvAKgPI/EQwfDRegjF/O27/dtLETOnThg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RxHB2CqF; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 04D7540E0218;
	Thu, 27 Jun 2024 03:00:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DrsUvQUOunVS; Thu, 27 Jun 2024 03:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719457248; bh=AY4aMCo9kTgD3MRGQfEJ79FC77YpLM84z9ED/n/mc04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RxHB2CqF3t+CTlineP1Zx0d2XuVqSbkH0Yuxdm0FoLanZCGoA0vF2q3MAylyCpX3S
	 vs7GZfC8E/GmEGDA8g51CLOIpA3w9oPQT341E2uQPh9fLRxFPF2N8QUvhyq/McaJGm
	 iVeOXAxo1IddgqnBlndSK+FYVV7rBCetl+CI6AKUzDiQvlv0p9nsPZ+NO49nY3hvXd
	 Yh0ONb4Xxxpqt/uFxlQzEaGPccuzMXRBBfR4AIaLw0Xl0vH4uvgiP/lCUjBtUykTq2
	 mvEVvWkQ+s+4r6H1CuWsHv9FtFPIuCEwU7ABBFDntzZWSU5yK7ieg+PPK+59kv+nVh
	 d0cnS4VzfY2+ZhLBeZ0fLGNM2yffbmAf+CkSl2+pP/F0+r/tlYaoggzUm+AgzCmGsb
	 DJJXa8kGK8NQ8xq8Z1EwR+uk9txvvkLpwZDr3zkeauqjMYKth5VHT8Un7pBQxdnmF5
	 66P+oLZx1o35PDIwos6Cx47bKgy9ZklM+54auT5ukCv3kJJfqAcKaM1FOtz590SkOY
	 WRtzXJ5uEYncEmc6sqia6/hpt2l5jBfhyfpaEKoMazrlQb/ooCUhT9GsmDxQZB8j6n
	 m105RooDj41u3bw4QXkJehaV/z4NQF5cHA4iXuVUtxhUltP6wkDJGWoclilmqKWsq3
	 xPh9Iccur9sMubLu/d5V706Q=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3760340E01D6;
	Thu, 27 Jun 2024 03:00:33 +0000 (UTC)
Date: Thu, 27 Jun 2024 05:00:26 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, Huang Rui <ray.huang@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/cpu/amd: Clarify amd_get_highest_perf()
Message-ID: <20240627030026.GAZnzVyitzWW6nE_s8@fat_crate.local>
References: <20240626042043.2410-1-mario.limonciello@amd.com>
 <20240626042043.2410-2-mario.limonciello@amd.com>
 <20240626171421.GRZnxMbcI83xe1SLtB@fat_crate.local>
 <681732d3-76ba-47ba-9cce-362c6fe094cb@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <681732d3-76ba-47ba-9cce-362c6fe094cb@amd.com>

On Wed, Jun 26, 2024 at 01:18:17PM -0500, Mario Limonciello wrote:
> And then patch 2 or patch 3 change the "default" return to 166 and if there
> is functional issues then they need to be special cased.

Sounds ok to me. Keep the whole logic in one place. Sure.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

