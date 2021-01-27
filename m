Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2131E305804
	for <lists+linux-pm@lfdr.de>; Wed, 27 Jan 2021 11:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbhA0KO5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 05:14:57 -0500
Received: from foss.arm.com ([217.140.110.172]:36810 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235688AbhA0KMv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 Jan 2021 05:12:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8657A31B;
        Wed, 27 Jan 2021 02:11:56 -0800 (PST)
Received: from [10.57.4.29] (unknown [10.57.4.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA1D23F66B;
        Wed, 27 Jan 2021 02:11:52 -0800 (PST)
Subject: Re: [RFC][PATCH 0/3] New thermal interface allowing IPA to get max
 power
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com, amitk@kernel.org, rui.zhang@intel.com,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
References: <20210126104001.20361-1-lukasz.luba@arm.com>
 <20210127091540.xesvwoeavyaf37jn@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <9aecd2cd-771e-58b8-6672-f133600b70b5@arm.com>
Date:   Wed, 27 Jan 2021 10:11:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210127091540.xesvwoeavyaf37jn@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 1/27/21 9:15 AM, Viresh Kumar wrote:
> On 26-01-21, 10:39, Lukasz Luba wrote:
>> As it's a RFC, it still misses the cpufreq sysfs implementation, but would
>> be addressed if all agree.
> 
> Not commenting on the whole stuff but if you ever need something for cpufreq, it
> is already there. Look for these.
> 
> store_one(scaling_min_freq, min);
> store_one(scaling_max_freq, max);
> 
> Hopefully they will work just fine.
> 

So, can I assume you don't mind to plumb it into these two?

Yes, I know them and the tricky macro. I just wanted to avoid
one patch for this macro and one patch for cpufreq_cooling.c,
which would use it.

If you agree and Chanwoo agrees for the devfreq, and Daniel
for the new callback in cooling device, then I would continue
by adding missing patches for cpufreq-cooling part.

Regards,
Lukasz

