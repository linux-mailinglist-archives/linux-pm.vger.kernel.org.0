Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBB581444
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 10:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfHEIcu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 04:32:50 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46176 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfHEIcu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Aug 2019 04:32:50 -0400
Received: by mail-ot1-f66.google.com with SMTP id z23so56111018ote.13;
        Mon, 05 Aug 2019 01:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zN5arBluSaU7iuMkb1bdkzd/J9ztzBg1fZtHM8/6PEw=;
        b=rOsWPRG/CSdeweQgt2Id0UaxTCZNcJT4KnwCxTHY5qNyWZRY4ANwyxqlpeYxvKBDeo
         5cMJp+uQVqrSZII/tpaOnjhf13UP3r+96Cp4P7LnWShaVWnwqHtzzKwplGCuppilobca
         1lPfT1/SaRa7fN1R+sFsWhaph3fa2MiA4QNppsgsc/YSfUdddcidUMPPGrY/GEc4mGba
         INkSwS2sJauZDMFM3AbsQ9ckOak6HdG+1s5qx3fy5/SCLmSa8wbaw36zDUQOP1rcFZAp
         LYzale9DriEbFELhDMYcfPJjyNB5ZjOIBoj17cbYha9JjaxVlZ07Gdh2k4HKQZxb/YH8
         VvJA==
X-Gm-Message-State: APjAAAXI9jju8BawSMnNZ4wRtS2TSnZ24SR9obcnA0a5BWOaTDf+X46A
        1XgcsfQ9DllmxrLzR2U863wjD7eFD6l562qOcio=
X-Google-Smtp-Source: APXvYqxi/zGwKaFeEyCdwqytMLCi1mCgwjaO4WgXUM53T9921kaMZ1kccxf7zKH1cxGKvNJhRPvfgPSROUeermemRI8=
X-Received: by 2002:a05:6830:1516:: with SMTP id k22mr106178174otp.189.1564993969706;
 Mon, 05 Aug 2019 01:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190731215514.212215-1-trong@android.com> <32598586.Mjd66ZhNnG@kreacher>
 <CANA+-vDTDq__LnLBpM5u_VHHvpFA--K5Du63vPB7HfaKzBsPtg@mail.gmail.com>
 <6987393.M0uybTKmdI@kreacher> <CANA+-vAPpXF1=z1=OjOhr8HWQ=Qn39qtQ3+8bUeXNTuFFTxoJQ@mail.gmail.com>
 <CAJZ5v0go-qOTyQV4D2Sj_xQxT831PxJZP0uay67rG73Q3K2pHQ@mail.gmail.com>
 <5d42281c.1c69fb81.bcda1.71f5@mx.google.com> <CANA+-vCoCuMtSKCfnav9NSwrzX7of9iLbppNX+pcymBp19kgQQ@mail.gmail.com>
 <5d434a23.1c69fb81.c4201.c65b@mx.google.com> <CANA+-vCt3QJDykzbZWBDZyaiaMiz_SOJ+Htv7+G0czjL07MjmQ@mail.gmail.com>
 <CAJZ5v0ioPioGBNBjiK-i5eydT9AGU3JvOBAy8L0zvs3kQNF35Q@mail.gmail.com> <CANA+-vDYh4a74ve1NZkybbcqpQZK-8tTGVK6+Nqgv0yvqg-Dgg@mail.gmail.com>
In-Reply-To: <CANA+-vDYh4a74ve1NZkybbcqpQZK-8tTGVK6+Nqgv0yvqg-Dgg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 5 Aug 2019 10:32:35 +0200
Message-ID: <CAJZ5v0hJ4O53VG4GbdU7fibWFx2Lx_oUkfV1te8iZRAyBbEk8A@mail.gmail.com>
Subject: Re: [PATCH v6] PM / wakeup: show wakeup sources stats in sysfs
To:     Tri Vo <trong@android.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
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

