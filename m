Return-Path: <linux-pm+bounces-10393-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0069E924CEF
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 03:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BAC9283765
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 01:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDA810E3;
	Wed,  3 Jul 2024 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DO26YFnF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB734683;
	Wed,  3 Jul 2024 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719968421; cv=none; b=QhC3OUav6N1jfkGFV9nm4in/y9hQwTlOqC28bMfalGW6lNvCLWXTZBGCLCYvjr7VxVpHMYXOOWMNhTzjkzrNdlsv5MY+VdjsTnv2je0XKd6c7YXVm9yQCbhWqVjECpgba+e0/koqePHetgIDfCRgq0AxHh+pRYkYNC1GgJWYUks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719968421; c=relaxed/simple;
	bh=v9a2giiEKnJ5XVS6wLgrehH9OKCuZrkXtBNVi2LQQ9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sD8BGRXI5xxSq43toWUG2XIy/HsDsnfTcvS+eorBSivvXlV7uZgYxxYfQSXDE+r8P/0+qPocFHFdUjfnpOnzlQReUu/SHuctGvVtJidLNglu/G0d/hWr/pV4hzQfZPZiZ03nSWi+CbNyYKKprDK8pUPq97p+o3PcuoP0aGI2TQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DO26YFnF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E99C116B1;
	Wed,  3 Jul 2024 01:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719968421;
	bh=v9a2giiEKnJ5XVS6wLgrehH9OKCuZrkXtBNVi2LQQ9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DO26YFnF9wBh74tR67gPrg2v8ZmxbBN+ni3IolIIsRvlGZc6uOulxvOSRKngFVnPp
	 FsthxQy5KMcdT7wFVXdGjccRxxmmii7aJQvEOuw/B395d+ipSm0BnrO9JoKNtxgLod
	 DErqeUGG7R0I2US28DVfx5P1ZcB7mY4twXsskdBrSW38K7XHQcYP+ddVLGT+zxGh+F
	 pVuSuuOSmO4CWC/8MZgXqzNVEuqeqWS03kLbGD9g7AuBErfG3OsouZaxG2jVx8Qc5H
	 U+h2Np1VWZW0cUfFFkqRXpXf8Q2HXQuUsYUTHo7cZoTx9uC9oGsLzX/t+4I6c1Y7ds
	 PD1QerVrdxxZQ==
Date: Tue, 2 Jul 2024 18:00:18 -0700
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
Subject: Re: [PATCH PATCH v2 8/9] x86/bugs: Declutter vulnerable CPU list
Message-ID: <20240703010018.qov5lxldvou7fhhl@treble>
References: <20240627-add-cpu-type-v2-0-f927bde83ad0@linux.intel.com>
 <20240627-add-cpu-type-v2-8-f927bde83ad0@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240627-add-cpu-type-v2-8-f927bde83ad0@linux.intel.com>

On Thu, Jun 27, 2024 at 01:44:48PM -0700, Pawan Gupta wrote:
> The affected processor table has a lot of repetition and redundant
> information that can be omitted. For example:
> 
>   VULNBL_INTEL_STEPPINGS(INTEL_IVYBRIDGE,		X86_STEPPING_ANY,		SRBDS),
> 
> can easily be simplified to:
> 
>   VULNBL_INTEL(IVYBRIDGE,	SRBDS),
> 
> Apply this to all the entries in the affected processor table.
> 
> No functional change. Disassembly of arch/x86/kernel/cpu/common.o does not
> show any difference before and after the change.

This patch only changes data, not code.  So there's not much point in
diffing the disassembly ;-)

A diff of the .init.rodata sections actually shows one (non-functional)
difference in cpu_vuln_blacklist[].

The COMETLAKE_L entries were moved to a new section below the rest of
the entries:

	/* Match more than Vendor/Family/Model */
	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPINGS(0x0, 0x0),	MMIO | RETBLEED),
	VULNBL_INTEL	      (COMETLAKE_L,					MMIO | MMIO_SBDS | RETBLEED | GDS),

While that's functionally correct, it breaks the visual sorting, which
is confusing and even a bit dangerous.  One would reasonably expect the
COMETLAKE_L entries to come immediately after COMETLAKE, so it would be
quite possible for somebody to come along later and add a new
COMETLAKE_L there which conflicts with the later entries.

I'd much rather leave the STEPPINGS entry in the original list where it
belongs.  Something like:

	...
	VULNBL_INTEL(ICELAKE_L,			MMIO | MMIO_SBDS | RETBLEED | GDS),
	VULNBL_INTEL(ICELAKE_D,			MMIO | GDS),
	VULNBL_INTEL(ICELAKE_X,			MMIO | GDS),
	VULNBL_INTEL(COMETLAKE,			MMIO | MMIO_SBDS | RETBLEED | GDS),
	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,
			       X86_STEPPINGS(0x0, 0x0),
			       MMIO | RETBLEED),
	VULNBL_INTEL(COMETLAKE_L,		MMIO | MMIO_SBDS | RETBLEED | GDS),
	VULNBL_INTEL(TIGERLAKE_L,		GDS),
	VULNBL_INTEL(TIGERLAKE,			GDS),
	...

Yes, that's a little ugly, but at least the sorting is correct so it's
less confusing and more robust overall.

-- 
Josh

