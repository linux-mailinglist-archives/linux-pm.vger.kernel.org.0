Return-Path: <linux-pm+bounces-10394-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B33924D00
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 03:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E80C282221
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 01:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1F01854;
	Wed,  3 Jul 2024 01:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEaiVgWy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7156B139D;
	Wed,  3 Jul 2024 01:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719968676; cv=none; b=GaPOwBwM0FnzhitKmYDlmKYdUlk7gpifEaU7QI08PYUysQHoa8/GccdSN7F/CRDp3fWQKL6WrO9AMw1OiEu/aXY+WOfYJvB4fQnxvRaqRDo1AKTeimWnE/dNIuNmQOhpTY190WLj4VthIC5/+rR50JEc3suXW4j45qOEltawgKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719968676; c=relaxed/simple;
	bh=LcnahQlqsMIdmoV8uTqbUdIbnrzfrdwjOBwRUmo/5b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TV53WIKunlkUNSF5NERt1g7q2JmQdBaDWZntBdy72sSJsJrOPErd7OmvGUUK/efi2KbhpS5ovPPFLX+0blZqwAauQ+zvEwzKuTPT+BK07Zc7hMX33MvEvJJB/hRlkC/z/Mzi3HAldbIZo5CHqNlKwj+IjWcd1x0ANuXtQXqd6Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEaiVgWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4169C32781;
	Wed,  3 Jul 2024 01:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719968676;
	bh=LcnahQlqsMIdmoV8uTqbUdIbnrzfrdwjOBwRUmo/5b0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GEaiVgWy3hKxjdHsqqVx2D8rAU4aFWq/yHxIxYMQa8B5+cEzvd9t81rmLD4donzUr
	 SFqwfdTdQfIbt+jfG3AzOVsnj5A/WxZ/el9bRx5wmMEWhO+xumc/UjmAZTbFyhvHBz
	 /AcUvUntaLuqZZcUCqD5JQV3y1r8T4/ITYDGY9sLhZOxGTJZ5avtmGRRamazIc3XDt
	 fyRob+/r8MrW+uf+5uPGnrv/K6mkRiS2up8q0SPRPXjCtecGe9sBgCN5MbeNZg9Pfs
	 pDmMeJJZjPbOWUgrr4WZATUs/47HKXcGZSk9EZdYZrmbDt1g4llifmJsHNTWKxPcup
	 p1otuy+JarWOA==
Date: Tue, 2 Jul 2024 18:04:33 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	daniel.sneddon@linux.intel.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Brice Goglin <brice.goglin@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <Perry.Yuan@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH PATCH v2 9/9] x86/rfds: Exclude P-only parts from the
 RFDS affected list
Message-ID: <20240703010433.2ymzh5g7osth5ch5@treble>
References: <20240627-add-cpu-type-v2-0-f927bde83ad0@linux.intel.com>
 <20240627-add-cpu-type-v2-9-f927bde83ad0@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240627-add-cpu-type-v2-9-f927bde83ad0@linux.intel.com>

On Thu, Jun 27, 2024 at 01:44:55PM -0700, Pawan Gupta wrote:
> @@ -1255,9 +1260,7 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
>  	VULNBL_INTEL(TIGERLAKE,			GDS),
>  	VULNBL_INTEL(LAKEFIELD,			MMIO | MMIO_SBDS | RETBLEED),
>  	VULNBL_INTEL(ROCKETLAKE,		MMIO | RETBLEED | GDS),
> -	VULNBL_INTEL(ALDERLAKE,			RFDS),
>  	VULNBL_INTEL(ALDERLAKE_L,		RFDS),
> -	VULNBL_INTEL(RAPTORLAKE,		RFDS),
>  	VULNBL_INTEL(RAPTORLAKE_P,		RFDS),
>  	VULNBL_INTEL(RAPTORLAKE_S,		RFDS),
>  	VULNBL_INTEL(ATOM_GRACEMONT,		RFDS),
> @@ -1271,6 +1274,8 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
>  	/* Match more than Vendor/Family/Model */
>  	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPINGS(0x0, 0x0),	MMIO | RETBLEED),
>  	VULNBL_INTEL	      (COMETLAKE_L,					MMIO | MMIO_SBDS | RETBLEED | GDS),
> +	VULNBL_INTEL_TYPE     (ALDERLAKE,	ATOM,				RFDS),
> +	VULNBL_INTEL_TYPE     (RAPTORLAKE,	ATOM,				RFDS),

Same comment here, these should be inline with the main list.  Maybe
there's some way to structure the indentations so they align better
vertically with the STEPPINGS/TYPE variants.

-- 
Josh

