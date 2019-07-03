Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 797085E07F
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 11:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfGCJIL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 3 Jul 2019 05:08:11 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34280 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfGCJIK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jul 2019 05:08:10 -0400
Received: by mail-ot1-f66.google.com with SMTP id n5so1608751otk.1;
        Wed, 03 Jul 2019 02:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nbEbntIJaLENK/oqeoihZjrIjyBepd0wvibz6dSpYeE=;
        b=g6OaSQ0Ow1QayrCaFQXW7MwfDuoShLOsyo24YGCJoSA280OiBbm0cXS/Rm9V0SlB7Y
         KgGhESTn9M4TgAIYKFBS9lQxzqc07JxSHNvEh5wsifKkPKMy2HXBpdtkwnjDABjgqZSH
         1HsX6qI56sftTC373T5QCX/A/DzZb7XIB6H6rK7tAoHdexlsCxQl2wKzVcmQI5HHCphP
         b699zrouR6gHS0bnHg1LXGDnahZPPHPk08eYUbETHpiii+lG/z/z0POyYzvypPRJXi2S
         YK9t4gHO5mudVzo6Fk+dM8ZXm8NZ+//vW17m0cCdEApySG2yel7qJ9xTX8vPrOnW0zFo
         iFZA==
X-Gm-Message-State: APjAAAV2WsRKGjPMbVtoVWJJL4fweHQFKhRDNuZXTtcxTnbipGkIBC5O
        Sg2TDAGwcB8AwKulD4qsQUTOjRVT35WfR+8IeZ0=
X-Google-Smtp-Source: APXvYqzw2F9FsWK8Gf8cnIc2VWd1k4GWetsGGm3DNFMokosTuaRW154UNXW1UF0auw1LGJC4+gTVmrEWM0JuNriWXjc=
X-Received: by 2002:a9d:6a4b:: with SMTP id h11mr13439329otn.266.1562144889996;
 Wed, 03 Jul 2019 02:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190702163715.12649-1-smuchun@gmail.com> <CAJZ5v0jzVG5X8idR7Fy8g6=UPMpZ7eK6A_Uhqrer1aJFY1hX1w@mail.gmail.com>
 <CAPSr9jE6Qfu4NpmDfUrS+hVad2OP+xr00yoJ3k5=e=f7ZKwY+g@mail.gmail.com>
In-Reply-To: <CAPSr9jE6Qfu4NpmDfUrS+hVad2OP+xr00yoJ3k5=e=f7ZKwY+g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Jul 2019 11:07:58 +0200
Message-ID: <CAJZ5v0ifXrrWd=md=fyW2P5xgRtZQ_==d1E-z7LYcJF2PMPxJA@mail.gmail.com>
Subject: Re: [PATCH v2] PM: Move disabling/enabling runtime PM to
 suspend/resume noirq
To:     Muchun Song <smuchun@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 3, 2019 at 2:56 AM Muchun Song <smuchun@gmail.com> wrote:
>
> Rafael J. Wysocki <rafael@kernel.org> 于2019年7月3日周三 上午1:54写道：
> >
> > On Tue, Jul 2, 2019 at 6:37 PM Muchun Song <smuchun@gmail.com> wrote:
> > >
> > > Currently, the PM core disables runtime PM for all devices right after
> > > executing subsystem/driver .suspend_late() callbacks for them and
> > > re-enables it right before executing subsystem/driver .resume_early()
> > > callbacks for them. This may lead to problems when there are two devices
> > > such that the irq handler thread function executed for one of them
> > > depends on runtime PM working for the other. E.g. There are two devices,
> > > one is i2c slave device depends on another device which can be the i2c
> > > adapter device. The slave device can generate system wakeup signals and
> > > is enabled to wake up the system(via call enable_irq_wake()). So, the irq
> > > of slave device is enabled. If a wakeup signal generate after executing
> > > subsystem/driver .suspend_late() callbacks. Then, the irq handler thread
> > > function will be called(The irq is requested via request_threaded_irq())
> > > and the slave device reads data via i2c adapter device(via i2c_transfer()).
> > > In that case, it may be failed to read data because of the runtime PM
> > > disabled.
> > >
> > > It is also analogously for resume. If a wakeup signal generate when the
> > > system is in the sleep state. The irq handler thread function may be
> > > called before executing subsystem/driver .resume_early(). In that case,
> > > it also may be failed to read data because of the runtime PM disabled.
> > >
> >
> > This has been discussed for a number of times, documented and no, I'm
> > not going to apply this patch.
>
> Thanks for your reply. I want to know why we can't do that, so where
> can I find the discussion?

The discussions rather.

You need to search email archives, especially for the reason why the
"late" and "early" callbacks have been added.  There was a conference
presentation about that even.

The bottom line is that the change you are proposing cannot be made.

> > PM-runtime cannot be relied on during the "noirq" stages of suspend
> > and resume, which is why it is disabled by the core in the "late" and
> > "early" stages, respectively.
> >
>
> What better solution do we have for the example I am talking about
> which is described in the commit message?

It's not "what better solution is there", because what you are
proposing would simply not work.

Basically, if there are devices that may need the given one in the
"noirq" resume phase, this device needs to be resumed upfront.  It may
be runtime-suspended again in the "early" resume phase.
