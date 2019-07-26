Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD67771E8
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2019 21:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfGZTLP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jul 2019 15:11:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:4356 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbfGZTLP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Jul 2019 15:11:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 12:11:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="181963387"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga002.jf.intel.com with ESMTP; 26 Jul 2019 12:11:10 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hr5cS-0006eY-Of; Fri, 26 Jul 2019 22:11:08 +0300
Date:   Fri, 26 Jul 2019 22:11:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 17/40] soundwire: bus: use
 runtime_pm_get_sync/pm when enabled
Message-ID: <20190726191108.GE9224@smile.fi.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-18-pierre-louis.bossart@linux.intel.com>
 <45a912c5-134b-8642-70ef-8c1060389300@linux.intel.com>
 <20190726182534.GO16003@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726182534.GO16003@ubuntu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 26, 2019 at 08:25:35PM +0200, Guennadi Liakhovetski wrote:
> On Fri, Jul 26, 2019 at 01:08:57PM -0500, Pierre-Louis Bossart wrote:
> > On 7/25/19 6:40 PM, Pierre-Louis Bossart wrote:
> > > Not all platforms support runtime_pm for now, let's use runtime_pm
> > > only when enabled.

> > option2 (suggested by Jan Kotas): catch the -EACCESS error code
> > 
> >  	ret = pm_runtime_get_sync(slave->bus->dev);
> > -	if (ret < 0)
> > +	if (ret < 0 && ret != -EACCES)
> >  		return ret;

> Otherwise I'd go with (2), I think, since
> that's also the official purpose of the -EACCESS return code:
> 
> https://lists.linuxfoundation.org/pipermail/linux-pm/2011-June/031930.html

And at least we have examples in the kernel

drivers/gpu/drm/radeon/radeon_fb.c:57:  if (ret < 0 && ret != -EACCES) {

-- 
With Best Regards,
Andy Shevchenko


