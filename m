Return-Path: <linux-pm+bounces-25204-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC4EA8542D
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 08:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104A619E02DC
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 06:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B85A27CB25;
	Fri, 11 Apr 2025 06:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I2TEmSxO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BB71EDA05
	for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2025 06:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744353202; cv=none; b=iWgCnz7LWOuE1STO16ZLcGGXPBGM6CZc1A/xWo/dDWA2uRVa9md+uYscgIFPN6Kf1MiDrx6v2CSdS99hi6J7czppxdNqhk1g4lVsNNsA1Fk1uOQXiPHu0oML6V9ItbvVqhfdGIUtcvpz7kbeerbonVHIFsnINFD5kOkOWtgMXKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744353202; c=relaxed/simple;
	bh=ZDFmo6XWdgunS+Hy0itINfL6+cj9NZhgqxVmy4gEGTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkE4NcktMNgQWSHqRasEgIZun5A0JowK24Gu67jpDQOt8yJKIqcj6obApwbHxjDXH3QUeNdFbyi0tnRjOSmVUB1u4DXNJIxfMVyeIiL1xOjo1zJB16n0AbNYJeO2UY8ERM0Q/xF18hrxw5lqY5PfNS1p4VlQ13aqEg6B9YC5qeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I2TEmSxO; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744353201; x=1775889201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZDFmo6XWdgunS+Hy0itINfL6+cj9NZhgqxVmy4gEGTE=;
  b=I2TEmSxOrp+SanJCyT0W3S4jW3BK0qM7Y/z94tw0wXh0BCXi6owWDL1G
   vja8fUwXzu6sKCmqqyjfFh0OQTgI+9qlsT/rwaYJ7TRwLkMi4IeXO/HZj
   iv8aM1q/9G6xDSA6cFFUBop0UA4flYf07bjdbc7hlLfiKfbGlFKMoCc3S
   MOTVamKJn4uapdaO66hlOLNmgdvesvaP3bwDWUmU1GFgVlRqWSLEn1L6/
   QXDTASLKJJvTOmyCpL0HV0H1MsggYPI3B1I9dalaPtp0uqz+21pG9096J
   gvIE5biAuf9W870enqgrjrIxzv9P4cMdL24MsDI10nXSz+HfyyBneGUnF
   Q==;
X-CSE-ConnectionGUID: XLCZkjRdR5KFJEH+60+FuQ==
X-CSE-MsgGUID: yLIgqTs5Qh2+LaqwIpNvvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="71283284"
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="71283284"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 23:33:19 -0700
X-CSE-ConnectionGUID: aKi5RjHYQqipVg/FaTpZNA==
X-CSE-MsgGUID: 9QYHkerDTqqhs/ddj/QmkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,203,1739865600"; 
   d="scan'208";a="133974879"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 23:33:17 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id DCA9111F7EE;
	Fri, 11 Apr 2025 09:33:14 +0300 (EEST)
Date: Fri, 11 Apr 2025 06:33:14 +0000
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>
Subject: Re: [PATCH 3/7] pm: runtime: Mark last busy stamp in
 pm_runtime_put_autosuspend()
Message-ID: <Z_i3qlyaxA9bm2BW@kekkonen.localdomain>
References: <20250410153106.4146265-1-sakari.ailus@linux.intel.com>
 <20250410153106.4146265-4-sakari.ailus@linux.intel.com>
 <20250410201711.GB29836@pendragon.ideasonboard.com>
 <Z_i2Og7PT8O6P-Y0@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_i2Og7PT8O6P-Y0@kekkonen.localdomain>

On Fri, Apr 11, 2025 at 06:27:06AM +0000, Sakari Ailus wrote:
> > s/ and decrement/, decrement/
> 
> Ack. I'll address this in v2, but wait for other comments still awhile.

The paragraph now looks like:

 * Update the last access time of @dev, decrement runtime PM usage counter of
 * @dev and if it turns out to be equal to 0, queue up a work item for @dev like
 * in pm_request_autosuspend().

I.e. runtime PM usage counter of @dev is decremented, not the usage counter
of the last access time.

-- 
Sakari Ailus

