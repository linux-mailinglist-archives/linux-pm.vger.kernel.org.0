Return-Path: <linux-pm+bounces-35462-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D71BA39A8
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 14:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFA5D1C02A41
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 12:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B092ED87F;
	Fri, 26 Sep 2025 12:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H+fIFiTw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08932F28ED;
	Fri, 26 Sep 2025 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758889561; cv=none; b=F0+vfk/V5uiu4pxFkXvRjHXpRvqcRl8gdbFNc2SrMNzn3RaAPTPPPtPVpoNkZfS01/cuWq+TH0ihqyiK658WoVTWO+/5lkeccIVgl9OmZLRvf4VRQekO7XiYJRwA66Du4rGIa/RDmJz5igS95HrFRaEr0/VwkA1FaadyRKaIjLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758889561; c=relaxed/simple;
	bh=z235u+o2xilU5adSL6DP7M5msiAkBYTnQhWC4wN24tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Somx3aKYInzXvUJnx+1ALQfNs0vIH94jd2ERjM5+SurzHkrphjgkc/7H64+4dsdp+1WzXGrp2736K2bCtbz5+OsIzaJK307czvNw+LWaYQaY0Is/t4UnFiVTPtlzVrNmDr3dAcLqCcJxvGO9ml3kVNOXHFitUmyISM9QIw892vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H+fIFiTw; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758889560; x=1790425560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z235u+o2xilU5adSL6DP7M5msiAkBYTnQhWC4wN24tQ=;
  b=H+fIFiTwns90HgD4U+bdB2yp21EePNRURNjvq4JN795fK9c9YDY7V9eQ
   P35SbjU8mdBfMbSAmxXLCcMAfW1HbQI98J5djLc7NafXoVnTDRRL1pbH0
   dKmHTVbC162aYJkWwzrKK4HgxNmxGq8dP1pZRpXByx7Cs+QVYQe1H9n38
   p6XQJhlJThYtzgZFRXrgFCCeQCYSEShuDsb45BKzrdhBCtNE8PGKfJyd0
   vXb5bOrYpwcZZyZ0AQW7lThMKPMMcIQtz+v2SC15+Q1QCjiVAHoL9MyH0
   yrTqDgTQKZnCVSeNHd1SmizGFr03EO453AdO93sClUp5t0ut0O+lwGYmk
   Q==;
X-CSE-ConnectionGUID: joqwHbp+TrmxMuXvSI/hTg==
X-CSE-MsgGUID: yt3Z4kVVRCGXtwZdy1aV3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="60921631"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="60921631"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 05:26:00 -0700
X-CSE-ConnectionGUID: jhL0ppPmSwuMPh5X68sQ0w==
X-CSE-MsgGUID: UvHJEqvERsOPa0JqZHJdbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="181908661"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.33])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 05:25:57 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 846AD1202BC;
	Fri, 26 Sep 2025 15:25:54 +0300 (EEST)
Date: Fri, 26 Sep 2025 15:25:54 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] PM: runtime: Update kerneldoc return codes
Message-ID: <aNaGUmOUfVsKazGr@kekkonen.localdomain>
References: <20250925124216.v2.1.I443d97ccd1c67f32670eb93784ad735b11816743@changeid>
 <20250925124216.v2.3.I65666ec0d246c22ed4da78a395121b4581460ca6@changeid>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925124216.v2.3.I65666ec0d246c22ed4da78a395121b4581460ca6@changeid>

On Thu, Sep 25, 2025 at 12:42:16PM -0700, Brian Norris wrote:
> APIs based on __pm_runtime_idle() (pm_runtime_idle(), pm_request_idle())
> do not return 1 when already suspended. They return -EAGAIN. This is
> already covered in the docs, so the entry for "1" is redundant and
> conflicting.
> 
> (pm_runtime_put() and pm_runtime_put_sync() were previously incorrect,
> but that's fixed in "PM: runtime: pm_runtime_put{,_sync}() returns 1
> when already suspended", to ensure consistency with APIs like
> pm_runtime_put_autosuspend().)
> 
> RPM_GET_PUT APIs based on __pm_runtime_suspend() do return 1 when
> already suspended, but the language is a little unclear -- it's not
> really an "error", so it seems better to list as a clarification before
> the 0/success case. Additionally, they only actually return 1 when the
> refcount makes it to 0; if the usage counter is still non-zero, we
> return 0.
> 
> pm_runtime_put(), etc., also don't appear at first like they can ever
> see "-EAGAIN: Runtime PM usage_count non-zero", because in non-racy
> conditions, pm_runtime_put() would drop its reference count, see it's
> non-zero, and return early (in __pm_runtime_idle()). However, it's
> possible to race with another actor that increments the usage_count
> afterward, since rpm_idle() is protected by a separate lock; in such a
> case, we may see -EAGAIN.
> 
> Because this case is only seen in the presence of concurrent actors, it
> makes sense to clarify that this is when "usage_count **became**
> non-zero", by way of some racing actor.
> 
> Lastly, pm_runtime_put_sync_suspend() duplicated some -EAGAIN language.
> Fix that.
> 
> Fixes: 271ff96d6066 ("PM: runtime: Document return values of suspend-related API functions")
> Link: https://lore.kernel.org/linux-pm/aJ5pkEJuixTaybV4@google.com/
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

