Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE2519A623
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 09:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbgDAHTa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Apr 2020 03:19:30 -0400
Received: from foss.arm.com ([217.140.110.172]:44124 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731680AbgDAHT3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Apr 2020 03:19:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAD1831B;
        Wed,  1 Apr 2020 00:19:28 -0700 (PDT)
Received: from [10.37.12.63] (unknown [10.37.12.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69E453F52E;
        Wed,  1 Apr 2020 00:23:27 -0700 (PDT)
Subject: Re: [PATCH v5 2/5] OPP: refactor dev_pm_opp_of_register_em() and
 update related drivers
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com, viresh.kumar@linaro.org
Cc:     Morten.Rasmussen@arm.com, Dietmar.Eggemann@arm.com,
        javi.merino@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com,
        nm@ti.com, sboyd@kernel.org, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, daniel.lezcano@linaro.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
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
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <4326bd75-e892-63ca-5757-5befd9bbac14@arm.com>
Date:   Wed, 1 Apr 2020 08:19:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200318114548.19916-3-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/18/20 11:45 AM, Lukasz Luba wrote:
> The Energy Model framework supports both: CPUs and devfreq devices. Drop
> the CPU specific interface with cpumask and add struct device. Add also a
> return value. This new interface provides easy way to create a simple
> Energy Model, which then might be used in i.e. thermal subsystem.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>   drivers/cpufreq/cpufreq-dt.c           |  2 +-
>   drivers/cpufreq/imx6q-cpufreq.c        |  2 +-
>   drivers/cpufreq/mediatek-cpufreq.c     |  2 +-
>   drivers/cpufreq/omap-cpufreq.c         |  2 +-
>   drivers/cpufreq/qcom-cpufreq-hw.c      |  2 +-
>   drivers/cpufreq/scpi-cpufreq.c         |  2 +-
>   drivers/cpufreq/vexpress-spc-cpufreq.c |  2 +-
>   drivers/opp/of.c                       | 71 ++++++++++++++++----------
>   include/linux/pm_opp.h                 | 15 +++++-
>   9 files changed, 65 insertions(+), 35 deletions(-)


Gentle ping.

Viresh could you have a look at it?

Regards,
Lukasz
