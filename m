Return-Path: <linux-pm+bounces-16678-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CE59B528D
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 20:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D6A284681
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 19:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D352071E6;
	Tue, 29 Oct 2024 19:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="R91qr6az"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EE01FBF50;
	Tue, 29 Oct 2024 19:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730229409; cv=none; b=f9xCpyVXDBi3ow08g1suHAqIrBsN/D7SKEOcNr2IQf40NkiXoKpIqmfhKQcCQdlPatBcboRZBo8yBWlcwznuaV521xZHDEWZSUFQEMMN/Pd7BoMdGofly0FEf9oY8Mny5mr644IOLfDjjx6RgpL1CgjCsf/BEolZcIaYQBAvNJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730229409; c=relaxed/simple;
	bh=QsUrMu2XlZNY7oEUj/a/YTqiiYHE1xROUDsqVTOIbSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ryl+pvmZEgsPn7WdNYuqdZYzYf6qUiMzNjTyO756kAgTLoy1ZD9bR6CqHrUe96ggSIHbUmnEICqhq7HdGCgBp35+xmLV1ufHdP85VnYFbK2l1g2XJ/p0IF0Y8TVbqmfW1cNo6o7C9vfoIdp5vOMwz1ULBdvh2Qwpt3XwFRFXRfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=R91qr6az; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2F2F640E019C;
	Tue, 29 Oct 2024 19:16:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FA7FlAZbomgW; Tue, 29 Oct 2024 19:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730229399; bh=2OCmyKBsSKP5AzXVFymIxdlDz4cGAywN80+RPbEYwHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R91qr6azMOZlHRhNIimQ9MteMSSOooJh6ihZyyFYS7CpNy4d1ePk+/rpGQmRNi/H7
	 kblNBPo2YU34KrGLiUT+0XxMbjfCU5Xp1Cqb6zVKYI4jNuedYPoJBkHdMFG8k4S+AV
	 bhsjaGRfGB1GT2cba8oiv6Lfj6inT7qeI9+Ryxqm17ThLDMYN/zae28/At5y386cKd
	 iik8o3/G5knBBm3bCmg9WfySEzsaRGwsiT1wnFOgZnmnzDcnibfmGhkEta5xG8whZE
	 CJaploP0NU775aVDcuXfgAA7e2elx21+3VNWpOG6pfrG5hsZDf7dERDnbTSJHtHxl/
	 6WqxC4mPerUQe3pzmBdF8NlfNYPDsUhtJr/SlsiIIq7n6Euu9dQYx675unrntW4WgJ
	 V6PLRBaUDvjdERtJWHwEiDJBVkwKbnvlyHAZBT+QljVt2gBzXEh68JVXiDfTfxfute
	 8g1lj0Ws+Uz6DI3y4jD3Ybt21miBPJv8+BQHfPZyYmTlkIIDjDE+uzLlxAZarXXFka
	 xHO/Q6lbR1Ze4FpbvTZrB3JcyDerCmLSFZe7ByJ5yKlNQ9GoJ9OGd0lGNBiORflI0Z
	 cM+pR1w2dvAxM3HgBhPaZWAkxQWssR2zaIVyEXKmOjnQlERhH210uKwkCjFAgYQYQS
	 IW9sx+M4GhS0WBMv7BsxwxgQ=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B734340E0191;
	Tue, 29 Oct 2024 19:16:28 +0000 (UTC)
Date: Tue, 29 Oct 2024 20:16:23 +0100
From: Borislav Petkov <bp@alien8.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	x86@kernel.org, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v5 05/13] platform/x86: hfi: Introduce AMD Hardware
 Feedback Interface Driver
Message-ID: <20241029191623.GYZyE0h3364vdHHoxP@fat_crate.local>
References: <20241028020251.8085-1-mario.limonciello@amd.com>
 <20241028020251.8085-6-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241028020251.8085-6-mario.limonciello@amd.com>

On Sun, Oct 27, 2024 at 09:02:43PM -0500, Mario Limonciello wrote:
> +static int __init amd_hfi_init(void)
> +{
> +	int ret;
> +
> +	if (acpi_disabled ||
> +	    !boot_cpu_has(X86_FEATURE_AMD_HETEROGENEOUS_CORES) ||
> +	    !boot_cpu_has(X86_FEATURE_AMD_WORKLOAD_CLASS))

s/boot_cpu_has/cpu_feature_enabled/g

Audit your whole set pls.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

