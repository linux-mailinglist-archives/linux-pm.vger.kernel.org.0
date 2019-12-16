Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE4F31211D9
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 18:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfLPRiG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Dec 2019 12:38:06 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43492 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfLPRiG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Dec 2019 12:38:06 -0500
Received: by mail-ed1-f65.google.com with SMTP id dc19so5685821edb.10
        for <linux-pm@vger.kernel.org>; Mon, 16 Dec 2019 09:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xVlnYof8DAaJMRHdXncgMcLCmCDz89wZ5MrLVxQ3668=;
        b=HAHiU/kc9BQfdrXOTb0pMRjTabU4P0PmWnlzlisQntpft5CilOJkVVE7IcJVg98RjH
         bWfsVo3gXEEdXo9FdGEe673IK7QxlE04Pt2JpvnwkMy+4Ve/K5iL964X8BXxp1yM1yE1
         exZB1HR/sUSFn2j6Q2VMCmN7wHW01FELPG8dI81G8cyZ4QI7w/nMY1ATq0l4mXct3xDy
         0FnkKisTYJ1TnuViLD/MRgX1rULcbTRQz/szaWUy0/A8JrECubUlqnQSGF+YjnKCV7km
         SsBSDlLLJuJ1mUF498DRL/5os4ceOXuqIauEPIkB0H4bPQnCBEAB1UM97VpHIxiAViCo
         oCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xVlnYof8DAaJMRHdXncgMcLCmCDz89wZ5MrLVxQ3668=;
        b=AqxpwIpzuvjcW73iLLH3f0Tz3NWAXSDLBbVlrKk6pj3amJQTYBfI8+uzN90cWD4oFO
         6ZUS6G6rQDmWulXs+NgePgBGcXlFxJp67MaF2/lm8d9tIZyIZgfQDvKSW8sAUeGjxTG1
         u/2W20AWYC43bCk3eGNL2u511J5qM6uex230+WvjS9y9d4bKvELhqy1DGExC7XPHzK66
         vzcB9EV8omyhy+5GHz5dD2JIlJH55ctf0qzd5Xu+dAAQGnErvjYMN5QodPEWUqBC64WL
         mquyVh41yzife/FINaeMHUVsrH8tcfvv27JMtrvss2oBfg7DU1GWKMmmYfIIz6D8u8hL
         +/tQ==
X-Gm-Message-State: APjAAAWuntLmU5H98Sgr9syguZSphG7nCOSxR8yp/QQokZa5xltoinlj
        9w6bxT5hQ075B+pwWHj2fyveDNB3tdq/iWtpsj6Bag==
X-Google-Smtp-Source: APXvYqysiCNa0azfvSBojamdfWpsfsknwO5qk57jvmhj8OqnUfH2RsjfwFSonCxkgDmnYDE//B/LCVeGGDmnVkjXHPg=
X-Received: by 2002:a17:906:3149:: with SMTP id e9mr89943eje.292.1576517882853;
 Mon, 16 Dec 2019 09:38:02 -0800 (PST)
MIME-Version: 1.0
References: <20191205071953.121511-1-wvw@google.com> <69dd3a7a-c5fe-3ae7-8a4d-c3939870eed8@linaro.org>
 <CAGXk5yrsmvHK_xwvp_kFNmSqKOZ7Ef3HrVBHYDMBmDsCz0FNSQ@mail.gmail.com>
 <0603228e-5f0b-d335-30ce-67cf0626a489@linaro.org> <20191211085400.GB500800@kroah.com>
 <CAGXk5yrFp1eeeadhJar_qJqJ9G1q2mn+5m8JW4705ouQDLqzsw@mail.gmail.com>
 <f0ebc98d-25f2-6326-c0d8-8dda543c4091@linaro.org> <CAGXk5yosq5saYWdsz2k+uCYZ5CNTR4zNR2nB3H7-=TQs07u8Sw@mail.gmail.com>
 <20191215163422.GC9148@google.com>
