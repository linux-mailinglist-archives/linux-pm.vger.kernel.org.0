Return-Path: <linux-pm+bounces-15979-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F829A43A0
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 18:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D888D1C22E83
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2024 16:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C69203705;
	Fri, 18 Oct 2024 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AXqYqzwA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CE8202651;
	Fri, 18 Oct 2024 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729268431; cv=none; b=g+fIqG2eTvqsnxuqnYPPiO5jCTZvgbQflTTrQabySsITYD13eLhRSdLuH4wlyh15s7xtx05q4M1X3MeE5xjljHzVGYlUAeJxTNOZzCi7ufNkTAFpt4CkJVurPQZ6nPvYNzhKWXbEYByMVwst0dXqfiTfzGHbThjigH22Q/EaIWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729268431; c=relaxed/simple;
	bh=mkVYt2W5JOK0CvpUDNHo8dPYoJDfSL/8UCOFmOypSx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3IZfFnyTAftYlM/oSUwiO8oOk8lDVd1/5kIlX4XKr1HXEZqxsq/kWxL9z66eV1VqMQ6gpzOTsIrfP62l8BEFGkXVevWhaOjSAGYQxeVomQ+ndf58fb1e0pwvnZ7k+cSRPhfSmJr/ujW3a++8uS1+98AkwLqELMqTTkzvMMDJrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=AXqYqzwA; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C9A8540E015F;
	Fri, 18 Oct 2024 16:20:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YDifM9s0iqSI; Fri, 18 Oct 2024 16:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729268422; bh=xAbSibuOma7sKDAZvFzI/jo58IkQccgwolksqNCMrZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AXqYqzwACXfOfbviQ0eFvl2TZ9vjOqJa7IjGA7k8wTzcpUBXvT6z3scpSlc78Al5l
	 e3U+LTW3XTLt14U/oWiEkpWKstLPvs5tlQiIWb/wdVDwD7HOV8N+n5gQImeV3f0dRs
	 c0kAAE0Ig0mJOcaz5szPcgjTZxbFEtopiFOG9f8OVECMDwjKNXo+n0U3fv12b1VHj0
	 z90Hxin8C3MjK8kWI3bOq/7TR7eP/fvRxreYX08yZ9oSwewdHO9dZDnnyACCFJuhEm
	 OFfQSr7LREtkK1oEqyiYbGgdWB3i+ywexHJlwAOKSlMKv077jqPT2dWSjRCDMFX3by
	 w3Z0ODCFu84H2KCMOS5FITEuI/AYU57ca4H+4Vk/doI7lbVqn5KUZmlYsOuf8BTNJf
	 U5VuoNMqzLbZFsApKN/hN5moZojCxEQXAQe1j74uziOn9KznkijIN7miDTwLpsNnzM
	 XqU9mgKyzRXUvI+vFuCVHkmh4fCHAu2hPunxKio1WvR02hUmAJL9Qb6DfgAW4NM4cz
	 Xvib9NsejahQM29aqxQWW0wZZDtkdUIbeCeKeguK8DaWd4h3J6fmA8As9FBNR0tu7u
	 /RlczOwf8IAHA13/Xl76hFvIYnP8jJm/x8Dz0nbtbq+IsKtLBaw6olo8Js5KfX/wZV
	 mMFEsUtI+X5qvRglS4q3VZGI=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1B37540E0169;
	Fri, 18 Oct 2024 16:20:02 +0000 (UTC)
Date: Fri, 18 Oct 2024 18:19:56 +0200
From: Borislav Petkov <bp@alien8.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	daniel.sneddon@linux.intel.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Brice Goglin <brice.goglin@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <Perry.Yuan@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v4 02/10] x86/cpu/topology: Add CPU type to struct
 cpuinfo_topology
Message-ID: <20241018161956.GCZxKKrLeTg0VTdfWA@fat_crate.local>
References: <20240930-add-cpu-type-v4-0-104892b7ab5f@linux.intel.com>
 <20240930-add-cpu-type-v4-2-104892b7ab5f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240930-add-cpu-type-v4-2-104892b7ab5f@linux.intel.com>

On Mon, Sep 30, 2024 at 07:47:24AM -0700, Pawan Gupta wrote:
> Subject: Re: [PATCH v4 02/10] x86/cpu/topology: Add CPU type to struct...

x86/cpu: ...

is enough.

> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 4a686f0e5dbf..61c8336bc99b 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -105,6 +105,17 @@ struct cpuinfo_topology {
>  	// Cache level topology IDs
>  	u32			llc_id;
>  	u32			l2c_id;
> +
> +	// Hardware defined CPU-type
> +	union {
> +		u32		hw_cpu_type;
> +		struct {
> +			/* CPUID.1A.EAX[23-0] */

Might as well stick to only // comments as we do those in headers now.

> +			u32	intel_core_native_model_id:24;

wow, that needs a whole breath to speak: "intel_core_native_model_id".

"core" and "native" look like they wanna go. What is that field supposed to
mean even?

> +			/* CPUID.1A.EAX[31-24] */
> +			u32	intel_core_type:8;
> +		};
> +	};
>  };

...

> +enum x86_topology_hw_cpu_type topology_hw_cpu_type(struct cpuinfo_x86 *c)
> +{
> +	if (c->x86_vendor == X86_VENDOR_INTEL)
> +		return c->topo.intel_core_type;
> +
> +	return c->topo.hw_cpu_type;

Huh, the other vendors are not enabled. This should return
TOPO_HW_CPU_TYPE_UNKNOWN then.

I know, it does but make explicit pls.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

