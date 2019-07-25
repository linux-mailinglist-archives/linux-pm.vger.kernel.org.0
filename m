Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A865E75267
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 17:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388979AbfGYPS5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 11:18:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46914 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388736AbfGYPS4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 11:18:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3CE77607DE; Thu, 25 Jul 2019 15:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564067935;
        bh=hnHhbe9q2IRKMtnzCZ2ig0RS/AUD9YxThPnuMNlk9D8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=By2gD602wfGFKF5ttG1fS+NbvbHMmWaPI1sqfQ/NTN5FVQR8M0A/sRZFNOrqPSTgk
         pcgvoVbrPbEJxxxPn0h+MrVXJaMWP32Zn7elvYxPJ724rVNtge4N+PO5m74WsUDiVE
         wvxeLJkSmojIkK9x9VnIRVXAqbBrjFcRbhWsXGNY=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 15C5060312;
        Thu, 25 Jul 2019 15:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564067934;
        bh=hnHhbe9q2IRKMtnzCZ2ig0RS/AUD9YxThPnuMNlk9D8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YfAfVEyfyjHOH1K+e7WFQFs8oC4PxsyySdDgQxFsrZMPwEbKeSJAgETfScZ0dIa7V
         K6ins/go/UOKVqrCBpwt5hzK3dFSPpUOf7+t9RtmiTjFmCJY1XMadJC0MV+9wTSDsz
         A5vgV0iFLyRawDjGwXQhqn1HGJe0NeMNigtnIIsI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 15C5060312
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Thu, 25 Jul 2019 09:18:51 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, mkshah@codeaurora.org
Subject: Re: [PATCH V2 2/4] drivers: qcom: rpmh-rsc: avoid locking in the
 interrupt handler
Message-ID: <20190725151851.GG18620@codeaurora.org>
References: <20190722215340.3071-1-ilina@codeaurora.org>
 <20190722215340.3071-2-ilina@codeaurora.org>
 <5d3769df.1c69fb81.55d03.aa33@mx.google.com>
 <20190724145251.GB18620@codeaurora.org>
 <5d38b38e.1c69fb81.e8e5d.035b@mx.google.com>
 <20190724203610.GE18620@codeaurora.org>
 <CAD=FV=UYj55m99EcQXmkYhs257A46x8DaarE0DC-GRF_3dY3-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAD=FV=UYj55m99EcQXmkYhs257A46x8DaarE0DC-GRF_3dY3-Q@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 24 2019 at 17:28 -0600, Doug Anderson wrote:
>Hi,
>
>On Wed, Jul 24, 2019 at 1:36 PM Lina Iyer <ilina@codeaurora.org> wrote:
>>
>> On Wed, Jul 24 2019 at 13:38 -0600, Stephen Boyd wrote:
>> >Quoting Lina Iyer (2019-07-24 07:52:51)
>> >> On Tue, Jul 23 2019 at 14:11 -0600, Stephen Boyd wrote:
>> >> >Quoting Lina Iyer (2019-07-22 14:53:38)
>> >> >> Avoid locking in the interrupt context to improve latency. Since we
>> >> >> don't lock in the interrupt context, it is possible that we now could
>> >> >> race with the DRV_CONTROL register that writes the enable register and
>> >> >> cleared by the interrupt handler. For fire-n-forget requests, the
>> >> >> interrupt may be raised as soon as the TCS is triggered and the IRQ
>> >> >> handler may clear the enable bit before the DRV_CONTROL is read back.
>> >> >>
>> >> >> Use the non-sync variant when enabling the TCS register to avoid reading
>> >> >> back a value that may been cleared because the interrupt handler ran
>> >> >> immediately after triggering the TCS.
>> >> >>
>> >> >> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> >> >> ---
>> >> >
>> >> >I have to read this patch carefully. The commit text isn't convincing me
>> >> >that it is actually safe to make this change. It mostly talks about the
>> >> >performance improvements and how we need to fix __tcs_trigger(), which
>> >> >is good, but I was hoping to be convinced that not grabbing the lock
>> >> >here is safe.
>> >> >
>> >> >How do we ensure that drv->tcs_in_use is cleared before we call
>> >> >tcs_write() and try to look for a free bit? Isn't it possible that we'll
>> >> >get into a situation where the bitmap is all used up but the hardware
>> >> >has just received an interrupt and is going to clear out a bit and then
>> >> >an rpmh write fails with -EBUSY?
>> >> >
>> >> If we have a situation where there are no available free bits, we retry
>> >> and that is part of the function. Since we have only 2 TCSes avaialble
>> >> to write to the hardware and there could be multiple requests coming in,
>> >> it is a very common situation. We try and acquire the drv->lock and if
>> >> there are free TCS available and if available mark them busy and send
>> >> our requests. If there are none available, we keep retrying.
>> >>
>> >
>> >Ok. I wonder if we need some sort of barriers here too, like an
>> >smp_mb__after_atomic()? That way we can make sure that the write to
>> >clear the bit is seen by another CPU that could be spinning forever
>> >waiting for that bit to be cleared? Before this change the spinlock
>> >would be guaranteed to make these barriers for us, but now that doesn't
>> >seem to be the case. I really hope that this whole thing can be changed
>> >to be a mutex though, in which case we can use the bit_wait() API, etc.
>> >to put tasks to sleep while RPMh is processing things.
>> >
>> We have drivers that want to send requests in atomic contexts and
>> therefore mutex locks would not work.
>
>Jumping in without reading all the context, but I saw this fly by and
>it seemed odd.  If I'm way off base then please ignore...
>
>Can you give more details?  Why are these drivers in atomic contexts?
>If they are in atomic contexts because they are running in the context
>of an interrupt then your next patch in the series isn't so correct.
>
>Also: when people submit requests in atomic context are they always
>submitting an asynchronous request?  In that case we could
>(presumably) just use a spinlock to protect the queue of async
>requests and a mutex for everything else?
Yes, drivers only make async requests in interrupt contexts. They cannot
use the sync variants. The async and sync variants are streamlined into
the same code path. Hence the use of spinlocks instead of mutexes
through the critical path.

--Lina