On Sun, Aug 4, 2019 at 12:40 AM Tri Vo <trong@android.com> wrote:
>
> On Thu, Aug 1, 2019 at 3:10 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Aug 1, 2019 at 11:45 PM Tri Vo <trong@android.com> wrote:
> > >
> > > On Thu, Aug 1, 2019 at 1:23 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > >
> > > > Quoting Tri Vo (2019-08-01 12:50:25)
> > > > > On Wed, Jul 31, 2019 at 4:45 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > > > >
> > > > > > Quoting Rafael J. Wysocki (2019-07-31 16:10:38)
> > > > > > > On Thu, Aug 1, 2019 at 12:59 AM Tri Vo <trong@android.com> wrote:
> > > > > > > >
> > > > > > > > >
> > > > > > > > > So why wouldn't something like this suffice:
> > > > > > > > >
> > > > > > > > > dev = device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), ws,
> > > > > > > > >                                 wakeup_source_groups, "wakeup:%s", ws->name);
> > > > > > > > >
> > > > > > > > > ?
> > > > > > > >
> > > > > > > > ws->name is inherited from the device name. IIUC device names are not
> > > > > > > > guaranteed to be unique. So if different devices with the same name
> > > > > > > > register wakeup sources, there is an error.
> > > > > > >
> > > > > > > OK
> > > > > > >
> > > > > > > So I guess the names are retained for backwards compatibility with
> > > > > > > existing user space that may be using them?
> > > > > > >
> > > > > > > That's kind of fair enough, but having two different identification
> > > > > > > schemes for wakeup sources will end up confusing.
> > > > > >
> > > > > > I understand your concern about the IDA now. Thanks for clarifying.
> > > > > >
> > > > > > How about we name the devices 'wakeupN' with the IDA when they're
> > > > > > registered with a non-NULL device pointer and then name them whatever
> > > > > > the name argument is when the device pointer is NULL. If we have this,
> > > > > > we should be able to drop the name attribute in sysfs and figure out the
> > > > > > name either by looking at the device name in /sys/class/wakeup/ if it
> > > > > > isn't 'wakeupN', or follow the symlink to the device in /sys/devices/
> > > > > > and look at the parent device name there.
> > > > >
> > > > > This makes it difficult for userspace to query the name a wakeup
> > > > > source, as it now has to first figure out if a wakeup source is
> > > > > associated with a device or not. The criteria for that is also
> > > > > awkward, userspase has to check if directory path contains "wakeupN",
> > > > > then it's a virtual wakeup source.
> > > >
> > > > I think you mean if it doesn't match wakeupN then it's a virtual wakeup
> > > > source?
> > >
> > > Yes
> > > >
> > > > >
> > > > > IMO it's cleaner to consistently have /sys/class/wakeup/wakeupN/name
> > > > > for every wakeup source.
> > > >
> > > > I don't find it awkward or difficult. Just know what the name of the
> > > > /sys/class/wakeup/ path is and then extract the name from there if it
> > > > doesn't match wakeupN, otherwise read the 'device' symlink and run it
> > > > through basename.
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
> > OK, whatever.
> >
> > Let's use the IDA as originally proposed and retain the names for
> > backwards compatibility only.
> >
> > Maybe just allocate the ID at the wakeup source object creation time
> > already (ISTR that you did that before attempting to create a virtual
> > device for the wakeup source).
>
> Yes, allocating the ID when creating the wakeup source object makes
> sense. However, kernel/power/wakelock.c allocates its wakeup sources
> manually. I imagine we don't want these IDs to be created in more than
> one place.

No, we don't.

> Making wakelock.c only use wakeup_source_*() family of functions when
> dealing with wakeup sources  might be a worthwhile change though. Then
> we won't have to worry about ID allocation in wakelock.c. WDYT?

Sounds reasonable to me.

> Also, it sounds like we all agree with "/sys/class/wakeup/wsN/" path
> and "/sys/class/wakeup/wsN/name" attribute for each wakeup source,
> right?

Generally yes, but please make it "wakeupN".
