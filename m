Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B293219A9CB
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 12:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgDAKtd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Apr 2020 06:49:33 -0400
Received: from foss.arm.com ([217.140.110.172]:48630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgDAKtd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Apr 2020 06:49:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA5471FB;
        Wed,  1 Apr 2020 03:49:32 -0700 (PDT)
Received: from [10.37.12.63] (unknown [10.37.12.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A4CC3F68F;
        Wed,  1 Apr 2020 03:49:21 -0700 (PDT)
Subject: Re: [PATCH v5 4/5] thermal: devfreq_cooling: Refactor code and switch
 to use Energy Model
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
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
        orjan.eide@arm.com, rdunlap@infradead.org, mka@chromium.org
References: <20200318114548.19916-1-lukasz.luba@arm.com>
 <20200318114548.19916-5-lukasz.luba@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <b409f9d4-e9fe-1473-f2dd-aa11e3be1fd9@arm.com>
Date:   Wed, 1 Apr 2020 11:49:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200318114548.19916-5-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/18/20 11:45 AM, Lukasz Luba wrote:
> The overhauled Energy Model (EM) framework support also devfreq devices.
> The unified API interface of the EM can be used in the thermal subsystem to
> not duplicate code. The power table now is taken from EM structure and
> there is no need to maintain calculation for it locally. In case when the
> EM is not provided by the device a simple interface for cooling device is
> used.
> 
> There is also an improvement in code related to enabling/disabling OPPs,
> which prevents from race condition with devfreq governors.
> 
> [lkp: Reported the build warning]
> Reported-by: kbuild test robot <lkp@intel.com>
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org> # for tracing code
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>   drivers/thermal/devfreq_cooling.c | 474 ++++++++++++++++--------------
>   include/linux/devfreq_cooling.h   |  39 +--
>   include/trace/events/thermal.h    |  19 +-
>   3 files changed, 277 insertions(+), 255 deletions(-)
> 

Gentle ping.

Daniel or Amit could you have a look at this patch?

Regards,
Lukasz
