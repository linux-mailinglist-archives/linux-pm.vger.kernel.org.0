Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4320319F789
	for <lists+linux-pm@lfdr.de>; Mon,  6 Apr 2020 16:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgDFOF4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Apr 2020 10:05:56 -0400
Received: from foss.arm.com ([217.140.110.172]:46148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728086AbgDFOFz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 6 Apr 2020 10:05:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F809106F;
        Mon,  6 Apr 2020 07:05:53 -0700 (PDT)
Received: from [10.37.12.4] (unknown [10.37.12.4])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA1043F73D;
        Mon,  6 Apr 2020 07:05:42 -0700 (PDT)
Subject: Re: [PATCH v5 2/5] OPP: refactor dev_pm_opp_of_register_em() and
 update related drivers
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
 <20200318114548.19916-3-lukasz.luba@arm.com>
 <3ee5dc1a-fdfe-da17-9a62-a5182c1f4d3e@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <00c839d1-2f03-2d3b-5746-95deae30bee3@arm.com>
Date:   Mon, 6 Apr 2020 15:05:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3ee5dc1a-fdfe-da17-9a62-a5182c1f4d3e@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

Thank you for your comments.

On 4/3/20 5:21 PM, Daniel Lezcano wrote:
> On 18/03/2020 12:45, Lukasz Luba wrote:
>> The Energy Model framework supports both: CPUs and devfreq devices. Drop
>> the CPU specific interface with cpumask and add struct device. Add also a
>> return value. This new interface provides easy way to create a simple
>> Energy Model, which then might be used in i.e. thermal subsystem.
> 
> This patch contains too many different changes.

OK, I will create 4 patches:
1) change with new argument in API function:
    void dev_pm_opp_of_register_em(dev, cpumask)
   and updated drivers
2) changes with _get_cpu_power --> _get_power
3) changes adding int return in dev_pm_opp_of_register_em()
    and updating error handling path inside
4) header changes with new dev_pm_opp_of_unregister_em()

> 
> There are fixes and traces added in addition to a function prototype change. >
> Please provide patches separated by logical changes.

I will try to make this API change in a safe way, which
won't break cpufreq drivers compilation.

> 
> If the cpumask is extracted in the underlying function
> em_register_perf_domain() as suggested in the previous patch 1/5,
> dev_pm_opp_of_register_em() can be struct device centric only.

That would be ideal situation but unfortunately not possible to
implement (as responded in 1/5).

Regards,
Lukasz
