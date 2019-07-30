Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C86067AE3D
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 18:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfG3Qno (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 12:43:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58870 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfG3Qno (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 12:43:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B501560850; Tue, 30 Jul 2019 16:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564505022;
        bh=nzlx+WA8YpyPWGC852+7ZM1qfO8l79oxasafpFjso+c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HOl2oflInJUHQq2PZ68pCYQNQYdFCO+4JJDpEmNEvs49i4kZiqV10RlrLP2bhZs8c
         S8a2q/z0w9eWP1x6/KjBQtyEkYlMei1S6kRHUYDaKQ7lDM1zr0kp+CsX7VLlMzCuJg
         D1DVLX47+Yjxz05bcWdpCbU3/E19t0Csq//tIpEg=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 915F3602BC;
        Tue, 30 Jul 2019 16:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564505021;
        bh=nzlx+WA8YpyPWGC852+7ZM1qfO8l79oxasafpFjso+c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=giQuwOOght+bx4P3Ia3F/fMlV8ERnpI8PRUC20JNo8qJIr0KXTBoby48qa2lmfAL3
         /sjUn3+QJrx6sOjCwtrE0B9gbngmM9FIWZ+mHQU8Mw+UTzw7yW8VPEn4fp4sp6F6Sr
         ozzHq2Z2qC/0vcVOmmA1Kz7Ad2G+XJ/GhSIGQFoo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 915F3602BC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
Subject: Re: [PATCH v4 0/3] Introduce Bandwidth OPPs for interconnects
To:     Saravana Kannan <saravanak@google.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        David Dai <daidavid1@codeaurora.org>, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20190726231558.175130-1-saravanak@google.com>
 <20190729093545.kvnqxjkyx4nogddk@vireshk-i7>
 <CAGETcx8OBFGgP1-hj717Sk-_N95-kacVsz0yb288n3pej12n1Q@mail.gmail.com>
 <20190730024640.xk27jgdfl2j6ucx7@vireshk-i7>
 <361effba-4433-24d9-243c-201af39214cc@codeaurora.org>
 <CAGETcx_BpJswxA4AGARogZ1xRJPqm=_zTOZq1xJ2vgx+DUYsqQ@mail.gmail.com>
From:   Sibi Sankar <sibis@codeaurora.org>
Message-ID: <a9ab8614-7626-c309-24cc-02ce08a80ce5@codeaurora.org>
Date:   Tue, 30 Jul 2019 22:13:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAGETcx_BpJswxA4AGARogZ1xRJPqm=_zTOZq1xJ2vgx+DUYsqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/30/19 11:23 AM, Saravana Kannan wrote:
> On Mon, Jul 29, 2019 at 10:28 PM Sibi Sankar <sibis@codeaurora.org> wrote:
>>
>> Hey Viresh,
>>
>> On 7/30/19 8:16 AM, Viresh Kumar wrote:
>>> On 29-07-19, 13:16, Saravana Kannan wrote:
>>>> Sibi might be working on doing that for the SDM845 CPUfreq driver.
>>>> Georgi could also change his GPU driver use case to use this BW OPP
>>>> table and required-opps.
>>>>
>>>> The problem is that people don't want to start using this until we
>>>> decide on the DT representation. So it's like a chicken and egg
>>>> situation.
>>>
>>> Yeah, I agree to that.
>>>
>>> @Georgi and @Sibi: This is your chance to speak up about the proposal
>>> from Saravana and if you find anything wrong with them. And specially
>>> that it is mostly about interconnects here, I would like to have an
>>> explicit Ack from Georgi on this.
>>>
>>> And if you guys are all okay about this then please at least commit
>>> that you will convert your stuff based on this in coming days.
>>
>> I've been using both Saravana's and Georgi's series for a while
>> now to scale DDR and L3 on SDM845. There is currently no consensus
>> as to where the votes are to be actuated from, hence couldn't post
>> anything out.
>>
>> DCVS based on Saravana's series + passive governor:
>> https://github.com/QuinAsura/linux/tree/lnext-072619-SK-series
> 
> Thanks Sibi! You might want to convert your patches so that until the
> passive governor is ready, you just look up the required opps and vote
> for BW directly from the cpufreq driver. Once devfreq governor is
> ready, you can switch to it.

Sure I'll do that.

> 
> -Saravana
> 
>>
>> DCVS based on Georgi's series: (I had already posted this out)
>> https://github.com/QuinAsura/linux/tree/lnext-072619-GJ-series
>>
>> --
>> Qualcomm Innovation Center, Inc.
>> Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
>> a Linux Foundation Collaborative Project

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc, is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
