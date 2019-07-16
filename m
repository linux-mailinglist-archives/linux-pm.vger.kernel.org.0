Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96C926AE35
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 20:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388310AbfGPSNI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 14:13:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:32798 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbfGPSNI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 14:13:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7E9B16188E; Tue, 16 Jul 2019 18:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563300787;
        bh=srM1eZBYfggNW2Yf3/i2BiDYN0hawmNXpAJQu3yeR6k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=T5aZ8DAnYr1/JvnUJZ0eq+cz5Q9hpwxUuz6vy9xAtBy3YnAlgTe1nSdcjNd4h78n+
         VDmZ/XIe1LjI0yK9l6ZQEBbnblfqJdPO8zfHNV9LPC26BbzZ4yhwiU7RNNAGtuidHY
         KNU2wpdr8vWGaIaCLTlpywqnSl+xA0UL0TeAvJG0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.79.43.230] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1CE27615E3;
        Tue, 16 Jul 2019 18:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563300785;
        bh=srM1eZBYfggNW2Yf3/i2BiDYN0hawmNXpAJQu3yeR6k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WyoUpwMBfHTs7k0DDAwHkBUEEx2hEiInVvPegg7NxC0J0Fxpc7OnUhC7uNfS6Y3xn
         uBB5fCkd6C2XsgYFtLlH2FRiIb3kmaxhc1z/1qHuJDngVWJgsNHLI071XwoaTBjnxG
         iSkBu3gip3D5+YzCXAxN4MlHKDUiSu5hrezdqPc0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1CE27615E3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH v2 11/11] interconnect: Add devfreq support
To:     Saravana Kannan <saravanak@google.com>,
        Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        Android Kernel Team <kernel-team@android.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, adharmap@codeaurora.org
References: <20190614041733.120807-1-saravanak@google.com>
 <20190614041733.120807-12-saravanak@google.com>
 <5dc6c820-ead8-d0dc-44de-4d13f86df042@linaro.org>
 <CAGETcx-xU9i1FJB5JecUoyZEfWpD8f+o9bC3SQmb-=3fLVbmQw@mail.gmail.com>
From:   Sibi Sankar <sibis@codeaurora.org>
Message-ID: <9f2bf3fd-f7c5-40e8-6415-f334e3ef8d5d@codeaurora.org>
Date:   Tue, 16 Jul 2019 23:42:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAGETcx-xU9i1FJB5JecUoyZEfWpD8f+o9bC3SQmb-=3fLVbmQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Saravana,

On 6/18/19 2:48 AM, Saravana Kannan wrote:
> On Mon, Jun 17, 2019 at 8:44 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>>
>> Hi Saravana,
>>
>> On 6/14/19 07:17, Saravana Kannan wrote:
>>> Add a icc_create_devfreq() and icc_remove_devfreq() to create and remove
>>> devfreq devices for interconnect paths. A driver can create/remove devfreq
>>> devices for the interconnects needed for its device by calling these APIs.
>>> This would allow various devfreq governors to work with interconnect paths
>>> and the device driver itself doesn't have to actively manage the bandwidth
>>> votes for the interconnects.
>>
>> Thanks for the patches, but creating devfreq devices for each interconnect path
>> seems odd to me - at least for consumers that already use a governor.
> 
> Each governor instance always handles one "frequency" (more like
> performance) domain at a time. So if a consumer is already using a
> governor to scale the hardware block, then using another governor to
> scale the interconnect performance points is the right way to go about
> it. In fact, that's exactly what devfreq passive governor's
> documentation even says it's meant for. That's also what cpufreq does
> for each cluster/CPU frequency domain too.
> 
>> So for DDR
>> scaling for example, are you suggesting that we add a devfreq device from the
>> cpufreq driver in order to scale the interconnect between CPU<->DDR?
> 
> Yes in general. Although, CPUs are a special case because CPUs don't
> go through devfreq. So passive governor as it stands today won't work.
> CPU<->DDR scaling might need a separate governor (unlikely) or some
> changes to the passive governor that I'm happy to work on once we
> settle this for general devices like GPU, etc. But the DT format for
> CPUs will be identical to GPUs or any other device.

using icc_create_devfreq from the cpufreq-hw driver on SDM845 SoC
to scale CPU<->DDR would cause a circular dependency. (i.e) with
the addition of cpufreq notifier to the passive governor as in
https://patchwork.kernel.org/patch/11046147/ devm_devfreq_add_device
would require the cpufreq transistion notifier register and cpu
freq_cpu_get to go through. Please add your thought on addressing this.

> 
>> Also if the
>> GPU is already using devfreq, should we add a devfreq per each interconnect
>> path? What would be the benefit in this case - using different governors for
>> bandwidth scaling maybe?
> 
> When saying "separate/different governors" in this email, I mean both
> different instance of the same governor logic with different tunables
> AND actually different algorithms/governor logic entirely.
> 
> The heuristics to use for each interconnect path might be (more like,
> will be) different based on hardware characteristics (Eg: what voltage
> domains the interconnect is sitting on) and what interconnect
> information is available (Eg: Just busy time vs bandwidth count vs no
> information etc) -- so having separate governors for each interconnect
> path makes a lot of sense. It also allows userspace to control the
> policy for scaling each of those paths based on product use cases.
> 
> For example, when the GPU is just doing simple UI rendering, userspace
> can use the max_freq sysfs file for the devfreq device to disallow high
> bandwidth OPPs on the GPU<->DDR path, but those higher OPPs could be
> allowed by userspace when the GPU is used for games. Having devfreq
> device for each interconnect path also make it easy to debug
> performance issues -- you can independently change the votes for each
> path to figure out what is causing the bottleneck, etc.
> 
> Adding a devfreq device for interconnect voting with a few lines gives
> all these features "for free".
> 
> This doesn't mean all users of interconnect framework NEED to use
> devfreq for interconnect. They might do it simply based on
> calculations based on the use case (Eg: display driver from display
> resolution). But if they are trying to use any kind of
> algorithm/heuristics, writing it as a devfreq governor should be
> encouraged.
> 
> Also want to point out that BW OPPs also work for drivers that don't
> use devfreq at all. The interconnect-opp-table just lists the
> meaningful OPP leveld for the path and the device driver can pick one
> entry from the table based on the use case.
> 
> Thanks,
> Saravana
> 
> 
> 

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
