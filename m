Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8560F771D8
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2019 21:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfGZTI3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jul 2019 15:08:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:47167 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbfGZTI3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Jul 2019 15:08:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 12:08:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="181962931"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga002.jf.intel.com with ESMTP; 26 Jul 2019 12:08:25 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hr5Zn-0006dE-Bx; Fri, 26 Jul 2019 22:08:23 +0300
Date:   Fri, 26 Jul 2019 22:08:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH 17/40] soundwire: bus: use runtime_pm_get_sync/pm
 when enabled
Message-ID: <20190726190823.GD9224@smile.fi.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-18-pierre-louis.bossart@linux.intel.com>
 <45a912c5-134b-8642-70ef-8c1060389300@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45a912c5-134b-8642-70ef-8c1060389300@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 26, 2019 at 01:08:57PM -0500, Pierre-Louis Bossart wrote:
> This thread became unreadable with interleaved top-posting, allow me restate
> the options and ask PM folks what they think
> 
> On 7/25/19 6:40 PM, Pierre-Louis Bossart wrote:
> > Not all platforms support runtime_pm for now, let's use runtime_pm
> > only when enabled.

Just a side note below...

> > -	ret = pm_runtime_get_sync(slave->bus->dev);
> > -	if (ret < 0)

Here...

> > -		return ret;
> > +	if (pm_runtime_enabled(slave->bus->dev)) {
> > +		ret = pm_runtime_get_sync(slave->bus->dev);
> > +		if (ret < 0)

...and thus here...

> > +			return ret;
> > +	}
> >   	ret = sdw_transfer(slave->bus, &msg);
> > -	pm_runtime_put(slave->bus->dev);
> > +
> > +	if (pm_runtime_enabled(slave->bus->dev))
> > +		pm_runtime_put(slave->bus->dev);
> 
> This is option1: we explicitly test if pm_runtime is enabled before calling
> _get_sync() and _put()
> 
> option2 (suggested by Jan Kotas): catch the -EACCESS error code
> 
>  	ret = pm_runtime_get_sync(slave->bus->dev);
> -	if (ret < 0)
> +	if (ret < 0 && ret != -EACCES)

...and here, the pm_runtime_put_noidle() call is missed.

>  		return ret;
> 
> option3: ignore the return value as done in quite a few drivers
> 
> Are there any other options? I am personally surprised this is not handled
> in the pm_runtime core, not sure why users need to test for this?

-- 
With Best Regards,
Andy Shevchenko


