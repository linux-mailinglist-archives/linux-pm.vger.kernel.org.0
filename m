Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1D17E672
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2019 01:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388202AbfHAXhr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Aug 2019 19:37:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33946 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731340AbfHAXhr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Aug 2019 19:37:47 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so28823153pgc.1
        for <linux-pm@vger.kernel.org>; Thu, 01 Aug 2019 16:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=He4srDDjR3eOu8dQvJpFAh9KJKFadcANypNWpSDxupI=;
        b=gGahkqEiD/gwzpQjrecPFZNK1Ra8oEc+fPFsOzTWK9BmHydhFK1WTpcp0YfWW4ouA0
         noYn7SXtOWsQ3oGfWVJH+9N0HYhOrI/n0fLRo3szqgjd1MheOtz+5YzQu0CdTstNpEYi
         dfCXmGxaRKlbWJMLj/JEwVkxTmOTjNj3ma03k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=He4srDDjR3eOu8dQvJpFAh9KJKFadcANypNWpSDxupI=;
        b=BpbLGxpM7XKuh7B5Wjw0cP+GVVgQxAss1lx2sGtc0lLXVAK3AqDXJftcqMn/0dHksL
         3mWdQ4FoLnjhbaioB2GD43rahMla3lp0gUpkBehFw9nkN2/cL3IYIsKI83Yyv7yarmU5
         EQVzCmL50PIkIS4w0iXRPhehvzxgLBkBkyzO9H1YgQRtdFKZebyMjBROOLHfPH4TPzip
         qzRWAYI2f6sKNNqdMcj3fOP5iIP9UCzVlVAfk+W/rKsM2N/SSMD7eNB6P4cn/6eByo2c
         2Tr4imvea21WpUZ6IIznZglCS/aJNwtgYo2BVkxjyKUzj8yamPY1xMHgd7049ZSQqFM9
         Hi8A==
X-Gm-Message-State: APjAAAVpdHu4+A5T+AU1T/016A1z9JqqFU0rI1jvVuVnM9az0qJqrT/5
        YElMHjkfMnAgWVWUPD6QyouoPQ==
X-Google-Smtp-Source: APXvYqyCCWV1uR5H76mBpc5BuNYcsfoZX5cMSV+YgGnyn2ehfNLs7DPOdgwIjGme5n0bE5T+Y8fcqw==
X-Received: by 2002:aa7:858b:: with SMTP id w11mr53899119pfn.68.1564702666329;
        Thu, 01 Aug 2019 16:37:46 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id o14sm152127614pfh.153.2019.08.01.16.37.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 16:37:45 -0700 (PDT)
