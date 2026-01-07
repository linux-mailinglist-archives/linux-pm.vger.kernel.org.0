Return-Path: <linux-pm+bounces-40395-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E4ECFF9F6
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 20:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0A353058BCF
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 19:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20452348898;
	Wed,  7 Jan 2026 18:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xo4PLeKe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D5B33AD9E;
	Wed,  7 Jan 2026 18:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767811897; cv=none; b=n6ReFb0lMLliBjXAe+ugzJo7dDFfM4eIknSpFFwuZc6m4Q6X06dw2VNTlG2GzeGNUj2jXNsWlSuiFMjwCKh8K69UdusD5UnxQRqCpVHu3W27yH20BlxlxBHhIEj4OL2YoRYT3UERvZkidZbb/AlBwjYY1XUdMH01Lh2Y2cs0FRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767811897; c=relaxed/simple;
	bh=oK2ddbEmcbKdHY/HjJVsgNc6NncfoXvn+c0af6X7qXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUqjkhKvsImeNL4NoXgKlm1bzHrbmtCTRAID1CWdpl3oNoCjPMV5/W/aFhBWaOtycvVj7+PRXoku3HbzIdUpKehmfELxWkBaLdtOBFnDNsPsBBqOMK1keniYX+42RrhPFjsaiE55l0673l6wUZjVfiggTxhLGEZR5Yrc/EBA2uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xo4PLeKe; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767811893; x=1799347893;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oK2ddbEmcbKdHY/HjJVsgNc6NncfoXvn+c0af6X7qXc=;
  b=Xo4PLeKehSJMEwHvM/aIOejb1RewLN9EraLPj+9MkdLVU1dqgGTTGOM3
   lCgikSdjkFlG13WylUoXibApPUv7FZwO5iWh9T2spFTCBHbLR1TN+s/sr
   TdBx9xLMvYDIdbyY2lB8PPt340jeP3t2dWhtn4jOOY65mhs1sFot248Fy
   GRU5i+/r+tTo8M14cAFlqKuXa62zG8EfkXpvvPoVtDijcNTJyw5g0XIBf
   +3pTvW5oevxqy7pGAh5OGDXpn1vC+Y/ecYcwYuZvRWB0WyUboRAyQVCmG
   NcSQfor1u2J9y+/vUBkSNAwgVIp855trZtstLgf6WzaUYven7ga+nyqHm
   A==;
X-CSE-ConnectionGUID: eYJlCNMbRuimH0x3OTsSTg==
X-CSE-MsgGUID: JkjMajC3TKmUEvb64qkAZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="68925246"
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="68925246"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 10:51:24 -0800
X-CSE-ConnectionGUID: eyAxprYEQj+98pau/1wVYQ==
X-CSE-MsgGUID: D/pXi+6pSw60dw/1uUsqXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="207143715"
Received: from vpanait-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.174])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 10:51:21 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 5F4EE12020E;
	Wed, 07 Jan 2026 20:51:34 +0200 (EET)
Date: Wed, 7 Jan 2026 20:51:34 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Brian Norris <briannorris@chromium.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org
Subject: Re: [PATCH v1 06/23] media: ccs: Discard pm_runtime_put() return
 value
Message-ID: <aV6rNrdHDmnG9LwB@kekkonen.localdomain>
References: <6245770.lOV4Wx5bFT@rafael.j.wysocki>
 <22966634.EfDdHjke4D@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22966634.EfDdHjke4D@rafael.j.wysocki>

Hi Rafael,

On Mon, Dec 22, 2025 at 09:03:25PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Passing the pm_runtime_put() return value to callers is not particularly
> useful.
> 
> Returning an error code from pm_runtime_put() merely means that it has
> not queued up a work item to check whether or not the device can be
> suspended and there are many perfectly valid situations in which that
> can happen, like after writing "on" to the devices' runtime PM "control"
> attribute in sysfs for one example.  It also happens when the kernel is
> configured with CONFIG_PM unset.
> 
> Accordingly, update ccs_post_streamoff() to simply discard the return
> value of pm_runtime_put() and always return success to the caller.
> 
> This will facilitate a planned change of the pm_runtime_put() return
> type to void in the future.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This patch is part of a series, but it doesn't depend on anything else
> in that series.  The last patch in the series depends on it.
> 
> It can be applied by itself and if you decide to do so, please let me
> know.
> 
> Otherwise, an ACK or equivalent will be appreciated, but also the lack
> of specific criticism will be eventually regarded as consent.

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

