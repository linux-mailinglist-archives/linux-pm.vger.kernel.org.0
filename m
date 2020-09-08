Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B571026179E
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 19:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731599AbgIHRjO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 13:39:14 -0400
Received: from a27-55.smtp-out.us-west-2.amazonses.com ([54.240.27.55]:33118
        "EHLO a27-55.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731389AbgIHRjH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 13:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599586743;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        bh=5hr+21GN/a0XeKqQOvPosaEbVEuzqFPlV6FPY5IdE4c=;
        b=oYcRMCnwTFuJrMWwBGjaujQvqV7NboxQCEwGKvQoJvQBHMn1Zn2pXvFnqOoo1Hwi
        1+gpFgx9LjN0zbYDwTsXsqK4dTz6xtaXFkkuobXA3j+uDLYZqRmpuTPOCYwGBNL2i2k
        gzSxTdQRdaKeoj8TcVRAjDPnbmQiykB0O7n6AOBU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599586743;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Feedback-ID;
        bh=5hr+21GN/a0XeKqQOvPosaEbVEuzqFPlV6FPY5IdE4c=;
        b=XLqptdvkl2F06qIB63PO0CRr+GmeMfqcDzTQTrF4MIVT6NqwFjT3QdCI9f/PnS91
        rPxYyeg+wv8QU8BvDmCQ43NklOIFvohkhtSbshgXIRKmx3TPpcI6cQyQR0dM/qpS9LM
        NogadO6cDytzTr09FHeT6R1vgca2ghZIzC93+h78=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6B3ABC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
Date:   Tue, 8 Sep 2020 17:39:02 +0000
From:   Lina Iyer <ilina@codeaurora.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [RFC PATCH 0/2] Better domain idle from device wakeup patterns
Message-ID: <010101746eccb270-05beb27f-e1e4-40eb-92da-ad1bb48feb41-000000@us-west-2.amazonses.com>
References: <20200902232546.31240-1-ilina@codeaurora.org>
 <CAPDyKFr+nA-EwbN_sOCj=R0EEtMNEaqfMqB+uV5+uzMTjS4rMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPDyKFr+nA-EwbN_sOCj=R0EEtMNEaqfMqB+uV5+uzMTjS4rMA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SES-Outgoing: 2020.09.08-54.240.27.55
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 08 2020 at 06:15 -0600, Ulf Hansson wrote:
>On Thu, 3 Sep 2020 at 01:26, Lina Iyer <ilina@codeaurora.org> wrote:
>>
>> Hello,
>>
>> I was looking for an option to do better power management for some
>> domains where the devices enter runtime PM in a predictable fashion. For
>> example a display device that sends a vsync interrupt every 16 ms for a
>> 60 Hz panel. These interrupts are not timer interrupts but tend to
>> interrupt periodically to service the workflow and the devices and
>> domains may go back to idle soon after. Two domains are affected by this
>> - the device's PM domain and the CPU PM domain.
>>
>> As a first step, I am looking to solve for the device's PM domain idle
>> state (and hopefully solve for the CPU PM domains subsequently). The PM
>> domain could have multiple idle states and/or the enter/exit latencies
>> could be high. In either case, it may not always be beneficial to power
>> off the domain, only to turn it back on before satisfying the idle state
>> residency. When the wakeup is known for the device, we could use that to
>> determine the worthiness of entering a domain idle state. Only the
>> device can tell us when the future event would be and that could change
>> as the usecase changes. Like, when the panel refresh rate increases to
>> 120 Hz. If this information was made available to runtime PM, we could
>> use that in the domain governor to determine a suitable idle state. This
>> is the idea behind these patches.
>
>While striving towards entering the most optimal (energy and
>performance wise) idle state, I think it's an interesting approach.
>
Thanks for taking time to review this.

>>
>> In the first patch, I am proposing an API for devices to specify their
>> wakeup as a time in the future and in the second patch, I am updating
>> the PM domain governor to use this information to determine the idle
>> state. I have not had a chance to test this out yet, but I wanted to
>> know if I am on the right track.
>
>I don't have any immediate objections - I think the approach seems
>reasonable. Still, my first thought that this could be an extension to
>the dev_pm_qos interface, but perhaps that isn't a good fit.
>
Yeah, I did look into that, but it did not the bill exactly either
starting with the locking requirements and how the next event could be
placed from an interrupt context.

>I also have a couple of comments to the code, but I will reply to each
>patch separately about that.
>
>>
>> Would appreciate your thoughts on this.
>
>When it comes to showing real results, other than in theory, I think

Well, the device's PM domain power saving is largely dependent on the
board design and the power saving or performance benefit may not be
easily quantifiable.

>we need to make the genpd's cpu governor to cope with the next wakeup
>event as well.
>
I was hoping to tie this with the genirq/timing framework as well for
the CPUs, but it is something I was thinking as a next step. The API and
the governor changes here lay the foundation for that as well. All we
need to do is hook up the predicted event to the CPU device and the CPU
domain governor already calls into the default_power_down_ok() which
takes care of the next event to effect a better governor decision.

--Lina

>>
>> Thanks,
>> Lina
>>
>>
>> Lina Iyer (2):
>>   PM / runtime: register device's next wakeup
>>   PM / Domains: use device's next wakeup to determine domain idle state
>>
>>  drivers/base/power/domain_governor.c | 87 ++++++++++++++++++++++++++--
>>  drivers/base/power/runtime.c         | 31 ++++++++++
>>  include/linux/pm.h                   |  2 +
>>  include/linux/pm_domain.h            |  1 +
>>  include/linux/pm_runtime.h           |  1 +
>>  5 files changed, 116 insertions(+), 6 deletions(-)
>>
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
>
>Kind regards
>Uffe
