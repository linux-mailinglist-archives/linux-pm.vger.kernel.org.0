Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73C9119F702
	for <lists+linux-pm@lfdr.de>; Mon,  6 Apr 2020 15:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgDFNfS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Apr 2020 09:35:18 -0400
Received: from foss.arm.com ([217.140.110.172]:45810 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728451AbgDFNfS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 6 Apr 2020 09:35:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEA2F7FA;
        Mon,  6 Apr 2020 06:35:17 -0700 (PDT)
Received: from [10.37.12.4] (unknown [10.37.12.4])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8230E3F52E;
        Mon,  6 Apr 2020 06:35:07 -0700 (PDT)
Subject: Re: [PATCH v5 4/5] thermal: devfreq_cooling: Refactor code and switch
 to use Energy Model
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com
Cc:     Morten.Rasmussen@arm.com, Dietmar.Eggemann@arm.com,
        javi.merino@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com,
        viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org,
        rui.zhang@intel.com, amit.kucheria@verdurent.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        qperret@google.com, bsegall@google.com, mgorman@suse.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, khilman@kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, patrick.bellasi@matbug.net,
        orjan.eide@arm.com, rdunlap@infradead.org, mka@chromium.org
References: <20200318114548.19916-1-lukasz.luba@arm.com>
 <20200318114548.19916-5-lukasz.luba@arm.com>
 <f3e9f127-47b1-9f30-2148-3c95a5933a92@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <4bf6cc66-8df4-3224-418d-0549026a3672@arm.com>
Date:   Mon, 6 Apr 2020 14:35:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f3e9f127-47b1-9f30-2148-3c95a5933a92@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/3/20 6:44 PM, Daniel Lezcano wrote:
> On 18/03/2020 12:45, Lukasz Luba wrote:
>> The overhauled Energy Model (EM) framework support also devfreq devices.
>> The unified API interface of the EM can be used in the thermal subsystem to
>> not duplicate code. The power table now is taken from EM structure and
>> there is no need to maintain calculation for it locally. In case when the
>> EM is not provided by the device a simple interface for cooling device is
>> used.
>>
>> There is also an improvement in code related to enabling/disabling OPPs,
>> which prevents from race condition with devfreq governors.
>>
>> [lkp: Reported the build warning]
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org> # for tracing code
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> The changes are too big, please split this patch into smaller chunks.

OK, I will split it and re-base on top of thermal testing.

> 
>> ---
>>   drivers/thermal/devfreq_cooling.c | 474 ++++++++++++++++--------------
>>   include/linux/devfreq_cooling.h   |  39 +--
>>   include/trace/events/thermal.h    |  19 +-
>>   3 files changed, 277 insertions(+), 255 deletions(-)
>>
>> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> 
> [ ... ]
> 
>>   struct devfreq_cooling_device {
>>   	int id;
>>   	struct thermal_cooling_device *cdev;
>>   	struct devfreq *devfreq;
>>   	unsigned long cooling_state;
>> -	u32 *power_table;
>>   	u32 *freq_table;
>> -	size_t freq_table_size;
>> +	size_t max_level;
> 
> Could you rename it to 'max_state' ?

Yes.

Thank you for your comments.

Regards,
Lukasz

