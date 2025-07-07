Return-Path: <linux-pm+bounces-30288-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B831EAFB3C7
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 15:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5BA34A3853
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 13:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A0429DB6E;
	Mon,  7 Jul 2025 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XXzT9kpo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0397629CB5A;
	Mon,  7 Jul 2025 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751893213; cv=none; b=FjsOr6gCuRy+frUqyQHALppAF08uXqET3YKM9ncMp28IFrzPBS5XQPkNaudrYeIi4C0KzfqE8+2sXWa47WqRCXs/j+NFlgdhj8fos1PZxKDd2WuiwNMLcmxj7RjS+FejNGC7dmiLoggEIvTsHF0w1pbTMPFAteOoaMccMlsoBBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751893213; c=relaxed/simple;
	bh=J3DjD0salwf2bBWotRPZRsxToyGSYa/Dj6wJBZqh9D4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n3Oi+hEdtx2RevGpQJb6wVAyIEN0c2fTBAazQYMUqR7I3jVUezs9nywJJ7RWBFr9RdzC7Q0ftchiaOA3uP3qMEytzg0/8jd9NyKB07HDeLHVPZmsaYSl/i7eW1mNd6uAzBIYWOFkrb0LrpStSN/Ii5H1goIT4NSS2fJ3g1kQyJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XXzT9kpo; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751893212; x=1783429212;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=J3DjD0salwf2bBWotRPZRsxToyGSYa/Dj6wJBZqh9D4=;
  b=XXzT9kpordaFF1haLad/aod3M5Srx4g7mGQ8wnTVrPVm9QIczVxNs/fM
   1BhRowAgsjuEAY7C8I9JQE7W4gdkJXNEopcfm6EWrn/Rqiiyss2g0Hvcq
   YOWfBaaweBL4+37WFGPnxwdWBWfzmCSwPUagS739FRoDUB0eWGenQFfM8
   euK+dayoFYMUA754AfadZJ9SxsS4REWqBtM9964SZ3vuxQ/0Gtg/UB6ay
   etgs2Hs9eYFE7EEvqe7EBzAUSmvpCWU7jSgyFI/RGjzrmItuIGcwxSeZ7
   XoleJ22GNm8wdF6byFZzYG0Pt93niXY8RyDQYQbNE9V3LhtToj+tIuXwO
   Q==;
X-CSE-ConnectionGUID: 5lnmwUg3QPGeB5Dj9z2wCA==
X-CSE-MsgGUID: Dsey4dQkTkmT/pCzOqsmSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54079782"
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; 
   d="scan'208";a="54079782"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 06:00:11 -0700
X-CSE-ConnectionGUID: mNeIJhdfRjqijpugQR9ARg==
X-CSE-MsgGUID: C+3EcmpIR92v/zVMOmM/ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; 
   d="scan'208";a="159481007"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.104])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 06:00:09 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: sre@kernel.org, Hans de Goede <hansg@kernel.org>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250627205124.250433-1-W_Armin@gmx.de>
References: <20250627205124.250433-1-W_Armin@gmx.de>
Subject: Re: [PATCH 1/3] power: supply: core: Add
 power_supply_get/set_property_direct()
Message-Id: <175189320409.2280.2456749792554779164.b4-ty@linux.intel.com>
Date: Mon, 07 Jul 2025 16:00:04 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 27 Jun 2025 22:51:22 +0200, Armin Wolf wrote:

> Power supply extensions might want to interact with the underlying
> power supply to retrieve data like serial numbers, charging status
> and more. However doing so causes psy->extensions_sem to be locked
> twice, possibly causing a deadlock.
> 
> Provide special variants of power_supply_get/set_property() that
> ignore any power supply extensions and thus do not touch the
> associated psy->extensions_sem lock.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/3] power: supply: core: Add power_supply_get/set_property_direct()
      commit: 3ebed2fddf6fac5729ffc8c471c87d111b641678
[2/3] power: supply: test-power: Test access to extended power supply
      commit: a5f354232118751fe43be6ac896f8d6e7d7418b5
[3/3] platform/x86: dell-ddv: Fix taking the psy->extensions_sem lock twice
      commit: d4e83784b2a9be58b938d55efb232d2751c4cab4

--
 i.


