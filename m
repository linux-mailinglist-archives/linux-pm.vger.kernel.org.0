Return-Path: <linux-pm+bounces-22823-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B134EA42623
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 16:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04551891386
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 15:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265F819CC08;
	Mon, 24 Feb 2025 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lpoXGh29"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969872747B;
	Mon, 24 Feb 2025 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740410248; cv=none; b=eiX4gDNudp56yDRu2SSOCOsHWulBGC3hOVT+azqHog7NNg9g4iTQoqk+LodyV/I1LERAdNDfpM6JU3+hUXfyPlEaak1kBRn+XikqN6L1go0CNGuWI0lFnjVP5DA2lF5auSiEQ2hZ93nFDrKEnBLLHQF2pczB0IrceuyKCRjGH20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740410248; c=relaxed/simple;
	bh=sQimosQ2z+83CglJXTa8C0ZKfUSZD4Ae4NihGOTawUQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KgmrBm8JFnUZQNA+xWmfCwVUhIUyBwlQspki1TeJGxX2AuzD2i/PYCigtLxwex8BZS1R0huPjQJXDIfD67e+7/3lpvZ1BdzoXJZTqMHyV8woX5RvvXv3RY/3wk+1s/8Kglo+76gP+S0vbt6+jkdU24omS88+Kcp505R2a4VRvJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lpoXGh29; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740410247; x=1771946247;
  h=from:to:in-reply-to:references:subject:message-id:date:
   mime-version:content-transfer-encoding;
  bh=sQimosQ2z+83CglJXTa8C0ZKfUSZD4Ae4NihGOTawUQ=;
  b=lpoXGh29MXje56PSBRRn3oBSWXscP6defYACR+3idCBBWOxj+PHe0wOr
   Ow1hCDrmJmXHmHcQp6+1pbtT33Syfxl0XMiwVt0/NsteLoXQkofsAGUlG
   XkDQSiAVC8+GcukkQsMVA7aY4nCwT2iA4EGk1CWF/e4WdJ6hQExuysLBQ
   2wjFPD+dVo3OZ9nptQbR+4ajYpvPeGJMIrMMPX5EoyNg3fihgfshk3l2e
   Oan6ZuQvxvrnJZfEF7x7EM2DbgtwwAPm4zzjKx0CD6E8Rnk8RbtZZE/Zg
   +vCyuT3GaWD4RjMwdbzt61qR2+sm+5vHc6Vtopvx6U3/RVmN+NVgz33ux
   Q==;
X-CSE-ConnectionGUID: 9A3BQ6iETuqM/5x7gvUxUw==
X-CSE-MsgGUID: wZjH9QRSQE2cXOYXUvWwZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="52160649"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="52160649"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 07:17:26 -0800
X-CSE-ConnectionGUID: sl0X7ItiTOCA+mYGCMjByA==
X-CSE-MsgGUID: yq4VBFDoT9Ww1TLvROGvmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="121180699"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.233])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 07:17:23 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: rajvi0912@gmail.com, irenic.rajneesh@gmail.com, 
 david.e.box@linux.intel.com, hdegoede@redhat.com, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <20250214214416.10150-1-xi.pardee@linux.intel.com>
References: <20250214214416.10150-1-xi.pardee@linux.intel.com>
Subject: Re: [PATCH v2 0/3] Add Pather Lake support to intel_pmc_core
Message-Id: <174041023817.15708.16693455390305946085.b4-ty@linux.intel.com>
Date: Mon, 24 Feb 2025 17:17:18 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 14 Feb 2025 13:44:08 -0800, Xi Pardee wrote:

> This patch series contains three patches. The first one adds Panther
> Lake support to intel_pmc_core driver. The second patch removes
> unnecessary declarations in header file. The third patch removes
> unnecessary extern keyword of function declaration in header file.
> 
> v2->v1:
> - Remove unnecessary variable declarations in header file
> - Remove unnecessary extern keyword in header file
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/3] platform/x86/intel/pmc: Add Panther Lake support to intel_pmc_core
      commit: d31feed799c1a25750cc72113c22b1d4d744be21
[2/3] platform/x86/intel/pmc: Remove unnecessary declarations in header
      commit: 9eeeb2a7c77313530a223b58ac53f0eba1c6292c
[3/3] platform/x86/intel/pmc: Remove unneeded extern keyword in header
      commit: c5855d2022b0d33702d5da24ed8caa80a3e57c23

--
 i.


