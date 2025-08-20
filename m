Return-Path: <linux-pm+bounces-32718-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F72B2E0D0
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 17:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6BFD1CC0C6A
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 15:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1DC3277BE;
	Wed, 20 Aug 2025 15:10:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425293277A8;
	Wed, 20 Aug 2025 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702652; cv=none; b=L8EvPnB5UdVPVgFyiDCvoxZ/FTvJqyfXlsYaX1R7KoM54TyYZpj42glbipyp427AP6ZogHPqK5lyx4iJYTyRfZGbCC+6JM+OwU8SH4VYU3jGKNZq9/qLlLBRsYACYbCnJKnC1B9XfUEV7jM136R2QShk1RFTlUcdB9IJ+tQTy/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702652; c=relaxed/simple;
	bh=0o1ZKr+OVgTNv/axtlIyra7bcdBWa1I6DQfsq+DZb4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZOE7yNa5BjU3LeR/ooeC1ZEveI0Trl68HqHWIbH6oX8ojO6N7Lng/6shGIdR+8ZKRGVJsedYT82ymA9onSLx+c/j1dYcLKA1lXMRTemwqM/2ImIN1yAuJ9EkGpJKoShu9CixsvbI+/cDSr1zvTcPCe5FRVGM2KxKI5/EKVzMqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 270261D31;
	Wed, 20 Aug 2025 08:10:42 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 695743F738;
	Wed, 20 Aug 2025 08:10:46 -0700 (PDT)
Date: Wed, 20 Aug 2025 16:10:26 +0100
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
	linux-pm@vger.kernel.org, kvmarm@lists.linux.dev,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v3 1/5] arm64: make SCTLR2_EL1 accessible
Message-ID: <aKXlYhhrNp/8StK2@e133380.arm.com>
References: <20250813120118.3953541-1-yeoreum.yun@arm.com>
 <20250813120118.3953541-2-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813120118.3953541-2-yeoreum.yun@arm.com>

Hi,

On Wed, Aug 13, 2025 at 01:01:14PM +0100, Yeoreum Yun wrote:
> When the kernel runs at EL1, and yet is booted at EL2,
> HCRX_EL2.SCTLR2En must be set to avoid trapping SCTLR2_EL1 accesses
> from EL1 to EL2.
> 
> Ensure this bit is set at the point of initialising EL2.
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/el2_setup.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
> index 46033027510c..d755b4d46d77 100644
> --- a/arch/arm64/include/asm/el2_setup.h
> +++ b/arch/arm64/include/asm/el2_setup.h
> @@ -57,9 +57,15 @@
>          /* Enable GCS if supported */
>  	mrs_s	x1, SYS_ID_AA64PFR1_EL1
>  	ubfx	x1, x1, #ID_AA64PFR1_EL1_GCS_SHIFT, #4
> -	cbz	x1, .Lset_hcrx_\@
> +	cbz	x1, .Lskip_hcrx_GCSEn_\@
>  	orr	x0, x0, #HCRX_EL2_GCSEn
>  
> +.Lskip_hcrx_GCSEn_\@:
> +	mrs_s	x1, SYS_ID_AA64MMFR3_EL1
> +	ubfx	x1, x1, #ID_AA64MMFR3_EL1_SCTLRX_SHIFT, #4
> +	cbz	x1, .Lset_hcrx_\@
> +	orr	x0, x0, HCRX_EL2_SCTLR2En

Nit: prefix immediate operands with # please -- see usage elsewhere in
this file.

(This comes from the legacy AArch32 syntax and has never been required
by AArch64 assemblers, but it has become a tradition in the Linux arch
code...)

The only execptions to this rule are macros (mov_q, mrs_s etc. --
frequently they have an underscore in the name; "real" instructions
never do.)

> +
>  .Lset_hcrx_\@:

Maybe rename this label to .Lskip_hcrx_SCTLR2En_\@, so that people
don't have to keep renaming an existing label whenever they add
another block here.

>  	msr_s	SYS_HCRX_EL2, x0
>  .Lskip_hcrx_\@:

[...]

Cheers
---Dave

