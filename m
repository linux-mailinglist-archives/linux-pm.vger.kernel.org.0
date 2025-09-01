Return-Path: <linux-pm+bounces-33575-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B46E7B3EAE6
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 17:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386841B262E1
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 15:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0BA338F5F;
	Mon,  1 Sep 2025 15:18:25 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCE02FE04D;
	Mon,  1 Sep 2025 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756739905; cv=none; b=b5rEM0KE7GqJe5pL3zgE49g/7kECphJGrpzC0wl72KdnyBKc6EH9teZr7jKp1Udns0NO9PPzgIBCwZ7yC8N0C1JHPK9zXbnKLw2VH4avLCJ4XwAzS+Q0PlyDTdjIsKRJ4+C2sgVw6sNHwFcvJW9/oFHLrylWtQ/vpqM7t6b2P1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756739905; c=relaxed/simple;
	bh=mi1jhE0hSalMzhQcxvX/AVfoKXLeTEfI2y5Rv+u9/3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kI+Ydu7xg22MoFRqouoWAGcjmObvMKo4cIX1uVToolYgRqfoKjAjwBunNH6PP6Tj4cLX82plOT4ZzKGCUJW1DkUhu4BYGgUf615k1WEpT0xXMnVJdoUQcCcFyGXPqirtngdGSaIhjeNvKIwQ/O6k/kelj23pYsNmqEEw2GG3+eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E701B16A3;
	Mon,  1 Sep 2025 08:18:14 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DF833F6A8;
	Mon,  1 Sep 2025 08:18:19 -0700 (PDT)
Date: Mon, 1 Sep 2025 16:18:16 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
	oliver.upton@linux.dev, anshuman.khandual@arm.com, robh@kernel.org,
	james.morse@arm.com, mark.rutland@arm.com, joey.gouly@arm.com,
	ahmed.genidi@arm.com, kevin.brodsky@arm.com,
	scott@os.amperecomputing.com, mbenes@suse.cz,
	james.clark@linaro.org, frederic@kernel.org, rafael@kernel.org,
	pavel@kernel.org, ryan.roberts@arm.com, suzuki.poulose@arm.com,
	maz@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 0/5] initialize SCTRL2_ELx
Message-ID: <aLW5OIgv8/bvvY9E@e133380.arm.com>
References: <20250821172408.2101870-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821172408.2101870-1-yeoreum.yun@arm.com>

Hi,

On Thu, Aug 21, 2025 at 06:24:03PM +0100, Yeoreum Yun wrote:
> This series introduces initial support for the SCTLR2_ELx registers in Linux.
> The feature is optional starting from ARMv8.8/ARMv9.3,
> and becomes mandatory from ARMv8.9/ARMv9.4.
> 
> Currently, Linux has no strict need to modify SCTLR2_ELx--
> at least assuming that firmware initializes
> these registers to reasonable defaults.
> 
> However, several upcoming architectural features will require configuring
> control bits in these registers.
> Notable examples include FEAT_PAuth_LR and FEAT_CPA2.

This looks OK to me now, except for one or two minor issues (see
replies to the patches).

I think we will need a way of testing all the code paths before this
should be merged, though.

Have you tested all the code paths, or are there some things that have
not been tested?


Since this code is not useful by itself, it may make sense to delay
merging it until we have patches for a feature that depends on SCTLR2.

Cheers
---Dave