In-Reply-To: <20191215163422.GC9148@google.com>
From:   Wei Wang <wvw@google.com>
Date:   Mon, 16 Dec 2019 09:37:50 -0800
Message-ID: <CAGXk5yoeRtOsQDOys20kJd5Wh-meMXdLe5JaCwiQGA-eWit-ow@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] thermal: introduce by-name softlink
To:     Sandeep Patil <sspatil@android.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Dec 15, 2019 at 8:34 AM Sandeep Patil <sspatil@android.com> wrote:
>
> Hi Wei,
>
> (resending because I accidentally replied only to you. Also adding everyo=
ne
> else back in the thread, not sure what happened before).
>
> On Wed, Dec 11, 2019 at 02:19:03PM -0800, Wei Wang wrote:
> > On Wed, Dec 11, 2019 at 1:11 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> > >
> > > On 11/12/2019 21:11, Wei Wang wrote:
> > > > On Wed, Dec 11, 2019 at 12:54 AM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > >>
> > > >> On Tue, Dec 10, 2019 at 09:54:11PM +0100, Daniel Lezcano wrote:
> > > >>> On 10/12/2019 21:01, Wei Wang wrote:
> > > >>>> On Tue, Dec 10, 2019 at 6:36 AM Daniel Lezcano
> > > >>>> <daniel.lezcano@linaro.org> wrote:
> > > >>>>>
> > > >>>>> On 05/12/2019 08:19, Wei Wang wrote:
> > > >>>>>> The paths thermal_zone%d and cooling_device%d are not intuitiv=
e and the
> > > >>>>>> numbers are subject to change due to device tree change. This =
usually
> > > >>>>>> leads to tree traversal in userspace code.
> > > >>
> > > >> tree traversal is supposed to be done in userspace code :)
> > > >>
> > > > Yes, that can be done in userspace, but given the amount of thermal
> > > > zones we have in some mobile devices, this will bring a lot of
> > > > convenience.
> > >
> > > But usually all these thermal zones are fixed and building the name<-=
>tz
> > > association is just a question of a few lines of code from userspace,
> > > no? What would be the benefit of adding more ABI?
> >
> >
> > code reuse as tz mapping is per device tree setup and we try to use
> > the same _type_  in thermal zone in shared client code for Android
> > thermal API.
>
> CMIIW, but the tz mapping today can still be done by parsing through the
> directory the other way? (i.e. tz->type) instead of type->tz?
>
Parsing can be done in clients, one particular place is for init, but
still possible.
https://cs.android.com/search?q=3Dtz-by-name%20file:%5C.rc
Yeah, as said, we can definitely do pasing in every userspace daemon,
but AFAICT, all userspace codes (open source / closed source) are
using thermal zones / cooling devices  by "name/type". So I am
probling the possibility of having this kind of support for
convenience.
FYI, Chrome also feel this is useful
https://lore.kernel.org/lkml/20191206191545.GO228856@google.com/

> Also, I understand the resistance to add a new ABI since it will have to =
be
> kept around forever. What would be worth knowing is if these mappings are
> static (built once) or you have to go through and parse the directories e=
very
> time? AFAIU, the parsing (map creation) seems to only happen once during
> boot, so we (Android) should be ok?
>
Those mapping are usually static nowadays, but could be changed if
modules are unloaded. Right now we only do UEVENT for userspace
governor,
https://github.com/torvalds/linux/blob/9c7db5004280767566e91a33445bf93aa479=
ef02/drivers/thermal/user_space.c#L37
Actually, I am about sending another RFC to add some more uevent to
userspace. Without the UEVENT, I think we cannot guarantee the mapping
is static.

> >
> > >
> > > If there is a thermal zone change, then a notification can be used, s=
o
> > > the userspace code rebuild the name<->tz, no?
> >
> >
> > Assuming you meant for type<->tz, this mapping won't change in runtime
> > in our case (not unloading things), but it could be changed due to
> > device tree change, e.g. adding/removing thermal zones.
>
> I actually think we might need this after all. This assumes all tz device=
s
> are registered when userspace (thermal hal/daemon) is coming up. However,
> that may soon not be the case and we have to adjust for devices being add=
ed
> in parallel with userspace?
>
> So, may be we need to start monitoring uevents like we do for power suppl=
ies
> too? In that case, the mapping can also be done dynamically.
>
> Lastly, I think we can make a case further if there are benefits we can s=
hare
> here other than convenience. Like startup time, handing hardware variatio=
ns
> etc? (Also point to the current userspace code that uses this)
>
I replied above before reading this part, and I guess we had the same
thought on this.