Message-ID: <5d4377c9.1c69fb81.f1307.7bc5@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANA+-vBi6j5FSsfdqNZ7zQmH2OzsAEMyz=39-y-ygagscR7ZEA@mail.gmail.com>
References: <20190731215514.212215-1-trong@android.com> <6987393.M0uybTKmdI@kreacher> <CANA+-vAPpXF1=z1=OjOhr8HWQ=Qn39qtQ3+8bUeXNTuFFTxoJQ@mail.gmail.com> <CAJZ5v0go-qOTyQV4D2Sj_xQxT831PxJZP0uay67rG73Q3K2pHQ@mail.gmail.com> <5d42281c.1c69fb81.bcda1.71f5@mx.google.com> <CANA+-vCoCuMtSKCfnav9NSwrzX7of9iLbppNX+pcymBp19kgQQ@mail.gmail.com> <5d434a23.1c69fb81.c4201.c65b@mx.google.com> <CANA+-vCt3QJDykzbZWBDZyaiaMiz_SOJ+Htv7+G0czjL07MjmQ@mail.gmail.com> <5d4363ae.1c69fb81.b621e.65ed@mx.google.com> <CANA+-vBi6j5FSsfdqNZ7zQmH2OzsAEMyz=39-y-ygagscR7ZEA@mail.gmail.com>
Subject: Re: [PATCH v6] PM / wakeup: show wakeup sources stats in sysfs
From:   Stephen Boyd <swboyd@chromium.org>
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
To:     Tri Vo <trong@android.com>
User-Agent: alot/0.8.1
Date:   Thu, 01 Aug 2019 16:37:44 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Tri Vo (2019-08-01 15:44:40)
> On Thu, Aug 1, 2019 at 3:11 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Tri Vo (2019-08-01 14:44:52)
> > >
> > > The concern was that having both "id" and "name" around might be
> > > confusing. I don't think that making the presence of "name"
> > > conditional helps here. And we have to maintain additional logic in
> > > both kernel and userspace to support this.
> > >
> > > Also, say, userspace grabs a wakelock named "wakeup0". In the current
> > > patch, this results in a name collision and an error. Even assuming
> > > that userspace doesn't have ill intent, it still needs to be aware of
> > > "wakeupN" naming pattern to avoid this error condition.
> > >
> > > All wakeup sources in the /sys/class/wakeup/ are in the same namespace
> > > regardless of where they originate from, i.e. we have to either (1)
> > > inspect the name of a wakeup source and make sure it's unique before
> > > using it as a directory name OR (2) generate the directory name on
> > > behalf of whomever is registering a wakeup source, which I think is a
> > > much simpler solution.
> >
> > Ok. If the device name is going to be something generic like 'wakeupN',
> > then we need to make sure that the wakeup source name is unique.
>=20
> If we could easily make sure that wakeup source names are unique, then
> we wouldn't need to generate "wakeupN" ids :)

It's not hard to make sure the device names are unique, we just use an
IDA and we're done. The problem is making it easy for the user to
understand what wakeup source it is. If the ws->name is duplicated that
is harder. It's an orthogonal problem.

>=20
> > Otherwise, I'm not able to see how userspace will differentiate between
> > two of the same named wakelocks. Before this patch the wakeup source
> > name looks to have been used for debugging, but now it's being used
> > programmatically to let userspace act upon it somehow. Maybe it's for
> > debug still, but I could see how userspace may want to hunt down the
> > wakelock that's created in userspace and penalize or kill the task
> > that's waking up the device.
>=20
> Two wakelocks can't have the same name. So they are still
> distinguishable from userspace. However, there is still no way to
> figure out from userspace which process created which wake lock.
> That's a weakness of /sys/power/wake_lock API, independent of this
> patch.

Even without knowing the process, we can have a problem if kernelspace
makes the same named wake source as one made in userspace through the
wakelock APIs. We won't be able to distinguish the two. Sounds like
we've never had this problem though, so I guess we ignore it.

> >
> > I see that wakelock_lookup_add() already checks the list of wakelock
> > wakeup sources, but I don't see how I can't create an "alarmtimer"
> > wakelock again, but this time for userspace, by writing into
> > /sys/power/wake_lock.
>=20
> Behind the scenes, writing "alarmtimer" to /sys/power/wake_lock
> creates a wakeup source named "alarmtimer", which in turn creates a
> directory /sys/class/wakeup/alarmtimer (in you patch), which is likely
> already created by alarmtimer. This leads to an error. The error is
> resolved if wakeup source's sysfs entry is /sys/class/wakeup/wakeupN
> instead.

Right.

> >
> > What happens with namespaces here BTW? Can a wakelock be made in one
> > namespace and that is the same name as another wakelock in a different
> > namespace? Right now it doesn't look possible because of the global name
> > matching, but it probably makes sense to support this? Maybe we just
> > shouldn't make anything in sysfs for wake sources that can be any random
> > name created from the wakelock path right now. I don't see how it can be
> > traced back to the process that created it in any reasonable way.
>=20
> It should be OK if we don't use the arbitrary wakelock name in the
> path, but instead use the generated id "wakeupN".

I'm more concerned about namespaces in general and how the wake_lock
file in sysfs is supposed to work with it. It sounds like it just
doesn't work and userspace has to be careful to not reuse the same name
for some sort of wakelock and sit some daemon on top of the kernel
interface.

