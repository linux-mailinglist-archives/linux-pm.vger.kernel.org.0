Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B784A3802
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jan 2022 19:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbiA3SPd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 30 Jan 2022 13:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236788AbiA3SPc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Jan 2022 13:15:32 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA55C06173B
        for <linux-pm@vger.kernel.org>; Sun, 30 Jan 2022 10:15:31 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id m90so10629895uam.2
        for <linux-pm@vger.kernel.org>; Sun, 30 Jan 2022 10:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=PB7S81wb9t4u0hRvcxHMNh0F5lIgk9V9ej9pH5Jl/70=;
        b=qcUne9Bu7WOVGASCnovsKC7MQtpyr8NW367UbN9LDAKeYqjV+Sc1eaTq7aXGnL8uYB
         yy+vLPD2xC0TrFWLb3JJGZcVrhMhvJ5C+AsurDen9tJ5nka/M6wf+pDb1bRB0BSioeUJ
         qiiOjKHv2spFm+Pw6Qx7t6Jdazw8Te/U+OaPKscHrxLlVUppgq3WTrOVQEOVJBUKGYT2
         h1GXw5ZSXwIdGki6m949qzHILSRhNPaPRiRB3Pz5QwxIIXBGwuj6MqBI8UB9udpj1F2B
         TP6accXkSFhXaKidGNlPEiUgQLcviMaAowWoJA14YyB5vXA5wHPnEr2JUIYrF7ff1IPL
         M5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=PB7S81wb9t4u0hRvcxHMNh0F5lIgk9V9ej9pH5Jl/70=;
        b=poofCf3Tiix1j+6s2OI1Q+ngjPYFpPAHzTqkLDIqtZHoacjoX07hRkw6obytfkkSzg
         jAEF/GOjvmKTBolQDzuFhF7v9WZw/dTBGYKZwyYjef6xaIDRJV4ImNnN/jt2/MrpW1R7
         lw+hcfHv37fqYTAeWfH45zEJI//TBlPqJDOwszSVi9dkrDI0NSZpEF4bunfpUBZkwH1V
         io8/lrS5F2fPEl9oPCIx/sZCnZ2cQaSkttvtwq7BBYnyrDdR1yVlRxwg+chpYREbLKl2
         OYIKAQdr/XCy6UWAmUO3z57tka4kv6m7iqtFJgvgfnrVkIVJ0Pwkn0VaqDfBfd/5KAML
         nilQ==
X-Gm-Message-State: AOAM5339bemudHRMeFqkidhkHUqvXhxabILXy5rn0tSRRSrhuJL3Hb6y
        QM3PYpcYX9ZzufYnL+0e37QJHMKpKESDiyObETgGj0Jkam4C6FOA
X-Google-Smtp-Source: ABdhPJx5lAhfHKjbAMCz3qIR4BXsRA6gWS+gSyHum+OQxSFQ/mgbgvgsC/r0+PEV2LnuYeJfDS2f5S1vk7x74VOhmkw=
X-Received: by 2002:ab0:2619:: with SMTP id c25mr6810336uao.44.1643566529737;
 Sun, 30 Jan 2022 10:15:29 -0800 (PST)
MIME-Version: 1.0
From:   Zichar Zhang <zichar.zhang@linaro.org>
Date:   Mon, 31 Jan 2022 02:15:05 +0800
Message-ID: <CAE9iGojMgYKxReeartpXKWORdAfsj4t7Zo0pVb--+SLVGq4=cA@mail.gmail.com>
Subject: Re: [RFC] PM: suspend: Upstreaming wakeup reason capture support
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kelly Rossmoyer <krossmo@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Vijay Nayak <nayakvij@google.com>,
        Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael, Kelly

hello Rafael, it is a little bit late for me to reply to you. I was
finding the way to
reply to you, cause I'm not in the "cc list". So, thanks Kelly in that way. :)
I'm totally agree with you that we should split the work into smaller
pieces and do it step by step.

Hi Kelly,
I got the strong signal from you that you insist on your requirement.
It's reasonable, and I want that if I am the user too. :)

But it's could be some problem for me to do all of that. And I am calling help
here. Yes! I need some help!

I want to seperate this task into 4 part:
1. user interface: like sysfs file /sys/power/last_wakeup_reason.
2. report interface: call by "wakeup sources" to report "wakeup reason".
3. report operation in kernel: like "interrupt subsystem". (a common interface)
4. report operation in device: like WDT driver, GIC driver or other
device driver.

I think we should do the first 3 parts, but not the last one, cause it is device
specific things. Device and BSP should do that, I insist that.
Part 1 and 2 are easily to do, and I can rework again and agian until it is all
right for everyone.
So it is clear that we have problem with the third part. And yes! it is very
hard.

Kernel desn't know how the "machine" wakeup, kernel just offer the interface
that user can mark the "wakeup source", like IRQD_WAKEUP_STATE flag
and "ws"(wakeup source) interface (acturally they are fake wakeup sources).
These works well and we can easily to report these which Android patch and
mine already do that.
But the left things is hard.Cause kernel or "subsystem" in kernel desn't has
any mechanism to do that. Then we are facing these three things:

1. "misconfigured" and "unmapped" IRQs reporting.
Android patch just add a "wakeup report" interface here once it was occurred,
even it's not in a "suspend" state, and even one of them was in GIC driver.
if I was the maintainer I won't take this, but the question is what should I do
for that?
(Maybe I shoud give a task to "interrupt subsystem people" and ask them to
do that? :) )

2. errors in suspend/resume process.
That means if there is a error occurs in suspend/resume process I need to
report it as "wakeup reason".Which is just "abort wakeup reason" as  Kelly
said. But it is lots of errors may occurs here, and which one I should report,
and is that enough?
And as  Kelly said the code is "messy", that does hit the point.

3. threaded inerrupt
Sorry, I don't find the properly place in kernel to report there "wakeup
reason". Maybe that's my lack of knowalige. :)
It's seem like some interrupt chip driver should do that? I don't know. Maybe
I should offer a interface and just let "user" to use it?

So, that all the things I got.
And again kelly, I got your mind, and I will try to think this over again to see
if I can find a way to do that.

besides, thanks Jone and John, I will rework the patch after this discusion.

And any advice could help! :)
Or you have a better idea, I can help you to do yours!

Best
Zichar
