Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C843373FE6
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2019 22:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387978AbfGXUgP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 16:36:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52914 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfGXUgO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 16:36:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4F28560588; Wed, 24 Jul 2019 20:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564000573;
        bh=LeXYBF4XZF+Eab2E7VFMqCpPAbcHZ5qGNQCkNioMI04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e+1uovH+DfPEa13HCBRKq6kYXCNe6BUY6BmVLWd3OKIn8uKQvdwzAsfQWJOsWBzQo
         3pvyITvUwHHKKGVn2H9TVqF4fswgAvsjnPVfGJHJrwFaAxji7ZtNGamZ99JAUT88Z6
         5jWTHlmS8r64iMczX1k0rRZfF/s0hfElDANZnM5c=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4B4F460392;
        Wed, 24 Jul 2019 20:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564000572;
        bh=LeXYBF4XZF+Eab2E7VFMqCpPAbcHZ5qGNQCkNioMI04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a7cYdd2xjX2abQ5f3LG+OcGurndQp/AjKXZLkjoyWEbhzmCKz5cGH9RYpwbVgNul3
         DXzxFpU9IaTIG/TbQawoIbIfm78gJR8tDStF9ih2Mr3HYMPS5o2h5Yt5g6r/4sKjZM
         ieya17n3ksapj9vhBRNQYj6TdCHqcfu4GSdYaPg0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B4F460392
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Wed, 24 Jul 2019 14:36:10 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        mkshah@codeaurora.org
Subject: Re: [PATCH V2 2/4] drivers: qcom: rpmh-rsc: avoid locking in the
 interrupt handler
Message-ID: <20190724203610.GE18620@codeaurora.org>
References: <20190722215340.3071-1-ilina@codeaurora.org>
 <20190722215340.3071-2-ilina@codeaurora.org>
 <5d3769df.1c69fb81.55d03.aa33@mx.google.com>
 <20190724145251.GB18620@codeaurora.org>
 <5d38b38e.1c69fb81.e8e5d.035b@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5d38b38e.1c69fb81.e8e5d.035b@mx.google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 24 2019 at 13:38 -0600, Stephen Boyd wrote:
>Quoting Lina Iyer (2019-07-24 07:52:51)
>> On Tue, Jul 23 2019 at 14:11 -0600, Stephen Boyd wrote:
>> >Quoting Lina Iyer (2019-07-22 14:53:38)
>> >> Avoid locking in the interrupt context to improve latency. Since we
>> >> don't lock in the interrupt context, it is possible that we now could
>> >> race with the DRV_CONTROL register that writes the enable register and
>> >> cleared by the interrupt handler. For fire-n-forget requests, the
>> >> interrupt may be raised as soon as the TCS is triggered and the IRQ
>> >> handler may clear the enable bit before the DRV_CONTROL is read back.
>> >>
>> >> Use the non-sync variant when enabling the TCS register to avoid reading
>> >> back a value that may been cleared because the interrupt handler ran
>> >> immediately after triggering the TCS.
>> >>
>> >> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> >> ---
>> >
>> >I have to read this patch carefully. The commit text isn't convincing me
>> >that it is actually safe to make this change. It mostly talks about the
>> >performance improvements and how we need to fix __tcs_trigger(), which
>> >is good, but I was hoping to be convinced that not grabbing the lock
>> >here is safe.
>> >
>> >How do we ensure that drv->tcs_in_use is cleared before we call
>> >tcs_write() and try to look for a free bit? Isn't it possible that we'll
>> >get into a situation where the bitmap is all used up but the hardware
>> >has just received an interrupt and is going to clear out a bit and then
>> >an rpmh write fails with -EBUSY?
>> >
>> If we have a situation where there are no available free bits, we retry
>> and that is part of the function. Since we have only 2 TCSes avaialble
>> to write to the hardware and there could be multiple requests coming in,
>> it is a very common situation. We try and acquire the drv->lock and if
>> there are free TCS available and if available mark them busy and send
>> our requests. If there are none available, we keep retrying.
>>
>
>Ok. I wonder if we need some sort of barriers here too, like an
>smp_mb__after_atomic()? That way we can make sure that the write to
>clear the bit is seen by another CPU that could be spinning forever
>waiting for that bit to be cleared? Before this change the spinlock
>would be guaranteed to make these barriers for us, but now that doesn't
>seem to be the case. I really hope that this whole thing can be changed
>to be a mutex though, in which case we can use the bit_wait() API, etc.
>to put tasks to sleep while RPMh is processing things.
>
We have drivers that want to send requests in atomic contexts and
therefore mutex locks would not work.

--Lina

