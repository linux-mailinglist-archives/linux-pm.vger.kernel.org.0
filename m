Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2F5769E88
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2019 23:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732047AbfGOVsZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jul 2019 17:48:25 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35935 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731232AbfGOVsZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2019 17:48:25 -0400
Received: by mail-oi1-f193.google.com with SMTP id w7so13893686oic.3
        for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2019 14:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6e7DRMuQdVok4h9s3bFzY/fVAesWrHCG++TXs3wwJc=;
        b=b+RfaTs//kWIhveDSusgI4qjyvX0eUrbNXorBAg27bcO9UpmJ4T2qDep9avaJUwfT0
         kDsl4ZumaPNqw0I4YBrS5IYFs7EQ0wuzE7vNuHJlS2uF7TGlPuB637tG1TeAWyIvfr0c
         pgoY6TuZDTvWTjE1RXRX7i/OB/omeFq2khiE7Md2ZgKF/7ZpBpZMXp5f696nB/um3kHH
         smsCwp1vvsLFB+dxz3LlQoeg9++1+xgff51PUlsDp7OLXqD9qfRSTgIYtx5ahOx6/qqe
         8VBAMiFgtbMey8lFx4HCeQ0hOruTIX4l1lqLgEQnNkJS3n3AqxsHc/mPiYs51Bi45pnb
         2T9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6e7DRMuQdVok4h9s3bFzY/fVAesWrHCG++TXs3wwJc=;
        b=RIm6xIru+ln+isW8c099ZmttZpTkhSmClZPyfliKD/vHtoH9hgKeM99APQQcOrCYjH
         t1Z0MGRkhW6prQKMXMh++iAY1tRX6fRH3ngUx8OLtFXqYS2kk/uf/CBpPEj/FfNmSLeD
         4pDH6pCR/A81Me7oV1iWrDj2mlvCHCcVDtZ1XmRFzuQW0mz4We4kFrmHkkrv+l+KsDDr
         sz5NwDSvmJLFjE3wcNMtEzhGpI4q+zfJK3icDbTspHLXhCULnz0D27CKMb2ZX1n4yKe3
         TMu17Cohm4neqqaYnilY/40zllO0OlwHa/ABb+QJ7xLDH+XRWNI1g5rPaSXo18ipGpDz
         sjDQ==
X-Gm-Message-State: APjAAAXLBbJEYOqomaxy+AE0vcsBw+wwti/NUM8QX2e4TyBGPFrkGUU7
        zAGSFTqA+3WyEcdgNWjQpw7a+5r6Xr88WVwkBNY=
X-Google-Smtp-Source: APXvYqw9dke1ghFxnHX6HAV2lmdw3RdzqwaSF9V28TbiYgFTCr6s6WN4r5ruqE3Ue2Mqdc0xMnuCjFZwdezWm01SCQk=
X-Received: by 2002:aca:3509:: with SMTP id c9mr15286738oia.179.1563227304035;
 Mon, 15 Jul 2019 14:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <CANA+-vAxU5jp6PQ26NU+UMc6iyw6KkBS9nbd6wj0qqkO-1WhYg@mail.gmail.com>
 <20190715201116.221078-1-trong@android.com> <20190715203651.GA7513@kroah.com>
In-Reply-To: <20190715203651.GA7513@kroah.com>
From:   Tri Vo <trong@android.com>
Date:   Mon, 15 Jul 2019 14:48:13 -0700
Message-ID: <CANA+-vC+_Gp4RwdLH_XYDAepRONB66PdekvaCxNT3ZVGx73G6A@mail.gmail.com>
Subject: Re: [PATCH v3] PM / wakeup: show wakeup sources stats in sysfs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>, kaleshsingh@google.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 15, 2019 at 1:37 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 15, 2019 at 01:11:16PM -0700, Tri Vo wrote:
> > Userspace can use wakeup_sources debugfs node to plot history of suspend
> > blocking wakeup sources over device's boot cycle. This information can
> > then be used (1) for power-specific bug reporting and (2) towards
> > attributing battery consumption to specific processes over a period of
> > time.
> >
> > However, debugfs doesn't have stable ABI. For this reason, create a
> > 'struct device' to expose wakeup sources statistics in sysfs under
> > /sys/class/wakeup/<name>/.
> >
> > Introduce CONFIG_PM_SLEEP_STATS that enables/disables showing wakeup
> > source statistics in sysfs.
> >
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Tri Vo <trong@android.com>
> > Tested-by: Tri Vo <trong@android.com>
>
> Co-Developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> perhaps given that I rewrote the whole file last time?  :)

Thanks again for the help!
>
>
> > ---
> >  Documentation/ABI/testing/sysfs-power |  73 ++++++++++++-
> >  drivers/base/power/Makefile           |   1 +
> >  drivers/base/power/wakeup.c           |  12 ++-
> >  drivers/base/power/wakeup_stats.c     | 148 ++++++++++++++++++++++++++
> >  include/linux/pm_wakeup.h             |  19 ++++
> >  kernel/power/Kconfig                  |  10 ++
> >  kernel/power/wakelock.c               |  10 ++
> >  7 files changed, 270 insertions(+), 3 deletions(-)
> >  create mode 100644 drivers/base/power/wakeup_stats.c
>
> What changed from v2?  :)

Oops, my bad.

> And I am guessing that you actually tested this all out, and it works
> for you?

Yes, I played around with wakelocks to make sure that wakeup source
stats are added/updated/removed as expected.

> Have you changed Android userspace to use the new api with no
> problems?

Kalesh helped me test this patch (added him in Tested-by: field in
latest patch version). We haven't tested beyond booting and manual
inspection on android devices. Android userspace changes should be
fairly trivial though.
