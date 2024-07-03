Return-Path: <linux-pm+bounces-10564-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2705F926B31
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 00:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B9B281737
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 22:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C1413D2B2;
	Wed,  3 Jul 2024 22:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVadbYSi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81FD3D393;
	Wed,  3 Jul 2024 22:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720044286; cv=none; b=M3m03yQotuAwBZMwK+YkK5mZ4vG8sNEeNbRDrEZJiibQMctuPYB15Dqi3yqLL1pvVN2cadcmJ6AMOteS7h37TqmNyR13O500n9C6miCp8FT7U3/9ojsT6jFCblR3Smlbp0cW/lbwNavOV/+EVvp7pBfyHFPTyVymwsjCKjTsrWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720044286; c=relaxed/simple;
	bh=R+Iu1Y/sYsn5xNK43DVWQoj/JlpVQxwIZZ2KcLMzsLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4QLuFE4bDe+I5tX2+prGXVdmmxi80gtAqCr1GwEth7nZDAeFjqcucabUEPiAnNfzETcvxiYVUsA/HeA/T0bZ+oVcu2PYkylyLZkA+QhcC/M+Cw1XMaY8+T3yC5yayYQjTXYM7yqIVXrO0kCWBi2dePmM0gNcWqAVUHlShfs8Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVadbYSi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8893EC2BD10;
	Wed,  3 Jul 2024 22:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720044286;
	bh=R+Iu1Y/sYsn5xNK43DVWQoj/JlpVQxwIZZ2KcLMzsLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pVadbYSisYApWEQcCCxCfY03962VOXiIy7bn5oD7PGRX/xLXIhoyW1Q5jc0Dsw4Hz
	 LzZMvrPCkT4y79YZBPoi21GOk+WT/cwkTNDltGbyrd2CbnZgJBC445Gkj04TEr3qMa
	 ZPd8DEGMl3IIDHHV1CZ8YQAPanQe+nZCcLsENTolvQHI9liB9qheYdJysxvnk6niwN
	 fk8nQn9M1d58oBW71NLw+g0YO+Z/nPgHZkWcQOhimrhxuIbq/UpkVYYlMSV3Mj0LgL
	 NYdXIudljlXKGMdohUNtM9RLPM3n8pXEnXjo+MCe76iRpJywQeyygZw3+S/rBxXxwk
	 rGMkhRZwhuKtA==
Date: Wed, 3 Jul 2024 15:04:44 -0700
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
Message-ID: <20240703220444.oufkvabpivillv3e@treble>
References: <20240627-add-cpu-type-v2-0-f927bde83ad0@linux.intel.com>
 <20240627-add-cpu-type-v2-9-f927bde83ad0@linux.intel.com>
 <20240703010433.2ymzh5g7osth5ch5@treble>
 <20240703182613.4vfaoxl344mdanxn@desk>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240703182613.4vfaoxl344mdanxn@desk>

On Wed, Jul 03, 2024 at 11:26:13AM -0700, Pawan Gupta wrote:
> On Tue, Jul 02, 2024 at 06:04:33PM -0700, Josh Poimboeuf wrote:
> > Same comment here, these should be inline with the main list.  Maybe
> > there's some way to structure the indentations so they align better
> > vertically with the STEPPINGS/TYPE variants.
> 
> This is how it is turning out to be:
> +	VULNBL_INTEL(		IVYBRIDGE,		SRBDS),
> +	VULNBL_INTEL(		HASWELL,		SRBDS),
> +	VULNBL_INTEL(		HASWELL_L,		SRBDS),
> +	VULNBL_INTEL(		HASWELL_G,		SRBDS),
> +	VULNBL_INTEL(		HASWELL_X,		MMIO),
> +	VULNBL_INTEL(		BROADWELL_D,		MMIO),
> +	VULNBL_INTEL(		BROADWELL_G,		SRBDS),
> +	VULNBL_INTEL(		BROADWELL_X,		MMIO),
> +	VULNBL_INTEL(		BROADWELL,		SRBDS),
> +	VULNBL_INTEL(		SKYLAKE_X,		MMIO | RETBLEED | GDS),
> +	VULNBL_INTEL(		SKYLAKE_L,		MMIO | RETBLEED | GDS | SRBDS),
> +	VULNBL_INTEL(		SKYLAKE,		MMIO | RETBLEED | GDS | SRBDS),
> +	VULNBL_INTEL(		KABYLAKE_L,		MMIO | RETBLEED | GDS | SRBDS),
> +	VULNBL_INTEL(		KABYLAKE,		MMIO | RETBLEED | GDS | SRBDS),
> +	VULNBL_INTEL(		CANNONLAKE_L,		RETBLEED),
> +	VULNBL_INTEL(		ICELAKE_L,		MMIO | MMIO_SBDS | RETBLEED | GDS),
> +	VULNBL_INTEL(		ICELAKE_D,		MMIO | GDS),
> +	VULNBL_INTEL(		ICELAKE_X,		MMIO | GDS),
> +	VULNBL_INTEL(		COMETLAKE,		MMIO | MMIO_SBDS | RETBLEED | GDS),
> +	VULNBL_INTEL_STEPPINGS(	COMETLAKE_L,	X86_STEPPINGS(0x0, 0x0),	MMIO | RETBLEED),
> +	VULNBL_INTEL(		COMETLAKE_L,		MMIO | MMIO_SBDS | RETBLEED | GDS),
> +	VULNBL_INTEL(		TIGERLAKE_L,		GDS),
> +	VULNBL_INTEL(		TIGERLAKE,		GDS),
> +	VULNBL_INTEL(		LAKEFIELD,		MMIO | MMIO_SBDS | RETBLEED),
> +	VULNBL_INTEL(		ROCKETLAKE,		MMIO | RETBLEED | GDS),
> +	VULNBL_INTEL_TYPE(	ALDERLAKE,	ATOM,	RFDS),
> +	VULNBL_INTEL(		ALDERLAKE_L,		RFDS),
> +	VULNBL_INTEL_TYPE(	RAPTORLAKE,	ATOM,	RFDS),
> +	VULNBL_INTEL(		RAPTORLAKE_P,		RFDS),
> +	VULNBL_INTEL(		RAPTORLAKE_S,		RFDS),
> +	VULNBL_INTEL(		ATOM_GRACEMONT,		RFDS),
> +	VULNBL_INTEL(		ATOM_TREMONT,		MMIO | MMIO_SBDS | RFDS),
> +	VULNBL_INTEL(		ATOM_TREMONT_D,		MMIO | RFDS),
> +	VULNBL_INTEL(		ATOM_TREMONT_L,		MMIO | MMIO_SBDS | RFDS),
> +	VULNBL_INTEL(		ATOM_GOLDMONT,		RFDS),
> +	VULNBL_INTEL(		ATOM_GOLDMONT_D,	RFDS),
> +	VULNBL_INTEL(		ATOM_GOLDMONT_PLUS,	RFDS),

Looks good to me.

The bug bits could also be vertically aligned, but that might offend
those with undersized terminals :-)

-- 
Josh

