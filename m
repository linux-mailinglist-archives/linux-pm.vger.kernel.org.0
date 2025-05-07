Return-Path: <linux-pm+bounces-26780-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3593FAADA84
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 10:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536211BC47A5
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 08:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AF91FC109;
	Wed,  7 May 2025 08:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZZux7i0V"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CD81E3DFD;
	Wed,  7 May 2025 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746607903; cv=none; b=BwY1B6FARMapoeeJJgQhBO5t/pScNcRPZBDUOivvs2e32kVXwAXrnJ5CYq4XhMJAU/bPvqHObYRDlIyUj/C3Fcub4Xim8RgTfqO4wcaiYK3ryAqD0VHICc+hD4mQ5+nS1hPmUkvWG9gzyxS3aFaytoS+t6zL6zyKfJbkjogPGwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746607903; c=relaxed/simple;
	bh=ZRGbU16EbvLnN1mbcnVMGiKhfTvveYDWrA+XdW/F9ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EG1Lqqk/kr5i4eoAREq9PCBQ0/6HvIZcEaH5M0eQWHawld1McYHlPpTMNluO0K/cYxoubZNqu3WUzg9Y1JfcbRr6lyFQmScT4mgBsqwNeXqmfZyZaHl/Zu9euhls2TZlfMY6fm0pO5ceuzfLmQVeLxDNrNDKkmqeCmKTVj0xtjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZZux7i0V; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746607902; x=1778143902;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZRGbU16EbvLnN1mbcnVMGiKhfTvveYDWrA+XdW/F9ag=;
  b=ZZux7i0V4caVjSoAGZbGly6568nQcIuklKPUoZpqUNChrx8ULFLvm2td
   xQlskQSS/CHozvQdgFxugLud7X5BmxncbC9xf1Jo/pqxS/rewBhc15ng2
   Q9SooLhncYX30szHXY9GTGF3G+qWiYTb2UUtcXzE/j0krOotEuaOirBDx
   8QDKegDwBVhXPip9ITWOmkj0pxvMB41m4jCT1U9ZkQJxXmskaHUSAsU5+
   bhRA2sPyMef2N400G428G/arn9ZyNOc5Ho4OL0dj/eqcloDy5OMiX18bN
   7R4UTWexZQVkUxatGyNxvE8LtVLwuHAd5ZWxDeFZj2qYLjUNtqTexEeE4
   A==;
X-CSE-ConnectionGUID: EE5cua3SQ16CMAgr86aIIg==
X-CSE-MsgGUID: QznCW1lnQ/Gj5k0liUG7ZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48458801"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="48458801"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 01:51:41 -0700
X-CSE-ConnectionGUID: EtXsSu9LQe6T33TJsof/7g==
X-CSE-MsgGUID: UT0T4aFTS862wyvBzJ35Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="135611044"
Received: from yungchua-mobl2.ccr.corp.intel.com (HELO [10.246.105.120]) ([10.246.105.120])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 01:51:38 -0700
Message-ID: <eff651df-bc2a-45bf-a629-5adb4f8f398c@linux.intel.com>
Date: Wed, 7 May 2025 16:51:35 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] soundwire: intel_auxdevice: Fix system suspend/resume
 handling
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Sanyog Kale <sanyog.r.kale@intel.com>, linux-sound@vger.kernel.org,
 bard.liao@intel.com
References: <5891540.DvuYhMxLoT@rjwysocki.net>
 <30acf520-c137-4b49-8b69-08e35a7c5969@linux.dev>
Content-Language: en-US
From: "Liao, Bard" <yung-chuan.liao@linux.intel.com>
In-Reply-To: <30acf520-c137-4b49-8b69-08e35a7c5969@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/26/2025 1:12 AM, Pierre-Louis Bossart wrote:
> On 4/24/25 20:13, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> The code in intel_suspend() and intel_resume() needs to be properly
>> synchronized with runtime PM which is not the case currently, so fix
>> it.
>>
>> First of all, prevent runtime PM from triggering after intel_suspend()
>> has started because the changes made by it to the device might be
>> undone by a runtime resume of the device.  For this purpose, add a
>> pm_runtime_disable() call to intel_suspend().
> 
> Allow me to push back on this, because we have to be very careful with a hidden state transition that needs to happen.
> 
> If a controller was suspended by pm_runtime, it will enter the clock stop mode.
> 
> If the system needs to suspend, the controller has to be forced to exit the clock stop mode and the bus has to restart before we can suspend it, and that's why we had those pm_runtime_resume().
> 
> Disabling pm_runtime when entering system suspend would be problematic for Intel hardware, it's a known can of worms.
> 
> It's quite possible that some of the code in intel_suspend() is no longer required because the .prepare will resume the bus properly, but I wanted to make sure this state transition out of clock-stop is known and taken into consideration.
> 
> Bard, is this a configuration you've tested?


Sorry for the late reply. Yes, I tested jack detection in runtime
suspended. Also, the CI test is passed.


