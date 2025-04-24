Return-Path: <linux-pm+bounces-26124-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AF4A9AFCC
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 15:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422E63BA61D
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 13:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A012147EA;
	Thu, 24 Apr 2025 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ja2BQ0Ex"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA5D1624E9;
	Thu, 24 Apr 2025 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745502637; cv=none; b=caD63qQXXNySOl45wNl/vCgLrGh19zrXCwCoee7SEpsr3Uo9igXpKnEzvK0YIiRC0eGF1HIACIq/iDajQcWTg6yW457GaNIJYY+/bUuYvcWCbfBPy2iBOZ3YHoE5nyK7Tqt8fifxHTGbrYcZWyFn/4rmU/FKu4p8MLIDiAuTNtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745502637; c=relaxed/simple;
	bh=5JL2fhJiXzvgPGufoPeHeSIrQj6ar4IZnKQEH9m8M8I=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cSlhWUNquMiHNa3bpRPnqmXygX6DsAgxp1FtptCsoeOcAi+a7rE56Oe3B8BQr80eCMXc+zzNdpm1BXuVAVrRaLzsQB4g/qQuiy6ZurATCsESE+MSoEnaReVCXxL10YwcV21ZJbYeiwkfdFIwpieZwHii+8gyeX4cp49yYkDGujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ja2BQ0Ex; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745502636; x=1777038636;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5JL2fhJiXzvgPGufoPeHeSIrQj6ar4IZnKQEH9m8M8I=;
  b=ja2BQ0ExrfVVmn0fX/KYhG8ZIi+8Ea8B6NDq/kdVa44FiF2YZS79221n
   nw4InhRckhmvO9f8JV+fuRsFARQbpjKOjxkQCGofEMiI+1s8yr0j9hbpa
   LuayzLy5nMOp9DxZpIPYY8rtaI5WF4Wpw1hPnuecaAGtk4ETsqLo0GDZ6
   ajffbmzL4QlNpTEHd6jihUKC5K9bc/FifN1guEwPx6A8a+RLG4jgcYPnN
   SNcCOJILFaXgRT4dxEndovh5pCIkXMQHSHgWjfmuLMMA1hPeKCuxGJ86J
   bQ2anNaEqDpBUInN4gc8Ck/fr37EJyuRQP7avEZitACoOD0XCZ2P+jfeE
   g==;
X-CSE-ConnectionGUID: NA0m8mj1Sl27bHvZJnHmRQ==
X-CSE-MsgGUID: ILnsk3UuQ4aDhI1S9o62AA==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="34756283"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="34756283"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 06:50:34 -0700
X-CSE-ConnectionGUID: zyNcbMEZR0u0xT8pTcZuOw==
X-CSE-MsgGUID: +omxsx4MTzOXm5y5EpJ4cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="132605524"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 06:50:29 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 24 Apr 2025 16:50:25 +0300 (EEST)
To: Antheas Kapenekakis <lkml@antheas.dev>
cc: platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org, 
    linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, 
    Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>, 
    Jonathan Corbet <corbet@lwn.net>, 
    Joaquin Ignacio Aramendia <samsagax@gmail.com>, 
    Derek J Clark <derekjohn.clark@gmail.com>, 
    Kevin Greenberg <kdgreenberg234@protonmail.com>, 
    Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>, 
    Eileen <eileen@one-netbook.com>, LKML <linux-kernel@vger.kernel.org>, 
    sre@kernel.org, linux@weissschuh.net, Hans de Goede <hdegoede@redhat.com>, 
    mario.limonciello@amd.com
Subject: Re: [PATCH v9 15/15] platform/x86: oxpec: Rename rval to ret in
 tt_toggle
In-Reply-To: <20250417175310.3552671-16-lkml@antheas.dev>
Message-ID: <851ff55e-68d5-c358-df37-e6404a8fe39f@linux.intel.com>
References: <20250417175310.3552671-1-lkml@antheas.dev> <20250417175310.3552671-16-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 17 Apr 2025, Antheas Kapenekakis wrote:

> Rename the variable `rval` to `ret` in the function
> to follow conventions.

This and a few other changelogs use exceptionally short paragraph width, 
please reflow.

--
 i.

> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/platform/x86/oxpec.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
> index ce20bf70027df..93d4abf8c3b8a 100644
> --- a/drivers/platform/x86/oxpec.c
> +++ b/drivers/platform/x86/oxpec.c
> @@ -409,19 +409,19 @@ static ssize_t tt_toggle_store(struct device *dev,
>  			       size_t count)
>  {
>  	bool value;
> -	int rval;
> +	int ret;
>  
> -	rval = kstrtobool(buf, &value);
> -	if (rval)
> -		return rval;
> +	ret = kstrtobool(buf, &value);
> +	if (ret)
> +		return ret;
>  
>  	if (value) {
> -		rval = tt_toggle_enable();
> +		ret = tt_toggle_enable();
>  	} else {
> -		rval = tt_toggle_disable();
> +		ret = tt_toggle_disable();
>  	}
> -	if (rval)
> -		return rval;
> +	if (ret)
> +		return ret;
>  
>  	return count;
>  }
> 