> - ssp
> >
> >
> > >
> > > > e.g. this is on Pixel 4 XL:
> > > > coral:/ # ls  /sys/devices/virtual/thermal/
> > > > cdev-by-name      cooling_device15  cooling_device22  cooling_devic=
e3
> > > >  cooling_device9  thermal_zone15  thermal_zone22  thermal_zone3
> > > > thermal_zone37  thermal_zone44  thermal_zone51  thermal_zone59
> > > > thermal_zone66  thermal_zone73  thermal_zone80  thermal_zone88
> > > > cooling_device0   cooling_device16  cooling_device23  cooling_devic=
e30
> > > >  thermal_zone0    thermal_zone16  thermal_zone23  thermal_zone30
> > > > thermal_zone38  thermal_zone45  thermal_zone52  thermal_zone6
> > > > thermal_zone67  thermal_zone74  thermal_zone81  thermal_zone9
> > > > cooling_device1   cooling_device17  cooling_device24  cooling_devic=
e31
> > > >  thermal_zone1    thermal_zone17  thermal_zone24  thermal_zone31
> > > > thermal_zone39  thermal_zone46  thermal_zone53  thermal_zone60
> > > > thermal_zone68  thermal_zone75  thermal_zone82  tz-by-name
> > > > cooling_device10  cooling_device18  cooling_device25  cooling_devic=
e4
> > > >  thermal_zone10   thermal_zone18  thermal_zone25  thermal_zone32
> > > > thermal_zone4   thermal_zone47  thermal_zone54  thermal_zone61
> > > > thermal_zone69  thermal_zone76  thermal_zone83
> > > > cooling_device11  cooling_device19  cooling_device26  cooling_devic=
e5
> > > >  thermal_zone11   thermal_zone19  thermal_zone26  thermal_zone33
> > > > thermal_zone40  thermal_zone48  thermal_zone55  thermal_zone62
> > > > thermal_zone7   thermal_zone77  thermal_zone84
> > > > cooling_device12  cooling_device2   cooling_device27  cooling_devic=
e6
> > > >  thermal_zone12   thermal_zone2   thermal_zone27  thermal_zone34
> > > > thermal_zone41  thermal_zone49  thermal_zone56  thermal_zone63
> > > > thermal_zone70  thermal_zone78  thermal_zone85
> > > > cooling_device13  cooling_device20  cooling_device28  cooling_devic=
e7
> > > >  thermal_zone13   thermal_zone20  thermal_zone28  thermal_zone35
> > > > thermal_zone42  thermal_zone5   thermal_zone57  thermal_zone64
> > > > thermal_zone71  thermal_zone79  thermal_zone86
> > > > cooling_device14  cooling_device21  cooling_device29  cooling_devic=
e8
> > > >  thermal_zone14   thermal_zone21  thermal_zone29  thermal_zone36
> > > > thermal_zone43  thermal_zone50  thermal_zone58  thermal_zone65
> > > > thermal_zone72  thermal_zone8   thermal_zone87
> > > >
> > > >
> > > >> But what userspace code needs to do this, and for what?
> > > > In Android, thermal daemon and thermal HAL as well as some init.rc
> > > > script would use those thermal paths for managing and monitoring
> > > > thermal. The daemon/HAL could have logic pipled in, however Android=
's
> > > > init.rc script would be really tricky.
> > > > On a related note, we also create /dev/block/by-name links from use=
rspace.
> > > >
> > > > Thanks!
> > > > -Wei
> > > >>
> > > >> thanks,
> > > >>
> > > >> greg k-h
> > >
> > >
> > > --
> > >  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software f=
or ARM SoCs
> > >
> > > Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> > > <http://twitter.com/#!/linaroorg> Twitter |
> > > <http://www.linaro.org/linaro-blog/> Blog
> > >
