Return-Path: <linux-pm+bounces-33607-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6295B3F66C
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 09:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B656C162773
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 07:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDA52874FE;
	Tue,  2 Sep 2025 07:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z3Rro0Jh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F59C3398A;
	Tue,  2 Sep 2025 07:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756797493; cv=none; b=DP2LCDz7nLKWN75YVnJBEr+uiobUrVTC+YkQ1cVGqSleLjVlkY+QXruQUVhsaDY9MplYMdNv72ziBXL8LHR6sJZ/WbqIQXWTDRz8+5l0wQGr49/zq1aTUYUFvrCTj071w3TRGwvvsdWeJUksDe4HczhNpJ7wlj3tqxpLNsFe2c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756797493; c=relaxed/simple;
	bh=0Rdl5axL8MQAF+i4yLlc9kbFCgyQpRHFJ/Nq8lJFGRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DC1j+UMhYYid/K73i+eD8w5nJQQvoU91FHRrDRXJAO4yv9kxChDy/o0Mk94Sc6qGhe6CuVxQjRSiPc7vxVnUXJRVjtzmmG/ADwIncYtVhqOM2TCqshKQfdyrhBkroieL/nf0H5GuvoaJkLxoj6zKW6uajcbhygdhOqS9sUdZrfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z3Rro0Jh; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756797491; x=1788333491;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Rdl5axL8MQAF+i4yLlc9kbFCgyQpRHFJ/Nq8lJFGRw=;
  b=Z3Rro0JhWe46MRj2cZzQXAtAmJrUIfAHVnNxLjtBdK4nXkT8vB27l1aT
   HS3zarDyR2a0kgz7he+t+z9DZQIFbsWlPCYnGdtC/pDn9H00nfQX30wh+
   81zKRbNGAIT3+Le/Dv4yiPFfjzk5IOubsMlennGCQX5n/Adb3LQvlICGF
   KZxVGVKc57kyIxNs2ZHkN/6DE58dZZCFuXyHTMDFTYuZ4PIj0kWN5OhqC
   b9r0q6hl9729vSCqk/dF6zqpETSmrzlkSPt9PVMqrearC4d4je4fLRCUL
   Sh0fwxZdgNH422tLMZYcb+h3p8bCnjgqlEtbE0dK1yh6mlP8je5LjP0Dn
   A==;
X-CSE-ConnectionGUID: fpJPCZ7wQ5K/1iT5xJp7cg==
X-CSE-MsgGUID: nwJfN1ziTqSfsA0Wkx9m1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58974649"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58974649"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 00:18:10 -0700
X-CSE-ConnectionGUID: pZbsXOJoQJG3ZyPcvg4vjA==
X-CSE-MsgGUID: StixuDxBSlaCzViffTVqvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="176467428"
Received: from agladkov-desk.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.32])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 00:18:08 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 5FC2A121F49;
	Tue, 02 Sep 2025 10:18:05 +0300 (EEST)
Date: Tue, 2 Sep 2025 10:18:05 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	kunit-dev@googlegroups.com, Len Brown <lenb@kernel.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] PM: runtime: Update kerneldoc return codes
Message-ID: <aLaaLc0TPhtm-H5j@kekkonen.localdomain>
References: <20250829003319.2785282-1-briannorris@chromium.org>
 <20250829003319.2785282-3-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829003319.2785282-3-briannorris@chromium.org>

Hi Brian,

Thanks for posting this. A few comments below.

