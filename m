Return-Path: <linux-pm+bounces-36179-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 392F5BDDF24
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 12:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 294404EEC2F
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 10:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E255631A553;
	Wed, 15 Oct 2025 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IlDyGl8S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F9C3081D8;
	Wed, 15 Oct 2025 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760523605; cv=none; b=J9YBHNfB+1hY/ct1nRf0IxJzmjIy5BILlmRj5xyDZs52U/eG5YuiB3YaE9Ek+T7b7L+zTl2WJSTZlP6PK0UJfR3dA9eiHCKfM6zZ1r1VA2mXE/DL3M6RmlFszc6wnNQJUndSfEF0eYmgBUwlPkmuqoouf8HntYsMFeYERGWbFCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760523605; c=relaxed/simple;
	bh=bs7/thg5Z5VOfFwZjE7aM1gTUyMEXNvJwxigOV1AyVg=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RlV1DZB8xDWz7ID5P7GzZip/tkaSmXXjsqxDJULK4ueL+MpNm836X5JQkVP4O7MQTg6DHspTfcF3DNHp2MYbFEhsR97zb1s68AxICsq7mwT+kfaMIGkualRMiD7ju7UWOkFeYmG7L8h8foPAg8JVcN33sOpyIqydAe027fiAiAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IlDyGl8S; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760523604; x=1792059604;
  h=from:to:in-reply-to:references:subject:message-id:date:
   mime-version:content-transfer-encoding;
  bh=bs7/thg5Z5VOfFwZjE7aM1gTUyMEXNvJwxigOV1AyVg=;
  b=IlDyGl8SvkXrVtGaMC873/7KvTeKTDj6WN5OgXYevESIP6DRrZz+Ziq1
   X2VJUnPr16xqW4MJOfpkIXbFGK3Uh8veAjpR1vivFA310rwwa5UEH3BvQ
   6skJpE6vjMaT7iednKUGXV4XhWhn5WTCBKWt73YOV28fBen5UGDcMH3vt
   P4Y31Y0v36jdaJoRCgPPKVHDOauaFRh3fNMIlNqaDaliCfwB1gNUZuIzJ
   szZxGX6pdMI9VR5/UHDz2s7ejrWfGY9xFp2K/IFhU9p1QSa5qnmoW8p4p
   t+bh3lYiY9M7OxEnjDjSCf4U4MA1EruOZhOFKGRO8QUkxtFVKizZV7QC1
   Q==;
X-CSE-ConnectionGUID: Nv4qCbErQSmg3J5YHOraoQ==
X-CSE-MsgGUID: L/1282+CRC2O3FMz5riWSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="73373162"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="73373162"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 03:20:02 -0700
X-CSE-ConnectionGUID: Pb6wy7Q2TDOmjZgJCWe77w==
X-CSE-MsgGUID: xXx2JB3URkK4h7rHYVukQA==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.75])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 03:19:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
 Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <20251014214548.629023-1-xi.pardee@linux.intel.com>
References: <20251014214548.629023-1-xi.pardee@linux.intel.com>
Subject: Re: [PATCH 0/6] Update Arrow Lake telemetry GUID
Message-Id: <176052359484.21241.13282551469499297780.b4-ty@linux.intel.com>
Date: Wed, 15 Oct 2025 13:19:54 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 14 Oct 2025 14:45:28 -0700, Xi Pardee wrote:

> This patch series updates the Arrow Lake DMU telemetry GUID and enhances
> the infrastructure for managing lpm_req_guid. Additionally, it includes
> two patches that improve the intel_pmc_core driver.
> 
> The first three patches update the Arrow Lake DMU telemetry GUID and add
> support for multiple possible GUIDs. The fourth patch standardizes the
> naming convention for PMC variable indices. The fifth patch enhances
> lpm_req_guid management. The final patch removes an unnecessary variable.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/6] platform/x86:intel/pmc: Update Arrow Lake telemetry GUID
      commit: 644ab3bc98ee386f178d5209ae8170b3fac591aa
[2/6] platform/x86:intel/pmc: Add support for multiple DMU GUIDs
      commit: 3b603955f2423cf668ebd5ba670019a5b4960cc5
[3/6] platform/x86:intel/pmc: Add DMU GUID to Arrow Lake U/H
      commit: a32f7d76e3cd7c4170db44d109661d657cfa5e21
[4/6] platform/x86:intel/pmc: Rename PMC index variable to pmc_idx
      commit: 7848154c3a11fb3ffbffd150f2185f97b5a6595a
[5/6] platform/x86:intel/pmc: Relocate lpm_req_guid to pmc_reg_map
      commit: c2bc11f1f204ef916ec96e45cf329e42873b37d6
[6/6] platform/x86:intel/pmc: Remove redundant has_die_c6 variable
      commit: 1c72d9c3e0c61468de878d906a65d4cc845718fb

--
 i.


