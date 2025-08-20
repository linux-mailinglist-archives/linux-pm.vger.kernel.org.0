Return-Path: <linux-pm+bounces-32723-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AACFB2E0DD
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 17:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3C91C866A1
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 15:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DC9341666;
	Wed, 20 Aug 2025 15:12:06 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A420E182D2;
	Wed, 20 Aug 2025 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702726; cv=none; b=EEoOg54kZn9gD8fyp+T86DcUDZ6FnoIWttnNS10jI1X6V41jZAKoIG/P8vzdP6pS1k2nGraXVYhcG/hPi4Lh7svXQH2t9YkUh8xn8VCz+BzGkwC4rpfyHiRHlMJfiU917lGdojXrIDZVJbv0vd4ZmdwI3r9O07KdV7IX5NIp+AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702726; c=relaxed/simple;
	bh=bKySXmogrdywUpuJaQEVkaR1IVoL1YNv1ljg9g1gKVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qm/EEctPTRm29wy+8i/vKca7QZ0izLH1+IvpRQI5NRYu21hnbzNFZ201yDknNrnl9ZXkxcYR7rYDcIPwQXn7rp74+h1gwkiHqEj2/a8BtxHPZR4f3WR5iDRvmTk1n0MJQZFlBo6rGp4RogNNwfdV8lFqhxr5aewl/DeAgXsHJUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C892F1D31;
	Wed, 20 Aug 2025 08:11:55 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AC2E3F738;
	Wed, 20 Aug 2025 08:12:00 -0700 (PDT)
Date: Wed, 20 Aug 2025 16:11:57 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
	oliver.upton@linux.dev, anshuman.khandual@arm.com, robh@kernel.org,
	james.morse@arm.com, mark.rutland@arm.com, joey.gouly@arm.com,
	ahmed.genidi@arm.com, kevin.brodsky@arm.com,
	scott@os.amperecomputing.com, mbenes@suse.cz,
	james.clark@linaro.org, frederic@kernel.org, rafael@kernel.org,
	pavel@kernel.org, ryan.roberts@arm.com, suzuki.poulose@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH v3 0/5] initialize SCTRL2_ELx
Message-ID: <aKXlvcqM90197MiJ@e133380.arm.com>
References: <20250813120118.3953541-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250813120118.3953541-1-yeoreum.yun@arm.com>

Hi,

On Wed, Aug 13, 2025 at 01:01:13PM +0100, Yeoreum Yun wrote:
> This series introduces initial support for the SCTLR2_ELx registers in Linux.
> The feature is optional starting from ARMv8.8/ARMv9.3,
> and becomes mandatory from ARMv8.9/ARMv9.4.
> 
> Currently, Linux has no strict need to modify SCTLR2_ELx—
> at least assuming that firmware initializes
> these registers to reasonable defaults.
> 
> However, several upcoming architectural features will require configuring
> control bits in these registers.
> Notable examples include FEAT_PAuth_LR and FEAT_CPA2.

This looks OK overall to me, apart from some confusion between
SCTLR_ELx and SCTLR2_ELx in patch 2 (see my comments there).

This code will need to be tested somehow.  Do you have any thoughts on
this?  Hacking the bootwrapper, KVM and/or kvmtool may provide a way of
checking what happens when the kernel is entered with "wrong" initial
values in relevant bits (HRCX_EL2.SCTLR2En, SCTLR2_EL{1,2}).


Regarding the patch history:

> Patch History
> ==============
> from v2 to v3:
>   - rewrite commit messages.
>   - fix missing SCTLR2_EL2 synchonization at boot.
>   - https://lore.kernel.org/all/20250811163340.1561893-1-yeoreum.yun@arm.com/
> 
> from v1 to v2:
>   - rebase to v6.17-rc1
>   - https://lore.kernel.org/all/20250804121724.3681531-1-yeoreum.yun@arm.com/

Going forwards, can you try to make sure that significant changes to
the series are all mentioned here?

I didn't have time to look at v2, and in the meantime half of the
series disappeared and a chunk of code was moved from one patch to
another.  I saves reviewers some time and effort if they do not have to
dig through previous review conversations in order to understand what
changed between versions of a series.

(No need to mention every trivial change, though.)

Cheers
---Dave

