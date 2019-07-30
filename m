Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 560677A90E
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 14:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfG3M5t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 08:57:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:45000 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbfG3M5t (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 30 Jul 2019 08:57:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 05:57:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,326,1559545200"; 
   d="scan'208";a="183122529"
Received: from chingkai-mobl.amr.corp.intel.com (HELO [10.252.137.193]) ([10.252.137.193])
  by orsmga002.jf.intel.com with ESMTP; 30 Jul 2019 05:57:47 -0700
Subject: Re: [alsa-devel] [RFC PATCH 17/40] soundwire: bus: use
 runtime_pm_get_sync/pm when enabled
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-pm@vger.kernel.org,
        tiwai@suse.de, gregkh@linuxfoundation.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-18-pierre-louis.bossart@linux.intel.com>
 <45a912c5-134b-8642-70ef-8c1060389300@linux.intel.com>
 <20190726190823.GD9224@smile.fi.intel.com>
 <5a16d9e6-0a9c-a0a8-3b11-d046247f3879@linux.intel.com>
 <20190730112157.GM23480@smile.fi.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a1b383b3-7846-3545-38a5-beece3e52849@linux.intel.com>
Date:   Tue, 30 Jul 2019 07:57:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730112157.GM23480@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/30/19 6:21 AM, Andy Shevchenko wrote:
> On Mon, Jul 29, 2019 at 05:07:39PM -0500, Pierre-Louis Bossart wrote:
>> On 7/26/19 2:08 PM, Andy Shevchenko wrote:
>>> On Fri, Jul 26, 2019 at 01:08:57PM -0500, Pierre-Louis Bossart wrote:
> 
>>>> -	if (ret < 0)
>>>> +	if (ret < 0 && ret != -EACCES)
>>>
>>> ...and here, the pm_runtime_put_noidle() call is missed.
>>
>> yes but in the example you provided, they actually do more work than just
>> decrement the device usage counter:
> 
> In their case they would like to do that. You decide what is appropriate call
> in your case.
> 
> My point is, that reference counter in case of error handling should be
> returned back to its value.

Agree on the reference count.
I am however not clear on the next step and 'what is appropriate'.

If pm_runtime_get_sync() failed, then technically the device was not 
resumed so marking it as last_busy+autosuspend, or using a plain vanilla 
put() will not result in any action. I must be missing something here.
