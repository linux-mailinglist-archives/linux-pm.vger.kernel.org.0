Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3D1109A98
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 09:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbfKZI6E convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 26 Nov 2019 03:58:04 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:37628 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfKZI6E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2019 03:58:04 -0500
Received: by mail-ot1-f46.google.com with SMTP id d5so15250715otp.4
        for <linux-pm@vger.kernel.org>; Tue, 26 Nov 2019 00:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2adQebnij/sMRJw7kwXHoI/wFRANM80vOhoQJ1Fowcg=;
        b=n4OMl0KwoV9ouBlIRgj8ftUig9Iisd0SkxxIxc8wplXKsbU7TZrLUI1wdczwD9u0wH
         ocH46jgNdc4Id2UAtRk6SVioxXXbt0oG4vdjw467TIcyeg17/KDU+mFUlOghLPB0hWjL
         ZWmMsaR0NZDEvHSllubflAzQR/zjma7aiA9v+hrVXItViQ6Io3FKWzwoixH9vtAut4qo
         CkDIqLgNpcBx1XU2SSet5rhPNUp+Vkwzrq7jF7iwMOXq2N56Hi32Shd06/7DluAusiPc
         Bq91dmz3NiLvlWZbtYcjrh247imKJIMcnwA4TMG+DXRIlUp9ti5JN5lOTKeJd22gSbBO
         hRmQ==
X-Gm-Message-State: APjAAAUF506z4Kvi6DvFtJ89scxUkLMCRXUMBRK+JHQAsyeHG1jSDkex
        zy0sjSejCCCzfjr89ny9dRxx7TaczW/09xu/fiM=
X-Google-Smtp-Source: APXvYqzjQ15WkgDRMPiBfcfgv3/8sVveaIck+568ocWmKKj//mjkAtl1BLap93sXhQDxfib/Cwr+u+3qxJicwNxe4lU=
X-Received: by 2002:a9d:7483:: with SMTP id t3mr1600688otk.262.1574758682983;
 Tue, 26 Nov 2019 00:58:02 -0800 (PST)
MIME-Version: 1.0
References: <DB3PR0402MB391626A8ECFDC182C6EDCF8DF54E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20191121093557.bycvdo4xyinbc5cb@vireshk-i7> <DB3PR0402MB39165544EDD0317095A1B72DF54E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0geykeebX-67+h4twj+t7oTVBf7X7_UsXw0LAc+0Ap75Q@mail.gmail.com>
 <CAJZ5v0j4z9tEDCGKRc7dHqTiJ1Fq3So=ELfvR6H25UkRmKeBvg@mail.gmail.com>
 <DB3PR0402MB3916BDC24BDA1053B7ADBDCFF5490@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0g5EGWVAm4A8ynoWAPc1wJRpR6wgZqwhvbmeT4eT49EUA@mail.gmail.com>
 <DB3PR0402MB39165E40800E42C2E5635C7CF54A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAJZ5v0iiJusFSrB9LRQq39K9TeGu0kndogdd060qqiJ=QOAQRw@mail.gmail.com>
In-Reply-To: <CAJZ5v0iiJusFSrB9LRQq39K9TeGu0kndogdd060qqiJ=QOAQRw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Nov 2019 09:57:52 +0100
Message-ID: <CAJZ5v0iWSw-wYP6odA7D9SDLQWX=X5KE_7WJ50z5kXUGoo1dHw@mail.gmail.com>
Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 25, 2019 at 1:44 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Nov 25, 2019 at 7:05 AM Anson Huang <anson.huang@nxp.com> wrote:
> >
> > Hi, Rafael
> >         Looks like adding pr_info() in irq_work_sync() makes issue can NOT be reproduced, any possibility of race happen there and the pr_info eliminate the race condition? I will continue run the test with the pr_info to see if any luck to reproduce it.
>
> Yes, it looks like there is a race condition in there.

I'm also thinking about a nasty enough compiler optimization in irq_work_sync().

Do you use LLVM by any chance?  If so, can you put a READ_ONCE()
around the work->flags read in there and see if that makes any
difference?
