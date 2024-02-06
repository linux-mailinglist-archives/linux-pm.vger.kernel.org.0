Return-Path: <linux-pm+bounces-3503-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A228584BC75
	for <lists+linux-pm@lfdr.de>; Tue,  6 Feb 2024 18:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D362288F5A
	for <lists+linux-pm@lfdr.de>; Tue,  6 Feb 2024 17:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532E76ABA;
	Tue,  6 Feb 2024 17:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ft7NImPT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97170C133
	for <linux-pm@vger.kernel.org>; Tue,  6 Feb 2024 17:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707241569; cv=none; b=FppN7WpTC9xr7hOMfvGuyyqcv2Ctf8MZ0C3S4un3m89piE/8ahTP43tYoT7o+naC6jov63bI2fplv16IcaWYbhp+xZSCVigUEaNVMv3ueu0i0OiGWHD023+6+Y9e//24ckWHBrKUttY8DEzIomBc6SINYHt4moUZOi77OMpR0fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707241569; c=relaxed/simple;
	bh=PE6mFaS1w6GExhvNvwH+FcI750kGC8Rv2rjzlCIwILE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbyHYA/s7RfVfs8sVd9k0OxhWBsANdNQCBWkGo6b2e1le4OaYjtQje84CzBf2YptqU59JFZA6NzIQDK6/+ghFgRFTDq4VoPsh1PgfHasE5MX5rqznSIxjCmCIecbZE2j4nbHvNtOoQw8+yfl4DVODq0q6IDkQU4co01Xq9u7wNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ft7NImPT; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707241568; x=1738777568;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PE6mFaS1w6GExhvNvwH+FcI750kGC8Rv2rjzlCIwILE=;
  b=ft7NImPT+qZ6R3b2BjRNZFY3qF9y3VcEinoBo7cpvkmy2OmdbzDRAUAY
   pZr2i1W0h5inig/Ah6wNxlTE0D1BQ/FZZoW01+bPLmgeFMAhHol7Ng7x7
   Yr51VZvqQVVMW/dSkTrpALOb69/PmFF6usU+5j1oKZ4ZVlKTH7JWDOgQy
   Mq39U7z+3xd4ZSyTueGH/xm5lAh1m3Qo/3r3tSrwpSay5gckQ6b2xBz/A
   L59MMuo11/7bq4S/bcwR5WUOQEttFuJpmjcV6IpCerRsHZOaP3qs2+jhV
   gCv8zh1HDOctB40Or4XHC3+WGKYpWWS2LXLoPBpkAHW/8ZL98S8PfR5J3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="4595770"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="4595770"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 09:40:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="5684139"
Received: from seswarav-mobl.amr.corp.intel.com (HELO desk) ([10.209.58.175])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 09:40:13 -0800
Date: Tue, 6 Feb 2024 09:40:11 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Li RongQing <lirongqing@baidu.com>
Cc: linux-pm@vger.kernel.org
Subject: Re: [PATCH] intel_idle: update spec_ctrl register only when necessary
Message-ID: <20240206174011.tvwl753clni2bxio@desk>
References: <20240206071452.42673-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206071452.42673-1-lirongqing@baidu.com>

On Tue, Feb 06, 2024 at 03:14:52PM +0800, Li RongQing wrote:
> spec_ctrl maybe 0 when mitigations is off, and writing spec_ctrl MSR
> is expensive operation, so update spec_ctrl only when necessary

Have you observed SPEC_CTRL MSR being written on idle when mitigations
are off?

IIUC, intel_idle_ibrs() will only be called when X86_FEATURE_KERNEL_IBRS
is set:

state_update_enter_method()
{
...
          if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS) &&
                          ((state->flags & CPUIDLE_FLAG_IBRS) || ibrs_off)) {
		  ...
                  state->enter = intel_idle_ibrs;
                  return;
          }

And X86_FEATURE_KERNEL_IBRS wont be set when mitigations are off.

