Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 547827AD15
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 17:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732737AbfG3P7b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 11:59:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:15780 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfG3P7a (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 30 Jul 2019 11:59:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 08:59:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,327,1559545200"; 
   d="scan'208";a="371583569"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jul 2019 08:59:27 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hsUX7-0005G1-3H; Tue, 30 Jul 2019 18:59:25 +0300
Date:   Tue, 30 Jul 2019 18:59:25 +0300
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
Message-ID: <20190730155925.GT23480@smile.fi.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-18-pierre-louis.bossart@linux.intel.com>
 <45a912c5-134b-8642-70ef-8c1060389300@linux.intel.com>
 <20190726190823.GD9224@smile.fi.intel.com>
 <5a16d9e6-0a9c-a0a8-3b11-d046247f3879@linux.intel.com>
 <20190730112157.GM23480@smile.fi.intel.com>
 <a1b383b3-7846-3545-38a5-beece3e52849@linux.intel.com>
 <20190730155809.GS23480@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730155809.GS23480@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 30, 2019 at 06:58:09PM +0300, Andy Shevchenko wrote:
> On Tue, Jul 30, 2019 at 07:57:46AM -0500, Pierre-Louis Bossart wrote:
> > On 7/30/19 6:21 AM, Andy Shevchenko wrote:
> > > On Mon, Jul 29, 2019 at 05:07:39PM -0500, Pierre-Louis Bossart wrote:
> > > > On 7/26/19 2:08 PM, Andy Shevchenko wrote:

> > so marking it as last_busy+autosuspend, or using a plain vanilla put() will
> > not result in any action. I must be missing something here.
> 
> put_noidle(). Because if it failed on the first call and was resumed, put()
> will try to shut it down (since reference count goes to no-user base).

Sorry, this has to be read as (was -> wasn't)

> put_noidle(). Because if it failed on the first call and wasn't resumed, put()
> will try to shut it down (since reference count goes to no-user base).

-- 
With Best Regards,
Andy Shevchenko


