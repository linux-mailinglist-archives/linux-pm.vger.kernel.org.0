Return-Path: <linux-pm+bounces-9415-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF3C90C7A0
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 12:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAFA0284276
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 10:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BAC1553BB;
	Tue, 18 Jun 2024 09:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="iFRi77EF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB65155359;
	Tue, 18 Jun 2024 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718701686; cv=none; b=Or5dG6ucXJi7oFNdeux+Ey90QrKxIVv8Bh2ZOxiPLIC0s1vqT7GNv257yQ+IDrFJCr2te4K5Bn3d39wTClOAAHaz3dwuac+jBWtiHvmwetnuz+NbxXgcgLczHcI7U9R2dveDi5mwMQkfYO3ac1YtrWi+kHrUPlMcQXDC6x9YSIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718701686; c=relaxed/simple;
	bh=aWEOLZxVcmFG7Tnj8nKoIk9Y+jEqw5pv7TQtLuUW/GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bU2OC+Q68S98YqIggNUu0GdxWQJZTgIPO4FhFkh/Vj+DqVF4EzsoAWS0PW5kq7IRJa/7WSCN7xjx5pgyb74eoxRKxLIFFOG1tb60h4o729eWtnQVUeYCAvuW/3xR1vlBv0VNCesCr1mlqF9gOXj6kY+akWi9Nl/OZuTebqg+NAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=iFRi77EF; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BAA2940E0219;
	Tue, 18 Jun 2024 09:07:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aGuF-HTpzT1b; Tue, 18 Jun 2024 09:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718701675; bh=hAO9+helngUuUeubF6L7V/zmmLQ0R5mhgBjYodP5Jf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iFRi77EFPt40/h2RfC93fbcbpEk55gAB/W/g6MVNFoQc8uWRLdvMEqWnxD0DorZSg
	 F6pGDuX1sHe/x+EDfVcYT1eR+XzDzq6Mz9u6GnZDSN3FVg2mTV4fHOR4X3IreV/ybN
	 YkvD+xnJu0m2QR4eKN+AY42d1z+riZO7/4wo5L3gHVwD4ip8w7XVCqgJ1kWe8yxgYo
	 VFS2wUQVeAUWiPpFDMUl8xN9RrL0uYx327vKkxWWUhZ/wwbc8PWtA30BCM5RDE7P9H
	 VTUeDvKaFbqhqj/GJk19SKyGxQkbH7M8LzAeTSE54CQdebAmAaZYejswQVw7TY7cNf
	 Bol8FbSafqQIKXR9lKK1C8NPfzZvihvmTg0EjGzToDUmEbQgh1qpVlf0WH/FpytIwG
	 rVwz/vbh0KRQMhRSDwEvHvTK/ToEwszqK+7/IFbXfyW+kLGYsyaRc5xJUiUZnSb6JS
	 czKCfqzUbQYXwQfSc180t/lGf4Bz3mWmvwGP/jBrYMaCAN7XBXHfqKRgQOAbYZwY2V
	 1Dlwsdd+lAjbkpVvwA5UbG7Q6XbsZhE3kCvtrOR8Vl3jDs6AdoCtV88chL3T1AzoNw
	 RPiLkrHSVdEaya9qkVuqeVxQcy6m1Wh/Epb/QENsPRuLjvPA3IO/6R5H2fapRJNTeA
	 syoB+CbPNhsLVtRlsPpG7S0c=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 27D3540E01F9;
	Tue, 18 Jun 2024 09:07:45 +0000 (UTC)
Date: Tue, 18 Jun 2024 11:07:39 +0200
From: Borislav Petkov <bp@alien8.de>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH 1/2] x86/cpufeatures: Add HWP highest perf change feature
 flag
Message-ID: <20240618090739.GAZnFOW6FRwcE5EkQI@fat_crate.local>
References: <20240618035122.438822-1-srinivas.pandruvada@linux.intel.com>
 <20240618035122.438822-2-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240618035122.438822-2-srinivas.pandruvada@linux.intel.com>

On Mon, Jun 17, 2024 at 08:51:20PM -0700, Srinivas Pandruvada wrote:
> When CPUID[6].EAX[15] is set to 1, this CPU supports notification for
> HWP (Hardware P-states) highest performance change.
> 
> Add a feature flag to check if the CPU supports HWP highest performance
> change.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 3c7434329661..4674ba5310b2 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -361,6 +361,7 @@
>  #define X86_FEATURE_HWP_ACT_WINDOW	(14*32+ 9) /* HWP Activity Window */
>  #define X86_FEATURE_HWP_EPP		(14*32+10) /* HWP Energy Perf. Preference */
>  #define X86_FEATURE_HWP_PKG_REQ		(14*32+11) /* HWP Package Level Request */
> +#define X86_FEATURE_HWP_HIGHEST_PERF_CHANGE (14*32+15) /* HWP Highest perf change */

Doesn't belong in /proc/cpuinfo:

#define X86_FEATURE_HWP_HIGHEST_PERF_CHANGE (14*32+15) /* "" HWP Highest perf change */

							^^^^^


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

