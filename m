Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D59297905
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 23:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756830AbgJWVpU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 17:45:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56196 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756829AbgJWVpU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 17:45:20 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603489518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PWPxXpTrrlDAeAy6R37UaEC62YtNtDdRIHMGAEIcaW4=;
        b=hqS9jtc72zZGGGvuARTIcDq9Bv39aoItwcwnJj5bZVZ2Y4JcL/OEvlg+F4rBW/3QvdAo5W
        o0oTfq/JEl4KlySZQgb8ctuo3u2t4yiY9b6aBcHTW1doqMSIHqCIOvyPOespByI8R6DteC
        Mnc2b44dqqRk9b+Qv75thSsNdMP1/hFPGgZwGYvIST3FPSH+Cr6RBt2I+41mJMlymMsCys
        mHJAgOydFcQv7eHmls5kMa3fy0LD5Pcz/XRmitDfDdEjcuX1a1GlLRAJpgSj9HpYAXHDLi
        D2rO3RQkEqlalHqnhcm0LAiOEq6O4vCeeKCmk5lcO2FbWHiaWTLhSE4ogtegpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603489518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PWPxXpTrrlDAeAy6R37UaEC62YtNtDdRIHMGAEIcaW4=;
        b=vN0BUdufar4GqRZsYtOJFbaVQZ+fsFLNAUb3ZoyM9mXLBSx29xYtazVk59Lodu4n6WWhfb
        64PcddB3kDPYxGBw==
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Tian Tao <tiantao6@hisilicon.com>
Cc:     Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, amitk@kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thermal: replace spin_lock_irqsave by spin_lock in hard IRQ
In-Reply-To: <CAMuHMdVcraVpetQwdj7hW5bCum1SUXz14X6NhcVtq3BH3Csyzw@mail.gmail.com>
References: <1603249530-25218-1-git-send-email-tiantao6@hisilicon.com> <CAMuHMdVcraVpetQwdj7hW5bCum1SUXz14X6NhcVtq3BH3Csyzw@mail.gmail.com>
Date:   Fri, 23 Oct 2020 23:45:17 +0200
Message-ID: <877drg62he.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 22 2020 at 14:51, Geert Uytterhoeven wrote:
> On Wed, Oct 21, 2020 at 2:15 PM Tian Tao <tiantao6@hisilicon.com> wrote:
>> The code has been in a irq-disabled context since it is hard IRQ. There
>> is no necessity to do it again.
>>
> Is this also true if CONFIG_PREEMPT_RT=y, and all irq handlers execute
> in the context of special tasks?

On RT or even on mainline with 'threadirqs' on the command line all
interrupts which are not explicitly requested with IRQF_NO_THREAD run
their handlers in thread context. The same applies to soft interrupts.

That means they are subject to the normal scheduler rules and no other
code is going to acquire that lock from hard interrupt context either,
so the irqsave() here is pointless in all cases.

Famous last words...

  ... unless the driver does magic things like having a hrtimer armed
  which expires in hard interrupt context and touches the very same
  lock, but that's not the case in this particular driver.

So the change itself is correct, but the change log could do with some
polishing. :)

Thanks,

        tglx

