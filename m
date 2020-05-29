Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5DC1E8116
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 17:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgE2PBA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 May 2020 11:01:00 -0400
Received: from foss.arm.com ([217.140.110.172]:37480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbgE2PA7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 29 May 2020 11:00:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D452F1045;
        Fri, 29 May 2020 08:00:58 -0700 (PDT)
Received: from [10.37.12.52] (unknown [10.37.12.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C41F73F718;
        Fri, 29 May 2020 08:00:48 -0700 (PDT)
Subject: Re: [PATCH v8 0/8] Add support for devices in the Energy Model
To:     rjw@rjwysocki.net
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com, Dietmar.Eggemann@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, sudeep.holla@arm.com,
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
References: <20200527095854.21714-1-lukasz.luba@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <8fca24a1-93f7-f859-bd1f-b7bf484737f4@arm.com>
Date:   Fri, 29 May 2020 16:00:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200527095854.21714-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,


On 5/27/20 10:58 AM, Lukasz Luba wrote:
> Hi all,
> 
> Background of this version:
> This is the v8 of the patch set and is has smaller scope. I had to split
> the series into two: EM changes and thermal changes due to devfreq
> dependencies. The patches from v7 9-14 which change devfreq cooling are
> going to be sent in separate patch series, just after this set get merged
> into mainline. These patches related to EM got acks and hopefully can go
> through linux-pm tree. The later thermal patches will go through thermal
> tree.
> 
> The idea and purpose of the Energy Model framework changes:
> This patch set introduces support for devices in the Energy Model (EM)
> framework. It will unify the power model for thermal subsystem. It will
> make simpler to add support for new devices willing to use more
> advanced features (like Intelligent Power Allocation). Now it should
> require less knowledge and effort for driver developer to add e.g.
> GPU driver with simple energy model. A more sophisticated energy model
> in the thermal framework is also possible, driver needs to provide
> a dedicated callback function. More information can be found in the
> updated documentation file.
> 
> First 7 patches are refactoring Energy Model framework to add support
> of other devices that CPUs. They change:
> - naming convention from 'capacity' to 'performance' state,
> - API arguments adding device pointer and not rely only on cpumask,
> - change naming when 'cpu' was used, now it's a 'device'
> - internal structure to maintain registered devices
> - update users to the new API
> Patch 8 updates OPP framework helper function to be more generic, not
> CPU specific.
> 
> The patch set is based on linux-pm branch linux-next 813946019dfd.
> 

Could you take the patch set via your linux-pm?

Regards,
Lukasz
