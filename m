Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17CF87AFE6
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 19:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbfG3R3i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 13:29:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43442 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728935AbfG3R3i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 13:29:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 468726037C; Tue, 30 Jul 2019 17:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564507777;
        bh=E7jANAXXkajQa6C5PUztGcfWtG5q4XzpnhfVwCjYX9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dgl4wrJMPHWyja+Qb8FeMv3prWlJBX1WSvlSbxBO2TrB5kp8ROUSHAvd7yaaLyFZs
         oe21hvwDdwUpgSDts/iPwTSmUGTTmK1fAsW9w1d110lJ6BQ5bI/tkTcpYEM67updlO
         tFfEoB7YYp1Xr/Kdp5CzGsAHF9Nxagkdf4NHZxZY=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0678F602BC;
        Tue, 30 Jul 2019 17:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564507776;
        bh=E7jANAXXkajQa6C5PUztGcfWtG5q4XzpnhfVwCjYX9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VpmDr2ipp6AByTDQOLnlZBeRmVtl3lmYmYIQjWu9DWjJNPQVo+roHb0j+5s/THjoh
         8KaLpJ+xwwF88ubJqNBr5wHKsCiTRzu/N3cM8NkLLS9GdLc0ct0HwKURiLVgVvapXC
         KuL4JJQ/mocvPY35hZeyzZ5CGgnaBZK2aqTFdJ0M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0678F602BC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Tue, 30 Jul 2019 11:29:35 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, mkshah@codeaurora.org
Subject: Re: [PATCH V2 2/4] drivers: qcom: rpmh-rsc: avoid locking in the
 interrupt handler
Message-ID: <20190730172935.GJ18620@codeaurora.org>
References: <20190722215340.3071-2-ilina@codeaurora.org>
 <5d3769df.1c69fb81.55d03.aa33@mx.google.com>
 <20190724145251.GB18620@codeaurora.org>
 <5d38b38e.1c69fb81.e8e5d.035b@mx.google.com>
 <20190724203610.GE18620@codeaurora.org>
 <CAD=FV=UYj55m99EcQXmkYhs257A46x8DaarE0DC-GRF_3dY3-Q@mail.gmail.com>
 <20190725151851.GG18620@codeaurora.org>
 <CAD=FV=X2ENqt5+vdUoRnLTRbedj_sFdQD3Me-yYEW0fDOdBCvg@mail.gmail.com>
 <20190729190139.GH18620@codeaurora.org>
 <5d3f5d6d.1c69fb81.4c1e2.5be6@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5d3f5d6d.1c69fb81.4c1e2.5be6@mx.google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 29 2019 at 14:56 -0600, Stephen Boyd wrote:
>Quoting Lina Iyer (2019-07-29 12:01:39)
>> On Thu, Jul 25 2019 at 09:44 -0600, Doug Anderson wrote:
>> >On Thu, Jul 25, 2019 at 8:18 AM Lina Iyer <ilina@codeaurora.org> wrote:
>> >>
>> >> On Wed, Jul 24 2019 at 17:28 -0600, Doug Anderson wrote:
>> >> >
>> >> >Jumping in without reading all the context, but I saw this fly by and
>> >> >it seemed odd.  If I'm way off base then please ignore...
>> >> >
>> >> >Can you give more details?  Why are these drivers in atomic contexts?
>> >> >If they are in atomic contexts because they are running in the context
>> >> >of an interrupt then your next patch in the series isn't so correct.
>> >> >
>> >> >Also: when people submit requests in atomic context are they always
>> >> >submitting an asynchronous request?  In that case we could
>> >> >(presumably) just use a spinlock to protect the queue of async
>> >> >requests and a mutex for everything else?
>> >> Yes, drivers only make async requests in interrupt contexts.
>> >
>> >So correct me if I'm off base, but you're saying that drivers make
>> >requests in interrupt contexts even after your whole series and that's
>> >why you're using spinlocks instead of mutexes.  ...but then in patch
>> >#3 in your series you say:
>> >
>> >> Switch over from using _irqsave/_irqrestore variants since we no longer
>> >> race with a lock from the interrupt handler.
>> >
>> >Those seem like contradictions.  What happens if someone is holding
>> >the lock, then an interrupt fires, then the interrupt routine wants to
>> >do an async request.  Boom, right?
>> >
>> The interrupt routine is handled by the driver and only completes the
>> waiting object (for sync requests). No other requests can be made from
>> our interrupt handler.
>
>The question is more if an interrupt handler for some consumer driver
>can call into this code and make an async request. Is that possible? If
>so, the concern is that the driver's interrupt handler can run and try
>to grab the lock on a CPU that already holds the lock in a non-irq
>disabled context. This would lead to a deadlock while the CPU servicing
>the interrupt waits for the lock held by another task that's been
>interrupted.
>
Hmm.. this patch will cause that issue, since we remove the irqsave
aspects of the locking. Let me give that a thought.
>>
>> >> They cannot
>> >> use the sync variants. The async and sync variants are streamlined into
>> >> the same code path. Hence the use of spinlocks instead of mutexes
>> >> through the critical path.
>> >
>> >I will perhaps defer to Stephen who was the one thinking that a mutex
>> >would be a big win here.  ...but if a mutex truly is a big win then it
>> >doesn't seem like it'd be that hard to have a linked list (protected
>> >by a spinlock) and then some type of async worker that:
>> >
>> >1. Grab the spinlock, pops one element off the linked list, release the spinlock
>> >2. Grab the mutex, send the one element, release the mutex
>> This would be a problem when the request is made from an irq handler. We
>> want to keep things simple and quick.
>>
>
>Is the problem that you want to use RPMh code from deep within the idle
>thread? As part of some sort of CPU idle driver for qcom platforms? The
>way this discussion is going it sounds like nothing is standing in the
>way of a design that use a kthread to pump messages off a queue of
>messages that is protected by a spinlock. The kthread would be woken up
>by the sync or async write to continue to pump messages out until the
>queue is empty.
>
While it is true that we want to use RPMH in cpuidle driver. Its just
that we had threads and all in our downstream 845 and it complicated the
whole setup a bit too much to our liking and did not help debug either.
I would rather not get all that back in the driver.

--Lina
