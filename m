Return-Path: <linux-pm+bounces-14554-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC7697E7D0
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 10:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE401F21D91
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 08:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A543C193422;
	Mon, 23 Sep 2024 08:46:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8103032A;
	Mon, 23 Sep 2024 08:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727081206; cv=none; b=IpEPEtUrFNVoC1kbLZiDfRE4S6UhZH14trww5VurDMTfStwjEkFkUZm+8Izb7VL5DqPfxOmNd1hMjNcflRFiaq1kpuuDR8Jl1E2IqIFvO8w+arO9kW761Jv64/ExZ2LXAQ83y8QlP47jl9C7hFb2sfIQifD1XLes2hqO84pgupw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727081206; c=relaxed/simple;
	bh=OTVU63kmTALPHa0CGgMy4lcPFTwPRxc9jxos8ssUmNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjSeTJRss9RkiHwmBzfQCuWDkW6QG62ZdZwbSrFf2nSfdUmCPZRu2RqOV+2e1CWFc4iWvflRm1F6IhdS7ClKQ/Y9RIEzrPRsBU05qX7TYUqSfX+w3YQzlWtGgvn0BmZBZtPb3NbH2YkJ6QW7Ihf2ldANgsIbnB7mP9GolDeETc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: daY6yaK5RFemrsItQQTd0Q==
X-CSE-MsgGUID: Jzj3b1zjSbu1UFLQoYgZww==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="36683218"
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="36683218"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 01:46:44 -0700
X-CSE-ConnectionGUID: JVFVxTx3Rb2utcz+0+/BwQ==
X-CSE-MsgGUID: xtrwNKjUQx+/2G5ukxXURg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="75376941"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 01:46:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1sseiN-0000000Btkl-3rOj;
	Mon, 23 Sep 2024 11:46:39 +0300
Date: Mon, 23 Sep 2024 11:46:39 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
	regressions@lists.linux.dev, Paul Menzel <pmenzel@molgen.mpg.de>,
	Marek Maslanka <mmaslanka@google.com>
Subject: Re: [PATCH] platform/x86:intel/pmc: Leave ACPI PM Timer alone when
 using S3 suspend
Message-ID: <ZvEq78hWn367CJV5@smile.fi.intel.com>
References: <20240919165349.235777-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919165349.235777-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Sep 19, 2024 at 06:53:49PM +0200, Hans de Goede wrote:
> Disabling the ACPI PM timer causes suspend to no longer work on
> a Intel Kaby Lake Dell XPS 13 using deep / S3 suspend.
> 
> The power-savings from disabling the pm-timer are mostly relevant for
> s0ix suspend. If regular S3 suspend is used the firmware is in control of
> the suspend and if necessary it should disable the timer if necessary.
> 
> Limit the disabling of the ACPI PM Timer on suspend to when using
> S0ix (so not firmware, but OS handled) suspend to fix this.

Acked-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko



