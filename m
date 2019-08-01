Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E02737E5F3
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2019 00:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732268AbfHAWqq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Aug 2019 18:46:46 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42294 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732187AbfHAWqp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Aug 2019 18:46:45 -0400
Received: by mail-ot1-f67.google.com with SMTP id l15so76089427otn.9;
        Thu, 01 Aug 2019 15:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6/A0oFUJlLeWDW4iRfhcabTxuKQ2E0T/S9GKqy4yr6w=;
        b=BRFT8UXsCmKc+OO2lHbV7mRLsfKRHlLFZnfbx3esM7Tvh0DSSG/njPGNhXFfdLtinR
         H3CujCvYD6Fz3mUajjZiESx/yrdDpVbK2GI38lybPxxDQM4vYVAU4r2PsWUTRUkviw8l
         e/09PQF21TUdQhvCLemgvD0S1RLprfovxqdWzRpUHfywYIl+rW3lZAzjY+PdFO2YOBPd
         1TDEFK6hH4ApoOd9805eegNx7+op9SNenBQ33FywpxwB01QMsvXFuDWR/ycGxVIAmsr1
         NdKkofCQ5DCnQYi1kYb6lEIyHQbJHjJnVLaOU98yxi9JKSAmgH7difzC9kxvUSFifhNV
         qLHA==
X-Gm-Message-State: APjAAAU5p098XhP2NOzaHG71tauh/i8/93cn5+sD5l4vJSSy9kS3VI4P
        q3Sxquz8yhmZmTjZmczkYibAIWHkgrhmqDbASJfAIg==
X-Google-Smtp-Source: APXvYqxSnifKD3zLTP20OF59FU7o3QBu7uY673X7OYVYnL7YJ6f84BMO1+q791T5S82mWIpAvyCQnCeyFRFn0MrxQMs=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr92227045otp.189.1564699604701;
 Thu, 01 Aug 2019 15:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190731215514.212215-1-trong@android.com> <32598586.Mjd66ZhNnG@kreacher>
 <CANA+-vDTDq__LnLBpM5u_VHHvpFA--K5Du63vPB7HfaKzBsPtg@mail.gmail.com>
 <6987393.M0uybTKmdI@kreacher> <CANA+-vAPpXF1=z1=OjOhr8HWQ=Qn39qtQ3+8bUeXNTuFFTxoJQ@mail.gmail.com>
 <CAJZ5v0go-qOTyQV4D2Sj_xQxT831PxJZP0uay67rG73Q3K2pHQ@mail.gmail.com>
 <5d42281c.1c69fb81.bcda1.71f5@mx.google.com> <CANA+-vCoCuMtSKCfnav9NSwrzX7of9iLbppNX+pcymBp19kgQQ@mail.gmail.com>
 <5d434a23.1c69fb81.c4201.c65b@mx.google.com> <CANA+-vCt3QJDykzbZWBDZyaiaMiz_SOJ+Htv7+G0czjL07MjmQ@mail.gmail.com>
 <5d4363ae.1c69fb81.b621e.65ed@mx.google.com>
In-Reply-To: <5d4363ae.1c69fb81.b621e.65ed@mx.google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Aug 2019 00:46:33 +0200
Message-ID: <CAJZ5v0jTviWeJhrWHGrtQHrVXAPoHDyFs6-06paJPHX-mH33bg@mail.gmail.com>
Subject: Re: [PATCH v6] PM / wakeup: show wakeup sources stats in sysfs
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Tri Vo <trong@android.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Fri, Aug 2, 2019 at 12:11 AM Stephen Boyd <swboyd@chromium.org> wrote:
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
> Otherwise, I'm not able to see how userspace will differentiate between
> two of the same named wakelocks. Before this patch the wakeup source
> name looks to have been used for debugging, but now it's being used
> programmatically to let userspace act upon it somehow.

I'm not actually sure if this patch changes the situation with respect
to wakeup source names.   User space still can use them for whatever
it used to use the list in debugfs and that's it.

That's what I mean by retaining the names for "backwards compatibility only".

> Maybe it's for debug still, but I could see how userspace may want to hunt down the
> wakelock that's created in userspace and penalize or kill the task
> that's waking up the device.

It can't do that right now.

> I see that wakelock_lookup_add() already checks the list of wakelock
> wakeup sources, but I don't see how I can't create an "alarmtimer"
> wakelock again, but this time for userspace, by writing into
> /sys/power/wake_lock.
>
> What happens with namespaces here BTW? Can a wakelock be made in one
> namespace and that is the same name as another wakelock in a different
> namespace? Right now it doesn't look possible because of the global name
> matching, but it probably makes sense to support this? Maybe we just
> shouldn't make anything in sysfs for wake sources that can be any random
> name created from the wakelock path right now. I don't see how it can be
> traced back to the process that created it in any reasonable way.

It can't.

The assumption was that there would be a "manager" process in user
space controlling access to this interface and it would do its own
tracking.  That predated namespaces though. :-)
