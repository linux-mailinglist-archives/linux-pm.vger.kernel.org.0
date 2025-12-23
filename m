Return-Path: <linux-pm+bounces-39853-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DABEECD9414
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 13:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDFCD3022ABF
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 12:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6644327C1B;
	Tue, 23 Dec 2025 12:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JsahPuzA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74F32D77F7;
	Tue, 23 Dec 2025 12:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766492971; cv=none; b=KktIkpgR3MQATOF4+4vNBB66c0EfptGwdTOPFUkvtIFYXgoCpy07anfxYJ/CNVUG2e1o49QORilzmwU+YcNnWKgqis7rOdvKiP7k3QwW2HcILxQq7i1e/vRmT9Q93HliEEA1RCGWz+0qfNktWMb1nJaQAqhR9GyORSt+L14N3q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766492971; c=relaxed/simple;
	bh=WjswL0tpeFyblrLVXPMJbmSpvGR6aiDnS3KaYJwgQAc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CFUtLR/mkdJkUPcWr940ov1NkAO48Q/AaIq5doJHrE7VR1FVaR9M14I/F/VpjvRSvEf8vDUJDhdWP2gEI15jxgFd8FF+TEmXDDqyy590zOqmoA2KJgY4LbN1hR5d8N512ljvzTfuLxSYJ/tzSzOP8iFUo+QroCX+65bx3pBqRmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JsahPuzA; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766492969; x=1798028969;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WjswL0tpeFyblrLVXPMJbmSpvGR6aiDnS3KaYJwgQAc=;
  b=JsahPuzA8CYmrpNSoLZc3Racveax7lKJ890+3LGhAfZKxNsaMOIeUIVi
   st/ZMOLVfZovsfaWvYDfMP0IUzEFR/JYkCkQNA+9c+XD6ea6uiezpWh1x
   CUR3rjN7ekEFPvorxcioFk4sjiyq4guBOe8DBSJ3r5S9ysOHK8+0NR5ik
   ixyUdtVlSdHxfuJc/9d1kbqR546NyTep2s9hIBr1OOcJgVzMFvqqMoKqr
   jUNgxJVNSwWyk57z0NroB0j5R2SFyjig0l7SsuTP8ZdbrVqiO+JXkrjie
   R/rgjRq3aG/yKMYbaF9X9qnpnUamp4644AjId35arpAu3jcvxVRUnKn73
   g==;
X-CSE-ConnectionGUID: NvSHUAwFQWyNpWhSmEe2Rg==
X-CSE-MsgGUID: aWg66/3NTRCcE/7Gp58T3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="68385271"
X-IronPort-AV: E=Sophos;i="6.21,170,1763452800"; 
   d="scan'208";a="68385271"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 04:29:29 -0800
X-CSE-ConnectionGUID: AwluVt9OS8atyWr2uxdYaQ==
X-CSE-MsgGUID: uGqulKFHRUKIE0R9kBZAXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,170,1763452800"; 
   d="scan'208";a="199684292"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.48])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 04:29:26 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 23 Dec 2025 14:29:23 +0200 (EET)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    hdegoede@redhat.com, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/3] platform/x86/intel/pmc: Change LPM mode fields to
 u8
In-Reply-To: <20251217002343.2289577-2-xi.pardee@linux.intel.com>
Message-ID: <0de42147-16c3-e610-caae-e7aba5406782@linux.intel.com>
References: <20251217002343.2289577-1-xi.pardee@linux.intel.com> <20251217002343.2289577-2-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 16 Dec 2025, Xi Pardee wrote:

> Change the datatypes pf num_lpm_modes and lpm_en_modes[] from int
> to u8. The u8 type is more appropriate and improves the readability
> and maintainability of the code.
> 
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/core.c | 18 ++++++++++--------
>  drivers/platform/x86/intel/pmc/core.h |  4 ++--
>  2 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index 7d7ae8a40b0ec..3e916228e7ed2 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -779,7 +779,7 @@ static int pmc_core_substate_res_show(struct seq_file *s, void *unused)
>  	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
>  	const int lpm_adj_x2 = pmc->map->lpm_res_counter_step_x2;
>  	u32 offset = pmc->map->lpm_residency_offset;
> -	int mode;
> +	u8 mode;
>  
>  	seq_printf(s, "%-10s %-15s\n", "Substate", "Residency");
>  
> @@ -838,7 +838,7 @@ static void pmc_core_substate_req_header_show(struct seq_file *s, int pmc_index,
>  					      enum header_type type)
>  {
>  	struct pmc_dev *pmcdev = s->private;
> -	int mode;
> +	u8 mode;
>  
>  	seq_printf(s, "%40s |", "Element");
>  	pmc_for_each_mode(mode, pmcdev)
> @@ -880,7 +880,7 @@ static int pmc_core_substate_blk_req_show(struct seq_file *s, void *unused)
>  			const struct pmc_bit_map *map;
>  
>  			for (map = maps[r_idx]; map->name; map++) {
> -				int mode;
> +				u8 mode;
>  
>  				if (!map->blk)
>  					continue;
> @@ -953,7 +953,8 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
>  			u32 lpm_status;
>  			u32 lpm_status_live;
>  			const struct pmc_bit_map *map;
> -			int mode, i, len = 32;
> +			int i, len = 32;
> +			u8 mode;
>  
>  			/*
>  			 * Capture the requirements and create a mask so that we only
> @@ -1065,7 +1066,7 @@ static int pmc_core_lpm_latch_mode_show(struct seq_file *s, void *unused)
>  	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
>  	bool c10;
>  	u32 reg;
> -	int mode;
> +	u8 mode;
>  
>  	reg = pmc_core_reg_read(pmc, pmc->map->lpm_sts_latch_en_offset);
>  	if (reg & LPM_STS_LATCH_MODE) {
> @@ -1097,8 +1098,9 @@ static ssize_t pmc_core_lpm_latch_mode_write(struct file *file,
>  	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
>  	bool clear = false, c10 = false;
>  	unsigned char buf[8];
> -	int m, mode;
> +	int mode;
>  	u32 reg;
> +	u8 m;
>  
>  	if (count > sizeof(buf) - 1)
>  		return -EINVAL;
> @@ -1490,8 +1492,8 @@ int pmc_core_pmt_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc, struct tel
>  {
>  	const u8 *lpm_indices;
>  	int num_maps, mode_offset = 0;
> -	int ret, mode;
> -	int lpm_size;
> +	int ret, lpm_size;
> +	u8 mode;
>  
>  	lpm_indices = pmc->map->lpm_reg_index;
>  	num_maps = pmc->map->lpm_num_maps;

Why is "mode" in pmc_core_get_low_power_modes() left untouched?

(Unrelated to the patch, it seems to contain a double empty line as well.)

> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
> index 272fb4f57f346..ead2f33ed3ed5 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -462,8 +462,8 @@ struct pmc_dev {
>  	struct mutex lock; /* generic mutex lock for PMC Core */
>  
>  	u64 s0ix_counter;
> -	int num_lpm_modes;
> -	int lpm_en_modes[LPM_MAX_NUM_MODES];
> +	u8 num_lpm_modes;
> +	u8 lpm_en_modes[LPM_MAX_NUM_MODES];
>  	void (*suspend)(struct pmc_dev *pmcdev);
>  	int (*resume)(struct pmc_dev *pmcdev);
>  
> 

-- 
 i.


