Return-Path: <linux-pm+bounces-30737-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27793B02EFB
	for <lists+linux-pm@lfdr.de>; Sun, 13 Jul 2025 08:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C142189EF61
	for <lists+linux-pm@lfdr.de>; Sun, 13 Jul 2025 06:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90171A0BDB;
	Sun, 13 Jul 2025 06:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qg+Wi9X8"
X-Original-To: linux-pm@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3278E2D023
	for <linux-pm@vger.kernel.org>; Sun, 13 Jul 2025 06:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752389369; cv=none; b=DQyDiEIluTex9Z0Toor43JdJ6KqanPN3OswI8675HryPKyKLtBn/TmtOh5+wjdvzSPTO52V9O4xsL78SFFMBHSp9M7qiyHsB+jz54ipi9dUlBKzvmBXrYRRWKd2I855EFJmF+GRx0V+7rPl4WBK7OHc5fPywM7jgMEyOTQvo3FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752389369; c=relaxed/simple;
	bh=zgDokYeAuGvGbLU5ZYeN3Nu7NtaWmJo3Zn7ySxDWvOo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=k5oWEtObY5BuEBWBvdUVv34JGR5CfPgqumae6rwyHlgf40TqHGuWWHxft4XS2FV2dzKY4SP6E87lKWCYyt/nKZfsOOnQKtOT7VPiRp7D01YXrjHFIe8egOUQs4BTQ31NVxmEZ5fwgHi2dmCH76kVwe2rNFR+aPsTKKF7IlCqYXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qg+Wi9X8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=oIHPswPlA65mr5pcx9FN9/QN7K7Y03Al26IS3uvROLw=; b=qg+Wi9X84E+G180TPrWFhuuLiB
	SoPJjhTaZC5dGYdscsUNFCTWFv/HNZ67/D81kGreJbgup/9WrRvG07KgxCsEzdroQ2J171p1iK0Y/
	W5vwVSFUqHL5xy5A0JbSzGkc1xgE3S2uYLhCuExQmhtdKBA0xWUb1N+UmEbfs3dOrnPVbv0D+GxOd
	LGrk4MYW1mmiZnTzSW4H4lhiuEE4u8JkLlsj9+kvHFvj66Hend1Sw0q0KGu4l/QoxQwz3FQvOTVtH
	feFcoq2Nu2tSf6qfZAD1bNqQVo1RcsHAeIomBAgnenyQOh67Cm7kPcs6A10MR8/ncN6Iim1mUtPwb
	B9FzjATQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaqWc-0000000HPmg-0CWH;
	Sun, 13 Jul 2025 06:49:26 +0000
Message-ID: <2d99c998-cc35-4bf2-8c91-ea4a9ed1ff9e@infradead.org>
Date: Sat, 12 Jul 2025 23:49:25 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] PM: hibernate: Add stub for
 pm_hibernate_is_recovering()
To: Mario Limonciello <superm1@kernel.org>, mario.limonciello@amd.com,
 rafael@kernel.org, pavel@kernel.org, len.brown@intel.com,
 guoqing.zhang@amd.com
Cc: linux-pm@vger.kernel.org
References: <20250712233715.821424-1-superm1@kernel.org>
Content-Language: en-US
In-Reply-To: <20250712233715.821424-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/12/25 4:37 PM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Randy reports that amdgpu fails to compile with the following error:
> ERROR: modpost: "pm_hibernate_is_recovering" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> 
> This happens because pm_hibernate_is_recovering() is only compiled when
> CONFIG_PM_SLEEP is set.  Add a stub for it so that drivers don't need
> to depend upon CONFIG_PM.
> 
> Cc: Samuel Zhang <guoqing.zhang@amd.com>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/dri-devel/CAJZ5v0h1CX+aTu7dFy6vB-9LM6t5J4rt7Su3qVnq1xx-BFAm=Q@mail.gmail.com/T/#m2b9fe212b35fde11d58fcbc4e0727bc02ebba7b0
> Fixes: c2aaddbd2dede ("PM: hibernate: add new api pm_hibernate_is_recovering()")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> --
> v2:
>  * put stub in right ifdef
> ---
>  include/linux/suspend.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 293137210fdf4..fcb150ee83b6b 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -426,8 +426,6 @@ int is_hibernate_resume_dev(dev_t dev);
>  static inline int is_hibernate_resume_dev(dev_t dev) { return 0; }
>  #endif
>  
> -bool pm_hibernate_is_recovering(void);
> -
>  /* Hibernation and suspend events */
>  #define PM_HIBERNATION_PREPARE	0x0001 /* Going to hibernate */
>  #define PM_POST_HIBERNATION	0x0002 /* Hibernation finished */
> @@ -478,6 +476,7 @@ extern unsigned int lock_system_sleep(void);
>  extern void unlock_system_sleep(unsigned int);
>  
>  extern bool pm_sleep_transition_in_progress(void);
> +bool pm_hibernate_is_recovering(void);
>  
>  #else /* !CONFIG_PM_SLEEP */
>  
> @@ -508,6 +507,7 @@ static inline unsigned int lock_system_sleep(void) { return 0; }
>  static inline void unlock_system_sleep(unsigned int flags) {}
>  
>  static inline bool pm_sleep_transition_in_progress(void) { return false; }
> +static inline bool pm_hibernate_is_recovering(void) { return false; }
>  
>  #endif /* !CONFIG_PM_SLEEP */
>  

-- 
~Randy

