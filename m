Return-Path: <linux-pm+bounces-20562-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3B4A13F00
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 17:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637FC188A5E4
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 16:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB8222BAD9;
	Thu, 16 Jan 2025 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KEtb+6TK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C131022A7FA;
	Thu, 16 Jan 2025 16:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737044018; cv=none; b=EnuIZcgtdQvpsAwNt4DkGB7P0bQvDpiFDbMtW0TAW1TPrF/HiXgnRd1esdIA8g9cBOvmN7a7i+9eIwjqctaJB/1ymFCC/a5L688C3+LVRwNDyaauHa8RybAxbd2lPFwDLteszyGkft9abK5pHVm7hq0kFC1Rpah274JEilm7lKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737044018; c=relaxed/simple;
	bh=YTfVF+G9qXcD88zA4v+05XFx3vzf2b4f8ztuVqDlTB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjQNp/WCVtZ/9RWpEpdy4eR/w3rKHB9SHskuI1m9w/wU9DYnthU6Y8OzHGuhVQjsYKT6UWODDaokkcvS8rPW/zpp8hvDgTNqE6M10/6h8jtb/7ezqQHwwkv/mxBxvd/PlbNojGgdXMwaPNd6vo9AP81XvmP5Xh67sBmvLCYq0h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KEtb+6TK; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737044017; x=1768580017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YTfVF+G9qXcD88zA4v+05XFx3vzf2b4f8ztuVqDlTB8=;
  b=KEtb+6TKDorroOXRdBDc/iTSurhlHzcpSBLaXowgLXY7Y94n+cDrOMas
   WqdolY/lhx+kWhg4TahLtzTSo5CO296tmzo92sXM9g9TvpxUcpNHr3iVt
   eEcbJCJV47nChwckYLrqPN9FRB4d19x/mTXh8S1LEmMm8QPkX50s5yX0E
   2lD8tUucocEVvR1rmvJqLare7MG1oMfqsl+cdBtmIBh27cvgDep0FRREr
   dyBP6N7rc1h+Wrdjywqjpu93J56976m2ss8BQ7gCJohWa3oNJel3X2ris
   ObmkpMpy7YMofjJuDSgXM9c3fCMPKW8tCTVBYLvICEzi/odzFog9fyD/M
   A==;
X-CSE-ConnectionGUID: oZH5EnyDRvaSs7Lv/AhNEg==
X-CSE-MsgGUID: 6Au54n3NRgG/I9FyAMspSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="48443108"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="48443108"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 08:13:36 -0800
X-CSE-ConnectionGUID: JAtNw0QsRYGwnkRSaJIEDA==
X-CSE-MsgGUID: fziWSYPCRwWClbNcbHKxkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="106075339"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 08:13:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tYSUt-00000001jLm-1BRB;
	Thu, 16 Jan 2025 18:13:31 +0200
Date: Thu, 16 Jan 2025 18:13:31 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 1/1] PM: Revert "Add EXPORT macros for exporting PM
 functions"
Message-ID: <Z4kwK6JCm5RDI4nG@smile.fi.intel.com>
References: <20250116154354.149297-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0izBnSGjmjO7T+_gEhrSib0==_bRXnsLEdzEjbH0cZDqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0izBnSGjmjO7T+_gEhrSib0==_bRXnsLEdzEjbH0cZDqg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jan 16, 2025 at 05:09:29PM +0100, Rafael J. Wysocki wrote:
> On Thu, Jan 16, 2025 at 4:44 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > The introduced macros are not doing what they intend for, namely
> > they won't eliminate the code when CONFIG_PM=n.
> 
> I don't think they have ever been expected to eliminate the code then.
> They just don't export the symbols in that case.

Then I'm really puzzled with (potential) usefulness of them to begin with.
Having a dead code that is not exported is doubtful benefit.

> > Also there were no users of them for all this time.
> 
> This actually is a good argument for dropping stuff.
> 
> > Drop them for good and to avoid possible misleading.

-- 
With Best Regards,
Andy Shevchenko



