Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92C91BFE65
	for <lists+linux-pm@lfdr.de>; Thu, 30 Apr 2020 16:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgD3Odl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Apr 2020 10:33:41 -0400
Received: from foss.arm.com ([217.140.110.172]:56156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbgD3Odk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 Apr 2020 10:33:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8BAD1063;
        Thu, 30 Apr 2020 07:33:39 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA72A3F68F;
        Thu, 30 Apr 2020 07:33:37 -0700 (PDT)
References: <20200424114058.21199-1-benjamin.gaignard@st.com> <7657495.QyJl4BcWH5@kreacher> <30cdecf9-703a-eb2b-7c2b-f1e21c805add@st.com> <70e743cf-b88e-346a-5114-939b8724c83d@arm.com> <6b5cde14-58b3-045d-9413-223e66b87bf0@st.com> <CAJZ5v0h6t6perZiibCWhEh1_V0pSXqFe-z22TFqH7KTFXYmqpQ@mail.gmail.com> <a234e123-6c15-8e58-8921-614b58ca24ca@st.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "viresh.kumar\@linaro.org" <viresh.kumar@linaro.org>,
        Hugues FRUCHET <hugues.fruchet@st.com>,
        "mchehab\@kernel.org" <mchehab@kernel.org>,
        "mcoquelin.stm32\@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "pavel\@ucw.cz" <pavel@ucw.cz>,
        "len.brown\@intel.com" <len.brown@intel.com>,
        "linux-pm\@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media\@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-stm32\@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel\@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [RFC 0/3] Introduce cpufreq minimum load QoS
In-reply-to: <a234e123-6c15-8e58-8921-614b58ca24ca@st.com>
Date:   Thu, 30 Apr 2020 15:33:35 +0100
Message-ID: <jhjtv11cabk.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 30/04/20 14:46, Benjamin GAIGNARD wrote:
>> That's not what I meant.
>>
>> I suppose that the interrupt processing in question takes place in
>> process context and so you may set the lower clamp on the utilization
>> of the task carrying that out.
>
> I have try to add this code when starting streaming (before the first
> interrupt) the frames from the sensor:
> const struct sched_attr sched_attr = {
>    .sched_util_min = 10000, /* 100% of usage */

Unless you play with SCHED_CAPACITY_SHIFT, the max should be 1024 -
i.e. SCHED_CAPACITY_SCALE. That's a really big boost, but that's for you to
benchmark.

>    .sched_flags = SCHED_FLAG_UTIL_CLAMP_MIN,
>   };
>
> sched_setattr(current, &sched_attr);
>
> I don't see any benefices maybe there is some configuration flags to set.
>
> How changing sched_util_min could impact cpufreq ondemand governor ?
> Does it change the value returned when the governor check the idle time ?
>

You'll have to use the schedutil governor for uclamp to have an effect. And
arguably that's what you should be using, unless something explicitly
prevents you from doing that.

>>
>> Alternatively, that task may be a deadline one.
