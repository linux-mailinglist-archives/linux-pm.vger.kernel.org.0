Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12C76142E77
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2020 16:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgATPL3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jan 2020 10:11:29 -0500
Received: from foss.arm.com ([217.140.110.172]:33464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgATPL3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 20 Jan 2020 10:11:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3B7330E;
        Mon, 20 Jan 2020 07:11:28 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49CBA3F52E;
        Mon, 20 Jan 2020 07:11:22 -0800 (PST)
Subject: Re: [PATCH 1/4] PM / EM: and devices to Energy Model
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com
Cc:     Morten.Rasmussen@arm.com, Chris.Redpath@arm.com,
        ionela.voinescu@arm.com, javi.merino@arm.com,
        cw00.choi@samsung.com, b.zolnierkie@samsung.com, rjw@rjwysocki.net,
        sudeep.holla@arm.com, viresh.kumar@linaro.org, nm@ti.com,
        sboyd@kernel.org, rui.zhang@intel.com, amit.kucheria@verdurent.com,
        daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        rostedt@goodmis.org, qperret@google.com, bsegall@google.com,
        mgorman@suse.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, kernel@pengutronix.de, khilman@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org, robh@kernel.org,
        matthias.bgg@gmail.com, steven.price@arm.com,
        tomeu.vizoso@collabora.com, alyssa.rosenzweig@collabora.com,
        airlied@linux.ie, daniel@ffwll.ch, patrick.bellasi@matbug.net
References: <20200116152032.11301-1-lukasz.luba@arm.com>
 <20200116152032.11301-2-lukasz.luba@arm.com>
 <17b77e0c-9455-0479-d37b-c57717c784c7@arm.com>
Message-ID: <d0b90b97-3604-d4f4-b873-3879a9221532@arm.com>
Date:   Mon, 20 Jan 2020 16:11:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <17b77e0c-9455-0479-d37b-c57717c784c7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20/01/2020 15:53, Dietmar Eggemann wrote:
> On 16/01/2020 16:20, lukasz.luba@arm.com wrote:
>> From: Lukasz Luba <lukasz.luba@arm.com>

[...]

>> +enum em_type {
>> +	EM_SIMPLE,
>> +	EM_CPU,
>> +};
> 
> s/EM_SIMPLE/EM_DEV ?
> 
> Right now I only see energy models and _one_ specific type (the CPU EM).
> So a tag 'is a CPU EM' would suffice. No need for EM_SIMPE ...

Wait, you even have

struct em_device {
        struct em_perf_domain *em_pd;
        struct device *dev;
        ...
}

static bool _is_cpu_device(struct device *dev)

Shouldn't this be enough to distinguish between EM and special CPU EM
under the API? Even when required to use container_of() to get from
em_perf_domain to device.
