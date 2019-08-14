Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C15558DD19
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2019 20:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbfHNShV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Aug 2019 14:37:21 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:40546 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbfHNShS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Aug 2019 14:37:18 -0400
Received: by mail-ot1-f52.google.com with SMTP id c34so269070otb.7
        for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2019 11:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n1ZhkxlA5RiuxtYaWeDgg6qWaM8JmbM5adPrEVLQCaY=;
        b=mHFrTUKiPm4qyuo740JkJ7NzrjP6aZ05fw+cbk/S1SH/Xp8XRyb4Qr6JMvEHaqDpeb
         6k0m7zmpxIeHgqZ05hZyX5ciFz3Y1cfCb9EcgczR9hd2ZlCgcrE0EooCzT9ib+3XuG7D
         /hH9E0TM8qOyoW8OcZ+td0oBasB3IvuTybxtCcqufMHMhsFCL7bEy0eHDHp1PCBL7xKk
         kDsDdv+NHXzgr/G0Ue7HQpILnjPycMftf8nGNwLT0wie+5+X3GoK7WnnKmLXnKrecD32
         xVSfVhk0jJPLfG/CcjPSVLRxanongInZpzdKxAc6s1lKXNoimCvL6qIIguTYZ+5AxMW0
         hVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n1ZhkxlA5RiuxtYaWeDgg6qWaM8JmbM5adPrEVLQCaY=;
        b=spNMWHVVmhnFSusBjusKjOF3XZjrG4eoMEDsvhXKELNyJj3N95DeNkSkoxz4kcUZuV
         XVR7xxfaFSMx22i27+v4ljk2/mjkPgPPzEzwK2JtqABHQRD9ij8JxBa8xEVqkDoS6JVB
         BOSMBeOPH5YPJoUy0S3nwjCmjKzwDPRpyhFn5Pdhtp+LzC1wb6kEdqlfsrPJz8L8Napx
         0T2MElqpglxF0780ajRrD58h1qKulOopt9J9pQVKzaYLb6Xq8SxBA5BpZ7gy4xOp8hn0
         QKgYPx4rucZtsTzh2HCvCPMaT9KXUuN6TGBAgq8wKKoE6j4efq1tHHajQAkt12iI4Ltu
         SxMQ==
X-Gm-Message-State: APjAAAU/qa6i0f4Jl68CBi3svlsDhdpkG98Or3v4X8ZyrloYxqWwU2Rc
        9oy30iMgzWLDu93LsP8VgHLB3qf6GBFtM9gULP5gxA==
X-Google-Smtp-Source: APXvYqxbpuYpgfQERx/WDHl76hZenTI35Sh0ai+nP9DIPjQa3J7qJfNAG5EVro6PHqaavQ2NvV+TrvsE/9vX002QLeo=
X-Received: by 2002:a05:6830:13d9:: with SMTP id e25mr411557otq.197.1565807836826;
 Wed, 14 Aug 2019 11:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <1565731976.8572.16.camel@lca.pw> <5d53b238.1c69fb81.d3cd3.cd53@mx.google.com>
 <20190814084014.GB52127@atomide.com>
In-Reply-To: <20190814084014.GB52127@atomide.com>
From:   Tri Vo <trong@android.com>
Date:   Wed, 14 Aug 2019 11:37:05 -0700
Message-ID: <CANA+-vDeSAYUNfTQzQPT2N_CUgvYr6i_LP_BdHT_zX+FPt8NHg@mail.gmail.com>
Subject: Re: "PM / wakeup: Show wakeup sources stats in sysfs" causes boot warnings
To:     Tony Lindgren <tony@atomide.com>
Cc:     Stephen Boyd <swboyd@chromium.org>, Qian Cai <cai@lca.pw>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 14, 2019 at 1:40 AM Tony Lindgren <tony@atomide.com> wrote:
>
> * Stephen Boyd <swboyd@chromium.org> [691231 23:00]:
> > I also notice that device_set_wakeup_capable() has a check to see if the
> > device is registered yet and it skips creating sysfs entries for the
> > device if it isn't created in sysfs yet. Why? Just so it can be called
> > before the device is created? I guess the same logic is handled by
> > dpm_sysfs_add() if the device is registered after calling
> > device_set_wakeup_*().
>
> Hmm just guessing.. It's maybe because drivers can enable and disable
> the wakeup capability at any point for example like driver/net drivers
> do based on WOL etc?
>
> > There's two approaches I see:
> >
> >       1) Do a similar check for device_set_wakeup_enable() and skip
> >       adding the wakeup class until dpm_sysfs_add().
> >
> >       2) Find each case where this happens and only call wakeup APIs
> >       on the device after the device is added.
> >
> > I guess it's better to let devices have wakeup modified on them before
> > they're registered with the device core?
>
> I think we should at least initially handle case #1 above as multiple
> places otherwise seem to break. Then maybe we could add a warning to
> help fix all the #2 cases if needed?

Makes sense. For case#1, we could also just register the wakeup source
without specifying the parent device if the latter hasn't been
registered yet. Userspace won't be able to associate a wakeup source
to the parent device. But I think it's a reasonable fix, assuming we
want to fix devices not being added before calling wakeup APIs #2.
