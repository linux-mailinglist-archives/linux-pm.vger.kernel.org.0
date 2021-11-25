Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F84445DFE3
	for <lists+linux-pm@lfdr.de>; Thu, 25 Nov 2021 18:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241554AbhKYRmk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Nov 2021 12:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbhKYRkk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Nov 2021 12:40:40 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9187AC0613F3
        for <linux-pm@vger.kernel.org>; Thu, 25 Nov 2021 09:26:05 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id u18so13165893wrg.5
        for <linux-pm@vger.kernel.org>; Thu, 25 Nov 2021 09:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ymZelrb7KzOn/PJyiCiUaGyHyZ2Hoc1vLnFtSp8LvdE=;
        b=mJnM/izD+nsitJlievhuRcvf/DMhGZYBbJNUCAHwXSC0s+MsFJqb0KyEt5sxjvKcIj
         QXyHTWDX6tv0mI9bfzLstpQjOkevk2aY6JV6nBm0ZXkkm/hu0SfDxjy9RHQbSv0XzDvg
         9lOcGd4E9M4HJ4lmBO+FxV5h3b8aS4BCHeUNE1nmaZruP6mMgz/C1yDXqT7QkFuz8f4y
         oZ1gkK1ki4R9qIOVTy0Tb8S57TuRN6c5BMYp3uLUl0pP9Yd3jOpOF1uGm/zTf/4uQD2a
         rb4CeHBlLEPtnnMO1lxU7Fb9CZKYWy66yEd3GcxTJ0y88To+zYXm2m84T/tio1GWuFvf
         IwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ymZelrb7KzOn/PJyiCiUaGyHyZ2Hoc1vLnFtSp8LvdE=;
        b=ZzXLqU0DCBjOJLicbit9rhW7IeKET8i6tWbqGOyYrm1Iz9Ikpxl+3uiVar3kYsPWVz
         AkkZMrFKdnm19Z0L8FB+4wsXeXBNPPY1qj7io6Y2mppLDC+thKO/S6gyv8jh6JKDpy6O
         BHiwywIuUJiS1o6A96qzMKIBfKE22ks/XsDhjeCjix3JpfjZAGG7d1+ooERiQ8qcWwhI
         CIQH19O5vrvAbBrsE3w5CJTXxWyJvQ6cKBW3Kq2/KPQQnRf4BK9H+LUHKhpELt/4nMXu
         wbuq4qgSqWSttA8JNfp2rf0AoK17oJCGe/Z4DOjS1FhzRaOtirb2M4lQgp41KTsAueTD
         OXZQ==
X-Gm-Message-State: AOAM530EpaJ+EUBw6NLsE7MeJL70w/jPIjlcPdu/Domh7T053eHeQy5E
        OdCvJz7oXU+lR/0JuNjDDqDNiw==
X-Google-Smtp-Source: ABdhPJzNrxF26RFAHPi+aUzYJTbWVxlVIELTLFjA7eN4upC9HjgyS9vb3THJOtWFC9fTm9lDLwa01A==
X-Received: by 2002:a05:6000:181:: with SMTP id p1mr8506708wrx.292.1637861163860;
        Thu, 25 Nov 2021 09:26:03 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:47ed:5339:c53f:6a8? ([2a01:e34:ed2f:f020:47ed:5339:c53f:6a8])
        by smtp.googlemail.com with ESMTPSA id h27sm9592940wmc.43.2021.11.25.09.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 09:26:03 -0800 (PST)
Subject: Re: [PATCH] sched/idle: Export cpu_idle_poll_ctrl() symbol
To:     Maulik Shah <quic_mkshah@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, quic_lsrao@quicinc.com,
        rnayak@codeaurora.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <1637831676-32737-1-git-send-email-quic_mkshah@quicinc.com>
 <YZ9ctgCBYJEEjuwt@hirez.programming.kicks-ass.net>
 <687d97b6-347a-92c0-34ba-00331dfb6c82@quicinc.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0fb74083-e378-e1b4-624b-4f2076f237df@linaro.org>
Date:   Thu, 25 Nov 2021 18:26:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <687d97b6-347a-92c0-34ba-00331dfb6c82@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25/11/2021 15:13, Maulik Shah wrote:
> Hi Peter,
> 
> On 11/25/2021 3:21 PM, Peter Zijlstra wrote:
>> On Thu, Nov 25, 2021 at 02:44:36PM +0530, Maulik Shah wrote:
>>> Export cpu_idle_poll_ctrl() so that module drivers can use same.
>> This does not seem like a really safe interface to expose to the
>> world.
> 
> Thanks for the review.
> 
> Keeping the cpuidle enabled from boot up may delay/increase the boot up
> time.
> Below is our use case to force cpuidle to stay in cpu_idle_poll().
> 
> We keep cpuidle disabled from boot up using "nohlt" option of kernel
> command line which internally sets cpu_idle_force_poll = 1;
> and once the device bootup reaches till certain point (for example the
> android homescreen is up) userspace may notify a
> vendor module driver which can invoke cpu_idle_poll_ctrl(false); to come
> out of poll mode.
> So vendor module driver needs cpu_idle_poll_ctrl() exported symbol.
> 
> We can not take PM-QoS from driver to prevent deep cpuidle since all the
> vendor modules are kept in a separate partition and will be loaded only
> after kernel boot up is done
> and by this time kernel already starts executing deep cpuidle modes.
>>
>> Surely the better solution is to rework things to not rely on this. I'm
>> fairly sure it's not hard to write a cpuidle driver that does much the
>> same.
> The other option i think is to pass cpuidle.off=1 in kernel command line
> and then add enable_cpuidle() in drivers/cpuidle/cpuidle.c
> something similar as below which can be called by vendor module.
> 
> void enable_cpuidle(void)
> {
>         off = 0;
> }
> EXPORT_SYMBOL_GPL(enable_cpuidle);
> 
> This may be a good option since we have already disable_cpuidle() but
> not enable_cpuidle().
> 
> void disable_cpuidle(void)
> {
>         off = 1;
> }
> 
> Hi Rafael/Daniel, can you please let me know your suggestion on
> this/similar implementation?

Did you try to use the QoS latency? Sounds like it is exactly for this
purpose.

Set it to zero to force cpuidle to choose the shallowest idle state and
then INT_MAX to disable the constraint.

 cpu_latency_qos_add_request();

Hope that helps

  -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
