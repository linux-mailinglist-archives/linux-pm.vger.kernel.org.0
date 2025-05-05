Return-Path: <linux-pm+bounces-26639-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83A4AA92F3
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 14:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E2A3B3558
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 12:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A2624887C;
	Mon,  5 May 2025 12:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZBpVUGK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4827817993;
	Mon,  5 May 2025 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746447769; cv=none; b=kV/0I1MjcqCpPGVSwzE9/XcG2BGVq9+PYF/cSfd15RU2jo3MIeZZIbBSumg8+O9PJ3e9gD7qDGRZehJbOnc8NTnS0juDtcXleJThwdTIqe/Dxrs9rKhJCakF/f/3y1LdEsGes1FCeXdsKD0sDN0DbUNJKrAHmLVE+ybFcbiN9tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746447769; c=relaxed/simple;
	bh=Y8ybWUoyZGMkPfg1A2YJrkLyMIN3pzE8FSiuDN0etOE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cR0JJYdr2BNHSXxwwiexSy8/K/dioPykiSgHKMSuea8a9C+gA67pFakMvmlytUDC7TLfUDqSM1gQtVEbwcTawUpT/eobWB8oEA3NZmKvZ1ET7wehNreVe8MY2Gsp25nv/SCJTS27tGu5H4HYNGYEEbTWPvJNOKdabxPJVkMd5iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fZBpVUGK; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746447767; x=1777983767;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Y8ybWUoyZGMkPfg1A2YJrkLyMIN3pzE8FSiuDN0etOE=;
  b=fZBpVUGK7HwxLbafyknepESXrMNZplsGjW0Tl9ZnJicCYYIvWHqmpRFQ
   golqul0Af9j/uChih2zWLRJBIpcFPJq0QYkT5pSrwHWOg7zyUVyCbCMdf
   kyzmhWO4Zio4p7baEzc2MfvcH6Zpygw8dcGh33RswHRwcLyKrK1NuYibB
   i68vFRekKmqx0en/VzpqiPVJRtMTQ5WbN4wEl6hYY9f6df/SkDteqQQFk
   yiY9T7bbCPz0Mi1h5EQSJQhmsD7WquQghX92vOrLo6w4WFpFBG3CbW7wA
   QwaxFhhFnS0hlT7Gz9TNqf+GPLaZvmpgtO9iPFpDyKObVy5ZLT6FJSC/b
   w==;
X-CSE-ConnectionGUID: mOtvbLdcT1uW05VzcDGd4g==
X-CSE-MsgGUID: 5iJgjcJ3TyCEjRQ5i9rkhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11423"; a="51706556"
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="51706556"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 05:22:45 -0700
X-CSE-ConnectionGUID: EhktSXioRkilbp+oZQALmw==
X-CSE-MsgGUID: TF2r7xXfRiySogHX9A5sAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="166156824"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.68])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 05:22:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 5 May 2025 15:22:39 +0300 (EEST)
To: Sebastian Reichel <sebastian.reichel@collabora.com>
cc: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] power: supply: core: Add additional health status
 values
In-Reply-To: <wla5mfgblecq7tiiangrzxv32yjhiru4h6i7nnmn3qvvl6o3ht@j7rbgete42u7>
Message-ID: <8cb0e0f7-a48e-5770-0c82-f0a75ed23d66@linux.intel.com>
References: <20250429003606.303870-1-W_Armin@gmx.de> <wla5mfgblecq7tiiangrzxv32yjhiru4h6i7nnmn3qvvl6o3ht@j7rbgete42u7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 30 Apr 2025, Sebastian Reichel wrote:
> On Tue, Apr 29, 2025 at 02:36:03AM +0200, Armin Wolf wrote:
> > Some batteries can signal when an internal fuse was blown. In such a
> > case POWER_SUPPLY_HEALTH_DEAD is too vague for userspace applications
> > to perform meaningful diagnostics.
> > 
> > Additionally some batteries can also signal when some of their
> > internal cells are imbalanced. In such a case returning
> > POWER_SUPPLY_HEALTH_UNSPEC_FAILURE is again too vague for userspace
> > applications to perform meaningful diagnostics.
> > 
> > Add new health status values for both cases.
> > 
> > Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Hi Sebastian,

Is it okay with you I take this through pdx86 tree?

--
 i.

> 
> -- Sebastian
> 
> > ---
> > Changes since v1:
> >  - rename "Fuse blown" to "Blown fuse"
> >  - rename "Cell imbalanced" to "Cell imbalance"
> > ---
> >  Documentation/ABI/testing/sysfs-class-power | 2 +-
> >  drivers/power/supply/power_supply_sysfs.c   | 2 ++
> >  include/linux/power_supply.h                | 2 ++
> >  3 files changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> > index 2a5c1a09a28f..be8be54b183d 100644
> > --- a/Documentation/ABI/testing/sysfs-class-power
> > +++ b/Documentation/ABI/testing/sysfs-class-power
> > @@ -456,7 +456,7 @@ Description:
> >  			      "Over voltage", "Under voltage", "Unspecified failure", "Cold",
> >  			      "Watchdog timer expire", "Safety timer expire",
> >  			      "Over current", "Calibration required", "Warm",
> > -			      "Cool", "Hot", "No battery"
> > +			      "Cool", "Hot", "No battery", "Blown fuse", "Cell imbalance"
> >  
> >  What:		/sys/class/power_supply/<supply_name>/precharge_current
> >  Date:		June 2017
> > diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> > index edb058c19c9c..2703ed1dd943 100644
> > --- a/drivers/power/supply/power_supply_sysfs.c
> > +++ b/drivers/power/supply/power_supply_sysfs.c
> > @@ -110,6 +110,8 @@ static const char * const POWER_SUPPLY_HEALTH_TEXT[] = {
> >  	[POWER_SUPPLY_HEALTH_COOL]		    = "Cool",
> >  	[POWER_SUPPLY_HEALTH_HOT]		    = "Hot",
> >  	[POWER_SUPPLY_HEALTH_NO_BATTERY]	    = "No battery",
> > +	[POWER_SUPPLY_HEALTH_BLOWN_FUSE]	    = "Blown fuse",
> > +	[POWER_SUPPLY_HEALTH_CELL_IMBALANCE]	    = "Cell imbalance",
> >  };
> >  
> >  static const char * const POWER_SUPPLY_TECHNOLOGY_TEXT[] = {
> > diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> > index 888824592953..69df3a452918 100644
> > --- a/include/linux/power_supply.h
> > +++ b/include/linux/power_supply.h
> > @@ -71,6 +71,8 @@ enum {
> >  	POWER_SUPPLY_HEALTH_COOL,
> >  	POWER_SUPPLY_HEALTH_HOT,
> >  	POWER_SUPPLY_HEALTH_NO_BATTERY,
> > +	POWER_SUPPLY_HEALTH_BLOWN_FUSE,
> > +	POWER_SUPPLY_HEALTH_CELL_IMBALANCE,
> >  };
> >  
> >  enum {
> > -- 
> > 2.39.5
> > 
> 

