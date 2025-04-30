Return-Path: <linux-pm+bounces-26430-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA5FAA3FEE
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 02:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF091B67CDE
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 01:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE1E63B9;
	Wed, 30 Apr 2025 00:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jQpsrssK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F895383;
	Wed, 30 Apr 2025 00:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745974791; cv=none; b=hY5ycvYgehizfL9DpkmKbp+9HDST4LZGwZDlfBPaWjO5y+H/sQqfwVxIgHDVB+rK581QNYgPFsRb9EWbaweQQL+Vi81WThbkfM2VjYdYeUn7vOg05sU5Sn0v/Hns/lSH7AgINm9wzWHINI1y+3jVCiknnhgb2+ccNHLd0tR6RAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745974791; c=relaxed/simple;
	bh=WhUB3VaFezDmHRqv2eDG+gPvY+Gb2z2eJ972ck0h/xY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BcQlU+aObHs2iwsAaGq4Bau3ynX68oTo01yRoUZHxL/bmuBrpTaBhjKhYvWL9BuFcxI9GoUXgS1O7/BrsVzg/oku+UbUHsFmSfawCk5FR0xDdDgIzb6xFoyATtxB6UNaQAiJOMKJ+NvZjmpip28rojX4JUNK+BoZao5X7azzuAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jQpsrssK; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745974790; x=1777510790;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WhUB3VaFezDmHRqv2eDG+gPvY+Gb2z2eJ972ck0h/xY=;
  b=jQpsrssKdCcQRbXmhLvpM5dDEll0LHp9WVwNbuK1aJNC+HGIY3hPOmOf
   JohwZ+oVcyDoV0ZrEHWmd2WuK/P4keprqW5aPkvNTTcURgBv0B0dq72jM
   Yz+O+2HqZOYINVRgdvH0FOk34wzWB+rjX3M1EfjfEGbdfQAmNqq0UdTNN
   tumVrAe/mR530RsMZ+ZbErpxBl2SF0XB2W6LxRTJdqod8vqI5o3FB4ieP
   wJzj2w9461whG7iIyKXJFLXzd2a0wYYUO2RRH6c73oOe0RWuLMv3Vk/CK
   jFDTw6ENK6ZdJx9QTsNOIT8COD3cqnlqw20K8GOvieIMwFFAlNtgDB5Cm
   w==;
X-CSE-ConnectionGUID: yHk24WglSs21P4+7sBTa4g==
X-CSE-MsgGUID: Ls9TDTMfRnCCzxN8c4M2GA==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="50278527"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="50278527"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 17:59:49 -0700
X-CSE-ConnectionGUID: 7KPA1S2zSQWO0ACI85ZHlQ==
X-CSE-MsgGUID: GOuRf77DS/CBJpncNm4nwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="133918074"
Received: from yungchua-mobl2.ccr.corp.intel.com (HELO [10.246.104.98]) ([10.246.104.98])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 17:59:45 -0700
Message-ID: <d4cafb3f-2045-40c1-a8fd-58dd46485232@linux.intel.com>
Date: Wed, 30 Apr 2025 08:59:27 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] soundwire: intel_auxdevice: Fix system suspend/resume
 handling
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Vinod Koul <vkoul@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Sanyog Kale <sanyog.r.kale@intel.com>, linux-sound@vger.kernel.org
References: <12680420.O9o76ZdvQC@rjwysocki.net>
Content-Language: en-US
From: "Liao, Bard" <yung-chuan.liao@linux.intel.com>
In-Reply-To: <12680420.O9o76ZdvQC@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/29/2025 3:50 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Before commit bca84a7b93fd ("PM: sleep: Use DPM_FLAG_SMART_SUSPEND
> conditionally") the runtime PM status of the device in intel_resume()
> had always been RPM_ACTIVE because setting DPM_FLAG_SMART_SUSPEND had
> caused the core to call pm_runtime_set_active() for that device during
> the "noirq" resume phase.  For this reason, the pm_runtime_suspended()
> check in intel_resume() had never triggered and the code depending on
> it had never run.  That had not caused any observable functional issues
> to appear, so effectively the code in question had never been needed.
> 
> After commit bca84a7b93fd the core does not call pm_runtime_set_active()
> for all devices with DPM_FLAG_SMART_SUSPEND set any more and the code
> depending on the pm_runtime_suspended() check in intel_resume() runs if
> the device is runtime-suspended prior to a system-wide suspend
> transition.  Unfortunately, when it runs, it breaks things due to the
> attempt to runtime-resume bus->dev which most likely is not ready for a
> runtime resume at that point.
> 
> It also does other more-or-less questionable things.  Namely, it
> calls pm_runtime_idle() for a device with a nonzero runtime PM usage
> counter which has no effect (all devices have nonzero runtime PM
> usage counters during system-wide suspend and resume).  It also calls
> pm_runtime_mark_last_busy() for the device even though devices cannot
> runtime-suspend during system-wide suspend and resume (because their
> runtime PM usage counters are nonzero) and an analogous call is made
> in the same function later.  Moreover, it sets the runtime PM status
> of the device to RPM_ACTIVE before activating it.
> 
> For the reasons listed above, remove that code altogether.
> 
> On top of that, add a pm_runtime_disable() call to intel_suspend() to
> prevent the device from being runtime-resumed at any point after
> intel_suspend() has started to manipulate it because the changes
> made by that function would be undone by a runtime-suspend of the
> device.
> 
> Next, once runtime PM has been disabled, the runtime PM status of the
> device cannot change, so pm_runtime_status_suspended() can be used
> instead of pm_runtime_suspended() in intel_suspend().
> 
> Finally, make intel_resume() call pm_runtime_set_active() at the end to
> set the runtime PM status of the device to "active" because it has just
> been activated and re-enable runtime PM for it after that.
> 
> Additionally, drop the setting of DPM_FLAG_SMART_SUSPEND from the
> driver because it has no effect on devices handled by it.
> 
> Fixes: bca84a7b93fd ("PM: sleep: Use DPM_FLAG_SMART_SUSPEND conditionally")
> Reported-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Tested-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2: New changelog
> 
> Since it fixes a recent regression in 6.15-rc, I can route it through the
> PM tree unless that would be a major concern.
> 

 Acked-by: Bard Liao <yung-chuan.liao@linux.intel.com>

