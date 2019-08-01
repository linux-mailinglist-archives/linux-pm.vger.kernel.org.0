Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFBA7E537
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2019 00:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389353AbfHAWKO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Aug 2019 18:10:14 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43656 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731606AbfHAWKO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Aug 2019 18:10:14 -0400
Received: by mail-ot1-f66.google.com with SMTP id j11so18704982otp.10;
        Thu, 01 Aug 2019 15:10:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=icGQ7KbXQOBn9ZuqWfvGCA7fdSC9Cq3WEqhHvcvzjCk=;
        b=Yh6GuWlKshm/HjqJVrJn/7odRseVGJO3hFLGiL5/7O2+GpI22X9ss6nLTtQhTEsjXI
         88lYyNXA217f6zEy6pHI6cjskz1vUl17eg0Eie1A1zyoi+rjetMoGnmw1W4U9IkJIhBz
         Q/7NKw447ygHDggeAgsvI1hjapHx+cYmGGwLeO6PnlEifeg5CS0IEEOg8SoDfxlPwU4g
         9jz4j02sp3OJ9bwBAGKe/gwms5SFN3WZeFnH3R8l20rJ015qDzLJMHrBS1jDFB/QAcZf
         FZZQcgZV3COnSBye6W1mQbGy+16+jBfpYOrqyjcd2bl9xGbCyZIoT98NSJ7G/877zNiW
         o7ug==
X-Gm-Message-State: APjAAAUcYgZ34sPnzlogTZEGQh1w1Zwlcb33XlwZkID7vxdYKoyXsd1U
        miYLbPbZHbeAlvtyaProlL0Fdjp6siRczhnJphw=
X-Google-Smtp-Source: APXvYqwEvtyrpT6/CM38Bf5IVR9zJg5hy7k0mY9PrXRB7P8CiwmEgr1lsJHCmoN2LyeQXTb/1Y9df2KfbocHQD87lg8=
X-Received: by 2002:a9d:6b96:: with SMTP id b22mr29585963otq.262.1564697413585;
 Thu, 01 Aug 2019 15:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190731215514.212215-1-trong@android.com> <32598586.Mjd66ZhNnG@kreacher>
 <CANA+-vDTDq__LnLBpM5u_VHHvpFA--K5Du63vPB7HfaKzBsPtg@mail.gmail.com>
 <6987393.M0uybTKmdI@kreacher> <CANA+-vAPpXF1=z1=OjOhr8HWQ=Qn39qtQ3+8bUeXNTuFFTxoJQ@mail.gmail.com>
 <CAJZ5v0go-qOTyQV4D2Sj_xQxT831PxJZP0uay67rG73Q3K2pHQ@mail.gmail.com>
 <5d42281c.1c69fb81.bcda1.71f5@mx.google.com> <CANA+-vCoCuMtSKCfnav9NSwrzX7of9iLbppNX+pcymBp19kgQQ@mail.gmail.com>
 <5d434a23.1c69fb81.c4201.c65b@mx.google.com> <CANA+-vCt3QJDykzbZWBDZyaiaMiz_SOJ+Htv7+G0czjL07MjmQ@mail.gmail.com>
In-Reply-To: <CANA+-vCt3QJDykzbZWBDZyaiaMiz_SOJ+Htv7+G0czjL07MjmQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Aug 2019 00:10:02 +0200
Message-ID: <CAJZ5v0ioPioGBNBjiK-i5eydT9AGU3JvOBAy8L0zvs3kQNF35Q@mail.gmail.com>
Subject: Re: [PATCH v6] PM / wakeup: show wakeup sources stats in sysfs
To:     Tri Vo <trong@android.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
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

On Thu, Aug 1, 2019 at 11:45 PM Tri Vo <trong@android.com> wrote:
>
> On Thu, Aug 1, 2019 at 1:23 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Tri Vo (2019-08-01 12:50:25)
> > > On Wed, Jul 31, 2019 at 4:45 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > >
> > > > Quoting Rafael J. Wysocki (2019-07-31 16:10:38)
> > > > > On Thu, Aug 1, 2019 at 12:59 AM Tri Vo <trong@android.com> wrote:
> > > > > >
> > > > > > >
> > > > > > > So why wouldn't something like this suffice:
> > > > > > >
> > > > > > > dev = device_create_with_groups(wakeup_class, parent, MKDEV(0, 0), ws,
> > > > > > >                                 wakeup_source_groups, "wakeup:%s", ws->name);
> > > > > > >
> > > > > > > ?
> > > > > >
> > > > > > ws->name is inherited from the device name. IIUC device names are not
> > > > > > guaranteed to be unique. So if different devices with the same name
> > > > > > register wakeup sources, there is an error.
> > > > >
> > > > > OK
> > > > >
> > > > > So I guess the names are retained for backwards compatibility with
> > > > > existing user space that may be using them?
> > > > >
> > > > > That's kind of fair enough, but having two different identification
> > > > > schemes for wakeup sources will end up confusing.
> > > >
> > > > I understand your concern about the IDA now. Thanks for clarifying.
> > > >
> > > > How about we name the devices 'wakeupN' with the IDA when they're
> > > > registered with a non-NULL device pointer and then name them whatever
> > > > the name argument is when the device pointer is NULL. If we have this,
> > > > we should be able to drop the name attribute in sysfs and figure out the
> > > > name either by looking at the device name in /sys/class/wakeup/ if it
> > > > isn't 'wakeupN', or follow the symlink to the device in /sys/devices/
> > > > and look at the parent device name there.
> > >
> > > This makes it difficult for userspace to query the name a wakeup
> > > source, as it now has to first figure out if a wakeup source is
> > > associated with a device or not. The criteria for that is also
> > > awkward, userspase has to check if directory path contains "wakeupN",
> > > then it's a virtual wakeup source.
> >
> > I think you mean if it doesn't match wakeupN then it's a virtual wakeup
> > source?
>
> Yes
> >
> > >
> > > IMO it's cleaner to consistently have /sys/class/wakeup/wakeupN/name
> > > for every wakeup source.
> >
> > I don't find it awkward or difficult. Just know what the name of the
> > /sys/class/wakeup/ path is and then extract the name from there if it
> > doesn't match wakeupN, otherwise read the 'device' symlink and run it
> > through basename.
>
> The concern was that having both "id" and "name" around might be
> confusing. I don't think that making the presence of "name"
> conditional helps here. And we have to maintain additional logic in
> both kernel and userspace to support this.
>
> Also, say, userspace grabs a wakelock named "wakeup0". In the current
> patch, this results in a name collision and an error. Even assuming
> that userspace doesn't have ill intent, it still needs to be aware of
> "wakeupN" naming pattern to avoid this error condition.
>
> All wakeup sources in the /sys/class/wakeup/ are in the same namespace
> regardless of where they originate from, i.e. we have to either (1)
> inspect the name of a wakeup source and make sure it's unique before
> using it as a directory name OR (2) generate the directory name on
> behalf of whomever is registering a wakeup source, which I think is a
> much simpler solution.

OK, whatever.

Let's use the IDA as originally proposed and retain the names for
backwards compatibility only.

Maybe just allocate the ID at the wakeup source object creation time
already (ISTR that you did that before attempting to create a virtual
device for the wakeup source).
