Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54E0116BF2C
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2020 11:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbgBYK4r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 05:56:47 -0500
Received: from foss.arm.com ([217.140.110.172]:49072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729106AbgBYK4r (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Feb 2020 05:56:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80E7A30E;
        Tue, 25 Feb 2020 02:56:46 -0800 (PST)
Received: from [10.37.12.155] (unknown [10.37.12.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75D703F6CF;
        Tue, 25 Feb 2020 02:56:36 -0800 (PST)
Subject: Re: [PATCH v3 1/4] PM / EM: add devices to Energy Model
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com
Cc:     Morten.Rasmussen@arm.com, Dietmar.Eggemann@arm.com,
        javi.merino@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com,
        viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org,
        rui.zhang@intel.com, amit.kucheria@verdurent.com,
        daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, qperret@google.com, bsegall@google.com,
        mgorman@suse.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, kernel@pengutronix.de, khilman@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, liviu.dudau@arm.com,
        lorenzo.pieralisi@arm.com, patrick.bellasi@matbug.net,
        orjan.eide@arm.com
References: <20200221194731.13814-1-lukasz.luba@arm.com>
 <20200221194731.13814-2-lukasz.luba@arm.com>
 <4ac6a187-1a09-335d-5c05-bf810ff81aaa@infradead.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <cf0d6bf7-ad87-4fbf-0392-646d5aa6d52b@arm.com>
Date:   Tue, 25 Feb 2020 10:56:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <4ac6a187-1a09-335d-5c05-bf810ff81aaa@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Randy,

Thank you for taking the time to look into this patch.

On 2/22/20 12:42 AM, Randy Dunlap wrote:
> Hi,
> One minor nit. Please see inline:
> 
> On 2/21/20 11:47 AM, Lukasz Luba wrote:
>> Add support of other devices into the Energy Model framework not only the
>> CPUs. Change the interface to be more unified which can handle other
>> devices as well.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   Documentation/power/energy-model.rst     | 133 ++++----
>>
>> diff --git a/Documentation/power/energy-model.rst b/Documentation/power/energy-model.rst
>> index 90a345d57ae9..7576820664e5 100644
>> --- a/Documentation/power/energy-model.rst
>> +++ b/Documentation/power/energy-model.rst
> 
>> @@ -85,13 +89,20 @@ API.
>>   2.3 Accessing performance domains
>>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>   
>> +There is two API functions which provide the access to the energy model:
> 
>     There are two

Indeed a mistake, I will fix it.

> 
>> +em_cpu_get() which takes CPU id as an argument and em_pd_get() with device
>> +pointer as an argument. It depends on the subsystem which interface it is
>> +going to use, but in case of CPU devices both functions return the same
>> +performance domain.
>> +
> 
> 
> cheers.
> 

Regards,
Lukasz
