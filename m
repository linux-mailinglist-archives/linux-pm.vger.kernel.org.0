Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 990157AD0A
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 17:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfG3P6Q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 11:58:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:55522 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728759AbfG3P6Q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 30 Jul 2019 11:58:16 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 08:58:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,327,1559545200"; 
   d="scan'208";a="255645883"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga001.jf.intel.com with ESMTP; 30 Jul 2019 08:58:11 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hsUVt-0005F7-JJ; Tue, 30 Jul 2019 18:58:09 +0300
Date:   Tue, 30 Jul 2019 18:58:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-pm@vger.kernel.org,
        tiwai@suse.de, gregkh@linuxfoundation.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 17/40] soundwire: bus: use
 runtime_pm_get_sync/pm when enabled
Message-ID: <20190730155809.GS23480@smile.fi.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-18-pierre-louis.bossart@linux.intel.com>
 <45a912c5-134b-8642-70ef-8c1060389300@linux.intel.com>
 <20190726190823.GD9224@smile.fi.intel.com>
 <5a16d9e6-0a9c-a0a8-3b11-d046247f3879@linux.intel.com>
 <20190730112157.GM23480@smile.fi.intel.com>
 <a1b383b3-7846-3545-38a5-beece3e52849@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1b383b3-7846-3545-38a5-beece3e52849@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 30, 2019 at 07:57:46AM -0500, Pierre-Louis Bossart wrote:
> On 7/30/19 6:21 AM, Andy Shevchenko wrote:
> > On Mon, Jul 29, 2019 at 05:07:39PM -0500, Pierre-Louis Bossart wrote:
> > > On 7/26/19 2:08 PM, Andy Shevchenko wrote:
> > > > On Fri, Jul 26, 2019 at 01:08:57PM -0500, Pierre-Louis Bossart wrote:
> > 
> > > > > -	if (ret < 0)
> > > > > +	if (ret < 0 && ret != -EACCES)
> > > > 
> > > > ...and here, the pm_runtime_put_noidle() call is missed.
> > > 
> > > yes but in the example you provided, they actually do more work than just
> > > decrement the device usage counter:
> > 
> > In their case they would like to do that. You decide what is appropriate call
> > in your case.
> > 
> > My point is, that reference counter in case of error handling should be
> > returned back to its value.
> 
> Agree on the reference count.
> I am however not clear on the next step and 'what is appropriate'.
> 
> If pm_runtime_get_sync() failed, then technically the device was not resumed

Not so straight. It depends on reference count. It might be true (most cases
I think), or not true, if device had been resumed previously by other call.

> so marking it as last_busy+autosuspend, or using a plain vanilla put() will
> not result in any action. I must be missing something here.

put_noidle(). Because if it failed on the first call and was resumed, put()
will try to shut it down (since reference count goes to no-user base).

-- 
With Best Regards,
Andy Shevchenko


