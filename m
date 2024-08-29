Return-Path: <linux-pm+bounces-13153-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42589642A3
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 13:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64C06B27945
	for <lists+linux-pm@lfdr.de>; Thu, 29 Aug 2024 11:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764011917F6;
	Thu, 29 Aug 2024 11:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kH3l1iD+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA3C190696;
	Thu, 29 Aug 2024 11:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724929587; cv=none; b=UzmPksyv18bGKDBLEGHKbMpXTuxezW2PtV++XDUP+Km+iefbw/vlWLIU7xJNZjU1EIyIXct4c6H8ZN1Aawj/oTW6kmQVQJ5p4hDWTjzUvR4vm+n+hhPoWLAuHBw0ozUnGm+yO91NUtNk6o9y+T0zLhL0TaAIhnvOPZYTu8qOGmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724929587; c=relaxed/simple;
	bh=fXFHWvDEFQpHCXW8wDIY3+3Ei0yEnEq0foY/LnXdYnQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=p3aEcbfc0WEqOPgH0SeZ6KZ2RknPnnKiw3nf+ybszW3kcYuZPUWBZx0xrXhgTjugqW481HdK+FM88U7ac5oENYjyyKiLPdLKWRU9vLp9zi2coBPLUIOGhEjl73TXYMXhRHhRIP/mGdFFJljc4qc209ur3iSwpZHJJvvYhXF1DBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kH3l1iD+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724929585; x=1756465585;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fXFHWvDEFQpHCXW8wDIY3+3Ei0yEnEq0foY/LnXdYnQ=;
  b=kH3l1iD+K8adSCUvyeBbt2gkoCxc3ovz6GhAEuqMzRkWm9D6D8rTMBY7
   XCqRefOGJSpkakDdDyp7E5BM7M2I4bgvuX1CZY7pAGxf1/uNw8SZpVI4L
   I8Voq2EX3HlP1AHZpNBrwm5UnkAQmC8AQ0uoKWHJhEqA6Ps4yswEqj57N
   o3XoYCFH1HJQK9uND8iDEuy2YFndiP29qZrfRtMTeOqSVePDwkmrA7hw0
   0ntnIiIlGK+ol57minRWHDgd9jLiXCkCsbX+rso0k8T84Gpn1p3/ET4IT
   +/g/MxrkhqGZAkSuJSfVbgoTmU71daAKLVcUOlSuiIJL6/2oJ4UfGPX+a
   A==;
X-CSE-ConnectionGUID: gEqLwi/sRWOVEnFfWay/nA==
X-CSE-MsgGUID: QBv2k5dOQgmYyjwPnLheAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23675259"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="23675259"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 04:06:24 -0700
X-CSE-ConnectionGUID: VsFVoFL9St+s/000ymnpJA==
X-CSE-MsgGUID: x/xOIDQdSWeVcnRQO/O+6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="63368439"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.59])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 04:06:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 29 Aug 2024 14:06:17 +0300 (EEST)
To: Xi Pardee <xi.pardee@linux.intel.com>
cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 07/11] platform/x86:intel/pmc: Check return value of
 ioremap
In-Reply-To: <20240828222932.1279508-8-xi.pardee@linux.intel.com>
Message-ID: <b3665329-dbe9-d78d-a988-b7c346b069de@linux.intel.com>
References: <20240828222932.1279508-1-xi.pardee@linux.intel.com> <20240828222932.1279508-8-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 28 Aug 2024, Xi Pardee wrote:

> Check the return value of ioremap operation and return ENOMEM when
> the operation fails for better error handling.
> 
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/ssram_telemetry.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/pmc/ssram_telemetry.c b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
> index 73c727042ca6..f625d39d1aa3 100644
> --- a/drivers/platform/x86/intel/pmc/ssram_telemetry.c
> +++ b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
> @@ -84,6 +84,9 @@ pmc_core_ssram_get_pmc(struct pmc_dev *pmcdev, unsigned int pmc_idx, u32 offset)
>  	ssram_base = ssram_pcidev->resource[0].start;
>  	tmp_ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
>  
> +	if (!tmp_ssram)
> +		return -ENOMEM;
> +
>  	if (pmc_idx != PMC_IDX_MAIN) {
>  		/*
>  		 * The secondary PMC BARS (which are behind hidden PCI devices)

Is this a fix to the current code? And should have Fixes tag and go 
first because of that?

-- 
 i.


