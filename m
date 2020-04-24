Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB2D1B7168
	for <lists+linux-pm@lfdr.de>; Fri, 24 Apr 2020 12:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgDXKC0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Apr 2020 06:02:26 -0400
Received: from foss.arm.com ([217.140.110.172]:58762 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbgDXKCZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Apr 2020 06:02:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D64DD1FB;
        Fri, 24 Apr 2020 03:02:24 -0700 (PDT)
Received: from [10.37.12.92] (unknown [10.37.12.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 557CD3F73D;
        Fri, 24 Apr 2020 03:02:14 -0700 (PDT)
Subject: Re: [PATCH v6 09/10] thermal: devfreq_cooling: Refactor code and
 switch to use Energy Model
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com, Dietmar.Eggemann@arm.com, cw00.choi@samsung.com,
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
References: <20200410084210.24932-1-lukasz.luba@arm.com>
 <20200410084210.24932-10-lukasz.luba@arm.com>
 <20200423175708.GG65632@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <b93226ac-a1f1-c1d0-fc25-0bd0f336252a@arm.com>
Date:   Fri, 24 Apr 2020 11:02:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200423175708.GG65632@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 4/23/20 6:57 PM, Daniel Lezcano wrote:
> On Fri, Apr 10, 2020 at 09:42:09AM +0100, Lukasz Luba wrote:
>> The overhauled Energy Model (EM) framework support also devfreq devices.
>> The unified API interface of the EM can be used in the thermal subsystem to
>> not duplicate code. The power table now is taken from EM structure and
>> there is no need to maintain calculation for it locally. In case when the
>> EM is not provided by the device a simple interface for cooling device is
>> used.
>>
>> [lkp: Reported the build warning]
>> Reported-by: kbuild test robot <lkp@intel.com>
>> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org> # for tracing code
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> Is it possible to split this patch into smaller parts? It is hard to understand
> what is related to the em conversion and other changes which look not related
> so far.
> 

No problem, I will do the split (it will be in the v7).

Regards,
Lukasz
