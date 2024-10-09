Return-Path: <linux-pm+bounces-15412-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4217F99719B
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 18:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1201C2033E
	for <lists+linux-pm@lfdr.de>; Wed,  9 Oct 2024 16:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924181E5715;
	Wed,  9 Oct 2024 16:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bApfItvi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64A31E0481;
	Wed,  9 Oct 2024 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491277; cv=none; b=Y6ltpNiu1NPm4Um6+xovLvWdU1nXkB4/Pv1raQTBbZWygSKH0gKFuNthUiGTm8uI5opnalgCAtV/Xi48RN3l29jg2X0h4nB9lnImkXRrsIPpLnpBpQDQNN6fx4ZeV+Nr4g9nu3nNxmxgXyg+GYGFwEc+J0TCsHGexMFSiOulj3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491277; c=relaxed/simple;
	bh=5IONwWAaygzDPnMaidc2cVsIS1VTE48ucYzxzIFEfRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czzc0gFI5J3ouR2ZvzD1TfZS/WkR98zbBZiLZxG2PqgrA2gg7zAZaO1raRT80X+UstvwayVAWPwCUm2I3gruHY+eB8qTg84urOyf3JoexTWcHRoEZT4HVRtSHAJ51654SnbYKQ6WHJwoDFoDw4USGG9It+rQdaF3FRKR/JUNLRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bApfItvi; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728491276; x=1760027276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5IONwWAaygzDPnMaidc2cVsIS1VTE48ucYzxzIFEfRs=;
  b=bApfItviV/I1Z0u3zLELfP9Wianikem1TIuWehvTqQcVHqyYVuzfj5+g
   +MvVkBI/fTZoeCXa+1uw3Y5MdWjd28cDXio9OyszSKkqbWVStdvBVBfxi
   KB+PTelXv9yGxHIFssu3LaRt5R7G5PmEXMFuIcEBEuuUyzSdz+8g+A9Wa
   LlOeDj0XuDQmjfP8LRuwdNBEVFQOQwmMdrrNagfZki6mn/j8JoevqmMXY
   U2rDWhSU9qrkwJZ/2ZtI03IYpxz8iEus1GoVq37vQgPlFX5MLNjwmJGB4
   PaVn2nntkhS5xZa84QHhKKKqRGDQgO0NGL/nS7msZo8Sv3wS6mIrfW3L5
   A==;
X-CSE-ConnectionGUID: EpHP8rbZSiu9n8Z57vJU9A==
X-CSE-MsgGUID: my6SKx7dQh2nmUustK0M4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27923222"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="27923222"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 09:27:55 -0700
X-CSE-ConnectionGUID: oQoVtMfHTjmqz0Cmn1i1Zg==
X-CSE-MsgGUID: CPHxacxfT/GicCpeJ5tzmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="80292162"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 09:27:54 -0700
Date: Wed, 9 Oct 2024 09:33:44 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Zhang Rui <rui.zhang@intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, rafael.j.wysocki@intel.com,
	x86@kernel.org, linux-pm@vger.kernel.org, hpa@zytor.com,
	peterz@infradead.org, thorsten.blum@toblux.com,
	yuntao.wang@linux.dev, tony.luck@intel.com, len.brown@intel.com,
	srinivas.pandruvada@intel.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH V2] x86/apic: Stop the TSC Deadline timer during lapic
 timer shutdown
Message-ID: <20241009163344.GA25814@ranerica-svr.sc.intel.com>
References: <20241009072001.509508-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009072001.509508-1-rui.zhang@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, Oct 09, 2024 at 03:20:01PM +0800, Zhang Rui wrote:
> This 12-year-old bug prevents some modern processors from achieving
> maximum power savings during suspend. For example, Lunar Lake systems

Two nits:

> gets 0% package C-states during suspend to idle and this causes energy
> star compliance tests to fail.

s/gets/get/
s/energy start/Energy Star/

