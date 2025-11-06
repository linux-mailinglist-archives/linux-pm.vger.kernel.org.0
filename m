Return-Path: <linux-pm+bounces-37507-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22123C3AE63
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 13:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5E1C3B06EA
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 12:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D14E3277A7;
	Thu,  6 Nov 2025 12:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A69ZaGeM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5872F291D;
	Thu,  6 Nov 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762432152; cv=none; b=O1rHWT+GOOMIzytw5fsD3McgCMnyANV5C0MPMhuKV6TxQ9LqDscIg1OmNQbsRr7RSJbUnIkdiQF8YgvZz/NA1+z2bX+xaP37pesO7+1ZvVAbzZPeIIo0cT1PANElr/2OUBeLQlrjqC5yU4aezJzODFqZ1VSonzQdD0zTiIh5f3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762432152; c=relaxed/simple;
	bh=ERJmoxOB7bQoI4DfXgSXp3efgxUaQ2oFpC72NQoTjNE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nMh8oAsCxXEEMf83x5tfP9wOLjBdoVg8o0In1v4IE8T9ipZOhy+jzMyhcL10a/3ODLhYfghJ7nOsVOaGgCP66tTErke0UTut4NysF3OMK8K07uBqeSAx+5CZ2h5y502EvG6gO87/NfjeeSWQx9rUsdaqC1YKyb8KEj3keG9kw6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A69ZaGeM; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762432151; x=1793968151;
  h=from:to:in-reply-to:references:subject:message-id:date:
   mime-version:content-transfer-encoding;
  bh=ERJmoxOB7bQoI4DfXgSXp3efgxUaQ2oFpC72NQoTjNE=;
  b=A69ZaGeMzOXQtpHQxGi8vowHedNT4FIuzPAGjADnh8j/GgmzuEM3nVSP
   YKnLV0/Z9ENMd+r9cQmd1gdfAUdATwXxPrUvcs/yMU3n8Z8dWXQL/p65/
   F2Rd7s9AYW1XYDn7AOJ75s+kIUESzvka23RFDP1N+5c5ldRgJRsdt8awG
   oOKWfXPON/aAamsoM6x3K1adeD6wRdF9UAwQVJwSjCEsFr+LFTqATuMLL
   SKCMZvHjd0yMPd6alsN1ET57crf3AqxN7l32dY70QODE/LcPN6pO9hgXn
   OebOiCUs19JgkIAspq4kBmkRTIGx87TFpeXYYKPnAxWoFnKQoiky304RU
   w==;
X-CSE-ConnectionGUID: mGC0JFiuQG2KsmRHWuOpPQ==
X-CSE-MsgGUID: Xa4SnWk/SEaxxw3wLqhBwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="74856166"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="74856166"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 04:29:10 -0800
X-CSE-ConnectionGUID: AcGVl4vVTTGtZVAXTAT2kQ==
X-CSE-MsgGUID: KH7u5L8WRHeVIBmF1iHtAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="187591818"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.187])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 04:29:07 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
 Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <20251105215020.1984036-1-xi.pardee@linux.intel.com>
References: <20251105215020.1984036-1-xi.pardee@linux.intel.com>
Subject: Re: [PATCH 1/2] platform/x86/intel/vsec: Add support for Wildcat
 Lake
Message-Id: <176243214239.3161.9066799480591024469.b4-ty@linux.intel.com>
Date: Thu, 06 Nov 2025 14:29:02 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 05 Nov 2025 13:50:14 -0800, Xi Pardee wrote:

> Add Wildcat Lake PMT telemetry support.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/2] platform/x86/intel/vsec: Add support for Wildcat Lake
      commit: afc0f9ee9e1684288cbcb57b93f7e225eb8b6c44
[2/2] platform/x86:intel/pmc: Enable SSRAM support for Wildcat Lake
      commit: 9c8249cfdf5aa2b843b0cbef81eb0898493694fe

--
 i.


