Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F543162078
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2020 06:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgBRFhE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 00:37:04 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33430 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgBRFhE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Feb 2020 00:37:04 -0500
Received: by mail-lj1-f195.google.com with SMTP id y6so21450530lji.0
        for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2020 21:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HQqzcFnDoi+mJWHn9CYGpZJAJQhhw/tPMZwi/T/g4NM=;
        b=P9FM9oW0/QQsLJRWErjz3Ro5y5GOJlIV78gyDcdDweIynnwcdvnAAnc15dhRt4y7ja
         +VO6G09pkHoJihWu8qe9H/MUklPe4uNN7jNB29oBWeOkA9ukiI/SHXTQPVnCRFPvYdv1
         C1RgulT8ay5w4vjwXl8Q1IcIUpK6BnmlX+niwuwCUQsCEvXJ8P42MLyG1Mru9bgweta6
         t6g8w5oAQG+bm0QmQC43FL4QgdGnrq8pDI6d4LaB7jVjW/dvTNOgMyCTNhhuAxoolwU3
         xP+XtDqPnVTCScVk1HOq74hd0SHppRtUCaHdNF+7px2b6rjd9pdpDyV4a4bpDiuzJl03
         Z7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HQqzcFnDoi+mJWHn9CYGpZJAJQhhw/tPMZwi/T/g4NM=;
        b=AcGM74HnMPZ4LZeluybrzwT+kjuVKCl55U60tztHnPK0nReeTOZc0xJZw2a4QTw43v
         XzovtPPmPOQQNlYNmMtBKZsVEN1OymV3suuVG5iCcsAMMSbWV9ZUoDi6geWXI16PpOUX
         DoIqIvHmqxdIeDTzjVJTTX5G2MqCSXY6EqGCLL59+iDJh6FF5/0SVJ+IQdRAfWzruuRk
         IGRjZz+8MJBUnEPoVNI37OnQpSDGtA+7DHukcEoBdE8UT4UTcM7nJPHCisznYpMVmovk
         Bpd9NfMuCZdo1KNkjLqk/aRITc8efa45ndeQfAyVQI/RVFibIY4en8/G1FqFqjHiUM0c
         87aA==
X-Gm-Message-State: APjAAAWNmDZYVN0qCUgxOQhCEtQ5jF77yVlnqhbfuDYQ6Hl/kqX5XQ8c
        ZGTalc1fQSwoa7KaXHnxnFjN5gcYa+xdrzpoq8X85g==
X-Google-Smtp-Source: APXvYqzZk8WTMI+ktNFla+FJhSjzyb+0R+CvGj8jIUEUynj0w8f6xkRereZa9onoa7LNIT5cMbLDTwn/dOHWYqGK0LQ=
X-Received: by 2002:a2e:5854:: with SMTP id x20mr11130896ljd.287.1582004222420;
 Mon, 17 Feb 2020 21:37:02 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580390127.git.amit.kucheria@linaro.org> <9d4f69cd-fb00-6216-5621-fa6d5b42ce19@linaro.org>
In-Reply-To: <9d4f69cd-fb00-6216-5621-fa6d5b42ce19@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 18 Feb 2020 11:06:50 +0530
Message-ID: <CAP245DXyciZ3RhGiK+10kiiG6ZHWfDXUGr5Dybwx7H5_UqJzjA@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] thermal: tsens: Handle critical interrupts
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

OK. I will address one last comment as part of the rebase.

Regards,
Amit

On Mon, Feb 17, 2020 at 8:55 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Amit,
>
> can you respin the series against v5.6-rc2?
>
> Thanks
>
>   -- Daniel
>
>
> On 30/01/2020 14:27, Amit Kucheria wrote:
> > TSENS IP v2.x supports critical interrupts and v2.3+ adds watchdog supp=
ort
> > in case the FSM is stuck. Enable support in the driver.
> >
> > This series was generated on top of linux-next from 20200130 to integra=
te
> > some patches that that are queued currently.
> >
> > Changes from v3:
> > - Remove the DTS changes that are already queued
> > - Fix review comments by Bjorn
> > - Fixup patch description to clarify that we don't use TSENS critical
> >   interrupts in Linux, but need it for the watchdog support that uses t=
he
> >   same HW irq line.
> > - Separate kernel-doc fixes into a separate patch.
> >
> > Changes from v2:
> > - Handle old DTBs w/o critical irq in the same way as fix sent for 5.5
> >
> > Changes from v1:
> > - Make tsens_features non-const to allow run time detection of features
> > - Pass tsens_sensor around as a const
> > - Fix a bug to release dev pointer in success path
> > - Address review comments from Bjorn and Stephen (thanks for the review=
)
> > - Add msm8998 and msm8996 DTSI changes for critical interrupts
> >
> >
> >
> > Amit Kucheria (7):
> >   drivers: thermal: tsens: Pass around struct tsens_sensor as a constan=
t
> >   drivers: thermal: tsens: use simpler variables
> >   drivers: thermal: tsens: Release device in success path
> >   drivers: thermal: tsens: Add critical interrupt support
> >   drivers: thermal: tsens: Add watchdog support
> >   drivers: thermal: tsens: kernel-doc fixup
> >   drivers: thermal: tsens: Remove unnecessary irq flag
> >
> >  drivers/thermal/qcom/tsens-8960.c   |   2 +-
> >  drivers/thermal/qcom/tsens-common.c | 191 ++++++++++++++++++++++++----
> >  drivers/thermal/qcom/tsens-v2.c     |  18 ++-
> >  drivers/thermal/qcom/tsens.c        |  26 +++-
> >  drivers/thermal/qcom/tsens.h        |  94 +++++++++++++-
> >  5 files changed, 300 insertions(+), 31 deletions(-)
> >
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
