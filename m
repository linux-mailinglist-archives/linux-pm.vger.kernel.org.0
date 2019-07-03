Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CABD75D9E4
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 02:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfGCA4e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jul 2019 20:56:34 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35466 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCA4e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jul 2019 20:56:34 -0400
Received: by mail-qt1-f193.google.com with SMTP id d23so752015qto.2;
        Tue, 02 Jul 2019 17:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ohmey1Vg9RYAAD1Ed48jjZ7GHK/q9zc8KdCvb9YzKyg=;
        b=u8Gtpy6jWhl+SHKw2Lmxv2oPwGvPxk04kBDj2/UcV0y2LADhqPIYfIrNEgnMacka1Q
         FEcjg2uvKEPcOjmysHzPW0S0ljEE919ejk7D7+uN4ecFQ9mCy6rjvuIXAO48NoB+S+KG
         xOiQ6jkqWECb2q4d6EnFXy0HB8w8SPMZ3MuZy6GpYUdOOHMKVpZ0k4RUEps6uWE3YqaT
         Sc7mvsLOEsMk+N68dEBxDDXXab/SuJtE2256ICfp4e3/EeyhFBlDb5R3ECRVUEBpc76B
         z8hoRcFNJv5PxQHbaOuCpNGHnoofBl+FpGDpxc/gnzz8V1xjKJgUedVMl3JhR7RuGijA
         jZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ohmey1Vg9RYAAD1Ed48jjZ7GHK/q9zc8KdCvb9YzKyg=;
        b=Zbflz7sOLNyYPEb2MjzqSAz0SKP3188vGNUXn53yEHIS6DwA+NqppzAcgDlFi/GzMV
         yrzOPdnYWubv8KfrAgnlwduRfbBobuA4f4qdtsIEGKAn+CllcW1EEAlsCaWrfubOxW8R
         cNuvD/Km5T4Nv0b9Dhpfs7EFbvjiSqDQL8PujNmap53kXs1HuyguceMR8fKs+wSJVPsL
         u+PC+6ppuVwfiBP8vyedUj+HYCTAem8RUTEV0cSvbcRN7D5ihI4iUJFfrppUpwXOLm+g
         htnyN+DLnjkvz0m1njYgXUshvEXMhnAcgtSFnaS/1ht7KUbadEYB9xWkpypbRu+ISue9
         sobQ==
X-Gm-Message-State: APjAAAVpDvniXwmkIb8jzFTcI+xyV9L8fB8nmbcmsqXs34LprwJLQZEn
        cEjbEHGkflaV5WWpNjxbQu29bp2fe1pGu38I6b0=
X-Google-Smtp-Source: APXvYqztiuteWGCyZsoaHnUThtkJ88Z9Lbno9npjnKvIoAzmCyNgrITmQ0xPKpO1mfd+Qsn9yRVDw9tQiAOQOKhu1AQ=
X-Received: by 2002:ac8:2b90:: with SMTP id m16mr27485334qtm.384.1562115393802;
 Tue, 02 Jul 2019 17:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190702163715.12649-1-smuchun@gmail.com> <CAJZ5v0jzVG5X8idR7Fy8g6=UPMpZ7eK6A_Uhqrer1aJFY1hX1w@mail.gmail.com>
In-Reply-To: <CAJZ5v0jzVG5X8idR7Fy8g6=UPMpZ7eK6A_Uhqrer1aJFY1hX1w@mail.gmail.com>
From:   Muchun Song <smuchun@gmail.com>
Date:   Wed, 3 Jul 2019 08:56:22 +0800
Message-ID: <CAPSr9jE6Qfu4NpmDfUrS+hVad2OP+xr00yoJ3k5=e=f7ZKwY+g@mail.gmail.com>
Subject: Re: [PATCH v2] PM: Move disabling/enabling runtime PM to
 suspend/resume noirq
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rafael J. Wysocki <rafael@kernel.org> =E4=BA=8E2019=E5=B9=B47=E6=9C=883=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=881:54=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Jul 2, 2019 at 6:37 PM Muchun Song <smuchun@gmail.com> wrote:
> >
> > Currently, the PM core disables runtime PM for all devices right after
> > executing subsystem/driver .suspend_late() callbacks for them and
> > re-enables it right before executing subsystem/driver .resume_early()
> > callbacks for them. This may lead to problems when there are two device=
s
> > such that the irq handler thread function executed for one of them
> > depends on runtime PM working for the other. E.g. There are two devices=
,
> > one is i2c slave device depends on another device which can be the i2c
> > adapter device. The slave device can generate system wakeup signals and
> > is enabled to wake up the system(via call enable_irq_wake()). So, the i=
rq
> > of slave device is enabled. If a wakeup signal generate after executing
> > subsystem/driver .suspend_late() callbacks. Then, the irq handler threa=
d
> > function will be called(The irq is requested via request_threaded_irq()=
)
> > and the slave device reads data via i2c adapter device(via i2c_transfer=
()).
> > In that case, it may be failed to read data because of the runtime PM
> > disabled.
> >
> > It is also analogously for resume. If a wakeup signal generate when the
> > system is in the sleep state. The irq handler thread function may be
> > called before executing subsystem/driver .resume_early(). In that case,
> > it also may be failed to read data because of the runtime PM disabled.
> >
>
> This has been discussed for a number of times, documented and no, I'm
> not going to apply this patch.

Thanks for your reply. I want to know why we can't do that, so where
can I find the discussion?

> PM-runtime cannot be relied on during the "noirq" stages of suspend
> and resume, which is why it is disabled by the core in the "late" and
> "early" stages, respectively.
>

What better solution do we have for the example I am talking about
which is described in the commit message? Thanks.

Yours,
Muchun