On Thu, Aug 28, 2025 at 05:28:28PM -0700, Brian Norris wrote:
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
> refcount makes it to 0; if the usage_count is still non-zero, we return
> 0.
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
> ---
> 
>  include/linux/pm_runtime.h | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index d88d6b6ccf5b..fd17ffe1bc79 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -356,7 +356,6 @@ static inline int pm_runtime_force_resume(struct device *dev) { return -ENXIO; }
>   * * -EPERM: Device PM QoS resume latency 0.
>   * * -EINPROGRESS: Suspend already in progress.
>   * * -ENOSYS: CONFIG_PM not enabled.
> - * * 1: Device already suspended.
>   * Other values and conditions for the above values are possible as returned by
>   * Runtime PM idle and suspend callbacks.
>   */
> @@ -439,7 +438,6 @@ static inline int pm_runtime_resume(struct device *dev)
>   * * -EPERM: Device PM QoS resume latency 0.
>   * * -EINPROGRESS: Suspend already in progress.
>   * * -ENOSYS: CONFIG_PM not enabled.
> - * * 1: Device already suspended.
>   */
>  static inline int pm_request_idle(struct device *dev)
>  {
> @@ -540,15 +538,16 @@ static inline int pm_runtime_resume_and_get(struct device *dev)
>   * equal to 0, queue up a work item for @dev like in pm_request_idle().
>   *
>   * Return:
> + * * 1: Usage counts dropped to zero, but device was already suspended.

Does this actually happen? pm_runtime_put() calls __pm_runtime_idle() that
doesn't appear to return 1 in any case.

>   * * 0: Success.
>   * * -EINVAL: Runtime PM error.
>   * * -EACCES: Runtime PM disabled.
> - * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
> + * * -EAGAIN: Runtime PM usage_count became non-zero or Runtime PM status
> + *            change ongoing.
>   * * -EBUSY: Runtime PM child_count non-zero.
>   * * -EPERM: Device PM QoS resume latency 0.
>   * * -EINPROGRESS: Suspend already in progress.
>   * * -ENOSYS: CONFIG_PM not enabled.
> - * * 1: Device already suspended.
>   */
>  static inline int pm_runtime_put(struct device *dev)
>  {
> @@ -565,15 +564,16 @@ DEFINE_FREE(pm_runtime_put, struct device *, if (_T) pm_runtime_put(_T))
>   * equal to 0, queue up a work item for @dev like in pm_request_autosuspend().
>   *
>   * Return:
> + * * 1: Usage counts dropped to zero, but device was already suspended.
>   * * 0: Success.

"usage_count" and "usage counter" is being used in kernel-doc already, I'd
use either of the two. "usage_count" refers directly to the field in struct
dev_pm_info (and is used a few lines below). Same elsewhere.

>   * * -EINVAL: Runtime PM error.
>   * * -EACCES: Runtime PM disabled.
> - * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
> + * * -EAGAIN: Runtime PM usage_count became non-zero or Runtime PM status
> + *            change ongoing.
>   * * -EBUSY: Runtime PM child_count non-zero.
>   * * -EPERM: Device PM QoS resume latency 0.
>   * * -EINPROGRESS: Suspend already in progress.
>   * * -ENOSYS: CONFIG_PM not enabled.
> - * * 1: Device already suspended.
>   */
>  static inline int __pm_runtime_put_autosuspend(struct device *dev)
>  {
> @@ -590,15 +590,16 @@ static inline int __pm_runtime_put_autosuspend(struct device *dev)
>   * in pm_request_autosuspend().
>   *
>   * Return:
> + * * 1: Usage counts dropped to zero, but device was already suspended.
>   * * 0: Success.
>   * * -EINVAL: Runtime PM error.
>   * * -EACCES: Runtime PM disabled.
> - * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
> + * * -EAGAIN: Runtime PM usage_count became non-zero or Runtime PM status
> + *            change ongoing.
>   * * -EBUSY: Runtime PM child_count non-zero.
>   * * -EPERM: Device PM QoS resume latency 0.
>   * * -EINPROGRESS: Suspend already in progress.
>   * * -ENOSYS: CONFIG_PM not enabled.
> - * * 1: Device already suspended.
>   */
>  static inline int pm_runtime_put_autosuspend(struct device *dev)
>  {
> @@ -619,14 +620,15 @@ static inline int pm_runtime_put_autosuspend(struct device *dev)
>   * if it returns an error code.
>   *
>   * Return:
> + * * 1: Usage counts dropped to zero, but device was already suspended.
>   * * 0: Success.

Does this happen (pm_runtime_put_sync() calls __pm_runtime_idle())?

>   * * -EINVAL: Runtime PM error.
>   * * -EACCES: Runtime PM disabled.
> - * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
> + * * -EAGAIN: Runtime PM usage_count became non-zero or Runtime PM status
> + *            change ongoing.
>   * * -EBUSY: Runtime PM child_count non-zero.
>   * * -EPERM: Device PM QoS resume latency 0.
>   * * -ENOSYS: CONFIG_PM not enabled.
> - * * 1: Device already suspended.
>   * Other values and conditions for the above values are possible as returned by
>   * Runtime PM suspend callbacks.
>   */
> @@ -646,15 +648,15 @@ static inline int pm_runtime_put_sync(struct device *dev)
>   * if it returns an error code.
>   *
>   * Return:
> + * * 1: Usage counts dropped to zero, but device was already suspended.
>   * * 0: Success.
>   * * -EINVAL: Runtime PM error.
>   * * -EACCES: Runtime PM disabled.
> - * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
> - * * -EAGAIN: usage_count non-zero or Runtime PM status change ongoing.
> + * * -EAGAIN: Runtime PM usage_count became non-zero or Runtime PM status
> + *            change ongoing.
>   * * -EBUSY: Runtime PM child_count non-zero.
>   * * -EPERM: Device PM QoS resume latency 0.
>   * * -ENOSYS: CONFIG_PM not enabled.
> - * * 1: Device already suspended.
>   * Other values and conditions for the above values are possible as returned by
>   * Runtime PM suspend callbacks.
>   */
> @@ -677,15 +679,16 @@ static inline int pm_runtime_put_sync_suspend(struct device *dev)
>   * if it returns an error code.
>   *
>   * Return:
> + * * 1: Usage counts dropped to zero, but device was already suspended.
>   * * 0: Success.
>   * * -EINVAL: Runtime PM error.
>   * * -EACCES: Runtime PM disabled.
> - * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status change ongoing.
> + * * -EAGAIN: Runtime PM usage_count became non-zero or Runtime PM status
> + *            change ongoing.
>   * * -EBUSY: Runtime PM child_count non-zero.
>   * * -EPERM: Device PM QoS resume latency 0.
>   * * -EINPROGRESS: Suspend already in progress.
>   * * -ENOSYS: CONFIG_PM not enabled.
> - * * 1: Device already suspended.
>   * Other values and conditions for the above values are possible as returned by
>   * Runtime PM suspend callbacks.
>   */

-- 
Kind regards,

Sakari Ailus

