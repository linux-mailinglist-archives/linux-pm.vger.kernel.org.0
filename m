Return-Path: <linux-pm+bounces-22683-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC587A3FD04
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 18:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3813B3326
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 17:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B77824C66D;
	Fri, 21 Feb 2025 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rmi5w32T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6674124BD11;
	Fri, 21 Feb 2025 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157516; cv=none; b=BCtkPYvWS2MZcQCbGEks15jz6GqBmfCGnwpuSR4VI9PHlG5kVo6tffIeagmfyYFRp2XgbDfYVNwTn8HvLNYHROkTdEZfbVAfU8YfvKy1GOuOjGLGt2stsprTaqyRA2n7Kp7uAit7d5I6FZPwYn0Tzfzg6V/SkwXbv73UM+X1woQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157516; c=relaxed/simple;
	bh=WbW3SAWLQJrmCpMzqPGX5MMUKli4PXDnNDOyEBLp3X0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bfLYm4+bdaexAvWrUIaqQXIVMBje2LpmTeVHKBxO3Fhsjw2t0F50IDd1PBH0biP0vQVM9TTKf3udUtPTEpAKZliXt5/rf5M0NQauzwSj3qezkQrAinCHjKcfln1HFAU5B8nnxlX9hrNSmfEJfc2xWubueAC0HkuJx9xCtr8teXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rmi5w32T; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740157515; x=1771693515;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WbW3SAWLQJrmCpMzqPGX5MMUKli4PXDnNDOyEBLp3X0=;
  b=Rmi5w32TT19WlOwhpmqR8vkhu9+CYyFc8BzfG4vdBriCconLKnc/AgdG
   VgRT4ItwNIzQgOjBGTPf9GdPIIBOayC8MdNc5Xty4dm54VJQ5b03IXgI0
   08N32gJ8KfG65p4+aSrl97F+LRr9e86hpJt/rtnvEm3KSGf0+qmYPSllj
   LXFavFkV7Tt1IGScRWeS27GFUn/IMbZN41kAFFjAkrBl0IX7n+m2DNTHD
   Xfj5Xtq1nCnNw62/CSTDCs1v946atiEpP3b35ZJEyBCOhAOTSVcPWPJn6
   DKNLf7O6/pCU57Kl1KMHX30LW6eDl/tZsLWxeKI41Bap01VAY8PDPLlba
   w==;
X-CSE-ConnectionGUID: QRZs2qsfQyqr4Gb2I15gEg==
X-CSE-MsgGUID: OKsH8ZkbRb+7Gitf4c382g==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="40902463"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="40902463"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 09:05:14 -0800
X-CSE-ConnectionGUID: PYJDpfRXRe2YAt1iGJHvGA==
X-CSE-MsgGUID: Yr500fwjSwuOm2NHrTIwOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="115374665"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.110.189]) ([10.125.110.189])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 09:05:13 -0800
Message-ID: <43c873e1-737a-4119-abb7-49cc51acd6a0@intel.com>
Date: Fri, 21 Feb 2025 10:05:09 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 13/13] ntb: idt: use devm_kmemdup_array()
To: Raag Jadav <raag.jadav@intel.com>, perex@perex.cz, tiwai@suse.com,
 broonie@kernel.org, lgirdwood@gmail.com, deller@gmx.de,
 andriy.shevchenko@linux.intel.com, sre@kernel.org,
 sakari.ailus@linux.intel.com, mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
 jdmason@kudzu.us, fancer.lancer@gmail.com
Cc: linux-sound@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-media@vger.kernel.org, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250221165333.2780888-1-raag.jadav@intel.com>
 <20250221165333.2780888-14-raag.jadav@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250221165333.2780888-14-raag.jadav@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/21/25 9:53 AM, Raag Jadav wrote:
> Convert to use devm_kmemdup_array() which is more robust.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

I think this patch [1] from earlier today makes this change unnecessary now.

[1]: https://lore.kernel.org/ntb/20250221085748.2298463-1-arnd@kernel.org/

> ---
>  drivers/ntb/hw/idt/ntb_hw_idt.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> index 544d8a4d2af5..dbfc53d0ef0c 100644
> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> @@ -1103,16 +1103,11 @@ static struct idt_mw_cfg *idt_scan_mws(struct idt_ntb_dev *ndev, int port,
>  		}
>  	}
>  
> -	/* Allocate memory for memory window descriptors */
> -	ret_mws = devm_kcalloc(&ndev->ntb.pdev->dev, *mw_cnt, sizeof(*ret_mws),
> -			       GFP_KERNEL);
> -	if (!ret_mws)
> -		return ERR_PTR(-ENOMEM);
> -
>  	/* Copy the info of detected memory windows */
> -	memcpy(ret_mws, mws, (*mw_cnt)*sizeof(*ret_mws));
> +	ret_mws = devm_kmemdup_array(&ndev->ntb.pdev->dev, mws, *mw_cnt,
> +				     sizeof(mws[0]), GFP_KERNEL);
>  
> -	return ret_mws;
> +	return ret_mws ?: ERR_PTR(-ENOMEM);
>  }
>  
>  /*


