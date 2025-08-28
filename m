Return-Path: <linux-pm+bounces-33255-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2F2B39C37
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 14:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B1773B78CC
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 12:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078B730F807;
	Thu, 28 Aug 2025 12:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HPTgbtJy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B4630E840;
	Thu, 28 Aug 2025 12:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756382856; cv=none; b=OFE+rHYBN/YXL8OcED6mNyoLw10GZGXuM6R3gj1ckItU51fKoXwO8YdL2HcHVFtjH2ribGPzYF1eWR8LYifhUi4lCzYfV95AnrKZCU3o/sIc91qo/T1T9lpOq+DhX06mhzlFkUYj6Kfdh/29rx7BM/gMxDi2Af9jExCt6OSfMVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756382856; c=relaxed/simple;
	bh=MEsgWjHHKOSy0/qlmUZoWQO9jW51A5yBymFzPMwX+Ts=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uLW+QKK6drxVm3Qiujwj2hg88wZsAHP1R/y+hUjgyrIIWWWGqCWl/a2rHUvvVLLNwnzgIexP5ZXJZ894zIylSrpW3qmMgoOOmTFfso10wfw6/RXJXhHwRVM2rYMjYhfdpIQUZgdnFS9aTIDID2k8uxCoSRWhCvn98VxhTXUYvcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HPTgbtJy; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756382855; x=1787918855;
  h=from:to:in-reply-to:references:subject:message-id:date:
   mime-version:content-transfer-encoding;
  bh=MEsgWjHHKOSy0/qlmUZoWQO9jW51A5yBymFzPMwX+Ts=;
  b=HPTgbtJyLGTceDyR3BwcA4lsZlILjvxPzKNqcshCuYwnuYWo5aweXt7t
   sK/UTu/g+x7LxSFCLYBPs20vugQWWgnpKRZ1RLKew4XeF4esJ62bnA4IP
   uSvjKmijnkk/240v7xvq6rmShgnnWt3yMAY4Ndbp5c59uDncuIBqZxOjn
   4R/r4IvEdmxy/LuRwrcwI7cnIPwp8sLI6LPG5MVmu6Tc2qI53CEcaLNPH
   Okmbr3cpRb8DzXk73GlHc40BbwKm6RW6WsUpAgRfLqrqJfPPPmFLV146p
   G2m5JrLL4a4NFvcEMnFcUXUoMaKhHNyGCmHm3eP2wahT5hMJYIbYoyr5a
   Q==;
X-CSE-ConnectionGUID: MvjOb1y1SMGkXFxtaDAzlQ==
X-CSE-MsgGUID: /38oOU4GRvmY8qMEfW5xxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="61283450"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="61283450"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 05:07:35 -0700
X-CSE-ConnectionGUID: G3UETmsZSfSmOVUWKLJeBw==
X-CSE-MsgGUID: 0GK+TJlPRIaIC6+434Akgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="207245301"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 05:07:32 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
 Xi Pardee <xi.pardee@linux.intel.com>
In-Reply-To: <20250826183946.802684-1-xi.pardee@linux.intel.com>
References: <20250826183946.802684-1-xi.pardee@linux.intel.com>
Subject: Re: [PATCH v1 1/2] platform/x86/intel/pmc: Add Wildcat Lake
 support to Intel PMC SSRAM Telemetry
Message-Id: <175638284669.13908.17368761888999022904.b4-ty@linux.intel.com>
Date: Thu, 28 Aug 2025 15:07:26 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 26 Aug 2025 11:39:42 -0700, Xi Pardee wrote:

> Add Wildcat Lake support to Intel PMC SSRAM Telemetry driver.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/2] platform/x86/intel/pmc: Add Wildcat Lake support to Intel PMC SSRAM Telemetry
      commit: c138158e87aaca6da345603a03e5d9e8d90fdd36
[2/2] platform/x86/intel/pmc: Add Wildcat Lake support to intel_pmc_core
      commit: 1866c3b93989081770e0a59c671a483eb72ea85b

--
 i.


