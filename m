Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562571EA0E3
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jun 2020 11:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgFAJVM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jun 2020 05:21:12 -0400
Received: from foss.arm.com ([217.140.110.172]:35324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgFAJVM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 1 Jun 2020 05:21:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D6B41FB;
        Mon,  1 Jun 2020 02:21:11 -0700 (PDT)
Received: from [10.37.12.87] (unknown [10.37.12.87])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CF523F305;
        Mon,  1 Jun 2020 02:21:00 -0700 (PDT)
Subject: Re: [PATCH v8 3/8] PM / EM: update callback structure and add device
 pointer
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-imx@nxp.com
Cc:     Dietmar.Eggemann@arm.com, cw00.choi@samsung.com,
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
References: <20200527095854.21714-1-lukasz.luba@arm.com>
 <20200527095854.21714-4-lukasz.luba@arm.com>
 <666b2f9e-d7ed-6ddb-80aa-e63ab9909ee6@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <3a7d1261-df40-4b3a-14c2-6c6d18b5b5c1@arm.com>
Date:   Mon, 1 Jun 2020 10:20:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <666b2f9e-d7ed-6ddb-80aa-e63ab9909ee6@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 5/29/20 6:43 PM, Daniel Lezcano wrote:
> On 27/05/2020 11:58, Lukasz Luba wrote:
>> The Energy Model framework is going to support devices other that CPUs. In
>> order to make this happen change the callback function and add pointer to
>> a device as an argument.
>>
>> Update the related users to use new function and new callback from the
>> Energy Model.
>>
>> Acked-by: Quentin Perret <qperret@google.com>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 

Thank you Daniel!

Regards,
Lukasz
