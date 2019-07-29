Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 895AF79CE4
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 01:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbfG2Xhz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 19:37:55 -0400
Received: from mga14.intel.com ([192.55.52.115]:18711 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727533AbfG2Xhy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Jul 2019 19:37:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jul 2019 16:37:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,324,1559545200"; 
   d="scan'208";a="165650561"
Received: from ahanamuk-mobl.amr.corp.intel.com (HELO [10.251.134.69]) ([10.251.134.69])
  by orsmga008.jf.intel.com with ESMTP; 29 Jul 2019 16:37:51 -0700
Subject: Re: [alsa-devel] [RFC PATCH 17/40] soundwire: bus: use
 runtime_pm_get_sync/pm when enabled
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     alsa-devel@alsa-project.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-18-pierre-louis.bossart@linux.intel.com>
 <45a912c5-134b-8642-70ef-8c1060389300@linux.intel.com>
 <20190726190823.GD9224@smile.fi.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <5a16d9e6-0a9c-a0a8-3b11-d046247f3879@linux.intel.com>
Date:   Mon, 29 Jul 2019 17:07:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726190823.GD9224@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/26/19 2:08 PM, Andy Shevchenko wrote:
> On Fri, Jul 26, 2019 at 01:08:57PM -0500, Pierre-Louis Bossart wrote:
>> This thread became unreadable with interleaved top-posting, allow me restate
>> the options and ask PM folks what they think
>>
>> On 7/25/19 6:40 PM, Pierre-Louis Bossart wrote:
>>> Not all platforms support runtime_pm for now, let's use runtime_pm
>>> only when enabled.
> 
> Just a side note below...
> 
>>> -	ret = pm_runtime_get_sync(slave->bus->dev);
>>> -	if (ret < 0)
> 
> Here...
> 
>>> -		return ret;
>>> +	if (pm_runtime_enabled(slave->bus->dev)) {
>>> +		ret = pm_runtime_get_sync(slave->bus->dev);
>>> +		if (ret < 0)
> 
> ...and thus here...
> 
>>> +			return ret;
>>> +	}
>>>    	ret = sdw_transfer(slave->bus, &msg);
>>> -	pm_runtime_put(slave->bus->dev);
>>> +
>>> +	if (pm_runtime_enabled(slave->bus->dev))
>>> +		pm_runtime_put(slave->bus->dev);
>>
>> This is option1: we explicitly test if pm_runtime is enabled before calling
>> _get_sync() and _put()
>>
>> option2 (suggested by Jan Kotas): catch the -EACCESS error code
>>
>>   	ret = pm_runtime_get_sync(slave->bus->dev);
>> -	if (ret < 0)
>> +	if (ret < 0 && ret != -EACCES)
> 
> ...and here, the pm_runtime_put_noidle() call is missed.

yes but in the example you provided, they actually do more work than 
just decrement the device usage counter:

static int
radeonfb_open(struct fb_info *info, int user)
{
	struct radeon_fbdev *rfbdev = info->par;
	struct radeon_device *rdev = rfbdev->rdev;
	int ret = pm_runtime_get_sync(rdev->ddev->dev);
	if (ret < 0 && ret != -EACCES) {
		pm_runtime_mark_last_busy(rdev->ddev->dev);
		pm_runtime_put_autosuspend(rdev->ddev->dev);
		return ret;
	}
	return 0;
}

unless I am missing something pm_runtime_put_noidle() and 
_put_autosuspend() are not equivalent, are they?
