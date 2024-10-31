Return-Path: <linux-pm+bounces-16801-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E9D9B750C
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 08:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB706B24D2D
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2024 07:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26081487D1;
	Thu, 31 Oct 2024 07:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DAGeQ4hS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE391487E5;
	Thu, 31 Oct 2024 07:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730358454; cv=none; b=QndNXy0835HtE0vyJkT1d65GpIV0omkakUEv/8nt/C+eLVxs3IDSwCTpad8gpuFHv52pNfdjdtefktiHXD2vZoIqRWz8fEzkcOSJ0pth1Hzktzba4Q+fzLK6CZ/8dqG5Yk56e0RhqMFmpwOrpQWBXdxqXn5KMxjuExpzps5AuYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730358454; c=relaxed/simple;
	bh=cVb6lHhTocSAbTwN2Yn8J5X2Ab/FN0hVW8k6lizXiZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOyT4IxDsuVMag5dl5RkYn0Lmebnj9UU9D9AV1NnMj5/5KKzDIoMtKOA0B8YM9jrVyfQCSO9aE/BOsH6QugXy/58e11ObXmJygPkX9aR/GO35TsVhMbmD+OKS8qNYSWfNlk2kxFzx2QEUwrIK8EXXbDgKzC1A3TYWT1BRKhe2W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DAGeQ4hS; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730358453; x=1761894453;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cVb6lHhTocSAbTwN2Yn8J5X2Ab/FN0hVW8k6lizXiZw=;
  b=DAGeQ4hS3IzK5LhsyJ5p0LrzZM78++sm329sj2jcixc0+q4M+vcqj+2y
   6l44B4K7IBBvedErB2Vr7aCMS+cHVjbmi8s7qi7fieBIv/lKXTGKkF+ts
   SK7DjyzoDxMQDvR0FI77Adv/0+9gkThckkelU7/UFSLs7MmAMN9CF4ovM
   WxQkyJ9rJS1hij5SSohLEO+QSq6iaI6XPWG5dvAcAADjVD5NYBarzCNu5
   neK9u9IMB7gMFmAoWyN0PTx6YvUJ0KYwCylQhy+pivE7Q9AIIHGBTOcS5
   H5HxChSoNtpK8uPbNcw41iYAVaAzissfOAEGkWQaALuR92BkbcO2mmqYl
   A==;
X-CSE-ConnectionGUID: 3PeBe0UKTYasQOoAtwtUAQ==
X-CSE-MsgGUID: llpYUJQsSi6pSIUkfpQ+ZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="47558492"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="47558492"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 00:07:32 -0700
X-CSE-ConnectionGUID: CbGEroigStKku2couUKRjA==
X-CSE-MsgGUID: TAJg7JVvRcKGaMI/L3UUwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82194911"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 00:07:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t6PHD-00000009KN3-3pNm;
	Thu, 31 Oct 2024 09:07:27 +0200
Date: Thu, 31 Oct 2024 09:07:27 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, loongarch@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	WANG Xuerui <kernel@xen0n.name>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/1] cpufreq: loongson: Check for error code from
 devm_mutex_init() call
Message-ID: <ZyMsr0JrXne-h4r8@smile.fi.intel.com>
References: <20241030162930.2111255-1-andriy.shevchenko@linux.intel.com>
 <CAAhV-H6bOZLur8Eq2CyFaeQp7R1LwiRqf0ODqnftg6+zAbDoYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H6bOZLur8Eq2CyFaeQp7R1LwiRqf0ODqnftg6+zAbDoYg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 31, 2024 at 09:29:52AM +0800, Huacai Chen wrote:
> On Thu, Oct 31, 2024 at 12:29 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> > -       for (i = 0; i < MAX_PACKAGES; i++)
> > -               devm_mutex_init(&pdev->dev, &cpufreq_mutex[i]);
> > +       for (i = 0; i < MAX_PACKAGES; i++) {
> > +               ret = devm_mutex_init(&pdev->dev, &cpufreq_mutex[i]);
> > +               if (ret)
> Good catch, but I think "if (ret < 0)" is better? Sometimes a positive
> return value is legal, even if not in this case.

I disagree on this.

During a tons of reviews I have done in the past this kind of check is
impediment and always rises the Q "why?" It means that the author hasn't
fully thought through the code and most likely done something is a cargo cult.
On top of that, if the callee is changed at some point to actually return
a positive code(s), the caller most likely has to be at least aware of that
change. The proposed modification makes this silently compile and hides
possible important details from the caller(s).

> And it is better to use loongson3 rather than loongson because there
>  is another loongson2 driver.

Thanks, I will change that in v2 (I believe you are talking about Subject?).

> > +                       return ret;
> > +       }

-- 
With Best Regards,
Andy Shevchenko



