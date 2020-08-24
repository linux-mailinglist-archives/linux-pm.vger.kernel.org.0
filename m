Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177AF24F986
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 11:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgHXJq2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 05:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbgHXImU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 04:42:20 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436DDC061573;
        Mon, 24 Aug 2020 01:42:19 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a5so7812800wrm.6;
        Mon, 24 Aug 2020 01:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FbqblzJhgrxr4jZgi3Lq34QqMg+Ttkj3vGhG8H42MbE=;
        b=QP3WPu9b1QKlz3sDPT/E0l4eLPgQXgf9j16xq2ixoEUc4YlJj12mlVBgfq9loGF/TJ
         inbamtbamkfPkYT3SfI0Eh4mq32N8+pl52ApN5zilY94tGLgqlZnZYGEg3vBl30ec3Rc
         lRekNLBhwn7fVnXk6ocbZNYwxvicu0x1ikJHlNCEtv/eZmpH0IShjDQNXnVLqgCSsCM7
         66JACXsjbYo5b75KtgOu33NpuUIcU/PsrlkUQ72cIXvlI+CtvFNRiFB0TS50tEk2t43h
         PbfgiKOCWJRUf+GNeUadfRHUmsRxLBN0hqYkbF0TzgTh2NrcqM1Yw3UzBJbNiIaHD2Hi
         WuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FbqblzJhgrxr4jZgi3Lq34QqMg+Ttkj3vGhG8H42MbE=;
        b=ZQ18iiHRs/prN1Ei63AtBQJJL//DQBzTxXkw2fXaI4AlVfHCMxAlnx9UG5DljWnDzv
         gaqewKYe1YZWpUmKTsnDKmIoPhUfCeXh5dr8xc6S17j9z4wnsrjnRucBfw8QrFnHNjzX
         xsAtz17ZubqtTHe57JU6BW6+ly0EI6hWTRfHP8+2I7IRGuRolJcP4XBNiMlS9KTt4ZT2
         jMUum3FS2riayoYtIEOVpHK9CdqTx/Mxz5nEKfY1cWvF7bW1yK7OqFjH8CTI/q700cdZ
         mrv5I2JuzY6/wkUhbsGTJRxLWA/flNJ4DpgBzf6Npc9XRqWh13j4ZSO2vtYbwarJCP9w
         q1Hg==
X-Gm-Message-State: AOAM532BI97XU5AVvURpGpNSiwCUGiAFcoSXByA0NPYoHH+cFGSNfruz
        D/v2dSYZqvUrkWSzmDvarlF80vJ8rTOckKUFJVJzirDaJE3fQA==
X-Google-Smtp-Source: ABdhPJzAg8uQC8Mrf0XcBKdIu2nrOS4XC7CNiYSaA3zhrvxiaasEP+kVaYJgjFUamKAVfjf08TugaCoK1jLRBUkbid8=
X-Received: by 2002:adf:9283:: with SMTP id 3mr4718276wrn.70.1598258537988;
 Mon, 24 Aug 2020 01:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597376585.git.huangqiwu@xiaomi.com> <ced256ea8ac2f3e54c33677facc4c2ef04dee643.1597376585.git.huangqiwu@xiaomi.com>
 <20200814060909.GD1409566@kroah.com> <CAPtXDt1e3fi7ymW0-FSknUAYCQ80aL=4btbeA2e4Xre7+e7OtA@mail.gmail.com>
 <20200818060707.GB1742213@kroah.com> <CAPtXDt26DdOi6JG7x3mTrR5YwArjkAeXY2TogRnK_xkSabhL2g@mail.gmail.com>
 <20200824074357.GB4133866@kroah.com>
In-Reply-To: <20200824074357.GB4133866@kroah.com>
From:   Qiwu Huang <yanziily@gmail.com>
Date:   Mon, 24 Aug 2020 16:42:06 +0800
Message-ID: <CAPtXDt0yW7Kh6a9JGfXaha_wKVjae7U74m6K=631Ofh8_m4uvg@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] power: supply: core: add quick charge type property
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qiwu Huang <huangqiwu@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 24, 2020 at 3:43 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Aug 24, 2020 at 08:54:56AM +0800, Qiwu Huang wrote:
> > On Tue, Aug 18, 2020 at 2:07 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Aug 18, 2020 at 09:56:28AM +0800, Qiwu Huang wrote:
> > > > On Fri, Aug 14, 2020 at 2:09 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Fri, Aug 14, 2020 at 11:46:54AM +0800, Qiwu Huang wrote:
> > > > > > From: Qiwu Huang <huangqiwu@xiaomi.com>
> > > > > >
> > > > > > Reports the kind of quick charge type based on
> > > > > > different adapter power.
> > > > > >
> > > > > > Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
> > > > > > ---
> > > > > >  Documentation/ABI/testing/sysfs-class-power | 21 +++++++++
> > > > > >  drivers/power/supply/power_supply_sysfs.c   |  1 +
> > > > > >  drivers/power/supply/qcom_smbb.c            | 51 +++++++++++++++++++++
> > > > > >  include/linux/power_supply.h                | 14 ++++++
> > > > > >  4 files changed, 87 insertions(+)
> > > > >
> > > > > You should also submit your driver that uses these new attributes at the
> > > > > same time.  What happened to that request?  Otherwise no one really
> > > > > knows how these are being used, or if they even are used by anyone.
> > > > >
> > > >
> > > > I don't think I can submit the whole driver because our drivers are
> > > > divided into three parts, the first part is in ADSP, the second part
> > > > is in kernel and the third part is in Android Hal.This is the second
> > > > part.
> > >
> > > WHat is "ADSP"?
> >
> > ADSP: advanced digital signal processor
>
> Ok, then just send the kernel driver.
>
> > > Just submit your kernel driver code, that's all we care about here.
> > > Userspace code is not anything we can do anything with :)
> >
> > If we ported the full driver, we would break the existing driver
> > structure because we would introduce more Qualcomm code. I think
> > that's an unreasonable change.
>
> That doesn't make much sense.  You have a working driver for these apis,
> just submit it for inclusion, it should never break any existing
> drivers, otherwise your code wouldn't work either.

We're an Android device, we're working on a Qualcomm based code, and
from the current code tree, the current code tree is missing the QTI
Charger code

>
> thanks,
>
> greg k-h



-- 
Thanks

Qiwu
