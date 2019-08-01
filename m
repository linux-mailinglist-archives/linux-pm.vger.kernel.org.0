Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7677E5EF
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2019 00:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390014AbfHAWox (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Aug 2019 18:44:53 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34618 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390012AbfHAWox (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Aug 2019 18:44:53 -0400
Received: by mail-oi1-f196.google.com with SMTP id l12so55328857oil.1
        for <linux-pm@vger.kernel.org>; Thu, 01 Aug 2019 15:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z19NwBBdlIkZbbmAdrU9bSR86zfLlrJIzkv4N57qplI=;
        b=k32ozRW15p+q3FqanD6ih08gd2KoUftSnAlKaDETCL8bT79KMYjAZj2SCzlsv9lwm1
         KG2PG9tOJKVdogB3N1ZiDEW9/0oXpC0t0qjHboE4/UCexMg6vA3DLYuldrIBqTnoSUBq
         1YVpGFsFiW8Sg49HO5nUf9TGa70p5SGi1l9tlndyN6H7Iv/jojiymW+w78CeU4kCOIaW
         SzSYN94Vp+Sq7vzLl0nTaa1rwtppnFCi26XgKbVPEWeyC6PAjvAC4vVCi1wa/zAWMksU
         Cyx9WvHiO6ZZhnNZHARfrtxF4AWgZkmY+RFkTB2N6UpiiDOXPd/NUFviWIEKl0W8WfGQ
         VI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z19NwBBdlIkZbbmAdrU9bSR86zfLlrJIzkv4N57qplI=;
        b=nbLed+J+WT8PkGYfHms8g9Tq9It5wf2IS7x/VuNXL+AMzv2dIuv5zTdZ+2+kiBlvwe
         mkxKjB/cuUYx2hIwYHHCJvUKHX2b0wEB2iX7dir27Bdbwyvec++aHUQJHGno+wrE/hYx
         f08AxUT3VezQNjjPXLhbxLjNrE1VmAY9Hz71nDeWhHRcP/f14PuLrbyLoZxMRDs/KVHU
         //JpcdmghzvXxcwUB6cYTs7szdmniaVGK2kncRqy9s4y7SZEpXNCFlAxsR08jGt2WhSv
         QNv4AB6Xe13E/XvAbCPs6xKiP+2r/m7eOdVtRsaX1yG1i2zr6BgK2lb+ObwqbGfOTZqP
         4YZw==
X-Gm-Message-State: APjAAAUNfPvdFiUz9syLHg+70YYHJbWAD6pLtIVfGaj42WNb00mxHFAF
        eq6KNrlrrKrIRBO4FOd+Vqu8YoPTbul1g6mt1Zkdtw==
X-Google-Smtp-Source: APXvYqzL6Tgyg2JWP92iL6t03/Io4jUVU0O6z3DswEQ2kaYVSaQlvoL2++34ELuEnWw6x6VL/opZYgm88z8ZoUdO8v4=
X-Received: by 2002:aca:af55:: with SMTP id y82mr759314oie.172.1564699491791;
 Thu, 01 Aug 2019 15:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190731215514.212215-1-trong@android.com> <32598586.Mjd66ZhNnG@kreacher>
 <CANA+-vDTDq__LnLBpM5u_VHHvpFA--K5Du63vPB7HfaKzBsPtg@mail.gmail.com>
 <6987393.M0uybTKmdI@kreacher> <CANA+-vAPpXF1=z1=OjOhr8HWQ=Qn39qtQ3+8bUeXNTuFFTxoJQ@mail.gmail.com>
 <CAJZ5v0go-qOTyQV4D2Sj_xQxT831PxJZP0uay67rG73Q3K2pHQ@mail.gmail.com>
 <5d42281c.1c69fb81.bcda1.71f5@mx.google.com> <CANA+-vCoCuMtSKCfnav9NSwrzX7of9iLbppNX+pcymBp19kgQQ@mail.gmail.com>
 <5d434a23.1c69fb81.c4201.c65b@mx.google.com> <CANA+-vCt3QJDykzbZWBDZyaiaMiz_SOJ+Htv7+G0czjL07MjmQ@mail.gmail.com>
 <5d4363ae.1c69fb81.b621e.65ed@mx.google.com>
In-Reply-To: <5d4363ae.1c69fb81.b621e.65ed@mx.google.com>
From:   Tri Vo <trong@android.com>
Date:   Thu, 1 Aug 2019 15:44:40 -0700
Message-ID: <CANA+-vBi6j5FSsfdqNZ7zQmH2OzsAEMyz=39-y-ygagscR7ZEA@mail.gmail.com>
Subject: Re: [PATCH v6] PM / wakeup: show wakeup sources stats in sysfs
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 1, 2019 at 3:11 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Tri Vo (2019-08-01 14:44:52)
> > On Thu, Aug 1, 2019 at 1:23 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > >
> > > I don't find it awkward or difficult. Just know what the name of the
> > > /sys/class/wakeup/ path is and then extract the name from there if it
> > > doesn't match wakeupN, otherwise read the 'device' symlink and run it
> > > through basename.
> >
> > The concern was that having both "id" and "name" around might be
> > confusing. I don't think that making the presence of "name"
> > conditional helps here. And we have to maintain additional logic in
> > both kernel and userspace to support this.
> >
> > Also, say, userspace grabs a wakelock named "wakeup0". In the current
> > patch, this results in a name collision and an error. Even assuming
> > that userspace doesn't have ill intent, it still needs to be aware of
> > "wakeupN" naming pattern to avoid this error condition.
> >
> > All wakeup sources in the /sys/class/wakeup/ are in the same namespace
> > regardless of where they originate from, i.e. we have to either (1)
> > inspect the name of a wakeup source and make sure it's unique before
> > using it as a directory name OR (2) generate the directory name on
> > behalf of whomever is registering a wakeup source, which I think is a
> > much simpler solution.
>
> Ok. If the device name is going to be something generic like 'wakeupN',
> then we need to make sure that the wakeup source name is unique.

If we could easily make sure that wakeup source names are unique, then
we wouldn't need to generate "wakeupN" ids :)

> Otherwise, I'm not able to see how userspace will differentiate between
> two of the same named wakelocks. Before this patch the wakeup source
> name looks to have been used for debugging, but now it's being used
> programmatically to let userspace act upon it somehow. Maybe it's for
> debug still, but I could see how userspace may want to hunt down the
> wakelock that's created in userspace and penalize or kill the task
> that's waking up the device.

Two wakelocks can't have the same name. So they are still
distinguishable from userspace. However, there is still no way to
figure out from userspace which process created which wake lock.
That's a weakness of /sys/power/wake_lock API, independent of this
patch.
>
> I see that wakelock_lookup_add() already checks the list of wakelock
> wakeup sources, but I don't see how I can't create an "alarmtimer"
> wakelock again, but this time for userspace, by writing into
> /sys/power/wake_lock.

Behind the scenes, writing "alarmtimer" to /sys/power/wake_lock
creates a wakeup source named "alarmtimer", which in turn creates a
directory /sys/class/wakeup/alarmtimer (in you patch), which is likely
already created by alarmtimer. This leads to an error. The error is
resolved if wakeup source's sysfs entry is /sys/class/wakeup/wakeupN
instead.
>
> What happens with namespaces here BTW? Can a wakelock be made in one
> namespace and that is the same name as another wakelock in a different
> namespace? Right now it doesn't look possible because of the global name
> matching, but it probably makes sense to support this? Maybe we just
> shouldn't make anything in sysfs for wake sources that can be any random
> name created from the wakelock path right now. I don't see how it can be
> traced back to the process that created it in any reasonable way.

It should be OK if we don't use the arbitrary wakelock name in the
path, but instead use the generated id "wakeupN".
