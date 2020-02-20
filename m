Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2D79165B93
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 11:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgBTKeR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 05:34:17 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:34818 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgBTKeR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 05:34:17 -0500
Received: by mail-oi1-f176.google.com with SMTP id b18so27076827oie.2;
        Thu, 20 Feb 2020 02:34:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VAP40k6HR+6LKosbEIXZrUrjkDmLImj5HhCg+dOGS6g=;
        b=hCXCxjaL0arZq7Mt6L0VY1KmxZ3S4aTZLSRFXbg4e3Ralvtzr3fWxZ2Z6vIcbkT0BL
         csNWls07d4p3WpWqojOy9sejBvNvJPxEuLO70+h/mxr7WIhZOd7DdSUWGqahgddBHOJV
         2bUi38qlgAZ7S6i1NSe7QcVg3rMZtRSFGfola/ztzFyCyMANObqTbB9u6fq1M5bdH5XD
         NL0NgftZBUfgTY3xwiPDKzdb0x8ZM55D8BQvwzNoWxYzaOXSKFn05vth3rhh4AkMZQbg
         YcnjLT40iamQOiajmgmky5tX1k0V29dmNXCaUqNSjmx+gV1GhXNzd1A705y2Y6KUEzCJ
         elXQ==
X-Gm-Message-State: APjAAAU4URjUlmGWEPorwgAEsqIIRAYdfZgT9PPTFbsHaGpgIQSo1/HA
        jYHEY9/i+ax4dkjDGTywQjtQbRwv7Ogl5usUqMM=
X-Google-Smtp-Source: APXvYqxofCC5wkjMP+nnXS7Hd45Hjl/OC5qNpLdFit8SZ20DA4UkgIppGZx0Jh5bzPvWsHc4pCJIzjWzfolo2wunR4k=
X-Received: by 2002:a54:4e96:: with SMTP id c22mr1527235oiy.110.1582194856166;
 Thu, 20 Feb 2020 02:34:16 -0800 (PST)
MIME-Version: 1.0
References: <0955D72C-D24D-402E-884F-C706578BF477@canonical.com>
 <a9fd25cd0a151d20e975ce79ab70197e39ef01e1.camel@linux.intel.com>
 <235CF4F8-19BF-4B00-8C92-E59CB2D476A7@canonical.com> <CAJZ5v0jXvo0ceNMp=kstTi24Ne7F-ZGMcD0T0TSMpcZZWsJsUA@mail.gmail.com>
 <CA007B3C-C084-429E-B774-70264A9E609F@canonical.com>
In-Reply-To: <CA007B3C-C084-429E-B774-70264A9E609F@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Feb 2020 11:34:05 +0100
Message-ID: <CAJZ5v0in-v9iu88Wj0gAg_th-E-QWDSHZ_XvgyoOuqE=CZPtqQ@mail.gmail.com>
Subject: Re: Hard Disk consumes lots of power in s2idle
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Kent Lin <kent.lin@canonical.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 20, 2020 at 11:25 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
>
>
> > On Feb 20, 2020, at 18:12, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Feb 20, 2020 at 9:08 AM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> >>
> >> Hi Srinivas,
> >>
> >>> On Feb 20, 2020, at 02:36, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> >>>
> >>> Hi Kai,
> >>>
> >>> On Wed, 2020-02-19 at 22:22 +0800, Kai-Heng Feng wrote:
> >>>> Hi Srinivas,
> >>>>
> >>>> Your previous work to support DEVSLP works well on SATA SSDs, so I am
> >>>> asking you the issue I am facing:
> >>>> Once a laptop has a HDD installed, the power consumption during
> >>>> S2Idle increases ~0.4W, which is quite a lot.
> >>>> However, HDDs don't seem to support DEVSLP, so I wonder if you know
> >>>> to do proper power management for HDDs?
> >>> What is the default here
> >>> cat /sys/power/mem_sleep
> >>> s2idle or deep?
> >>
> >> It defaults to s2idle.
> >>
> >>>
> >>> Please follow debug steps here:
> >>> https://01.org/blogs/qwang59/2018/how-achieve-s0ix-states-linux
> >>>
> >>> We need to check whether you get any PC10 residency or not.
> >>
> >> Yes it reaches PC10. It doesn't reach SLP_S0 though.
> >> The real number on S2Idle power consumption:
> >> No HDD: ~1.4W
> >> One HDD: ~1.8W
> >>
> >> If the SoC doesn't hit PC10 the number should be significantly higher.
> >> That's why I think the issue is the power management on HDD itself.
> >
> > I'm assuming that you mean a non-SSD device here.
>
> Yes, it's spinning rust here.
>
> >
> > That would be handled via ata_port_suspend() I gather and whatever
> > that does should do the right thing.
> >
> > Do you think that the disk doesn't spin down or it spins down, but the
> > logic stays on?
>
> The spin sound is audible, so I am certain the HDD spins down during S2Idle.

OK

> How do I know if the logic is on or off?

Well, if it were off, it would not draw power. :-)

So IMO it is reasonable to assume that the logic on the drive stays
on.  I'm not aware of anything that can be done to turn it off,
however.
