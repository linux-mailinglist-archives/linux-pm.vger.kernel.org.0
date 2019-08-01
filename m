Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 990E07DF25
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 17:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbfHAPbp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Aug 2019 11:31:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35987 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729049AbfHAPbp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Aug 2019 11:31:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so34274614pfl.3
        for <linux-pm@vger.kernel.org>; Thu, 01 Aug 2019 08:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:from:to:subject:user-agent:date;
        bh=P4+QkcP5SWfnPke/f4WzJjlFeJ5WbmTA3DCQpoIEOwo=;
        b=idub+EGEAbLZ4tR3sB6OGyyoDN4Dx3awXMt99vRAI6Vnr6fGz4v78jbzggQ/sTRIyj
         +1/kvEecNC+K6qLeXU+Yq9sjjIijHXv5jFkc817cZ96zXdImJ11+vBArzqkAgBz84UIo
         1a+cU/uZf4LZsTAFIlOoXUcGu+1C6rHccPRKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:from:to:subject
         :user-agent:date;
        bh=P4+QkcP5SWfnPke/f4WzJjlFeJ5WbmTA3DCQpoIEOwo=;
        b=Ena46NjAWCkBkZLZE7m1ZovmFq3RWc6Phxtk3jlnAborTCcQaW1PjO9WnmdHYGaqaO
         1g3GyHcQGdJbEEJ+3TNsKlqbqLW808cG3kzWAsH7CzotSEa0NQ+mBmz0g4/J/U26TOG1
         3pzT881SMjeAG1d/kpcMK/uPy9Cb2Y6/Hul06iLWqmf1hTodWTU/h2aZqlBqySdurXQQ
         P3OJvJAvKi04BNVllqxwHBUOGCWiml5C3pPpbSh8xn8mW5bjP1T+xLfvb3PS5K4zYY9j
         n7MbHN+Qv7+9GiiQy9iAotLXqkgCst9dKVmAvKb+d/VKzRNUYArSX4TKsJUDHDrpJDOJ
         EFqQ==
X-Gm-Message-State: APjAAAVxCmL4ObdQarqoOgghfttJBe4mxHpZCqyeQv9P8pQn31smEf5j
        iaVpaumy1f5Es1XvTpwdIAQXRA==
X-Google-Smtp-Source: APXvYqyKhNXanLEqc3S/0be5CT8tQHKUMlAHzimJSNFlmKiEaKcKDacCqnXnNDuNpJ/KcwniiOFELg==
X-Received: by 2002:a63:29c4:: with SMTP id p187mr68449509pgp.330.1564673504344;
        Thu, 01 Aug 2019 08:31:44 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id d15sm16313360pjc.8.2019.08.01.08.31.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 08:31:43 -0700 (PDT)
Message-ID: <5d4305df.1c69fb81.c4013.1950@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJZ5v0jkLXwqmXwyYtdZ9X2=W2KNKS4Ok_NrDew2yvvt1=4pgQ@mail.gmail.com>
References: <20190731215514.212215-1-trong@android.com> <32598586.Mjd66ZhNnG@kreacher> <CANA+-vDTDq__LnLBpM5u_VHHvpFA--K5Du63vPB7HfaKzBsPtg@mail.gmail.com> <6987393.M0uybTKmdI@kreacher> <CANA+-vAPpXF1=z1=OjOhr8HWQ=Qn39qtQ3+8bUeXNTuFFTxoJQ@mail.gmail.com> <CAJZ5v0go-qOTyQV4D2Sj_xQxT831PxJZP0uay67rG73Q3K2pHQ@mail.gmail.com> <5d42281c.1c69fb81.bcda1.71f5@mx.google.com> <5d423637.1c69fb81.62114.ca6f@mx.google.com> <CAJZ5v0jkLXwqmXwyYtdZ9X2=W2KNKS4Ok_NrDew2yvvt1=4pgQ@mail.gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Tri Vo <trong@android.com>,
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
From:   Stephen Boyd <swboyd@chromium.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6] PM / wakeup: show wakeup sources stats in sysfs
User-Agent: alot/0.8.1
Date:   Thu, 01 Aug 2019 08:31:42 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Rafael J. Wysocki (2019-08-01 01:09:22)
> On Thu, Aug 1, 2019 at 2:45 AM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Stephen Boyd (2019-07-31 16:45:31)
> > >
> > > This approach also nicely detects duplicate wakeup source names in the
> > > case that the string passed in to wakeup_source_register() is already
> > > used on the virtual bus.
> >
> > This was clearly untested! Here's a better one. This is what I see on my
> > device with this patch squashed in:
> >
> > localhost ~ # cat /sys/kernel/debug/wakeup_sources
> > name            active_count    event_count     wakeup_count    expire_=
count    active_since    total_time      max_time        last_change  preve=
nt_suspend_time
> > 1-1.2.4.1       0               0               0               0      =
         0               0               0               0   0
> > 1-1.1           0               0               0               0      =
         0               0               0               0   0
> > gpio-keys       0               0               0               0      =
         0               0               0               0   0
> > spi10.0         0               0               0               0      =
         0               0               0               0   0
> > a88000.spi:ec@0:keyboard-controller     0               0              =
 0               0               0               0           0
> >                 0               0
> > alarmtimer      0               0               0               0      =
         0               0               0               0   0
> > cros-ec-rtc.1.auto      0               0               0              =
 0               0               0               0           0
> >                 0
> > a8f8800.usb     0               0               0               0      =
         0               0               0               0   0
> > a6f8800.usb     0               0               0               0      =
         0               0               0               0   0
> > localhost ~ # ls -l /sys/class/wakeup/
> > total 0
> > lrwxrwxrwx. 1 root root 0 Jul 31 17:43 alarmtimer -> ../../devices/plat=
form/soc/ac0000.geniqup/a88000.spi/spi_master/spi10/spi10.0/cros-ec-dev.0.a=
uto/cros-ec-rtc.1.auto/rtc/rtc0/alarmtimer
>=20
> So why is this not "(...)rtc0/wakeup/alarmtimer" ?
>=20
> This particular bit looks kind of inconsistent.

I believe this is the code you're looking for in drivers/base/core.c

                /*
                 * If we have no parent, we live in "virtual".
                 * Class-devices with a non class-device as parent, live
                 * in a "glue" directory to prevent namespace collisions.
                 */
                if (parent =3D=3D NULL)
                        parent_kobj =3D virtual_device_parent(dev);
                else if (parent->class && !dev->class->ns_type)
                        return &parent->kobj;
                else
                        parent_kobj =3D &parent->kobj;


>=20
> I guess without your patch you'd see "(...)rtc0/wakeup/wakeup0" instead, =
right?

No, it would be rtc0/wakeup0. That's because rtc is a class, and rtc0 is
part of that class, so we don't try to make a glue directory named after
the class to avoid collisions (see class_dir_create_and_add()
implementation).

BTW, paths in /sys/devices aren't supposed to matter too much. In this
case, I'd expect to see userspace looking at the /sys/class/wakeup path
to follow the symlink to figure out what device triggered a wakeup. It
can look at the 'device' symlink inside the directory for the wakeup
device to figure out which one it is.

Final thought, might want to suppress the power directory from being
created for the wakeup class. It looks odd to have
/sys/class/wakeup/wakeup0/power when the presumably does nothing.
